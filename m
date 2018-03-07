Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25F71F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933598AbeCGRbQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:16 -0500
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:54586
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932537AbeCGRbG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jJSu18qaUBk76O1K1OvOmMeKDEKn9JDv2wIyGnML4ZM=;
 b=fGfXE5ppihxRAlrzJKZSPVjxOJ9Pl8RcJqH4hKKHnsgacVMdlhqi5CZXbKbHcCplmJjQneC0ToiTDSAX07hfp87hlwT/Vz0pRSVYnWXMMrr/Z7SR44pQbHlbuSzMeC9aMOWvAlaCxdKeOY7a4u+KEbT/G+wfqiF5f7+zFw16lNY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:31:01 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 4/9] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Wed,  7 Mar 2018 18:30:21 +0100
Message-Id: <20180307173026.30058-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307173026.30058-1-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf70cc37-c141-4ec5-f4f3-08d584513425
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:4yx3bs6wTKRdhoCACt4ReDbttjAkfgkVGDRQ1ZFg5N8iDqYAId3lQepU4JKOzl+rYCnUXBzZXvOmnNOxt58oB18vZ+ms3yeSv+EYFTxwHElHsEIUnjas7rXiGt1eZ5kfCiL9O75cVA1uN6nSD2nv01LGuTpsy4sv80LfiDobkh6fmO6MIeBQc83x4KcHXh9r132dz9zFI60aAqhyfOE2ETtMs8iFOM8/i5y9fFAChM9vwVGsfHCcAO/3I0w4uuLd;25:yck0o0j7Da++hkGJoanSzu9hlgkM6sMiGY3usmwkyqhTAz4Tv6L8Qyny/AkK4WpngQ6lcjvheufncIV1eo8VLC9ttumVWoWnjq8UbpdY9kVRyA8DjlGS1BCVCCzHgRd4dktJyng60i0mJEH48ATkr9zyP93eFIX/h1cjOukuAWFr4an+xlaWfnoXkWGgT1XTPpOwFUe1M8nKdnRuKEbecDYvaNV13ikQtL1SlmNyHNyddcBGQ3mxPaRFwnMugOEip/iuwDZ/fU5RwxY2sODcG2uu572GuwpcWOlAhACD6Ba082Ov3K/ER9UCrAYGBxXKZB+6czvXeN+bU6zfEiV5JA==;31:HGO81qfvz/nEgaObIPFzYMgBrsyQuoftm0OBRyFEPmFqJ4m2UPAnbRFHh1xMXjAF4rS31gBenl8DSeZ3g4w7GkX7HkxYvgv7+fPyfFVlDwvUf44jexTBI0LPZpXpzhpN1LpDnGsF/KEso4hqTZ4e/eWJzbUU3s20EeNgcMaWaCewjhO0fzmvNc0ECYioWf1NquKMGvzdegExTSFhapYzut7Uc7vriuNUOyD4iyPz4MQ=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:eO1y+hAXpepvjwg5qgUG+IvBlN5yfrmiELknGO6wBShVrXOJSZdKlS+k41+PsNNvPZaa6vBYTsODb/WkPqNRDInXMKfJHwE/JeZl2RG6G1D6Zrbar+IjahjVOjn+WE8687WbtRUGEnQKYEYi8Aq5haCbfGXTDWgeXtWGCkMb/oysDQ0TroLv0Encnl1W/6vgS9DsmxtRBF5hX9q648/i2JvshEgunNJ+O/BSjC6Hk80Me+zRQguJVF5c1vJth5WxLeiI6+ykBWIVjlTSGXjCsxKQwN9t/62hIp8/aPBA0q2w6BRcEFv4NTw/9/KMueY0fePrTrwwUI36nU7qwnYLmJ40dDE0sc5MNoP6Ml2MGdAJLJ9jmoyoeSD/R3tEMhdVNqay1W8SIUI4HXZrG3lS7Cl+vIvaBUREmeOS7VTg/+RM6BUBxZGsNXHzw+1cgyFUABOpg+PACaXyPGx60zqg09TCvQKylbj4CyUPrP68Um27rIdZkQNetaaScvHPYlelDXGNHPEhJoM9jRozxQuLA4z2wtECKB4idnA2on8a6HFX0Aan9r6Koevbw65Y2fKQ4wdjFZh+90ld9PKUdNnP5IVC123TYDveKJkIPfa6KAA=;4:AEfcOlJ8WoTfXE2IyR2ZLbFUxyc5TeA9LEnP8re27NQUkDzmkcIBSha+gfRgb14mP7V/emWLzQHWPILGNtQJsVepxnCDe5teGIxuOmrD+NIbbulkwGeXkMQ6+CusCeoeKqBObXcevF7vdyevwAHn7n+RSNZYIYyxMmRG0ifT76eZRXjKrgAMVYZ0Nq65UioLp7Xcq8OcnTqhrMRsOsJmsJ+Ey6ZRI9b5DNDi3gLyiqJJpr32NpkQ2GgKdWi1RKGbcCovakN0LveroEKoUho6knVJvfG9Nca5XO+xJ/V3AxeZ5rvAoOeVN+LaZPwlGFO4
X-Microsoft-Antispam-PRVS: <MWHP136MB00143F9CD8992B4B344F7BADE8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(59450400001)(6486002)(4326008)(26005)(6306002)(316002)(8666007)(386003)(8656006)(53376002)(39060400002)(76176011)(52116002)(7696005)(51416003)(97736004)(25786009)(50466002)(2361001)(2351001)(966005)(105586002)(85782001)(50226002)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:UT3fBjTT9LGU9Q+frQ55aPPx9uaCzBlumJGQLcevR?=
 =?us-ascii?Q?ghIBpAAWeEIR+bf8sG0YDfvVb10/F7cmLrpRyy3pUQDUjINGnd9aPhiIuNiR?=
 =?us-ascii?Q?Gd2uZ3WKttsqKA2cN3qehLtPpQAXpzo8+bSgbcbtZ0pdFTSUZhIATApSj/tN?=
 =?us-ascii?Q?Eo1tgoHtovtY3dUn7oBHl52T3HeKv6b0dR0FiGRsWvQpS0nQ3hyFd/EmrTMq?=
 =?us-ascii?Q?arCJx+FvT8c3e/pnaS+6oCI/EHUvY11+IbrniDcIaPCca7Zf2YfjT3iJOMLI?=
 =?us-ascii?Q?41EcD8taHzQTOzWm0EgTmnofnJIxWSsoxXxNYk6FhmdqU0Io9vBKJ59R7bsa?=
 =?us-ascii?Q?9YGEmSjyLlnrOdUbLhVBn+mszQidvWbk5rDYeG5U6g1+kw7uQ0nRvxOFcBm0?=
 =?us-ascii?Q?qi9llUIs7uFz0duEDOYmDgppUj5tGGf169lBGFoZ30oCr5duZTo5fyAYd4P1?=
 =?us-ascii?Q?3VUMLMumS10BTiGYhp4oSycKHvJbdmLnWHFnCmnWcIZMMN26MydiBEeLLBJE?=
 =?us-ascii?Q?OgkkW26p5DtAes9tBHiWSuIrBHAv6kL5NhdC8prm35pY3SP5pT42elglC7Dh?=
 =?us-ascii?Q?7Z/XmKJAER+MXmx603jXpxKzho0FSCuMptvfxy3rXa9rk1PuFNPYIPB/O52K?=
 =?us-ascii?Q?y7GK2kA4RGELP7bN5jWl8hzr6nzocB3EwY1sc/FkfM1TR6r76brwYM01w7eT?=
 =?us-ascii?Q?SorpkLZykxhj+alMP28siSB8DGKQfgqJT0IuJ5Pkhu4dwv+LftyuHwDIPnOB?=
 =?us-ascii?Q?IGdRX+vJiiRbBnnGGgtBXAm8z6nBJmVZAsS9N7nBX/q015woIZyZaIYK/Lvy?=
 =?us-ascii?Q?588BsVLtZEBbptqbUBFp+WIqg489KQ6bwkD/GyLFsagthq3Umlibeo1mZtiW?=
 =?us-ascii?Q?6a16zOe9thQgU5qdcX5+MPnxfV/h+/47znaMqpfczuu+HGL28BjxoeeeHC1k?=
 =?us-ascii?Q?yXaVDHFFtaZ0MZiiqph/IxC2jKTRTOyLnXvyFSWqSWPlpUQsVnv/0yQZR21G?=
 =?us-ascii?Q?nzOeG9kZmwVCRiHbIyPU4l2d4cOTMULHb54FYcZ1Fp4X96BYmKFo3aUC5ml/?=
 =?us-ascii?Q?ZpUM+L1mL6D5jsHAotbB5jJnValM2o27uZ1V5LkZcfbrE30R//ApK1GEcRCc?=
 =?us-ascii?Q?NGaMnfb8wxoIqOvo1VzX09Xw47yV67CcVzyZu73B7W9KFMHbT7V4Uy+588AT?=
 =?us-ascii?Q?YbVvMiFpBX8OP9GePnJBzeXXP+J1dGG9B7ZVpLVW3YujxGsf8+Vyrjm0g+jl?=
 =?us-ascii?Q?HwkO8vTmYhDkXRnIQVPOkd2TdWm3AbyBs6Pp+C2AKrfv/j9HvfEUNCHAuild?=
 =?us-ascii?Q?QtbopoIl3D1XGpVXb2LM0bJt9IEERdbB5CGmP5yQZTqv37Yv03MP5HY0zJDf?=
 =?us-ascii?Q?Kxtqw=3D=3D?=
X-Microsoft-Antispam-Message-Info: jonvqb5/Qf8j5+e93vsZHGXrUqYclzamhYVMQ8vqgiAcGivCGgHoxKHecyU9/XYEOBOVLS8swXjmGKvBUiZOemaYziK5ojx4J9R7Y2S3qg0nXpLFuyUdzA8z2J44RYBrRW6McnbD/pPcTYD+Q9QK7TLuPOGmPm/6ZuQqVNV//sFjPhiwSL8hOd/4BHGtGRF+
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:3DYAd4BI2aJlzVFNcN2XnUvobRUvGUUZWYvRbQQi9MpE7cCjEIE4MZU+EudBlYKQDoUb0vQcs//ky+x2TP//ZSkVsLBr+PMl0lwDIpZIVzHuu1jQdRYHPQzGVdBlMU+Ec5OV49P/H1ULn/LFzPIl+yvZr9s5E3Xxde+JRusEqAmwfSltw0MX/AMu8mCcEavgYmYrLi0/1gtVUhFpwYlaWwJR8oK6lsKFYDAibWxFD0YY3/4eLm9WPuFiMDk+43gK2usOozm8oZIrf1n6vaFaZyVhXmnZjAL9lmz+pyGaZ4eSYGVUmmK998hORUQ13TkKx9kWm7gLtQuf4Z5Ih585WGOa8xrl+RlXxbjok04f/+w=;5:HL9fF3iE15u+UsCGvkKD3sMQty4ZZ/2Erca3hzvLmbub4qA/b4yQNNmvdPwzf8deZAV79wOm11F+kLLEm2IMCHYlnqRJWm5Q0TA7SCVuIQoyfvH9ncREYO+vSyR+cJ/dC6c2N1WRaNJGewDZxLofwLBWIqaumrUebivtZHszL14=;24:PFOkl1F8c09wObDZoy1F2/lwyoa+fVehFBt8NN7Fy49D9d1Ea853J3VLZNQjjAvTS6lO9QjW+/Y/6iLGeeqS+lzqwmPnzedc7zhZOYnGo88=;7:GWKg4+dfMxlLJWtO8eYbNsn9PNHNV8gUkA0WRFO4U7w276GxIxH4eW6Npnc33jj94bsGJwWrQRA47G+ayNDLybTIM7KfeorF5aQPMAwEwnPp7M9HCvt98RUsMKmiiCsHwr6jo+vrZHFBwlg1aTcuDOTtI2NLOtY1/j5B4PJuzuWZKwnDzk4NrEnbZUGrkWaNWV0ynT9tF3DJLU9cFHqtV0IZfaj7Qk8AoTlwx4awIQStMtF8Q5ktM/5Nhb4TlzAP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:31:01.4756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf70cc37-c141-4ec5-f4f3-08d584513425
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
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
 utf8.c | 26 ++++++++++++++++++++++++++
 utf8.h |  9 +++++++++
 2 files changed, 35 insertions(+)

diff --git a/utf8.c b/utf8.c
index 2c27ce0137..e4b99580f0 100644
--- a/utf8.c
+++ b/utf8.c
@@ -538,6 +538,32 @@ char *reencode_string_len(const char *in, int insz,
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
+	  (!strcasecmp(enc, "UTF-16BE") || !strcasecmp(enc, "UTF-16LE") ||
+	   !strcasecmp(enc, "UTF16BE") || !strcasecmp(enc, "UTF16LE")) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (!strcasecmp(enc, "UTF-32BE") || !strcasecmp(enc, "UTF-32LE") ||
+	   !strcasecmp(enc, "UTF32BE") || !strcasecmp(enc, "UTF32LE")) &&
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

