Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28389C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbiA1M5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiA1M46 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BAC061758
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l5so9670369edv.3
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVoW9GPGkHQ808jEOw+kAjTiHQ5bYKHY0uZ9U1bkW7Q=;
        b=kd57kZwbyeMLaa06OxvO7Eawf/KBkyRU/AOMRMSNWPC+JKNRn+8NHXJNh3CdxGX/qA
         2GYv6tdE9JJ/DIfxbOZK29gQ3OT+9Vc/btbaqOlnA+9DsSqID6LmQOZ+JqTufgj30jy9
         eOu2NZf/TCXA8PSuGtDAM3hBPU/UOrY2z+n9UOgdcAw8WfxGcGd5u1fBA9dCovro+mF7
         VCLtGulpjndb9FcSWmh2qCc+b5XGL0yUr3K8NlK/TVGbTUMK/94TGSjWQpMhYupFgRs5
         ft3L09PzwRuDjoeYG+lOLqPSU7edlrsGMR8JdM+6Vsnjo4mFpO1ioeSYbgKwQhZVDIub
         88YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVoW9GPGkHQ808jEOw+kAjTiHQ5bYKHY0uZ9U1bkW7Q=;
        b=jV+zueIB8teJwmVUyt/lviWVQ8d28N2CyVYDrBaGohvXuuX35KBSoZci5dHEOQWu2h
         ovnGXTPXYfm/SHgyHfJGuXGt1PazgdugAGBi+FC+QuKOjDQisjrWQ6QidTLXutzhmsPM
         kmQUUIhM28vbBlAS0rI/cyVj5S19w5t1qE/WdWa4HB7dThlZBEmP1KZIoFjoQde2HjnV
         juHSdbBDw6/GTdRnsN9GzTwLtiFogv0o9w22g5zxD3gTMI5/cyQgt0kuDSOUfKHXH8Pb
         2YFavskyguo2Ma+N7WF/NCNWj0yibdZTBvbwxDQkdSyS9gfOFmEuIXApM9HCo1YqCqMn
         JtsA==
X-Gm-Message-State: AOAM532B9tKAOITROdtwgZW9rKT3EoU0aoRVzveohp+MgQrKdJ/9Z58E
        nz1YIqkGZ/O2TX6nSLEcGscAsIRUdd95iw==
X-Google-Smtp-Source: ABdhPJxF/olaDAQ8Nxo3a3qMuXFrd+8Okp5GNnb6b29DPYDKw1+E9OoAVg5LN2Zv1WP0s+GBD8ecjA==
X-Received: by 2002:aa7:cd08:: with SMTP id b8mr7819849edw.265.1643374615144;
        Fri, 28 Jan 2022 04:56:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 9/9] submodule: move core cmd_update() logic to C
Date:   Fri, 28 Jan 2022 13:56:40 +0100
Message-Id: <patch-v5-9.9-e8e57606ee9-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

This patch completes the conversion past the flag parsing of
`submodule update` by introducing a helper subcommand called
`submodule--helper update`. The behaviour of `submodule update` should
remain the same after this patch.

We add more fields to the `struct update_data` that are required by
`struct submodule_update_clone` to be able to perform a clone, when that
is needed to be done.

Recursing on a submodule is done by calling a subprocess that launches
`submodule--helper update`, with a modified `--recursive-prefix` and
`--prefix` parameter.

We also introduce `update_submodules2()` and `update_submodule2()`
which will supersede `update_submodules()` and `update_submodule()`.

When the `--init` flag is passed to the subcommand, we do not spawn a
new subprocess and call `submodule--helper init` on the submodule paths,
because the Git machinery is not able to pick up the configuration
changes introduced by that init call[1]. So we instead run the
`init_submodule_cb()` callback over each submodule in the same process.

While we are at it, we also remove the fetch_in_submodule() shell
function since it is no longer used anywhere.

[1] https://lore.kernel.org/git/CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com/

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 599 +++++++++++++++++++++---------------
 git-submodule.sh            | 145 +--------
 2 files changed, 356 insertions(+), 388 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4a0890954e9..1c28b6f479c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -71,21 +71,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository);
 }
 
-static int print_default_remote(int argc, const char **argv, const char *prefix)
-{
-	char *remote;
-
-	if (argc != 1)
-		die(_("submodule--helper print-default-remote takes no arguments"));
-
-	remote = get_default_remote();
-	if (remote)
-		printf("%s\n", remote);
-
-	free(remote);
-	return 0;
-}
-
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -1965,29 +1950,6 @@ static void determine_submodule_update_strategy(struct repository *r,
 	free(key);
 }
 
-static int module_update_module_mode(int argc, const char **argv, const char *prefix)
-{
-	const char *path, *update = NULL;
-	int just_cloned;
-	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
-
-	if (argc < 3 || argc > 4)
-		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
-
-	just_cloned = git_config_int("just_cloned", argv[1]);
-	path = argv[2];
-
-	if (argc == 4)
-		update = argv[3];
-
-	determine_submodule_update_strategy(the_repository,
-					    just_cloned, path, update,
-					    &update_strategy);
-	fputs(submodule_strategy_to_string(&update_strategy), stdout);
-
-	return 0;
-}
-
 struct update_clone_data {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -2015,7 +1977,6 @@ struct submodule_update_clone {
 	const char *prefix;
 	int single_branch;
 
-	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
 	int update_clone_nr; int update_clone_alloc;
 
@@ -2038,6 +1999,7 @@ struct submodule_update_clone {
 }
 
 struct update_data {
+	const char *prefix;
 	const char *recursive_prefix;
 	const char *sm_path;
 	const char *displaypath;
@@ -2045,13 +2007,54 @@ struct update_data {
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
 	int depth;
+	int recommend_shallow;
+	int single_branch;
+	int max_jobs;
+	unsigned int init;
 	unsigned int force;
 	unsigned int quiet;
 	unsigned int nofetch;
 	unsigned int just_cloned;
+	unsigned int remote;
+	unsigned int recursive;
+	unsigned int progress;
+	unsigned int dissociate;
+	unsigned int require_init;
+	unsigned warn_if_uninitialized ;
+	struct string_list references;
+	struct module_list list;
 };
 #define UPDATE_DATA_INIT { \
+	.list = MODULE_LIST_INIT, \
 	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
+	.recommend_shallow = -1, \
+	.references = STRING_LIST_INIT_DUP, \
+	.single_branch = -1, \
+	.max_jobs = 1, \
+}
+
+static void update_clone_from_update_data(struct submodule_update_clone *suc,
+					  struct update_data *update_data)
+{
+	suc->prefix = update_data->prefix;
+	suc->recursive_prefix = update_data->recursive_prefix;
+	suc->max_jobs = update_data->max_jobs;
+	suc->progress = update_data->progress;
+	suc->quiet = update_data->quiet;
+	suc->dissociate = update_data->dissociate;
+	suc->require_init = update_data->require_init;
+	suc->single_branch = update_data->single_branch;
+	suc->warn_if_uninitialized = update_data->warn_if_uninitialized;
+	suc->list = update_data->list;
+	suc->update = update_data->update_strategy;
+	suc->recommend_shallow = update_data->recommend_shallow;
+	if (update_data->depth)
+		suc->depth = xstrfmt("--depth=%d", update_data->depth);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			string_list_append(&suc->references, item->string);
+	}
 }
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
@@ -2352,8 +2355,15 @@ static int run_update_command(struct update_data *ud, int subforce)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
 	int must_die_on_failure = 0;
+	struct submodule_update_strategy strategy = SUBMODULE_UPDATE_STRATEGY_INIT;
 
-	switch (ud->update_strategy.type) {
+	if (ud->update_strategy.type == SM_UPDATE_UNSPECIFIED || ud->just_cloned)
+		determine_submodule_update_strategy(the_repository, ud->just_cloned,
+						    ud->sm_path, NULL, &strategy);
+	else
+		strategy = ud->update_strategy;
+
+	switch (strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		cp.git_cmd = 1;
 		strvec_pushl(&cp.args, "checkout", "-q", NULL);
@@ -2376,55 +2386,54 @@ static int run_update_command(struct update_data *ud, int subforce)
 		break;
 	case SM_UPDATE_COMMAND:
 		cp.use_shell = 1;
-		strvec_push(&cp.args, ud->update_strategy.command);
+		strvec_push(&cp.args, strategy.command);
 		must_die_on_failure = 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		    submodule_strategy_to_string(&strategy));
 	}
 	strvec_push(&cp.args, oid);
 
 	cp.dir = xstrdup(ud->sm_path);
 	prepare_submodule_repo_env(&cp.env_array);
 	if (run_command(&cp)) {
-		switch (ud->update_strategy.type) {
+		switch (strategy.type) {
 		case SM_UPDATE_CHECKOUT:
-			printf(_("Unable to checkout '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
+				    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_REBASE:
-			printf(_("Unable to rebase '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			if (!must_die_on_failure)
+				break;
+			die(_("Unable to rebase '%s' in submodule path '%s'"),
+			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_MERGE:
-			printf(_("Unable to merge '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			if (!must_die_on_failure)
+				break;
+			die(_("Unable to merge '%s' in submodule path '%s'"),
+			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_COMMAND:
-			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
-			       ud->update_strategy.command, oid, ud->displaypath);
+			if (!must_die_on_failure)
+				break;
+			die(_("Execution of '%s %s' failed in submodule path '%s'"),
+			    strategy.command, oid, ud->displaypath);
 			break;
 		default:
 			BUG("unexpected update strategy type: %s",
-			    submodule_strategy_to_string(&ud->update_strategy));
+			    submodule_strategy_to_string(&strategy));
 		}
-		/*
-		 * NEEDSWORK: We are currently printing to stdout with error
-		 * return so that the shell caller handles the error output
-		 * properly. Once we start handling the error messages within
-		 * C, we should use die() instead.
-		 */
-		if (must_die_on_failure)
-			return 2;
-		/*
-		 * This signifies to the caller in shell that the command
-		 * failed without dying
-		 */
+
+		/* the command failed, but update must continue */
 		return 1;
 	}
 
-	switch (ud->update_strategy.type) {
+	if (ud->quiet)
+		return 0;
+
+	switch (strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		printf(_("Submodule path '%s': checked out '%s'\n"),
 		       ud->displaypath, oid);
@@ -2439,17 +2448,17 @@ static int run_update_command(struct update_data *ud, int subforce)
 		break;
 	case SM_UPDATE_COMMAND:
 		printf(_("Submodule path '%s': '%s %s'\n"),
-		       ud->displaypath, ud->update_strategy.command, oid);
+		       ud->displaypath, strategy.command, oid);
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		    submodule_strategy_to_string(&strategy));
 	}
 
 	return 0;
 }
 
-static int do_run_update_procedure(struct update_data *ud)
+static int run_update_procedure(struct update_data *ud)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2479,178 +2488,6 @@ static int do_run_update_procedure(struct update_data *ud)
 	return run_update_command(ud, subforce);
 }
 
-static void update_submodule(struct update_clone_data *ucd)
-{
-	fprintf(stdout, "dummy %s %d\t%s\n",
-		oid_to_hex(&ucd->oid),
-		ucd->just_cloned,
-		ucd->sub->path);
-}
-
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
-	return update_submodules(&opt);
-}
-
-static int run_update_procedure(int argc, const char **argv, const char *prefix)
-{
-	char *prefixed_path, *update = NULL;
-	struct update_data opt = UPDATE_DATA_INIT;
-
-	struct option options[] = {
-		OPT__QUIET(&opt.quiet,
-			   N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&opt.force, N_("force checkout updates"),
-			   0),
-		OPT_BOOL('N', "no-fetch", &opt.nofetch,
-			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
-			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
-			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &opt.suboid, N_("subsha1"),
-			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_END()
-	};
-
-	const char *const usage[] = {
-		N_("git submodule--helper run-update-procedure [<options>] <path>"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc != 1)
-		usage_with_options(usage, options);
-
-	opt.sm_path = argv[0];
-
-	if (opt.recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", opt.recursive_prefix, opt.sm_path);
-	else
-		prefixed_path = xstrdup(opt.sm_path);
-
-	opt.displaypath = get_submodule_displaypath(prefixed_path, prefix);
-
-	determine_submodule_update_strategy(the_repository, opt.just_cloned,
-					    opt.sm_path, update,
-					    &opt.update_strategy);
-
-	free(prefixed_path);
-
-	if (!oideq(&opt.oid, &opt.suboid) || opt.force)
-		return do_run_update_procedure(&opt);
-
-	return 3;
-}
-
-static int resolve_relative_path(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf sb = STRBUF_INIT;
-	if (argc != 3)
-		die("submodule--helper relative-path takes exactly 2 arguments, got %d", argc);
-
-	printf("%s", relative_path(argv[1], argv[2], &sb));
-	strbuf_release(&sb);
-	return 0;
-}
-
 static const char *remote_submodule_branch(const char *path)
 {
 	const struct submodule *sub;
@@ -2783,17 +2620,11 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+static void ensure_core_worktree(const char *path)
 {
-	const char *path;
 	const char *cw;
 	struct repository subrepo;
 
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-
 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
@@ -2813,8 +2644,6 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
-
-	return 0;
 }
 
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
@@ -3001,6 +2830,271 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
+static void update_data_to_args(struct update_data *update_data, struct strvec *args)
+{
+	const char *update = submodule_strategy_to_string(&update_data->update_strategy);
+
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
+	if (update_data->prefix)
+		strvec_pushl(args, "--prefix", update_data->prefix, NULL);
+	if (update_data->recursive_prefix)
+		strvec_pushl(args, "--recursive-prefix",
+			     update_data->recursive_prefix, NULL);
+	if (update_data->quiet)
+		strvec_push(args, "--quiet");
+	if (update_data->force)
+		strvec_push(args, "--force");
+	if (update_data->init)
+		strvec_push(args, "--init");
+	if (update_data->remote)
+		strvec_push(args, "--remote");
+	if (update_data->nofetch)
+		strvec_push(args, "--no-fetch");
+	if (update_data->dissociate)
+		strvec_push(args, "--dissociate");
+	if (update_data->progress)
+		strvec_push(args, "--progress");
+	if (update_data->require_init)
+		strvec_push(args, "--require-init");
+	if (update_data->depth)
+		strvec_pushf(args, "--depth=%d", update_data->depth);
+	if (update)
+		strvec_pushl(args, "--update", update, NULL);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			strvec_pushl(args, "--reference", item->string, NULL);
+	}
+	if (update_data->recommend_shallow == 0)
+		strvec_push(args, "--no-recommend-shallow");
+	else if (update_data->recommend_shallow == 1)
+		strvec_push(args, "--recommend-shallow");
+	if (update_data->single_branch >= 0)
+		strvec_push(args, "--single-branch");
+}
+
+static int update_submodule(struct update_data *update_data)
+{
+	char *prefixed_path;
+
+	ensure_core_worktree(update_data->sm_path);
+
+	if (update_data->recursive_prefix)
+		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
+					update_data->sm_path);
+	else
+		prefixed_path = xstrdup(update_data->sm_path);
+
+	update_data->displaypath = get_submodule_displaypath(prefixed_path,
+							     update_data->prefix);
+	free(prefixed_path);
+
+	if (update_data->just_cloned) {
+		oidcpy(&update_data->suboid, null_oid());
+	} else {
+		if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+			die(_("Unable to find current revision in submodule path '%s'"),
+			    update_data->displaypath);
+	}
+
+	if (update_data->remote) {
+		char *remote_name = get_default_remote_submodule(update_data->sm_path);
+		const char *branch = remote_submodule_branch(update_data->sm_path);
+		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+
+		if (!update_data->nofetch) {
+			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
+					      0, NULL))
+				die(_("Unable to fetch in submodule path '%s'"),
+				    update_data->sm_path);
+		}
+
+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
+			die(_("Unable to find %s revision in submodule path '%s'"),
+			    remote_ref, update_data->sm_path);
+
+		free(remote_ref);
+	}
+
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+		if (run_update_procedure(update_data))
+			return 1;
+
+	if (update_data->recursive) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct update_data next = *update_data;
+		int res;
+
+		if (update_data->recursive_prefix)
+			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
+						update_data->sm_path);
+		else
+			prefixed_path = xstrfmt("%s/", update_data->sm_path);
+
+		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
+								  update_data->prefix);
+		next.prefix = NULL;
+		oidcpy(&next.oid, null_oid());
+		oidcpy(&next.suboid, null_oid());
+
+		cp.dir = update_data->sm_path;
+		cp.git_cmd = 1;
+		prepare_submodule_repo_env(&cp.env_array);
+		update_data_to_args(&next, &cp.args);
+
+		/* die() if child process die()'d */
+		res = run_command(&cp);
+		if (!res)
+			return 0;
+		die_message(_("Failed to recurse into submodule path '%s'"),
+			    update_data->displaypath);
+		if (res == 128)
+			exit(res);
+		else if (res)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int update_submodules(struct update_data *update_data)
+{
+	int i, res = 0;
+	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+
+	update_clone_from_update_data(&suc, update_data);
+	run_processes_parallel_tr2(suc.max_jobs, update_clone_get_next_task,
+				   update_clone_start_failure,
+				   update_clone_task_finished, &suc, "submodule",
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
+	if (suc.quickstop) {
+		res = 1;
+		goto cleanup;
+	}
+
+	for (i = 0; i < suc.update_clone_nr; i++) {
+		struct update_clone_data ucd = suc.update_clone[i];
+
+		oidcpy(&update_data->oid, &ucd.oid);
+		update_data->just_cloned = ucd.just_cloned;
+		update_data->sm_path = ucd.sub->path;
+
+		if (update_submodule(update_data))
+			res = 1;
+	}
+
+cleanup:
+	string_list_clear(&update_data->references, 0);
+	return res;
+}
+
+static int module_update(int argc, const char **argv, const char *prefix)
+{
+	const char *update = NULL;
+	struct pathspec pathspec;
+	struct update_data opt = UPDATE_DATA_INIT;
+
+	struct option module_update_clone_options[] = {
+		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
+		OPT_BOOL(0, "init", &opt.init,
+			 N_("initialize uninitialized submodules before update")),
+		OPT_BOOL(0, "remote", &opt.remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
+		OPT_BOOL(0, "recursive", &opt.recursive,
+			 N_("traverse submodules recursively")),
+		OPT_BOOL('N', "no-fetch", &opt.nofetch,
+			 N_("don't fetch new objects from the remote site")),
+		OPT_STRING(0, "prefix", &opt.prefix,
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
+				N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &opt.dissociate,
+			 N_("use --reference only while cloning")),
+		OPT_INTEGER(0, "depth", &opt.depth,
+			    N_("create a shallow clone truncated to the "
+			       "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &opt.max_jobs,
+			    N_("parallel jobs")),
+		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
+			 N_("whether the initial clone should follow the shallow recommendation")),
+		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
+		OPT_BOOL(0, "progress", &opt.progress,
+			 N_("force cloning progress")),
+		OPT_BOOL(0, "require-init", &opt.require_init,
+			 N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &opt.single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+
+	update_clone_config_from_gitmodules(&opt.max_jobs);
+	git_config(git_update_clone_config, &opt.max_jobs);
+
+	argc = parse_options(argc, argv, prefix, module_update_clone_options,
+			     git_submodule_helper_usage, 0);
+	oidcpy(&opt.oid, null_oid());
+	oidcpy(&opt.suboid, null_oid());
+
+	if (update)
+		if (parse_submodule_update_strategy(update,
+						    &opt.update_strategy) < 0)
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
@@ -3388,16 +3482,11 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update-module-mode", module_update_module_mode, 0},
-	{"update-clone", update_clone, 0},
-	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
-	{"relative-path", resolve_relative_path, 0},
+	{"update", module_update, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66a..bcd8b92aabd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -246,20 +246,6 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
-# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
-# Because arguments are positional, use an empty string to omit <depth>
-# but include <sha1>.
-fetch_in_submodule () (
-	sanitize_submodule_env &&
-	cd "$1" &&
-	if test $# -eq 3
-	then
-		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
-	else
-		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
-	fi
-)
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -361,133 +347,26 @@ cmd_update()
 		shift
 	done
 
-	if test -n "$init"
-	then
-		cmd_init "--" "$@" || return
-	fi
-
-	{
-	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
-		${progress:+"--progress"} \
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper update \
+		${GIT_QUIET:+--quiet} \
+		${force:+--force} \
+		${progress:+--progress} \
+		${dissociate:+--dissociate} \
+		${remote:+--remote} \
+		${recursive:+--recursive} \
+		${init:+--init} \
+		${require_init:+--require-init} \
+		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
-		${dissociate:+"--dissociate"} \
-		${depth:+--depth "$depth"} \
-		${require_init:+--require-init} \
+		${depth:+"$depth"} \
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
 		-- \
-		"$@" || echo "#unmatched" $?
-	} | {
-	err=
-	while read -r quickabort sha1 just_cloned sm_path
-	do
-		die_if_unmatched "$quickabort" "$sha1"
-
-		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
-
-		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-
-		if test $just_cloned -eq 1
-		then
-			subsha1=
-		else
-			just_cloned=
-			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify HEAD) ||
-			die "fatal: $(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
-		fi
-
-		if test -n "$remote"
-		then
-			branch=$(git submodule--helper remote-branch "$sm_path")
-			if test -z "$nofetch"
-			then
-				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" $depth ||
-				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
-			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
-			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
-		fi
-
-		out=$(git submodule--helper run-update-procedure \
-			  ${wt_prefix:+--prefix "$wt_prefix"} \
-			  ${GIT_QUIET:+--quiet} \
-			  ${force:+--force} \
-			  ${just_cloned:+--just-cloned} \
-			  ${nofetch:+--no-fetch} \
-			  ${depth:+"$depth"} \
-			  ${update:+--update "$update"} \
-			  ${prefix:+--recursive-prefix "$prefix"} \
-			  ${sha1:+--oid "$sha1"} \
-			  ${subsha1:+--suboid "$subsha1"} \
-			  "--" \
-			  "$sm_path")
-
-		# exit codes for run-update-procedure:
-		# 0: update was successful, say command output
-		# 1: update procedure failed, but should not die
-		# 2 or 128: subcommand died during execution
-		# 3: no update procedure was run
-		res="$?"
-		case $res in
-		0)
-			say "$out"
-			;;
-		1)
-			err="${err};fatal: $out"
-			continue
-			;;
-		2|128)
-			die_with_status $res "fatal: $out"
-			;;
-		esac
-
-		if test -n "$recursive"
-		then
-			(
-				prefix=$(git submodule--helper relative-path "$prefix$sm_path/" "$wt_prefix")
-				wt_prefix=
-				sanitize_submodule_env
-				cd "$sm_path" &&
-				eval cmd_update
-			)
-			res=$?
-			if test $res -gt 0
-			then
-				die_msg="fatal: $(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
-				if test $res -ne 2
-				then
-					err="${err};$die_msg"
-					continue
-				else
-					die_with_status $res "$die_msg"
-				fi
-			fi
-		fi
-	done
-
-	if test -n "$err"
-	then
-		OIFS=$IFS
-		IFS=';'
-		for e in $err
-		do
-			if test -n "$e"
-			then
-				echo >&2 "$e"
-			fi
-		done
-		IFS=$OIFS
-		exit 1
-	fi
-	}
+		"$@"
 }
 
 #
-- 
2.35.0.914.ge5c8aab0d5b

