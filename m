Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FEE1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeGLT7H (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:59:07 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:47675 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbeGLT7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:59:07 -0400
Received: by mail-ua0-f201.google.com with SMTP id o16-v6so9119604ual.14
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=dsAxR51ixQcvVJpqlcuXY2s4JPlIko9SjEdBahO2kmI=;
        b=HuNAxeUr85U7pidUCXsVNlKtIDwDmuRBDW9/417ivUQX221WxWWnfyqSPpMSYwA5+P
         WmX/tUjqpPFmgvvlDhdlb9WKoULJV7/R2yvtI7DiV2S60yylL9i7PIbxO+JlXAnuaXwC
         /qz134VO+ANyMIQS0hHSaRcAYuWckSRUlgBEd0BsiePsTyhoOR0yRxoX8VfGklXPnv/r
         hY/Q8YSJ+90UhuyY9dKPiMyp/E4I/1rPKK4lT6Y830lXWR3SQRYO1FW+/8hYplPAMSCA
         OmCYER7wWLbc1zSFY0dEFEbnsG2DYJOt/vrigjDtvZTgyPWXC1e/SyZgvIThAg0rwCH5
         Q++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=dsAxR51ixQcvVJpqlcuXY2s4JPlIko9SjEdBahO2kmI=;
        b=gnt5CCMEck8+6xC3UiVBpB98S6RnJ/2tWq5x677TtSkxNuxzWAZmNAPV0bvleeV3c/
         pIg3+0FCaugURWLeiyCC6r/4lz0MCMxkrm/faxDFuPjv+WI8Z1zGllkD+gOCNTVQgQBK
         s8ztwcndigph86k7IVNiWkQgMe1UC60YG9y8EP2xH5+tk+wSdiBe2V0sybgDKchYqHui
         ct2nFDbx41KPilVHXmgcZ9RtAkrOsVnDX/eFU89EQcG7b6og8yOYtJf/dOcB2PeTNhrv
         7s5oWn8R2B207OjQzvw/KHYcl6rsLhbHIJKb7PpWsohdHjF/sU2e+M687KNM3AkaG0tb
         Yiew==
X-Gm-Message-State: AOUpUlFC18biypyADidu1kC0/utj1Ln8mbvaWogqm5oi0fq4YUihBe1j
        jsqd4W9r6uD9QvqCsyvusQWpb6fZefXBpXOnbXe8eVBnSOLk2Q/iTOPUNUO+mr8MRt9xiuwNErY
        +jxDDpuBO/zvRdG8N78NBX59EJRUu1LyifrHDqsV82WZtt8EZnWkJmlUXlAyu
X-Google-Smtp-Source: AAOMgpeHn29//vl8NH00iE51fOWDMmgJfTbRCgSnsWUX41rukYYv8QujDnamN23+3pLw8BweniSChmYmwDiE
MIME-Version: 1.0
X-Received: by 2002:ab0:2102:: with SMTP id d2-v6mr1729754ual.6.1531424885057;
 Thu, 12 Jul 2018 12:48:05 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:47:51 -0700
In-Reply-To: <20180712194754.71979-1-sbeller@google.com>
Message-Id: <20180712194754.71979-4-sbeller@google.com>
References: <20180712194754.71979-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 3/6] builtin/submodule--helper: factor out submodule updating
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

