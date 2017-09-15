Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD63220281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbdIOTVV (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:21 -0400
Received: from mail-sn1nam01on0136.outbound.protection.outlook.com ([104.47.32.136]:57891
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751662AbdIOTVT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FpLGemMbWaMPGVlrhPhYeztoQxq1qb+l7XIFfhJtYhc=;
 b=AWXL2QoW9DbjJf12dfPdJgGjTh/V/Ya8LsNnlpV1m80SSHQWjVa/va93zYRPWqViyV96QTY8j+IL7n1ZCPTs5TjDiXKriQdaa92VdDMUeRmODC7+jaZRCJGJlHRsYO4dthBKANfHMfdIH04jmeVxk3beIX7i43Bb8OHiSnLG3/E=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:15 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 01/12] bswap: add 64 bit endianness helper get_be64
Date:   Fri, 15 Sep 2017 15:20:32 -0400
Message-Id: <20170915192043.4516-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6649d2f2-79fe-478a-ebe5-08d4fc6ef035
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:VHL5dv50vCPxQlpJtZkHfuMQxx5KeuwuFH1XysT9Lp0VanrroDD6dxJwcVjmdabFO44XsxRXnxtkFCKgSaQg7TNSVIfpqdH0mU4JHXsy6zoFlTl1ezBmaJ0vn5RSS2oI1LzUTGVIJ7RxsjCyChm8+uwH9ODBw9i6hf925IY4LRpcNP0GQa4h4ad3ZqtvF6VT3YFNLI/5OG0RBrkqvY6Y30rskuRkGfKoCAISBraxICLT4ogv7Tw8V2jFEoFcrA3Y;25:5D9NrYCbOeabg49uhSG0EEA2sLyTzDXcDgmWaGHobZH4Oh8WHOHpBtaD4BQPDb4vJzzybNtNXBWFiNt/gQdHywlMWF140w0MQrA/IxRbTBTbXvQD1cqzSlKAoPudy5HramJVmTEMl1Z8y/jwKPK8jzi0XPAVEadEDW9TmsJIryIRHuV2hpW7ZF/GtK4iCjCfSynZ2vAe0Q1FCywF6Y60eBp6HAG0Ubaz/uka9TGjOfQxTi1goV1p80+1AyZq80KuX7IxwsfAWRxAGHar/xces/vM1u6bvRbOYTSUqDeOY5DOh/JvreY1fcwDruAiJGXIEc3zsRjzkp5fbqnSfk91rQ==;31:7R34nnP7Rsjw0QbrPmUQUQDxmvKlN+YcHE2KeM7JSdckVrdpDzYj3xVyGa6J/DRO/I4zqd4s2obA0370xFmWChns6GH4Rm7A+VwysLNgaPIlOHiViVIwsnijx2dMhakTdYc9avSKIcvCQFwdy/2BeFGwfIFD99J7uuh3IHEPfxaxXJdZ1hUQfPc9r1zO4jhCrIzgJNvTkPfwwy6lxXhn3ESAtVCehnw7bED03SYOth0=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:nzyC5OCC/G7kI734Mw4VlABs5pyk3YzoV9CCWmvb2UyiQX6Ghng8WD9znwnaCTQfldnuJA3lm4yWG++u4j9JEYQxVFjzO6rsr9S1+f+2BXxSKyj5TSWnr9Fv/u941lOJIzsQWL6ERqjo6vmgRE0I1cSAymFkwSeCYMfvJ2mdsvidMeAoRSfesCq3BgYrlNBmfYzrfCliJbmGn04qQtlBC3Q1zlOG9fkRJm+t6Q2SnlDxoBXZTkRigClA2U449/zF0BJ0ZVtUl5cBaTi3w9+6WEwnjTQ9/OG135bOZm3tIlTdlgJe6dTTgKrD2+z1USQp1tOz+A5Y78SSzrysFHlDcSOImrOp5SCbPeep+b92PuXmAnTZsltwA7kVxa3P5eUd5UTVIw0TA9r2LkD/uMboSMG1pAQmg1dhanu1NkF4IxFbshMpE2vNQksjRXVnSNdjwGh4ejvtTKH7e0oD8OFfTHJ63EWAlk5wfveAe4xcquUt8lxm0txaDadhbZ9X6QtM;4:A1KFgsbBuyuIo5tvgPqD9OGgn8NcCjNlhtq6k3poNko8Hm/S41IKrmr1mmQK0i36wrRWfEactlvG3c77HXsPVXg2cJhOSy/TVfC5i6Ax2ZRgCqJ2FfJURzhOoqAzHjTTuKj+mABUJFgOgXNFj3XnVJuCrOUzSCjy1evghI7kxz1s5EohcApQBsSnGZvh4gl5u6Q73ZAOF9ig70pJSNUlVRMTVoHuYWnIxzwjo1T/CHya9DMBC04AXdQJiLaiUXLqC5hJPuAUHB5nxNRv/01olRN2lMUXGLpn3Dw+oNiuCoI=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB046917272BA2CEAA7E12B6EFF46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:T5cOM5Il1ektmqbD9NF3Sr4jJcjEx23wrHEVEqYzp?=
 =?us-ascii?Q?MNyfAYmPpBTJG88r81XYTWtkdebJ1CKrw2FeyEs7KAlJUYY5X0+6vCt/r1xW?=
 =?us-ascii?Q?jyxHbdJ+dsTRyPQi6bpuE8qPWrEJkyIznq7SBheCYvEE6q8dH1mMqu37kCfe?=
 =?us-ascii?Q?oYXzsPiyXzTEjjkO0ljOSR7mpsDABjQHNAMMNyo9bejyEEcQ9T8EZ7flHFsP?=
 =?us-ascii?Q?MgZSpiDmNs5nlpuAtAmYv9WiQH9N80or1ci1enTWHcIWTXhiLHRxUc4EkTn2?=
 =?us-ascii?Q?zpzS36TffMn4NnWUrUtIOtxIPwxqG0MJ5yJoq2VP38WO0SXacjJDBj2YQiZD?=
 =?us-ascii?Q?+rFRsggG1DN93Fc1jlEnByr5by4Rlbhjh0u51d4gX2ZPhdnqF/dR6e2Ioyta?=
 =?us-ascii?Q?+H4xgDKsRks/m0BnHhnZktB/r5o+h8gQzORetp+KiTDAMLJ58hhJOoVdSknr?=
 =?us-ascii?Q?AznsXk9xEj04yENsKy86ZDWs7lSDzwNSizDdJPxJJunI0PZ5M7zZhwsW+KDJ?=
 =?us-ascii?Q?3nBFqVYjpOfC4CFf/k2OJaJYXZgxmbUvFdbS0OwltV4g7b6gCPpw319sBngG?=
 =?us-ascii?Q?UldqrvVgPUrE5wEgAuMnCfIuXRQHGUXe21WWKne7xl6c12p1yclROuPo4Lm8?=
 =?us-ascii?Q?REBN5aGq41Fulb4sZ9BHXmHwFF5k2zGynniuRIsZ/E7YMcc4P3jIXYM3ZU1Q?=
 =?us-ascii?Q?hgBAEkhjbaO3IR/7McXRGnKE66eNMypRqS9GfTKe7NcoHbAA06bm0P11/7Ed?=
 =?us-ascii?Q?BVgBIo7jw94Wo/iIMHS1nnStCDEgzebxtzwXipiyKaCE59yZi1wKhYLKA/yC?=
 =?us-ascii?Q?KYFyMgroFu35RLRVLkzr4xgVsxvUiEBnhTawRbRA4WoHpzu5ygqiRy/2oFVl?=
 =?us-ascii?Q?3kZz9nuXr8Woc7mTayOlv7JpUpEnPsRVkhpHwFTAF/72atamGQ8A/9pV+Qqg?=
 =?us-ascii?Q?u7zrfJp6gbJLZeU7IQ14mu/LASDcKiluXBHS9A1FrkemSVw7yl0m4VclxdeT?=
 =?us-ascii?Q?p2zv68X1lbOQzU9f92/9yR3wFHedc96N6L8175IJ3yyLI8kMb/Nf4okNO4zD?=
 =?us-ascii?Q?NbaGiVQLnURpqpTFEhuPyPg1So6QA1lV8PWI2Zq9QNhDOc74CZ98QWOmEGgl?=
 =?us-ascii?Q?fuTbtUarApIh4Al0ZuO3065m6l5pCAoVNPqhsz+XO1znjQd/pzWUw/WAL7Lx?=
 =?us-ascii?Q?PqCoPf3HVhzol6+yFr2KFO+FG7mvQg3sTgtp9yqh3CXFMVLADxWM+UjTOcCl?=
 =?us-ascii?Q?tp0tpa+de4hAvXB/3cZPj5N07VqyXtLXVE3xloNitGnDMNCrLUNYbQGKZixe?=
 =?us-ascii?Q?ffa3Ep+RckL1AdLyYmjDAxDKnAkP2+FfVwXlaptOA7PE2aPqywKu70OzokAk?=
 =?us-ascii?Q?djEaHVpAXPmoNLWQA6nPQrawL9cYTlInYHkYush7VdpXPSVH9qw8OooD96x/?=
 =?us-ascii?Q?dERL8G8r1iX4RCABeQtlY3B+kq/PuCPDNrqwMTK1D6kNA2pXTWE?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:PwXuYbcdpgYLynl69/Lb8Qdn+Jye8kMBqpSxVhDZzFEq4TRnd8czld5mXf8Z/xZDo9OAlp8eLFiDQfheYWPhJT/11/nGl61At+mUfi6fT6lWCIZxFWJu0Lp5DsQ7UJbH8Ltp3vPfn11sVOCo1XYkDp4loHrJmvl7OxAdmMldZI5ex63ZdJ4ygFREVItOWHQ5IwIucznDBIiEfwv3EA9m6u/7cEu4g4zp9RaQsdZKiHase///Br0SE6bShBsBP2FUPVIdWbSxM1wiRom5Oxi48Fuduacj9lfj2qQDEnALMdG9g3A0EnHfBHYPdhkpZtbWoD1tYz9IH6qLFxV2dxr3Dg==;5:OITVe1CuXe7g9eGmX81Cq5sOhJWWdeTceQJI/BM9tKiapI3SLaBWav+4ukOARnOBbHSMT21uA0xTABhpwblmwQvez7nBBFzDWaAlXh2nmCg9yh7Y/ArOqkB10BPuYitmKoSj9ZIB8rxWgfkZnBCbkw==;24:aR0Ev5ThqeVasrnRNWXdsCvOYh6zNjTN/VHuZY7HJ6kbvDZmpGSrk1k1jCqn2Ld9Ylm14x7KY89KC811eEw46t3CDgsETpbPEH8qvcVN9Cw=;7:lBKg8uFX18UHel3fY0sNqzrH/MdjmKUXdFRHpBAHshDo4WCcs0EckFwlH07Z6GskkO8n8oS2h5JTNoFgIAn9+Lp7RfNmI4XMUy1KKnNCNTv0jfKq+fGQdJjOp7DEKsU8kGI6zFiKZA37Go0QjcXRRivm7sputXRGMKz8J6bb14twKUY2vdkVUJXmQpUfH/NbGwAS4OvlRxS3Nj/7PFtXwLcYpEY29hVj0T6U/MDn7ms=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:15.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new get_be64 macro to enable 64 bit endian conversions on memory
that may or may not be aligned.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 compat/bswap.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index 7d063e9e40..6b22c46214 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -158,7 +158,9 @@ static inline uint64_t git_bswap64(uint64_t x)
 
 #define get_be16(p)	ntohs(*(unsigned short *)(p))
 #define get_be32(p)	ntohl(*(unsigned int *)(p))
+#define get_be64(p)	ntohll(*(uint64_t *)(p))
 #define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
+#define put_be64(p, v)	do { *(uint64_t *)(p) = htonll(v); } while (0)
 
 #else
 
@@ -178,6 +180,13 @@ static inline uint32_t get_be32(const void *ptr)
 		(uint32_t)p[3] <<  0;
 }
 
+static inline uint64_t get_be64(const void *ptr)
+{
+	const unsigned char *p = ptr;
+	return	(uint64_t)get_be32(p[0]) << 32 |
+		(uint64_t)get_be32(p[4]) <<  0;
+}
+
 static inline void put_be32(void *ptr, uint32_t value)
 {
 	unsigned char *p = ptr;
@@ -187,4 +196,17 @@ static inline void put_be32(void *ptr, uint32_t value)
 	p[3] = value >>  0;
 }
 
+static inline void put_be64(void *ptr, uint64_t value)
+{
+	unsigned char *p = ptr;
+	p[0] = value >> 56;
+	p[1] = value >> 48;
+	p[2] = value >> 40;
+	p[3] = value >> 32;
+	p[4] = value >> 24;
+	p[5] = value >> 16;
+	p[6] = value >>  8;
+	p[7] = value >>  0;
+}
+
 #endif
-- 
2.14.1.548.ge54b1befee.dirty

