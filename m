Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702ABC4332F
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350760AbiBHIlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350670AbiBHIkf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:35 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71DCC03FEC5
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:34 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u80-20020a627953000000b004c82105f20dso9282410pfc.11
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PwVv5DANedhFe1iffJX8jChxJU4YFztjSW+fYl5zs1g=;
        b=h3NuYBWUD8kzun4/amXdUhdCcBwGlA918sxxqZjCaGkx1r8zSR7m0gwpFuZDimai5H
         +OcJYLZ05qGSUiNPtfpqYYndagfuXK+uS4E/f8JiAhD39CAZX/9/2xrQLCh9fVJVKOki
         BuqwHDbhU0XXmm70bA9RHwtvYPWD/Ni47+gHfdm7YB1kiR7rpW0+kQmXEFXvmb+tTGzq
         VlWsy/FwJ0g/WGCWTBrUgArVKw129tLmVP8elCKewfNLbSUiCNXRPaLeMmfhGZRiIvjs
         ZaZN5a6Q3IX4gtTZeZOrdaF5aUtPuw/huezXYn2DMNoYSwJ5sfl6umVo/B4jt+LMrzQL
         tb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PwVv5DANedhFe1iffJX8jChxJU4YFztjSW+fYl5zs1g=;
        b=LaZoxin3mUR6CowA7Vd1hQqEakZ7anHdfYw7QBYQw57nZBUacQgNG7vWYkybTae49e
         Y+DVIcHiyYaPeQx5i0ZpcrC5/q3g4ZuuCsbzKjx6dgAJseeIKY5TjTGsQC8+I4NTfuKE
         2KQmJAwzGBYKBObYM6S/sWVxk5lrkhi7yjjfSL3vU0YIeQmgPlIsNi4NSW1mYDDjy/ji
         gtBNpCCmyW2N9rp9dxtrBX4QqBmW4/6CsgzQDPX4ySZA4nB5zRK1jgKRDlJlgeTPaS1H
         UyCA2fXvFRWYk8Y9bzFj/jVkWVk+xyGCxaXz5uupGiLpFFSeKYjEhcRBHFZSi6tUJPPI
         YQEA==
X-Gm-Message-State: AOAM533+4UHloRQ14t8rXgEWgwECPCxlu5By14OXSV/sGg+VMArN1Hpy
        PqIK+C5+xHtKFvI2c9DxRy5jMQ5t1q3SxFngyA3FnPY/KiQr9H2R0b7uRwSr2dzEk1vjjaFP4iz
        p+TKOpZKGkhYNy35Xy2mnimwTfNR/DO6PtpXBHSEv67wSGHMTXsEzX06HlBeest4=
X-Google-Smtp-Source: ABdhPJx7c4FBYyNndXPLLQcngr6aghOFL8EcFMj23DsnOC371/bgTpS0+wpNnJteHD8KU2BQzpgD2TxwHCMO3w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:5a64:: with SMTP id
 k36mr2616955pgm.408.1644309634237; Tue, 08 Feb 2022 00:40:34 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:51 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-16-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 15/16] submodule--helper: move functions around
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next commit will change the internals of several functions and
arrange them in a more logical manner. Move these functions to their
final positions so that the diff is smaller.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 228 ++++++++++++++++++------------------
 1 file changed, 114 insertions(+), 114 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5635f0c48b..0ab8f9d49f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2451,120 +2451,6 @@ static void update_submodule(struct update_clone_data *ucd)
 		ucd->sub->path);
 }
 
-static int update_submodules(struct submodule_update_clone *suc)
-{
-	int i;
-
-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
-				   update_clone_task_finished, suc, "submodule",
-				   "parallel/update");
-
-	/*
-	 * We saved the output and put it out all at once now.
-	 * That means:
-	 * - the listener does not have to interleave their (checkout)
-	 *   work with our fetching.  The writes involved in a
-	 *   checkout involve more straightforward sequential I/O.
-	 * - the listener can avoid doing any work if fetching failed.
-	 */
-	if (suc->quickstop)
-		return 1;
-
-	for (i = 0; i < suc->update_clone_nr; i++)
-		update_submodule(&suc->update_clone[i]);
-
-	return 0;
-}
-
-static int update_clone(int argc, const char **argv, const char *prefix)
-{
-	const char *update = NULL;
-	struct pathspec pathspec;
-	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
-
-	struct option module_update_clone_options[] = {
-		OPT_BOOL(0, "init", &opt.init,
-			 N_("initialize uninitialized submodules before update")),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
-			   N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
-			   N_("reference repository")),
-		OPT_BOOL(0, "dissociate", &opt.dissociate,
-			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &opt.depth, "<depth>",
-			   N_("create a shallow clone truncated to the "
-			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &opt.max_jobs,
-			    N_("parallel jobs")),
-		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
-			    N_("whether the initial clone should follow the shallow recommendation")),
-		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
-		OPT_BOOL(0, "progress", &opt.progress,
-			    N_("force cloning progress")),
-		OPT_BOOL(0, "require-init", &opt.require_init,
-			   N_("disallow cloning into non-empty directory")),
-		OPT_BOOL(0, "single-branch", &opt.single_branch,
-			 N_("clone only one branch, HEAD or --branch")),
-		OPT_END()
-	};
-
-	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
-		NULL
-	};
-	opt.prefix = prefix;
-
-	update_clone_config_from_gitmodules(&opt.max_jobs);
-	git_config(git_update_clone_config, &opt.max_jobs);
-
-	argc = parse_options(argc, argv, prefix, module_update_clone_options,
-			     git_submodule_helper_usage, 0);
-
-	if (update)
-		if (parse_submodule_update_strategy(update, &opt.update) < 0)
-			die(_("bad value for update parameter"));
-
-	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
-		return 1;
-
-	if (pathspec.nr)
-		opt.warn_if_uninitialized = 1;
-
-	if (opt.init) {
-		struct module_list list = MODULE_LIST_INIT;
-		struct init_cb info = INIT_CB_INIT;
-
-		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0)
-			return 1;
-
-		/*
-		 * If there are no path args and submodule.active is set then,
-		 * by default, only initialize 'active' modules.
-		 */
-		if (!argc && git_config_get_value_multi("submodule.active"))
-			module_list_active(&list);
-
-		info.prefix = opt.prefix;
-		info.superprefix = opt.recursive_prefix;
-		if (opt.quiet)
-			info.flags |= OPT_QUIET;
-
-		for_each_listed_submodule(&list, init_submodule_cb, &info);
-	}
-
-	return update_submodules(&opt);
-}
-
 /*
  * NEEDSWORK: Use a forward declaration to avoid moving
  * run_update_procedure() (which will be removed soon).
@@ -3021,6 +2907,120 @@ static int update_submodule2(struct update_data *update_data)
 	return 3;
 }
 
+static int update_submodules(struct submodule_update_clone *suc)
+{
+	int i;
+
+	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
+				   update_clone_start_failure,
+				   update_clone_task_finished, suc, "submodule",
+				   "parallel/update");
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
+	for (i = 0; i < suc->update_clone_nr; i++)
+		update_submodule(&suc->update_clone[i]);
+
+	return 0;
+}
+
+static int update_clone(int argc, const char **argv, const char *prefix)
+{
+	const char *update = NULL;
+	struct pathspec pathspec;
+	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
+
+	struct option module_update_clone_options[] = {
+		OPT_BOOL(0, "init", &opt.init,
+			 N_("initialize uninitialized submodules before update")),
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
+			   N_("path"),
+			   N_("path into the working tree, across nested "
+			      "submodule boundaries")),
+		OPT_STRING(0, "update", &update,
+			   N_("string"),
+			   N_("rebase, merge, checkout or none")),
+		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
+			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &opt.dissociate,
+			   N_("use --reference only while cloning")),
+		OPT_STRING(0, "depth", &opt.depth, "<depth>",
+			   N_("create a shallow clone truncated to the "
+			      "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &opt.max_jobs,
+			    N_("parallel jobs")),
+		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
+			    N_("whether the initial clone should follow the shallow recommendation")),
+		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
+		OPT_BOOL(0, "progress", &opt.progress,
+			    N_("force cloning progress")),
+		OPT_BOOL(0, "require-init", &opt.require_init,
+			   N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &opt.single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+	opt.prefix = prefix;
+
+	update_clone_config_from_gitmodules(&opt.max_jobs);
+	git_config(git_update_clone_config, &opt.max_jobs);
+
+	argc = parse_options(argc, argv, prefix, module_update_clone_options,
+			     git_submodule_helper_usage, 0);
+
+	if (update)
+		if (parse_submodule_update_strategy(update, &opt.update) < 0)
+			die(_("bad value for update parameter"));
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
+		return 1;
+
+	if (pathspec.nr)
+		opt.warn_if_uninitialized = 1;
+
+	if (opt.init) {
+		struct module_list list = MODULE_LIST_INIT;
+		struct init_cb info = INIT_CB_INIT;
+
+		if (module_list_compute(argc, argv, opt.prefix,
+					&pathspec, &list) < 0)
+			return 1;
+
+		/*
+		 * If there are no path args and submodule.active is set then,
+		 * by default, only initialize 'active' modules.
+		 */
+		if (!argc && git_config_get_value_multi("submodule.active"))
+			module_list_active(&list);
+
+		info.prefix = opt.prefix;
+		info.superprefix = opt.recursive_prefix;
+		if (opt.quiet)
+			info.flags |= OPT_QUIET;
+
+		for_each_listed_submodule(&list, init_submodule_cb, &info);
+	}
+
+	return update_submodules(&opt);
+}
+
 struct add_data {
 	const char *prefix;
 	const char *branch;
-- 
2.33.GIT

