Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664DA1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbeHHVU3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53583 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbeHHVU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so3807127wmh.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=11/DBm16vnGXlRgeKWtQ4psbd8oSNP4XV8sT4/4wW/o=;
        b=TDkpaOMIMuLsi0gJqmQn1XukMySEj6WJcNwPQaX5EvddhkDf4RLMwQpxPsJsqZTliG
         KlSUjGSqPhnIRvSc58fVgVCAQdFEcoslgdZ0LqOqhzFJQ8S4tRai5Fj7FrHfNVNuVuII
         vmiWy1HpJesw5DFX8FhwZCa5Le8OxRx9PCOpKrCBVJcAVsbIb3y+9/IR4TXwD0SiGcML
         wFakKQa6ZYBzd+goBxtflJtfvG0Nxrcei51BeWvtqBwYEEssGsmr3wuoI6OS4LbOk12v
         VTMLrFj938buyIbTTBjSryGuErlPd9I/VMftyXmLx+PuEilnH8VY/HGfXWWoqBBbxBtT
         aGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11/DBm16vnGXlRgeKWtQ4psbd8oSNP4XV8sT4/4wW/o=;
        b=IXG2JX/25a2/gLBhckCFpg7rWZT3YNJlkd1fCQXuFFWEQTE2eMxOH0onxMsQ1LPNQK
         7UfJZ/MtH+WaKp1AvMODtMEuzOgnZOWM2EppDo4sZ+ptesohdnLF8xTz46/Glil77ldC
         XvvPWC9hRwGfihkbeY0lumuHOW4tDWmiKC2nbzdBbDlCDfQ7Ik2l1jsnh7Ch5q1ASr0y
         CD8BJFxvdJSWTq/ZuWLbrU2iQ6VrOSJpnwKr2M7Ay24UVMFDcIIQI2e23dAlkbG4Ve3Y
         MfSdA7YRk1JDXeV7mkABhsdn99xYc/Vlu71BlKkxMmqZV0Ln+0Rc6uT3balaC/GCoJ99
         VWVw==
X-Gm-Message-State: AOUpUlEmKxpBys3BTd1b09FGBEdKK+RM3zEr0+44dY0EChh/82x3nE1z
        FI0fckkEWUPkYG3qoy+DSlc739qW
X-Google-Smtp-Source: AA+uWPwNZaHCxoN8OLq0Wj6XotU0+JeXu4Mi1VtWS03LJ1r3xipva04CEIkBD8Qkz5mxipc9u64CQg==
X-Received: by 2002:a1c:b84e:: with SMTP id i75-v6mr2497649wmf.158.1533754767354;
        Wed, 08 Aug 2018 11:59:27 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:26 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 12/26] stash: refactor `show_stash()` to use the diff API
Date:   Wed,  8 Aug 2018 21:58:51 +0300
Message-Id: <35e6fdfab85c21f0554da061cfab3f643d1aa794.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `show_stash()` uses `cmd_diff()` to generate
the output. After this commit, the output will be generated
using the internal API.

Before this commit, `git stash show --quiet` would act like
`git diff` and error out if the stash is not empty. Now, the
`--quiet` option does not error out given an empty stash.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 73 +++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 0c1efca6b..ec8c38c6f 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -10,6 +10,8 @@
 #include "run-command.h"
 #include "dir.h"
 #include "rerere.h"
+#include "revision.h"
+#include "log-tree.h"
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
@@ -662,56 +664,71 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 
 static int show_stash(int argc, const char **argv, const char *prefix)
 {
-	int i, ret = 0;
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct argv_array args_refs = ARGV_ARRAY_INIT;
+	int i;
+	int flags = 0;
 	struct stash_info info;
+	struct rev_info rev;
+	struct argv_array stash_args = ARGV_ARRAY_INIT;
 	struct option options[] = {
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_show_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+	init_diff_ui_defaults();
+	git_config(git_diff_ui_config, NULL);
 
-	cp.git_cmd = 1;
-	argv_array_push(&cp.args, "diff");
+	init_revisions(&rev, prefix);
 
-	/* Push arguments which are not options into args_refs. */
-	for (i = 0; i < argc; ++i) {
-		if (argv[i][0] == '-')
-			argv_array_push(&cp.args, argv[i]);
+	/* Push arguments which are not options into stash_args. */
+	for (i = 1; i < argc; ++i) {
+		if (argv[i][0] != '-')
+			argv_array_push(&stash_args, argv[i]);
 		else
-			argv_array_push(&args_refs, argv[i]);
-	}
-
-	if (get_stash_info(&info, args_refs.argc, args_refs.argv)) {
-		child_process_clear(&cp);
-		argv_array_clear(&args_refs);
-		return -1;
+			flags++;
 	}
 
 	/*
 	 * The config settings are applied only if there are not passed
 	 * any flags.
 	 */
-	if (cp.args.argc == 1) {
+	if (!flags) {
 		git_config(git_stash_config, NULL);
 		if (show_stat)
-			argv_array_push(&cp.args, "--stat");
+			rev.diffopt.output_format |= DIFF_FORMAT_DIFFSTAT;
+		if (show_patch) {
+			rev.diffopt.output_format = ~DIFF_FORMAT_NO_OUTPUT;
+			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+		}
+	}
 
-		if (show_patch)
-			argv_array_push(&cp.args, "-p");
+	if (get_stash_info(&info, stash_args.argc, stash_args.argv)) {
+		argv_array_clear(&stash_args);
+		return -1;
 	}
 
-	argv_array_pushl(&cp.args, oid_to_hex(&info.b_commit),
-			 oid_to_hex(&info.w_commit), NULL);
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	if (!rev.diffopt.output_format)
+		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	diff_setup_done(&rev.diffopt);
+	rev.diffopt.flags.recursive = 1;
+	setup_diff_pager(&rev.diffopt);
 
-	ret = run_command(&cp);
+	/*
+	 * We can return early if there was any option not recognised by
+	 * `diff_opt_parse()`, besides the word `stash`.
+	 */
+	if (argc > 1) {
+		free_stash_info(&info);
+		argv_array_clear(&stash_args);
+		usage_with_options(git_stash_helper_show_usage, options);
+	}
+
+	/* Do the diff thing. */
+	diff_tree_oid(&info.b_commit, &info.w_commit, "", &rev.diffopt);
+	log_tree_diff_flush(&rev);
 
 	free_stash_info(&info);
-	argv_array_clear(&args_refs);
-	return ret;
+	argv_array_clear(&stash_args);
+	return 0;
 }
 
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
-- 
2.18.0.573.g56500d98f

