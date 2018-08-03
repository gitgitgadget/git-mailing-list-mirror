Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62771F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeHDAWX (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:22:23 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:55756 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbeHDAWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:22 -0400
Received: by mail-io0-f201.google.com with SMTP id u23-v6so5046480iol.22
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/zTqv0mHfHtHO2i1LJK9Hrndyt00g5oP5k85EzRR5as=;
        b=sPkgTmgN6y0/Au2UVZGR2Yp3uXKpoiJ0GMGjTLigc+tbMe85QLYISsgZ/gEkd9ubsC
         2Yh+PJsC6n6LEuwAzj5zj4vrgmBuNLLXl9+xS0Ec12kekdheg5My0M2okKaNqJneKQc1
         M4/sDly0QMBJRoGH9ZqJB06ylvahyKNs7Lsxu/b0C9mPvbKbYoKNxKe/pS26efKhV7r1
         fdAudlppIypFSnxxVASjzdsrz0uU8AsSvHeD5Krt7JUnL0HgOkOQ/tqQl746dMnPfOi3
         7m2RdFJMC6R4yNs+mX5vbdBSGRi092syUBJrQ8ophg+k4TQnemQoO8ZWZikfU633C8fJ
         qqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/zTqv0mHfHtHO2i1LJK9Hrndyt00g5oP5k85EzRR5as=;
        b=Iv2V9OW22A1XDAmksQVOhdRcu10uObKhyJW8pzOkspiq2F1zo0oxZP9Avp3ZKVaLgI
         I8mwVZUZHlh6b6ZNWhR8LplZdKBkMRN9FYpSyMTL5Q9QnwgRqpDUIygZ5MrnTq0OLtkq
         AUzeT3/aBTpGfo/alpCXSF2BIB9QayzCbPdz3EhI8/LUAKVQ7DA4g0pezPIF20dSWEaZ
         V/sZAlrQqQ8dJPMKcekDLmYCDS7GEgkIWbn2O+FeU7Lq18NUeTp3lPkPEFZ3kOi7X7xz
         /PZFs9PW4Be0Tds9Clp/i45RCQGoFLugb4OsrIRBw6KKzSZgNPsmPJyY8cQ1WwwFg2S3
         fcVg==
X-Gm-Message-State: AOUpUlGK20NKgVnVop+d+InFoBOpm0ebFjZ6yTJNcoFzfOTEhU+VPWCz
        gIHEWeReM7nFL2XE42fHyeO7ggqslGBY8Lw//XCLYQsoAJ11wseIKgLmHPUdxeWgl6t+qUP0QF9
        zTDd+xUjzwP/1yORqCSmd+aeX9a5+vBWO7dgcEW/OBUia3Sm2h3RJT6LdSqON
X-Google-Smtp-Source: AA+uWPyJv6pD9DdC2Ff5rt1z93MrHSJPJ+YItSo0Jya3cpS99mT0n0jFHuuhZR/WR8F/uO23fF8/z9elJWWZ
MIME-Version: 1.0
X-Received: by 2002:a24:b713:: with SMTP id h19-v6mr406295itf.28.1533335048983;
 Fri, 03 Aug 2018 15:24:08 -0700 (PDT)
Date:   Fri,  3 Aug 2018 15:23:18 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com>
Message-Id: <20180803222322.261813-4-sbeller@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 3/7] builtin/submodule--helper: factor out submodule updating
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separate the command line parsing from the actual execution of the command
within the repository. For now there is not a lot of execution as
most of it is still in git-submodule.sh.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 59 +++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index da700c88963..32f00ca6f87 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1474,6 +1474,8 @@ struct submodule_update_clone {
 	/* failed clones to be retried again */
 	const struct cache_entry **failed_clones;
 	int failed_clones_nr, failed_clones_alloc;
+
+	int max_jobs;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
@@ -1716,11 +1718,36 @@ static int git_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
+static int update_submodules(struct submodule_update_clone *suc)
+{
+	struct string_list_item *item;
+
+	run_processes_parallel(suc->max_jobs,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished,
+			       suc);
+
+	/*
+	 * We saved the output and put it out all at once now.
+	 * That means:
+	 * - the listener does not have to interleave their (checkout)
+	 *   work with our fetching.  The writes involved in a
+	 *   checkout involve more straightforward sequential I/O.
+	 * - the listener can avoid doing any work if fetching failed.
+	 */
+	if (suc->quickstop)
+		return 1;
+
+	for_each_string_list_item(item, &suc->projectlines)
+		fprintf(stdout, "%s", item->string);
+
+	return 0;
+}
+
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
-	int max_jobs = 1;
-	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -1742,7 +1769,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &max_jobs,
+		OPT_INTEGER('j', "jobs", &suc.max_jobs,
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
@@ -1758,8 +1785,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 	suc.prefix = prefix;
 
-	update_clone_config_from_gitmodules(&max_jobs);
-	git_config(git_update_clone_config, &max_jobs);
+	update_clone_config_from_gitmodules(&suc.max_jobs);
+	git_config(git_update_clone_config, &suc.max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
@@ -1774,27 +1801,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	run_processes_parallel(max_jobs,
-			       update_clone_get_next_task,
-			       update_clone_start_failure,
-			       update_clone_task_finished,
-			       &suc);
-
-	/*
-	 * We saved the output and put it out all at once now.
-	 * That means:
-	 * - the listener does not have to interleave their (checkout)
-	 *   work with our fetching.  The writes involved in a
-	 *   checkout involve more straightforward sequential I/O.
-	 * - the listener can avoid doing any work if fetching failed.
-	 */
-	if (suc.quickstop)
-		return 1;
-
-	for_each_string_list_item(item, &suc.projectlines)
-		fprintf(stdout, "%s", item->string);
-
-	return 0;
+	return update_submodules(&suc);
 }
 
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
-- 
2.18.0.132.g195c49a2227

