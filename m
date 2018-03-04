Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147831F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbeCDUPt (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:15:49 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:20096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751848AbeCDUPp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4VAV7Z6N7IlcIlvLG/uBUZB50/kxO4fYkSa44DKk5EM=;
 b=W2SamLuWIet4Cd2NC5eNZZAWFB5cl/l4P89DIlMoYVe+9wHY8nof++4XqcUMSyoGap90XsvQ5ckqH9iQyzd5694pPwzmWPpyqCfnP9pHXbgHWrjMc6s56AchadPWsIQ+CCB7sTdu0+UZvrOY0y3h/0TALvhQKC899Yi3pLaS+Lg=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:14:45 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 3/8] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Sun,  4 Mar 2018 21:14:13 +0100
Message-Id: <20180304201418.60958-4-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304201418.60958-1-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:23:8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 982bb316-0c21-4cd7-dcac-08d5820c947f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:dNaI8l4Nu9MWp20xWnLkDvBueIKWH8Yxh6hpu3TtrTzv5U/d+VWj9JYn9+RqkjSGIc6VIPHFlB54r4+1JgdAlyBt7dHDZ2nuMvcyi5CxWQiBsdKV7JUdledtpm8TCai/qVN+hW8nIwY4fabjl3o3uF6kSi5/BMlQ7sYqcsEPyXv7wFvQHeY/x05xVPA3JVVmryWdQc26DdQyohXmCgYk0nymnlI8Hox9jRsuTlwuXxrw/nQRiOmaHf6eAod7tH8F;25:g49QHsjA2gxJKT7XQ+DcHWgpQW+vb36WBYO4XDcyB3mKIuyxWEs1bxbcauHdSG4TaXnmS8bxptn/alUzw46NompalxuQ1vRXjpe48Nwg9ZpKJcs82lUImtkRQmPRT+JA6yynXWnHJv3Z/AfOrCukOqAOejEOGxslsXyKMt549e2mq2BqcDzW9Hlv6kVckya2pnMBuIchXp7IYFzjQZnM/4sacgW3eiNoMT4SE8CavUOM51DjCkzMGQ80hJVj2J09/EK7KN9Uo3dhmykwchymbYzcZ0Ozzh5aYi9wOlT259Bk+lJ3DnvQy4zJQMZ6tBPlGV6l4mIQ1tj5xIthpE2LWA==;31:D125WQ8pbBPTTl1D1Bf7EBu5az0hGPAzek7pxOxH+oeZBJ6LXPJQhouwb7BM+2tsULN3mufBDtjPXcl2JlsQyIXj1QPKW65IqTbged7kEs1+sPJQ+7ydUaDWSV3FcW7gnv/dltqH8q+UVA6ZTYWGa7gnAvBMDJASlrPaChJ0jWdDYOtvXM3VRLJsBau96GfvY2mOJTKThOgdTzfLHCLJdLEGobWS6cBYPHkhCEyw8sw=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:mJ7i1iX8pxv1YvuQO5Clqh6t+FKL+StpDI+SBoWPSUQLlddg035uXQYr1ytVXFh+G00kK9p+ih+ucoADqIvnEHZR2HSqKE+lrnU8HP2EwETw6HdI7ishVydA6TuNLt7a2VaJNlZH1xKBA/+AQ3puYRlieR1g6WwdEtS7JGcpIGVpJ4AN+wVXRLKKcKaPVyP1Ss4yxfzgEY/rTvmz9PlT+3k14FwWvV6AYrhLp6G8i/4yhspaIqNEObVV7TnrOlEqVvtyBAhGaJyaoKup2SMcpMrqiUKC7uwM7hulGTHgz44ZhV4N0bG9LDlnmzPzaPu3UxKn7d1ydkrmpysJT1g564piniNqavtsJ7sJqLzt8mCKy93dDJT/Qck1C66DoJc9dLjGurmr68MZLVUfSaGkQQ2a7GzKFcIwvlqHhWfzyw7/NfPgVwPSiaK9rHdoK6EGll6ZFcwT9fdMwv4n/ZTh7eD0jf0BYduqMRdLNw4dKZ1gOQj7UDEm9aHmQxNjrRm8jxeicnMg1xBJJnv1isu5w7X/yYktyshu1Tlf68jBClzug1RH8wPufBUXVdXgW7TullRv1WPouPQNdUL5WVs7jbF/DTrqc582p9rN1/xqDyg=;4:9P5cJFXLlHPJ1O+ujq5tAcpMbxs6nV+uOFNOjnreHta21dK7i7gNATPmj74svs2GjynPX8XPcUhonaBnezY22UxRM6zA9r3kWTBBlp3qHyNXVmHpWKCP1Mu2Tpt2gAQBaKYOeo2rA8+OjefiC14XUHIYAVsmSLVvwqKZ8Kx7LJd6p3dvaaV2pyevl+0jNSPEY4kNYKys8ofZs5zkhv1W8gGE+SJIowoBKM56PXkH7n4VM1PgAkcZ+iZmWbFfDGzObIzru742wNFRMuUhuVBQ0deT0VopsRUBMc5WQpt+e1vCJOUb42QAy0nnnTsZMFuF
X-Microsoft-Antispam-PRVS: <DM5P136MB000940FF65DEE897919095DFE8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(966005)(76176011)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(53376002)(6486002)(59450400001)(53936002)(36756003)(6666003)(2950100002)(6916009)(6306002)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:+LbNQmqMZyTUqrFqCGR6M8AIy5EOzVYGK+sQ1zihy?=
 =?us-ascii?Q?KYl7TFWZnCcFSgLAkjFdrrOFvCJ7m5HPOunAbosMYAuMaMjggdkG2y9rNuZQ?=
 =?us-ascii?Q?nXdtEX8di6oRCF+JEpvXkkJD3al+NBihBOEEfV/gMfplGdpm6RvzZbNQo36P?=
 =?us-ascii?Q?eDXf6w7wEjAb7OT5rNI75FebcnmWsNe76vdUkc0M9BWzeBTEd0yaIlUN2q5J?=
 =?us-ascii?Q?0Nzp6RV1TPbqb5biHGuAot8AVsSanfQKTil2tRvqsOdIxqV4igJyfcrLmVE5?=
 =?us-ascii?Q?fvllqr9HuSh2ddi5/TspDr57Y/qyoFvQM3FdYhlgjEtD7EGbbIBf0Y0k7fB9?=
 =?us-ascii?Q?NKAM+br+xuvyCwyzj+9FMU5RWkDiiWhDY8fv8W4POvqWRCSZAtv8ABYkklWB?=
 =?us-ascii?Q?6XyFohWcpFvJkmvjaLl11CfooZaiVuMBdhH2QGiB4IRYtOTiJgC8EzH2WaKR?=
 =?us-ascii?Q?Q3P7Uksjpvxf0pI2gfLsPNpKcuqf/YRRJPjSP9Gfz1RnsUApQ4sj7PpG72I7?=
 =?us-ascii?Q?vnh0KR/yh8VGnRmcY1AZ9JOcrG2OrwEKhL4bS8l9eV+sWiDfOK3VLyJL07vh?=
 =?us-ascii?Q?Bc9MUbRTOcL3Bi/gqWjPfXLwerIWXKIhD2+mZGQzD03uAC6DypTVLl8l0pyy?=
 =?us-ascii?Q?kpOgjpj3Pt88L1ufJLpjSaWSDm6Ee85ZCtqSbxRIRd/ek91qT0+lzpVNVpsP?=
 =?us-ascii?Q?JU9IPGzfYl7mTeIjXnteRM7TlJvqqz0NTT6aUOQJzTu9TgPu8eQETYqqB70o?=
 =?us-ascii?Q?Iv0OTjXQ/oIheQKpZh8SA9nZJQ1eACGd4ZJuy0YpUXPrwNn08WgffD8bFGXj?=
 =?us-ascii?Q?/mFcCrkqLTRrSp0Jex9bX51QCyhwG/OeVvENR4MraS4rtQ/IOVLLDh4OnYuk?=
 =?us-ascii?Q?CsCYJHDouWbN5BbfyodKg9oJR6qKLzGvaHOoXtzjmxNv7idGlH6XGSKYQrXn?=
 =?us-ascii?Q?WzdoPIAk5uO+csCQW0RwHcsNGHRXnf1PCISGfwQld7Q5HE32hNsCl5aeZTgL?=
 =?us-ascii?Q?z45ErszjUyBFijXUNdBCmemUcrcgfdqaC0spPzaqD4N8N9IDM7WAaiRy5U3u?=
 =?us-ascii?Q?82164EbudvBqJMGxdGzlLGlIa4qBE9gNIpDybTZLjXW2bpXwvvBbHuHt3Ytp?=
 =?us-ascii?Q?85mDZ/MT6k5wLkp5krXlXmQCMPJ07RZgBaA9L22Z9uesDCs+P5Xj8UrLqvyo?=
 =?us-ascii?Q?uKU48PhNAOIuuvMPFajrUxpuY/ytf1wK0gkEC2pItU8rVotKjPhv6XHebQDP?=
 =?us-ascii?Q?kjCG+7TUpGwRxNYMqUMGe7g1aSdcdfEwh8+GczTjBEHproPgmenOHmubQrr/?=
 =?us-ascii?Q?WORQzHUEP+FSwRc3gW/kJztlIaFzPNCLCuCr4P6VhLKxlYEkdF6RPt+5tiLt?=
 =?us-ascii?Q?guKZQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: pI0G9tOKjXe/fCVKoH97MtZV3+SLUAuTHHw0OqXjJkj6XrKegK4wsNpAArnAFDdDApxC99jTZKDEdXNOF3zSHmiul+/jfb5asr88KOgcljkOAv9YwG2UiFS70uL4TbPwlaTov+OIjCele3Anq9CX2NKDJnLRbbSQZlBs0EHiLAJmUopfVAzbDujN5gTa8RhY
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:gIM0lOzDx6TTZGZk7/X7yz6pY8gfGM+8Qoecm7KuU35S5upWg5sFQM6RTrdfpWLK/SdirElmPfu1X9nDm/KUDZx1JvqjFwIJRLXU7eopTAKdRg/+shq3U8LlTMkAd7jSl5rwX6o87u5M4hpZ4/NsDIvNSIInxPeMrniYNPFcJoJGNM+ZpQdS9oGgp5Q7aZX18pKFOjd+T/KcpD/cNtKRu5k1pj3DamWEGylyWCpQO7YBfUyr0YFcgyAWM61Ae0OvAbUi+RSQ9AYvCDbpk50obF2YCkVG8NwiBqC30NaL0MEMoBMYsWePcIJPmn8YwtSAQl+6auMTCpAh/oFUGpxc4hBQNYSZwb3w5DRTaDbsLII=;5:FogGUVw2w2z4DULuzHpiJa4d3Nd+upsslvCavUEPiaijlmb85c4cXRckNLZQ6v4JUzswId0xyzetk1T5zIJQPob8SXQewGUtOdSodYLr8D0YI/bBmWSY4njtdxfemFp12iPICoy5ADhSODBdEnEn3D0av7ju+ljxN4tv+YSt6to=;24:UVFBtWtqnSVW+dOYsrbv8D3lwcm9XhUA8fgbP3BDC3xfLi8qgqX1Ke9yz/hEUl3F45/ONlwvQHduMfLSHNy5vXUpLo0AKoVcOoWDNnslF1w=;7:Zur+uvyop7++jmZdslip7QxwWo7hnzPeUBh771at8O05PZgEIJOknSAav39Tf/VfRWP2MQTRrcVYbzko+acGk6bnBSFFuKDM4PRmBH0jZX50h71irz6Sl8pB4lDlmXTWVUOYRpc7FpEYPWBdhs2oOz+kWz/ic0ExbqKKKTYO4vFMbJ+uLlMu5S6/2lqkxNoa6ooa+6dAfyu3uRZ35vmIBXDVvQzsD3fN0D/xZPSbZWT90VbdhDHFD8BgCByow7FR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:14:45.8387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982bb316-0c21-4cd7-dcac-08d5820c947f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
or UTF-32LE a BOM must not be used [1]. The function returns true if
this is the case.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#bom10

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 utf8.c | 24 ++++++++++++++++++++++++
 utf8.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/utf8.c b/utf8.c
index 2c27ce0137..914881cd1f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -538,6 +538,30 @@ char *reencode_string_len(const char *in, int insz,
 }
 #endif
 
+static int has_bom_prefix(const char *data, size_t len,
+			  const char *bom, size_t bom_len)
+{
+	return (len >= bom_len) && !memcmp(data, bom, bom_len);
+}
+
+static const char utf16_be_bom[] = {0xFE, 0xFF};
+static const char utf16_le_bom[] = {0xFF, 0xFE};
+static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	  (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
+	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 6bbcf31a83..0db1db4519 100644
--- a/utf8.h
+++ b/utf8.h
@@ -70,4 +70,13 @@ typedef enum {
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);
 
+/*
+ * If a data stream is declared as UTF-16BE or UTF-16LE, then a UTF-16
+ * BOM must not be used [1]. The same applies for the UTF-32 equivalents.
+ * The function returns true if this rule is violated.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#bom10
+ */
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.2

