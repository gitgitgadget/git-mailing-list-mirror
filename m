Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76901F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeAFAsu (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:48:50 -0500
Received: from mail-sn1nam02on0132.outbound.protection.outlook.com ([104.47.36.132]:19200
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753459AbeAFAsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LfEOAIVlZ+e78PrUmlTIZv3OqdMNTAFqL7aOTdUn5uI=;
 b=O4aQKeznSAy179K40HDMunCaHKbkkqOj3QtrT7nrGMtcQsNoO6TQoNbbjkH8i/a+7708guNVnaaQPITZqC0sEfFXndd2ipEToE3wkO3HHwL8FUD8yEXxcl29i8BBRuCQ/muMIQKmA/DksSxctg3RaV+vpl07WC44sN1OV5MDuXQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.88.245) by
 CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.7; Sat, 6 Jan 2018 00:48:43 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Sat,  6 Jan 2018 01:48:04 +0100
Message-Id: <20180106004808.77513-4-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180106004808.77513-1-lars.schneider@autodesk.com>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.88.245]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (10.167.35.16) To CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd9f9dab-4dba-4e84-23d3-08d5549f3e2e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;3:r+3FlqQcAL1G6uS5bZ9tHqIgR9+XG4LYAICYx79G9bkO7KnZC/UMlIAlt8YDe0h/kmA7LjDN6AEnLfz/Pfg2diRKMVS8Nx0+qumfeYRW4DyZMiIX5Fg0FL0uEe5Sx/NTrrqXSA/Q77nPIHVzHUw3VALvplFeoJRnWOjP8R6PxrefnjnlcETsKv3wAK6g0LoP7rwb/SbzFey9JNedZOyDbguIc2Ka2/Bg8lNtMpuiq3CxMggrDOcy6PpRKIJ3TVhl;25:URM81N2EAEsQoiRNmjCrUetAOJncVqnaTHEwudkhRieSCllPe/cbKgrjZcr/mMpwe1/qECnScoqElYEV/NAorg+1acc6hFZN4LdXQ92e7hz0bQhHweeerG7TCWqx5ah7YByk5Qd7r4VLWQ63gGN2mNhlXaSpMCDaqlmP0W0zG7gWhxjZ4888qOBkGZpriCVTTL3HddTMoOY/rcODGzJ5ERv5gts0Y7qGFpHcg3FOYn8oB7YOvq2lPfcmukfhpMrPopvUuoWYWPS5vx/lOQrerdAt02xrm7hwskdi16Jt4qfKVq3xQEi/IG8NHD3hccy8aLLYkwBpf07c1pX2BWIM3A==;31:ZxkfWXcTLZ9qJiEDl5rIZf492bsRyuQfn9SXmikQ6FJMInA17RNk9GTtD3ChGPsGriOLzFXgvS+yYtRQHm5mWwh/35HEPkKrpklMJn6PnfqQBFBGlVlnrl+cnaEY6fny1aPYwqGGVSuALMpq2CtRbHSztRsn0HsXSeFXsSxD+ZCt8yOmTTfUDn0OyvbZ9Okp/pDpYtKX8Q/7Clo+N2NHI+uroojPIFn0m/iOdJhIfGc=
X-MS-TrafficTypeDiagnostic: CY4P136MB0021:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;20:8IXUsu89JRsg4yZDocLboMmcDJ4y2pDhleJBuljlZqJ0dgCPyDyB4yQIJDslFZ3CxCCIWHXZxhHlpzZeZ2ozbjjQH9btZnuDyJepVmklrg8NYkSXhly+riSzvQcRURwgf1uFXbBnQDS+j0fbhpKQhnb95W8izUKDyXWCjWml3A+WIk0ZzMvI6y37EDFpqNAYl3zjb8rU1Qp8csg4bOMZmXKmXe4lf5Nf0uwZP4S9InY+2ruMlMEhRUyMF/b1xlXA8njVbSeEsEYkK9vedw5ojx8an+dQtz/uhKoYwp+GavorTJBYihKEsa8nP97sIL/HVImPZaXcZhcWpkqcks9/H2aNHgvcoxJDtRYYZo/ZKmOwAdKxwCZS9Z7Qo59QeQ9OOR+u5Bek1g4US5jH2RLzlrfaO0ChBnlA9VsFwlrAKig0iGsOOEQzTztUbOScvc9osuamx6ofsn4MqWNj7J+6aBuXrQgZUu8vWc4df/nrS1Rr7xRosuCPpwDD9T4akFsB8D/xXK5e/SazrGj3xq9UPfp7hONTmYkNOsO52SNKC1rkLXhjOq6x+ifO50VWOEXiXoaG5TXrAblxAwmpGIoxnzHwTR5fQgiUQbDlpl+TzLw=;4:BH3L6ssoUp3eFhL8Vu5XZyuucoyfS/AQhaVvmiVlfVRGQkDUBez1njuEQfn+EsX18FaIvQtBfXRbcmuifL/h+yK1B9gWFJtylZCf0QmyS8v7pmeaENWNvE0BGCYCof5hO3HiijSMs0mgG9V2jIZZ/WDv3xYXDtp38mNVysNBQTayT4dGTsShM9ck7CEKZXfTs1DTnaQ444u0/QcPwX/lNyoqb9RMwebjJSh1ceMBRl/MHLabvLpVw+WYuU/yCezqUq/U8dTyKQSWApxFowGdqQ==
X-Microsoft-Antispam-PRVS: <CY4P136MB0021B7F26AD56B9723F86C6BE81D0@CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4P136MB0021;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0021;
X-Forefront-PRVS: 0544D934E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(189003)(199004)(5660300001)(2950100002)(6916009)(86362001)(478600001)(6666003)(50466002)(97736004)(106356001)(52116002)(2351001)(6512007)(53936002)(7736002)(6306002)(50226002)(2361001)(6116002)(3846002)(305945005)(105586002)(1076002)(966005)(85782001)(9686003)(4326008)(8656006)(66066001)(33896004)(16586007)(316002)(6506007)(68736007)(2906002)(51416003)(69596002)(39060400002)(76176011)(8666007)(386003)(6486002)(53416004)(8936002)(48376002)(25786009)(16526018)(81166006)(81156014)(36756003)(53376002)(8676002)(47776003)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0021;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0021;23:IeI2OAGYsqu8jNDmtplACGcAMziUfNp0BTyNHA65A?=
 =?us-ascii?Q?mKj+vpU7ACBXV1J5HcSBto2ICFlEUlFYQvsuhOxi3J120lAHYzrGsqufVBW5?=
 =?us-ascii?Q?565o+vp867ZH4ECstPEAR2qXs9Lbid4PeRl7AAFrsYJia0wzQnsZSvYK6e3P?=
 =?us-ascii?Q?RGu2jH8+Y9Ae1zDcG9lIA9vK9zetYk8+0DHMe6DcSsewJ0qeeyMCkgW5+alc?=
 =?us-ascii?Q?RK7r0ovBGx08F5p8szonALsfSMM+MxETo3W9PZFxZAtT4pIfM+WWJpqr/vIK?=
 =?us-ascii?Q?NvRBLsxELsYknpd56DeuYAbCf3kuIFxZy/VBxyO+e1MvTzID/HTY+BFSJqXp?=
 =?us-ascii?Q?IMyGjeSLTBTS3VPQDsXViPMV1JafypuzqgG5eBJrgMwlXhWOTINFxbg1lq8e?=
 =?us-ascii?Q?NPamUrs3/kzuI0xGDpMXpEHosaI5NJQSTiHwnt1fVjKzUHuTgxk/vDbpdo/7?=
 =?us-ascii?Q?8b3kbDeSU2JInw970YaqC1EkGTG+Z76e8iqqKJE93sra0HPk3WFMNrGod+Rb?=
 =?us-ascii?Q?a1xWsn773z8dz0+KbYYGlAkrmSdaxyomS05w8vq/ECUKYtXmJj8BpuWL2yvB?=
 =?us-ascii?Q?2lm5L+3eD//bbbkP6Dn0LKoWahmtGRD94jjbzaWx1R1ESMWLVuayG5PxiFCO?=
 =?us-ascii?Q?IPmNA9fu01KKD04V0m4cXIwoqxmyaENQamfVa/snp5ulLq787G4M61/wk5PM?=
 =?us-ascii?Q?+/2YytNWQx7VSh81m7em7s+b7lapISIysmiwsEFJh+XmJqmuqIn8W2z9VXX3?=
 =?us-ascii?Q?fL6sJfV5yqQsK4sb5KJkISNQjlHm8WMVLMFMU11njQ7tewxIN2xSQO6p0K4w?=
 =?us-ascii?Q?7MChGD/JwpebrL0jmZ5qepWGI96o72g5je3LwY6wIBhqaUQRiHXOGPo2JJEs?=
 =?us-ascii?Q?c1k9gVY+n3u2mYaw8vgz83gDXvO189rt3LWYhJa449FdoakuRFkjEWwLc5Dl?=
 =?us-ascii?Q?MZVXLHh6xrZYabImBljzS8Bpdz60aoyQtVl2+24xURkCWEWXIa2BFVwvCk3V?=
 =?us-ascii?Q?aPTJM+JByNd0SFyxI+QzEV/CbiQfnJvR9M2KLsOFmNIsrrd3wU1UHs58Jzk5?=
 =?us-ascii?Q?S+mLKG1HYshuk2ODuN4UBrLlDVFyhRs21DKhULHkbc9mzJPL2U+Birrf4q1i?=
 =?us-ascii?Q?ksFwK7glX3JGLCbjJFI9GrKgSaqc+pql8La4XwDk7V5oW0hPyqynPzq02LZ6?=
 =?us-ascii?Q?r8FcAEa70mvyHoo/9HijfTdawnoVTOCOQVdatRNXz4mBKyKKIP74pOKzk3f1?=
 =?us-ascii?Q?bNgYpmdWnYOUE0hxNQBgvJ3xf0G2fsvZlYqT4YS2tS7Ic1iudvBnEXZ3OsSn?=
 =?us-ascii?Q?EEbF018y+x1BXoVlaXE+LXAIwtXPeostNkN7U64nF8z7iJCXzqo48UzC/I2u?=
 =?us-ascii?Q?F5CpgzwQOCTf09KJSllUbI+MMI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;6:ajqlFwWoP5DUwfV/5UjVdXOFS9Us2A86OJGCYOrq0/wIO46ysmvHrQOGv87j9TltkswgDe2a1MyDw15pnKuaT4Ov4xa9StmV6OSPi9I5cVvCWb9nbQi1YcDCii3HiX92/RIvb7uk2WeD0Z6SEg2+PzVu3OqLF6fhHah/MPRzlK/+4qXc/jEBgZ9kxngMxJoS1sXOiBV5bOnqdvTndE2F6cybPvGwuzlC8SjYeeLm+HfJbHWzGGnOwgIg8PNwYTHQ6y45QSmMoeFjIKax1/nfo3ZNLrm3l/cyzxVFylzzE5hjENK8kgenHjYkugQFNof7crymmbI/Swxea55oAeyz3hlqR3T11co76J75YqpVqCg=;5:dIPKl6XwTih+8oXGR4n/ynAfW5ERWeAVTtHKFxcQRDdjXuQ/WGr7Ys7Z9guMWFNx6uVNIJxMvLL4Jtlw0MHzEtDt6nnKwDHSycBPicUNv3PmNI7ZuOifUUemstXrDaPIodKeVWXlWojDFfc0NiVjcBtp+JQUbjTWAAwJ+23kivo=;24:OSbKyFzkD3AudJq8bncFZUT9HIvnhRmPrRWIcQfqbboKwcJPw1lQ75gsz5Fx/pmA2VQg/AQmPUV6Qda0e8zA5+E6CcfFZIwgnwBK8u4OUfY=;7:1Tcg0zhz2S4L7LeoMDR6sHIYy4ppYLKbfHXzaPDkaAc/BxXCnBm7niIKrx9wl19J7EYcwwbLKnJw0YBQG+kO1aa2K8WaG8KOL0+QbUrRRXDCEdvlj4Az4YmSzQiyTLLNd/fVF7VXrUHKtlvVTX/903zSeUEJRyz3IpUmQS7dAHkq64Y7YQR1YT7FkUbKWZKZCnqEE2YruNKsNQ+ZqYVQvIcWkwA7uS5k+hkkI0rKla0GuqHpYvDQhtSv1T4T+Sl6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2018 00:48:43.7693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9f9dab-4dba-4e84-23d3-08d5549f3e2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0021
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
index 6bbcf31a83..4711429af9 100644
--- a/utf8.h
+++ b/utf8.h
@@ -70,4 +70,13 @@ typedef enum {
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);
 
+/*
+ * Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
+ * or UTF-32LE a BOM must not be used [1]. The function returns true if
+ * this is the case.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#bom10
+ */
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.15.1

