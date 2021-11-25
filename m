Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB62C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbhKYW7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhKYW5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:57:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC1C061758
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d24so14688027wra.0
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktV1uXEGvzIUIz+w+85KX4GkKFIlhKJkGJ/a1K0n4DM=;
        b=GUHZqluabodUEZ9BzbMgWpqwXjopc5u9dyc7MzH3EOSWl0QaUHtFUMHw7qr8Q+A8eS
         AiO6DOd4QFqkaGAde3Q0brXMch8jd/Yyg25ZFaXO0K9jfxaRRW8OeUXCdT5n4KuOnyoI
         TBuCaM1x3Aq+lfxDbEk+3x0/gXJvu52SLzmQkRc4TdKTgeGwf6ODyBkbCfvhkw6ivYuk
         CE55uXIQwzQRFsVwbjUtswMXWj/F9aOkWCoIOGzsVg6wGgk+EJFNvgjkE8tkRDQpDCqE
         smdeVVWc8LWXjAP2FriaeYUypjykMtN5fx3xEbaOemsrB/sbwyoTUM+HJlsHG/m49ims
         huHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktV1uXEGvzIUIz+w+85KX4GkKFIlhKJkGJ/a1K0n4DM=;
        b=nfmi+yvOWmEuDDWJFOj3KPOn+YUTDMs+ZYG+PwSkMqz9ByItajkupDVI41PhV6C89h
         v2j5hq7y1Ir0OXIeOk1z94+xii9D9PqYVsTb9gtVAvNLx9oI7Bituklw4/IuZvqUkY4I
         VIWxYEXNplTlh+Y3puZ7t3TjBIserOpM9qzewBGn3YjVyq9KAw64Q/i2kNlNchH+u0lk
         4uvsd6MphTooJbiJj+t0PiilAIiquxrbcYEnKAvoweXud/DtZk8gnZBwSDdYW0+APcDz
         y1ZgqHQeE386X3B1Kha/EfmNRkKbV4iZyQMJjDerdMsOqO0tZH/mjemS7/vS4YtCR7Mq
         ByWQ==
X-Gm-Message-State: AOAM530ZjjC2RprNa1lplP2NpJvQ1CNm30nPJI7sfoVFtGp1kkMEqI8F
        MlDUWfSKh6UsBXoNRyVcbMc4TSf15SAKPA==
X-Google-Smtp-Source: ABdhPJzO4fsprqrEySNhXIBhA4bw7IGUTpz9Jqd9x+UMub76RTLlyBhLywlr2I1eFlkmwmyid4z6BA==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr10552018wry.261.1637880754250;
        Thu, 25 Nov 2021 14:52:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm5001257wmq.14.2021.11.25.14.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:52:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] run-command API: remove "argv" member, always use "args"
Date:   Thu, 25 Nov 2021 23:52:22 +0100
Message-Id: <patch-v3-7.9-275535a447e-20211125T224833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
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
which is a direct result of it being complex to use. This commit
addresses the root cause of that bug.

This change is larger than I'd like, but there's no easy way to avoid
it that wouldn't involve even more verbose intermediate steps. We use
the "argv" as the source of truth over the "args", so we need to
change all parts of run-command.[ch] itself, as well as the trace2
logging at the same time.

The resulting Windows-specific code in start_command() is a bit nasty,
as we're now assigning to a strvec's "v" member, instead of to our own
"argv". There was a suggestion of some alternate approaches in reply
to an earlier version of this commit[3], but let's leave larger a
larger and needless refactoring of this code for now.

1. http://lore.kernel.org/git/YT6BnnXeAWn8BycF@coredump.intra.peff.net
2. https://lore.kernel.org/git/20211120194048.12125-1-ematsumiya@suse.de/
3. https://lore.kernel.org/git/patch-5.5-ea1011f7473-20211122T153605Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c           | 42 ++++++++++++++++++++---------------------
 run-command.h           | 20 ++++++++------------
 sub-process.c           |  2 +-
 trace2/tr2_tgt_event.c  |  2 +-
 trace2/tr2_tgt_normal.c |  2 +-
 trace2/tr2_tgt_perf.c   |  4 ++--
 6 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/run-command.c b/run-command.c
index 620a06ca2f5..99dc93e7300 100644
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
@@ -902,7 +900,7 @@ int start_command(struct child_process *cmd)
 #else
 {
 	int fhin = 0, fhout = 1, fherr = 2;
-	const char **sargv = cmd->argv;
+	const char **sargv = cmd->args.v;
 	struct strvec nargv = STRVEC_INIT;
 
 	if (cmd->no_stdin)
@@ -929,20 +927,20 @@ int start_command(struct child_process *cmd)
 		fhout = dup(cmd->out);
 
 	if (cmd->git_cmd)
-		cmd->argv = prepare_git_cmd(&nargv, cmd->argv);
+		cmd->args.v = prepare_git_cmd(&nargv, sargv);
 	else if (cmd->use_shell)
-		cmd->argv = prepare_shell_cmd(&nargv, cmd->argv);
+		cmd->args.v = prepare_shell_cmd(&nargv, sargv);
 
-	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, (char**) cmd->env,
+	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v, (char**) cmd->env,
 			cmd->dir, fhin, fhout, fherr);
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
-		error_errno("cannot spawn %s", cmd->argv[0]);
+		error_errno("cannot spawn %s", cmd->args.v[0]);
 	if (cmd->clean_on_exit && cmd->pid >= 0)
 		mark_child_for_cleanup(cmd->pid, cmd);
 
 	strvec_clear(&nargv);
-	cmd->argv = sargv;
+	cmd->args.v = sargv;
 	if (fhin != 0)
 		close(fhin);
 	if (fhout != 1)
@@ -992,7 +990,7 @@ int start_command(struct child_process *cmd)
 
 int finish_command(struct child_process *cmd)
 {
-	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
+	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 0);
 	trace2_child_exit(cmd, ret);
 	child_process_clear(cmd);
 	invalidate_lstat_cache();
@@ -1001,7 +999,7 @@ int finish_command(struct child_process *cmd)
 
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
2.34.1.838.g779e9098efb

