Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E2BC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbhKVQHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbhKVQHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:07:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1380C061757
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so33627494wrr.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8Ub3v+eFEsG0azruM1RCTKzQDBgN+cxyrQ9N9BZaT4=;
        b=CIV5aK2cTVSq4svbw4blhqO6SW77jtr0hl+B9oyn8eg5LPkQgBsqDOzxWSeASR1Egr
         snZkgGkc8baFvu77X1QMBiyQLcsXksMsL7SjZaCHMrHEFKt6vnLGDNRDaYWxNoAhjLKQ
         o3TROyoY4uZ7Xd5NaAxsfxNmzW3Ql45HmqAmdFf3Odkh0u87n/PqfeteLNmNmL4lZrMi
         Uu8/46TcAuna/KhTQnGsrDQO+H1zkZyDu/3n4vClrsLK1Pq76s6d08ZcTISUrIPpbcc6
         ngaYl5HDuj+9hTBwvinHG7XeqhPR83rf/IO7QgoLzHgexH/XbV1Bt9WWaJBKom4kzBKL
         gr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8Ub3v+eFEsG0azruM1RCTKzQDBgN+cxyrQ9N9BZaT4=;
        b=KwXDM8knuJJnr1MPWoBc/6hsxXPYbcGNS4rMRjpn7HtsEFo5AijgfAMyRER7ERx9c6
         dyjp/AnHKG3MIxkk5qhfVo7Xc4WZwspEo+ss8FbXvGsP2gImm25KvmzJtxBxGZNgKbIJ
         eHyR8ZiN6emT24SxouC/hT02gi1gvqBaxpiSfQOhMEi4kIBZ9CCvvL6ShkPgXwyLIbJ/
         vYw9eIrNG/vn0gY/JxVhHQuuKN/wlFxowjwfMzuDnuaNL+CwD/3VldBk9tzBgwuysELy
         vsfGDL1lZtK6KxHAidisPTPx+dMoWT8MxT/LIRPhtqIPwlB6kVtEfJT3OZ5LZPy5aBT4
         +EVQ==
X-Gm-Message-State: AOAM531X7aTVqCQmvyTDiOv/ibiQxTm0u1p4JMP/SMqwrs8BkQ56bDZo
        kN8WIkVzS0w9T5H+6bxGitGgdz4kXEVsTw==
X-Google-Smtp-Source: ABdhPJwRRmdjOPUe0T2T4gzJ45iZq+m3eHwjZLgSHW/UGu/Mf2IQXH6p1YzRiVFjs4/rK9KQ6WROgQ==
X-Received: by 2002:adf:82f7:: with SMTP id 110mr40873800wrc.111.1637597059477;
        Mon, 22 Nov 2021 08:04:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm24005953wmc.43.2021.11.22.08.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:04:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] run-command API: remove "argv" member, always use "args"
Date:   Mon, 22 Nov 2021 17:04:07 +0100
Message-Id: <patch-5.5-ea1011f7473-20211122T153605Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gf3f912c366d
In-Reply-To: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net> <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "argv" member from the run-command API, ever since "args"
was added in c460c0ecdca (run-command: store an optional argv_array,
2014-05-15) being able to provide either "argv" or "args" has led to
some confusion and bugs.

If we hadn't gone in that direction and only had an "argv" our
problems wouldn't have been solved either, as noted in [1] (and in the
documentation amended here) it comes with inherent memory management
issues: The caller would have to hang on to the "argv" until the
run-command API was finished. If the "argv" was an argument to main()
this wasn't an issue, but if it it was manually constructed using the
API might be painful.

We also have a recent report[2] of a user of the API segfaulting,
which is a direct result of it being complex to use. A test being
added here would segfault before this change.

This change is larger than I'd like, but there's no easy way to avoid
it that wouldn't involve even more verbose intermediate steps. We use
the "argv" as the source of truth over the "args", so we need to
change all parts of run-command.[ch] itself, as well as the trace2
logging at the same time.

We can also similarly follow-up and remove "env" member in favor of
"env_array", which is a much smaller change than this series removing
"argv", but let's stop at "argv" for now. We can always do "env" as a
follow-up.

I have not carefully tested the Windows-specific code in
start_command() as I don't have a Windows system, but it seems to pass
CI + runs the tests there.

1. http://lore.kernel.org/git/YT6BnnXeAWn8BycF@coredump.intra.peff.net
2. https://lore.kernel.org/git/20211120194048.12125-1-ematsumiya@suse.de/

Reported-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c          |  2 --
 run-command.c               | 51 ++++++++++++++++++++-----------------
 run-command.h               | 20 ++++++---------
 sub-process.c               |  2 +-
 t/helper/test-run-command.c | 10 +++++---
 t/t7006-pager.sh            |  4 +++
 trace2/tr2_tgt_event.c      |  2 +-
 trace2/tr2_tgt_normal.c     |  2 +-
 trace2/tr2_tgt_perf.c       |  4 +--
 9 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1a..7264a5b5de0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -355,7 +355,6 @@ static int add_worktree(const char *path, const char *refname,
 		goto done;
 
 	if (opts->checkout) {
-		cp.argv = NULL;
 		strvec_clear(&cp.args);
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
@@ -390,7 +389,6 @@ static int add_worktree(const char *path, const char *refname,
 			cp.stdout_to_stderr = 1;
 			cp.dir = path;
 			cp.env = env;
-			cp.argv = NULL;
 			cp.trace2_hook_name = "post-checkout";
 			strvec_pushl(&cp.args, absolute_path(hook),
 				     oid_to_hex(null_oid()),
diff --git a/run-command.c b/run-command.c
index 620a06ca2f5..6158807ed13 100644
--- a/run-command.c
+++ b/run-command.c
@@ -380,7 +380,7 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 	switch (cerr->err) {
 	case CHILD_ERR_CHDIR:
 		error_errno("exec '%s': cd to '%s' failed",
-			    cmd->argv[0], cmd->dir);
+			    cmd->args.v[0], cmd->dir);
 		break;
 	case CHILD_ERR_DUP2:
 		error_errno("dup2() in child failed");
@@ -392,12 +392,12 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 		error_errno("sigprocmask failed restoring signals");
 		break;
 	case CHILD_ERR_ENOENT:
-		error_errno("cannot run %s", cmd->argv[0]);
+		error_errno("cannot run %s", cmd->args.v[0]);
 		break;
 	case CHILD_ERR_SILENT:
 		break;
 	case CHILD_ERR_ERRNO:
-		error_errno("cannot exec '%s'", cmd->argv[0]);
+		error_errno("cannot exec '%s'", cmd->args.v[0]);
 		break;
 	}
 	set_error_routine(old_errfn);
@@ -405,7 +405,7 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 
 static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 {
-	if (!cmd->argv[0])
+	if (!cmd->args.v[0])
 		BUG("command is empty");
 
 	/*
@@ -415,11 +415,11 @@ static int prepare_cmd(struct strvec *out, const struct child_process *cmd)
 	strvec_push(out, SHELL_PATH);
 
 	if (cmd->git_cmd) {
-		prepare_git_cmd(out, cmd->argv);
+		prepare_git_cmd(out, cmd->args.v);
 	} else if (cmd->use_shell) {
-		prepare_shell_cmd(out, cmd->argv);
+		prepare_shell_cmd(out, cmd->args.v);
 	} else {
-		strvec_pushv(out, cmd->argv);
+		strvec_pushv(out, cmd->args.v);
 	}
 
 	/*
@@ -663,7 +663,7 @@ static void trace_run_command(const struct child_process *cp)
 		trace_add_env(&buf, cp->env);
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
-	sq_quote_argv_pretty(&buf, cp->argv);
+	sq_quote_argv_pretty(&buf, cp->args.v);
 
 	trace_printf("%s", buf.buf);
 	strbuf_release(&buf);
@@ -676,8 +676,6 @@ int start_command(struct child_process *cmd)
 	int failed_errno;
 	char *str;
 
-	if (!cmd->argv)
-		cmd->argv = cmd->args.v;
 	if (!cmd->env)
 		cmd->env = cmd->env_array.v;
 
@@ -729,7 +727,7 @@ int start_command(struct child_process *cmd)
 			str = "standard error";
 fail_pipe:
 			error("cannot create %s pipe for %s: %s",
-				str, cmd->argv[0], strerror(failed_errno));
+				str, cmd->args.v[0], strerror(failed_errno));
 			child_process_clear(cmd);
 			errno = failed_errno;
 			return -1;
@@ -758,7 +756,7 @@ int start_command(struct child_process *cmd)
 		failed_errno = errno;
 		cmd->pid = -1;
 		if (!cmd->silent_exec_failure)
-			error_errno("cannot run %s", cmd->argv[0]);
+			error_errno("cannot run %s", cmd->args.v[0]);
 		goto end_of_spawn;
 	}
 
@@ -868,7 +866,7 @@ int start_command(struct child_process *cmd)
 	}
 	atfork_parent(&as);
 	if (cmd->pid < 0)
-		error_errno("cannot fork() for %s", cmd->argv[0]);
+		error_errno("cannot fork() for %s", cmd->args.v[0]);
 	else if (cmd->clean_on_exit)
 		mark_child_for_cleanup(cmd->pid, cmd);
 
@@ -885,7 +883,7 @@ int start_command(struct child_process *cmd)
 		 * At this point we know that fork() succeeded, but exec()
 		 * failed. Errors have been reported to our stderr.
 		 */
-		wait_or_whine(cmd->pid, cmd->argv[0], 0);
+		wait_or_whine(cmd->pid, cmd->args.v[0], 0);
 		child_err_spew(cmd, &cerr);
 		failed_errno = errno;
 		cmd->pid = -1;
@@ -902,8 +900,9 @@ int start_command(struct child_process *cmd)
 #else
 {
 	int fhin = 0, fhout = 1, fherr = 2;
-	const char **sargv = cmd->argv;
+	const char **sargv = strvec_detach(&cmd->args);
 	struct strvec nargv = STRVEC_INIT;
+	const char **temp_argv = NULL;
 
 	if (cmd->no_stdin)
 		fhin = open("/dev/null", O_RDWR);
@@ -929,20 +928,26 @@ int start_command(struct child_process *cmd)
 		fhout = dup(cmd->out);
 
 	if (cmd->git_cmd)
-		cmd->argv = prepare_git_cmd(&nargv, cmd->argv);
+		temp_argv = prepare_git_cmd(&nargv, sargv);
 	else if (cmd->use_shell)
-		cmd->argv = prepare_shell_cmd(&nargv, cmd->argv);
+		temp_argv = prepare_shell_cmd(&nargv, sargv);
+	else
+		temp_argv = sargv;
+	if (!temp_argv)
+		BUG("should have some cmd->args to set");
+	strvec_pushv(&cmd->args, temp_argv);
+	strvec_clear(&nargv);
 
-	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, (char**) cmd->env,
+	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v, (char**) cmd->env,
 			cmd->dir, fhin, fhout, fherr);
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
-		error_errno("cannot spawn %s", cmd->argv[0]);
+		error_errno("cannot spawn %s", cmd->args.v[0]);
 	if (cmd->clean_on_exit && cmd->pid >= 0)
 		mark_child_for_cleanup(cmd->pid, cmd);
 
-	strvec_clear(&nargv);
-	cmd->argv = sargv;
+	strvec_pushv(&cmd->args, sargv);;
+	free(sargv);
 	if (fhin != 0)
 		close(fhin);
 	if (fhout != 1)
@@ -992,7 +997,7 @@ int start_command(struct child_process *cmd)
 
 int finish_command(struct child_process *cmd)
 {
-	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
+	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 0);
 	trace2_child_exit(cmd, ret);
 	child_process_clear(cmd);
 	invalidate_lstat_cache();
@@ -1001,7 +1006,7 @@ int finish_command(struct child_process *cmd)
 
 int finish_command_in_signal(struct child_process *cmd)
 {
-	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 1);
+	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
 	trace2_child_exit(cmd, ret);
 	return ret;
 }
diff --git a/run-command.h b/run-command.h
index 49878262584..c0d1210cc63 100644
--- a/run-command.h
+++ b/run-command.h
@@ -44,21 +44,17 @@
 struct child_process {
 
 	/**
-	 * The .argv member is set up as an array of string pointers (NULL
-	 * terminated), of which .argv[0] is the program name to run (usually
-	 * without a path). If the command to run is a git command, set argv[0] to
-	 * the command name without the 'git-' prefix and set .git_cmd = 1.
+	 * The .args is a `struct strvec', use that API to manipulate
+	 * it, e.g. strvec_pushv() to add an existing "const char **"
+	 * vector.
 	 *
-	 * Note that the ownership of the memory pointed to by .argv stays with the
-	 * caller, but it should survive until `finish_command` completes. If the
-	 * .argv member is NULL, `start_command` will point it at the .args
-	 * `strvec` (so you may use one or the other, but you must use exactly
-	 * one). The memory in .args will be cleaned up automatically during
-	 * `finish_command` (or during `start_command` when it is unsuccessful).
+	 * If the command to run is a git command, set the first
+	 * element in the strvec to the command name without the
+	 * 'git-' prefix and set .git_cmd = 1.
 	 *
+	 * The memory in .args will be cleaned up automatically during
+	 * `finish_command` (or during `start_command` when it is unsuccessful).
 	 */
-	const char **argv;
-
 	struct strvec args;
 	struct strvec env_array;
 	pid_t pid;
diff --git a/sub-process.c b/sub-process.c
index dfa790d3ff9..cae56ae6b80 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -187,7 +187,7 @@ static int handshake_capabilities(struct child_process *process,
 				*supported_capabilities |= capabilities[i].flag;
 		} else {
 			die("subprocess '%s' requested unsupported capability '%s'",
-			    process->argv[0], p);
+			    process->args.v[0], p);
 		}
 	}
 
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3c4fb862234..b5519f92a19 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -31,7 +31,7 @@ static int parallel_next(struct child_process *cp,
 	if (number_callbacks >= 4)
 		return 0;
 
-	strvec_pushv(&cp->args, d->argv);
+	strvec_pushv(&cp->args, d->args.v);
 	strbuf_addstr(err, "preloaded output of a child\n");
 	number_callbacks++;
 	return 1;
@@ -274,7 +274,7 @@ static int quote_stress_test(int argc, const char **argv)
 		if (i < skip)
 			continue;
 
-		cp.argv = args.v;
+		strvec_pushv(&cp.args, args.v);
 		strbuf_reset(&out);
 		if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) < 0)
 			return error("Failed to spawn child process");
@@ -396,7 +396,8 @@ int cmd__run_command(int argc, const char **argv)
 	}
 	if (argc < 3)
 		return 1;
-	proc.argv = (const char **)argv + 2;
+	strvec_clear(&proc.args);
+	strvec_pushv(&proc.args, (const char **)argv + 2);
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
 		if (start_command(&proc) < 0 && errno == ENOENT)
@@ -408,7 +409,8 @@ int cmd__run_command(int argc, const char **argv)
 		exit(run_command(&proc));
 
 	jobs = atoi(argv[2]);
-	proc.argv = (const char **)argv + 3;
+	strvec_clear(&proc.args);
+	strvec_pushv(&proc.args, (const char **)argv + 3);
 
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435e..d75a874b5be 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -16,6 +16,10 @@ test_expect_success 'setup' '
 	test_commit initial
 '
 
+test_expect_success 'non-existent pager does not segfault' '
+	git -c pager.show=INVALID show
+'
+
 test_expect_success TTY 'some commands use a pager' '
 	rm -f paginated.out &&
 	test_terminal git log &&
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 3a0014417cc..bd17ecdc321 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -354,7 +354,7 @@ static void fn_child_start_fl(const char *file, int line,
 	jw_object_inline_begin_array(&jw, "argv");
 	if (cmd->git_cmd)
 		jw_array_string(&jw, "git");
-	jw_array_argv(&jw, cmd->argv);
+	jw_array_argv(&jw, cmd->args.v);
 	jw_end(&jw);
 	jw_end(&jw);
 
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 58d9e430f05..6e429a3fb9e 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -232,7 +232,7 @@ static void fn_child_start_fl(const char *file, int line,
 	strbuf_addch(&buf_payload, ' ');
 	if (cmd->git_cmd)
 		strbuf_addstr(&buf_payload, "git ");
-	sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
+	sq_append_quote_argv_pretty(&buf_payload, cmd->args.v);
 
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index e4acca13d64..2ff9cf70835 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -335,10 +335,10 @@ static void fn_child_start_fl(const char *file, int line,
 	strbuf_addstr(&buf_payload, " argv:[");
 	if (cmd->git_cmd) {
 		strbuf_addstr(&buf_payload, "git");
-		if (cmd->argv[0])
+		if (cmd->args.nr)
 			strbuf_addch(&buf_payload, ' ');
 	}
-	sq_append_quote_argv_pretty(&buf_payload, cmd->argv);
+	sq_append_quote_argv_pretty(&buf_payload, cmd->args.v);
 	strbuf_addch(&buf_payload, ']');
 
 	perf_io_write_fl(file, line, event_name, NULL, &us_elapsed_absolute,
-- 
2.34.0.822.gb876f875f1b

