Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15041F424
	for <e@80x24.org>; Wed,  9 May 2018 17:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965815AbeEIREK (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:04:10 -0400
Received: from avasout01.plus.net ([84.93.230.227]:53927 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965697AbeEIREJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:04:09 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id GSVaf5FtgQrTpGSVbfvrJn; Wed, 09 May 2018 18:04:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ZIX5Z0zb c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=PKzvZo6CAAAA:8
 a=KsoOg5XCfp6jcgd24t4A:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=PwKx63F5tFurRwaNxrlG:22 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] BUG_exit_code: fix sparse "symbol not declared" warning
Message-ID: <dd1db230-9d5a-f78b-f2ec-38754135495d@ramsayjones.plus.com>
Date:   Wed, 9 May 2018 18:04:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH89GUoaXIAu2Z8TfZmMxFstKKeuHeeiFTrCPPvyQSZRoKfT5ort4hj2iFLpEklV7SIycKpMLbTzdFvavCzQHvROR0Y12SWtKC9O7g5o3nNHDy2jtRzF
 ALsOZCjWSdwrPr/t6drakz7tkbGJ3sRuO9MOSmHovTgbNX3pfU4lQQQpZD/bLqqANMS/7nMMrqWV5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Johannes,

If you need to re-roll your 'js/use-bug-macro' branch, could you
please squash this into the relevant patch (commit a86303cb5d,
"test-tool: help verifying BUG() code paths", 2018-05-02).

This will, obviously, not be required if you were to implement
Jeff's suggestion (in [1]) of using an environment variable
instead. (which, FWIW, I prefer).

Thanks!

ATB,
Ramsay Jones

[1] https://public-inbox.org/git/20180507090109.GA367@sigill.intra.peff.net/

 git-compat-util.h    | 3 +++
 t/helper/test-tool.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5a5a99af7..b7883b257 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1116,6 +1116,9 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 #define HAVE_VARIADIC_MACROS 1
 #endif
 
+/* usage.c: only to be used for testing BUG() implementation (see test-tool) */
+extern int BUG_exit_code;
+
 #ifdef HAVE_VARIADIC_MACROS
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 5176f9f20..805a45de9 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -47,7 +47,6 @@ static struct test_cmd cmds[] = {
 int cmd_main(int argc, const char **argv)
 {
 	int i;
-	extern int BUG_exit_code;
 
 	BUG_exit_code = 99;
 	if (argc < 2)
-- 
2.17.0
