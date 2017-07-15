Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34C82082F
	for <e@80x24.org>; Sat, 15 Jul 2017 19:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdGOTXQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 15:23:16 -0400
Received: from mout.web.de ([217.72.192.78]:58528 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdGOTXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 15:23:16 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNcIg-1dY7La0ZZK-007EMG; Sat, 15
 Jul 2017 21:22:52 +0200
Subject: [PATCH 2/1] bswap: convert get_be16, get_be32 and put_be32 to inline
 functions
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <56f1263c-a0b4-260b-7e23-881e21119041@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <06c5bc39-d2c4-3436-97a7-9faa7c0519ca@web.de>
Date:   Sat, 15 Jul 2017 21:22:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <56f1263c-a0b4-260b-7e23-881e21119041@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GbTzrGYGAc1P8IBcDT4Pv2iny7sn2FnJTf5WgH0semYdRmRmstr
 jIigesgNPMZsRLSAvvxLfViFtQ5FdcLNfLBGimuhXGQjPW6Cr2GY681QQl2RZ7SdEjvgzWB
 P6DJrGdDBwZOmlqEwltKeZoGBIvr0aS6QzU+K/faPh+yp16p4XOkZgdomLqgO93m0GswEUT
 ktUoCIZZG9QTO0anJ8N2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8E1lo/iTL/I=:NE0g7HdZEJBJLU1DbPOlc5
 gaRAwc0ajYMeleM4KeEAKxyoe1tBwfX4wBrHbIPt6xzwOkIq36MUNAINvDgDuoXqPRBr7u7RC
 yuTSr098KY9GvGgHgcBkVBjwtiYjYMQ8yM9pk1+vbaO601O8zMxnisbRuX2z5e08KYXXhoUjX
 fiXlFd4u62zkHHpy5zxs3gxAVZK4MXaKeqLNW9yRRidW7v86JD6+vIraplXYrxorQefByBT3/
 XoYMpHeHV7cqxOeE+jrt2nFHfTXHnk4eD5jUciB1aFQXn386MzWIsqnn6HVNGom4lcTxP21aH
 aerjTsQ5/4RS1cj2ofjvxaAXvPGcHDxgJevXPR4JBdldW5oWOrLJ8SRpDFQTTKVZtGJ58JRIK
 OrR1kWACMX7TH18HBpfdWEpCXXIjPuVskPY+fpj/HKqwxFFu4tEG2AzgYl4VHWYC8z9ji8o+i
 qUvHCO3hgU85ZIc3AjInIyQ574hDkxtMypHV59mAyPcPNfpAbu7whiM3KBhnlRo3WuqyoaPTK
 xMl62P/uyxdwHzPhty3kmKiaJcQnhg3B/Wit0Sm0hAoY57afjN+2KDX+3aH9J7JFtQ4ThHmNw
 txMoTd1/k4ZYsVwOGyHK0KPNpjphhONOyR3bIWnDqyLqxgq1aR4qDy07FGX0QRDtfcqA9Leuj
 YolmOuVdKzhG3nC3zRKNMQZHcO9UIuneNimTE/w47jg7c7IdJj5UB8vlPlK8nUfbLC9AekDX4
 zxNOPHLjd6vkmjNrGmoBbctjI6KQJzrTrvX5fHS4G1bLRhepNu65qbM4OkOzMPE8TWWxyXeTn
 TFMknDjzurqWQQlevDfJH/7gAuvE8Al5Kjl43XB2GNwYrgeN6k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the implementation and allow callers to use expressions with
side-effects by turning the macros get_be16, get_be32 and put_be32 into
inline functions.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
All these redundant casts started to bother me, so I tried to come up
with nice and clean inline functions.  Successfully?  You tell me.
They are longer, but less cluttered.  Would it punish -O0 builds?  Is
it all worth it?

 compat/bswap.h | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 4582c1107a..7d063e9e40 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -162,19 +162,29 @@ static inline uint64_t git_bswap64(uint64_t x)
 
 #else
 
-#define get_be16(p)	( \
-	(*((unsigned char *)(p) + 0) << 8) | \
-	(*((unsigned char *)(p) + 1) << 0) )
-#define get_be32(p)	( \
-	((uint32_t)*((unsigned char *)(p) + 0) << 24) | \
-	((uint32_t)*((unsigned char *)(p) + 1) << 16) | \
-	((uint32_t)*((unsigned char *)(p) + 2) <<  8) | \
-	((uint32_t)*((unsigned char *)(p) + 3) <<  0) )
-#define put_be32(p, v)	do { \
-	unsigned int __v = (v); \
-	*((unsigned char *)(p) + 0) = __v >> 24; \
-	*((unsigned char *)(p) + 1) = __v >> 16; \
-	*((unsigned char *)(p) + 2) = __v >>  8; \
-	*((unsigned char *)(p) + 3) = __v >>  0; } while (0)
+static inline uint16_t get_be16(const void *ptr)
+{
+	const unsigned char *p = ptr;
+	return	(uint16_t)p[0] << 8 |
+		(uint16_t)p[1] << 0;
+}
+
+static inline uint32_t get_be32(const void *ptr)
+{
+	const unsigned char *p = ptr;
+	return	(uint32_t)p[0] << 24 |
+		(uint32_t)p[1] << 16 |
+		(uint32_t)p[2] <<  8 |
+		(uint32_t)p[3] <<  0;
+}
+
+static inline void put_be32(void *ptr, uint32_t value)
+{
+	unsigned char *p = ptr;
+	p[0] = value >> 24;
+	p[1] = value >> 16;
+	p[2] = value >>  8;
+	p[3] = value >>  0;
+}
 
 #endif
-- 
2.13.3
