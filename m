Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C3C1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeGQA4z (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:56:55 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:56479 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGQA4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:56:55 -0400
Received: by mail-yb0-f201.google.com with SMTP id e6-v6so28912168ybk.23
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 17:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=dsAxR51ixQcvVJpqlcuXY2s4JPlIko9SjEdBahO2kmI=;
        b=YKmEqDMk4hBUMq8d5T7zlZ8kRBCqzK1KZ0QOvX6TGSB0SBvU/7E5wMOLTuSGI30ToH
         csPJutABLEiC1cFyMkKGde/idhePmN+TZ+4mW8zKFkLBd+31C15QiciJCGeiDGP8TsHg
         KYTkkPzDmZe6jtlI8lg2Ea3qqwVgnOXv52wQOHZpci7eZ+CPUOJViJJfILwsWl/zoenL
         syu3ApK/R1cuC1Ea2uzjhqHhWtYUy6HlIg7NzPRU4gQjuRCiB0qiq9yVKzZDIFSG8u19
         C4OFsZ4Kcqva6rzIBtyCj/8fA8p0YOhZXfpOsDvrIMmzP2rYsNBgpDbMspyJXuI5/1sy
         hrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=dsAxR51ixQcvVJpqlcuXY2s4JPlIko9SjEdBahO2kmI=;
        b=eRWZf6wg732qhKciWMKr5d7AAZpN6z9RM5z/QosoZ6x/udMQV8i7A/X4tXZC/gFCry
         GtnDp2IaHT32Eg0iBiXwqOblsgdjh0N/9lIeOC6CYcJewpgr3YJjgPg/bp9TFBV1wkTx
         qoqOlrSh7sBUrjigtsvEn84EarbiBq7UadRDJfR4LIDION0tE8aiJbJ/h79TBu9DbhZ8
         eDCoGAyjG0Mvz/G1rK3n95sFN6Xoppqs3rOrUebLhk9SlUbeg7LTz901TfZ2qPiIVC2v
         0tBtW/R5K8AYX62vArQNIvaOs2/Yowosdy6X2K+IA7Cjhs5nW+lwko9px3makdVxOXFX
         E4EA==
X-Gm-Message-State: AOUpUlEz58atiuFVvSQFHiVcU+TD/xzQCIdaHXyXsg5hKe7/BvPYKWhY
        gnzU+t9t7/fxqaqxUBmskniXJOGdKj1KVEQ/lNeA3/ABSVuhd1Ek+EzEH3o1PcusSkgnhSCS/y+
        GVnkPWVF4jr1YNwiRoH/GxzkDcVZluXAonw/JqKGrqqB9gFEdTVnOcbme4S05
X-Google-Smtp-Source: AAOMgpcppUBAR9+nPVbsENKqsd34esuvMtpIl+SVsI1Up2k8g62uojFJDnsgETR5s5nBsh/GZsfPKFA8ldTG
MIME-Version: 1.0
X-Received: by 2002:a81:98f:: with SMTP id 137-v6mr5402735ywj.206.1531787225105;
 Mon, 16 Jul 2018 17:27:05 -0700 (PDT)
Date:   Mon, 16 Jul 2018 17:26:51 -0700
In-Reply-To: <20180717002654.120375-1-sbeller@google.com>
Message-Id: <20180717002654.120375-4-sbeller@google.com>
References: <20180717002654.120375-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 3/6] builtin/submodule--helper: factor out submodule updating
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
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
2.18.0.203.gfac676dfb9-goog

