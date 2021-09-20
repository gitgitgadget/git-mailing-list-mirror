Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B290C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010B61159
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhITPhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhITPhs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:37:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B397C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u15so30930231wru.6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kHwEPahS84M/N/7qSnmimTKja3puIa/1/lesv4Ul6RI=;
        b=mkjtYZbufnv1tcuYCAdpBd0rzWY4e6Gpa6cgmMGgcwG/IomQck2TwmnFycNRn8r0qO
         YjJnUU5cTuwNkLP+yOHf1yaq7ICMtt3r11zwghTqHay4cvpEzlRgqkLP4+7dPIJL33Es
         vwnP1rGVfvu8XX1hRyPV2MeKGB9GP1i9G2qQPuGbJvGZiE9XlciY9+yWowsmvhlSlegn
         0FwmXJDJcwabvJXQbwgx4mQeh6aGyN1ebJQzWbmDBNM2dwH4xE0JCc/EgqPDos0JOIcF
         goFYCsNPoF7wi2zsTe3PGMk4BqWxj/HTBrDsfgmUTq9dL4+ieWIo/4kPF72cwQuXfOv7
         wedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kHwEPahS84M/N/7qSnmimTKja3puIa/1/lesv4Ul6RI=;
        b=PbEFl7urT6QQk1AC0UJAhq8y4sZjZF7TIiuYMcQcgNhUhwOQ19IXXLiItMBhO600Ix
         vBiE6B2IZk+gzbJYQ0D7ej4d7pta2yY6/KxNiTAyO5ch5I0da4Nt2ZtfGBXBK0EjPcyp
         T04BXjSeJPlcf1IOoLRw2PgSaDDLEjw//Fk6rhK7N0aj8GLlitbFJkImpTdbhiZr/l8q
         IWDyseeBBEXwcX3wGqzaRaben2mXHa7gnqj011th9ty38HaywgZ5H1IdbQguu/76sHlV
         OvgV8XamI5CjbJfhRYLWHaEbNNU1Uig+DG6rfw+okZGYoBltF9DfCd2BvIr/5UqmCfWq
         gNyg==
X-Gm-Message-State: AOAM532gLIva2kOCvCm6iRpb8TfTsfO15MZ0qE5LNdTU/t/W7BKd5W5I
        k7orcORmh7UyvfMgiWiHR5VGJHzlihE=
X-Google-Smtp-Source: ABdhPJzOJ+YS+lS4mTGeH50Spc56ZWxBZVSNqgHBZSUga6TCWF8gsSNha5CyBKPFjn5O9o9SiIL8Hg==
X-Received: by 2002:a05:6000:104e:: with SMTP id c14mr29086572wrx.130.1632152179943;
        Mon, 20 Sep 2021 08:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm18485192wrd.25.2021.09.20.08.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:36:19 -0700 (PDT)
Message-Id: <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 15:36:11 +0000
Subject: [PATCH v2 0/7] Builtin FSMonitor Part 1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V2 of Part 1 of my Builtin FSMonitor series.

Changes since V1 include:

 * Drop the Trace2 memory leak.
 * Added a new "child_ready" event to Trace2 as an alternative to the
   "child_exit" event for background processes.
 * Convert the Trace2-related NEEDSWORK items in "start_bg_command()" to use
   the new "child_ready" event.
 * Various minor code and documentation cleanups.

Jeff Hostetler (7):
  trace2: add trace2_child_ready() to report on background children
  simple-ipc: preparations for supporting binary messages.
  simple-ipc: move definition of ipc_active_state outside of ifdef
  simple-ipc/ipc-win32: add trace2 debugging
  simple-ipc/ipc-win32: add Windows ACL to named pipe
  run-command: create start_bg_command
  t/helper/simple-ipc: convert test-simple-ipc to use start_bg_command

 Documentation/technical/api-trace2.txt |  40 +++++
 compat/simple-ipc/ipc-unix-socket.c    |  14 +-
 compat/simple-ipc/ipc-win32.c          | 179 +++++++++++++++++--
 run-command.c                          | 129 ++++++++++++++
 run-command.h                          |  57 ++++++
 simple-ipc.h                           |  21 ++-
 t/helper/test-simple-ipc.c             | 233 +++++++------------------
 trace2.c                               |  31 ++++
 trace2.h                               |  25 +++
 trace2/tr2_tgt.h                       |   5 +
 trace2/tr2_tgt_event.c                 |  22 +++
 trace2/tr2_tgt_normal.c                |  14 ++
 trace2/tr2_tgt_perf.c                  |  15 ++
 13 files changed, 587 insertions(+), 198 deletions(-)


base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1040%2Fjeffhostetler%2Fbuiltin-fsmonitor-part1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1040/jeffhostetler/builtin-fsmonitor-part1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1040

Range-diff vs v1:

 1:  5f557caee00 < -:  ----------- trace2: fix memory leak of thread name
 -:  ----------- > 1:  f88e9feff26 trace2: add trace2_child_ready() to report on background children
 2:  7182419f6df ! 2:  258baa0df8c simple-ipc: preparations for supporting binary messages.
     @@ Commit message
      
          Add `command_len` argument to the Simple IPC API.
      
     -    In my original Simple IPC API, I assumed that the request
     -    would always be a null-terminated string of text characters.
     -    The command arg was just a `const char *`.
     +    In my original Simple IPC API, I assumed that the request would always
     +    be a null-terminated string of text characters.  The `command`
     +    argument was just a `const char *`.
      
     -    I found a caller that would like to pass a binary command
     -    to the daemon, so I want to ammend the Simple IPC API to
     -    take `const char *command, size_t command_len` and pass
     -    that to the daemon.  (Really, the first arg should just be
     -    a `void *` or `const unsigned byte *` to make that clearer.)
     +    I found a caller that would like to pass a binary command to the
     +    daemon, so I am amending the Simple IPC API to receive `const char
     +    *command, size_t command_len` arguments.
      
     -    Note, the response side has always been a `struct strbuf`
     -    which includes the buffer and length, so we already support
     -    returning a binary answer.  (Yes, it feels a little weird
     -    returning a binary buffer in a `strbuf`, but it works.)
     +    I considered changing the `command` argument to be a `void *`, but the
     +    IPC layer simply passes it to the pkt-line layer which takes a `const
     +    char *`, so to avoid confusion I left it as is.
     +
     +    Note, the response side has always been a `struct strbuf` which
     +    includes the buffer and length, so we already support returning a
     +    binary answer.  (Yes, it feels a little weird returning a binary
     +    buffer in a `strbuf`, but it works.)
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
 3:  7de207828ca = 3:  c94b4cbcbf2 simple-ipc: move definition of ipc_active_state outside of ifdef
 4:  30b7bb247c3 ! 4:  82b6ce0dd6a simple-ipc/ipc-win32: add trace2 debugging
     @@ compat/simple-ipc/ipc-win32.c: static enum ipc_active_state get_active_state(wch
       }
       
      @@ compat/simple-ipc/ipc-win32.c: static enum ipc_active_state connect_to_server(
     - 				if (GetLastError() == ERROR_SEM_TIMEOUT)
     + 			t_start_ms = (DWORD)(getnanotime() / 1000000);
     + 
     + 			if (!WaitNamedPipeW(wpath, timeout_ms)) {
     +-				if (GetLastError() == ERROR_SEM_TIMEOUT)
     ++				DWORD gleWait = GetLastError();
     ++
     ++				if (gleWait == ERROR_SEM_TIMEOUT)
       					return IPC_STATE__NOT_LISTENING;
       
     -+				gle = GetLastError();
      +				trace2_data_intmax("ipc-debug", NULL,
      +						   "connect/waitpipe/gle",
     -+						   (intmax_t)gle);
     ++						   (intmax_t)gleWait);
      +
       				return IPC_STATE__OTHER_ERROR;
       			}
 5:  5eadf719295 = 5:  faf6034848e simple-ipc/ipc-win32: add Windows ACL to named pipe
 6:  f97038a563d ! 6:  0822118c4b5 run-command: create start_bg_command
     @@ run-command.c: void prepare_other_repo_env(struct strvec *env_array, const char
      +	time_t time_limit;
      +
      +	/*
     -+	 * Silently disallow child cleanup -- even if requested.
     -+	 * The child process should persist in the background
     -+	 * and possibly/probably after this process exits.  That
     -+	 * is, don't kill the child during our atexit routine.
     ++	 * We do not allow clean-on-exit because the child process
     ++	 * should persist in the background and possibly/probably
     ++	 * after this process exits.  So we don't want to kill the
     ++	 * child during our atexit routine.
      +	 */
     -+	cmd->clean_on_exit = 0;
     ++	if (cmd->clean_on_exit)
     ++		BUG("start_bg_command() does not allow non-zero clean_on_exit");
     ++
     ++	if (!cmd->trace2_child_class)
     ++		cmd->trace2_child_class = "background";
      +
      +	ret = start_command(cmd);
      +	if (ret) {
     @@ run-command.c: void prepare_other_repo_env(struct strvec *env_array, const char
      +wait:
      +	pid_seen = waitpid(cmd->pid, &wait_status, WNOHANG);
      +
     -+	if (pid_seen == 0) {
     ++	if (!pid_seen) {
      +		/*
      +		 * The child is currently running.  Ask the callback
      +		 * if the child is ready to do work or whether we
      +		 * should keep waiting for it to boot up.
      +		 */
     -+		ret = (*wait_cb)(cb_data, cmd);
     ++		ret = (*wait_cb)(cmd, cb_data);
      +		if (!ret) {
      +			/*
      +			 * The child is running and "ready".
     -+			 *
     -+			 * NEEDSWORK: As we prepare to orphan (release to
     -+			 * the background) this child, it is not appropriate
     -+			 * to emit a `trace2_child_exit()` event.  Should we
     -+			 * create a new event for this case?
      +			 */
     ++			trace2_child_ready(cmd, "ready");
      +			sbgr = SBGR_READY;
      +			goto done;
      +		} else if (ret > 0) {
     ++			/*
     ++			 * The callback said to give it more time to boot up
     ++			 * (subject to our timeout limit).
     ++			 */
      +			time_t now;
      +
      +			time(&now);
     @@ run-command.c: void prepare_other_repo_env(struct strvec *env_array, const char
      +			 * Our timeout has expired.  We don't try to
      +			 * kill the child, but rather let it continue
      +			 * (hopefully) trying to startup.
     -+			 *
     -+			 * NEEDSWORK: Like the "ready" case, should we
     -+			 * log a custom child-something Trace2 event here?
      +			 */
     ++			trace2_child_ready(cmd, "timeout");
      +			sbgr = SBGR_TIMEOUT;
      +			goto done;
      +		} else {
      +			/*
     -+			 * The cb gave up on this child.
     -+			 *
     -+			 * NEEDSWORK: Like above, should we log a custom
     -+			 * Trace2 child-something event here?
     ++			 * The cb gave up on this child.  It is still running,
     ++			 * but our cb got an error trying to probe it.
      +			 */
     ++			trace2_child_ready(cmd, "error");
      +			sbgr = SBGR_CB_ERROR;
      +			goto done;
      +		}
      +	}
      +
     -+	if (pid_seen == cmd->pid) {
     ++	else if (pid_seen == cmd->pid) {
      +		int child_code = -1;
      +
      +		/*
     @@ run-command.c: void prepare_other_repo_env(struct strvec *env_array, const char
      +		 * before becoming "ready".
      +		 *
      +		 * We try to match the behavior of `wait_or_whine()`
     ++		 * WRT the handling of WIFSIGNALED() and WIFEXITED()
      +		 * and convert the child's status to a return code for
      +		 * tracing purposes and emit the `trace2_child_exit()`
      +		 * event.
     ++		 *
     ++		 * We do not want the wait_or_whine() error message
     ++		 * because we will be called by client-side library
     ++		 * routines.
      +		 */
      +		if (WIFEXITED(wait_status))
      +			child_code = WEXITSTATUS(wait_status);
     @@ run-command.c: void prepare_other_repo_env(struct strvec *env_array, const char
      +		goto done;
      +	}
      +
     -+	if (pid_seen < 0 && errno == EINTR)
     ++	else if (pid_seen < 0 && errno == EINTR)
      +		goto wait;
      +
      +	trace2_child_exit(cmd, -1);
     @@ run-command.h: int run_processes_parallel_tr2(int n, get_next_task_fn, start_fai
       void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
       
      +/**
     -+ * Possible return values for `start_bg_command()`.
     ++ * Possible return values for start_bg_command().
      + */
      +enum start_bg_result {
      +	/* child process is "ready" */
     @@ run-command.h: int run_processes_parallel_tr2(int n, get_next_task_fn, start_fai
      +};
      +
      +/**
     -+ * Callback used by `start_bg_command()` to ask whether the
     -+ * child process is ready or needs more time to become ready.
     ++ * Callback used by start_bg_command() to ask whether the
     ++ * child process is ready or needs more time to become "ready".
     ++ *
     ++ * The callback will receive the cmd and cb_data arguments given to
     ++ * start_bg_command().
      + *
      + * Returns 1 is child needs more time (subject to the requested timeout).
     -+ * Returns 0 if child is ready.
     -+ * Returns -1 on any error and cause `start_bg_command()` to also error out.
     ++ * Returns 0 if child is "ready".
     ++ * Returns -1 on any error and cause start_bg_command() to also error out.
      + */
     -+typedef int(start_bg_wait_cb)(void *cb_data,
     -+			      const struct child_process *cmd);
     ++typedef int(start_bg_wait_cb)(const struct child_process *cmd, void *cb_data);
      +
      +/**
     -+ * Start a command in the background.  Wait long enough for the child to
     -+ * become "ready".  Capture immediate errors (like failure to start) and
     -+ * any immediate exit status (such as a shutdown/signal before the child
     -+ * became "ready").
     ++ * Start a command in the background.  Wait long enough for the child
     ++ * to become "ready" (as defined by the provided callback).  Capture
     ++ * immediate errors (like failure to start) and any immediate exit
     ++ * status (such as a shutdown/signal before the child became "ready")
     ++ * and return this like start_command().
     ++ *
     ++ * We run a custom wait loop using the provided callback to wait for
     ++ * the child to start and become "ready".  This is limited by the given
     ++ * timeout value.
     ++ *
     ++ * If the child does successfully start and become "ready", we orphan
     ++ * it into the background.
      + *
     -+ * This is a combination of `start_command()` and `finish_command()`, but
     -+ * with a custom `wait_or_whine()` that allows the caller to define when
     -+ * the child is "ready".
     ++ * The caller must not call finish_command().
      + *
     -+ * The caller does not need to call `finish_command()`.
     ++ * The opaque cb_data argument will be forwarded to the callback for
     ++ * any instance data that it might require.  This may be NULL.
      + */
      +enum start_bg_result start_bg_command(struct child_process *cmd,
      +				      start_bg_wait_cb *wait_cb,
 7:  57f29feaadb ! 7:  6b7a058284b t/helper/simple-ipc: convert test-simple-ipc to use start_bg_command
     @@ Commit message
          Convert test helper to use `start_bg_command()` when spawning a server
          daemon in the background rather than blocks of platform-specific code.
      
     +    Also, while here, remove _() translation around error messages since
     +    this is a test helper and not Git code.
     +
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/helper/test-simple-ipc.c ##
     @@ t/helper/test-simple-ipc.c
       #ifndef SUPPORTS_SIMPLE_IPC
       int cmd__simple_ipc(int argc, const char **argv)
      @@ t/helper/test-simple-ipc.c: static int daemon__run_server(void)
     + 	 */
     + 	ret = ipc_server_run(cl_args.path, &opts, test_app_cb, (void*)&my_app_data);
     + 	if (ret == -2)
     +-		error(_("socket/pipe already in use: '%s'"), cl_args.path);
     ++		error("socket/pipe already in use: '%s'", cl_args.path);
     + 	else if (ret == -1)
     +-		error_errno(_("could not start server on: '%s'"), cl_args.path);
     ++		error_errno("could not start server on: '%s'", cl_args.path);
     + 
       	return ret;
       }
       
     @@ t/helper/test-simple-ipc.c: static int daemon__run_server(void)
      -		close(1);
      -		close(2);
      -		sanitize_stdfds();
     -+static int bg_wait_cb(void *cb_data, const struct child_process *cp)
     ++static int bg_wait_cb(const struct child_process *cp, void *cb_data)
      +{
      +	int s = ipc_get_active_state(cl_args.path);
       
     @@ t/helper/test-simple-ipc.c: static int daemon__run_server(void)
       /*
        * This process will run a quick probe to see if a simple-ipc server
        * is active on this path.
     +@@ t/helper/test-simple-ipc.c: static int client__stop_server(void)
     + 
     + 		time(&now);
     + 		if (now > time_limit)
     +-			return error(_("daemon has not shutdown yet"));
     ++			return error("daemon has not shutdown yet");
     + 	}
     + }
     + 

-- 
gitgitgadget
