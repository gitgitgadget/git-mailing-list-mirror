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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA83C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2C723AAC
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbhAHUEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbhAHUEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:54 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9FC0612AF
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 91so10127751wrj.7
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jr9QSNZH0hJrEkZSU/fGXnrjyJtEjvE16udnwVcQxKA=;
        b=vWxvH/KQJh0gHLdEOCHns7Fd3q3WRiuuJXmjpmMsvYfphas/7ztHaS6P0KznlbTg4X
         UdFnOqKWaEiIAYS5+m/qhLgCJFr49pdIXyY++9pv2fWakjY7QlIaquyv0w140ifEwDGu
         fz4TP7Njwk/ApGZLGNyU1yeNILkkMTUY4JvcosGxo996RIyN2DOiGjRiO6Dh6fnxxMJJ
         sAsYkjuXrkkmigZYYfPHV9Ymqfa9go+vvyM1zZiAEF+GqOqezc7KIH7nC9zhIkQ48g/u
         Q+2aeVs8NEH0rWJPso7BxnLPZte86y3RglGDKLHBa7lTDS8Gooy5hmmFjURN9JO0M8kO
         kjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jr9QSNZH0hJrEkZSU/fGXnrjyJtEjvE16udnwVcQxKA=;
        b=Khew5SWaGXOwrm6tc2h9gzFUKASTvQtn3/jCTWowQN+8gz4twgkPoXaAlMQ72GuXqu
         65+EkGxfyrLA84MZjJFTkN8PzVwdy66A03WwsLRFTgsQ1e4tAcrWnC8UcJKtOOMM/76K
         CgiBQuuUdpXmiU5BMeHGhCLSayId81KaGIN2dTZAl0t2rrvKEi4GkafLFu2lGsw4tIzW
         46oqetKhq5smFLKIg6eojG4SbuRQmaJD1og1E8KSFl4v8iNTxRxfmXCBTkaEPq8UXA1e
         wwNADqEaaSkZESVIRsbh7NDc2qZwvuc+jfo3CjRxoJbsgREkU4JcA1+3b3wy2Cb9VtE1
         u0JQ==
X-Gm-Message-State: AOAM532Qoazkk/dJHzvFFpnIawKCW13NDdZhLBhbf2IOcT25z547rxNJ
        vc9WSkgrOSgrwm/m83nEtYcgSZZYwfg=
X-Google-Smtp-Source: ABdhPJxL1q/C2cPODntO+IdCOSh0DVJiCy9IXyWtDIeDFNmN78/Bbx3fkeCS9UEvx5+YxOcDeSMPQQ==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr5266365wrp.401.1610136192417;
        Fri, 08 Jan 2021 12:03:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o125sm13090315wmo.30.2021.01.08.12.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:11 -0800 (PST)
Message-Id: <414ef816845b6e08dd0e3d9316f8ba3b9ae7d996.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:57 +0000
Subject: [PATCH v3 14/14] update-index: remove static globals from callbacks
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
that contains a 'repo' member, ready to use. This takes the place of
the previous 'struct refresh_params' which served only to group the
'flags' and 'has_errors' ints. We also collect other one-off settings,
but only those that require access to the index or repository in their
operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 104 ++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3e01d62865f..2c67a870cdc 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -780,18 +780,20 @@ static int do_reupdate(struct repository *repo,
 	return 0;
 }
 
-struct refresh_params {
+struct callback_data {
+	struct repository *repo;
+
 	unsigned int flags;
-	int *has_errors;
+	unsigned int has_errors;
+	unsigned nul_term_line;
+	unsigned read_from_stdin;
 };
 
-static struct repository *repo;
-
-static int refresh(struct refresh_params *o, unsigned int flag)
+static int refresh(struct callback_data *cd, unsigned int flag)
 {
 	setup_work_tree();
-	repo_read_index(repo);
-	*o->has_errors |= refresh_index(repo->index, o->flags | flag,
+	repo_read_index(cd->repo);
+	cd->has_errors |= refresh_index(cd->repo->index, cd->flags | flag,
 					NULL, NULL, NULL);
 	return 0;
 }
@@ -813,7 +815,7 @@ static int really_refresh_callback(const struct option *opt,
 }
 
 static int chmod_callback(const struct option *opt,
-				const char *arg, int unset)
+			  const char *arg, int unset)
 {
 	char *flip = opt->value;
 	BUG_ON_OPT_NEG(unset);
@@ -824,11 +826,12 @@ static int chmod_callback(const struct option *opt,
 }
 
 static int resolve_undo_clear_callback(const struct option *opt,
-				const char *arg, int unset)
+				       const char *arg, int unset)
 {
+	struct callback_data *cd = opt->value;
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	resolve_undo_clear_index(repo->index);
+	resolve_undo_clear_index(cd->repo->index);
 	return 0;
 }
 
@@ -863,12 +866,13 @@ static enum parse_opt_result cacheinfo_callback(
 	struct object_id oid;
 	unsigned int mode;
 	const char *path;
+	struct callback_data *cd = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
 	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
-		if (add_cacheinfo(repo->index, mode, &oid, path, 0))
+		if (add_cacheinfo(cd->repo->index, mode, &oid, path, 0))
 			die("git update-index: --cacheinfo cannot add %s", path);
 		ctx->argv++;
 		ctx->argc--;
@@ -878,7 +882,7 @@ static enum parse_opt_result cacheinfo_callback(
 		return error("option 'cacheinfo' expects <mode>,<sha1>,<path>");
 	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
 	    get_oid_hex(*++ctx->argv, &oid) ||
-	    add_cacheinfo(repo->index, mode, &oid, *++ctx->argv, 0))
+	    add_cacheinfo(cd->repo->index, mode, &oid, *++ctx->argv, 0))
 		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
 	ctx->argc -= 3;
 	return 0;
@@ -888,7 +892,7 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	struct parse_opt_ctx_t *ctx, const struct option *opt,
 	const char *arg, int unset)
 {
-	int *nul_term_line = opt->value;
+	struct callback_data *cd = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
@@ -896,7 +900,7 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
 	allow_add = allow_replace = allow_remove = 1;
-	read_index_info(repo->index, *nul_term_line);
+	read_index_info(cd->repo->index, cd->nul_term_line);
 	return 0;
 }
 
@@ -904,14 +908,14 @@ static enum parse_opt_result stdin_callback(
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
 
@@ -919,17 +923,17 @@ static enum parse_opt_result unresolve_callback(
 	struct parse_opt_ctx_t *ctx, const struct option *opt,
 	const char *arg, int unset)
 {
-	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
+	struct callback_data *cd = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
-	*has_errors = do_unresolve(repo, ctx->argc, ctx->argv,
-				   prefix, prefix ? strlen(prefix) : 0);
-	if (*has_errors)
-		repo->index->cache_changed = 0;
+	cd->has_errors = do_unresolve(cd->repo, ctx->argc, ctx->argv,
+				      prefix, prefix ? strlen(prefix) : 0);
+	if (cd->has_errors)
+		cd->repo->index->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -940,17 +944,17 @@ static enum parse_opt_result reupdate_callback(
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
-	*has_errors = do_reupdate(repo, ctx->argc, ctx->argv, prefix);
-	if (*has_errors)
-		repo->index->cache_changed = 0;
+	cd->has_errors = do_reupdate(cd->repo, ctx->argc, ctx->argv, prefix);
+	if (cd->has_errors)
+		cd->repo->index->cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -959,13 +963,13 @@ static enum parse_opt_result reupdate_callback(
 
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
@@ -974,11 +978,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
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
@@ -987,18 +992,18 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
@@ -1027,30 +1032,30 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
@@ -1082,8 +1087,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	repo = the_repository;
-
 	/* we will diagnose later if it turns out that we need to update it */
 	newfd = repo_hold_locked_index(repo, &lock_file, 0);
 	if (newfd < 0)
@@ -1094,6 +1097,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("cache corrupted");
 
 	repo->index->updated_skipworktree = 1;
+	cd.repo = repo;
+	cd.flags = 0;
+	cd.has_errors = 0;
+	cd.nul_term_line = 0;
+	cd.read_from_stdin = 0;
 
 	/*
 	 * Custom copy of parse_options() because we want to handle
@@ -1139,7 +1147,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 	argc = parse_options_end(&ctx);
 
-	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
+	getline_fn = cd.nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
 	if (preferred_index_format) {
 		if (preferred_index_format < INDEX_FORMAT_LB ||
 		    INDEX_FORMAT_UB < preferred_index_format)
@@ -1152,14 +1160,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		repo->index->version = preferred_index_format;
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
@@ -1238,7 +1246,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	if (repo->index->cache_changed || force_write) {
 		if (newfd < 0) {
-			if (refresh_args.flags & REFRESH_QUIET)
+			if (cd.flags & REFRESH_QUIET)
 				exit(128);
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
@@ -1248,5 +1256,5 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	rollback_lock_file(&lock_file);
 
-	return has_errors ? 1 : 0;
+	return cd.has_errors ? 1 : 0;
 }
-- 
gitgitgadget
