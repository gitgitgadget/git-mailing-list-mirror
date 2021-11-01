Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A773C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0445760F24
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhKAS7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhKAS7A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:59:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12858C061764
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso143428wmc.2
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4awI6kyCmU7lNtR32Oby6c2lnSKdWsAnLRc1QYYpYo=;
        b=CaOwvcUXtK2M5AYKWrnACh7it1kuRe7IfHRkbIwOSKpnF+UNf1gPNrLC25JXtTR+sJ
         7+WM0C6nmM8Ocen8rKwhSoaL9wZ9E4ZF9iTK2c0NVfj30Dki+ukFb5tAplv6b9LChttp
         tAN+73ULDo6UQYx+RK97G86cciHTuqFjgDNrSQBiB9jLOMcQi9WtQjHRjfnKVc9daB6a
         LCwd8Byhyvd3NoxU848BOuwte+C0snIFmknGm9lVTMPFtyZKpnqEKF1hZ00LhP/7QePH
         MVgO/WmYCOBaYsI7iAOitwDLHDhFMd0UWupe+K5xZyoVkhByMEEy5Fy5Mco9dbGZ4cvB
         xbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4awI6kyCmU7lNtR32Oby6c2lnSKdWsAnLRc1QYYpYo=;
        b=gW2yK8OAYzLpTuPHp8Hi+u0gyYc8feYCbbM52k4cNXT1Xnq0o+DJbK/jX7BR73uN3o
         wzJKEDYVPl4VJ9J2hUbXR4XC/l0AHT0/R6s1Q6d5i3DF4c4jiTR0A2eVw5tnN9R30YIg
         ZDaQnwvOdm8bLYdEyI96z/z3bTQHGfHK/TwtR2g7yLuNYNkpSqsDup9ML0JBcksXMvQv
         ebbX83mDQ4eFkGhyAwuyMKC7DuyHeHOMs/o8kYm1Xc9aA/3Ny23OyY1l9AmdN20lIjxB
         oXnQRWzs6g59atJZ+RwLfEfcqgZM7QV6H0496NBIgGIGaBICrVIkQOoRcIZ9tp2hg3mJ
         1wNA==
X-Gm-Message-State: AOAM531Wto41Pt3Yrvd3+YAKuwXOfEXejVpLbNMxRTDZraHpTwOYL4+z
        85wklRCe80KXOcPxe7ZvJvEQ/CNqedMqXZGK
X-Google-Smtp-Source: ABdhPJwNlueFAW3FUtm21LXbEviZao42BlOSIQBDY2nJ7qOsn7Oxx0+tUoT6+m3jHlcBRrZdkY7Gpg==
X-Received: by 2002:a7b:ce0f:: with SMTP id m15mr794433wmc.149.1635792984945;
        Mon, 01 Nov 2021 11:56:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/17] hook.[ch]: new library to run hooks + simple hook conversion
Date:   Mon,  1 Nov 2021 19:56:05 +0100
Message-Id: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part 2 of the greater configurable hook saga, starting by converting
some existing simple hooks to the new hook.[ch] library and "git hook
run" utility. See [1] for the last iteration.

This re-roll should address Junio's comments on v3, i.e. there's now a
run_hooks_l() API similar to run_hook_le(). I also simplified the
callers of run_hooks(), which is now called run_hooks_opt().

Since no callers needed anything but a one-shot call the memory public
memory management API is gone, that'll eventually be needed for a "git
hook list" with configurable hooks, but let's introduce those API bits
then, not now.

This grew to 17 patches from 13 due to splitting up some commints for
ease of review, the overall diffstat got smaller. I picked a function
with the same width as the old function, so many of the diffs are
now simply a s/run_hook_le(NULL, /run_hooks_l(/.

1. https://lore.kernel.org/git/cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com/

Emily Shaffer (14):
  hook: add 'run' subcommand
  gc: use hook library for pre-auto-gc hook
  am: convert {pre,post}-applypatch to use hook.h
  rebase: convert pre-rebase to use hook.h
  am: convert applypatch-msg to use hook.h
  merge: convert post-merge to use hook.h
  hooks: convert non-worktree 'post-checkout' hook to hook library
  hooks: convert worktree 'post-checkout' hook to hook library
  send-email: use 'git hook run' for 'sendemail-validate'
  git-p4: use 'git hook' to run hooks
  commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
  read-cache: convert post-index-change to use hook.h
  receive-pack: convert push-to-checkout hook to hook.h
  run-command: remove old run_hook_{le,ve}() hook API

Ævar Arnfjörð Bjarmason (3):
  hook API: add a run_hooks() wrapper
  hook API: add a run_hooks_l() wrapper
  git hook run: add an --ignore-missing flag

 .gitignore                 |   1 +
 Documentation/git-hook.txt |  45 +++++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/am.c               |   6 +-
 builtin/checkout.c         |   3 +-
 builtin/clone.c            |   3 +-
 builtin/gc.c               |   3 +-
 builtin/hook.c             |  84 +++++++++++++++++++++++
 builtin/merge.c            |   2 +-
 builtin/rebase.c           |   3 +-
 builtin/receive-pack.c     |   7 +-
 builtin/worktree.c         |  27 +++-----
 command-list.txt           |   1 +
 commit.c                   |  15 +++--
 git-p4.py                  |  70 ++-----------------
 git-send-email.perl        |  22 +++---
 git.c                      |   1 +
 hook.c                     | 131 ++++++++++++++++++++++++++++++++++++
 hook.h                     |  57 ++++++++++++++++
 read-cache.c               |   3 +-
 reset.c                    |   3 +-
 run-command.c              |  32 ---------
 run-command.h              |  17 -----
 t/t1800-hook.sh            | 134 +++++++++++++++++++++++++++++++++++++
 t/t9001-send-email.sh      |   4 +-
 27 files changed, 522 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

Range-diff against v3:
 1:  02fd699e699 !  1:  d97d6734961 hook: add 'run' subcommand
    @@ Commit message
         builtin/{commit-graph,multi-pack-index}.c.
     
         Some of the implementation here, such as a function being named
    -    run_hooks() when it's tasked with running one hook, to using the
    +    run_hooks_opt() when it's tasked with running one hook, to using the
         run_processes_parallel_tr2() API to run with jobs=1 is somewhere
         between a bit odd and and an overkill for the current features of this
         "hook run" command and the hook.[ch] API.
    @@ builtin/hook.c (new)
     +	int i;
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	const char *hook_name;
    -+	const char *hook_path;
     +	struct option run_options[] = {
     +		OPT_END(),
     +	};
    @@ builtin/hook.c (new)
     +	git_config(git_default_config, NULL);
     +
     +	hook_name = argv[0];
    -+	hook_path = find_hook(hook_name);
    -+	if (!hook_path) {
    -+		error("cannot find a hook named %s", hook_name);
    -+		return 1;
    -+	}
    -+
    -+	ret = run_hooks(hook_name, hook_path, &opt);
    -+	run_hooks_opt_clear(&opt);
    ++	opt.error_if_missing = 1;
    ++	ret = run_hooks_opt(hook_name, &opt);
    ++	if (ret < 0) /* error() return */
    ++		ret = 1;
     +	return ret;
     +usage:
     +	usage_with_options(builtin_hook_run_usage, run_options);
    @@ hook.c: int hook_exists(const char *name)
      	return !!find_hook(name);
      }
     +
    -+void run_hooks_opt_clear(struct run_hooks_opt *o)
    -+{
    -+	strvec_clear(&o->env);
    -+	strvec_clear(&o->args);
    -+}
    -+
     +static int pick_next_hook(struct child_process *cp,
     +			  struct strbuf *out,
     +			  void *pp_cb,
    @@ hook.c: int hook_exists(const char *name)
     +	return 0;
     +}
     +
    -+int run_hooks(const char *hook_name, const char *hook_path,
    -+	      struct run_hooks_opt *options)
    ++static void run_hooks_opt_clear(struct run_hooks_opt *options)
    ++{
    ++	strvec_clear(&options->env);
    ++	strvec_clear(&options->args);
    ++}
    ++
    ++int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
     +{
     +	struct hook_cb_data cb_data = {
     +		.rc = 0,
     +		.hook_name = hook_name,
    -+		.hook_path = hook_path,
     +		.options = options,
     +	};
    ++	const char *const hook_path = find_hook(hook_name);
     +	int jobs = 1;
    ++	int ret = 0;
     +
     +	if (!options)
     +		BUG("a struct run_hooks_opt must be provided to run_hooks");
     +
    ++	if (!hook_path && !options->error_if_missing)
    ++		goto cleanup;
    ++
    ++	if (!hook_path) {
    ++		ret = error("cannot find a hook named %s", hook_name);
    ++		goto cleanup;
    ++	}
    ++
    ++	cb_data.hook_path = hook_path;
     +	run_processes_parallel_tr2(jobs,
     +				   pick_next_hook,
     +				   notify_start_failure,
    @@ hook.c: int hook_exists(const char *name)
     +				   &cb_data,
     +				   "hook",
     +				   hook_name);
    -+
    -+	return cb_data.rc;
    ++	ret = cb_data.rc;
    ++cleanup:
    ++	run_hooks_opt_clear(options);
    ++	return ret;
     +}
     
      ## hook.h ##
    @@ hook.h
     +
     +	/* Args to be passed to each hook */
     +	struct strvec args;
    ++
    ++	/* Emit an error if the hook is missing */
    ++	unsigned int error_if_missing:1;
     +};
     +
     +#define RUN_HOOKS_OPT_INIT { \
    @@ hook.h: const char *find_hook(const char *name);
      int hook_exists(const char *hookname);
      
     +/**
    -+ * Clear data from an initialized "struct run_hooks_opt".
    -+ */
    -+void run_hooks_opt_clear(struct run_hooks_opt *o);
    -+
    -+/**
    -+ * Takes an already resolved hook found via find_hook() and runs
    -+ * it. Does not call run_hooks_opt_clear() for you.
    ++ * Takes a `hook_name`, resolves it to a path with find_hook(), and
    ++ * runs the hook for you with the options specified in "struct
    ++ * run_hooks opt". Will free memory associated with the "struct run_hooks_opt".
    ++ *
    ++ * Returns the status code of the run hook, or a negative value on
    ++ * error().
     + */
    -+int run_hooks(const char *hookname, const char *hook_path,
    -+	      struct run_hooks_opt *options);
    ++int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
      #endif
     
      ## t/t1800-hook.sh (new) ##
 -:  ----------- >  2:  ca6464f7d5e hook API: add a run_hooks() wrapper
 2:  42cc4d2c3c6 !  3:  173860afca1 gc: use hook library for pre-auto-gc hook
    @@ Commit message
         gc: use hook library for pre-auto-gc hook
     
         Move the pre-auto-gc hook away from run-command.h to and over to the
    -    new hook.h library.
    -
    -    To do this introduce a simple run_hooks_oneshot() wrapper, we'll be
    -    using it extensively for these simple cases of wanting to run a single
    -    hook under a given name, and having it free the memory we allocate for
    -    us.
    +    new hook.h library. This uses the new run_hooks() wrapper.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/gc.c: static int need_to_gc(void)
      		return 0;
      
     -	if (run_hook_le(NULL, "pre-auto-gc", NULL))
    -+	if (run_hooks_oneshot("pre-auto-gc", NULL))
    ++	if (run_hooks("pre-auto-gc"))
      		return 0;
      	return 1;
      }
    -
    - ## hook.c ##
    -@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
    - 
    - 	return cb_data.rc;
    - }
    -+
    -+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
    -+{
    -+	const char *hook_path;
    -+	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
    -+	int ret = 0;
    -+
    -+	if (!options)
    -+		options = &hook_opt_scratch;
    -+
    -+	hook_path = find_hook(hook_name);
    -+	if (!hook_path)
    -+		goto cleanup;
    -+
    -+	ret = run_hooks(hook_name, hook_path, options);
    -+cleanup:
    -+	run_hooks_opt_clear(options);
    -+
    -+	return ret;
    -+}
    -
    - ## hook.h ##
    -@@ hook.h: void run_hooks_opt_clear(struct run_hooks_opt *o);
    - /**
    -  * Takes an already resolved hook found via find_hook() and runs
    -  * it. Does not call run_hooks_opt_clear() for you.
    -+ *
    -+ * See run_hooks_oneshot() for the simpler one-shot API.
    -  */
    - int run_hooks(const char *hookname, const char *hook_path,
    - 	      struct run_hooks_opt *options);
    -+
    -+/**
    -+ * Calls find_hook() on your "hook_name" and runs the hooks (if any)
    -+ * with run_hooks().
    -+ *
    -+ * If "options" is provided calls run_hooks_opt_clear() on it for
    -+ * you. If "options" is NULL the default options from
    -+ * RUN_HOOKS_OPT_INIT will be used.
    -+ */
    -+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
    -+
    - #endif
 4:  b26cef24f39 !  4:  80a2171ddaf am: convert applypatch to use hook.h
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    am: convert applypatch to use hook.h
    +    am: convert {pre,post}-applypatch to use hook.h
     
    -    Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
    -    hook.h library instead of the run-command.h library.
    +    Teach pre-applypatch and post-applypatch to use the hook.h library
    +    instead of the run-command.h library.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/am.c ##
    -@@ builtin/am.c: static void am_destroy(const struct am_state *state)
    - static int run_applypatch_msg_hook(struct am_state *state)
    - {
    - 	int ret;
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    - 
    - 	assert(state->msg);
    --	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
    -+	strvec_push(&opt.args, am_path(state, "final-commit"));
    -+	ret = run_hooks_oneshot("applypatch-msg", &opt);
    - 
    - 	if (!ret) {
    - 		FREE_AND_NULL(state->msg);
     @@ builtin/am.c: static void do_commit(const struct am_state *state)
      	const char *reflog_msg, *author, *committer = NULL;
      	struct strbuf sb = STRBUF_INIT;
      
     -	if (run_hook_le(NULL, "pre-applypatch", NULL))
    -+	if (run_hooks_oneshot("pre-applypatch", NULL))
    ++	if (run_hooks("pre-applypatch"))
      		exit(1);
      
      	if (write_cache_as_tree(&tree, 0, NULL))
    @@ builtin/am.c: static void do_commit(const struct am_state *state)
      	}
      
     -	run_hook_le(NULL, "post-applypatch", NULL);
    -+	run_hooks_oneshot("post-applypatch", NULL);
    ++	run_hooks("post-applypatch");
      
      	strbuf_release(&sb);
      }
 -:  ----------- >  5:  74f459db287 hook API: add a run_hooks_l() wrapper
 3:  cbbfd77a4f6 !  6:  1fd70c0e88a rebase: convert pre-rebase to use hook.h
    @@ Commit message
         Move the pre-rebase hook away from run-command.h to and over to the
         new hook.h library.
     
    +    Since this hook needs arguments introduce a run_hooksl() wrapper, like
    +    run_hooks(), but it takes varargs.
    +
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/rebase.c
      #define DEFAULT_REFLOG_ACTION "rebase"
      
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 	int reschedule_failed_exec = -1;
    - 	int allow_preemptive_ff = 1;
    - 	int preserve_merges_selected = 0;
    -+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
    - 	struct option builtin_rebase_options[] = {
    - 		OPT_STRING(0, "onto", &options.onto_name,
    - 			   N_("revision"),
    -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 	}
      
      	/* If a hook exists, give it a chance to interrupt*/
    -+	strvec_push(&hook_opt.args, options.upstream_arg);
    -+	if (argc)
    -+		strvec_push(&hook_opt.args, argv[0]);
      	if (!ok_to_skip_pre_rebase &&
     -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
    --			argc ? argv[0] : NULL, NULL))
    -+	    run_hooks_oneshot("pre-rebase", &hook_opt))
    ++	    run_hooks_l("pre-rebase", options.upstream_arg,
    + 			argc ? argv[0] : NULL, NULL))
      		die(_("The pre-rebase hook refused to rebase."));
      
    - 	if (options.flags & REBASE_DIFFSTAT) {
 -:  ----------- >  7:  ccba3ddf52e am: convert applypatch-msg to use hook.h
 6:  7a9fd8627cd !  8:  2c23e8645ec merge: convert post-merge to use hook.h
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/merge.c ##
    -@@ builtin/merge.c: static void finish(struct commit *head_commit,
    - 		   const struct object_id *new_head, const char *msg)
    - {
    - 	struct strbuf reflog_message = STRBUF_INIT;
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    - 	const struct object_id *head = &head_commit->object.oid;
    - 
    - 	if (!msg)
     @@ builtin/merge.c: static void finish(struct commit *head_commit,
      	}
      
      	/* Run a post-merge hook */
     -	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
    -+	strvec_push(&opt.args, squash ? "1" : "0");
    -+	run_hooks_oneshot("post-merge", &opt);
    ++	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
      
      	apply_autostash(git_path_merge_autostash(the_repository));
      	strbuf_release(&reflog_message);
 -:  ----------- >  9:  cb95c79093b hooks: convert non-worktree 'post-checkout' hook to hook library
 5:  2a747a65829 ! 10:  f330600fec8 hooks: convert 'post-checkout' hook to hook library
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    hooks: convert 'post-checkout' hook to hook library
    +    hooks: convert worktree 'post-checkout' hook to hook library
     
         Move the running of the 'post-checkout' hook away from run-command.h
    -    to the new hook.h library. For "worktree" this requires a change to it
    -    to run the hooks from a given directory.
    +    to the new hook.h library in builtin/worktree.c. For this special case
    +    we need a change to the hook API to teach it to run the hook from a
    +    given directory.
     
    -    We could strictly speaking skip the "absolute_path" flag and just
    -    check if "dir" is specified, but let's split them up for clarity, as
    -    well as for any future user who'd like to set "dir" but not implicitly
    -    change the argument to an absolute path.
    +    We cannot skip the "absolute_path" flag and just check if "dir" is
    +    specified as we'd then fail to find our hook in the new dir we'd
    +    chdir() to. We currently don't have a use-case for running a hook not
    +    in our "base" repository at a given absolute path, so let's have "dir"
    +    imply absolute_path(find_hook(hook_name)).
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/checkout.c ##
    -@@
    - #include "config.h"
    - #include "diff.h"
    - #include "dir.h"
    -+#include "hook.h"
    - #include "ll-merge.h"
    - #include "lockfile.h"
    - #include "merge-recursive.h"
    -@@ builtin/checkout.c: struct branch_info {
    - static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
    - 			      int changed)
    - {
    --	return run_hook_le(NULL, "post-checkout",
    --			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
    --			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
    --			   changed ? "1" : "0", NULL);
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+
    - 	/* "new_commit" can be NULL when checking out from the index before
    - 	   a commit exists. */
    --
    -+	strvec_pushl(&opt.args,
    -+		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
    -+		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
    -+		     changed ? "1" : "0",
    -+		     NULL);
    -+	return run_hooks_oneshot("post-checkout", &opt);
    - }
    - 
    - static int update_some(const struct object_id *oid, struct strbuf *base,
    -
    - ## builtin/clone.c ##
    -@@
    - #include "connected.h"
    - #include "packfile.h"
    - #include "list-objects-filter-options.h"
    -+#include "hook.h"
    - 
    - /*
    -  * Overall FIXMEs:
    -@@ builtin/clone.c: static int checkout(int submodule_progress)
    - 	struct tree *tree;
    - 	struct tree_desc t;
    - 	int err = 0;
    -+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
    - 
    - 	if (option_no_checkout)
    - 		return 0;
    -@@ builtin/clone.c: static int checkout(int submodule_progress)
    - 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
    - 		die(_("unable to write new index file"));
    - 
    --	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
    --			   oid_to_hex(&oid), "1", NULL);
    -+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid),
    -+		     "1", NULL);
    -+	err |= run_hooks_oneshot("post-checkout", &hook_opt);
    - 
    - 	if (!err && (option_recurse_submodules.nr > 0)) {
    - 		struct strvec args = STRVEC_INIT;
    -
      ## builtin/worktree.c ##
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
      	 * is_junk is cleared, but do return appropriate code when hook fails.
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
     +			     "1",
     +			     NULL);
     +		opt.dir = path;
    -+		opt.absolute_path = 1;
     +
    -+		ret = run_hooks_oneshot("post-checkout", &opt);
    ++		ret = run_hooks_opt("post-checkout", &opt);
      	}
      
      	strvec_clear(&child_env);
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      
      	strvec_push(&cp->args, hook_path);
      	strvec_pushv(&cp->args, hook_cb->options->args.v);
    -@@ hook.c: static int notify_hook_finished(int result,
    - int run_hooks(const char *hook_name, const char *hook_path,
    - 	      struct run_hooks_opt *options)
    +@@ hook.c: static void run_hooks_opt_clear(struct run_hooks_opt *options)
    + 
    + int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
      {
     +	struct strbuf abs_path = STRBUF_INIT;
      	struct hook_cb_data cb_data = {
      		.rc = 0,
      		.hook_name = hook_name,
    --		.hook_path = hook_path,
    - 		.options = options,
    - 	};
    - 	int jobs = 1;
    -@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
    - 	if (!options)
    - 		BUG("a struct run_hooks_opt must be provided to run_hooks");
    +@@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
    + 	}
      
    -+	if (options->absolute_path) {
    + 	cb_data.hook_path = hook_path;
    ++	if (options->dir) {
     +		strbuf_add_absolute_path(&abs_path, hook_path);
    -+		hook_path = abs_path.buf;
    ++		cb_data.hook_path = abs_path.buf;
     +	}
    -+	cb_data.hook_path = hook_path;
     +
      	run_processes_parallel_tr2(jobs,
      				   pick_next_hook,
      				   notify_start_failure,
    -@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
    - 				   "hook",
    +@@ hook.c: int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
      				   hook_name);
    - 
    -+	if (options->absolute_path)
    -+		strbuf_release(&abs_path);
    -+
    - 	return cb_data.rc;
    + 	ret = cb_data.rc;
    + cleanup:
    ++	strbuf_release(&abs_path);
    + 	run_hooks_opt_clear(options);
    + 	return ret;
      }
    - 
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
      
    - 	/* Args to be passed to each hook */
    - 	struct strvec args;
    + 	/* Emit an error if the hook is missing */
    + 	unsigned int error_if_missing:1;
     +
    -+	/*
    -+	 * Resolve and run the "absolute_path(hook)" instead of
    -+	 * "hook". Used for "git worktree" hooks
    ++	/**
    ++	 * An optional initial working directory for the hook,
    ++	 * translates to "struct child_process"'s "dir" member.
     +	 */
    -+	int absolute_path;
    -+
    -+	/* Path to initial working directory for subprocess */
     +	const char *dir;
      };
      
      #define RUN_HOOKS_OPT_INIT { \
    -
    - ## reset.c ##
    -@@
    - #include "tree-walk.h"
    - #include "tree.h"
    - #include "unpack-trees.h"
    -+#include "hook.h"
    - 
    - int reset_head(struct repository *r, struct object_id *oid, const char *action,
    - 	       const char *switch_to_branch, unsigned flags,
    -@@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char *action,
    - 			ret = create_symref("HEAD", switch_to_branch,
    - 					    reflog_head);
    - 	}
    --	if (run_hook)
    --		run_hook_le(NULL, "post-checkout",
    --			    oid_to_hex(orig ? orig : null_oid()),
    --			    oid_to_hex(oid), "1", NULL);
    -+	if (run_hook) {
    -+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+		strvec_pushl(&opt.args,
    -+			     oid_to_hex(orig ? orig : null_oid()),
    -+			     oid_to_hex(oid),
    -+			     "1",
    -+			     NULL);
    -+		run_hooks_oneshot("post-checkout", &opt);
    -+	}
    - 
    - leave_reset_head:
    - 	strbuf_release(&msg);
 7:  840fb530df3 ! 11:  a0b6818c766 git hook run: add an --ignore-missing flag
    @@ Commit message
         git hook run: add an --ignore-missing flag
     
         For certain one-shot hooks we'd like to optimistically run them, and
    -    not complain if they don't exist. This will be used by send-email in a
    -    subsequent commit.
    +    not complain if they don't exist.
    +
    +    This was already supported by the underlying hook.c library, but had
    +    not been exposed via "git hook run". The command version of this will
    +    be used by send-email in a subsequent commit.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	int ignore_missing = 0;
      	const char *hook_name;
    - 	const char *hook_path;
      	struct option run_options[] = {
     +		OPT_BOOL(0, "ignore-missing", &ignore_missing,
     +			 N_("silently ignore missing requested <hook-name>")),
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	git_config(git_default_config, NULL);
      
      	hook_name = argv[0];
    -+	if (ignore_missing)
    -+		return run_hooks_oneshot(hook_name, &opt);
    - 	hook_path = find_hook(hook_name);
    - 	if (!hook_path) {
    - 		error("cannot find a hook named %s", hook_name);
    +-	opt.error_if_missing = 1;
    ++	if (!ignore_missing)
    ++		opt.error_if_missing = 1;
    + 	ret = run_hooks_opt(hook_name, &opt);
    + 	if (ret < 0) /* error() return */
    + 		ret = 1;
     
      ## t/t1800-hook.sh ##
     @@ t/t1800-hook.sh: test_expect_success 'git hook run: nonexistent hook' '
 8:  716ebabd794 = 12:  efa35971e9f send-email: use 'git hook run' for 'sendemail-validate'
 9:  95782109270 = 13:  98e0e3330fb git-p4: use 'git hook' to run hooks
10:  706426c8a79 ! 14:  79ea5a2a4f5 commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
    @@ commit.c: size_t ignore_non_trailer(const char *buf, size_t len)
     -	strvec_clear(&hook_env);
      
     -	return ret;
    -+	return run_hooks_oneshot(name, &opt);
    ++	return run_hooks_opt(name, &opt);
      }
11:  39069a9c3ff ! 15:  81612f94707 read-cache: convert post-index-change to use hook.h
    @@ read-cache.c
      
      /* Mask for the name length in ce_flags in the on-disk index */
      
    -@@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struct lock_file *l
    - {
    - 	int ret;
    - 	int was_full = !istate->sparse_index;
    -+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
    - 
    - 	ret = convert_to_sparse(istate, 0);
    - 
     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struct lock_file *l
      	else
      		ret = close_lock_file_gently(lock);
      
     -	run_hook_le(NULL, "post-index-change",
    --			istate->updated_workdir ? "1" : "0",
    --			istate->updated_skipworktree ? "1" : "0", NULL);
    -+	strvec_pushl(&hook_opt.args,
    -+		     istate->updated_workdir ? "1" : "0",
    -+		     istate->updated_skipworktree ? "1" : "0",
    -+		     NULL);
    -+	run_hooks_oneshot("post-index-change", &hook_opt);
    -+
    ++	run_hooks_l("post-index-change",
    + 			istate->updated_workdir ? "1" : "0",
    + 			istate->updated_skipworktree ? "1" : "0", NULL);
      	istate->updated_workdir = 0;
    - 	istate->updated_skipworktree = 0;
    - 
     
      ## run-command.c ##
     @@ run-command.c: int async_with_fork(void)
12:  9818078f1e5 ! 16:  43ecd6697e0 receive-pack: convert push-to-checkout hook to hook.h
    @@ builtin/receive-pack.c: static const char *push_to_checkout(unsigned char *hash,
     -			hash_to_hex(hash), NULL))
     +	strvec_pushv(&opt.env, env->v);
     +	strvec_push(&opt.args, hash_to_hex(hash));
    -+	if (run_hooks_oneshot(push_to_checkout_hook, &opt))
    ++	if (run_hooks_opt(push_to_checkout_hook, &opt))
      		return "push-to-checkout hook declined";
      	else
      		return NULL;
13:  1bc080d3611 = 17:  9ef574fa30c run-command: remove old run_hook_{le,ve}() hook API
-- 
2.33.1.1570.g069344fdd45

