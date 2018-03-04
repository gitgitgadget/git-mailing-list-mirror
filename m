Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F54C1F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCDUQE (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:16:04 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:20096
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932188AbeCDUPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FIhEynO2b3neAdT5vXxAdMTAHgKO9DcABqyakhJthAs=;
 b=ZcUXbGci1KYMx7WyINRQOL7hL7YWdgwfkbqEmEAi7peUdDpfnTimjC35JRoBTrfi2JfNMYi5N8/8IjJm6O8xx+ixaH5MqwG75aLj3ExNKhKDdQoiX1k8V4FL6glkGmuLH35EWMYCkDtBZn9gXZaKUCv5St58eKP8n/EqZ32wDWk=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:15:03 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 8/8] convert: add round trip check based on 'core.checkRoundtripEncoding'
Date:   Sun,  4 Mar 2018 21:14:18 +0100
Message-Id: <20180304201418.60958-9-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: cea58c5e-452a-4be6-c952-08d5820c9eeb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:fmfvv6V7Uy191flB7HLRrV8L4H+wnVNa7Z90Y4eamPGeVyNbOYYab6ZEWn+Dhaefd64PeOFwlS7tuB+xrmMjXH197bhhJHJNc3QaUgD1kOBlF40uItE2dPRQYR554EzlZz7//9VoTDvI9yUqi48bG8xafz9gwGLhzOip4DlCRS4ZMB0i9BhYZzIH7mVsbUToAJIDzIkNtK2TZzJUbNklLisUCobL6RYSly3AmXE9KY2K3hV0LX6mtNPrD9R8IoA1;25:g9B5H++zYFVEHHihO8xdPWapmGQaHlU/W9O0OaDiBWEyFEm6Ztmg+37c5EPSXl+qpAnz8lz5WEocUkeHN40wg022ZOrYghHOKez3Yh+4wAOO5FzLBz9OOwXZLB8ikYJSOHS8QttSSqSsF6ukxnuzx5l2ar5Dxr0mvUzP9Fj/VocRuaEb98JLuvSfMj6gXnQ0uYPIpAYE6qL6XotoC+8wxc0KZzJhgZw6YCVfb5b6HZN7gUlnJAZnX7nrcQkBty6UY5i9JWhCa/NDHmUtRXN6B4wVRdp78RReRYUZM5yp0XmyB+rt3d/MRfGhw6QpOsDd3bvYm+vSmtI3btUuMTLuwQ==;31:tgyqovtnLhO1d9ZC/A9dTUCpqHotoNzsUl3TVZxx8xvfPj8W0af4a9Ghq1Z21TX/XIA6hjiZThIFrGVk8Ywrxyye9g+4BrR2LeWCXZrPPT6SSrlLJFRXB5MqfjSPskLx8Z6woqI/hlOQ3PA1xcb4d33Cqvnlup6RhXrdNy3lMI4MsNzcdVX5Y7XZivM2S0gs0YsCMEXWZihIhY8WPYw99O4crGFiqws2qOvx/O8Jnxk=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:kZ1GA3BanKZX9BaF+pUrfjQETUFkbMaJg1xqHCzcGv4mKaZ7dq8+3Xg5U/25qbQaHiwuNhEa3TtYcRM3BKrCQ0ZC2WegKED2Dy4aUgVpAJs4AkU7+uhYwh6SYR+dPffcVYmwkBAYohSsDGhyeOSutELoTuz5PZ0NgBVIdycWLr7Hl0dzeA9E94sGLPlrKGLsVaBm71tYCEcfD/5NX1cbGg0My/L5DfE9i4u1ffaMJ+2X1sVrhnHpRlE+DdZEhAyBNWp9QjYwz31dxl10r+GzLZS+ii28wBMnnlw9LZo1rdo901gbn7gKVBuZoCQMUwgHxo1PjQlBdZDDI3QyHp1a/vV0t++lwtU6itIv7ps4/h+wOR38yZGb8soKNAvYjXv855QJ9LlGyT4lEF/td67WhXX6c2O5flw9ZnX+hQrEAOOVRECjvcT61lPvW+CF2rqV7RLL7XNm3dSlyjOs+hgYfcbyIa0ih6HEgL9k6cpi51qN4gcfdbxmb6A6dOTB7g+RLVWQ5Hqn0F/nPXi9p4MASuRO41y2DWIvLEfITWiruETqQ7z8C2+1/H2jgT+w5ExMVnEgy19AHqzXA+Quz8wXZePPKa+9r09mr0faaUrqGpk=
X-Microsoft-Antispam-PRVS: <DM5P136MB00091E96525B7C6B3DCBA9CFE8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;4:8CRaT5uEjJgfXyXn9ln54fcv8mUYytYzDETRFEpgUtfjxvsrKQ0rkpgkb+HV5w/iL4fnzugIUDWxLu05JilhLH5iNVct2bKC5GBtyturyqxy8HPtwze/Ez8p7I6PMh/R58mdlIHT2yEcmlNECsclPTVy5wRbIdeENlTWwSsyxPC43s8MsI0qNJc5oWvnUdIUSEyB11i5AQ5Do0vTX3WHrIflHPlvx05ePeHYwlrI7VXaLhOdY2nrV1WGYbzJjJxVdL2JT4N73aHZnt7J0yUurldLPdvYiT/a09PZZh2fN2h3GfaGq+DZ3kmABGwx9UVuaLUZjhISZYn9PqJPvZPtciO1ouI3ZiFyqtBLTaYqYsc=
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(966005)(575784001)(76176011)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(53376002)(5890100001)(6486002)(59450400001)(53936002)(36756003)(6666003)(2950100002)(6916009)(6306002)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:lmjmOZI+eWvhooHhhIfhxpw20iCxBabEnEfR6b8uK?=
 =?us-ascii?Q?RS9Z/8AdxMAiUtj2BPUyinYMMuwV+WAZ4haZorL7T8ewpC7jpAYMywKT4zVS?=
 =?us-ascii?Q?I/tDOZnUbjTax5X0SVlZtngG0PBIc2luKcHcmWwrHSV5unAlmyh0NlckVTIl?=
 =?us-ascii?Q?T3vBwl11/o4HIdaayJfQ9TCDBT3KWw0WxlIDeSWyLei0iHN4gaMkMZDOR5lV?=
 =?us-ascii?Q?l1nIIgFT6pM2TokvAJTBEMa7S+We2e/yKWD+VCIqjkI6hTI6gsaYXAR/zFbH?=
 =?us-ascii?Q?/tRD/e4wA3ANpIWWwDnuZkkb3LCbGEo1JCM8jjlCFqS5tO2++R6MhBclWm0M?=
 =?us-ascii?Q?ShIYPZbgKZsH1lApmUN+PGl0y3bBk3X3PlWtGWreFJo99EXsTi9Ozeg5r4b8?=
 =?us-ascii?Q?humUU9/2A5gZOnCYttvDFFcSMMts+H/CljOQGfF8Be2U0SAm6f99cxsSS9g4?=
 =?us-ascii?Q?IBLBbW5pGkn36po2BCYcuK0aIptNqyhE5MBvDGivOn2+qAgLycObjdRiSwjM?=
 =?us-ascii?Q?IuEuiG3mh5ln/l8Kg55Q2jMqDHNiEU37C4DoPjXNfn50I9TZZmT/Ud2c/hNU?=
 =?us-ascii?Q?qQvrXftft4qJ39wfqzQDYySZfUtBt4b0Kk9U8OLOc5L5uWl811byXsqnd6AO?=
 =?us-ascii?Q?cIu1iIPns8mO3uOLPODWPsJa68IrcJYgtk/qlsNkCTULfZ6V58/aMvi+3c5H?=
 =?us-ascii?Q?cOZGnIpZBp98nTO35ju9p1Yj/YFH+6ULr0POcRO/+NFPfF03iJxR26D8BxzD?=
 =?us-ascii?Q?YmFoHzyLKiVtDVUtz5ZsMtVqybZnBs7R+gLOo6mn2VVV2rA2wYibuL8g86ed?=
 =?us-ascii?Q?bj48xbIMYCKyuyNiLz4cb+0Zbfy7vm++sLm8UNVYoJC+P+IwcoeH19qBk52j?=
 =?us-ascii?Q?X/V50FAqjNciddDN3sT89yFNNrTs22I1Hkw7k3OFtogLZ7Th0/+6ADQACwjR?=
 =?us-ascii?Q?w19/Mh9fBy3BnldustsVGP1VEvtaAYMkbfS0rp9plMw/QODq5bUTxz1WhkER?=
 =?us-ascii?Q?BpSJ6akGcTxZPBk0cu4LXhOLlcIOpM+C7sjhwaOn/mkS/XMFUd6JeT9bqW4T?=
 =?us-ascii?Q?DuGXTahQ4kta77cC9u6NbmduC8MCJUSOgfpR0m2bOFkdBT05Jyj/BtxMn6ke?=
 =?us-ascii?Q?n5NQoXHZz/zLWPnKHCYImQsWyVfOVoKNhGUTI1ooyQEISoneiUEAYY9fIJ9t?=
 =?us-ascii?Q?TBwFvErW8ksXEHcPZRwjCY/5AWQDEIR7mkdtGCgF3BQ8t7JoGYjIMVVgICv8?=
 =?us-ascii?Q?tH2piuBUvCWPTW9i4SLw4ENvrlPabhoL3AIWCC46cv1imJJnFoxtPF2EA98r?=
 =?us-ascii?Q?PIvpXjTY9thIzKgl6SCMxRGETJd/36bi1fw4nPEUF48g7/qTniJqj/NnvWCK?=
 =?us-ascii?Q?PkuMrgA6zLiChM54UQAt/FgOE4S4NBFlfaQ3hcSK2F5jtGyzhB9u4VlEzM3U?=
 =?us-ascii?Q?0SG0Zr+NA=3D=3D?=
X-Microsoft-Antispam-Message-Info: sa4Bq6qqd7oKuNXyT1zpqDAW+pqywvyYzRvfcamBX5oWlxS1TuAmI3bNznnbClyl8PHRuc1Q9g6CzFyHvgk7iN3UTJYrl7SXxvE2i7ahrDdhIrHmMY4/XhOqx2AKGLFw87QTBnD7DDA7t2TNnjPVuLHsdPE6WxshO+sgm2dZabyZdXZBf68+uMDKIGUO5hRf
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:n81rKZg/36WrkiA1OPVJqpF0mgzu5ShlZVP/fgCxjanVrSAFDw4lW97+n1tG7Bi7aDlP+w5kC6cXb3t+rKmR4KDWkdiCbXsn5+3eDB0uRJpnMX9gMRbzws9RcUHC2iaw+lS1gq/ZxxUKJJPV2Ymm2evtZjwGeMvW2TYouGCNW4aSwcqqy7sAfJ0mF/wvx5sXC+K7XFneE841qTpUpK43g9i0PebUiu9cVT1uQcCQyI2D4N8U6cyAHFvz6iOzado9ir3qI6WPYhj3Ze1rfa05L278MxurT4tdgxdsuv1LrSHZbk59YE93CDWfWp9Fsy1wWJf0WXIxYd7Ns4U2HG5Ph3xPrFMKG44lc51hoD8XoCg=;5:oLA8VMcW0X0rARY2hSfjaUtSs9NFnbpKAenGurWJHJ9nTe7w1uWRGgY8ZSbNcTsZw8LC7fvosBMutXMTo4BNlMR/n6bvzPOoXdw1Ep4sSfNbA63iz5SXFGY72silEh33tQgan8fsKfzX/xw24mRUabxXkp/9s9LzbjArip0HuOI=;24:EUsSaEiEMRYXydBpgEEiMQOjidLw2Xzz+cN/1P3MkZCIuyVsGzeowyPGpcQxYzJ4QCkeAK+DFJf44bbEKaYX4+yWel7KPj0jSXv8qCbBEok=;7:R2izPicojj40Mp/pm77/ke395PUAuRAX0hr0WOtHh1UhD5mvaV4awfj1ukPu9W1F/I1h/Rft/yLiFh8MnvnLqe9kO9tBLKSFG0/+SIB611LidMlVUexGt1WjScClQu+8/HxYbNFvqmonyezhlbEonDRXIntSuwumeSDeArWur5bNH1oYuaGAMlOpxAVLZep7zap2+Y51Z4qPm8RgVoC0sA5a3lJb88hqVMfAqkAnWJBM2kbOIVJ//YZUxpFEDgfo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:15:03.2920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea58c5e-452a-4be6-c952-08d5820c9eeb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

UTF supports lossless conversion round tripping and conversions between
UTF and other encodings are mostly round trip safe as Unicode aims to be
a superset of all other character encodings. However, certain encodings
(e.g. SHIFT-JIS) are known to have round trip issues [1].

Add 'core.checkRoundtripEncoding', which contains a comma separated
list of encodings, to define for what encodings Git should check the
conversion round trip if they are used in the 'working-tree-encoding'
attribute.

Set SHIFT-JIS as default value for 'core.checkRoundtripEncoding'.

[1] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/config.txt         |  6 ++++
 Documentation/gitattributes.txt  |  8 +++++
 config.c                         |  5 +++
 convert.c                        | 78 ++++++++++++++++++++++++++++++++++++++++
 convert.h                        |  1 +
 environment.c                    |  1 +
 t/t0028-working-tree-encoding.sh | 39 ++++++++++++++++++++
 7 files changed, 138 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..d7a56054a5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -530,6 +530,12 @@ core.autocrlf::
 	This variable can be set to 'input',
 	in which case no output conversion is performed.
 
+core.checkRoundtripEncoding::
+	A comma separated list of encodings that Git performs UTF-8 round
+	trip checks on if they are used in an `working-tree-encoding`
+	attribute (see linkgit:gitattributes[5]). The default value is
+	`SHIFT-JIS`.
+
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
 	contain the link text. linkgit:git-update-index[1] and
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 31a4f92840..aa3deae392 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -312,6 +312,14 @@ number of pitfalls:
   internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
   That operation will fail and cause an error.
 
+- Reencoding content to non-UTF encodings can cause errors as the
+  conversion might not be UTF-8 round trip safe. If you suspect your
+  encoding to not be round trip safe, then add it to
+  `core.checkRoundtripEncoding` to make Git check the round trip
+  encoding (see linkgit:git-config[1]). SHIFT-JIS (Japanese character
+  set) is known to have round trip issues with UTF-8 and is checked by
+  default.
+
 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').
 
diff --git a/config.c b/config.c
index 1f003fbb90..d0ada9fcd4 100644
--- a/config.c
+++ b/config.c
@@ -1172,6 +1172,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.checkroundtripencoding")) {
+		check_roundtrip_encoding = xstrdup(value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.notesref")) {
 		notes_ref_name = xstrdup(value);
 		return 0;
diff --git a/convert.c b/convert.c
index eec34a94b9..6cbb2b2618 100644
--- a/convert.c
+++ b/convert.c
@@ -336,6 +336,43 @@ static void trace_encoding(const char *context, const char *path,
 	strbuf_release(&trace);
 }
 
+static int check_roundtrip(const char* enc_name)
+{
+	/*
+	 * check_roundtrip_encoding contains a string of space and/or
+	 * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
+	 * Search for the given encoding in that string.
+	 */
+	const char *found = strcasestr(check_roundtrip_encoding, enc_name);
+	const char *next;
+	int len;
+	if (!found)
+		return 0;
+	next = found + strlen(enc_name);
+	len = strlen(check_roundtrip_encoding);
+	return (found && (
+			/*
+			 * check that the found encoding is at the
+			 * beginning of check_roundtrip_encoding or
+			 * that it is prefixed with a space or comma
+			 */
+			found == check_roundtrip_encoding || (
+				found > check_roundtrip_encoding &&
+				(*(found-1) == ' ' || *(found-1) == ',')
+			)
+		) && (
+			/*
+			 * check that the found encoding is at the
+			 * end of check_roundtrip_encoding or
+			 * that it is suffixed with a space or comma
+			 */
+			next == check_roundtrip_encoding + len || (
+				next < check_roundtrip_encoding + len &&
+				(*next == ' ' || *next == ',')
+			)
+		));
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -384,6 +421,47 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	}
 	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
+	/*
+	 * UTF supports lossless conversion round tripping [1] and conversions
+	 * between UTF and other encodings are mostly round trip safe as
+	 * Unicode aims to be a superset of all other character encodings.
+	 * However, certain encodings (e.g. SHIFT-JIS) are known to have round
+	 * trip issues [2]. Check the round trip conversion for all encodings
+	 * listed in core.checkRoundtripEncoding.
+	 *
+	 * The round trip check is only performed if content is written to Git.
+	 * This ensures that no information is lost during conversion to/from
+	 * the internal UTF-8 representation.
+	 *
+	 * Please note, the code below is not tested because I was not able to
+	 * generate a faulty round trip without an iconv error. Iconv errors
+	 * are already caught above.
+	 *
+	 * [1] http://unicode.org/faq/utf_bom.html#gen2
+	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
+	 */
+	if (die_on_error && check_roundtrip(enc)) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc, default_encoding,
+					     &re_src_len);
+
+		trace_printf("Checking roundtrip encoding for %s...\n", enc);
+		trace_encoding("reencoded source", path, enc,
+			       re_src, re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			die(msg, path, enc, default_encoding);
+		}
+
+		free(re_src);
+	}
+
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
 }
diff --git a/convert.h b/convert.h
index 1d9539ed0b..765abfbd60 100644
--- a/convert.h
+++ b/convert.h
@@ -56,6 +56,7 @@ struct delayed_checkout {
 };
 
 extern enum eol core_eol;
+extern char *check_roundtrip_encoding;
 extern const char *get_cached_convert_stats_ascii(const struct index_state *istate,
 						  const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
diff --git a/environment.c b/environment.c
index 10a32c20ac..5bae9131ad 100644
--- a/environment.c
+++ b/environment.c
@@ -50,6 +50,7 @@ int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
+char *check_roundtrip_encoding = "SHIFT-JIS";
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index bdc487b44f..23e89ae623 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -191,4 +191,43 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	test_i18ngrep "error: BOM is required" err.out
 '
 
+test_expect_success 'check roundtrip encoding' '
+	test_when_finished "rm -f roundtrip.shift roundtrip.utf16" &&
+	test_when_finished "git reset --hard HEAD" &&
+
+	text="hallo there!\nroundtrip test here!" &&
+	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
+	echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
+
+	# SHIFT-JIS encoded files are round-trip checked by default...
+	GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	git reset &&
+
+	# ... unless we overwrite the Git config!
+	! GIT_TRACE=1 git -c core.checkRoundtripEncoding=garbage \
+		add .gitattributes roundtrip.shift 2>&1 |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	git reset &&
+
+	# UTF-16 encoded files should not be round-trip checked by default...
+	! GIT_TRACE=1 git add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-16, UTF-32" \
+		add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	# (here we also check that the casing of the encoding is irrelevant)
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-32, utf-16" \
+		add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset
+'
+
 test_done
-- 
2.16.2

