Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2B51F404
	for <e@80x24.org>; Sat, 24 Feb 2018 16:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeBXQ35 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 11:29:57 -0500
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:55968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbeBXQ3l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 11:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OvGirbqcQWXbs7ZcUe6+SmRyyCR/dMAqSCo1ZMEtjto=;
 b=qUfs/SVryw49mS/b93iKY3nAdH+C9/uTsqGcN5JxP/bi8cvdyk9qllNCIKeCDx7oogqG0XwXkloBvL+sjDQDywSNMMS3BLNJmlV/pmwXgXYzNcu/xF7g4/pyVdY44SAihLe049GszDhsxYpIml8/nWo7ldJuspUloMwQGNIIU2s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.26; Sat, 24
 Feb 2018 16:28:49 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 7/7] convert: add round trip check based on 'core.checkRoundtripEncoding'
Date:   Sat, 24 Feb 2018 17:28:01 +0100
Message-Id: <20180224162801.98860-8-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180224162801.98860-1-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CY4PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:910:16::13) To CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9420758-1a6d-46c9-efae-08d57ba3b087
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;3:18lqBOfEb5+Lp5PFZqcVry9kOnS+wjcdhSwNecLIsWphKH9he72OEJ30sIY1xMRQsQ0L5DQwobq9qI98CI15p9YWYm//C+8cv8mRYk3PKFf0Jr8d4hls8lytMSu1yLjl2jjLr325RFnlY5/oiN8sPyxP5FSwF7j/y26BywuBSDQabMRp77yxwtVfyC54UoWEU4pkwk9r96dlW5qGI2+/Prq0i3O0pqbfz5j1x/Lw4SxQ0PBID6ONBJHOfhxyNFeQ;25:R5i7CqeCY/qB9z9035/YMZYNELovpP69yAfU+LG8ImOmfOvncVZmJ2xSpkAOV07FMTYNfWcPj2ANua7z1Zb5MkIbtbC255yVLQRK4twMB9Yi3B5uUmUkvexwx6ZOLjvJFgeIbtmnCDLFNjWbD5B2V0kgrDeSEZB6E0WN4hyn5xPVDDEPYdq8esmOt+3+QXW1SYlW0jD7QtHJ4JxtfF7ZfVgwi4SBRlFz5Izmk83dJOsvaMQGUyissA7MLDxsH0n5pI+i4JHRMqENQFAyp6HleRcA7wxTcMuFTBzswtSr+aaPxTZsp8qSbdR809KTxokuzfpT1tW8vSWI5aXooPWs1w==;31:1mqJvkg37psYidZkSGuy6gvFm2BhsBimg+KKpd8D++XJh/V+SwPlTpH8f6kerPWFkvPrfItfgulJGng01TsC9BTxBIuydZ26Lho79Quyu3yUmb5DKNH8BSKKMN7FbvCriEW8N5Aibg0w4aJW+m60MNwspttLhSbAziOjnOn7zz1dhR2SjkwkUfFJQL2vdXSogyAfWOf/51LfmZrLKCUwgNtDKVXx+Hy3hnOVd/3gIMs=
X-MS-TrafficTypeDiagnostic: CY4P136MB0007:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;20:jVMKhnf2cNnxz3kwg5xbY+tk+lM6udTRcpy6Rq6mncd1Spg28BQdDuvBfyV+r77KqEgxjZmXo2Iw9Bqw/t20+FcgCYvAZHLlWp3otxC40j5VLZLwvzjSlqtCbakLyeg417yfnHkzzy9g58l6FQYg36hrCxCHTz+wIToex/69kCbfVYv0rzeWLWMfmc9brtUC832iNaEiyMRoFKgw9C7O9W3HId3Li6KYuPZNrsxSp+XxqO+DxFy4LU/fQhafXZMEDGN5DyBA+hLiUIgI4EwAWukWkRBv1l4wPU+e6A0iA6ABraqni3Ce9ppyidCKsjdPxbiOJ9TrCHUDka/2EGlMMYQ10tDAywPsSxlYGWZXnKpYBri7BtTz76opKBelNYn+PzPsQ0o7w8x1jxehJI5ZuRAcB7BgDfFLnYmsDnhT8KjjzWNSw6QHSGbRRkK+lMgwy15g35VV1iugJxuh2R5Y3mkcN2io8q5GclesKc/NbgG6FD8tUMGMedIdH8vdIl7DGLJMpo5k8AoV/CusKRXkgzH6UN8uWbj1r5vNxPY1ODmTL16QMIovCS5ujBmIc5iz3Lcp2gqedBvU/UGHn/QUWA91/wMK5vyLZy5srdJ2cVA=;4:Z5NXZE3dMFrfsQYNtBLUy4YFxw6ElRDxrf1AX9rX6t55lGPaYpHSqeJoBJvpWpL8TSmTFVaQ60f/GKKPWIMJzmH0h7XMOtGrEl2H7E9mOBdXm8HTwKTtg9kwX6Uu98rwXgC7Rtfpgu+E2loGZFFmNdUDmix3e1BmXhsGllQu4xgcVlMadJB2KwlaLg8Cn0q3+LRkOfB9F0G7fKGlg2dB+PVCxJcbE/jJe0Q913zf1Cqaird6ItfXMnA18IzTIS9oHUdjukRyCvGwWldy75segQ==
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY4P136MB0007;BCL:0;PCL:0;RULEID:;SRVR:CY4P136MB0007;
X-Forefront-PRVS: 0593E261C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(366004)(199004)(189003)(53376002)(8656006)(5660300001)(7736002)(66066001)(50226002)(47776003)(97736004)(8936002)(6512007)(9686003)(305945005)(8666007)(6306002)(6486002)(106356001)(36756003)(2351001)(2361001)(8676002)(81156014)(48376002)(68736007)(50466002)(5890100001)(85782001)(16586007)(33896004)(59450400001)(6506007)(386003)(105586002)(86362001)(26005)(6116002)(3846002)(1076002)(16526019)(186003)(52116002)(966005)(2950100002)(51416003)(39060400002)(76176011)(6666003)(4326008)(25786009)(6916009)(575784001)(85772001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0007;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0007;23:7LeoKuy/+k/XHKxtH3pfISZTNPpTZqMK3ZajFq/Si?=
 =?us-ascii?Q?4Aay+KiIaHleIWNvUKCJETEWfSPuyiMic3es6nRgesRivcaggnpGGAkRZ7Da?=
 =?us-ascii?Q?05UYfhI7h0IoriPr+Rc/V/0HRDhe8ZtOM6n/QuJg7/uORTHp1sc5ViG/w6DZ?=
 =?us-ascii?Q?wCDG20TyG9mXXPTTF9VA5VVRbocjhA9uoRO76ylCqPPLZKovAY1TOwD6Gy5D?=
 =?us-ascii?Q?2x2kNUPnwXP6cGzN94TudA9LABOtxlpOSc/MQSfRcPix+zq761aDdWpBj+fv?=
 =?us-ascii?Q?QftQl2m9O8qG/20Q/JLbTQKvfPHlryt2/xG/y7DYhIvZhVRu4PiL9iVk9H6K?=
 =?us-ascii?Q?uOHr7N/ywdIonNotlUSP3ZLTRpMwlC4TPxXD4B+05AeurR3JlDHja89OhATp?=
 =?us-ascii?Q?Att++JPCIzCRe9W+AD0GL9mINmnDg9PmftU85ERXgIjdeQOLLld55EODTH5y?=
 =?us-ascii?Q?vOPVoY8jOAMhhiiGwepjylyO21DtlFqkXOpocLQz5UBjAOS5R1eQCypuSlLP?=
 =?us-ascii?Q?qgGcxfEn0XF9S6pU4ViJBR93cxLExngBZz5YWvzO7nXGTzRSMvuO5+6n0obe?=
 =?us-ascii?Q?PSBM4OaUhAc/9/Su5GuMfAOVPM2nw5ML85CxLOjKaPYjkf1n4Q7FxmKWNOJz?=
 =?us-ascii?Q?/7ODUpCk6US1TK3RgFHC2LnobTzxEXCyK3abkG82lZe5+kU8fn3H43SobAbl?=
 =?us-ascii?Q?va9jSP0oY/sax8XN7Vodi+p+chiBrsV1SwwIHjUjTFa8+nfRY1xuUxJO+mEh?=
 =?us-ascii?Q?OCO6g3/46MykPMJRvYxjvWXVKbTZOwCyxfim35jqa9Mq4iytC4VGcTZPRZNA?=
 =?us-ascii?Q?hqqAtR1WmfLR3NMd5UldQrDS/7z5Kl23AffIZLPVDHpAxoaserI944O5/PRq?=
 =?us-ascii?Q?e6hYIVxKBmhs79VQxuaAKk85t9XuZr9fvXKDOCKNF1CJ8mvqan9m6AxaoJvm?=
 =?us-ascii?Q?kLiGwmqoNTq9RewlkUELOsDy6pImSsfetiZK/4AEP2U8LCuvyby1mE5Z2ni9?=
 =?us-ascii?Q?+4ZVKWrrfHAXQVvpBVxaj8CM/69WV/ohCFtox8UNrMvQa/ohjwq2HPnyABwi?=
 =?us-ascii?Q?Wgxu5vOOcNRF88FXefAeucnsRyo987dgQ4ZEM16RwNGgYBfqbdcbvULVsTal?=
 =?us-ascii?Q?Z1FTWcSwpJu+12czyW667TI/dxFziKO5+sQic2HfBaWsEqx7+2NQetpe+/3a?=
 =?us-ascii?Q?GEiNqDlnMwF+BPsU4XdBoc2vtGY8zYIh89l7oHwowrDbArgfMOUviW4oxbXV?=
 =?us-ascii?Q?wVOn50Shy/LpdlfZCEM4RoHhXpQ9UlPvt+mkzHEexh8iDw38uG5S8tDCH3ZO?=
 =?us-ascii?Q?eLw6UsowXegPNsRofRjRAKpIE+sSSG+6tcgVWZCfekS03E0Z4OkyBAikPNX4?=
 =?us-ascii?Q?nA/eA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;6:2ehxLOdX0soI7H6qpkzvp7fIN23Fej6z7AXbkPpUoj+PptZaQG1Edp+NwXZ0HOh0MDIt370Mb9faYUqmdubO17v/kdRWjAAEo22Aejtg5R50hIIec0gZeHrE77gCPmVheV1d6Da/pHiP7ddVufRQ8j+emTkSa31q//oE5DPBRhk6xgLFMTW9ARugX4HCLRXjeK9BeTo/WWi+4Gmgivxwvt1U4U7Mjbk0LRF6BWDnvCcQOr6RWQIfXXKGumQdzQ9521Ayr/sUPyzeDXoHTI8W2CQstyglZskTF95yCEdJ7lPyrk0Nv9HjLkAdEGFSEFT3Dtr4TPwHhz9Wv3iX1gtRxXRaRQgbCiuIcKgvLvjxM0E=;5:JQNlFMlNKIKYmvxCF3dGamPVRZM/WFxnqxnd27EfiF1+AomCliMRBVDCiYYbV1IbvYGNotGCxu0LLaijES+lw+UEfjnFOyuob7nzVJeuS2jsUc0Fv/cxbpbg43E441ZqUvL1/61PG3F2x7kZSKtvuiHWEVap/t9S5Zdb12birWA=;24:tGCB3jHJf/KROCt2Y9Q2+EwlQDw/2H7dqP+y9OCJw73WKrRE3aGcFCNWUpJV0iDofPeS5BtHhyLxjMrZ9VY/Zh9RE5YYj/em7oZ7si7LeJg=;7:O7LvK38bIO5j+RU9hTGcGvoUpaM1aKdHS1jbcOuXdvfwU5/skmxMdp3iuVT+aod/9x3ea2PC3a++5QrZYNkjla239LOd8+oMLgHxFXvDXg89HqZ0s3oc7dP92Ai60aRsmt/TIiU/O5oSwQXkMxYtqvseqWlIDGg3qxwoxqBxN74SiFfgk/r9xbObRElD7aKJB0Vujr63WutW/92mgJ0+veL3FwIm//K5iDV/BAh6aZxOWhD43DXzplEpuCCXaWLT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 16:28:49.3596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9420758-1a6d-46c9-efae-08d57ba3b087
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0007
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
 convert.c                        | 74 ++++++++++++++++++++++++++++++++++++++++
 convert.h                        |  1 +
 environment.c                    |  1 +
 t/t0028-working-tree-encoding.sh | 41 ++++++++++++++++++++++
 7 files changed, 136 insertions(+)

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
index eddeaee1f7..11315054f4 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -310,6 +310,14 @@ number of pitfalls:
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
index c4e2fd5fa5..398cd9cf7b 100644
--- a/convert.c
+++ b/convert.c
@@ -289,6 +289,39 @@ static void trace_encoding(const char *context, const char *path,
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
+	const char *next = found + strlen(enc_name);
+	int len = strlen(check_roundtrip_encoding);
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
 static struct encoding {
 	const char *name;
 	struct encoding *next;
@@ -366,6 +399,47 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
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
+	if ((conv_flags & CONV_WRITE_OBJECT) && check_roundtrip(enc->name)) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc->name, default_encoding,
+					     &re_src_len);
+
+		trace_printf("Checking roundtrip encoding for %s...\n", enc->name);
+		trace_encoding("reencoded source", path, enc->name,
+			       re_src, re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			die(msg, path, enc->name, default_encoding);
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
index 8666669b2d..e34c21eb29 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -225,4 +225,45 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	git reset --hard $BEFORE_STATE
 '
 
+test_expect_success 'check roundtrip encoding' '
+	text="hallo there!\nroundtrip test here!" &&
+	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
+	echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
+
+	# SHIFT-JIS encoded files are round-trip checked by default...
+	GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	git reset &&
+
+	# ... unless we overwrite the Git config!
+	test_config core.checkRoundtripEncoding "garbage" &&
+	! GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	test_unconfig core.checkRoundtripEncoding &&
+	git reset &&
+
+	# UTF-16 encoded files should not be round-trip checked by default...
+	! GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	test_config_global core.checkRoundtripEncoding "UTF-16, UTF-32" &&
+	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	# (here we also check that the casing of the encoding is irrelevant)
+	test_config_global core.checkRoundtripEncoding "UTF-32, utf-16" &&
+	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# cleanup
+	rm roundtrip.shift roundtrip.utf16 &&
+	git reset --hard HEAD
+'
+
 test_done
-- 
2.16.1

