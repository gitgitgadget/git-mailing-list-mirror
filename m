Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7011A2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbdIST2b (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:31 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:27081
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750919AbdIST23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nNgdhngHqYfqGzjbVOi15gP5wIhJfRjZpCiSGbdDn8w=;
 b=Y80vFBI4Q85n4UG7lh852yNPXmNu77OQY8s3BUIsvRPIQ/pZOMaB1CJ85c49bR+O3eegugJWE+m9vfyDAXD0gwpqpAYkwIQ037//EH7wWnRxbXwjuaNbc+wu6CAXdUFMxULLgtTMy+5K/fWpSAeroE03nJLZSRiHkI1aGt0aCCw=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:24 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 01/12] bswap: add 64 bit endianness helper get_be64
Date:   Tue, 19 Sep 2017 15:27:33 -0400
Message-Id: <20170919192744.19224-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f724dd-dbb8-4844-e554-08d4ff949951
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:O6FGQYfVZKNcvO5/pLoOHKBRF23xVjRMO9y+jIc4IDkqjRc1RGbKG6gchbxVJt8ANurj4R9C7zTVa3WbOqQsXDeX04cTLRhFhYOoXnneZI8Az/tvsBsriVbXOGRfI6/iXQKrshcxiaqKcJmroU323TyVsBOShkrKyFsLGauPkToSsAEbr8cmBoVVYqAK+WgoOHWGZdFNCHlt9GQR79zkpioUZ4K5aIOM2QWPTMMwEwXdoxmEqez8chQLwX34Jn1Y;25:ODLeGj1LpTsR0vd509FbapdnddKi+r8JB1Yy1DyTWg4RVPfmLlcejupYQ4UUzwpKOOt85v6gYlDCdYuWubC1Nha8TeJDNl13E7iT/83VCWaNEs982gR3fUIyi+fBdtrlPxMygLGn8pPKKGLFntrbT9vp4NxYV4a0lhe7lgG6i68zsvHOR4Q2XN+ILSxMzHnvffp3ar1jA09H0ShD5Q0ie620qfEjJEKQHNFTl1fF1+eQWlJBk332mi2fzM4B8R8HrXA+zCtwOGJq3/HRn7x0k9EuzYp3fAKext3fAe29kqxCDO25PcLtpJ6urk9qdgZj/Ep8hF4fhtvr70aQs/t/BA==;31:O1ADfq5CygZBF078WFH4ntMsVQfLlVILLsqoai4RC8HZAkKWDjOYk2tZCrq5g2SPxcyUozb4fDTrcT+VklAElDow6tLmkilA5d8cUsby6NDaOOZd2Tdfau2elOMPW/eGAchZCRTfjZShGxJIhCdiQPYyWHM8Y0eF9H1UUmbLphit+o8kMhoMJPI5Ay0GKi6Yipddjk0CgEMbw+qIwdqZehqJHa8WrsQVqBUBnGH2YdE=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:LQDLhzhfuIo8lWPxdbWXNp8PSAJE9rQl+2sOCV8jexIfYFVwQdUCar9umi0TLEYYNfuo3Y+vELrAb4qcvd0jzhX+t2hdBiLbwggGPpEifWaVVvh+Lcg221YjLgm6L60zlJLTPpt0khLmjZzNoe0qDrV3cKJ0q4pmGdqQiYcSHHUsSoyQVobyl61II7rOCa2cDXDbzCHqexhBtmmtsPbWSBJDwvVpgaLn3vw+Zs5qQco62RdDOkvFg1m/cS5zJXh5ikdDgbgJlE1d8lWVfyRfJtaWp2/t4lz1O49gIb2MsBSIpzNnzMh9IlXfKgqROvvs5MUN9A0m9Xmnx2l9XOCdH4ZuDPWcKoQV2AJLfcItQcWCAC/uukZCqPpGSJGv0HI29t8QJEo6kYyZN+xUOe/Cg/ckpcOrbiCXGbJMT+c7/2PKPM8NB5TReUOOJbqIneU8gLel3/etYXpSsmYNq8inKzAkGuKV6zuAZtA/wIoDBpVGvvOKTUxWUeX6GST5wppy;4:jUEQgC+suy15zX/UGmuOrmBed3/2PUc5VnHb1UTriNImsxwehGwbUaSn33PdK0zQKT9oSgmWKONUTQ3By0DCu9B/HpCZtCgULJjFVDAT/NzHJSBgtNc6L6xdpx4lscYJq8fHMFHSRJevjgdo2gEqmEpHOwxyOB/z2UxlaLxPkikJehq4COrP5oRgsLu3aHs1wcunaT3khvTcsWE27HCQIbv4y+okW1cncxo89coMevCSjUYCeBSCCnNlCYEhFVjdU14nMr3sdHz535ZCZlgIcaMscC/sgBJDtaRgUzTm11g=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471D4CBFE7D3AD1FBED7C5AF4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(6666003)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:UG+g2PDwuE6v2KPcOizMi/fMXbouAjDX0rFH7Y115?=
 =?us-ascii?Q?441pHCvfDheEjzeTRkUF/AkTwn7ieOlTlK/WwKh/IPBdXEuNIw4miA+2Uy3q?=
 =?us-ascii?Q?qfvF2/hocRDXDnPCcm9Idlu2K6PI81noxC/DLDLuGqRkdjuSqzAoj/206qO5?=
 =?us-ascii?Q?tBFGqpf2/MYbMF9tqahKQq9+V7VG7mulspbQhia2T3zeSlEGa+mfq26ZiZaR?=
 =?us-ascii?Q?4reha+zpy3aAAog7ViacfLdD9k27ZYAzqFdwW5bRxiolMcoxDGpF0xiyZPxI?=
 =?us-ascii?Q?x8kbQcWly3GpvRqxKd6OIPd8Yip+CwWqZ8xbi5mR/OMj4XZBzqpcQBxUzpLe?=
 =?us-ascii?Q?4XmQiQ+scACGEkxlowbV0h8bYqYHXuCkjXGqtcLnhboaTKojH01NTvJQLDPq?=
 =?us-ascii?Q?LDfvEmlzBVl15zA/v1WQ9IUBNxBoK/PQLNSxW4Fak8rxxovf79M3QbBQaHX8?=
 =?us-ascii?Q?9kqDcyrm8qSZnoEbwCp2R65XcFDlhxYnrhE2610cr9Ou1LDT/dpkrn5n/Vfs?=
 =?us-ascii?Q?2dDfwoPm4w2ufbASpTxY8QGpO5/P3P0LNTon8gTHWwV4XoFG/ycO6PhHcy/u?=
 =?us-ascii?Q?gLP9e62OMVatPcDI251sT0mVMByhkNhTUxck86Bj5qCyoBKt3TSkEL1Mh0be?=
 =?us-ascii?Q?qqdk0Qe5F2g2kKSwlBekGCTCIQkULivh+GjNoz4TBp2BDK4ioatYLvvMZmzO?=
 =?us-ascii?Q?98/wOt3zu5SFKuFDXMmD+iUQtqPBBbbadkRsb/foQykZISZ3gF/hnlpW6qX3?=
 =?us-ascii?Q?LB/lP9eVg9s012HsRsUpAaXWZMu5cIrR3PhYN1NVFx4pEIhYjzhWUAK+VxWM?=
 =?us-ascii?Q?pzJkztfVoB4Ok11ndM4esCSCreWA3cu5uKlCc7Qw+lrqg94U95p0D4n/wEr/?=
 =?us-ascii?Q?Ez+JAY/5X32HEkGQ7Czo0vrIuBP3afECwP3dMn912VlHHQY5VBWTiXjHrlbz?=
 =?us-ascii?Q?/OgB1ZJyp3w/8g9Jv2XYTEB0SsAwfwTCEaLetta4wDFtiUbUY6TqIB2BkG99?=
 =?us-ascii?Q?q7+hNKwVDeHmMY/E6K7AdO1GtaeetQKrEL9LoXa8ZXBua4q8omzxD+TSaznv?=
 =?us-ascii?Q?ezsPbO2vGzjeVXZIqynruz/3GoSvtwA3FljPjnbvqBYlLYIUo79zGY4hu31h?=
 =?us-ascii?Q?pJpB/npcCoxB+VKCctHMr/s6iK8cdOSahI35UPtDIW7jpo22ogGnryf67tPe?=
 =?us-ascii?Q?B/5LHPicnqYQ9n0gse75gIKsMJ0QRW5b1oUg/womdJZrViA2HjaqfEqq5gO2?=
 =?us-ascii?Q?PoMAIeaf5FADDm0FlZqtLQ8URUW7cKSVe6MvKWeejRQMitZ0A1YBIJG2U+Dl?=
 =?us-ascii?Q?3UyL+Cf80uRB78b0qwtEYva5omhg8BNWzKpAPmFZHaddnpL4kixBuM3/BxIR?=
 =?us-ascii?Q?GnmU/S7f15L7TfC3fQN0RlH3U3IK2QK7bSOl6n4qTq7MfZu/4Zz5RJWjUeEw?=
 =?us-ascii?Q?wurZ8D2SpITa9mo10yoi20rTwVXoWg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:Yd8L0TdCvtyoLeQAGsoysooFN0eIaF0Shww/9etHolNJjXJI6ihL+twR8GVGcuAUoNNOALJt8bdxt2bhiQq0Ve/eczaoUqVDJCMdTlsfMVCBCUFWr9T+CjQyqAoo4cDoU0l3hgco0Wt6jkPZsa5ZfvOznmZwCxZndFmzfaoEOOr89/NRyYGnmnPGs8xwCm1fliMerX1r7I1zixifUpdYnTBUQYzkHm/iwgLd0ryJP7cFCpNsrZ0Pl5gmIXDWwdDJ3ILXtxTNHFS10xXorARZyqZNPcpD6VRdr5SogJVjT1ydRF/TGX4fxMF7XWElAX+tY/Rm+ks4JGK9LSvq1hbALw==;5:fNxHqGrSL3hRLp/0noeCHCccQTyC6V9cqW9C11Q4ECZoqoSrPZVEsnq3NWX943hHgiOZWq7b4Jd8iTz+YdrrZ2ARz/7samjGb5OKfyrqD7XfYdj3piEuaCHa+tFF1OdrKbboJjBRnuuyU/IHmrX7gw==;24:ZjmRfKBI+OS1uC2tUgJn0Y38+Ym2JXWKus2rWp6N9VAazgsnn3+jRexE3Of4zzuFZ7sBHnb2wYbzg6PfJgF17DE8oZ+WlswORC3Db5dZHoE=;7:rMom8iyT3jIv+Uk4wVRAfwYzQB0AFvlC++mUcRhFk5gHQEikxZz4O/N0Lz9SqmTtUknLdceELbcXseEkzds2jOLXc0+pmB57nNjeQSiZ4EIELFn9b5RUNCqxX/7fP/DDTlpUHv7vlE/QgcjSQl8p7k1XZPf4Voi+bIeVF6R1aA2W81cOYsxpwsAb9MTsAwne6WJVgTQyBkBg659IFQQoP+hhtnOn2qcI4KF5RtPJqv0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:24.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
2.14.1.windows.1

