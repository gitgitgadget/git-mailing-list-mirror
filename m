Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76B51F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeCGRbo (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:44 -0500
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:59904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933641AbeCGRbY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bb0a4dkW48jJGmMrgqDe+dsaQPr4A0Dtz08fRhM/OMk=;
 b=Q+/ofV//cDlqtodkTp17cJ0gd0v0aik1XFqfYyDhl9glqco1ywbtC3mnPWZdwYDlFb/QC2LfCnPOF2jQVXw73cYGNBrRVKMZRjMEY+esLScSmPW+pKBTFSifI7Iz9lXDVR2VB2BhHgu4/RTnO2qrxIroCyJtdVjNidgQ4dDxwcM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:31:16 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 8/9] convert: add tracing for 'working-tree-encoding' attribute
Date:   Wed,  7 Mar 2018 18:30:25 +0100
Message-Id: <20180307173026.30058-9-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 518455d0-565d-40c3-8076-08d584513cab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:HwAglYrdaHHl0prPUfOlP1Vzs848Lx2hhYSb22oZ3Ag2+W0k1PqCjXlBPu3S1LD9wblsOn/H3C/9C+ZeDmKG6Rwfh8cPHUA8MoKtGHG/DgC1iufHHEzPVk5CWEuHsQ5nNoP9AT1LCvcPLkkpt76zQW0f3qZAh8f1DbJqrpHitdO1tRvWgAcGu6VgEV6hglVD3OUQ5nTROMIOk5Hdrc8nEGcFOQg1lfQicnS/pC9vraUD+/7mdr6KJVBe6CkeO3RT;25:cA8eq+FX6lm39qwaS0CFAMN4dm++aDuSTyQQCMn5ZsNkuhqy/0gkqf2sEoiviX8kPUL1fN53Bwa6s1eh4d9/+VHPKJrd7jRk6JlNf2vA7EiyuiZ8AamID5ezCUstcO96u0Odnfed8NLVNpeWbzvd0wpenLdizRfscfBjbfDUc7PzO3rm0vuaOaeyNPTze/xa4uM6Xe+qzVfeqVV6H1zXLPDr12aas2WWXPR7skHi76feSZwv6wk59l357SITD9Y7YciCQgZtzgN9g30yNGkRSYzV1IoRFso92QvBgYbeSGU+et3A93+3oeS+1Mf6SVp9Lim169wtRTZCVKGvlLnb8w==;31:ylnwbC6mqNHGaM3vUO/+RAhXx0lUzXe33XgElQCLdwfgPPR5gw88Chw1qoYsSHwNINpSHf9E2kYETyDR4jwQ0bJzmZAuafdegvoyz4uzU5ovBgCFTKR6aIBv8vwTH00Sere2wzaeNcvGNV/mzXJtUw6MvkutaNVsb6enyjJBnAn/jnb0bqjjLBhVnGshB1dtMMc2JbCNR3nHY72Cvw/iZy3dztCUws7+RZ4LamhT1pY=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:AiSF4EqOCKCXPBn4o5Fg8MBE2492ON0nnQwqgyQuxsrGFVI0YbsWzjIxzHiU81CHn61GwVpgPhqedBFS9synBomrFXUPuQ6wam3X0waFrucZXYQjErggjitux0vS6pWPYkb3xN9WrwJDnKBwdJYGa1XkylR/66QnueixYgCw1C867VAI8slJzaKh8juF76X/rGN7oHopIramJccpKVsesv8z4JWx6EaAQGYJzNv/MRW7oeTqwUdkFRpcsZYcyj8hIAyMeLE1c/IxlDZrOAH3PII7GNDRZX0ECYVieLKMB4Br6IVjrFAI/Ay19b6+Bkm9oZGEUvmGOc1KOR2ICbbw+7Tv1vqJrqGgC0n4KAfroKRePeauu+mGE+YfslU0hSfSemG+5hNIbV//BNSWcIV42NfI4lh7e8wHV5DnashaeuJ8ZRtfm1aCQMFS4Zt+XfK0ZxnTorAsmpbpad/pqbcUKuy6p1og2ZH3G1sVsTLDdA4dbUgGPaSvjc4mwcn1Hd9iO60wBgFMgTZ26OQhVGLhspawfYkUmZYVkpBn0JYPzFNPrlf+il+3/CVmMxbJsL778kZLCbrHczYDtvARssq+iqB/JyKZBl0BZgtZJKyqwTs=;4:x66H4b0RnasmoI8vYmdIhK4sONq+8ZCd7Fj8gyIejk2ZuN1YLXbM8iAJqVrZMhXXJj9c2QIzoFDGkzckmrDeMST9sKV8x8m7A9yNlcUC7LhdwPB1EjOEmkw2ojA8At3ZYnc69Ud+Esi4R+l9nQdukAzCVo1iDlsInadtJZD5rKADI+5koEMyRCQamp01Fsvr0YqCs7J2+i2rF87Nn55DoX1m9wRrIlsJ8X7FgdejpmYlgEMDxzSJDBw4iT+83+GUtomCechcMa9qpEFCLIvThiZxpg6FJmGFMCJP9TsDEabK7XBkut92JGBOOhHtSADm
X-Microsoft-Antispam-PRVS: <MWHP136MB0014517AA3A044FA14A97152E8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(59450400001)(6486002)(4326008)(26005)(316002)(8666007)(386003)(8656006)(39060400002)(76176011)(52116002)(7696005)(51416003)(5890100001)(97736004)(25786009)(50466002)(2361001)(2351001)(105586002)(85782001)(50226002)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:9bAnwIZybdgbmof1f3tyX93BUcRD0UzLaTlwlPJU1?=
 =?us-ascii?Q?p9WJ+SRkgDdr4NLmuuHevD81wQTq6sQKegeFtgtiH+XuK3e6wX9ST2lhc0jT?=
 =?us-ascii?Q?gorfsCwd1O3fLs10MwBf01HsT4s3mFT5+kmTXotF6ENNQEFxIvY74p0IQkkx?=
 =?us-ascii?Q?mayc3AQE3Hbx4ScLDwlZq5gEHoTptAPsDxihP2z2+HviB5gycBMA9+e+zHii?=
 =?us-ascii?Q?jmlHxdRkHBKs9zMQ/eAV9s3a7bpJ11bk17vRj/5X/qHGFolb92q4bn7KWSh1?=
 =?us-ascii?Q?MqSUdNxrDizwVbRCgL1H/F9krqnhNqcOjy4QCilTTFNZY0zHyPLhJTwO/1Bb?=
 =?us-ascii?Q?RD1VhiwKOeODQueyr6yqgeyDTAc8wiIVVTVXdVR4AdgPFifgCup/9wkTRbJv?=
 =?us-ascii?Q?ol8P4/RAlayWCRbsLPHsf155rJ5eev0TAEjknTbypJtPDuRCxl0g8ukj7ib3?=
 =?us-ascii?Q?eTJz4D6h6i7x11spPzgLYN3nzVGA2v3of3io3ZcqK/gU7yvJ46algQFNdjCA?=
 =?us-ascii?Q?PJNVV91REni6o0fe3sdbd7t4WgDSA/Ru1RrDHgkx8IPzIzMY151rnGBb4iBs?=
 =?us-ascii?Q?E0ZsCY857uyLQj/67pop0R5KVHdwmpUpU7jjbM8cfD8Y02MrZYZ77YtIZdwJ?=
 =?us-ascii?Q?M1azX1ebDFuhC4i76Gi8LblcX5vZONrVlqbzs1QwyWdP054JhT8RiVMLwLFb?=
 =?us-ascii?Q?n0r1fW+djSFN2r3sjs2VdeAYOIwctDVkEgPFpmKppfVipn45jb9s4WyY61Oy?=
 =?us-ascii?Q?9V6yAFCavhUur+JkWBh4fq9tWDq/1/1Q9QjGDs3o61MGZSjbuzs7W0mGPfaq?=
 =?us-ascii?Q?wKVXEXwlZLcVFJgY9Z2Gws8t0yKhX3q+Hi/7kQcsxjOqsYckadwhJxZ94ZsX?=
 =?us-ascii?Q?dA2oqkVWqXDYUMUlGwN7qF4T3qeIY5QPGha/hGwDDc6UaR+DBqqkvU4VsnRa?=
 =?us-ascii?Q?Myg9CNo86NekRT/6Q5hr6JOuJxB//Ft+rKaQVlLVRT39H60VTXJyP/TlwVZV?=
 =?us-ascii?Q?PtdrEPJZ0FXXhiFZtvW5z2aMol+4aemDB5WqBWrPCLeUYimveNarr+QojcSA?=
 =?us-ascii?Q?LZT63Af/5bDFyJ23OQu2Edw+qjwIgviwy6rlyCXZ+yLUlADYG7Bm4pXThwE2?=
 =?us-ascii?Q?qdWPDAfnK3hLttuYHSU2iJAvvQEz88vy/hRrYFzjpv2Zvd5WCajpOeJlPnKc?=
 =?us-ascii?Q?9h/tvpfKhPZVer3Da7U0CjHpJlHyQvtjR2RiAd732k3NUgSz0BI9BzoJ65Li?=
 =?us-ascii?Q?93r9c45K6IBMtdevkG6dqpfvVFYc0E/MNE8hIsnrtwwmeadYIx5JNF5rO7W1?=
 =?us-ascii?Q?yrRAgHGdPhYm2+yU1MQpzE=3D?=
X-Microsoft-Antispam-Message-Info: Gl+Emui26Q2KOD/Pp8gLHVxnFCxks/uXN2kAbyLuHuCWgjoLNPQJOpEzhPBM6AxvJwMagnFBbV4sBZSYNbgsktxszYsLoc0iOTgrGIp2eUrvyvKCRyACy2vV283ZQa1TVlVJKNvshRsBBPNXGtsNiejSA0Uy2R6YL8Pvm5ik/Nte67ibTHf832d24f1KCqIf
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:66j411HnXAXwnKi+a+EXp6QkoTNTi0MtLlr1SgdVF+J0bTCaeYeGjrMcqsbW//PLc0jbz2c4jQfP5mzoYEw9hqxddC1stOjSavSwmwgOShTqPM1VqzskVOPjsxrDTArOlNOXSzdFEVUSVG4BrMaD0joSeGihzvfRXB3KAS5MU2z6VJHdTXKje55LwgqALpUfhYZNMX4Vkq0udfjLp7rXnT9H+vCTRwTQjP+zq8b31Ju2jjB0eDJta4wqijpwPBoPb/k1N4I9x2VQ97H6acLqoy0AV+zA4rX7OdKMH1HBmh2ceNYf/iiORmC4fbBuU1Oo9SfmiEgUMpZSuGnIO1mNXDs4vDS1Jfx3eBg0IlGhNYk=;5:pni0AVp3xfcIj7YcGO03YE6pCo7S4SkSqKrJYPU2PSH1603EZ9XHk4u9mXGzGdfTg9Xdy/cM8VO0R/nYxb+ascuEdyOSzh+oNf1eoPCs5XubxoQEyS3gHW74qNvjAbmkeeFuFVmO79iF38vcc1gtflfvGup15pZaxJc7VzPqFZs=;24:TdMzmnvcq7ZFK8plTw7XxUS5aETC7760jh5R29WNJB6K+fp1i7g6lMeuH8vfciJd7rnR8NN3MpIwRI5gc/MJFUfk3qYxBBkhMnnNgmi8V5k=;7:aauPBENVKcshBKhBLE1GMffEYg1Ee6ame6rYjiwLU9WHJ5iCdA/gcuiC9SUnODK3UaVWrFER/lLaCKFqrVSVC4lC1PAhrqoI9LssLdqdGK3wKyKHlG7ABAPg+OgWOk07cbjquqSsXfm+e5j3OpSHOeegXAeYyokEBlWBOEP8VxLTNT7k1cw8r9a7QE9U1A6eUkzuBdcAi5quAwZDgb/N3JEpqxt73DshnIod4iIGJj6pPwjZ4fktknnmBHhqyeTr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:31:16.2570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518455d0-565d-40c3-8076-08d584513cab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add the GIT_TRACE_WORKING_TREE_ENCODING environment variable to enable
tracing for content that is reencoded with the 'working-tree-encoding'
attribute. This is useful to debug encoding issues.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 25 +++++++++++++++++++++++++
 t/t0028-working-tree-encoding.sh |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/convert.c b/convert.c
index f19a15dd02..5776dfbc99 100644
--- a/convert.c
+++ b/convert.c
@@ -318,6 +318,29 @@ static int validate_encoding(const char *path, const char *enc,
 	return 0;
 }
 
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
+	struct strbuf trace = STRBUF_INIT;
+	int i;
+
+	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
+	for (i = 0; i < len && buf; ++i) {
+		strbuf_addf(
+			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			i,
+			(unsigned char) buf[i],
+			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
+		);
+	}
+	strbuf_addchars(&trace, '\n', 1);
+
+	trace_strbuf(&coe, &trace);
+	strbuf_release(&trace);
+}
+
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
@@ -346,6 +369,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (validate_encoding(path, enc, src, src_len, die_on_error))
 		return 0;
 
+	trace_encoding("source", path, enc, src, src_len);
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
@@ -363,6 +387,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 			return 0;
 		}
 	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index aa05f82166..6f3a82f61b 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,6 +4,8 @@ test_description='working-tree-encoding conversion via gitattributes'
 
 . ./test-lib.sh
 
+GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
+
 test_expect_success 'setup test files' '
 	git config core.eol lf &&
 
-- 
2.16.2

