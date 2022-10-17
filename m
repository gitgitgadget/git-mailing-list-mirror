Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399E9C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJQRta (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJQRt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA99B1D5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b4so19635427wrs.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyZC3/55hN/eEoMs+Wos5M490GkkWWHzQ1TRk8zZA9k=;
        b=jDXVpV825O+Z9pOk2uo0JRQt2j2wI+dtgAn7r5CaVlluv5qUA6vbA3M0cEU77K2EGZ
         Y0ee7PoKKTo4dFtfPtMjiLaidGrsd72VHkLaOYDNziLM09198eoOwgkjcxftnKjs1t7p
         95r6Pop5ASth+7NbAOY3RJWoSKIb3QyUm4OPSya6K5Ra4GFDMGpImP4xdHdxz+XP4xmB
         N/UV1hcMQU3WwYvUgXcOBXsBqw28C++cj+ui/JnL94+W70qTGSVWSyJQAlDAByX/0+ht
         2YafqUW9u6yFNehBNrFc86VUVpBIHfJOCfrkJC0wX8eQoY9nFkD5TElbk7KmSJL0Hd6x
         46qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyZC3/55hN/eEoMs+Wos5M490GkkWWHzQ1TRk8zZA9k=;
        b=v+NSYXOzF/ohLNxJUeF4OptBXZ2V87o8kaJktXV3X+3Npfz5+EGZ8KlRXSKARTTbK3
         +oS+nmqKGlXkNmmK1pqj6hFOqCmXUjyaAULs+E1xBLZpfnlmyO6fjeHK7HcsKRscoF4r
         PmI0yEua/r94cU++2dbxnvl3xKUJnOLYytQJACAbaVK8UiWXPkYQcYjzl/yvi4VMd8u7
         u5ZVqB8sS+FchOy+VATB5Yh70E30/fOGRL6xm9G19KklEmemXNshiiPd0vguwLeXLeqC
         AMUTahSXemORE4sbrQq1xS6s0BRbXNUWOnfwpLtu33BqgQMsD3VjtFmEPrhE9g4At24j
         r6dg==
X-Gm-Message-State: ACrzQf2jCMl9P3tu71ofy9dnsfzoa/vBym3826h+P7PE7kCE50Om1RhX
        gu3egabGg/epwWckz8Wh1xXlPrG6brsC7A==
X-Google-Smtp-Source: AMsMyM5ffVcF8dc1J4lzGltW9LKi8BgUSgXZ78HsdbUVly3tKEfJ/6ub76DU0a5ppRxwlRAX/7ZQ1Q==
X-Received: by 2002:a5d:4f10:0:b0:231:1c7b:e42 with SMTP id c16-20020a5d4f10000000b002311c7b0e42mr6908623wru.568.1666028964471;
        Mon, 17 Oct 2022 10:49:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
Date:   Mon, 17 Oct 2022 19:49:11 +0200
Message-Id: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides a more idiomatic set of run-command API helpers
to match our current use-cases for run_command_v_opt(). See v1[1] for
a more general overview.

Changes since v1:

 * Fixed a migration bug in builtin/remote.c noted by Junio (just
   skipping that case).

 * Fixed an indentation issue noted by Jeff.

 * Changed run_command_sv_opt() so that we take full advantage of
   having the "struct strvec *", and move it to "cmd.args", rather
   than copying its contents.

 * Rewrote how 1/10 uses the "opts" helper, in response to Junio's
   comment.

 * Small commit message touch-ups.

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com/

CI & branch for this topic available at
https://github.com/avar/git/tree/avar/run-command-wrapper-API-simplification-2

Ævar Arnfjörð Bjarmason (10):
  run-command.c: refactor run_command_*_tr2() to internal helpers
  merge: remove always-the-same "verbose" arguments
  run-command API: add and use a run_command_l_opt()
  am: use run_command_l_opt() for show_patch()
  run-command API docs: clarify & fleshen out run_command_v_opt*() docs
  run-command API: remove RUN_COMMAND_STDOUT_TO_STDERR flag
  run-command API & diff.c: remove run_command_v_opt_cd_env()
  run-command API & users: remove run_command_v_opt_tr2()
  gc: use strvec_pushf(), avoid redundant strbuf_detach()
  run-command API: add and use a run_command_sv_opt()

 add-interactive.c        |  3 +-
 bisect.c                 | 19 ++++++-----
 builtin/add.c            |  6 ++--
 builtin/am.c             | 14 +++-----
 builtin/clone.c          | 19 ++++-------
 builtin/difftool.c       | 14 ++++----
 builtin/gc.c             | 49 ++++++++++------------------
 builtin/merge.c          | 46 ++++++--------------------
 builtin/pull.c           | 15 ++-------
 builtin/remote.c         |  5 +--
 compat/mingw.c           |  8 ++---
 diff.c                   | 26 +++++++--------
 fsmonitor-ipc.c          | 10 ++++--
 git.c                    | 15 +++++----
 ll-merge.c               |  4 +--
 merge.c                  |  3 +-
 run-command.c            | 52 +++++++++++++++++------------
 run-command.h            | 70 ++++++++++++++++++++++++++--------------
 scalar.c                 |  6 +---
 sequencer.c              | 15 ++-------
 t/helper/test-fake-ssh.c |  4 +--
 tmp-objdir.h             |  6 ++--
 22 files changed, 179 insertions(+), 230 deletions(-)

Range-diff against v1:
 1:  c1f701af6e8 !  1:  3842204371e run-command.c: refactor run_command_*_tr2() to internal helpers
    @@ run-command.c: int run_command(struct child_process *cmd)
     +	cmd->close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
     +}
     +
    - int run_command_v_opt(const char **argv, int opt)
    - {
    - 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
    -@@ run-command.c: int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
    - 	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
    - }
    - 
    -+static int run_command_v_opt_cd_env_tr2_1(struct child_process *cmd, int opt,
    -+					  const char *dir,
    -+					  const char *const *env,
    -+					  const char *tr2_class)
    ++static int run_command_v_opt_1(struct child_process *cmd, int opt)
     +{
     +	run_command_set_opts(cmd, opt);
    -+	cmd->dir = dir;
    -+	if (env)
    -+		strvec_pushv(&cmd->env, (const char **)env);
    -+	cmd->trace2_child_class = tr2_class;
     +	return run_command(cmd);
     +}
     +
    - int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
    - 				 const char *const *env, const char *tr2_class)
    + int run_command_v_opt(const char **argv, int opt)
    + {
    + 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
    +@@ run-command.c: int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
      {
      	struct child_process cmd = CHILD_PROCESS_INIT;
    -+
      	strvec_pushv(&cmd.args, argv);
     -	cmd.no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
     -	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
    @@ run-command.c: int run_command_v_opt_cd_env(const char **argv, int opt, const ch
     -	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
     -	cmd.wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
     -	cmd.close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
    --	cmd.dir = dir;
    --	if (env)
    --		strvec_pushv(&cmd.env, (const char **)env);
    --	cmd.trace2_child_class = tr2_class;
    + 	cmd.dir = dir;
    + 	if (env)
    + 		strvec_pushv(&cmd.env, (const char **)env);
    + 	cmd.trace2_child_class = tr2_class;
     -	return run_command(&cmd);
    -+	return run_command_v_opt_cd_env_tr2_1(&cmd, opt, dir, env, tr2_class);
    ++	return run_command_v_opt_1(&cmd, opt);
      }
      
      #ifndef NO_PTHREADS
 2:  543ccbb1ee1 =  2:  8b00172ef83 merge: remove always-the-same "verbose" arguments
 3:  fd81d44f221 !  3:  680a42a878e run-command API: add and use a run_command_l_opt()
    @@ builtin/clone.c: static void write_refspec_config(const char *src_ref_prefix,
      	if (!access(alternates, F_OK)) {
     -		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
     +		if (run_command_l_opt(RUN_GIT_CMD|RUN_COMMAND_NO_STDIN,
    -+				      "repack",  "-a", "-d", NULL))
    ++				      "repack", "-a", "-d", NULL))
      			die(_("cannot repack to clean up"));
      		if (unlink(alternates) && errno != ENOENT)
      			die_errno(_("cannot unlink temporary alternates file"));
    @@ builtin/merge.c: static int save_state(struct object_id *stash)
      refresh_cache:
      	if (discard_cache() < 0 || read_cache() < 0)
     
    - ## builtin/remote.c ##
    -@@ builtin/remote.c: static int verbose;
    - 
    - static int fetch_remote(const char *name)
    - {
    --	const char *argv[] = { "fetch", name, NULL, NULL };
    --	if (verbose) {
    --		argv[1] = "-v";
    --		argv[2] = name;
    --	}
    - 	printf_ln(_("Updating %s"), name);
    --	if (run_command_v_opt(argv, RUN_GIT_CMD))
    -+	if (verbose && run_command_l_opt(RUN_GIT_CMD, "-v", "fetch", name,
    -+					 NULL))
    -+		return error(_("Could not fetch %s"), name);
    -+	else if (run_command_l_opt(RUN_GIT_CMD, "fetch", name, NULL))
    - 		return error(_("Could not fetch %s"), name);
    - 	return 0;
    - }
    -
      ## compat/mingw.c ##
     @@ compat/mingw.c: static int read_yes_no_answer(void)
      static int ask_yes_no_if_possible(const char *format, ...)
    @@ run-command.c: static void run_command_set_opts(struct child_process *cmd, int o
     +	return run_command(&cmd);
     +}
     +
    - int run_command_v_opt(const char **argv, int opt)
    + static int run_command_v_opt_1(struct child_process *cmd, int opt)
      {
    - 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
    + 	run_command_set_opts(cmd, opt);
     
      ## run-command.h ##
     @@ run-command.h: struct child_process {
 4:  4cd61aaa981 !  4:  5cfd6a94ce3 am: use run_command_l_opt() for show_patch()
    @@ Commit message
         am: use run_command_l_opt() for show_patch()
     
         The "git show" invocation added in 66335298a47 (rebase: add
    -    --show-current-patch, 2018-02-11) is a one-off, and one where we're
    -    not calling oid_to_hex() twice. So we can rely on the static buffer
    -    that oid_to_hex() points to, rather than xstrdup()-ing it. As a result
    -    we can use the run_command_l_opt() function.
    +    --show-current-patch, 2018-02-11) is one where we're not calling
    +    oid_to_hex() twice. So we can rely on the static buffer that
    +    oid_to_hex() points to, rather than xstrdup()-ing it. As a result we
    +    can use the run_command_l_opt() function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 5:  b6a3c4c66f8 =  5:  4fca38bb4d6 run-command API docs: clarify & fleshen out run_command_v_opt*() docs
 6:  9d0286fbf64 =  6:  75eccc152ad run-command API: remove RUN_COMMAND_STDOUT_TO_STDERR flag
 7:  31e8536f28c !  7:  3b3d3777232 run-command API & diff.c: remove run_command_v_opt_cd_env()
    @@ diff.c: static void run_external_diff(const char *pgm,
      static int similarity_index(struct diff_filepair *p)
     
      ## run-command.c ##
    -@@ run-command.c: int run_command_l_opt(int opt, ...)
    +@@ run-command.c: static int run_command_v_opt_1(struct child_process *cmd, int opt)
      
      int run_command_v_opt(const char **argv, int opt)
      {
    @@ run-command.c: int run_command_v_opt_tr2(const char **argv, int opt, const char
     -	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
     -}
     -
    - static int run_command_v_opt_cd_env_tr2_1(struct child_process *cmd, int opt,
    - 					  const char *dir,
    - 					  const char *const *env,
    + int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
    + 				 const char *const *env, const char *tr2_class)
    + {
     
      ## run-command.h ##
     @@ run-command.h: struct child_process {
 8:  88e063f3b05 !  8:  4f1a051823f run-command API & users: remove run_command_v_opt_tr2()
    @@ run-command.c: static void run_command_set_opts(struct child_process *cmd, int o
      	cmd->close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
      }
     @@ run-command.c: int run_command_l_opt(int opt, ...)
    + 	return run_command(&cmd);
      }
      
    +-static int run_command_v_opt_1(struct child_process *cmd, int opt)
    +-{
    +-	run_command_set_opts(cmd, opt);
    +-	return run_command(cmd);
    +-}
    +-
      int run_command_v_opt(const char **argv, int opt)
     -{
     -	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, NULL);
    @@ run-command.c: int run_command_l_opt(int opt, ...)
     -	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
     -}
     -
    --static int run_command_v_opt_cd_env_tr2_1(struct child_process *cmd, int opt,
    --					  const char *dir,
    --					  const char *const *env,
    --					  const char *tr2_class)
    --{
    --	run_command_set_opts(cmd, opt);
    --	cmd->dir = dir;
    --	if (env)
    --		strvec_pushv(&cmd->env, (const char **)env);
    --	cmd->trace2_child_class = tr2_class;
    --	return run_command(cmd);
    --}
    --
     -int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
     -				 const char *const *env, const char *tr2_class)
      {
      	struct child_process cmd = CHILD_PROCESS_INIT;
    - 
    ++
      	strvec_pushv(&cmd.args, argv);
    --	return run_command_v_opt_cd_env_tr2_1(&cmd, opt, dir, env, tr2_class);
    +-	cmd.dir = dir;
    +-	if (env)
    +-		strvec_pushv(&cmd.env, (const char **)env);
    +-	cmd.trace2_child_class = tr2_class;
    +-	return run_command_v_opt_1(&cmd, opt);
     +	run_command_set_opts(&cmd, opt);
     +	return run_command(&cmd);
      }
 9:  0f5524e40ad =  9:  99c5688797a gc: use strvec_pushf(), avoid redundant strbuf_detach()
10:  874cb72c2f4 ! 10:  138af632a36 run-command API: add and use a run_command_sv_opt()
    @@ Commit message
         carry over to "return" after a "strvec_clear()" to use this new
         function instead.
     
    +    Because we pass the "struct strvec *" to the function we can also
    +    avoid copying the arguments to the "args" member of the "struct
    +    child_process", as we were doing with run_command_v_opt().
    +
    +    Instead we can use memcpy() and strvec_clear() to do the moral
    +    equivalent of a strbuf_{detach,attach}(). The strvec API doesn't have
    +    a strvec_attach(), we could add it here while at it, but let's avoid
    +    generalizing the interface for now and migrate the "struct strvec *"
    +    in the "run_command_sv_opt()" instead.
    +
         Let's leave aside the user in "builtin/bisect--helper.c"'s
         bisect_visualize(). There's an outstanding topic that's extensively
         modifying it.
    @@ merge.c: int try_merge_command(struct repository *r,
      	discard_index(r->index);
      	if (repo_read_index(r) < 0)
     
    + ## run-command.c ##
    +@@ run-command.c: int run_command_v_opt(const char **argv, int opt)
    + 	return run_command(&cmd);
    + }
    + 
    ++int run_command_sv_opt(struct strvec *args, int opt)
    ++{
    ++	struct child_process cmd = CHILD_PROCESS_INIT;
    ++
    ++	/* TODO: We could encapsulate this with a strvec_attach() */
    ++	memcpy(&cmd.args, args, sizeof(*args));
    ++	strvec_init(args);
    ++	run_command_set_opts(&cmd, opt);
    ++	return run_command(&cmd);
    ++}
    ++
    + #ifndef NO_PTHREADS
    + static pthread_t main_thread;
    + static int main_thread_set;
    +
      ## run-command.h ##
     @@ run-command.h: struct child_process {
      
    @@ run-command.h: int run_command_v_opt(const char **argv, int opt);
     +/**
     + * The run_command_sv_opt() function is a wrapper for
     + * run_command_v_opt(). It takes a "struct strvec *args" which
    -+ * similarly to run_command() (but not run_command_sv_opt()) will be
    -+ * strvec_clear()'d before returning.
    ++ * similarly will be strvec_clear()'d before returning.
     + *
     + * Use it for the common case of constructing a "struct strvec" for a
     + * one-shot run_command_v_opt() invocation.
    ++ *
    ++ * The "args" will migrated the "cmd.args" member of an underlying
    ++ * "struct child_process", in a way that avoids making an extra copy.
     + */
     +RESULT_MUST_BE_USED
    -+static inline int run_command_sv_opt(struct strvec *args, int opt)
    -+{
    -+	int ret = run_command_v_opt(args->v, opt);
    -+
    -+	strvec_clear(args);
    -+	return ret;
    -+}
    ++int run_command_sv_opt(struct strvec *args, int opt);
     +
      /**
       * Execute the given command, sending "in" to its stdin, and capturing its
-- 
2.38.0.1091.gf9d18265e59

