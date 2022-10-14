Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC7C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJNPkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJNPkf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D2EBC44C
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so8147696wrp.10
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqWQpP4+MHgKm9G83g2j0bsZFUI5ekhWntQs2m2nobk=;
        b=Q1o7HIXZ+oLy0n2pM9qz7/xPZ2x2yteRXlg3+VaH6QhsbXwbvsjq5ZZPfB2famq4tJ
         0NhUawV/ZKOe7iT4iMrZoF69vPWSCRYkZ01njra8jq4oI0SZE/aIoA/sf9yQHrzxeIxk
         WTMRMLzyCCLB0m/CfnzGZr/69kuetZAlbDp2HugMLEBjvL156QtaPJGTeOEG7jPkDt0Z
         ZhPpApwi71bSjcOe3nKj/EtCCWI5UIq1aAvmy8SOWZoKi3bjzDf2ivkq/0/UnNOBhvr2
         YigeCbwAG0P3S8xYZ6aSDDAcvacIokqxbENQ2EZXLu76vAWZKOqIEYxEKZPo7alWO30R
         6NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqWQpP4+MHgKm9G83g2j0bsZFUI5ekhWntQs2m2nobk=;
        b=1xUB/lzKxj5hQb+jPSaeUE4vbAV1UZMhrzjpvBLInTCnr/YhCfOvXKelEPTR+F1inN
         vmBe30CVJteL2xTnFwvmSdSm4iIExyaUeD3wXETc3eULbeYrHTJ7tfDKZ2Gz4tmjnDT+
         VDWXwlwCuTYW+l1LXDtRAIYAx33OEun4MqS26kvuNAVjekngxjWrOJFM5rjKY4kv6HOi
         RQbG25+gtg/kxLjY1X5lvU9rvO/UltXYTSRb3yiVXl0vSA9RixfFcl0fcgXLPLXn1t48
         op7uY7WhrEqjk48cl7OWeU8YEnLKxqQgMBlFX/3KQBdn3KQ8n2dXSUAKCqmgIuz66pcb
         kFtw==
X-Gm-Message-State: ACrzQf2jQ5skAg5u0LrJf0aJGv7Ig5VTBcd0LbCyBdJ4J5MNC4+MSRpL
        aaXlNMY48U4C+xbgfpl/OeK5ofrHMX8GJA==
X-Google-Smtp-Source: AMsMyM5ceEigAEnMupB4FCaJzBdHHxFrOLClKQ3OfjpTzKcUqjlttHyOx3toblcmN6KaNUzHRfcKfw==
X-Received: by 2002:a05:6000:cf:b0:22e:58cd:5a38 with SMTP id q15-20020a05600000cf00b0022e58cd5a38mr3981557wrx.436.1665762030098;
        Fri, 14 Oct 2022 08:40:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] run-command API: add and use a run_command_l_opt()
Date:   Fri, 14 Oct 2022 17:40:15 +0200
Message-Id: <patch-03.10-fd81d44f221-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When run_command() is used with strvec_pushl() as in the pre-image of
b004c902827 (gc: simplify maintenance_task_pack_refs(), 2022-10-04) we
get the benefit of the LAST_ARG_MUST_BE_NULL. See 9fe3edc47f1 (Add the
LAST_ARG_MUST_BE_NULL macro, 2013-07-18).

Let's provide and use a run_command_l_opt() function, which gives us
the best of both worlds. We'll now need less code to accomplish the
same thing, and this version's safer as we can assert that the
terminating NULL is present.

The "builtin/bisect--helper.c" would be a large beneficiary of this
API, with "15 insertions(+), 26 deletions(-)", but let's leave that
aside for now, as there's an outstanding topic that's extensively
modifying it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                 | 19 +++++++++----------
 builtin/clone.c          | 16 ++++++----------
 builtin/difftool.c       | 14 ++++++--------
 builtin/gc.c             | 22 ++++++++--------------
 builtin/merge.c          | 35 ++++++-----------------------------
 builtin/remote.c         | 10 ++++------
 compat/mingw.c           |  8 +++-----
 ll-merge.c               |  4 +---
 run-command.c            | 15 +++++++++++++++
 run-command.h            | 13 +++++++++++--
 sequencer.c              |  4 +---
 t/helper/test-fake-ssh.c |  4 +---
 12 files changed, 71 insertions(+), 93 deletions(-)

diff --git a/bisect.c b/bisect.c
index fd581b85a72..415b0e7b0b2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -738,18 +738,17 @@ enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	argv_checkout[2] = bisect_rev_hex;
-	if (no_checkout) {
+	if (no_checkout)
 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
-	} else {
-		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
-			/*
-			 * Errors in `run_command()` itself, signaled by res < 0,
-			 * and errors in the child process, signaled by res > 0
-			 * can both be treated as regular BISECT_FAILED (-1).
-			 */
-			return BISECT_FAILED;
-	}
+	else if (run_command_l_opt(RUN_GIT_CMD, "checkout", "-q",
+				   bisect_rev_hex, "--", NULL))
+		/*
+		 * Errors in `run_command()` itself, signaled by res < 0,
+		 * and errors in the child process, signaled by res > 0
+		 * can both be treated as regular BISECT_FAILED (-1).
+		 */
+		return BISECT_FAILED;
 
 	commit = lookup_commit_reference(the_repository, bisect_rev);
 	format_commit_message(commit, "[%H] %s%n", &commit_msg, &pp);
diff --git a/builtin/clone.c b/builtin/clone.c
index ed8d44bb6ab..13fc7a4bc5d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -651,23 +651,19 @@ static void update_head(const struct ref *our, const struct ref *remote,
 
 static int git_sparse_checkout_init(const char *repo)
 {
-	struct strvec argv = STRVEC_INIT;
-	int result = 0;
-	strvec_pushl(&argv, "-C", repo, "sparse-checkout", "set", NULL);
-
 	/*
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
 	core_apply_sparse_checkout = 1;
 
-	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+	if (run_command_l_opt(RUN_GIT_CMD, "-C", repo, "sparse-checkout",
+			      "set", NULL)) {
 		error(_("failed to initialize sparse-checkout"));
-		result = 1;
+		return 1;
 	}
 
-	strvec_clear(&argv);
-	return result;
+	return 0;
 }
 
 static int checkout(int submodule_progress, int filter_submodules)
@@ -862,11 +858,11 @@ static void write_refspec_config(const char *src_ref_prefix,
 
 static void dissociate_from_references(void)
 {
-	static const char* argv[] = { "repack", "-a", "-d", NULL };
 	char *alternates = git_pathdup("objects/info/alternates");
 
 	if (!access(alternates, F_OK)) {
-		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
+		if (run_command_l_opt(RUN_GIT_CMD|RUN_COMMAND_NO_STDIN,
+				      "repack",  "-a", "-d", NULL))
 			die(_("cannot repack to clean up"));
 		if (unlink(alternates) && errno != ENOENT)
 			die_errno(_("cannot unlink temporary alternates file"));
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4b10ad1a369..ed211a87322 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -44,8 +44,8 @@ static int difftool_config(const char *var, const char *value, void *cb)
 
 static int print_tool_help(void)
 {
-	const char *argv[] = { "mergetool", "--tool-help=diff", NULL };
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	return run_command_l_opt(RUN_GIT_CMD, "mergetool", "--tool-help=diff",
+				 NULL);
 }
 
 static int parse_index_info(char *p, int *mode1, int *mode2,
@@ -361,7 +361,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
 	int flags = RUN_GIT_CMD, err = 0;
-	const char *helper_argv[] = { "difftool--helper", NULL, NULL, NULL };
+	const char *helper_command = "difftool--helper";
 	struct hashmap wt_modified, tmp_modified;
 	int indices_loaded = 0;
 
@@ -563,16 +563,14 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	}
 
 	strbuf_setlen(&ldir, ldir_len);
-	helper_argv[1] = ldir.buf;
 	strbuf_setlen(&rdir, rdir_len);
-	helper_argv[2] = rdir.buf;
-
 	if (extcmd) {
-		helper_argv[0] = extcmd;
+		helper_command = extcmd;
 		flags = 0;
 	} else
 		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
-	ret = run_command_v_opt(helper_argv, flags);
+	ret = run_command_l_opt(flags, helper_command, ldir.buf, rdir.buf,
+				NULL);
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&wtindex);
diff --git a/builtin/gc.c b/builtin/gc.c
index 243ee85d283..075b4637660 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -58,8 +58,6 @@ static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 static struct strvec reflog = STRVEC_INIT;
 static struct strvec repack = STRVEC_INIT;
 static struct strvec prune = STRVEC_INIT;
-static struct strvec prune_worktrees = STRVEC_INIT;
-static struct strvec rerere = STRVEC_INIT;
 
 static struct tempfile *pidfile;
 static struct lock_file log_lock;
@@ -167,9 +165,8 @@ static void gc_config(void)
 struct maintenance_run_opts;
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts)
 {
-	const char *argv[] = { "pack-refs", "--all", "--prune", NULL };
-
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	return run_command_l_opt(RUN_GIT_CMD, "pack-refs", "--all", "--prune",
+				 NULL);
 }
 
 static int too_many_loose_objects(void)
@@ -574,8 +571,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
 	strvec_pushl(&prune, "prune", "--expire", NULL);
-	strvec_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
-	strvec_pushl(&rerere, "rerere", "gc", NULL);
 
 	/* default expiry time, overwritten in gc_config */
 	gc_config();
@@ -688,14 +683,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (prune_worktrees_expire) {
-		strvec_push(&prune_worktrees, prune_worktrees_expire);
-		if (run_command_v_opt(prune_worktrees.v, RUN_GIT_CMD))
-			die(FAILED_RUN, prune_worktrees.v[0]);
-	}
+	if (prune_worktrees_expire &&
+	    run_command_l_opt(RUN_GIT_CMD, "worktree", "prune", "--expire",
+			      prune_worktrees_expire, NULL))
+		die(FAILED_RUN, "worktree");
 
-	if (run_command_v_opt(rerere.v, RUN_GIT_CMD))
-		die(FAILED_RUN, rerere.v[0]);
+	if (run_command_l_opt(RUN_GIT_CMD, "rerere", "gc", NULL))
+		die(FAILED_RUN, "rerere");
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);
diff --git a/builtin/merge.c b/builtin/merge.c
index 3bb49d805b4..9c04b588f68 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -347,55 +347,32 @@ static int save_state(struct object_id *stash)
 
 static void read_empty(const struct object_id *oid)
 {
-	int i = 0;
-	const char *args[7];
-
-	args[i++] = "read-tree";
-	args[i++] = "-m";
-	args[i++] = "-u";
-	args[i++] = empty_tree_oid_hex();
-	args[i++] = oid_to_hex(oid);
-	args[i] = NULL;
-
-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	if (run_command_l_opt(RUN_GIT_CMD, "read-tree", "-m", "-u",
+			      empty_tree_oid_hex(), oid_to_hex(oid), NULL))
 		die(_("read-tree failed"));
 }
 
 static void reset_hard(const struct object_id *oid)
 {
-	int i = 0;
-	const char *args[6];
-
-	args[i++] = "read-tree";
-	args[i++] = "-v";
-	args[i++] = "--reset";
-	args[i++] = "-u";
-	args[i++] = oid_to_hex(oid);
-	args[i] = NULL;
-
-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	if (run_command_l_opt(RUN_GIT_CMD, "read-tree", "-v", "--reset", "-u",
+			      oid_to_hex(oid), NULL))
 		die(_("read-tree failed"));
 }
 
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strvec args = STRVEC_INIT;
-
 	reset_hard(head);
 
 	if (is_null_oid(stash))
 		goto refresh_cache;
 
-	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
-	strvec_push(&args, oid_to_hex(stash));
-
 	/*
 	 * It is OK to ignore error here, for example when there was
 	 * nothing to restore.
 	 */
-	run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
+	run_command_l_opt(RUN_GIT_CMD, "stash", "apply", "--index", "--quiet",
+			  oid_to_hex(stash), NULL);
 
 refresh_cache:
 	if (discard_cache() < 0 || read_cache() < 0)
diff --git a/builtin/remote.c b/builtin/remote.c
index 910f7b9316a..1d86c14297b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -92,13 +92,11 @@ static int verbose;
 
 static int fetch_remote(const char *name)
 {
-	const char *argv[] = { "fetch", name, NULL, NULL };
-	if (verbose) {
-		argv[1] = "-v";
-		argv[2] = name;
-	}
 	printf_ln(_("Updating %s"), name);
-	if (run_command_v_opt(argv, RUN_GIT_CMD))
+	if (verbose && run_command_l_opt(RUN_GIT_CMD, "-v", "fetch", name,
+					 NULL))
+		return error(_("Could not fetch %s"), name);
+	else if (run_command_l_opt(RUN_GIT_CMD, "fetch", name, NULL))
 		return error(_("Could not fetch %s"), name);
 	return 0;
 }
diff --git a/compat/mingw.c b/compat/mingw.c
index 901375d5841..4f5392c5796 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -196,17 +196,15 @@ static int read_yes_no_answer(void)
 static int ask_yes_no_if_possible(const char *format, ...)
 {
 	char question[4096];
-	const char *retry_hook[] = { NULL, NULL, NULL };
+	char *retry_hook;
 	va_list args;
 
 	va_start(args, format);
 	vsnprintf(question, sizeof(question), format, args);
 	va_end(args);
 
-	if ((retry_hook[0] = mingw_getenv("GIT_ASK_YESNO"))) {
-		retry_hook[1] = question;
-		return !run_command_v_opt(retry_hook, 0);
-	}
+	if ((retry_hook = mingw_getenv("GIT_ASK_YESNO")))
+		return !run_command_l_opt(0, retry_hook, question, NULL);
 
 	if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
 		return 0;
diff --git a/ll-merge.c b/ll-merge.c
index 8955d7e1f6e..740689b7bd6 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -193,7 +193,6 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[6];
 	struct strbuf path_sq = STRBUF_INIT;
-	const char *args[] = { NULL, NULL };
 	int status, fd, i;
 	struct stat st;
 	enum ll_merge_result ret;
@@ -219,8 +218,7 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 
 	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);
 
-	args[0] = cmd.buf;
-	status = run_command_v_opt(args, RUN_USING_SHELL);
+	status = run_command_l_opt(RUN_USING_SHELL, cmd.buf, NULL);
 	fd = open(temp[1], O_RDONLY);
 	if (fd < 0)
 		goto bad;
diff --git a/run-command.c b/run-command.c
index cf4a431c839..0be5626f7f2 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1016,6 +1016,21 @@ static void run_command_set_opts(struct child_process *cmd, int opt)
 	cmd->close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
 }
 
+int run_command_l_opt(int opt, ...)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	va_list ap;
+	const char *arg;
+
+	va_start(ap, opt);
+	while ((arg = va_arg(ap, const char *)))
+		strvec_push(&cmd.args, arg);
+	va_end(ap);
+
+	run_command_set_opts(&cmd, opt);
+	return run_command(&cmd);
+}
+
 int run_command_v_opt(const char **argv, int opt)
 {
 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
diff --git a/run-command.h b/run-command.h
index 0e85e5846a5..6320d70f062 100644
--- a/run-command.h
+++ b/run-command.h
@@ -151,8 +151,8 @@ struct child_process {
 
 /**
  * The functions: child_process_init, start_command, finish_command,
- * run_command, run_command_v_opt, run_command_v_opt_cd_env, child_process_clear
- * do the following:
+ * run_command, run_command_l_opt, run_command_v_opt,
+ * run_command_v_opt_cd_env, child_process_clear do the following:
  *
  * - If a system call failed, errno is set and -1 is returned. A diagnostic
  *   is printed.
@@ -254,6 +254,15 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 				 const char *const *env, const char *tr2_class);
 
+/**
+ * The run_command_l_opt() function run_command_v_opt() takes a list
+ * of strings terminated by a NULL. Use it instead of
+ * run_command_v_opt() when possible, as it allows the compiler to
+ * check that the "argv" is NULL-delimited.
+ */
+LAST_ARG_MUST_BE_NULL
+int run_command_l_opt(int opt, ...);
+
 /**
  * Execute the given command, sending "in" to its stdin, and capturing its
  * stdout and stderr in the "out" and "err" strbufs. Any of the three may
diff --git a/sequencer.c b/sequencer.c
index debb2ecbafe..20495db9de2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3558,12 +3558,10 @@ static int error_failed_squash(struct repository *r,
 
 static int do_exec(struct repository *r, const char *command_line)
 {
-	const char *child_argv[] = { NULL, NULL };
 	int dirty, status;
 
 	fprintf(stderr, _("Executing: %s\n"), command_line);
-	child_argv[0] = command_line;
-	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
+	status = run_command_l_opt(RUN_USING_SHELL, command_line, NULL);
 
 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 12beee99ad2..7967478a40a 100644
--- a/t/helper/test-fake-ssh.c
+++ b/t/helper/test-fake-ssh.c
@@ -8,7 +8,6 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f;
 	int i;
-	const char *child_argv[] = { NULL, NULL };
 
 	/* First, print all parameters into $TRASH_DIRECTORY/ssh-output */
 	if (!trash_directory)
@@ -25,6 +24,5 @@ int cmd_main(int argc, const char **argv)
 	/* Now, evaluate the *last* parameter */
 	if (argc < 2)
 		return 0;
-	child_argv[0] = argv[argc - 1];
-	return run_command_v_opt(child_argv, RUN_USING_SHELL);
+	return run_command_l_opt(RUN_USING_SHELL, argv[argc - 1], NULL);
 }
-- 
2.38.0.1092.g8c0298861b0

