Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F241F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeGRU2d (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:28:33 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:46888 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbeGRU2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:32 -0400
Received: by mail-qk0-f201.google.com with SMTP id u19-v6so4577091qkl.13
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=2+Bk4VkvKse+SbY4PzPfyKV6hHJS1WlccH1Qm6Uc+s8=;
        b=sFCcbyObPaY95W8Pq7CyyJT8egmA+3L9YmuaA4dFiYKRrjKi0XDCJZCG08wHZY8TNe
         +MgUCoUby9zrjqoEC/4J6zJjZ2wKK4gaBeE1e8o/KrjAE93U00n7w9JhKnz9AM6pTgIs
         F3ma1khV3krm5b2ohMc9EKHuKpNVvrhMxgHdM2eqM278SCFbf8i0gQmE9cov3lwLuPh+
         yN11PqUGF0vctQaPoEOZXgTTl1xIr+CgtTRr/JT3ZINQdOgeEIztTfFkTgHVsw0IA6Fx
         fdTCrxoGTo89fLrfgey04Q9XBDJt4mQqyoetChl2zv6dT4q4GlQAbsbHCGmzmHGpStdW
         l0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=2+Bk4VkvKse+SbY4PzPfyKV6hHJS1WlccH1Qm6Uc+s8=;
        b=m3bUcbkVYKAe0XYYVoGSE4aB/uqHLzw93wf/Pmdr26H0dGlgzD7QfpyoqQIQY68y6h
         idgRtnndBrbLrXsEhHKXB7XFjHNhgrSY74bfdOZTirurfpimCdiKHt8ztsSq6xVHks12
         c615eBFAcxLITG64JGh5uo/HfJnPv8K/oKldba4b1XeWZs/h7h3UUhtdHhNIyP5dPmm9
         WdaaCBKcQpB3p8yls7KPp5QuZ9dgYdKV1ZK8H6cW3Vzt5c+XI6kOFUVFxlGhqpi/2uUd
         mtxv/v6PG2NoFs9pU+BqzezK57kN+0pxxG4Qmz53HZjXXig1Y63gJbJlJoHATI/95z/5
         5oVg==
X-Gm-Message-State: AOUpUlFMQ/RGUUHTdOxBF4xhYF51cejMHFouc5gRaeS7BZHG56q5+CWO
        0Fg8alVLetqNn6xIvd+xB1Rz2ShK8iyT6NtfuP/oSf30ZKPaz2ctE0nUxlHfvEEwPB+5vAIzYQV
        iqpgtudxeAh1Ce2m6KX9kiImM/9DbFXdnuDI5PzOAdF0v67R4Tu5AYioLV3Qw
X-Google-Smtp-Source: AAOMgpdqI/BKEvxtFmVt6RUusIJVf9N04Mkbsx7N+YpDvZJuohOzSRc2MfiyC9Eu+NxsMM7rYZqoUS5MTGq+
MIME-Version: 1.0
X-Received: by 2002:a0c:be06:: with SMTP id k6-v6mr3940685qvg.56.1531943348353;
 Wed, 18 Jul 2018 12:49:08 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:48:50 -0700
In-Reply-To: <20180718194853.57994-1-sbeller@google.com>
Message-Id: <20180718194853.57994-4-sbeller@google.com>
References: <20180718194853.57994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 3/6] builtin/submodule--helper: factor out submodule updating
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com, stolee@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separate the command line parsing from the actual execution of the command
within the repository. For now there is not a lot of execution as
most of it is still in git-submodule.sh.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 59 +++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ebcfe85bfa9..96929ba1096 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1472,6 +1472,8 @@ struct submodule_update_clone {
 	/* failed clones to be retried again */
 	const struct cache_entry **failed_clones;
 	int failed_clones_nr, failed_clones_alloc;
+
+	int max_jobs;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
@@ -1714,11 +1716,36 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
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
 
@@ -1740,7 +1767,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &max_jobs,
+		OPT_INTEGER('j', "jobs", &suc.max_jobs,
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
@@ -1756,8 +1783,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 	suc.prefix = prefix;
 
-	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
-	git_config(gitmodules_update_clone_config, &max_jobs);
+	config_from_gitmodules(gitmodules_update_clone_config, &suc.max_jobs);
+	git_config(gitmodules_update_clone_config, &suc.max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
@@ -1772,27 +1799,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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
2.18.0.233.g985f88cf7e-goog

