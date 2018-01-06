Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22ECF1F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbeAFAs5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:48:57 -0500
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:45321
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753459AbeAFAsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vfJJj1VZe+jm6SBO+7o4cUnyyqC6mgSBqKrd8O+Co2k=;
 b=gQgIqAOMzgbMKnXEdCnqhGJcHZawJpztGbVvQdGQgT8vQWlSOr0ZjG9fLLpyxJwLtEdpx4axj4SZyHgrYpOgwS6+dxeoWtCAkYbFMA0aW/ICuWiTVEzry+dYT7q2mMauPduDisMdevvHaAytGME9YgITvlspF8tgjT40LFVSwVk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.88.245) by
 CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.7; Sat, 6 Jan 2018 00:48:49 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 5/7] convert_to_git(): safe_crlf/checksafe becomes int conv_flags
Date:   Sat,  6 Jan 2018 01:48:06 +0100
Message-Id: <20180106004808.77513-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180106004808.77513-1-lars.schneider@autodesk.com>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [93.219.88.245]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (10.167.35.16) To CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9acc94d-9872-48f0-ab43-08d5549f41e0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;3:i8NV6C6VcnSbmrDTcKgYI2XFuGtXHSynUVzkYErzbfwmHfHCWGh8/ktJVI/933xzGqo9k5VoNuS+mJt55X0O5L02xyqw+x455XppzYHaPkvryxQULqhh2U4AwcEWcbv6jeJiBZGktGLAKGT0BhYrimbygGtUhAU1DAnQEuv2ffnmDO/MXpd+xnCCGHUk2nrymgCGzBmB3uHmLsnFAlQ3t/gSsbzDKjWaLkxWdch3EPyKwDroep1r4NkQj1t1EGJp;25:qs7lFfjRiXW6LPcmHkMx4ok6Mbg49l3FqsZR7cY87kWJXPaP3SbmfI/WHHC0iFGlWUjF5+yqOENJrBKlZMesmJhxbcFjv56hbEwq2eIcPdoCPb8GQRGE8J8jz6t5BiPBEPXsiUi9RIv68edvlY+/AY0xMYQBQSXzN8McqM1puEktjlMZsAgn2oio4qs8gby4zQgc952kWkYU/DIJjzCs0u6kbfGmYhvG3IywdBtubNYBntzlj90PV2yiZyxkR0tL3fQC3LAmqiDwqiq/01sLMdqH7LN1xuKxZ65/q4fRCCpy4BarNQxTlgFFiXJh59B4N3KAcBQFV2guLFLX91KWWA==;31:0rIjUGhab9BDYqlcw5OVwtRQGx1WfdRw1vTfs+jAxGrokJBWoXjVjQ4M02Uo7WbEKeBqAMGI8d9OJSeh7ggUUPRADJgAQDTncf6Pnl58i28wBJxv3H2Mb1wYbSQWRHpUCBTpeEh376BHVGnpEqKC7AX9dFHBgQPTVuq8Bh3KYv9105HuHpSeGWacKWEE3moURE/hdjp62YPJiPpoVTRnkfhmOtf2lKe4eccv3gUQhQ4=
X-MS-TrafficTypeDiagnostic: CY4P136MB0021:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;20:5HcUIveaA7tNv3sXabzpOGNnwU9QNIz5mVg60jHQwHlC+7OOG2bWjR2s72LMsbhnHn4m/uzZPxQ/lgQu5mOxlbIx1nMUUMCqc5s1E8nnS5lmEEvbb7FyGnRivw86yQaWMIqJAKN8rODHW9kwTKLM2cuaWoRfB2QZvgv5+0wzXLxSE7MYwhhG2MgtPMj6SpbMtky52OW2waygIAIcUCiIc8fMWOaUIOOzAm/W2oKUqnuWsVmAr9JPRExOlc5inYKWOZO+Y6oWMK19cU4sR9RVZtJEfcnRCmFaMaD+YXlNHtzSmK9v3LNwRCkgCFevXU+Ibu2Pu6iJxDzYlVGSXozuNs7WWMp4WdHBgueUqibsyA0At6mZ8z7US5g/1aZDEBc5YG7RgnoEPFj4mzEKz2Bp72Xx6h7uIyzUblsPpKR9lH+/QmNnOzFAauMqtHs8HkLvps1FaYofDKt3CrJXcOApngAsg3eKMfemjysbIkwkFurTsJJLKHjWb4G2s05Xv9FRvevyB8QD6ZRZIMopZZOIhEc17M4LtkqUFLehSb7kUca9TkizTq/IrZRdtP8NWz2zKkjx8jvF17yeYMTmhPdksLIfeXMmPOxKpgbeSkM8pG8=;4:R+bOHQDA7cRT7dOK7xbDYC0HFT5EPPhnPbvQZNlKcso83das5DaQTpzV0yQaKIw6qS91WxmkOsX4m+T9OWfPrn9nFP3BOFO+RT0FhcyD3U7r+M2lbezKmyDHZOu07veUUY0dhU6Me/2mgIdgcdCmd/GPBUd0WKh8yLxcp7xUm/5n6cWWsqdJa5D8g/N7holcmhH6q/IU216aLD0Ujx5iw9TecVJ3lN5ZEJfzTQqIixW9x0ofHhixKv73JQM4JjyFtfvtZs86qF4WnaWTKKq2P1VmPClcLF5WHm4O4ktbU8JX0IEGakfbk87unjUVcrYl
X-Microsoft-Antispam-PRVS: <CY4P136MB0021BC8323E103134B3F931DE81D0@CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(245156298449039);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4P136MB0021;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0021;
X-Forefront-PRVS: 0544D934E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(189003)(199004)(5660300001)(2950100002)(6916009)(86362001)(478600001)(6666003)(50466002)(97736004)(106356001)(2870700001)(52116002)(23676004)(2351001)(6512007)(53936002)(7736002)(50226002)(2361001)(6116002)(3846002)(305945005)(105586002)(1076002)(85782001)(9686003)(4326008)(8656006)(66066001)(33896004)(316002)(6506007)(68736007)(2906002)(69596002)(39060400002)(76176011)(8666007)(386003)(6486002)(53416004)(8936002)(25786009)(16526018)(81166006)(59450400001)(81156014)(36756003)(8676002)(47776003)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0021;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQMTM2TUIwMDIxOzIzOllUSTJ3amxSeDdyRkFpMWRySG90NWx1V0hk?=
 =?utf-8?B?Sm9mRmpoOHdVSTZjSlk4SDZZZkFRdzliRlp3Smp2Y3BjZ2hzSEtBUEEzc3F4?=
 =?utf-8?B?cnUzVVp6Q3BsMXZFcnhmQUhGK3BTM0dwVXp3b2pwWFZCMjlCdXhtdHVoejRN?=
 =?utf-8?B?dmVDSkRJeWE5cUtJYXc1WVVtNndUMkplTzE4a0lTUW1xN2NScC9rYWpyUElt?=
 =?utf-8?B?OWdjd3A0dEN4SHo0YkZDdWkycVJMclVPQmxEeGE4Wm9GWkNkbFhucWVuWUF3?=
 =?utf-8?B?NkV0b0J4cVhhQXk2TnNZYUdVR0xsbjRUcWMwTVNEdkNRZG5sNXBlWGozVWJS?=
 =?utf-8?B?NGplY05wNGMxQ2lBcy9VUUpoTUVuSUhEUGlpOHlFNmVFZGNxSWZzTXdDTTJi?=
 =?utf-8?B?Y2lRQ3YvSU5FenVaR2ZiVk5LMDRjdko5aERiSUZSbkluSnZzT2NaNUYvTGYr?=
 =?utf-8?B?eDEzbjJkY0FKNFBwZWZ5ejJmMGRXVEwydzU4MkpibC9JdWx5Zjk4R1hWMVJI?=
 =?utf-8?B?dWpWQ1JvRDkxMmM3Ums4Q1FsZzdJK1RvM1FKRWJXYkxyUGhqUi8zclFYNnlI?=
 =?utf-8?B?c0E5NjVyZUZlRkhoRWR4NGhkZEdOR0RQbm90V3NHMTYxNU1DZU9QL1dkenpY?=
 =?utf-8?B?VUR2VDBRSDJvY0c1QXYzYlBpVkI0WVBkVGhLRFFERFBBdGU4NGdDL3AvQ3pl?=
 =?utf-8?B?ZjhCZDVRRXhxTi9QZkhmRlFuWTVQUXlaMlZHVGZYT3VLVzA5ZWtabXpRc3NZ?=
 =?utf-8?B?dnZsVHNHQkxydThRdlYzUThrSlphRnVaeTAra3BUZWpEcGNMZ2tiakVzMW1V?=
 =?utf-8?B?ZnMzVC81WmpVSE14Q2E2VHlKM0ZCTnFvTXlmZXFTWUsybXV6Q25JNTR6SVVi?=
 =?utf-8?B?cmNTVVRSRmJnbk1CUWh2TXA1eDBDTGFDTXJtbUhCWFpZMzRod2lZTlBhUlBN?=
 =?utf-8?B?NEJOSUpsck5kSVVvaFc3RGFLZnh1aXMyQW0xZUFISGUvM3llalBEanlHWklT?=
 =?utf-8?B?MStSRXVTNmJrZVB3ZExYMkdBVHROYytkdDNFYXZKcHo5RW1wd2hlNzBWV2Rw?=
 =?utf-8?B?N0lva2U1b2c0QTA3UC9XL3VycDlnWDVLODVxUk9WTWlDWTNBT2toOTdDTElP?=
 =?utf-8?B?QVlBMXduUFFhUzlhcmcxZ01Fa0F3cGlXdVNNaTBuZHpPcFp6TGlsUHE2bEtU?=
 =?utf-8?B?ZUxubzdaWE9RMjBheFdUUXo5bHp6amZSRDFOUmNJZTFPbU51RWptWDZLR2Yx?=
 =?utf-8?B?c1Z2TkFRTFhLcmQyYzlmSGZYMnU1MWd6ZG41TUtsalVsNnBSMjlISCsrbVpw?=
 =?utf-8?B?T1gzN2ZyZGwrK0crNy9mUW5TT2dpVlArTFRqYjdxZldkNXg5emptWFdaeE45?=
 =?utf-8?B?ams1R0lRalZWb0NXc0drTWloVjgxakI5VW1hbFN4RWRXdDcvaWdKSDFvbVlo?=
 =?utf-8?B?dUttdVY0UXc2WVVrTmdTSmlnSm8zVk93ZTlYWmhMaUV6aVVIODEvMHFOcWpO?=
 =?utf-8?B?bGFJbU1tVTNFSVJWbTgyNU50Nk15RC9ydU9JWERyaWZXNFA4ZlVZNUdvWHF2?=
 =?utf-8?B?THZtQXg5R2M0dlRzOUFwVnVpb1JVaDYxNmpYV3BxR0FDcTNjZGxvTXlXTFA2?=
 =?utf-8?B?akd1eXR6d09aNDArMkQwenltbVNFYWlkcEtpNWltbFJWTTZCWmY3YkJETUpy?=
 =?utf-8?B?Vjc2MExJYlMrbnlEclhYd1d1NFlmWU1lWG1rNUdBbm8xZWJVMXZHdFJPT205?=
 =?utf-8?B?Uk5jcFY2dldXTGdzMDRSU3RYMVRYcjdKZ0NJSkRwMXpQZU9DRmRXZmtldUlT?=
 =?utf-8?Q?5LfhflYocoyX8?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;6:NeblDXIztS1cI4oqVr0C7peRciFSVK7iDNu1N4fbaHpvwYwqSHaPk0Bb0avYaXv8iwYiIUzFdnecXzaaXQ6STUMQ91Xz5tz5HBB7/956PYDnLaMXoPJn91+tqBSL1sxW+XMLI7iXcrUAvEfl6Mh6PoEzHfyoCuFBb9QtptJNb69/cFXmsZJEtLqajjNGK5mEXUk9GJDKtFQN4r2IOUqcr0HjmmCSOFx9x/JD3ljWYm9u+uAzJWrdAnoWUoqA02DLYNi8tYUCbTj5VzpPtwCZn3X8tInCjeStZb6qi8n5zpWp27NyTKHIX6/a4Fc+6zPQZeoClmGH7cNtDmV8Lkdt9UhUQ7H+TDpFtdE1mWxp08g=;5:Zj0cyxXmDeXPWubwsSZw9DnfooqVEXY9TI1ZGtk51hWnOR2Stms6dy0Pq9BkkZ7R6KOYblhmpA7S2ITyvQphZqhLj8HFZofqpT0KAIHGXrD1jx2cGUqsvuqe+JtNbpZhzBIzHTq3A+5FfPg4dbNUBGxOGbvvyZ7HkfMSz1acnnM=;24:6A2CrwukMKk3HbFaXxXhWkIWiTRSuTcI0CmYmsxW3GZS/aQ2iQ/HIyiSeot4TFCp22kyGR1eyHQBbjnbu8wcAjbaz3HLhy+PHyOEMdmGiwM=;7:rtmwyFdhRJwzz3WXsDAVC4qH1FgsXnp3e8ugtlJngxRUIvVnKzeeulIegjCe2Td1cegeX52sc1zx2bgfmUbMCnMKm/Q/aikaN/WMIorB1syjvlNeiRFbUktwyy/1r1NddyGOoR4WPvn+pwZot/elFamHVLrNNYs+MOsbSrZsuVLgR/if+AXuN7d72RegVlKtTOnE9gnmKCOPkfLx5Uwnlc5501fEKR91texmwOLo56YvY27dC3DWJg0SWZsYUU4r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2018 00:48:49.9881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9acc94d-9872-48f0-ab43-08d5549f41e0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When calling convert_to_git(), the checksafe parameter defined what
should happen if the EOL conversion (CRLF --> LF --> CRLF) does not
roundtrip cleanly. In addition, it also defined if line endings should
be renormalized (CRLF --> LF) or kept as they are.

checksafe was an safe_crlf enum with these values:
SAFE_CRLF_FALSE:       do nothing in case of EOL roundtrip errors
SAFE_CRLF_FAIL:        die in case of EOL roundtrip errors
SAFE_CRLF_WARN:        print a warning in case of EOL roundtrip errors
SAFE_CRLF_RENORMALIZE: change CRLF to LF
SAFE_CRLF_KEEP_CRLF:   keep all line endings as they are

In some cases the integer value 0 was passed as checksafe parameter
instead of the correct enum value SAFE_CRLF_FALSE. That was no problem
because SAFE_CRLF_FALSE is defined as 0.

FALSE/FAIL/WARN are different from RENORMALIZE and KEEP_CRLF. Therefore,
an enum is not ideal. Let's use a integer bit pattern instead and rename
the parameter to conv_flags to make it more generically usable. This
allows us to extend the bit pattern in a subsequent commit.

Helped-By: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 apply.c        |  6 +++---
 combine-diff.c |  2 +-
 config.c       |  7 +++++--
 convert.c      | 38 +++++++++++++++++++-------------------
 convert.h      | 17 +++++++----------
 diff.c         |  8 ++++----
 environment.c  |  2 +-
 sha1_file.c    | 12 ++++++------
 8 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68d..f8b67bfee2 100644
--- a/apply.c
+++ b/apply.c
@@ -2263,8 +2263,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 static int read_old_data(struct stat *st, struct patch *patch,
 			 const char *path, struct strbuf *buf)
 {
-	enum safe_crlf safe_crlf = patch->crlf_in_old ?
-		SAFE_CRLF_KEEP_CRLF : SAFE_CRLF_RENORMALIZE;
+	int conv_flags = patch->crlf_in_old ?
+		CONV_EOL_KEEP_CRLF : CONV_EOL_RENORMALIZE;
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		if (strbuf_readlink(buf, path, st->st_size) < 0)
@@ -2281,7 +2281,7 @@ static int read_old_data(struct stat *st, struct patch *patch,
 		 * should never look at the index when explicit crlf option
 		 * is given.
 		 */
-		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, conv_flags);
 		return 0;
 	default:
 		return -1;
diff --git a/combine-diff.c b/combine-diff.c
index 2505de119a..19f30c3353 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(&the_index, elem->path, result, len, &buf, global_conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/config.c b/config.c
index e617c2018d..1f003fbb90 100644
--- a/config.c
+++ b/config.c
@@ -1149,11 +1149,14 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.safecrlf")) {
+		int eol_rndtrp_die;
 		if (value && !strcasecmp(value, "warn")) {
-			safe_crlf = SAFE_CRLF_WARN;
+			global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 			return 0;
 		}
-		safe_crlf = git_config_bool(var, value);
+		eol_rndtrp_die = git_config_bool(var, value);
+		global_conv_flags_eol = eol_rndtrp_die ?
+			CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
 		return 0;
 	}
 
diff --git a/convert.c b/convert.c
index 20d7ab67bd..f39150cde9 100644
--- a/convert.c
+++ b/convert.c
@@ -193,30 +193,30 @@ static enum eol output_eol(enum crlf_action crlf_action)
 	return core_eol;
 }
 
-static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
+static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_action,
 			    struct text_stat *old_stats, struct text_stat *new_stats,
-			    enum safe_crlf checksafe)
+			    int conv_flags)
 {
 	if (old_stats->crlf && !new_stats->crlf ) {
 		/*
 		 * CRLFs would not be restored by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (conv_flags & CONV_EOL_RNDTRP_DIE)
+			die(_("CRLF would be replaced by LF in %s."), path);
+		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("CRLF will be replaced by LF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
-		else /* i.e. SAFE_CRLF_FAIL */
-			die(_("CRLF would be replaced by LF in %s."), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
 		 */
-		if (checksafe == SAFE_CRLF_WARN)
+		if (conv_flags & CONV_EOL_RNDTRP_DIE)
+			die(_("LF would be replaced by CRLF in %s"), path);
+		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("LF will be replaced by CRLF in %s.\n"
 				  "The file will have its original line"
 				  " endings in your working directory."), path);
-		else /* i.e. SAFE_CRLF_FAIL */
-			die(_("LF would be replaced by CRLF in %s"), path);
 	}
 }
 
@@ -259,7 +259,7 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
-		       enum crlf_action crlf_action, enum safe_crlf checksafe)
+		       enum crlf_action crlf_action, int conv_flags)
 {
 	struct text_stat stats;
 	char *dst;
@@ -289,12 +289,12 @@ static int crlf_to_git(const struct index_state *istate,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		if ((!(conv_flags & CONV_EOL_RENORMALIZE)) &&
 		    has_cr_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
-	if ((checksafe == SAFE_CRLF_WARN ||
-	    (checksafe == SAFE_CRLF_FAIL)) && len) {
+	if (((conv_flags & CONV_EOL_RNDTRP_WARN) ||
+	     ((conv_flags & CONV_EOL_RNDTRP_DIE) && len))) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */
@@ -307,7 +307,7 @@ static int crlf_to_git(const struct index_state *istate,
 			new_stats.crlf += new_stats.lonelf;
 			new_stats.lonelf = 0;
 		}
-		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);
+		check_global_conv_flags_eol(path, crlf_action, &stats, &new_stats, conv_flags);
 	}
 	if (!convert_crlf_into_lf)
 		return 0;
@@ -1120,7 +1120,7 @@ const char *get_convert_attr_ascii(const char *path)
 
 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, int conv_flags)
 {
 	int ret = 0;
 	struct conv_attrs ca;
@@ -1135,8 +1135,8 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
-	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
-		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
+	if (!(conv_flags & CONV_EOL_KEEP_CRLF)) {
+		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, conv_flags);
 		if (ret && dst) {
 			src = dst->buf;
 			len = dst->len;
@@ -1147,7 +1147,7 @@ int convert_to_git(const struct index_state *istate,
 
 void convert_to_git_filter_fd(const struct index_state *istate,
 			      const char *path, int fd, struct strbuf *dst,
-			      enum safe_crlf checksafe)
+			      int conv_flags)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
@@ -1158,7 +1158,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
@@ -1217,7 +1217,7 @@ int renormalize_buffer(const struct index_state *istate, const char *path,
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(istate, path, src, len, dst, CONV_EOL_RENORMALIZE);
 }
 
 /*****************************************************************
diff --git a/convert.h b/convert.h
index 4f2da225a8..65ab3e5167 100644
--- a/convert.h
+++ b/convert.h
@@ -8,15 +8,12 @@
 
 struct index_state;
 
-enum safe_crlf {
-	SAFE_CRLF_FALSE = 0,
-	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2,
-	SAFE_CRLF_RENORMALIZE = 3,
-	SAFE_CRLF_KEEP_CRLF = 4
-};
+#define CONV_EOL_RNDTRP_DIE   (1<<0) /* Die if CRLF to LF to CRLF is different */
+#define CONV_EOL_RNDTRP_WARN  (1<<1) /* Warn if CRLF to LF to CRLF is different */
+#define CONV_EOL_RENORMALIZE  (1<<2) /* Convert CRLF to LF */
+#define CONV_EOL_KEEP_CRLF    (1<<3) /* Keep CRLF line endings as is */
 
-extern enum safe_crlf safe_crlf;
+extern int global_conv_flags_eol;
 
 enum auto_crlf {
 	AUTO_CRLF_FALSE = 0,
@@ -66,7 +63,7 @@ extern const char *get_convert_attr_ascii(const char *path);
 /* returns 1 if *dst was used */
 extern int convert_to_git(const struct index_state *istate,
 			  const char *path, const char *src, size_t len,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+			  struct strbuf *dst, int conv_flags);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int async_convert_to_working_tree(const char *path, const char *src,
@@ -85,7 +82,7 @@ static inline int would_convert_to_git(const struct index_state *istate,
 extern void convert_to_git_filter_fd(const struct index_state *istate,
 				     const char *path, int fd,
 				     struct strbuf *dst,
-				     enum safe_crlf checksafe);
+				     int conv_flags);
 extern int would_convert_to_git_filter_fd(const char *path);
 
 /*****************************************************************
diff --git a/diff.c b/diff.c
index 2ebe2227b4..fe3ff6e876 100644
--- a/diff.c
+++ b/diff.c
@@ -3516,13 +3516,13 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 {
 	int size_only = flags & CHECK_SIZE_ONLY;
 	int err = 0;
+	int conv_flags = global_conv_flags_eol;
 	/*
 	 * demote FAIL to WARN to allow inspecting the situation
 	 * instead of refusing.
 	 */
-	enum safe_crlf crlf_warn = (safe_crlf == SAFE_CRLF_FAIL
-				    ? SAFE_CRLF_WARN
-				    : safe_crlf);
+	if (conv_flags & CONV_EOL_RNDTRP_DIE)
+		conv_flags = CONV_EOL_RNDTRP_WARN;
 
 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
@@ -3599,7 +3599,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, conv_flags)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/environment.c b/environment.c
index 8fa032f307..888b873f90 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,7 @@ enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
-enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
+int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/sha1_file.c b/sha1_file.c
index afe4b90f6e..dcb02e9ffd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -75,14 +75,14 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 }
 
 
-static enum safe_crlf get_safe_crlf(unsigned flags)
+static int get_conv_flags(unsigned flags)
 {
 	if (flags & HASH_RENORMALIZE)
-		return SAFE_CRLF_RENORMALIZE;
+		return CONV_EOL_RENORMALIZE;
 	else if (flags & HASH_WRITE_OBJECT)
-		return safe_crlf;
+		return global_conv_flags_eol | CONV_WRITE_OBJECT;
 	else
-		return SAFE_CRLF_FALSE;
+		return 0;
 }
 
 
@@ -1694,7 +1694,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(&the_index, path, buf, size, &nbuf,
-				   get_safe_crlf(flags))) {
+				   get_conv_flags(flags))) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -1728,7 +1728,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 	assert(would_convert_to_git_filter_fd(path));
 
 	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
-				 get_safe_crlf(flags));
+				 get_conv_flags(flags));
 
 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-- 
2.15.1

