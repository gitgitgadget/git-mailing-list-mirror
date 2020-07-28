Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F55AC433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0055B2065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgG1U0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:26:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:40236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgG1U0g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:26:36 -0400
Received: (qmail 29762 invoked by uid 109); 28 Jul 2020 20:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:26:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28610 invoked by uid 111); 28 Jul 2020 20:26:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:26:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:26:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/11] strvec: fix indentation in renamed calls
Message-ID: <20200728202631.GH1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Code which split an argv_array call across multiple lines, like:

  argv_array_pushl(&args, "one argument",
                   "another argument", "and more",
		   NULL);

was recently mechanically renamed to use strvec, which results in
mis-matched indentation like:

  strvec_pushl(&args, "one argument",
                   "another argument", "and more",
		   NULL);

Let's fix these up to align the arguments with the opening paren. I did
this manually by sifting through the results of:

  git jump grep 'strvec_.*,$'

and liberally applying my editor's auto-format. Most of the changes are
of the form shown above, though I also normalized a few that had
originally used a single-tab indentation (rather than our usual style of
aligning with the open paren). I also rewrapped a couple of obvious
cases (e.g., where previously too-long lines became short enough to fit
on one), but I wasn't aggressive about it. In cases broken to three or
more lines, the grouping of arguments is sometimes meaningful, and it
wasn't worth my time or reviewer time to ponder each case individually.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c           | 10 ++++-----
 add-patch.c                 | 10 ++++-----
 bisect.c                    |  2 +-
 builtin/bisect--helper.c    |  2 +-
 builtin/describe.c          |  8 +++----
 builtin/difftool.c          | 12 +++++------
 builtin/fetch.c             |  2 +-
 builtin/gc.c                |  2 +-
 builtin/pull.c              |  6 +++---
 builtin/rebase.c            | 14 ++++++-------
 builtin/receive-pack.c      | 42 ++++++++++++++++++-------------------
 builtin/repack.c            |  8 +++----
 builtin/stash.c             | 38 ++++++++++++++++-----------------
 builtin/submodule--helper.c | 20 +++++++++---------
 builtin/worktree.c          | 18 ++++++++--------
 bundle.c                    | 10 ++++-----
 connect.c                   |  7 ++++---
 connected.c                 |  2 +-
 daemon.c                    |  6 +++---
 fetch-pack.c                | 12 +++++------
 gpg-interface.c             | 14 ++++++-------
 http-backend.c              |  2 +-
 http-push.c                 |  2 +-
 http.c                      |  2 +-
 range-diff.c                | 28 ++++++++++++-------------
 refspec.c                   |  4 ++--
 remote-curl.c               |  8 +++----
 remote.c                    |  4 ++--
 sequencer.c                 |  8 +++----
 submodule.c                 | 30 +++++++++++++-------------
 t/helper/test-run-command.c |  6 +++---
 transport-helper.c          |  2 +-
 upload-pack.c               |  3 +--
 wt-status.c                 |  3 +--
 34 files changed, 173 insertions(+), 174 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index b345777d0c..458f3a3e69 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -941,7 +941,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		for (i = 0; i < files->items.nr; i++)
 			if (files->selected[i])
 				strvec_push(&args,
-						files->items.items[i].string);
+					    files->items.items[i].string);
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 			       PATHSPEC_LITERAL_PATH, "", args.argv);
@@ -979,13 +979,13 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 		struct strvec args = STRVEC_INIT;
 
 		strvec_pushl(&args, "git", "diff", "-p", "--cached",
-				 oid_to_hex(!is_initial ? &oid :
-					    s->r->hash_algo->empty_tree),
-				 "--", NULL);
+			     oid_to_hex(!is_initial ? &oid :
+					s->r->hash_algo->empty_tree),
+			     "--", NULL);
 		for (i = 0; i < files->items.nr; i++)
 			if (files->selected[i])
 				strvec_push(&args,
-						files->items.items[i].string);
+					    files->items.items[i].string);
 		res = run_command_v_opt(args.argv, 0);
 		strvec_clear(&args);
 	}
diff --git a/add-patch.c b/add-patch.c
index 3c91ae52ae..8c0772803b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -291,7 +291,7 @@ static void setup_child_process(struct add_p_state *s,
 
 	cp->git_cmd = 1;
 	strvec_pushf(&cp->env_array,
-			 INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
+		     INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
 }
 
 static int parse_range(const char **p,
@@ -386,10 +386,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	if (s->revision) {
 		struct object_id oid;
 		strvec_push(&args,
-				/* could be on an unborn branch */
-				!strcmp("HEAD", s->revision) &&
-				get_oid("HEAD", &oid) ?
-				empty_tree_oid_hex() : s->revision);
+			    /* could be on an unborn branch */
+			    !strcmp("HEAD", s->revision) &&
+			    get_oid("HEAD", &oid) ?
+			    empty_tree_oid_hex() : s->revision);
 	}
 	color_arg_index = args.argc;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
diff --git a/bisect.c b/bisect.c
index 3e50b51c11..99ff694960 100644
--- a/bisect.c
+++ b/bisect.c
@@ -644,7 +644,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	strvec_pushf(&rev_argv, bad_format, oid_to_hex(current_bad_oid));
 	for (i = 0; i < good_revs.nr; i++)
 		strvec_pushf(&rev_argv, good_format,
-				 oid_to_hex(good_revs.oid + i));
+			     oid_to_hex(good_revs.oid + i));
 	strvec_push(&rev_argv, "--");
 	if (read_paths)
 		read_bisect_paths(&rev_argv);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9815e78871..dd52878413 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -529,7 +529,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			struct strvec argv = STRVEC_INIT;
 
 			strvec_pushl(&argv, "checkout", start_head.buf,
-					 "--", NULL);
+				     "--", NULL);
 			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 				res = error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
diff --git a/builtin/describe.c b/builtin/describe.c
index ff3c169fa9..e3cac8002c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -505,8 +505,8 @@ static void describe_blob(struct object_id oid, struct strbuf *dst)
 	struct process_commit_data pcd = { null_oid, oid, dst, &revs};
 
 	strvec_pushl(&args, "internal: The first arg is not parsed",
-		"--objects", "--in-commit-order", "--reverse", "HEAD",
-		NULL);
+		     "--objects", "--in-commit-order", "--reverse", "HEAD",
+		     NULL);
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
@@ -598,8 +598,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 		strvec_init(&args);
 		strvec_pushl(&args, "name-rev",
-				 "--peel-tag", "--name-only", "--no-undefined",
-				 NULL);
+			     "--peel-tag", "--name-only", "--no-undefined",
+			     NULL);
 		if (always)
 			strvec_push(&args, "--always");
 		if (!all) {
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 40c4d7b6b6..5ac021a1d4 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -211,9 +211,9 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	env[0] = index_env.buf;
 
 	strvec_pushl(&update_index.args,
-			 "--git-dir", git_dir, "--work-tree", workdir,
-			 "update-index", "--really-refresh", "-q",
-			 "--unmerged", NULL);
+		     "--git-dir", git_dir, "--work-tree", workdir,
+		     "update-index", "--really-refresh", "-q",
+		     "--unmerged", NULL);
 	update_index.no_stdin = 1;
 	update_index.no_stdout = 1;
 	update_index.no_stderr = 1;
@@ -226,8 +226,8 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	run_command(&update_index);
 
 	strvec_pushl(&diff_files.args,
-			 "--git-dir", git_dir, "--work-tree", workdir,
-			 "diff-files", "--name-only", "-z", NULL);
+		     "--git-dir", git_dir, "--work-tree", workdir,
+		     "diff-files", "--name-only", "-z", NULL);
 	diff_files.no_stdin = 1;
 	diff_files.git_cmd = 1;
 	diff_files.use_shell = 0;
@@ -394,7 +394,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	child.dir = prefix;
 	child.out = -1;
 	strvec_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
-			 NULL);
+		     NULL);
 	for (i = 0; i < argc; i++)
 		strvec_push(&child.args, argv[i]);
 	if (start_command(&child))
diff --git a/builtin/fetch.c b/builtin/fetch.c
index cc636188ad..c2e7afeb6a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1601,7 +1601,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 	}
 
 	strvec_pushl(&argv, "fetch", "--append", "--no-auto-gc",
-			"--no-write-commit-graph", NULL);
+		     "--no-write-commit-graph", NULL);
 	add_options_to_argv(&argv);
 
 	if (max_children != 1 && list->nr != 1) {
diff --git a/builtin/gc.c b/builtin/gc.c
index 89742e159e..98719800a3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -662,7 +662,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 				strvec_push(&prune, "--no-progress");
 			if (has_promisor_remote())
 				strvec_push(&prune,
-						"--exclude-promisor-objects");
+					    "--exclude-promisor-objects");
 			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
 				die(FAILED_RUN, prune.argv[0]);
 		}
diff --git a/builtin/pull.c b/builtin/pull.c
index 8a8d30e1dc..dae8766646 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -638,7 +638,7 @@ static int rebase_submodules(void)
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	strvec_pushl(&cp.args, "submodule", "update",
-				   "--recursive", "--rebase", NULL);
+		     "--recursive", "--rebase", NULL);
 	argv_push_verbosity(&cp.args);
 
 	return run_command(&cp);
@@ -651,7 +651,7 @@ static int update_submodules(void)
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	strvec_pushl(&cp.args, "submodule", "update",
-				   "--recursive", "--checkout", NULL);
+		     "--recursive", "--checkout", NULL);
 	argv_push_verbosity(&cp.args);
 
 	return run_command(&cp);
@@ -802,7 +802,7 @@ static int get_rebase_fork_point(struct object_id *fork_point, const char *repo,
 		return -1;
 
 	strvec_pushl(&cp.args, "merge-base", "--fork-point",
-			remote_branch, curr_branch->name, NULL);
+		     remote_branch, curr_branch->name, NULL);
 	cp.no_stdin = 1;
 	cp.no_stderr = 1;
 	cp.git_cmd = 1;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index fb56b9e263..35aeb8effc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -348,7 +348,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	strvec_pushl(&make_script_args, "", revisions, NULL);
 	if (opts->restrict_revision)
 		strvec_pushf(&make_script_args, "^%s",
-				 oid_to_hex(&opts->restrict_revision->object.oid));
+			     oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
@@ -858,17 +858,17 @@ static int run_am(struct rebase_options *opts)
 
 	format_patch.git_cmd = 1;
 	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
-			 "--full-index", "--cherry-pick", "--right-only",
-			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
-			 "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
-			 "--no-base", NULL);
+		     "--full-index", "--cherry-pick", "--right-only",
+		     "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
+		     "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
+		     "--no-base", NULL);
 	if (opts->git_format_patch_opt.len)
 		strvec_split(&format_patch.args,
-				 opts->git_format_patch_opt.buf);
+			     opts->git_format_patch_opt.buf);
 	strvec_push(&format_patch.args, revisions.buf);
 	if (opts->restrict_revision)
 		strvec_pushf(&format_patch.args, "^%s",
-				 oid_to_hex(&opts->restrict_revision->object.oid));
+			     oid_to_hex(&opts->restrict_revision->object.oid));
 
 	status = run_command(&format_patch);
 	if (status) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 71274231aa..1fc69cf5bc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -668,24 +668,24 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 	}
 	if (!is_null_oid(&push_cert_oid)) {
 		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
-				 oid_to_hex(&push_cert_oid));
+			     oid_to_hex(&push_cert_oid));
 		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_SIGNER=%s",
-				 sigcheck.signer ? sigcheck.signer : "");
+			     sigcheck.signer ? sigcheck.signer : "");
 		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_KEY=%s",
-				 sigcheck.key ? sigcheck.key : "");
+			     sigcheck.key ? sigcheck.key : "");
 		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
-				 sigcheck.result);
+			     sigcheck.result);
 		if (push_cert_nonce) {
 			strvec_pushf(&proc->env_array,
-					 "GIT_PUSH_CERT_NONCE=%s",
-					 push_cert_nonce);
+				     "GIT_PUSH_CERT_NONCE=%s",
+				     push_cert_nonce);
 			strvec_pushf(&proc->env_array,
-					 "GIT_PUSH_CERT_NONCE_STATUS=%s",
-					 nonce_status);
+				     "GIT_PUSH_CERT_NONCE_STATUS=%s",
+				     nonce_status);
 			if (nonce_status == NONCE_SLOP)
 				strvec_pushf(&proc->env_array,
-						 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
-						 nonce_stamp_slop);
+					     "GIT_PUSH_CERT_NONCE_SLOP=%ld",
+					     nonce_stamp_slop);
 		}
 	}
 }
@@ -721,10 +721,10 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 		int i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
 			strvec_pushf(&proc.env_array,
-				"GIT_PUSH_OPTION_%d=%s", i,
-				feed_state->push_options->items[i].string);
+				     "GIT_PUSH_OPTION_%d=%s", i,
+				     feed_state->push_options->items[i].string);
 		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
-				 feed_state->push_options->nr);
+			     feed_state->push_options->nr);
 	} else
 		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
 
@@ -1718,7 +1718,7 @@ static const char *pack_lockfile;
 static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 {
 	strvec_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
-			ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
+		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
 static const char *unpack(int err_fd, struct shallow_info *si)
@@ -1768,10 +1768,10 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 			strvec_push(&child.args, "-q");
 		if (fsck_objects)
 			strvec_pushf(&child.args, "--strict%s",
-				fsck_msg_types.buf);
+				     fsck_msg_types.buf);
 		if (max_input_size)
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				(uintmax_t)max_input_size);
+				     (uintmax_t)max_input_size);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1787,22 +1787,22 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (xgethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
 		strvec_pushf(&child.args,
-				 "--keep=receive-pack %"PRIuMAX" on %s",
-				 (uintmax_t)getpid(),
-				 hostname);
+			     "--keep=receive-pack %"PRIuMAX" on %s",
+			     (uintmax_t)getpid(),
+			     hostname);
 
 		if (!quiet && err_fd)
 			strvec_push(&child.args, "--show-resolving-progress");
 		if (use_sideband)
 			strvec_push(&child.args, "--report-end-of-input");
 		if (fsck_objects)
 			strvec_pushf(&child.args, "--strict%s",
-				fsck_msg_types.buf);
+				     fsck_msg_types.buf);
 		if (!reject_thin)
 			strvec_push(&child.args, "--fix-thin");
 		if (max_input_size)
 			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				(uintmax_t)max_input_size);
+				     (uintmax_t)max_input_size);
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
diff --git a/builtin/repack.c b/builtin/repack.c
index 7435ee9af1..04c5ceaf7e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -366,7 +366,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--honor-pack-keep");
 	for (i = 0; i < keep_pack_list.nr; i++)
 		strvec_pushf(&cmd.args, "--keep-pack=%s",
-				 keep_pack_list.items[i].string);
+			     keep_pack_list.items[i].string);
 	strvec_push(&cmd.args, "--non-empty");
 	strvec_push(&cmd.args, "--all");
 	strvec_push(&cmd.args, "--reflog");
@@ -388,12 +388,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable) {
 				strvec_pushf(&cmd.args,
-						"--unpack-unreachable=%s",
-						unpack_unreachable);
+					     "--unpack-unreachable=%s",
+					     unpack_unreachable);
 				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
 			} else if (pack_everything & LOOSEN_UNREACHABLE) {
 				strvec_push(&cmd.args,
-						"--unpack-unreachable");
+					    "--unpack-unreachable");
 			} else if (keep_unreachable) {
 				strvec_push(&cmd.args, "--keep-unreachable");
 				strvec_push(&cmd.args, "--pack-loose-unreachable");
diff --git a/builtin/stash.c b/builtin/stash.c
index 05c086e54c..bfdbafae89 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -336,7 +336,7 @@ static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
 	 */
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "diff-index", "--cached", "--name-only",
-			 "--diff-filter=A", NULL);
+		     "--diff-filter=A", NULL);
 	strvec_push(&cp.args, c_tree_hex);
 	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
 }
@@ -368,7 +368,7 @@ static int restore_untracked(struct object_id *u_tree)
 	strvec_push(&cp.args, "read-tree");
 	strvec_push(&cp.args, oid_to_hex(u_tree));
 	strvec_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
+		     stash_index_path.buf);
 	if (run_command(&cp)) {
 		remove_path(stash_index_path.buf);
 		return -1;
@@ -378,7 +378,7 @@ static int restore_untracked(struct object_id *u_tree)
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "checkout-index", "--all", NULL);
 	strvec_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
+		     stash_index_path.buf);
 
 	res = run_command(&cp);
 	remove_path(stash_index_path.buf);
@@ -500,9 +500,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		cp.git_cmd = 1;
 		cp.dir = prefix;
 		strvec_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=%s",
-				 absolute_path(get_git_work_tree()));
+			     absolute_path(get_git_work_tree()));
 		strvec_pushf(&cp.env_array, GIT_DIR_ENVIRONMENT"=%s",
-				 absolute_path(get_git_dir()));
+			     absolute_path(get_git_dir()));
 		strvec_push(&cp.args, "status");
 		run_command(&cp);
 	}
@@ -547,7 +547,7 @@ static int do_drop_stash(struct stash_info *info, int quiet)
 
 	cp_reflog.git_cmd = 1;
 	strvec_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
-			 "--rewrite", NULL);
+		     "--rewrite", NULL);
 	strvec_push(&cp_reflog.args, info->revision.buf);
 	ret = run_command(&cp_reflog);
 	if (!ret) {
@@ -693,7 +693,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
-			 "--first-parent", "-m", NULL);
+		     "--first-parent", "-m", NULL);
 	strvec_pushv(&cp.args, argv);
 	strvec_push(&cp.args, ref_stash);
 	strvec_push(&cp.args, "--");
@@ -961,7 +961,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 
 	cp_upd_index.git_cmd = 1;
 	strvec_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
-			 "--remove", "--stdin", NULL);
+		     "--remove", "--stdin", NULL);
 	strvec_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 
@@ -1005,7 +1005,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	cp_read_tree.git_cmd = 1;
 	strvec_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
 	strvec_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
+		     stash_index_path.buf);
 	if (run_command(&cp_read_tree)) {
 		ret = -1;
 		goto done;
@@ -1035,7 +1035,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 
 	cp_diff_tree.git_cmd = 1;
 	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
-			 oid_to_hex(&info->w_tree), "--", NULL);
+		     oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
 		ret = -1;
 		goto done;
@@ -1089,10 +1089,10 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
 	cp_upd_index.git_cmd = 1;
 	strvec_pushl(&cp_upd_index.args, "update-index",
-			 "--ignore-skip-worktree-entries",
-			 "-z", "--add", "--remove", "--stdin", NULL);
+		     "--ignore-skip-worktree-entries",
+		     "-z", "--add", "--remove", "--stdin", NULL);
 	strvec_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
+		     stash_index_path.buf);
 
 	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
 			 NULL, 0, NULL, 0)) {
@@ -1343,7 +1343,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 			cp.git_cmd = 1;
 			strvec_pushl(&cp.args, "clean", "--force",
-					 "--quiet", "-d", NULL);
+				     "--quiet", "-d", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
 				strvec_push(&cp.args, "-x");
 			if (run_command(&cp)) {
@@ -1373,8 +1373,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 			cp_diff.git_cmd = 1;
 			strvec_pushl(&cp_diff.args, "diff-index", "-p",
-					 "--cached", "--binary", "HEAD", "--",
-					 NULL);
+				     "--cached", "--binary", "HEAD", "--",
+				     NULL);
 			add_pathspecs(&cp_diff.args, ps);
 			if (pipe_command(&cp_diff, NULL, 0, &out, 0, NULL, 0)) {
 				ret = -1;
@@ -1383,7 +1383,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 			cp_apply.git_cmd = 1;
 			strvec_pushl(&cp_apply.args, "apply", "--index",
-					 "-R", NULL);
+				     "-R", NULL);
 			if (pipe_command(&cp_apply, out.buf, out.len, NULL, 0,
 					 NULL, 0)) {
 				ret = -1;
@@ -1393,7 +1393,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
 			strvec_pushl(&cp.args, "reset", "--hard", "-q",
-					 "--no-recurse-submodules", NULL);
+				     "--no-recurse-submodules", NULL);
 			if (run_command(&cp)) {
 				ret = -1;
 				goto done;
@@ -1405,7 +1405,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 			cp.git_cmd = 1;
 			strvec_pushl(&cp.args, "checkout", "--no-overlay",
-					 oid_to_hex(&info.i_tree), "--", NULL);
+				     oid_to_hex(&info.i_tree), "--", NULL);
 			if (!ps->nr)
 				strvec_push(&cp.args, ":/");
 			else
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7705e8eabf..665db1ffed 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -499,7 +499,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		strvec_pushf(&cp.env_array, "sm_path=%s", path);
 		strvec_pushf(&cp.env_array, "displaypath=%s", displaypath);
 		strvec_pushf(&cp.env_array, "sha1=%s",
-				oid_to_hex(ce_oid));
+			     oid_to_hex(ce_oid));
 		strvec_pushf(&cp.env_array, "toplevel=%s", toplevel);
 
 		/*
@@ -513,7 +513,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		 */
 		sq_quote_buf(&sb, path);
 		strvec_pushf(&cp.args, "path=%s; %s",
-				 sb.buf, info->argv[0]);
+			     sb.buf, info->argv[0]);
 		strbuf_release(&sb);
 		free(toplevel);
 	} else {
@@ -537,7 +537,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		strvec_pushl(&cpr.args, "--super-prefix", NULL);
 		strvec_pushf(&cpr.args, "%s/", displaypath);
 		strvec_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
-				NULL);
+			     NULL);
 
 		if (info->quiet)
 			strvec_push(&cpr.args, "--quiet");
@@ -810,8 +810,8 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	strbuf_release(&buf);
 
 	strvec_pushl(&diff_files_args, "diff-files",
-			 "--ignore-submodules=dirty", "--quiet", "--",
-			 path, NULL);
+		     "--ignore-submodules=dirty", "--quiet", "--",
+		     path, NULL);
 
 	git_config(git_diff_basic_config, NULL);
 
@@ -852,7 +852,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		strvec_push(&cpr.args, "--super-prefix");
 		strvec_pushf(&cpr.args, "%s/", displaypath);
 		strvec_pushl(&cpr.args, "submodule--helper", "status",
-				 "--recursive", NULL);
+			     "--recursive", NULL);
 
 		if (flags & OPT_CACHED)
 			strvec_push(&cpr.args, "--cached");
@@ -996,7 +996,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	cp.git_cmd = 1;
 	cp.dir = path;
 	strvec_pushl(&cp.args, "submodule--helper",
-			 "print-default-remote", NULL);
+		     "print-default-remote", NULL);
 
 	strbuf_reset(&sb);
 	if (capture_command(&cp, &sb, 0))
@@ -1024,7 +1024,7 @@ static void sync_submodule(const char *path, const char *prefix,
 		strvec_push(&cpr.args, "--super-prefix");
 		strvec_pushf(&cpr.args, "%s/", displaypath);
 		strvec_pushl(&cpr.args, "submodule--helper", "sync",
-				 "--recursive", NULL);
+			     "--recursive", NULL);
 
 		if (flags & OPT_QUIET)
 			strvec_push(&cpr.args, "--quiet");
@@ -1128,7 +1128,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 			struct child_process cp_rm = CHILD_PROCESS_INIT;
 			cp_rm.git_cmd = 1;
 			strvec_pushl(&cp_rm.args, "rm", "-qn",
-					 path, NULL);
+				     path, NULL);
 
 			if (run_command(&cp_rm))
 				die(_("Submodule work tree '%s' contains local "
@@ -1251,7 +1251,7 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		struct string_list_item *item;
 		for_each_string_list_item(item, reference)
 			strvec_pushl(&cp.args, "--reference",
-					 item->string, NULL);
+				     item->string, NULL);
 	}
 	if (dissociate)
 		strvec_push(&cp.args, "--dissociate");
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3c483c23d4..be5d84f0a0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -414,10 +414,10 @@ static int add_worktree(const char *path, const char *refname,
 
 	if (!is_branch)
 		strvec_pushl(&cp.args, "update-ref", "HEAD",
-				 oid_to_hex(&commit->object.oid), NULL);
+			     oid_to_hex(&commit->object.oid), NULL);
 	else {
 		strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
-				 symref.buf, NULL);
+			     symref.buf, NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
 	}
@@ -466,9 +466,9 @@ static int add_worktree(const char *path, const char *refname,
 			cp.argv = NULL;
 			cp.trace2_hook_name = "post-checkout";
 			strvec_pushl(&cp.args, absolute_path(hook),
-					 oid_to_hex(&null_oid),
-					 oid_to_hex(&commit->object.oid),
-					 "1", NULL);
+				     oid_to_hex(&null_oid),
+				     oid_to_hex(&commit->object.oid),
+				     "1", NULL);
 			ret = run_command(&cp);
 		}
 	}
@@ -936,13 +936,13 @@ static void check_clean_worktree(struct worktree *wt,
 	validate_no_submodules(wt);
 
 	strvec_pushf(&child_env, "%s=%s/.git",
-			 GIT_DIR_ENVIRONMENT, wt->path);
+		     GIT_DIR_ENVIRONMENT, wt->path);
 	strvec_pushf(&child_env, "%s=%s",
-			 GIT_WORK_TREE_ENVIRONMENT, wt->path);
+		     GIT_WORK_TREE_ENVIRONMENT, wt->path);
 	memset(&cp, 0, sizeof(cp));
 	strvec_pushl(&cp.args, "status",
-			 "--porcelain", "--ignore-submodules=none",
-			 NULL);
+		     "--porcelain", "--ignore-submodules=none",
+		     NULL);
 	cp.env = child_env.argv;
 	cp.git_cmd = 1;
 	cp.dir = wt->path;
diff --git a/bundle.c b/bundle.c
index 709b2abc9c..565d05367f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -275,9 +275,9 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 	int i;
 
 	strvec_pushl(&pack_objects.args,
-			 "pack-objects",
-			 "--stdout", "--thin", "--delta-base-offset",
-			 NULL);
+		     "pack-objects",
+		     "--stdout", "--thin", "--delta-base-offset",
+		     NULL);
 	strvec_pushv(&pack_objects.args, pack_options->argv);
 	pack_objects.in = -1;
 	pack_objects.out = bundle_fd;
@@ -322,8 +322,8 @@ static int compute_and_write_prerequisites(int bundle_fd,
 	int i;
 
 	strvec_pushl(&rls.args,
-			 "rev-list", "--boundary", "--pretty=oneline",
-			 NULL);
+		     "rev-list", "--boundary", "--pretty=oneline",
+		     NULL);
 	for (i = 1; i < argc; i++)
 		strvec_push(&rls.args, argv[i]);
 	rls.out = -1;
diff --git a/connect.c b/connect.c
index 9b453fe792..3299ea956a 100644
--- a/connect.c
+++ b/connect.c
@@ -1208,7 +1208,7 @@ static void push_ssh_options(struct strvec *args, struct strvec *env,
 		strvec_push(args, "-o");
 		strvec_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
 		strvec_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-				 version);
+			     version);
 	}
 
 	if (flags & CONNECT_IPV4) {
@@ -1397,8 +1397,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 			transport_check_allowed("file");
 			conn->trace2_child_class = "transport/file";
 			if (version > 0) {
-				strvec_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-						 version);
+				strvec_pushf(&conn->env_array,
+					     GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+					     version);
 			}
 		}
 		strvec_push(&conn->args, cmd.buf);
diff --git a/connected.c b/connected.c
index 96b47879d3..21c1ebe9fb 100644
--- a/connected.c
+++ b/connected.c
@@ -106,7 +106,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	strvec_push(&rev_list.args, "--alternate-refs");
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
-				 _("Checking connectivity"));
+			     _("Checking connectivity"));
 
 	rev_list.git_cmd = 1;
 	rev_list.env = opt->env;
diff --git a/daemon.c b/daemon.c
index cea5f5354f..0dec89fa02 100644
--- a/daemon.c
+++ b/daemon.c
@@ -665,7 +665,7 @@ static void parse_extra_args(struct hostinfo *hi, struct strvec *env,
 	if (git_protocol.len > 0) {
 		loginfo("Extended attribute \"protocol\": %s", git_protocol.buf);
 		strvec_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
-				 git_protocol.buf);
+			     git_protocol.buf);
 	}
 	strbuf_release(&git_protocol);
 }
@@ -915,15 +915,15 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		inet_ntop(addr->sa_family, &sin_addr->sin_addr, buf, sizeof(buf));
 		strvec_pushf(&cld.env_array, "REMOTE_ADDR=%s", buf);
 		strvec_pushf(&cld.env_array, "REMOTE_PORT=%d",
-				 ntohs(sin_addr->sin_port));
+			     ntohs(sin_addr->sin_port));
 #ifndef NO_IPV6
 	} else if (addr->sa_family == AF_INET6) {
 		char buf[128] = "";
 		struct sockaddr_in6 *sin6_addr = (void *) addr;
 		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(buf));
 		strvec_pushf(&cld.env_array, "REMOTE_ADDR=[%s]", buf);
 		strvec_pushf(&cld.env_array, "REMOTE_PORT=%d",
-				 ntohs(sin6_addr->sin6_port));
+			     ntohs(sin6_addr->sin6_port));
 #endif
 	}
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 7aa5dfbdad..7f20eca4f8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -854,8 +854,8 @@ static int get_pack(struct fetch_pack_args *args,
 			if (xgethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
 			strvec_pushf(&cmd.args,
-					"--keep=fetch-pack %"PRIuMAX " on %s",
-					(uintmax_t)getpid(), hostname);
+				     "--keep=fetch-pack %"PRIuMAX " on %s",
+				     (uintmax_t)getpid(), hostname);
 		}
 		if (only_packfile && args->check_self_contained_and_connected)
 			strvec_push(&cmd.args, "--check-self-contained-and-connected");
@@ -885,7 +885,7 @@ static int get_pack(struct fetch_pack_args *args,
 
 	if (pass_header)
 		strvec_pushf(&cmd.args, "--pack_header=%"PRIu32",%"PRIu32,
-				 ntohl(header.hdr_version),
+			     ntohl(header.hdr_version),
 				 ntohl(header.hdr_entries));
 	if (fetch_fsck_objects >= 0
 	    ? fetch_fsck_objects
@@ -901,7 +901,7 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(&cmd.args, "--fsck-objects");
 		else
 			strvec_pushf(&cmd.args, "--strict%s",
-					 fsck_msg_types.buf);
+				     fsck_msg_types.buf);
 	}
 
 	cmd.in = demux.out;
@@ -1654,8 +1654,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 		strvec_push(&cmd.args, "http-fetch");
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
-				 (int) the_hash_algo->hexsz,
-				 packfile_uris.items[i].string);
+			     (int) the_hash_algo->hexsz,
+			     packfile_uris.items[i].string);
 		strvec_push(&cmd.args, uri);
 		cmd.git_cmd = 1;
 		cmd.no_stdin = 1;
diff --git a/gpg-interface.c b/gpg-interface.c
index cf56fe838f..b499270836 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -285,9 +285,9 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
 	strvec_push(&gpg.args, fmt->program);
 	strvec_pushv(&gpg.args, fmt->verify_args);
 	strvec_pushl(&gpg.args,
-			 "--status-fd=1",
-			 "--verify", temp->filename.buf, "-",
-			 NULL);
+		     "--status-fd=1",
+		     "--verify", temp->filename.buf, "-",
+		     NULL);
 
 	if (!gpg_status)
 		gpg_status = &buf;
@@ -435,10 +435,10 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	struct strbuf gpg_status = STRBUF_INIT;
 
 	strvec_pushl(&gpg.args,
-			 use_format->program,
-			 "--status-fd=2",
-			 "-bsau", signing_key,
-			 NULL);
+		     use_format->program,
+		     "--status-fd=2",
+		     "-bsau", signing_key,
+		     NULL);
 
 	bottom = signature->len;
 
diff --git a/http-backend.c b/http-backend.c
index 92fd62f73f..a03b4bae22 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -480,7 +480,7 @@ static void run_service(const char **argv, int buffer_input)
 		strvec_pushf(&cld.env_array, "GIT_COMMITTER_NAME=%s", user);
 	if (!getenv("GIT_COMMITTER_EMAIL"))
 		strvec_pushf(&cld.env_array,
-				 "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
+			     "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
 	cld.argv = argv;
 	if (buffer_input || gzipped_request || req_len >= 0)
diff --git a/http-push.c b/http-push.c
index e1deea6fe4..31911aa345 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1929,7 +1929,7 @@ int cmd_main(int argc, const char **argv)
 		strvec_push(&commit_argv, oid_to_hex(&ref->new_oid));
 		if (!push_all && !is_null_oid(&ref->old_oid))
 			strvec_pushf(&commit_argv, "^%s",
-					 oid_to_hex(&ref->old_oid));
+				     oid_to_hex(&ref->old_oid));
 		repo_init_revisions(the_repository, &revs, setup_git_directory());
 		setup_revisions(commit_argv.argc, commit_argv.argv, &revs, NULL);
 		revs.edge_hint = 0; /* just in case */
diff --git a/http.c b/http.c
index 268a1e9744..8b23a546af 100644
--- a/http.c
+++ b/http.c
@@ -2276,7 +2276,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	ip.in = tmpfile_fd;
 	if (preq->generate_keep) {
 		strvec_pushf(&ip.args, "--keep=git %"PRIuMAX,
-				 (uintmax_t)getpid());
+			     (uintmax_t)getpid());
 		ip.out = 0;
 	} else {
 		ip.no_stdout = 1;
diff --git a/range-diff.c b/range-diff.c
index 3a0eb70c89..831c490bf2 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -52,20 +52,20 @@ static int read_patches(const char *range, struct string_list *list,
 	size_t size;
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
-			"--reverse", "--date-order", "--decorate=no",
-			"--no-prefix",
-			/*
-			 * Choose indicators that are not used anywhere
-			 * else in diffs, but still look reasonable
-			 * (e.g. will not be confusing when debugging)
-			 */
-			"--output-indicator-new=>",
-			"--output-indicator-old=<",
-			"--output-indicator-context=#",
-			"--no-abbrev-commit",
-			"--pretty=medium",
-			"--notes",
-			NULL);
+		     "--reverse", "--date-order", "--decorate=no",
+		     "--no-prefix",
+		     /*
+		      * Choose indicators that are not used anywhere
+		      * else in diffs, but still look reasonable
+		      * (e.g. will not be confusing when debugging)
+		      */
+		     "--output-indicator-new=>",
+		     "--output-indicator-old=<",
+		     "--output-indicator-context=#",
+		     "--no-abbrev-commit",
+		     "--pretty=medium",
+		     "--notes",
+		     NULL);
 	if (other_arg)
 		strvec_pushv(&cp.args, other_arg->argv);
 	strvec_push(&cp.args, range);
diff --git a/refspec.c b/refspec.c
index 6f317d6b44..f10ef284ce 100644
--- a/refspec.c
+++ b/refspec.c
@@ -222,8 +222,8 @@ void refspec_ref_prefixes(const struct refspec *rs,
 			if (item->pattern) {
 				const char *glob = strchr(prefix, '*');
 				strvec_pushf(ref_prefixes, "%.*s",
-						 (int)(glob - prefix),
-						 prefix);
+					     (int)(glob - prefix),
+					     prefix);
 			} else {
 				expand_ref_prefix(ref_prefixes, prefix);
 			}
diff --git a/remote-curl.c b/remote-curl.c
index 85ce4f7e6f..7feaddc003 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1145,7 +1145,7 @@ static int fetch_git(struct discovery *heads,
 	struct strbuf rpc_result = STRBUF_INIT;
 
 	strvec_pushl(&args, "fetch-pack", "--stateless-rpc",
-			 "--stdin", "--lock-pack", NULL);
+		     "--stdin", "--lock-pack", NULL);
 	if (options.followtags)
 		strvec_push(&args, "--include-tag");
 	if (options.thin)
@@ -1166,7 +1166,7 @@ static int fetch_git(struct discovery *heads,
 		strvec_pushf(&args, "--shallow-since=%s", options.deepen_since);
 	for (i = 0; i < options.deepen_not.nr; i++)
 		strvec_pushf(&args, "--shallow-exclude=%s",
-				 options.deepen_not.items[i].string);
+			     options.deepen_not.items[i].string);
 	if (options.deepen_relative && options.depth)
 		strvec_push(&args, "--deepen-relative");
 	if (options.from_promisor)
@@ -1293,7 +1293,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 
 	strvec_init(&args);
 	strvec_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status",
-			 NULL);
+		     NULL);
 
 	if (options.thin)
 		strvec_push(&args, "--thin");
@@ -1311,7 +1311,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 		strvec_push(&args, "--verbose");
 	for (i = 0; i < options.push_options.nr; i++)
 		strvec_pushf(&args, "--push-option=%s",
-				 options.push_options.items[i].string);
+			     options.push_options.items[i].string);
 	strvec_push(&args, options.progress ? "--progress" : "--no-progress");
 	for_each_string_list_item(cas_option, &cas_options)
 		strvec_push(&args, cas_option->string);
diff --git a/remote.c b/remote.c
index 13b097866c..b4665fe5a3 100644
--- a/remote.c
+++ b/remote.c
@@ -1914,8 +1914,8 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	strvec_push(&argv, ""); /* ignored */
 	strvec_push(&argv, "--left-right");
 	strvec_pushf(&argv, "%s...%s",
-			 oid_to_hex(&ours->object.oid),
-			 oid_to_hex(&theirs->object.oid));
+		     oid_to_hex(&ours->object.oid),
+		     oid_to_hex(&theirs->object.oid));
 	strvec_push(&argv, "--");
 
 	repo_init_revisions(the_repository, &revs, NULL);
diff --git a/sequencer.c b/sequencer.c
index 80c770968a..31a2b1ab55 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3133,7 +3133,7 @@ static int do_exec(struct repository *r, const char *command_line)
 	child_argv[0] = command_line;
 	strvec_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
 	strvec_pushf(&child_env, "GIT_WORK_TREE=%s",
-			 absolute_path(get_git_work_tree()));
+		     absolute_path(get_git_work_tree()));
 	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
 					  child_env.argv);
 
@@ -3552,7 +3552,7 @@ static int do_merge(struct repository *r,
 			strvec_push(&cmd.args, strategy);
 			for (k = 0; k < opts->xopts_nr; k++)
 				strvec_pushf(&cmd.args,
-						 "-X%s", opts->xopts[k]);
+					     "-X%s", opts->xopts[k]);
 		}
 		strvec_push(&cmd.args, "--no-edit");
 		strvec_push(&cmd.args, "--no-ff");
@@ -3566,7 +3566,7 @@ static int do_merge(struct repository *r,
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
 			strvec_push(&cmd.args,
-					oid_to_hex(&j->item->object.oid));
+				    oid_to_hex(&j->item->object.oid));
 
 		strbuf_release(&ref_name);
 		unlink(git_path_cherry_pick_head(r));
@@ -3695,7 +3695,7 @@ void create_autostash(struct repository *r, const char *path,
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
-				 "stash", "create", "autostash", NULL);
+			     "stash", "create", "autostash", NULL);
 		stash.git_cmd = 1;
 		stash.no_stdin = 1;
 		strbuf_reset(&buf);
diff --git a/submodule.c b/submodule.c
index 5c9447422d..fb96d595b0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -495,7 +495,7 @@ void prepare_submodule_repo_env(struct strvec *out)
 {
 	prepare_submodule_repo_env_no_git_dir(out);
 	strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
-			 DEFAULT_GIT_DIR_ENVIRONMENT);
+		     DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
 static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
@@ -687,14 +687,14 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 
 	if (o->flags.reverse_diff) {
 		strvec_pushf(&cp.args, "--src-prefix=%s%s/",
-				 o->b_prefix, path);
+			     o->b_prefix, path);
 		strvec_pushf(&cp.args, "--dst-prefix=%s%s/",
-				 o->a_prefix, path);
+			     o->a_prefix, path);
 	} else {
 		strvec_pushf(&cp.args, "--src-prefix=%s%s/",
-				 o->a_prefix, path);
+			     o->a_prefix, path);
 		strvec_pushf(&cp.args, "--dst-prefix=%s%s/",
-				 o->b_prefix, path);
+			     o->b_prefix, path);
 	}
 	strvec_push(&cp.args, oid_to_hex(old_oid));
 	/*
@@ -1062,7 +1062,7 @@ static int push_submodule(const char *path,
 			const struct string_list_item *item;
 			for_each_string_list_item(item, push_options)
 				strvec_pushf(&cp.args, "--push-option=%s",
-						 item->string);
+					     item->string);
 		}
 
 		if (remote->origin != REMOTE_UNCONFIGURED) {
@@ -1780,7 +1780,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 		return 1;
 
 	strvec_pushl(&cp.args, "status", "--porcelain",
-				   "--ignore-submodules=none", NULL);
+		     "--ignore-submodules=none", NULL);
 
 	if (flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED)
 		strvec_push(&cp.args, "-uno");
@@ -1847,7 +1847,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "diff-index", "--quiet",
-				   "--cached", "HEAD", NULL);
+		     "--cached", "HEAD", NULL);
 	cp.no_stdin = 1;
 	cp.no_stdout = 1;
 	cp.dir = sub->path;
@@ -1867,7 +1867,7 @@ static void submodule_reset_index(const char *path)
 	cp.dir = path;
 
 	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-				   get_super_prefix_or_empty(), path);
+		     get_super_prefix_or_empty(), path);
 	strvec_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
 	strvec_push(&cp.args, empty_tree_oid_hex());
@@ -1948,7 +1948,7 @@ int submodule_move_head(const char *path,
 	cp.dir = path;
 
 	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-			get_super_prefix_or_empty(), path);
+		     get_super_prefix_or_empty(), path);
 	strvec_pushl(&cp.args, "read-tree", "--recurse-submodules", NULL);
 
 	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
@@ -1981,7 +1981,7 @@ int submodule_move_head(const char *path,
 
 			prepare_submodule_repo_env(&cp.env_array);
 			strvec_pushl(&cp.args, "update-ref", "HEAD",
-					 "--no-deref", new_head, NULL);
+				     "--no-deref", new_head, NULL);
 
 			if (run_command(&cp)) {
 				ret = -1;
@@ -2158,8 +2158,8 @@ void absorb_git_dir_into_superproject(const char *path,
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		strvec_pushl(&cp.args, "--super-prefix", sb.buf,
-					   "submodule--helper",
-					   "absorb-git-dirs", NULL);
+			     "submodule--helper",
+			     "absorb-git-dirs", NULL);
 		prepare_submodule_repo_env(&cp.env_array);
 		if (run_command(&cp))
 			die(_("could not recurse into submodule '%s'"), path);
@@ -2197,8 +2197,8 @@ int get_superproject_working_tree(struct strbuf *buf)
 	strvec_pop(&cp.env_array);
 
 	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
-			"ls-files", "-z", "--stage", "--full-name", "--",
-			subpath, NULL);
+		     "ls-files", "-z", "--stage", "--full-name", "--",
+		     subpath, NULL);
 	strbuf_reset(&sb);
 
 	cp.no_stdin = 1;
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 67dde56962..726835fcc2 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -244,10 +244,10 @@ static int quote_stress_test(int argc, const char **argv)
 		strvec_clear(&args);
 		if (msys2)
 			strvec_pushl(&args, "sh", "-c",
-					 "printf %s\\\\0 \"$@\"", "skip", NULL);
+				     "printf %s\\\\0 \"$@\"", "skip", NULL);
 		else
 			strvec_pushl(&args, "test-tool", "run-command",
-					 "quote-echo", NULL);
+				     "quote-echo", NULL);
 		arg_offset = args.argc;
 
 		if (argc > 0) {
@@ -339,7 +339,7 @@ static int inherit_handle(const char *argv0)
 	tmp = xmkstemp(path);
 
 	strvec_pushl(&cp.args,
-			 "test-tool", argv0, "inherited-handle-child", NULL);
+		     "test-tool", argv0, "inherited-handle-child", NULL);
 	cp.in = -1;
 	cp.no_stdout = cp.no_stderr = 1;
 	if (start_command(&cp) < 0)
diff --git a/transport-helper.c b/transport-helper.c
index dcd4adf444..ae8011e9d5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -136,7 +136,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	if (have_git_dir())
 		strvec_pushf(&helper->env_array, "%s=%s",
-				 GIT_DIR_ENVIRONMENT, get_git_dir());
+			     GIT_DIR_ENVIRONMENT, get_git_dir());
 
 	helper->trace2_child_class = helper->args.argv[0]; /* "remote-<name>" */
 
diff --git a/upload-pack.c b/upload-pack.c
index 1b0e1fca1a..4a7918e04e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -301,8 +301,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 			strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
 			strbuf_release(&buf);
 		} else {
-			strvec_pushf(&pack_objects.args, "--filter=%s",
-					 spec);
+			strvec_pushf(&pack_objects.args, "--filter=%s", spec);
 		}
 	}
 	if (uri_protocols) {
diff --git a/wt-status.c b/wt-status.c
index 60d4e847a5..8454662c90 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -913,8 +913,7 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	struct strbuf summary = STRBUF_INIT;
 	char *summary_content;
 
-	strvec_pushf(&sm_summary.env_array, "GIT_INDEX_FILE=%s",
-			 s->index_file);
+	strvec_pushf(&sm_summary.env_array, "GIT_INDEX_FILE=%s", s->index_file);
 
 	strvec_push(&sm_summary.args, "submodule");
 	strvec_push(&sm_summary.args, "summary");
-- 
2.28.0.rc2.475.g53c7e1c7f4

