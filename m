Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34251F404
	for <e@80x24.org>; Sat, 24 Feb 2018 16:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeBXQ3m (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 11:29:42 -0500
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:30992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbeBXQ3h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 11:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ylgkrdDBhcZ+AI1Gfg53NACfM2Ikwnj5R2F8MvhNaRw=;
 b=oWw1/y45naBGFa/ZafwtjRX6X1s7v8cHXF03h+IjJzVPwzN40v/Qf5objFFZqu+Qhqlw8pMA0QNR/YdzPR5WZ4z+tpQ9VgFfL+ggs9UsoeIdt2DRMMTEOJtQCRo5DZG9wcUlAkytNC1Vh4mearIkm9iAZMMDGuDi0ZJdlUeOX9A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.26; Sat, 24
 Feb 2018 16:28:35 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 2/7] strbuf: add xstrdup_toupper()
Date:   Sat, 24 Feb 2018 17:27:56 +0100
Message-Id: <20180224162801.98860-3-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: c817e0af-7799-4ee6-ac21-08d57ba3a88c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;3:cheIF+0GpqKiG6E4oG/9Y7RE74Jf59/H3O+JU2IzEIXjxSKwTLru6TI5WGSN8SD85wpiV+xTDmWubfYiz7BM0P7qd82lGVFel7Gf3W1ITLSy7hEimcox/80nQb3mzb492iiaaVFO2iohQmVtIA0jmuR0zaw5r2T0xDhadMj+OMlCoT5KKWb0QSrfw51yzmOoIEFJ9yRMbOlR9Hp7RxRYPcyaxsNL46YsyvEW7FtSR1F3S4t4wmdlXTwgV2uLNShs;25:Fkwlb9jfEZYcg6PR2dLY1/7HfFJ/D+0NylGbt1GWvW2JOgqnTMLV5LBELs+c+nNOdeWklbhxoMmae4hgTa2id0gtCIEN12y+UXfbGIfFn8DIFi4qmmGCHNCXyVwyYgrbPpCB4hAny+YKm866b2+fQANj3mr7VHVwzM01j20a6hrZrVn1g5NMi07dU1MVSHA+Ognn/xhgaNxlrPA+zwiVx/NiGb/qeKgRL9r7J0ARaRryl0Vw+W8HukbNChojIBZUappkzYFbu7XRh4HxO7tt3SmKwRJH9eSbeEPKGHAiw6BjSQUhmvhDYjRVFlbcCggiBXM/erjdhxzFtQXvDGPCBA==;31:cMybFybrauThTzTxes0YISEbyCWJJYUP0UJcJS+1yphTGijz3F5SF3vt7BN6c6iO9SKxe3IH7J4XZe884kvCmqI379ifGwApKfoSL0JwbtbioedSo6npOuxmwZa5Nwr3hEIK1+XfgBOoPUjHQaFES+9wca/Y0LH1P+1/7WGxcJ9X5otR/IFEC+XaTgygMAOam6N4eFqX6giqK4+fpQg+TGPM6C32LLKViA8GQVJVT2E=
X-MS-TrafficTypeDiagnostic: CY4P136MB0007:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;20:YSLWkG+/IYJ6hXIgp4VNz2ZnwH2WSAGEPEVnqa6ahrF1u8PnGlQM4GkTfwfiXnb3P972kfH2mqGOQG8MGQELlwoWr7MIOae/ccsMKnC7zeyB5IFqkRzqrAwsJoTtFt2OMvpiUZoFzQdufyPvuJxyuLFI28MJ5M9x2FfJX2FO+g9chL2j/8OwqYsi5imTMrUHJod82kJh597eIwQnagSRJoPZ6Zz7ZX+cTaQiO9HvHx1WknWOB7dOq1rNc0uD/4Xk2zAFdMdEz5kYnVl5PvPiceWYn4siBbB1iY3u6l4Vrjj7BgM172BE1YAHmAXtp0S6PxULwe9dY6ae09QBC4J6Rr+Nj2q3rMQ4usEcGcZckTFuYTr/CR2MEVe0E0jWcBT4sMDS6RQnTAH3nHGp3WJb7Pa4XY7v1iR0U9/XhuMCZhBtMlFZy1vcnFiH2Oc2d1ZWZY3ufsDqEx/mxehDH/Omm5e9X9kn3W0MmR9LIeIvzT+AIfzVSWLxxszpO4pa75uXeNJnWhyoD17krQjUsCTCclwlRe6i/rCGfmEb9IHNwN/q3h/NawkALSNCX0ByfM+ZopMcmqiy8Dv4dTMekLHKARlPkI4P2osPy55Qx+iIsgw=;4:FNiRuyY1+Bfn+I6iCgMHj1w+pwxGTuPtgi9fvObXtxMKD8rQ7Q5rGzNANL2DxpT17lMSYqj24R85NSp+90t/GGv6EHEI/BdHK6dL2r7lGA9iTXkK86l4+0mkBNG/IiXla7XXCClRYvux/5EoHrdW8vw8UTmqtHeAQy42jrUYdi9vKDtAb/MldF9Ixl/D7/qj5giffcACr/xqfsS6Z5l5X4S9cToBM4YTA68CMJ857bH6nnfLBvxs2P4CwgzbL3hg
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY4P136MB0007;BCL:0;PCL:0;RULEID:;SRVR:CY4P136MB0007;
X-Forefront-PRVS: 0593E261C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(199004)(189003)(8656006)(5660300001)(7736002)(66066001)(50226002)(47776003)(97736004)(8936002)(6512007)(9686003)(305945005)(8666007)(6486002)(106356001)(36756003)(2351001)(2361001)(8676002)(81156014)(48376002)(68736007)(50466002)(85782001)(16586007)(33896004)(6506007)(386003)(105586002)(86362001)(26005)(6116002)(3846002)(1076002)(16526019)(186003)(52116002)(2950100002)(51416003)(39060400002)(76176011)(6666003)(4326008)(25786009)(6916009)(575784001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0007;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0007;23:82mELlHBfP2zBAWceS7f15/bh/yDXOnWss4AqOlBN?=
 =?us-ascii?Q?boUQIvblNJPXeRHLWxaCSNsdu96G/6VHxiDS6ByI7thFH1e3qAUfXchUTmhH?=
 =?us-ascii?Q?LnJZH1wh4tKnZHH+ev37EI6paP+OfOnqmtzYppio9tkSbI/tRnNLIb9GRihx?=
 =?us-ascii?Q?FOpHk5x1qBoXpxX3myiHHnAhHH1zCG3PovSDz9iRyQ3QMc+0U4ruQguPrLZf?=
 =?us-ascii?Q?Ri+JPQU4ANIULGtusmN71hZRuXM6452zJVTsXZSIjbuE9GkkuKCTDasg+6Zv?=
 =?us-ascii?Q?AyeU3KtxnwkTFiEFE1KTUHAaadJZg1pFwn72oRMnfVGPH/zCNyjdeByUai1m?=
 =?us-ascii?Q?S0FUEgtjAcQWPZeeDhaPQCuhgHgLgJT8uaFjRO20n5qV4JhF+3O/l0q9ii14?=
 =?us-ascii?Q?2bthnvHMk5IvsZYsZMCColfiu2L08ThxOXfFSdP8Y1SGs0FilbHldQAXcuug?=
 =?us-ascii?Q?nzjdAa8G3BelHY3lj5WyPE1OfeJFHym1BYzakc9prCxiIlUyZVeGmcjPmEsD?=
 =?us-ascii?Q?xNAglvHhxQe1Gh0eWFHXbgiNXXKXbjXQBtkyKuURwUinc0s7T2aPGP706/cX?=
 =?us-ascii?Q?fjjNRVjSgMP1EhQGLummb/WkAZw+3UuzxVwug+BbymTue/tABtX73LSHoM+F?=
 =?us-ascii?Q?r7wPDfodCVhvDHt5jcrA0IPsal+ytqxtJQPugfM3tjXMD3vavD/nfMKy3hHN?=
 =?us-ascii?Q?mY3MnOrxltGV99BfbvkKUaXDr3U4OMLayBHf9LtpEPV21j4VHb/qGEWEqX0J?=
 =?us-ascii?Q?fZYM7Zye1GaoDlE00Vr+LfHN7QFbCVvonzfps9mkf5PfnFJuRGTLDMzytM5q?=
 =?us-ascii?Q?2YWEaWqsnYhZ+1Ui+gE+dQqQokKY8p6YDxt9wF2FK8/ACbEY+BnkefqoO1LC?=
 =?us-ascii?Q?2j1OSuDs6eJauXCz/dGLUDxJNXl4+rwL6pqEKlP21fFA8aZRcJORT+OjZaLE?=
 =?us-ascii?Q?lgSwlAVcaMussnqkam5Cx/s0ohgJj3XPUUDrApFpAQcHPD7wtRPmnkGnI1PR?=
 =?us-ascii?Q?L+ES3SfY3cXBbJoHxrDfOPpTpXwl/6DIFDbsjP6QnsJQaFr07ixfdlcSBgk4?=
 =?us-ascii?Q?YCjAKh5oNsT++bAO5UfGpWmngclIzOp0U8tjaYsAuYy2N+SnDCIC3bh7mqjf?=
 =?us-ascii?Q?RU0GaBYjDaHHigcaEnNyRkA4mcpcNud?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;6:35Y9i7YlD4pTMP4/pbBDhy0RvkEcjdl3e5MloZrd9vC24xASFn/+vMX4R2WIRsnBdzsDsfRm3RlSExdTHCzW023WvESNHd9Vdzc6xU/roklfK19fOxxuMPbKAfwSZhlli08h1T1lS86TdjtSaWs79QmcnlKtUfuZlzp413OmALbli9FKdJ5/+YfFeMFUws/pbKlYXsm+mBlKtWWHi0cW48wPccbPTWuLNCeqkSmKZWPYtXlVaLJES4X0Sj9cI4+OnVHYx+2CPip2k6wyfxYnSwvgJcCT0cWHAlZqW8ADzdo7gIDwTWouLD01XOUZPPsSm1VrYKUJRWahf7opjgAMAFnLBIow2y5OQivEwBnC7YE=;5:pygLji3Fe+6DzKRy13+0St4bR+CL7T8rm8MKpqhj6cwPeuDR/ClEQenTop7mavwBhwhbY5hwwOPQA67cx5Oyjyjx8MWP3QK9YebrWcnIQdIem6UyQDewhyCIeNAY4RGh/1W/2AQAejVqI/28GaoEKtrO8blZ4o5eJXtKGpknlhc=;24:GBQI30GhmlJp+xZP7AtyS6xg3XEbj3OizOUzryMgOAwjOw4guXp33FgrBnptXsjHbPtjbxwp10wgOaGxLblTYMN+af3Q1Jo9pgLO+jfH5zg=;7:voAoCNyllPuJZzENtoTKkTyEzVWXUL/kD+FW95IpKdgUIbxoq+76pyYP4eZ7PcjS867BI+vo23juUpoxAveu0bSQjIr+iqhsuumx8Q5q11iRyX0oAbrBYTCbzGxPSaR+n7aWOjyiuXYFGN9yL9PbU944RA7aPKbMQLR1LFfBcqcIXoNR7OIO5F4uDTf9+nbypli4dO8FOCjM8nEio+SPwKbuU40z5b+fSt05ZzD0FRsU5LvfnZYrarjEOY2JK4sI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 16:28:35.9688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c817e0af-7799-4ee6-ac21-08d57ba3a88c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 12 ++++++++++++
 strbuf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 55b7daeb35..b635f0bdc4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -784,6 +784,18 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..df7ced53ed 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -607,6 +607,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.16.1

