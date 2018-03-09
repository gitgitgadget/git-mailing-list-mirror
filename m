Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CBD1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbeCIRhK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:37:10 -0500
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com ([104.47.33.118]:2112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932480AbeCIRhB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AHTyyt84V3bmeacTSZljnxKvdoXdbm6ECq9M5jTMAEY=;
 b=H1hv8/MNrGJViI0KaC2BpmYsWzZfS8Q6yVhaSZUyxTdvs8dO5Ocw+7q9S6ICwroZdoWf2e/9UrAwohedRvd3rgFYNcOEnCeI3sVazaJKwBFLp8+nN5rZs35zX39cO/bJ73+H+b3CEHBL5kgIBk4G/+XioomvWH6kD2b9D8RkI8Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:36:25 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 10/10] convert: add round trip check based on 'core.checkRoundtripEncoding'
Date:   Fri,  9 Mar 2018 18:35:36 +0100
Message-Id: <20180309173536.62012-11-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309173536.62012-1-lars.schneider@autodesk.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:104:7::21) To MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bdbc4d63-7dcd-411b-42b4-08d585e449f0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:UA8Yna0ZbLdfoLMt3rGCGH1EVpojdIqIcinDPTcvFX4ZthzjidkOoCzMwucdbTTVy/kM6RmxSoZeVCDyX5UZqjSTjmkDBYEQp/BYEvR0/5EkhVTmqsegCwT5mqSfZ19rOvgq5KGGpQsYpxMHFFTBtCajeD7+gBee7EAGbnUPZqG6rYMYzQtNlflH3DeQrw+DWjHGzZcKj2j/ocSxu59uiH0CYx2fJPmW3lz1rneO+38U4Z46aQrmC3qSlQBFpbw3;25:RKfkWabD2hyo7WvgJnFQoZmZGbq8wsLuO1H8vLcWwU3FC5hDMgQn8J9cRLd4Aaxnb8OF4XCAwuUUC0q+IxX3szZwBMth93XBWIl050gcBPAemyQxlBlspPfz3x+i9cVcahbknxOrFkQeKWBsoy9lKLGm+FEsaRW+PshCbBLc12XaT9wvZMs3l3JULbAgUetC84Vv7K3iE/30p3NT7Tmlg8F9LwbBItf30HUtTDW1Z0kK81sThQTVT4BJhgUeix0jt4SWpTYRcPg5OxacC336n2II3X3KbxO1+rX9izNGijOw00RV3mq14i8v3pU5kz8J6aP+Ehand+VcwO8EtezCkQ==;31:rSNJzctX8wov8Uu8JRdGt77yezd9dVso31V3ldgMZOY6O07QwoD2X1QxypYIHA0mzhS52SpMyT8L7PvEgAXKj+NvRG9qtuYbDRXZqOYDA1lQ8KmHWjzDpgizlipSM5FVF0jdnNP9+lClMCBoZjZ2TDZsdXdNBrHf4/4iknJl0NY2t0E4OyX1aRIIOFhfgPl3NZN0sM8NaFN14AVlay2ktPlsV0QWZT2HNcUif+Wac/4=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:QyLERJdYgDlG1USvuYLNHcpYFqQ/TuxE89DUuhaZxTeRFPgdSIJi0J98EXHZ5Qd88QLqJMTECvWb5IG2Y3SKR5jhpuZYxepwBdrTsgOLNuOhhV7gsSTcJaD+g6mpXr1Ggbqv2GLGGnmMHKVEkFankXTZ8wvfuUoKsvD6UYl6HAyppT4zYwBmc+0mx3zkD6z4xbRG2R5bgukRn8HycL8P+1akTORBkzWGL1Im1T1AgEQEq1xHYcdqM+rZ8viXh5WmsDGGnhn3BrusGRdiZLRvxGFqpWZ7KUZIFwSqELaSrlqXNVneGi1WbQYBjRFT1MqDj1Jwc8+o+V3v0ZDxpDYEABUvZuOzUpxc00X/HB9AsffTQmKtruRgjWjbq5C6Otk1DYHs5Y8S2o3tsMlfk9B9WN4gZpN86N8txGH5wfB6nHjIl+kyZZ3csKjEEd1645yVopTkQr+siskoQs9UccZUIiMyZPlib/YFYH2VD6rUW5E9jUIucZ/nOzp4ivW1/Fb03+01tBT9hNSseAoynjB1ei+iNp+RPvHavG4A/kNRpQyOLPSCx6BVfJOB4ertcZ+uvN67i0wR1zakT0IevHUHszlicke+m3f743PpJ7odVfo=
X-Microsoft-Antispam-PRVS: <MWHP136MB0015AB6E5DB703ED45FF3815E8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;4:M+syR/cexl/FxjIpRc3kPNyQicL8ZwpwiywCjZedQVrnbIU51//nIizMUnlbclLOjIbzZgbNMeRtPOI308iZB0QyxIZtknf5lylIqTiMisxOVVAfIBPy4vWt2q1/sjqckbYjNR0n1EqcmN7r9IrGiGTdOGNdLj0kIs4wWKF93G2wsZKWJ6IIcuTpLGyUu2GV61P80wXx2208WalsqAzofiPXqpYwX2yumJYJgyEHBB+Z5xhWLquzemmizUeTHftC/h/bUniKtrY4cQEAhy3qeE9qHkDumeLn9KQclJbouOAXyoHiFoO5uNHbZpjU36NDFjnLu0FmNnML0aqG5byy7KIA1m2HSkkMGj/NjoA027g=
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(5890100001)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(59450400001)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(53376002)(6116002)(86362001)(575784001)(26005)(3846002)(85782001)(316002)(9686003)(6306002)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(966005)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:SlmK7LaPSFqxBf0lwmZH6L8gPwUDrrXasYm5Brztn?=
 =?us-ascii?Q?CvLMHw7wtxgwjqgmONUQdNDBKnbdd3DQXAw+UM5BxcS5u6brfBgP7K7smbnt?=
 =?us-ascii?Q?S937a10zu2CA5YOi7whjrg8bqPvcSN8BDeWMoY+D7N1BBWnlktlWGxK3DsDZ?=
 =?us-ascii?Q?5lS94Pp6GSYJv9TrNVc3+MD2/9zZevojCU+Tfzh4mgqPQ11jEhg7oImkEGzI?=
 =?us-ascii?Q?Vgkmnc3gxyAOTuR+LCFUIUn/oy8whW+7M9ltlWOlsVzOvEBz1Ug8ROO1ARUL?=
 =?us-ascii?Q?a/V6NOjHrAasOIz1RWFavLB4NI84lCQGdwcUPwCGefAnsKkLC5dzWBRXCs9/?=
 =?us-ascii?Q?yLc9XV2iJpjiLP+1pZnrpxEmsV34xhf721IMUinwovmlb00XiSz+6bF5oVQU?=
 =?us-ascii?Q?dTMwLA1jXbS8YWFhVbPU48ZCh80w3NMg80EMypBMUJO9jphZ9xt8WS+DtuVT?=
 =?us-ascii?Q?5zRF2uyeRPnLZ4vXNIHlzuIv4CDV0jK1zOBxB2YsEWGV0jYjgvzUF8uTxZBr?=
 =?us-ascii?Q?9rJApYcyh5Bno6q8KVKrmlN7xBusSRtdeLNh1am7nxFp0z8a4dhWnAttPz2j?=
 =?us-ascii?Q?Q5XKDe1nQ9J2hm+6i1ZKgu3976tMXpSUZEC0+ZRxzpY1IN8B5L+NJrvxRs7i?=
 =?us-ascii?Q?ujxNko1ECheGpeECVGtz7cuiOtaJe54B4Af8aA3OxFoXnJ2RNWzYLCma58/p?=
 =?us-ascii?Q?d4rK21vp6Glsgpmbr4ovBKPEFNrT8DEHN6PsYuBEIkQnv73Q4laK/TBIzrNZ?=
 =?us-ascii?Q?waDE764mrS/K9dTfJNXBcEr7Oh8vnYdqOVIc+thbl9ygky3PdyZZd5PkynRo?=
 =?us-ascii?Q?dOL67+qaY8W9KV5uKdxnVCqf1Ucl+cVXCS+QjFsaS8I7x7fbv7jBaJcwIgDt?=
 =?us-ascii?Q?DSNzIBl8msz23AhU8T3QZUrcutIFID62rc88nBgqooCnIteQ6x0zXURqOK0p?=
 =?us-ascii?Q?iZDUKUFhbozxQQdAaSIWQ8lX1zlvpevZX4Cvp+NVxWT2jaZmHU31unAPUg5R?=
 =?us-ascii?Q?/Ig05HFMMDbceTiT+TXlRFlzioYPJ1o+qshNJB9C8cWw9u1Dc7zpq6AeAgdB?=
 =?us-ascii?Q?OklgevQDPb9pvxgezZOdevja+apDgJbDHCjb8zybm9JA7sp2F2B7+r0CXtDz?=
 =?us-ascii?Q?rXSuxShAh3VRYVl67W082qif+iOpc70nRqsiqr0jgv+3b+oWuIZKGb40g9Ks?=
 =?us-ascii?Q?j9O2qrtytrOp/l207veiCU9xkUTGjgm6OkfLYqxM1VBBjUumslphRZSNb4DB?=
 =?us-ascii?Q?l1NSZV5iNfYbW7u5ThRCfpqJzde9UXWL5qjz88QJAlNQQqVWO7llC71CxUjT?=
 =?us-ascii?Q?2/fOgdQwbxBSnHbnEbOeQxSnOwaOUrPjfUXLqKfP7XVjrVohK0UK+hyb+uB/?=
 =?us-ascii?Q?xTf0+z9EL8G3l0fS0G+swd2NPZ2zBzqUgoZJDVdxn5ON+OUak9bKSpbA8dTY?=
 =?us-ascii?Q?xL/rVHEfA=3D=3D?=
X-Microsoft-Antispam-Message-Info: uDb9Ver0k/XGVKL5ck1twXKkziTaCShkZqAo7DrF1NLyTk9Zzi8F8wawAK6J99imZyRmJdhq98ETVbdDRxADeCKKezCgKVyToqybzLIXxxmjxrHCg2xGkXt1CDSbHIaF9KSCJuZOqOarqMmz9Os/RSYtRVsLJrU+UR7ccWr9gPs0b1/no4qskmqEORu1xbd2
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:AYvMEeXSdi1EEAB4QVcPNax5lHq4NHkfE3YH0a5EyGoNR+R8gmtq/gA0lbSAxw4y9yqOtT2tg68+CAE+tngUw1LSntPAE8I2LYABhhzpbAoY2zMfJJ9MAJoV1g5TW43O2LQ4zLnu47A8N0unlruICxGcXQPET+kgpISwSgYs6T5FJ7p/bmHyGA+LZlPTW2rhN9dbdrSF1N8wrciWi9Aoi/eLkybHbqv2r9w4CBgTLfE52oAgQzeS0R8hSZYSnXAMQwW/p+y3zoM2dcRoWlp+1dD0DDsChMaLvMB8LMhCHaUCCx2zgaav8oooB5l0Hu1OB1s4Hb4gTVNyz1m0rZDoIxecIOHy6+D1tI97y1RDlrw=;5:/uoKK8vG76zqOcebRsLibL7uUyaw6inLi8TlQcz4QdhW08FjcTbgz4t0MulPwcNNaC4/1ep9Y3sG7xZcDGNUYC/j6VH9YvDKqd+E/xrGQEDh5cmV8KvIMHVzMaQD6BDlSGU0HkBmPHnpepUFfByN3DpfkgGOnvW87WlMRzIvR+I=;24:PwTo+TIr/rEBsX7rlwCl9VemjtKdfM4I/OD9ZGZxZjz9NKjk/bq8Nfoqrk1sHiWhIWgo3FIB2J3MhqpCSPftUybIxbug2wtI+NQNI0Fn3iI=;7:SXKeMhcwCWasUDuOnXTx9mL/rZ1a3flkomaXCXRbEwXdQevrL34afzi7s80AjvRIADpPtcfcyZhejyHGpF7CPgwqymyYmIkPZbP6SFNZK9Bk8pyso/x8XhxrLv+Ct8dGt/tOuYBKNZ3QYtaz8xUT76OZC3XdF5yltFVmBHPNEvm95k6hyw4TN4/T39cIPG5l4aMtuRWd357Kfy97eSNz3IwhQIbvWT5ictsiNb2Td0qkFyD+X3EHtCQIC3QP+AyB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:36:25.6688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbc4d63-7dcd-411b-42b4-08d585e449f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
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
 Documentation/config.txt         |  6 +++
 Documentation/gitattributes.txt  |  8 ++++
 config.c                         |  5 +++
 convert.c                        | 79 +++++++++++++++++++++++++++++++++++++++-
 convert.h                        |  1 +
 environment.c                    |  1 +
 t/t0028-working-tree-encoding.sh | 39 ++++++++++++++++++++
 7 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..7dcac9b540 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -530,6 +530,12 @@ core.autocrlf::
 	This variable can be set to 'input',
 	in which case no output conversion is performed.
 
+core.checkRoundtripEncoding::
+	A comma and/or whitespace separated list of encodings that Git
+	performs UTF-8 round trip checks on if they are used in an
+	`working-tree-encoding` attribute (see linkgit:gitattributes[5]).
+	The default value is `SHIFT-JIS`.
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
index d739078016..c2d24882c1 100644
--- a/convert.c
+++ b/convert.c
@@ -347,6 +347,42 @@ static void trace_encoding(const char *context, const char *path,
 	strbuf_release(&trace);
 }
 
+static int check_roundtrip(const char *enc_name)
+{
+	/*
+	 * check_roundtrip_encoding contains a string of comma and/or
+	 * space separated encodings (eg. "UTF-16, ASCII, CP1125").
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
+				(isspace(found[-1]) || found[-1] == ',')
+			)
+		) && (
+			/*
+			 * check that the found encoding is at the
+			 * end of check_roundtrip_encoding or
+			 * that it is suffixed with a space or comma
+			 */
+			next == check_roundtrip_encoding + len || (
+				next < check_roundtrip_encoding + len &&
+				(isspace(next[0]) || next[0] == ',')
+			)
+		));
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -395,6 +431,47 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
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
@@ -1150,7 +1227,7 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
 	}
 
 	/* Don't encode to the default encoding */
-	if (!strcasecmp(value, default_encoding))
+	if (is_encoding_utf8(value) && is_encoding_utf8(default_encoding))
 		return NULL;
 
 	return value;
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
index f68e282c5e..07089bba2e 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -205,4 +205,43 @@ test_expect_success 'error if encoding garbage is already in Git' '
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
+		grep "Checking roundtrip encoding for utf-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	# (here we also check that the casing of the encoding is irrelevant)
+	GIT_TRACE=1 git -c core.checkRoundtripEncoding="UTF-32, utf-16" \
+		add roundtrip.utf16 2>&1 |
+		grep "Checking roundtrip encoding for utf-16" &&
+	git reset
+'
+
 test_done
-- 
2.16.2

