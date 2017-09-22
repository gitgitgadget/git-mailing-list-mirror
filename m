Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E045202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbdIVQgU (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:20 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752497AbdIVQgN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZfL63ji0sH6+f8gtfHLal5pGIKKrCanAuIrVfbDT25g=;
 b=dGWGjshCVJWStaFzsNrKFi7xGXPZUngBAhcWwuSASYpw3egJNcMgV5bT7mMevZ4NXHsZqhsEilQlnMg3L6XjcLZZXDhUZCNqBH1ylhIyv8u4KmSAHnpk9ePQ7dQwqQlQSN39WaGDZoSFQqtb2dRyLbE9ZRChaUHC78BjOUAfz2c=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:08 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 01/12] bswap: add 64 bit endianness helper get_be64
Date:   Fri, 22 Sep 2017 12:35:37 -0400
Message-Id: <20170922163548.11288-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-Office365-Filtering-Correlation-Id: d662b768-73d5-43cb-6f9f-08d501d80730
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:1Hj654tzhk1OE/dDYEEgTjoaoUE8h3sHZfhmGOOmRbq4zJ0P/rdO4ynDg9s58OEzlIVZUIPJs6KaN09bXiaIO3AbdSqEhDEe3xAAU4s/E/pojA8IifBEIBGIPOhfNHwFjzkvnAUX160nv0Bb9jCAl9AddoXzi3rtnMXWGy0ORV4hjptvu22mRb1CSFlmgDpzUqKECYRZYBKUtyDINJYh3PxbUkqpTAYnN7V1bK1Dtt5Mp3S56fnD8nem00VQgg/G;25:YEZu4BTasOdzSInloTY0+h62NO1HsexfYWBmInav3Kh8vUkvjovl0X3j5XfRdjfYxk025/+5a7lTyX2v3Dr2grRlxnqRTmIR+9R8i+EeLYqNZkFInu5QXi+L7KI+1pxJlDNzPM5w6B1cA7yDfIAQdlgvdcyIeL1stozi6IbHcQ1Y3BYmtvoJwWfBZ3cK94AXsRaSkfj2S83TPO0OuiwA+auf5LeJF3YnRQrZwqYYDwwZRcEaW21n7gMyIu/63qTaZkt5ERgGTP7QlRbkmE6/hMnkz1W/88sKn1hROl2/pWmRxxH9ntHIuPYGhA158OgPoLW8vzz+7TfBTaTrDaL+kA==;31:4CnhKuEnrVHRpXJW2j7eokfMBkTjmjjIuOYOFK0A9KxxiRI0ZPMfFGNN0Qi8+d3IOBRntpe7+HtQmwjo7iT512QGaTFBdoylZBPnUszSb8q4DTIejbPVWFAvGpAbsvzUittWu4n6l/IfgXa3asnu7oZ081MSuB7/VlVMi1tjStLC5yu7cyV4yzKL7BvFM0o/jos/mfkuc53B5dtlxajjGkwfJ0Go2Snr22HkgKRAyow=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:wLbRnyX0w0+aFcyVr8IVVUAtDhrmOvBUkhf1Rntr0eebRtlB47L93eO8hh5AaU1w40TCATaYQbcI2CfFTTxUoZxV8ceBwFLBVkVqa/2d9dPwsaiQwM6NV5pKcNPzyiDWKaKc1S+ataWonBpc7sp8POigshRvL0gGA9HbQlH8wdMGPIq5yFQOQKFqaQmdb5ndH7CR43JW0f/lRdA7NN4D0f1t6FV1EBbH8u0n9Qss7IYY0D451efqtpHt50y/X2g16W4eYuZ5fUIVlYHnsOfNWQexeDtCtxo9GPTuCIm68/YnbmIeW941E3Wa2ZCe9DOCCS+MST/2KVKuOaNTu5T98+EvIc0TM0oWGClF92DLa//E+cfSbJnoG23ffZCdVTUl/urk3io6B66xZrWKXLxt92lK4i8Bt4rbJFlf1kqmJ7lYfZPcOTkPWzjuEnnIw49Ng3S7ZgOa9BoTJM0cFAdEwo8xM5HXkQ22faCEbJACfMVPyifT0lMBj+XmhCpG02tm;4:RlCKeppTSG7mSRL9gEE7GS6RXzodlDI2l9N4o2R8HqFq9/di/kkNKMO6N/I3D4UQRtc6dzX5UeOm8Q49+AwCr3MdtKfNtyFqE9QebZOeDt4h8B4wni3tEHVOcME9y8G9G9O8dudhSV0fSeuYUpwjCC+DgzlGCcEL+xO4TEcFZaWKHGMo9+PzGgN3B3hqIeW+B1y6a5w1fck5Y6fSt5lMKA5Lc/oknaqIRmnZkwj4J52ukB51EGKzUQ9f1WAs/uCQBcvb75L2Xup6fsJA4jgen0TgpjPDISWcUcV3C9a+jk0=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB04667B8747327A51F41D19F4F4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(68736007)(76176999)(50226002)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:mLySPkB4mWZZn8weq20sn9lT68WTE74Xd3tPT/aM/?=
 =?us-ascii?Q?Vyxs5Fnt1z4ZRxRpWKvziugQFUbdi++OJ8grymhRDwqjgMl65SMb/6bc94R+?=
 =?us-ascii?Q?173XJlvQ15E7Ot13wEoOoHI7SXhVDh8Q5UNlk19BeFieLMU4di9W3I0m1tH2?=
 =?us-ascii?Q?FB667T1++197YdKEZ9cSNbkar1ykngpy10Ke2tw+04HDknvoKC94xmofUsAB?=
 =?us-ascii?Q?Kg8wYkjCO9UEzU5MuNlQkdCjSxk1HyxYo61mqrLHFGtXWQBoOKdlYzuLP8n4?=
 =?us-ascii?Q?Zkd5eMJX4Uf9RniMZ9ynGhdU2yJrp0HUtpjN/IQPQgUES/Nj7LzePALveDSk?=
 =?us-ascii?Q?A4QNXSotyQJi0pV+h53XZQbCce9ZWPnfTio3fepLUJcO+u+uEDwFPpruXGh/?=
 =?us-ascii?Q?A5Jl+o9RgFtJ2UdH4bs/xBOrlqZMpQ/RwWJcSfZMPIVCX+g+mauq5Ux/X8xC?=
 =?us-ascii?Q?r8dymcvHJ7I3lNBeGCUCHnE+zf1uCWXtg4tNJCBbfmn9Kdi1K0f+BtYa7SmI?=
 =?us-ascii?Q?RzBJAVbZrICpJT18/v8Ew07uK3VfUfFUYHgkxSulWPoKh4lNpMW5dv/YKjVw?=
 =?us-ascii?Q?aWr9Y15d8d2AjZkDy7kht2UcusI4itOlxnTtY0qMxWFV+4pv/NU9vNU38w/i?=
 =?us-ascii?Q?1HB6bOAzR2zCUvBBmPXl63H+z22oJOtqAejibMzLIs9dEdLIqKLx8YNHkmG+?=
 =?us-ascii?Q?I18t6iBgfUd9Qdun6MqiTEhnnZ3DXjDPog7NJQh/eICbIa1BZgywJmq4gkOE?=
 =?us-ascii?Q?HjbUR1F4/Y5xm0IPropAi4Wnt26+CcZ8S3D4wp7WG5IZWkZjqWl3tR3YGi3G?=
 =?us-ascii?Q?l4Jun7XS4DGMp9rr3PtNIvGN8KA1QTBXw9Keva6+Pyuh+IDLObmr7AQy3Jk2?=
 =?us-ascii?Q?aARop/tBXNbOykyqrliTMDHJXQZQREP8f4Ov0A/nduoRAxQgpXVQgRcoUyib?=
 =?us-ascii?Q?ittCqJKjdrp4rHMo5Ja25vOt0eRSLxeq7Rlddm9v+k0lWG6WBCXWX3G+A6X/?=
 =?us-ascii?Q?foylbQ3W1YhVkkp1nDgLQqlz8pvrN0TKgtsmLtXrWGsz8hTDd47pfk2ADjqJ?=
 =?us-ascii?Q?7wOw8wXyqyLVZxUmFDoXOG0qaEBoObufHF9xsS8UpRO1xu9m9TgQ6COWdAFU?=
 =?us-ascii?Q?fqlZyflBNILvx6hW4KIxKF79L9wOGUqRMFvVt2NwiXCl4VkoXhOLNxWCcFzf?=
 =?us-ascii?Q?FPLJoqLlBvvV8Pwhe+6bJZTUwk/gS+XVHSWKVD/XspmMgyMcKmzkl6NHtX2k?=
 =?us-ascii?Q?f13eCFJvhmeJXSxWDn8hvjdLHXuYPgwiy21t4iAO/jDeRU14mYQbrJdeXXWQ?=
 =?us-ascii?Q?zaSeFSw8pPPU2P7bGEAOkAeo0odHUU/0PX68mbeq6irWObnFssFot8sJs8Km?=
 =?us-ascii?Q?zFdnNLMoOTMc806FloZHdA6lkIy437TNEtrXhcnz5LOtWUfY7z5EJ8UqrLIA?=
 =?us-ascii?Q?E5NJlR6qu46/BlibnMieWwXFhS1Xxg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:weoq2CqGbeSjXGNSzMUWYrq7Np/0A52CGX2lub22xOZ2/Pj9OfVY//arpda4v4R1YaHtlY7qimJqThjPzi1kE/lr7JlcLDO6zdtrBVpZ2xis5TBdYA6MM95Nk3eaD7Fs9rcfQlOJ69Mu0MmIlpNekgcdVln/pNbC3dn0JwUAa4U0h0gTgUTwX7tWyxhlWa+3Bfxolnsx+0scfMNTqAeT6eE0oMlo5znrtEWNHIDyDljFy6+bQRQqfMufRNfUrJF0d8B9YDdCW8xT2iPGgRAdlJasjF/hcNG9xo5ZqXi5BH1iN3BkaJgjZHK7dK7a4AuDXeLvd0VUxM3Vi1Pl3R4Gxg==;5:7Kt3Qt/fA1iJogSZZT0lxJ45tov9pC0NZ5gKr8+e8K/tawp9Xvaofq1JXwJbEylGktT49QHhyDhTzrOt11pMwMcqtTbVQmuhayMBy41zC+tdeZr3PfS21VA9AisKhN65WHgm3Ly74Dcb+VedNbK6qw==;24:JTuJHdWlyYjXRSj1RLCzLsA6bWgWiJN+ydE2zA++EfiCnst3aV/28A6OJjaprpSmXX7rDLT7gtMefzm6FQjqfNQdrWVuWNVH/8frcKPRHqU=;7:WkRHrXusBi8/Zkz76lqLYSejcW+IWAbWiM8wiORDLdchiI2h5dwX096fEQMcRYA1BIk4Bfi4Bk15b+rANA/EJViESVSKfb5A3Mid7Ew4PHpvQT01kTrug+lDuOdh+iIMTHCexSqk2TFAY2VCxW/fk7gynr67gRJy5wgIr8hHTSbUJ9VvNMoUWTp/ZAAy6l+KsDu9Zce8iiaCm/CFhV9UU69xzLgrwTgh2rnXc24PrUY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:08.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
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
2.14.1.549.g6ff7ed0467

