Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A8CC433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF466227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbhAEEod (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbhAEEob (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB506C0617A7
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i9so34887139wrc.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TJlNRVfvQznY4xMUrb4h1llVXgrBaGfvjLTUs5lP0LI=;
        b=coayqL2hLJ06+1oaMnU3pZbR07B4n0kZwhih7J2Fu3OA7boqrVF3xpnGpVFdaU2AV2
         f7rF0Jau1CRR7qHfAjSk12atDkCpCJCEc+X7IgvnuTYNsix5exsqX861ugYqUnfWZ0vI
         CWXtJJZPp9CE6setFlx1L1PPizf9ME+wtL5CkSegfFmRJMe50fwKSuR1JuR23MWtWWn8
         kGvWyEMR2JLp2KxshMTSLJ4DvQxWmCi62cFliM/MPpr1/ViJAFo67IlHJ6sKru1TAP58
         v9wV2C8PI2yBehZlC2eDaXxRmtSOCs7LKZfDHKv9x1cNC4tgyh+CVbcETQ80UZcioKY3
         Ki/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TJlNRVfvQznY4xMUrb4h1llVXgrBaGfvjLTUs5lP0LI=;
        b=XinN4QP+tzUJ+VcWZqxTImzNGsAbQ+XkyjikWVwOdhPuHLazGSK3rMIJWi4rj/6qVk
         YR7irBZZOpFLtumorqO5e/bTByXbsOnCCyRyKJDyGly9gVCvKGIFnWo0JYnAXDBYY/Kr
         Fc2AFZjdFS5uBpk7bXOTq03uA7M8dMcjPjmEi+eiWqSiaWqhLUV4Ke9EAclcCNSEZR/h
         nFDsUZe0pn7DBGVOl9II8UgdmsbWPIqK3Ypr6JebNF7PeW+p5ISoWVrED1H5p0IGImDh
         LqQDNMDCpEQx/q5W69EhA5lUT2mijamOh3KhNuu1GdhvsNwcdGVsZsCg8PDEck9gCwH7
         HEcA==
X-Gm-Message-State: AOAM530UREuK+xRVTsPTLltr1eUrH72F0JCigx2jIwuu5qEgmwR9yBe8
        47jFxtuysJQGwamQuLXlytszXKi51RU=
X-Google-Smtp-Source: ABdhPJyYkQNW8Sa6uS9wxlZNOCtqsGWn03veD1SM/IDJDar82o+TUDOiNsw4MdBrJg3DPWgn+qmKMw==
X-Received: by 2002:a5d:58d3:: with SMTP id o19mr31679983wrf.250.1609821797171;
        Mon, 04 Jan 2021 20:43:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b19sm2348561wmj.37.2021.01.04.20.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:16 -0800 (PST)
Message-Id: <2b171a142b36b114d5ff526073fe3fd9517a4d32.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:43:03 +0000
Subject: [PATCH v2 14/14] update-index: remove static globals from callbacks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In order to remove index compatibility macros cleanly, we relied upon
static globals 'repo' and 'istate' to be pointers to the_repository and
the_index, respectively. We remove these static globals inside the
option parsing callbacks, which are the final uses in update-index.

The callbacks cannot change their method signature, so we must use the
value member of 'struct option', assigned in the array of option macros.
There are several callback methods that require at least one of 'repo'
and 'istate', but they use a variety of different data types for the
callback value.

Unify these callback methods to use a consistent 'struct callback_data'
that contains 'repo' and 'istate', ready to use. This takes the place of
the previous 'struct refresh_params' which served only to group the
'flags' and 'has_errors' ints. We also collect other one-off settings,
but only those that require access to the index or repository in their
operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 110 ++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 50 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index fb8d7879783..258db619a40 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -784,19 +784,21 @@ static int do_reupdate(struct repository *repo,
 	return 0;
 }
 
-struct refresh_params {
+struct callback_data {
+	struct repository *repo;
+	struct index_state *istate;
+
 	unsigned int flags;
-	int *has_errors;
+	unsigned int has_errors;
+	unsigned nul_term_line;
+	unsigned read_from_stdin;
 };
 
-static struct repository *repo;
-static struct index_state *istate;
-
-static int refresh(struct refresh_params *o, unsigned int flag)
+static int refresh(struct callback_data *cd, unsigned int flag)
 {
 	setup_work_tree();
-	repo_read_index(repo);
-	*o->has_errors |= refresh_index(istate, o->flags | flag,
+	repo_read_index(cd->repo);
+	cd->has_errors |= refresh_index(cd->istate, cd->flags | flag,
 					NULL, NULL, NULL);
 	return 0;
 }
@@ -818,7 +820,7 @@ static int really_refresh_callback(const struct option *opt,
 }
 
 static int chmod_callback(const struct option *opt,
-				const char *arg, int unset)
+			  const char *arg, int unset)
 {
 	char *flip = opt->value;
 	BUG_ON_OPT_NEG(unset);
@@ -829,11 +831,12 @@ static int chmod_callback(const struct option *opt,
 }
 
 static int resolve_undo_clear_callback(const struct option *opt,
-				const char *arg, int unset)
+				       const char *arg, int unset)
 {
+	struct callback_data *cd = opt->value;
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	resolve_undo_clear_index(istate);
+	resolve_undo_clear_index(cd->istate);
 	return 0;
 }
 
@@ -868,12 +871,13 @@ static enum parse_opt_result cacheinfo_callback(
 	struct object_id oid;
 	unsigned int mode;
 	const char *path;
+	struct callback_data *cd = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
 	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
-		if (add_cacheinfo(istate, mode, &oid, path, 0))
+		if (add_cacheinfo(cd->istate, mode, &oid, path, 0))
 			die("git update-index: --cacheinfo cannot add %s", path);
 		ctx->argv++;
 		ctx->argc--;
@@ -883,7 +887,7 @@ static enum parse_opt_result cacheinfo_callback(
 		return error("option 'cacheinfo' expects <mode>,<sha1>,<path>");
 	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
 	    get_oid_hex(*++ctx->argv, &oid) ||
-	    add_cacheinfo(istate, mode, &oid, *++ctx->argv, 0))
+	    add_cacheinfo(cd->istate, mode, &oid, *++ctx->argv, 0))
 		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
 	ctx->argc -= 3;
 	return 0;
@@ -893,7 +897,7 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	struct parse_opt_ctx_t *ctx, const struct option *opt,
 	const char *arg, int unset)
 {
-	int *nul_term_line = opt->value;
+	struct callback_data *cd = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
@@ -901,7 +905,7 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
 	allow_add = allow_replace = allow_remove = 1;
-	read_index_info(istate, *nul_term_line);
+	read_index_info(cd->istate, cd->nul_term_line);
 	return 0;
 }
 
@@ -909,14 +913,14 @@ static enum parse_opt_result stdin_callback(
 	struct parse_opt_ctx_t *ctx, const struct option *opt,
 	const char *arg, int unset)
 {
-	int *read_from_stdin = opt->value;
+	struct callback_data *cd = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
-	*read_from_stdin = 1;
+	cd->read_from_stdin = 1;
 	return 0;
 }
 
@@ -924,17 +928,17 @@ static enum parse_opt_result unresolve_callback(
 	struct parse_opt_ctx_t *ctx, const struct option *opt,
 	const char *arg, int unset)
 {
-	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
+	struct callback_data *cd = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
-	*has_errors = do_unresolve(repo, istate, ctx->argc, ctx->argv,
-				   prefix, prefix ? strlen(prefix) : 0);
-	if (*has_errors)
-		istate->cache_changed = 0;
+	cd->has_errors = do_unresolve(cd->repo, cd->istate, ctx->argc, ctx->argv,
+				      prefix, prefix ? strlen(prefix) : 0);
+	if (cd->has_errors)
+		cd->istate->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -945,17 +949,18 @@ static enum parse_opt_result reupdate_callback(
 	struct parse_opt_ctx_t *ctx, const struct option *opt,
 	const char *arg, int unset)
 {
-	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
+	struct callback_data *cd = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
 	setup_work_tree();
-	*has_errors = do_reupdate(repo, istate, ctx->argc, ctx->argv, prefix);
-	if (*has_errors)
-		istate->cache_changed = 0;
+	cd->has_errors = do_reupdate(cd->repo, cd->istate,
+				     ctx->argc, ctx->argv, prefix);
+	if (cd->has_errors)
+		cd->istate->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -964,13 +969,13 @@ static enum parse_opt_result reupdate_callback(
 
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
-	int newfd, entries, has_errors = 0, nul_term_line = 0;
+	struct repository *repo = the_repository;
+	struct callback_data cd;
+	int newfd, entries;
 	enum uc_mode untracked_cache = UC_UNSPECIFIED;
-	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
 	char set_executable_bit = 0;
-	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
 	int force_write = 0;
@@ -979,11 +984,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
+	struct index_state *istate;
+
 	struct option options[] = {
-		OPT_BIT('q', NULL, &refresh_args.flags,
+		OPT_BIT('q', NULL, &cd.flags,
 			N_("continue refresh even when index needs update"),
 			REFRESH_QUIET),
-		OPT_BIT(0, "ignore-submodules", &refresh_args.flags,
+		OPT_BIT(0, "ignore-submodules", &cd.flags,
 			N_("refresh: ignore submodules"),
 			REFRESH_IGNORE_SUBMODULES),
 		OPT_SET_INT(0, "add", &allow_add,
@@ -992,18 +999,18 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("let files replace directories and vice-versa"), 1),
 		OPT_SET_INT(0, "remove", &allow_remove,
 			N_("notice files missing from worktree"), 1),
-		OPT_BIT(0, "unmerged", &refresh_args.flags,
+		OPT_BIT(0, "unmerged", &cd.flags,
 			N_("refresh even if index contains unmerged entries"),
 			REFRESH_UNMERGED),
-		OPT_CALLBACK_F(0, "refresh", &refresh_args, NULL,
+		OPT_CALLBACK_F(0, "refresh", &cd, NULL,
 			N_("refresh stat information"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			refresh_callback),
-		OPT_CALLBACK_F(0, "really-refresh", &refresh_args, NULL,
+		OPT_CALLBACK_F(0, "really-refresh", &cd, NULL,
 			N_("like --refresh, but ignore assume-unchanged setting"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			really_refresh_callback),
-		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", NULL,
+		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", &cd,
 			N_("<mode>,<object>,<path>"),
 			N_("add the specified entry to the index"),
 			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
@@ -1032,30 +1039,30 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("add to index only; do not add content to object database"), 1),
 		OPT_SET_INT(0, "force-remove", &force_remove,
 			N_("remove named paths even if present in worktree"), 1),
-		OPT_BOOL('z', NULL, &nul_term_line,
+		OPT_BOOL('z', NULL, &cd.nul_term_line,
 			 N_("with --stdin: input lines are terminated by null bytes")),
-		{OPTION_LOWLEVEL_CALLBACK, 0, "stdin", &read_from_stdin, NULL,
+		{OPTION_LOWLEVEL_CALLBACK, 0, "stdin", &cd, NULL,
 			N_("read list of paths to be updated from standard input"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			NULL, 0, stdin_callback},
-		{OPTION_LOWLEVEL_CALLBACK, 0, "index-info", &nul_term_line, NULL,
+		{OPTION_LOWLEVEL_CALLBACK, 0, "index-info", &cd, NULL,
 			N_("add entries from standard input to the index"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			NULL, 0, stdin_cacheinfo_callback},
-		{OPTION_LOWLEVEL_CALLBACK, 0, "unresolve", &has_errors, NULL,
+		{OPTION_LOWLEVEL_CALLBACK, 0, "unresolve", &cd, NULL,
 			N_("repopulate stages #2 and #3 for the listed paths"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			NULL, 0, unresolve_callback},
-		{OPTION_LOWLEVEL_CALLBACK, 'g', "again", &has_errors, NULL,
+		{OPTION_LOWLEVEL_CALLBACK, 'g', "again", &cd, NULL,
 			N_("only update entries that differ from HEAD"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			NULL, 0, reupdate_callback},
-		OPT_BIT(0, "ignore-missing", &refresh_args.flags,
+		OPT_BIT(0, "ignore-missing", &cd.flags,
 			N_("ignore files missing from worktree"),
 			REFRESH_IGNORE_MISSING),
 		OPT_SET_INT(0, "verbose", &verbose,
 			N_("report actions to standard output"), 1),
-		OPT_CALLBACK_F(0, "clear-resolve-undo", NULL, NULL,
+		OPT_CALLBACK_F(0, "clear-resolve-undo", &cd, NULL,
 			N_("(for porcelains) forget saved unresolved conflicts"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			resolve_undo_clear_callback),
@@ -1087,8 +1094,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	repo = the_repository;
-
 	/* we will diagnose later if it turns out that we need to update it */
 	newfd = repo_hold_locked_index(repo, &lock_file, 0);
 	if (newfd < 0)
@@ -1098,8 +1103,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (entries < 0)
 		die("cache corrupted");
 
-	istate = repo->index;
+	cd.repo = repo;
+	cd.istate = istate = repo->index;
 	istate->updated_skipworktree = 1;
+	cd.flags = 0;
+	cd.has_errors = 0;
+	cd.nul_term_line = 0;
+	cd.read_from_stdin = 0;
 
 	/*
 	 * Custom copy of parse_options() because we want to handle
@@ -1145,7 +1155,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 	argc = parse_options_end(&ctx);
 
-	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
+	getline_fn = cd.nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
 	if (preferred_index_format) {
 		if (preferred_index_format < INDEX_FORMAT_LB ||
 		    INDEX_FORMAT_UB < preferred_index_format)
@@ -1158,14 +1168,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		istate->version = preferred_index_format;
 	}
 
-	if (read_from_stdin) {
+	if (cd.read_from_stdin) {
 		struct strbuf buf = STRBUF_INIT;
 		struct strbuf unquoted = STRBUF_INIT;
 
 		setup_work_tree();
 		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
-			if (!nul_term_line && buf.buf[0] == '"') {
+			if (!cd.nul_term_line && buf.buf[0] == '"') {
 				strbuf_reset(&unquoted);
 				if (unquote_c_style(&unquoted, buf.buf, NULL))
 					die("line is badly quoted");
@@ -1244,7 +1254,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	if (istate->cache_changed || force_write) {
 		if (newfd < 0) {
-			if (refresh_args.flags & REFRESH_QUIET)
+			if (cd.flags & REFRESH_QUIET)
 				exit(128);
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
@@ -1254,5 +1264,5 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	rollback_lock_file(&lock_file);
 
-	return has_errors ? 1 : 0;
+	return cd.has_errors ? 1 : 0;
 }
-- 
gitgitgadget
