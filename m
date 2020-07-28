Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A7C433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3B12065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgG1U23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:28:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:40262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgG1U23 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:28:29 -0400
Received: (qmail 29810 invoked by uid 109); 28 Jul 2020 20:28:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:28:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28707 invoked by uid 111); 28 Jul 2020 20:28:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:28:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:28:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/11] strvec: rename struct fields
Message-ID: <20200728202823.GK1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "argc" and "argv" names made sense when the struct was argv_array,
but now they're just confusing. Let's rename them to our usual "nr" and
"items" (which we use for string_list, as well as many ALLOC_GROW()
arrays).

Note that we have to update all of the callers immediately. Playing
tricks with the preprocessor is hard here, because we wouldn't want to
rewrite unrelated tokens.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm actually not that fond of "items". I almost went with just:

  const char **v;

as the variable name which contains it usually provides sufficient
context. But I worried that people would consider that too inscrutable.

 add-interactive.c           |  4 ++--
 add-patch.c                 |  8 +++----
 bisect.c                    |  2 +-
 builtin/add.c               |  2 +-
 builtin/am.c                | 16 +++++++-------
 builtin/annotate.c          |  2 +-
 builtin/bisect--helper.c    |  4 ++--
 builtin/clone.c             |  4 ++--
 builtin/commit.c            |  2 +-
 builtin/describe.c          |  6 ++---
 builtin/difftool.c          |  2 +-
 builtin/fetch.c             |  6 ++---
 builtin/gc.c                | 24 ++++++++++----------
 builtin/pack-objects.c      |  2 +-
 builtin/pull.c              | 16 +++++++-------
 builtin/rebase.c            | 16 +++++++-------
 builtin/receive-pack.c      | 14 ++++++------
 builtin/remote.c            |  4 ++--
 builtin/replace.c           |  2 +-
 builtin/show-branch.c       |  8 +++----
 builtin/stash.c             |  8 +++----
 builtin/submodule--helper.c |  6 ++---
 builtin/upload-archive.c    |  4 ++--
 builtin/worktree.c          |  6 ++---
 bundle.c                    |  2 +-
 commit.c                    |  2 +-
 connect.c                   | 16 +++++++-------
 daemon.c                    |  8 +++----
 diff.c                      |  2 +-
 environment.c               |  2 +-
 exec-cmd.c                  |  6 ++---
 git.c                       | 10 ++++-----
 graph.c                     |  4 ++--
 http-push.c                 |  2 +-
 ls-refs.c                   |  6 ++---
 merge.c                     |  2 +-
 pathspec.c                  |  2 +-
 range-diff.c                |  2 +-
 ref-filter.c                |  4 ++--
 remote-curl.c               |  6 ++---
 remote.c                    |  2 +-
 revision.c                  |  4 ++--
 run-command.c               | 20 ++++++++---------
 sequencer.c                 |  4 ++--
 serve.c                     |  6 ++---
 strvec.c                    | 44 ++++++++++++++++++-------------------
 strvec.h                    | 20 ++++++++---------
 submodule.c                 | 14 ++++++------
 t/helper/test-run-command.c |  8 +++----
 tmp-objdir.c                |  2 +-
 transport-helper.c          |  2 +-
 upload-pack.c               |  2 +-
 52 files changed, 186 insertions(+), 186 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 458f3a3e69..659289905c 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -944,7 +944,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 					    files->items.items[i].string);
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
-			       PATHSPEC_LITERAL_PATH, "", args.argv);
+			       PATHSPEC_LITERAL_PATH, "", args.items);
 		res = run_add_p(s->r, ADD_P_ADD, NULL, &ps_selected);
 		strvec_clear(&args);
 		clear_pathspec(&ps_selected);
@@ -986,7 +986,7 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 			if (files->selected[i])
 				strvec_push(&args,
 					    files->items.items[i].string);
-		res = run_command_v_opt(args.argv, 0);
+		res = run_command_v_opt(args.items, 0);
 		strvec_clear(&args);
 	}
 
diff --git a/add-patch.c b/add-patch.c
index 8c0772803b..df170d29ef 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -391,14 +391,14 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			    get_oid("HEAD", &oid) ?
 			    empty_tree_oid_hex() : s->revision);
 	}
-	color_arg_index = args.argc;
+	color_arg_index = args.nr;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
 	strvec_pushl(&args, "--no-color", "-p", "--", NULL);
 	for (i = 0; i < ps->nr; i++)
 		strvec_push(&args, ps->items[i].original);
 
 	setup_child_process(s, &cp, NULL);
-	cp.argv = args.argv;
+	cp.argv = args.items;
 	res = capture_command(&cp, plain, 0);
 	if (res) {
 		strvec_clear(&args);
@@ -415,8 +415,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		const char *diff_filter = s->s.interactive_diff_filter;
 
 		setup_child_process(s, &colored_cp, NULL);
-		xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
-		colored_cp.argv = args.argv;
+		xsnprintf((char *)args.items[color_arg_index], 8, "--color");
+		colored_cp.argv = args.items;
 		colored = &s->colored;
 		res = capture_command(&colored_cp, colored, 0);
 		strvec_clear(&args);
diff --git a/bisect.c b/bisect.c
index 99ff694960..5d4ba23ba7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -649,7 +649,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	if (read_paths)
 		read_bisect_paths(&rev_argv);
 
-	setup_revisions(rev_argv.argc, rev_argv.argv, revs, NULL);
+	setup_revisions(rev_argv.nr, rev_argv.items, revs, NULL);
 	/* XXX leak rev_argv, as "revs" may still be pointing to it */
 }
 
diff --git a/builtin/add.c b/builtin/add.c
index 6185dd12a8..eb6457da05 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -228,7 +228,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 		/* pass original pathspec, to be re-parsed */
 		strvec_push(&argv, pathspec->items[i].original);
 
-	status = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+	status = run_command_v_opt(argv.items, RUN_GIT_CMD);
 	strvec_clear(&argv);
 	return status;
 }
diff --git a/builtin/am.c b/builtin/am.c
index 992ab3ca27..3f2adb3822 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -812,7 +812,7 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 	strbuf_release(&sb);
 	free(series_dir_buf);
 
-	ret = split_mail_conv(stgit_patch_to_mail, state, patches.argv, keep_cr);
+	ret = split_mail_conv(stgit_patch_to_mail, state, patches.items, keep_cr);
 
 	strvec_clear(&patches);
 	return ret;
@@ -1002,7 +1002,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	}
 	write_state_text(state, "scissors", str);
 
-	sq_quote_argv(&sb, state->git_apply_opts.argv);
+	sq_quote_argv(&sb, state->git_apply_opts.items);
 	write_state_text(state, "apply-opt", sb.buf);
 
 	if (state->rebasing)
@@ -1401,9 +1401,9 @@ static int run_apply(const struct am_state *state, const char *index_file)
 		BUG("init_apply_state() failed");
 
 	strvec_push(&apply_opts, "apply");
-	strvec_pushv(&apply_opts, state->git_apply_opts.argv);
+	strvec_pushv(&apply_opts, state->git_apply_opts.items);
 
-	opts_left = apply_parse_options(apply_opts.argc, apply_opts.argv,
+	opts_left = apply_parse_options(apply_opts.nr, apply_opts.items,
 					&apply_state, &force_apply, &options,
 					NULL);
 
@@ -1428,7 +1428,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
 	strvec_push(&apply_paths, am_path(state, "patch"));
 
-	res = apply_all_patches(&apply_state, apply_paths.argc, apply_paths.argv, options);
+	res = apply_all_patches(&apply_state, apply_paths.nr, apply_paths.items, options);
 
 	strvec_clear(&apply_paths);
 	strvec_clear(&apply_opts);
@@ -1455,7 +1455,7 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
 
 	cp.git_cmd = 1;
 	strvec_push(&cp.args, "apply");
-	strvec_pushv(&cp.args, state->git_apply_opts.argv);
+	strvec_pushv(&cp.args, state->git_apply_opts.items);
 	strvec_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
 	strvec_push(&cp.args, am_path(state, "patch"));
 
@@ -2376,10 +2376,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 				strvec_push(&paths, mkpath("%s/%s", prefix, argv[i]));
 		}
 
-		if (state.interactive && !paths.argc)
+		if (state.interactive && !paths.nr)
 			die(_("interactive mode requires patches on the command line"));
 
-		am_setup(&state, patch_format, paths.argv, keep_cr);
+		am_setup(&state, patch_format, paths.items, keep_cr);
 
 		strvec_clear(&paths);
 	}
diff --git a/builtin/annotate.c b/builtin/annotate.c
index 7b7ecd366d..b9ab710740 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -18,5 +18,5 @@ int cmd_annotate(int argc, const char **argv, const char *prefix)
 		strvec_push(&args, argv[i]);
 	}
 
-	return cmd_blame(args.argc, args.argv, prefix);
+	return cmd_blame(args.nr, args.items, prefix);
 }
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index dd52878413..945641ea54 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -168,7 +168,7 @@ static int bisect_reset(const char *commit)
 		struct strvec argv = STRVEC_INIT;
 
 		strvec_pushl(&argv, "checkout", branch.buf, "--", NULL);
-		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		if (run_command_v_opt(argv.items, RUN_GIT_CMD)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
 				" reset <commit>'."), branch.buf);
@@ -530,7 +530,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 
 			strvec_pushl(&argv, "checkout", start_head.buf,
 				     "--", NULL);
-			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+			if (run_command_v_opt(argv.items, RUN_GIT_CMD)) {
 				res = error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
diff --git a/builtin/clone.c b/builtin/clone.c
index e26bd82dc4..e9712c383c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -752,7 +752,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 */
 	core_apply_sparse_checkout = 1;
 
-	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+	if (run_command_v_opt(argv.items, RUN_GIT_CMD)) {
 		error(_("failed to initialize sparse-checkout"));
 		result = 1;
 	}
@@ -844,7 +844,7 @@ static int checkout(int submodule_progress)
 					       "--single-branch" :
 					       "--no-single-branch");
 
-		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
+		err = run_command_v_opt(args.items, RUN_GIT_CMD);
 		strvec_clear(&args);
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index c3f4067537..01105ce8b0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1008,7 +1008,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct strvec env = STRVEC_INIT;
 
 		strvec_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
+		if (launch_editor(git_path_commit_editmsg(), NULL, env.items)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
diff --git a/builtin/describe.c b/builtin/describe.c
index e3cac8002c..85c1504065 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -509,7 +509,7 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 		     NULL);
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
+	if (setup_revisions(args.nr, args.items, &revs, NULL) > 1)
 		BUG("setup_revisions could not handle all args?");
 
 	if (prepare_revision_walk(&revs))
@@ -613,7 +613,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			strvec_pushv(&args, argv);
 		else
 			strvec_push(&args, "HEAD");
-		return cmd_name_rev(args.argc, args.argv, prefix);
+		return cmd_name_rev(args.nr, args.items, prefix);
 	}
 
 	hashmap_init(&names, commit_name_neq, NULL, 0);
@@ -659,7 +659,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 			repo_init_revisions(the_repository, &revs, prefix);
 			strvec_pushv(&args, diff_index_args);
-			if (setup_revisions(args.argc, args.argv, &revs, NULL) != 1)
+			if (setup_revisions(args.nr, args.items, &revs, NULL) != 1)
 				BUG("malformed internal diff-index command line");
 			result = run_diff_index(&revs, 0);
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 5ac021a1d4..78ea697325 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -683,7 +683,7 @@ static int run_file_diff(int prompt, const char *prefix,
 	strvec_push(&args, "diff");
 	for (i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
-	ret = run_command_v_opt_cd_env(args.argv, RUN_GIT_CMD, prefix, env);
+	ret = run_command_v_opt_cd_env(args.items, RUN_GIT_CMD, prefix, env);
 	exit(ret);
 }
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c2e7afeb6a..7953a1a25b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1354,7 +1354,7 @@ static int do_fetch(struct transport *transport,
 
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
-		if (ref_prefixes.argc)
+		if (ref_prefixes.nr)
 			strvec_push(&ref_prefixes, "refs/tags/");
 	}
 
@@ -1605,7 +1605,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 	add_options_to_argv(&argv);
 
 	if (max_children != 1 && list->nr != 1) {
-		struct parallel_fetch_state state = { argv.argv, list, 0, 0 };
+		struct parallel_fetch_state state = { argv.items, list, 0, 0 };
 
 		strvec_push(&argv, "--end-of-options");
 		result = run_processes_parallel_tr2(max_children,
@@ -1623,7 +1623,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 			strvec_push(&argv, name);
 			if (verbosity >= 0)
 				printf(_("Fetching %s\n"), name);
-			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+			if (run_command_v_opt(argv.items, RUN_GIT_CMD)) {
 				error(_("Could not fetch %s"), name);
 				result = 1;
 			}
diff --git a/builtin/gc.c b/builtin/gc.c
index 98719800a3..10346e0465 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -514,11 +514,11 @@ static void gc_before_repack(void)
 	if (done++)
 		return;
 
-	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
-		die(FAILED_RUN, pack_refs_cmd.argv[0]);
+	if (pack_refs && run_command_v_opt(pack_refs_cmd.items, RUN_GIT_CMD))
+		die(FAILED_RUN, pack_refs_cmd.items[0]);
 
-	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
-		die(FAILED_RUN, reflog.argv[0]);
+	if (prune_reflogs && run_command_v_opt(reflog.items, RUN_GIT_CMD))
+		die(FAILED_RUN, reflog.items[0]);
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
@@ -653,8 +653,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (!repository_format_precious_objects) {
 		close_object_store(the_repository->objects);
-		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
-			die(FAILED_RUN, repack.argv[0]);
+		if (run_command_v_opt(repack.items, RUN_GIT_CMD))
+			die(FAILED_RUN, repack.items[0]);
 
 		if (prune_expire) {
 			strvec_push(&prune, prune_expire);
@@ -663,19 +663,19 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			if (has_promisor_remote())
 				strvec_push(&prune,
 					    "--exclude-promisor-objects");
-			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
-				die(FAILED_RUN, prune.argv[0]);
+			if (run_command_v_opt(prune.items, RUN_GIT_CMD))
+				die(FAILED_RUN, prune.items[0]);
 		}
 	}
 
 	if (prune_worktrees_expire) {
 		strvec_push(&prune_worktrees, prune_worktrees_expire);
-		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
-			die(FAILED_RUN, prune_worktrees.argv[0]);
+		if (run_command_v_opt(prune_worktrees.items, RUN_GIT_CMD))
+			die(FAILED_RUN, prune_worktrees.items[0]);
 	}
 
-	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
-		die(FAILED_RUN, rerere.argv[0]);
+	if (run_command_v_opt(rerere.items, RUN_GIT_CMD))
+		die(FAILED_RUN, rerere.items[0]);
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 323f8bce80..492a61aed0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3704,7 +3704,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-		get_object_list(rp.argc, rp.argv);
+		get_object_list(rp.nr, rp.items);
 		strvec_clear(&rp);
 	}
 	cleanup_preferred_base();
diff --git a/builtin/pull.c b/builtin/pull.c
index dae8766646..858b492af3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -584,14 +584,14 @@ static int run_fetch(const char *repo, const char **refspecs)
 		strvec_push(&args, "--no-show-forced-updates");
 	if (set_upstream)
 		strvec_push(&args, set_upstream);
-	strvec_pushv(&args, opt_fetch.argv);
+	strvec_pushv(&args, opt_fetch.items);
 
 	if (repo) {
 		strvec_push(&args, repo);
 		strvec_pushv(&args, refspecs);
 	} else if (*refspecs)
 		BUG("refspecs without repo?");
-	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.items, RUN_GIT_CMD);
 	strvec_clear(&args);
 	return ret;
 }
@@ -691,8 +691,8 @@ static int run_merge(void)
 		strvec_push(&args, opt_ff);
 	if (opt_verify_signatures)
 		strvec_push(&args, opt_verify_signatures);
-	strvec_pushv(&args, opt_strategies.argv);
-	strvec_pushv(&args, opt_strategy_opts.argv);
+	strvec_pushv(&args, opt_strategies.items);
+	strvec_pushv(&args, opt_strategy_opts.items);
 	if (opt_gpg_sign)
 		strvec_push(&args, opt_gpg_sign);
 	if (opt_autostash == 0)
@@ -703,7 +703,7 @@ static int run_merge(void)
 		strvec_push(&args, "--allow-unrelated-histories");
 
 	strvec_push(&args, "FETCH_HEAD");
-	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.items, RUN_GIT_CMD);
 	strvec_clear(&args);
 	return ret;
 }
@@ -882,8 +882,8 @@ static int run_rebase(const struct object_id *curr_head,
 		strvec_push(&args, "--interactive");
 	if (opt_diffstat)
 		strvec_push(&args, opt_diffstat);
-	strvec_pushv(&args, opt_strategies.argv);
-	strvec_pushv(&args, opt_strategy_opts.argv);
+	strvec_pushv(&args, opt_strategies.items);
+	strvec_pushv(&args, opt_strategy_opts.items);
 	if (opt_gpg_sign)
 		strvec_push(&args, opt_gpg_sign);
 	if (opt_autostash == 0)
@@ -902,7 +902,7 @@ static int run_rebase(const struct object_id *curr_head,
 	else
 		strvec_push(&args, oid_to_hex(merge_head));
 
-	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.items, RUN_GIT_CMD);
 	strvec_clear(&args);
 	return ret;
 }
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 35aeb8effc..494107a648 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -351,7 +351,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 			     oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
-				    make_script_args.argc, make_script_args.argv,
+				    make_script_args.nr, make_script_args.items,
 				    flags);
 
 	if (ret)
@@ -900,7 +900,7 @@ static int run_am(struct rebase_options *opts)
 		return status;
 	}
 
-	strvec_pushv(&am.args, opts->git_am_opts.argv);
+	strvec_pushv(&am.args, opts->git_am_opts.items);
 	strvec_push(&am.args, "--rebasing");
 	strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 	strvec_push(&am.args, "--patch-format=mboxrd");
@@ -969,7 +969,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	add_var(&script_snippet, "revisions", opts->revisions);
 	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
 		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
-	sq_quote_argv_pretty(&buf, opts->git_am_opts.argv);
+	sq_quote_argv_pretty(&buf, opts->git_am_opts.items);
 	add_var(&script_snippet, "git_am_opt", buf.buf);
 	strbuf_release(&buf);
 	add_var(&script_snippet, "verbose",
@@ -1625,8 +1625,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		allow_preemptive_ff = 0;
 	}
 
-	for (i = 0; i < options.git_am_opts.argc; i++) {
-		const char *option = options.git_am_opts.argv[i], *p;
+	for (i = 0; i < options.git_am_opts.nr; i++) {
+		const char *option = options.git_am_opts.items[i], *p;
 		if (!strcmp(option, "--committer-date-is-author-date") ||
 		    !strcmp(option, "--ignore-date") ||
 		    !strcmp(option, "--whitespace=fix") ||
@@ -1721,10 +1721,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
-	if (options.git_am_opts.argc || options.type == REBASE_APPLY) {
+	if (options.git_am_opts.nr || options.type == REBASE_APPLY) {
 		/* all am options except -q are compatible only with --apply */
-		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
-			if (strcmp(options.git_am_opts.argv[i], "-q"))
+		for (i = options.git_am_opts.nr - 1; i >= 0; i--)
+			if (strcmp(options.git_am_opts.items[i], "-q"))
 				break;
 
 		if (i >= 0) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1fc69cf5bc..8747a4e91f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -950,7 +950,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.argv = update_refresh;
-	child.env = env->argv;
+	child.env = env->items;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
@@ -961,7 +961,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	/* run_command() does not clean up completely; reinitialize */
 	child_process_init(&child);
 	child.argv = diff_files;
-	child.env = env->argv;
+	child.env = env->items;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
@@ -974,7 +974,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 
 	child_process_init(&child);
 	child.argv = diff_index;
-	child.env = env->argv;
+	child.env = env->items;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
@@ -985,7 +985,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	read_tree[3] = hash_to_hex(sha1);
 	child_process_init(&child);
 	child.argv = read_tree;
-	child.env = env->argv;
+	child.env = env->items;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
@@ -1004,7 +1004,7 @@ static const char *push_to_checkout(unsigned char *hash,
 				    const char *work_tree)
 {
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->argv, push_to_checkout_hook,
+	if (run_hook_le(env->items, push_to_checkout_hook,
 			hash_to_hex(hash), NULL))
 		return "push-to-checkout hook declined";
 	else
@@ -1205,11 +1205,11 @@ static void run_update_post_hook(struct command *commands)
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
-		if (!proc.args.argc)
+		if (!proc.args.nr)
 			strvec_push(&proc.args, hook);
 		strvec_push(&proc.args, cmd->ref_name);
 	}
-	if (!proc.args.argc)
+	if (!proc.args.nr)
 		return;
 
 	proc.no_stdin = 1;
diff --git a/builtin/remote.c b/builtin/remote.c
index a3b33c2c88..9a98e77a5e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1470,15 +1470,15 @@ static int update(int argc, const char **argv)
 	for (i = 1; i < argc; i++)
 		strvec_push(&fetch_argv, argv[i]);
 
-	if (strcmp(fetch_argv.argv[fetch_argv.argc-1], "default") == 0) {
+	if (strcmp(fetch_argv.items[fetch_argv.nr-1], "default") == 0) {
 		git_config(get_remote_default, &default_defined);
 		if (!default_defined) {
 			strvec_pop(&fetch_argv);
 			strvec_push(&fetch_argv, "--all");
 		}
 	}
 
-	retval = run_command_v_opt(fetch_argv.argv, RUN_GIT_CMD);
+	retval = run_command_v_opt(fetch_argv.items, RUN_GIT_CMD);
 	strvec_clear(&fetch_argv);
 	return retval;
 }
diff --git a/builtin/replace.c b/builtin/replace.c
index 7bc5d66ed9..038b7f874b 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -513,7 +513,7 @@ static int convert_graft_file(int force)
 			continue;
 
 		strvec_split(&args, buf.buf);
-		if (args.argc && create_graft(args.argc, args.argv, force, 1))
+		if (args.nr && create_graft(args.nr, args.items, force, 1))
 			strbuf_addf(&err, "\n\t%s", buf.buf);
 		strvec_clear(&args);
 	}
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4c918ce90d..de27703297 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -561,7 +561,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		 * default_arg is now passed to parse_options(), so we need to
 		 * mimic the real argv a bit better.
 		 */
-		if (!default_args.argc)
+		if (!default_args.nr)
 			strvec_push(&default_args, "show-branch");
 		strvec_push(&default_args, value);
 		return 0;
@@ -684,9 +684,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	git_config(git_show_branch_config, NULL);
 
 	/* If nothing is specified, try the default first */
-	if (ac == 1 && default_args.argc) {
-		ac = default_args.argc;
-		av = default_args.argv;
+	if (ac == 1 && default_args.nr) {
+		ac = default_args.nr;
+		av = default_args.items;
 	}
 
 	ac = parse_options(ac, av, prefix, builtin_show_branch_options,
diff --git a/builtin/stash.c b/builtin/stash.c
index bfdbafae89..0134c6b0d6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -745,7 +745,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 			strvec_push(&revision_args, argv[i]);
 	}
 
-	ret = get_stash_info(&info, stash_args.argc, stash_args.argv);
+	ret = get_stash_info(&info, stash_args.nr, stash_args.items);
 	strvec_clear(&stash_args);
 	if (ret)
 		return -1;
@@ -754,7 +754,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	 * The config settings are applied only if there are not passed
 	 * any options.
 	 */
-	if (revision_args.argc == 1) {
+	if (revision_args.nr == 1) {
 		if (show_stat)
 			rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
 
@@ -767,7 +767,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	argc = setup_revisions(revision_args.argc, revision_args.argv, &rev, NULL);
+	argc = setup_revisions(revision_args.nr, revision_args.items, &rev, NULL);
 	if (argc > 1) {
 		free_stash_info(&info);
 		usage_with_options(git_stash_show_usage, options);
@@ -1611,5 +1611,5 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
 	strvec_pushv(&args, argv);
-	return !!push_stash(args.argc, args.argv, prefix, 1);
+	return !!push_stash(args.nr, args.items, prefix, 1);
 }
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 665db1ffed..6bbed9f92a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -817,9 +817,9 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
-	diff_files_args.argc = setup_revisions(diff_files_args.argc,
-					       diff_files_args.argv,
-					       &rev, NULL);
+	diff_files_args.nr = setup_revisions(diff_files_args.nr,
+					     diff_files_args.items,
+					     &rev, NULL);
 	diff_files_result = run_diff_files(&rev, 0);
 
 	if (!diff_result_code(&rev.diffopt, diff_files_result)) {
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index f02bb0ea15..8ded611092 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -36,7 +36,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 		char *buf = packet_read_line(0, NULL);
 		if (!buf)
 			break;	/* got a flush */
-		if (sent_argv.argc > MAX_ARGS)
+		if (sent_argv.nr > MAX_ARGS)
 			die("Too many options (>%d)", MAX_ARGS - 1);
 
 		if (!starts_with(buf, arg_cmd))
@@ -45,7 +45,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argv.argc, sent_argv.argv, prefix,
+	return write_archive(sent_argv.nr, sent_argv.items, prefix,
 			     the_repository, NULL, 1);
 }
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index be5d84f0a0..1d6b9455da 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -422,7 +422,7 @@ static int add_worktree(const char *path, const char *refname,
 			strvec_push(&cp.args, "--quiet");
 	}
 
-	cp.env = child_env.argv;
+	cp.env = child_env.items;
 	ret = run_command(&cp);
 	if (ret)
 		goto done;
@@ -433,7 +433,7 @@ static int add_worktree(const char *path, const char *refname,
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
-		cp.env = child_env.argv;
+		cp.env = child_env.items;
 		ret = run_command(&cp);
 		if (ret)
 			goto done;
@@ -943,7 +943,7 @@ static void check_clean_worktree(struct worktree *wt,
 	strvec_pushl(&cp.args, "status",
 		     "--porcelain", "--ignore-submodules=none",
 		     NULL);
-	cp.env = child_env.argv;
+	cp.env = child_env.items;
 	cp.git_cmd = 1;
 	cp.dir = wt->path;
 	cp.out = -1;
diff --git a/bundle.c b/bundle.c
index 565d05367f..2ba2277ef0 100644
--- a/bundle.c
+++ b/bundle.c
@@ -278,7 +278,7 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 		     "pack-objects",
 		     "--stdout", "--thin", "--delta-base-offset",
 		     NULL);
-	strvec_pushv(&pack_objects.args, pack_options->argv);
+	strvec_pushv(&pack_objects.args, pack_options->items);
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
 	pack_objects.git_cmd = 1;
diff --git a/commit.c b/commit.c
index a5176a25bd..c8fd6931a6 100644
--- a/commit.c
+++ b/commit.c
@@ -1643,7 +1643,7 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.argv,name, args);
+	ret = run_hook_ve(hook_env.items, name, args);
 	va_end(args);
 	strvec_clear(&hook_env);
 
diff --git a/connect.c b/connect.c
index 3299ea956a..e3a08179d4 100644
--- a/connect.c
+++ b/connect.c
@@ -70,9 +70,9 @@ int server_supports_v2(const char *c, int die_on_error)
 {
 	int i;
 
-	for (i = 0; i < server_capabilities_v2.argc; i++) {
+	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
-		if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
+		if (skip_prefix(server_capabilities_v2.items[i], c, &out) &&
 		    (!*out || *out == '='))
 			return 1;
 	}
@@ -87,9 +87,9 @@ int server_feature_v2(const char *c, const char **v)
 {
 	int i;
 
-	for (i = 0; i < server_capabilities_v2.argc; i++) {
+	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
-		if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
+		if (skip_prefix(server_capabilities_v2.items[i], c, &out) &&
 		    (*out == '=')) {
 			*v = out + 1;
 			return 1;
@@ -103,9 +103,9 @@ int server_supports_feature(const char *c, const char *feature,
 {
 	int i;
 
-	for (i = 0; i < server_capabilities_v2.argc; i++) {
+	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
-		if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
+		if (skip_prefix(server_capabilities_v2.items[i], c, &out) &&
 		    (!*out || *(out++) == '=')) {
 			if (parse_feature_request(out, feature))
 				return 1;
@@ -488,9 +488,9 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (!for_push)
 		packet_write_fmt(fd_out, "peel\n");
 	packet_write_fmt(fd_out, "symrefs\n");
-	for (i = 0; ref_prefixes && i < ref_prefixes->argc; i++) {
+	for (i = 0; ref_prefixes && i < ref_prefixes->nr; i++) {
 		packet_write_fmt(fd_out, "ref-prefix %s\n",
-				 ref_prefixes->argv[i]);
+				 ref_prefixes->items[i]);
 	}
 	packet_flush(fd_out);
 
diff --git a/daemon.c b/daemon.c
index 0dec89fa02..ee66002a6f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -482,7 +482,7 @@ static int upload_pack(const struct strvec *env)
 	strvec_pushl(&cld.args, "upload-pack", "--strict", NULL);
 	strvec_pushf(&cld.args, "--timeout=%u", timeout);
 
-	strvec_pushv(&cld.env_array, env->argv);
+	strvec_pushv(&cld.env_array, env->items);
 
 	return run_service_command(&cld);
 }
@@ -492,7 +492,7 @@ static int upload_archive(const struct strvec *env)
 	struct child_process cld = CHILD_PROCESS_INIT;
 	strvec_push(&cld.args, "upload-archive");
 
-	strvec_pushv(&cld.env_array, env->argv);
+	strvec_pushv(&cld.env_array, env->items);
 
 	return run_service_command(&cld);
 }
@@ -502,7 +502,7 @@ static int receive_pack(const struct strvec *env)
 	struct child_process cld = CHILD_PROCESS_INIT;
 	strvec_push(&cld.args, "receive-pack");
 
-	strvec_pushv(&cld.env_array, env->argv);
+	strvec_pushv(&cld.env_array, env->items);
 
 	return run_service_command(&cld);
 }
@@ -927,7 +927,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 #endif
 	}
 
-	cld.argv = cld_argv.argv;
+	cld.argv = cld_argv.items;
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
diff --git a/diff.c b/diff.c
index f1a3758922..fb5462c532 100644
--- a/diff.c
+++ b/diff.c
@@ -4239,7 +4239,7 @@ static void run_external_diff(const char *pgm,
 
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
-	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
+	if (run_command_v_opt_cd_env(argv.items, RUN_USING_SHELL, NULL, env.items))
 		die(_("external diff died, stopping at %s"), name);
 
 	remove_tempfile();
diff --git a/environment.c b/environment.c
index 00fe20e496..449a46995d 100644
--- a/environment.c
+++ b/environment.c
@@ -164,7 +164,7 @@ static const char *getenv_safe(struct strvec *argv, const char *name)
 		return NULL;
 
 	strvec_push(argv, value);
-	return argv->argv[argv->argc - 1];
+	return argv->items[argv->nr - 1];
 }
 
 void setup_git_env(const char *git_dir)
diff --git a/exec-cmd.c b/exec-cmd.c
index 0f8e888424..d657c025c2 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -324,18 +324,18 @@ const char **prepare_git_cmd(struct strvec *out, const char **argv)
 {
 	strvec_push(out, "git");
 	strvec_pushv(out, argv);
-	return out->argv;
+	return out->items;
 }
 
 int execv_git_cmd(const char **argv)
 {
 	struct strvec nargv = STRVEC_INIT;
 
 	prepare_git_cmd(&nargv, argv);
-	trace_argv_printf(nargv.argv, "trace: exec:");
+	trace_argv_printf(nargv.items, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	sane_execvp("git", (char **)nargv.argv);
+	sane_execvp("git", (char **)nargv.items);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
diff --git a/git.c b/git.c
index 258035cfb1..832688ca23 100644
--- a/git.c
+++ b/git.c
@@ -352,7 +352,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			strvec_push(&child.args, alias_string + 1);
 			strvec_pushv(&child.args, (*argv) + 1);
 
-			trace2_cmd_alias(alias_command, child.args.argv);
+			trace2_cmd_alias(alias_command, child.args.items);
 			trace2_cmd_list_config();
 			trace2_cmd_list_env_vars();
 			trace2_cmd_name("_run_shell_alias_");
@@ -667,7 +667,7 @@ static void handle_builtin(int argc, const char **argv)
 		}
 
 		argc++;
-		argv = args.argv;
+		argv = args.items;
 	}
 
 	builtin = get_builtin(cmd);
@@ -701,7 +701,7 @@ static void execv_dashed_external(const char **argv)
 	 * The code in run_command() logs trace2 child_start/child_exit
 	 * events, so we do not need to report exec/exec_result events here.
 	 */
-	trace_argv_printf(cmd.args.argv, "trace: exec:");
+	trace_argv_printf(cmd.args.items, "trace: exec:");
 
 	/*
 	 * If we fail because the command is not found, it is
@@ -762,13 +762,13 @@ static int run_argv(int *argcp, const char ***argv)
 			for (i = 0; i < *argcp; i++)
 				strvec_push(&args, (*argv)[i]);
 
-			trace_argv_printf(args.argv, "trace: exec:");
+			trace_argv_printf(args.items, "trace: exec:");
 
 			/*
 			 * if we fail because the command is not found, it is
 			 * OK to return. Otherwise, we just pass along the status code.
 			 */
-			i = run_command_v_opt_tr2(args.argv, RUN_SILENT_EXEC_FAILURE |
+			i = run_command_v_opt_tr2(args.items, RUN_SILENT_EXEC_FAILURE |
 						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
diff --git a/graph.c b/graph.c
index 09c9cc968c..1d68fffa24 100644
--- a/graph.c
+++ b/graph.c
@@ -355,8 +355,8 @@ struct git_graph *graph_init(struct rev_info *opt)
 			parse_graph_colors_config(&custom_colors, string);
 			free(string);
 			/* graph_set_column_colors takes a max-index, not a count */
-			graph_set_column_colors(custom_colors.argv,
-						custom_colors.argc - 1);
+			graph_set_column_colors(custom_colors.items,
+						custom_colors.nr - 1);
 		}
 	}
 
diff --git a/http-push.c b/http-push.c
index 31911aa345..c4e3825609 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1931,7 +1931,7 @@ int cmd_main(int argc, const char **argv)
 			strvec_pushf(&commit_argv, "^%s",
 				     oid_to_hex(&ref->old_oid));
 		repo_init_revisions(the_repository, &revs, setup_git_directory());
-		setup_revisions(commit_argv.argc, commit_argv.argv, &revs, NULL);
+		setup_revisions(commit_argv.nr, commit_argv.items, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
 
 		/* Generate a list of objects that need to be pushed */
diff --git a/ls-refs.c b/ls-refs.c
index 8192c949f4..e6b8c9cf8e 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -15,11 +15,11 @@ static int ref_match(const struct strvec *prefixes, const char *refname)
 {
 	int i;
 
-	if (!prefixes->argc)
+	if (!prefixes->nr)
 		return 1; /* no restriction */
 
-	for (i = 0; i < prefixes->argc; i++) {
-		const char *prefix = prefixes->argv[i];
+	for (i = 0; i < prefixes->nr; i++) {
+		const char *prefix = prefixes->items[i];
 
 		if (starts_with(refname, prefix))
 			return 1;
diff --git a/merge.c b/merge.c
index a05b054faa..bcfb9dcf8a 100644
--- a/merge.c
+++ b/merge.c
@@ -33,7 +33,7 @@ int try_merge_command(struct repository *r,
 	for (j = remotes; j; j = j->next)
 		strvec_push(&args, merge_argument(j->item));
 
-	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.items, RUN_GIT_CMD);
 	strvec_clear(&args);
 
 	discard_index(r->index);
diff --git a/pathspec.c b/pathspec.c
index c303126f37..75378f49d1 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -652,7 +652,7 @@ void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
 	if (in != stdin)
 		fclose(in);
 
-	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.argv);
+	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.items);
 	strvec_clear(&parsed_file);
 }
 
diff --git a/range-diff.c b/range-diff.c
index 831c490bf2..3fa3ac6cb5 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -67,7 +67,7 @@ static int read_patches(const char *range, struct string_list *list,
 		     "--notes",
 		     NULL);
 	if (other_arg)
-		strvec_pushv(&cp.args, other_arg->argv);
+		strvec_pushv(&cp.args, other_arg->items);
 	strvec_push(&cp.args, range);
 	cp.out = -1;
 	cp.no_stdin = 1;
diff --git a/ref-filter.c b/ref-filter.c
index 7f013851ed..9d29271478 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1918,9 +1918,9 @@ static void find_longest_prefixes(struct string_list *out,
 	struct strbuf prefix = STRBUF_INIT;
 
 	strvec_pushv(&sorted, patterns);
-	QSORT(sorted.argv, sorted.argc, qsort_strcmp);
+	QSORT(sorted.items, sorted.nr, qsort_strcmp);
 
-	find_longest_prefixes_1(out, &prefix, sorted.argv, sorted.argc);
+	find_longest_prefixes_1(out, &prefix, sorted.items, sorted.nr);
 
 	strvec_clear(&sorted);
 	strbuf_release(&prefix);
diff --git a/remote-curl.c b/remote-curl.c
index 7feaddc003..564da05648 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1190,7 +1190,7 @@ static int fetch_git(struct discovery *heads,
 	rpc.service_name = "git-upload-pack",
 	rpc.gzip_request = 1;
 
-	err = rpc_service(&rpc, heads, args.argv, &preamble, &rpc_result);
+	err = rpc_service(&rpc, heads, args.items, &preamble, &rpc_result);
 	if (rpc_result.len)
 		write_or_die(1, rpc_result.buf, rpc_result.len);
 	strbuf_release(&rpc_result);
@@ -1325,7 +1325,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-receive-pack",
 
-	err = rpc_service(&rpc, heads, args.argv, &preamble, &rpc_result);
+	err = rpc_service(&rpc, heads, args.items, &preamble, &rpc_result);
 	if (rpc_result.len)
 		write_or_die(1, rpc_result.buf, rpc_result.len);
 	strbuf_release(&rpc_result);
@@ -1366,7 +1366,7 @@ static void parse_push(struct strbuf *buf)
 			break;
 	} while (1);
 
-	ret = push(specs.argc, specs.argv);
+	ret = push(specs.nr, specs.items);
 	printf("\n");
 	fflush(stdout);
 
diff --git a/remote.c b/remote.c
index b4665fe5a3..370bd07dc3 100644
--- a/remote.c
+++ b/remote.c
@@ -1919,7 +1919,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	strvec_push(&argv, "--");
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	setup_revisions(argv.argc, argv.argv, &revs, NULL);
+	setup_revisions(argv.nr, argv.items, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
diff --git a/revision.c b/revision.c
index e144132ae9..d645487646 100644
--- a/revision.c
+++ b/revision.c
@@ -2767,7 +2767,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			got_rev_arg = 1;
 	}
 
-	if (prune_data.argc) {
+	if (prune_data.nr) {
 		/*
 		 * If we need to introduce the magic "a lone ':' means no
 		 * pathspec whatsoever", here is the place to do so.
@@ -2783,7 +2783,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		 * }
 		 */
 		parse_pathspec(&revs->prune_data, 0, 0,
-			       revs->prefix, prune_data.argv);
+			       revs->prefix, prune_data.items);
 	}
 	strvec_clear(&prune_data);
 
diff --git a/run-command.c b/run-command.c
index b9630a1b5f..30104a4ee1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -287,7 +287,7 @@ static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 	}
 
 	strvec_pushv(out, argv);
-	return out->argv;
+	return out->items;
 }
 
 #ifndef GIT_WINDOWS_NATIVE
@@ -426,11 +426,11 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 	 * there are dir separator characters, we have exec attempt to invoke
 	 * the command directly.
 	 */
-	if (!has_dir_sep(out->argv[1])) {
-		char *program = locate_in_PATH(out->argv[1]);
+	if (!has_dir_sep(out->items[1])) {
+		char *program = locate_in_PATH(out->items[1]);
 		if (program) {
-			free((char *)out->argv[1]);
-			out->argv[1] = program;
+			free((char *)out->items[1]);
+			out->items[1] = program;
 		} else {
 			strvec_clear(out);
 			errno = ENOENT;
@@ -672,9 +672,9 @@ int start_command(struct child_process *cmd)
 	char *str;
 
 	if (!cmd->argv)
-		cmd->argv = cmd->args.argv;
+		cmd->argv = cmd->args.items;
 	if (!cmd->env)
-		cmd->env = cmd->env_array.argv;
+		cmd->env = cmd->env_array.items;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
@@ -846,10 +846,10 @@ int start_command(struct child_process *cmd)
 		 * be used in the event exec failed with ENOEXEC at which point
 		 * we will try to interpret the command using 'sh'.
 		 */
-		execve(argv.argv[1], (char *const *) argv.argv + 1,
+		execve(argv.items[1], (char *const *) argv.items + 1,
 		       (char *const *) childenv);
 		if (errno == ENOEXEC)
-			execve(argv.argv[0], (char *const *) argv.argv,
+			execve(argv.items[0], (char *const *) argv.items,
 			       (char *const *) childenv);
 
 		if (errno == ENOENT) {
@@ -1874,7 +1874,7 @@ int run_auto_gc(int quiet)
 	strvec_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (quiet)
 		strvec_push(&argv_gc_auto, "--quiet");
-	status = run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
+	status = run_command_v_opt(argv_gc_auto.items, RUN_GIT_CMD);
 	strvec_clear(&argv_gc_auto);
 	return status;
 }
diff --git a/sequencer.c b/sequencer.c
index 31a2b1ab55..c1bcd64080 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2761,7 +2761,7 @@ static int reset_merge(const struct object_id *oid)
 	if (!is_null_oid(oid))
 		strvec_push(&argv, oid_to_hex(oid));
 
-	ret = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+	ret = run_command_v_opt(argv.items, RUN_GIT_CMD);
 	strvec_clear(&argv);
 
 	return ret;
@@ -3135,7 +3135,7 @@ static int do_exec(struct repository *r, const char *command_line)
 	strvec_pushf(&child_env, "GIT_WORK_TREE=%s",
 		     absolute_path(get_git_work_tree()));
 	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
-					  child_env.argv);
+					  child_env.items);
 
 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
diff --git a/serve.c b/serve.c
index 523a9be32d..0db929beff 100644
--- a/serve.c
+++ b/serve.c
@@ -146,9 +146,9 @@ int has_capability(const struct strvec *keys, const char *capability,
 		   const char **value)
 {
 	int i;
-	for (i = 0; i < keys->argc; i++) {
+	for (i = 0; i < keys->nr; i++) {
 		const char *out;
-		if (skip_prefix(keys->argv[i], capability, &out) &&
+		if (skip_prefix(keys->items[i], capability, &out) &&
 		    (!*out || *out == '=')) {
 			if (value) {
 				if (*out == '=')
@@ -223,7 +223,7 @@ static int process_request(void)
 			 * If no command and no keys were given then the client
 			 * wanted to terminate the connection.
 			 */
-			if (!keys.argc)
+			if (!keys.nr)
 				return 1;
 
 			/*
diff --git a/strvec.c b/strvec.c
index 9e76ab9295..0e17597f80 100644
--- a/strvec.c
+++ b/strvec.c
@@ -6,25 +6,25 @@ const char *empty_strvec[] = { NULL };
 
 void strvec_init(struct strvec *array)
 {
-	array->argv = empty_strvec;
-	array->argc = 0;
+	array->items = empty_strvec;
+	array->nr = 0;
 	array->alloc = 0;
 }
 
 static void strvec_push_nodup(struct strvec *array, const char *value)
 {
-	if (array->argv == empty_strvec)
-		array->argv = NULL;
+	if (array->items == empty_strvec)
+		array->items = NULL;
 
-	ALLOC_GROW(array->argv, array->argc + 2, array->alloc);
-	array->argv[array->argc++] = value;
-	array->argv[array->argc] = NULL;
+	ALLOC_GROW(array->items, array->nr + 2, array->alloc);
+	array->items[array->nr++] = value;
+	array->items[array->nr] = NULL;
 }
 
 const char *strvec_push(struct strvec *array, const char *value)
 {
 	strvec_push_nodup(array, xstrdup(value));
-	return array->argv[array->argc - 1];
+	return array->items[array->nr - 1];
 }
 
 const char *strvec_pushf(struct strvec *array, const char *fmt, ...)
@@ -37,7 +37,7 @@ const char *strvec_pushf(struct strvec *array, const char *fmt, ...)
 	va_end(ap);
 
 	strvec_push_nodup(array, strbuf_detach(&v, NULL));
-	return array->argv[array->argc - 1];
+	return array->items[array->nr - 1];
 }
 
 void strvec_pushl(struct strvec *array, ...)
@@ -51,19 +51,19 @@ void strvec_pushl(struct strvec *array, ...)
 	va_end(ap);
 }
 
-void strvec_pushv(struct strvec *array, const char **argv)
+void strvec_pushv(struct strvec *array, const char **items)
 {
-	for (; *argv; argv++)
-		strvec_push(array, *argv);
+	for (; *items; items++)
+		strvec_push(array, *items);
 }
 
 void strvec_pop(struct strvec *array)
 {
-	if (!array->argc)
+	if (!array->nr)
 		return;
-	free((char *)array->argv[array->argc - 1]);
-	array->argv[array->argc - 1] = NULL;
-	array->argc--;
+	free((char *)array->items[array->nr - 1]);
+	array->items[array->nr - 1] = NULL;
+	array->nr--;
 }
 
 void strvec_split(struct strvec *array, const char *to_split)
@@ -88,21 +88,21 @@ void strvec_split(struct strvec *array, const char *to_split)
 
 void strvec_clear(struct strvec *array)
 {
-	if (array->argv != empty_strvec) {
+	if (array->items != empty_strvec) {
 		int i;
-		for (i = 0; i < array->argc; i++)
-			free((char *)array->argv[i]);
-		free(array->argv);
+		for (i = 0; i < array->nr; i++)
+			free((char *)array->items[i]);
+		free(array->items);
 	}
 	strvec_init(array);
 }
 
 const char **strvec_detach(struct strvec *array)
 {
-	if (array->argv == empty_strvec)
+	if (array->items == empty_strvec)
 		return xcalloc(1, sizeof(const char *));
 	else {
-		const char **ret = array->argv;
+		const char **ret = array->items;
 		strvec_init(array);
 		return ret;
 	}
diff --git a/strvec.h b/strvec.h
index bd35de1ce4..fda1c81c86 100644
--- a/strvec.h
+++ b/strvec.h
@@ -2,10 +2,10 @@
 #define STRVEC_H
 
 /**
- * The argv-array API allows one to dynamically build and store
- * NULL-terminated lists.  An argv-array maintains the invariant that the
- * `argv` member always points to a non-NULL array, and that the array is
- * always NULL-terminated at the element pointed to by `argv[argc]`. This
+ * The strvec API allows one to dynamically build and store
+ * NULL-terminated arrays of strings. A strvec maintains the invariant that the
+ * `items` member always points to a non-NULL array, and that the array is
+ * always NULL-terminated at the element pointed to by `items[nr]`. This
  * makes the result suitable for passing to functions expecting to receive
  * argv from main().
  *
@@ -22,15 +22,15 @@ extern const char *empty_strvec[];
 
 /**
  * A single array. This should be initialized by assignment from
- * `STRVEC_INIT`, or by calling `strvec_init`. The `argv`
- * member contains the actual array; the `argc` member contains the
+ * `STRVEC_INIT`, or by calling `strvec_init`. The `items`
+ * member contains the actual array; the `nr` member contains the
  * number of elements in the array, not including the terminating
  * NULL.
  */
 struct strvec {
-	const char **argv;
-	size_t argc;
-	size_t alloc;
+	const char **items;
+	int nr;
+	int alloc;
 };
 
 #define STRVEC_INIT { empty_strvec, 0, 0 }
@@ -78,7 +78,7 @@ void strvec_split(struct strvec *, const char *);
 void strvec_clear(struct strvec *);
 
 /**
- * Disconnect the `argv` member from the `strvec` struct and
+ * Disconnect the `items` member from the `strvec` struct and
  * return it. The caller is responsible for freeing the memory used
  * by the array, and by the strings it references. After detaching,
  * the `strvec` is in a reinitialized state and can be pushed
diff --git a/submodule.c b/submodule.c
index fb96d595b0..d9bc9c4696 100644
--- a/submodule.c
+++ b/submodule.c
@@ -269,7 +269,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 			strvec_push(&args, item->string);
 		}
 
-		parse_pathspec(&ps, 0, 0, NULL, args.argv);
+		parse_pathspec(&ps, 0, 0, NULL, args.items);
 		ret = match_pathspec(repo->index, &ps, path, strlen(path), 0, NULL, 1);
 
 		strvec_clear(&args);
@@ -842,7 +842,7 @@ static void collect_changed_submodules(struct repository *r,
 	const struct commit *commit;
 
 	repo_init_revisions(r, &rev, NULL);
-	setup_revisions(argv->argc, argv->argv, &rev, NULL);
+	setup_revisions(argv->nr, argv->items, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 
@@ -1014,7 +1014,7 @@ int find_unpushed_submodules(struct repository *r,
 	struct string_list_item *name;
 	struct strvec argv = STRVEC_INIT;
 
-	/* argv.argv[0] will be ignored by setup_revisions */
+	/* argv.items[0] will be ignored by setup_revisions */
 	strvec_push(&argv, "find_unpushed_submodules");
 	oid_array_for_each_unique(commits, append_oid_to_argv, &argv);
 	strvec_push(&argv, "--not");
@@ -1453,7 +1453,7 @@ static int get_next_submodule(struct child_process *cp,
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
 			strvec_init(&cp->args);
-			strvec_pushv(&cp->args, spf->args.argv);
+			strvec_pushv(&cp->args, spf->args.items);
 			strvec_push(&cp->args, default_argv);
 			strvec_push(&cp->args, "--submodule-prefix");
 
@@ -1501,7 +1501,7 @@ static int get_next_submodule(struct child_process *cp,
 		cp->dir = task->repo->gitdir;
 
 		strvec_init(&cp->args);
-		strvec_pushv(&cp->args, spf->args.argv);
+		strvec_pushv(&cp->args, spf->args.items);
 		strvec_push(&cp->args, "on-demand");
 		strvec_push(&cp->args, "--submodule-prefix");
 		strvec_push(&cp->args, submodule_prefix.buf);
@@ -1619,8 +1619,8 @@ int fetch_populated_submodules(struct repository *r,
 		die(_("index file corrupt"));
 
 	strvec_push(&spf.args, "fetch");
-	for (i = 0; i < options->argc; i++)
-		strvec_push(&spf.args, options->argv[i]);
+	for (i = 0; i < options->nr; i++)
+		strvec_push(&spf.args, options->items[i]);
 	strvec_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 726835fcc2..605135be42 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -248,7 +248,7 @@ static int quote_stress_test(int argc, const char **argv)
 		else
 			strvec_pushl(&args, "test-tool", "run-command",
 				     "quote-echo", NULL);
-		arg_offset = args.argc;
+		arg_offset = args.nr;
 
 		if (argc > 0) {
 			trials = 1;
@@ -275,13 +275,13 @@ static int quote_stress_test(int argc, const char **argv)
 		if (i < skip)
 			continue;
 
-		cp.argv = args.argv;
+		cp.argv = args.items;
 		strbuf_reset(&out);
 		if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) < 0)
 			return error("Failed to spawn child process");
 
 		for (j = 0, k = 0; j < arg_count; j++) {
-			const char *arg = args.argv[j + arg_offset];
+			const char *arg = args.items[j + arg_offset];
 
 			if (strcmp(arg, out.buf + k))
 				ret = error("incorrectly quoted arg: '%s', "
@@ -298,7 +298,7 @@ static int quote_stress_test(int argc, const char **argv)
 			fprintf(stderr, "Trial #%d failed. Arguments:\n", i);
 			for (j = 0; j < arg_count; j++)
 				fprintf(stderr, "arg #%d: '%s'\n",
-					(int)j, args.argv[j + arg_offset]);
+					(int)j, args.items[j + arg_offset]);
 
 			strbuf_release(&out);
 			strvec_clear(&args);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index e78e481d8e..e21bef6cca 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -283,7 +283,7 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 {
 	if (!t)
 		return NULL;
-	return t->env.argv;
+	return t->env.items;
 }
 
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
diff --git a/transport-helper.c b/transport-helper.c
index ae8011e9d5..8abdf09faa 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -138,7 +138,7 @@ static struct child_process *get_helper(struct transport *transport)
 		strvec_pushf(&helper->env_array, "%s=%s",
 			     GIT_DIR_ENVIRONMENT, get_git_dir());
 
-	helper->trace2_child_class = helper->args.argv[0]; /* "remote-<name>" */
+	helper->trace2_child_class = helper->args.items[0]; /* "remote-<name>" */
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
diff --git a/upload-pack.c b/upload-pack.c
index 4a7918e04e..5783e23dcb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -897,7 +897,7 @@ static int send_shallow_list(struct upload_pack_data *data)
 			struct object *o = data->want_obj.objects[i].item;
 			strvec_push(&av, oid_to_hex(&o->oid));
 		}
-		deepen_by_rev_list(data, av.argc, av.argv);
+		deepen_by_rev_list(data, av.nr, av.items);
 		strvec_clear(&av);
 		ret = 1;
 	} else {
-- 
2.28.0.rc2.475.g53c7e1c7f4
