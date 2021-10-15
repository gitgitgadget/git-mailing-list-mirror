Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1425C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD8F61027
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhJOJpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbhJOJpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:45:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338EC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g2so1998239wme.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mWtnydJUx/RCN/cjYl9UqbnS/aHG8VcGCwZh7xG1v0=;
        b=I7ShTJFHfAPFCsdTtKIFBH2UhZVZviA7d5djZZYjLGfh3mnH5a4G75FrVSHL3TAT4N
         /bdv5mYej+gAohfhWIt705W+jwKVY+v75UWyA3U9XB7oKJGGnSpRI3MM1sV6sNWbP2rT
         +Z45y/vnzdbdA48j/clFWa0KOOek2ktIy95rL7eaNtKhkhN7w0c42ZisdeUd8412tcK0
         7n7Fs3Z+YPW7HEJik5iBZOJivWbU2VgYpxZXBe3CFpilAbvK3VCZ76gNn9aBwdEqDGGd
         SlKC+CA7WYpejasBBSGsrd/fmaB3Wyn2Dm51/05D2B6cD/XB+r9/zi9wDcO3BwK6Eff/
         /f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mWtnydJUx/RCN/cjYl9UqbnS/aHG8VcGCwZh7xG1v0=;
        b=rKEfb4tDnA0iscjqz7JrAGluJqh1oIZ+lFvrGlLPAhnYWC0CxQtPwpJlgzyFGqa4gR
         N3sjaDsBEURTWfYXf2huhPYqTBc5LoD3De842TJC1vBo3Q061ENmwZGWzmDFPihrNUAS
         1m4+wDXR2jZqWfoW9j5x6TsjKapi6ItAk6pA5Or2mJwPV54X/oRHkBiRHacsQyrL9zFX
         WjN6eLzamTM6Nb8L/e65Kfw557gBk0gNi6iYgY7chLQwji5LBJOKRVSVC8bqp6dX9Ba9
         sP9UklhfKpPI1g62qilI1fDOmM6sAhplZaQp8X5O/SUGUdTex5t5Kad5OCMsCr86KqU9
         xRbw==
X-Gm-Message-State: AOAM532eBCKeG3ouM4GRcGJoWeqEsmVRKOiMQo0eub2l5jsnxBA6sXFg
        TU+QU+fDkYFLKOAfvRHVtqFjKLkR7w033A==
X-Google-Smtp-Source: ABdhPJwAWI1tWqrT/0PEb0nmpoy2+8ZAFQWlUnYPl3yCbFrX/gWWk+g4VbBcPi2YH6L/SfJtHsj29g==
X-Received: by 2002:a1c:1dcb:: with SMTP id d194mr24099382wmd.161.1634291025290;
        Fri, 15 Oct 2021 02:43:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:44 -0700 (PDT)
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
Subject: [PATCH v2 00/13] hook.[ch]: new library to run hooks + simple hook conversion
Date:   Fri, 15 Oct 2021 11:43:28 +0200
Message-Id: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part 2 of the greater configurable hook saga, starting by converting
some existing simple hooks to the new hook.[ch] library and "git hook
run" utility.

See the v1 [1] CL for more context. I've dropped the git-p4 folks from
the CC list, your feedback on git-p4 would still be very appreciated,
but I don't think I need to re-spam you for every re-roll of this.

This v2:

 * Should address all outstanding comments on v1, which were mainly of
   the form that some boilerplate here didn't reflect the actual state
   of the code.

   I've updated the docs, code etc. to 1=1 map to the existing
   behavior. I said I'd punt on e.g. the one-member "struct hook" in
   reply to René Scharfe, but when I tried it and rebased the rest on
   it it actually made the progression more understandable, so I've
   done that here.

   I didn't convert some things, which are noted in the updated commit
   message on v1, e.g. we still use the parallel run-command.c API
   with jobs=1, and have a function called run_hooks() that only ever
   runs one hook.

1. https://lore.kernel.org/git/cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com/

Emily Shaffer (12):
  hook: add 'run' subcommand
  gc: use hook library for pre-auto-gc hook
  rebase: convert pre-rebase to use hook.h
  am: convert applypatch to use hook.h
  hooks: convert 'post-checkout' hook to hook library
  merge: convert post-merge to use hook.h
  send-email: use 'git hook run' for 'sendemail-validate'
  git-p4: use 'git hook' to run hooks
  commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
  read-cache: convert post-index-change to use hook.h
  receive-pack: convert push-to-checkout hook to hook.h
  run-command: remove old run_hook_{le,ve}() hook API

Ævar Arnfjörð Bjarmason (1):
  git hook run: add an --ignore-missing flag

 .gitignore                 |   1 +
 Documentation/git-hook.txt |  45 +++++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/am.c               |   8 ++-
 builtin/checkout.c         |  14 ++--
 builtin/clone.c            |   7 +-
 builtin/gc.c               |   3 +-
 builtin/hook.c             |  90 +++++++++++++++++++++++++
 builtin/merge.c            |   4 +-
 builtin/rebase.c           |   8 ++-
 builtin/receive-pack.c     |   7 +-
 builtin/worktree.c         |  28 ++++----
 command-list.txt           |   1 +
 commit.c                   |  15 +++--
 git-p4.py                  |  72 ++------------------
 git-send-email.perl        |  22 +++---
 git.c                      |   1 +
 hook.c                     | 121 +++++++++++++++++++++++++++++++++
 hook.h                     |  56 ++++++++++++++++
 read-cache.c               |  11 ++-
 reset.c                    |  14 ++--
 run-command.c              |  32 ---------
 run-command.h              |  17 -----
 t/t1800-hook.sh            | 134 +++++++++++++++++++++++++++++++++++++
 t/t9001-send-email.sh      |   4 +-
 27 files changed, 551 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

Range-diff against v1:
 1:  a39c0748d3f !  1:  ba64faf0580 hook: add 'run' subcommand
    @@ Commit message
         pattern here mirrors that of
         builtin/{commit-graph,multi-pack-index}.c.
     
    +    Some of the implementation here, such as a function being named
    +    run_hooks() when it's tasked with running one hook, to using the
    +    run_processes_parallel_tr2() API to run with jobs=1 is somewhere
    +    between a bit odd and and an overkill for the current features of this
    +    "hook run" command and the hook.[ch] API.
    +
    +    This code will eventually be able to run multiple hooks declared in
    +    config in parallel, by starting out with these names and APIs we
    +    reduce the later churn of renaming functions, switching from the
    +    run_command() to run_processes_parallel_tr2() API etc.
    +
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/git-hook.txt (new)
     +
     +NAME
     +----
    -+git-hook - run git hooks
    ++git-hook - Run git hooks
     +
     +SYNOPSIS
     +--------
    @@ Documentation/git-hook.txt (new)
     +DESCRIPTION
     +-----------
     +
    -+This command is an interface to git hooks (see linkgit:githooks[5]).
    -+Currently it only provides a convenience wrapper for running hooks for
    -+use by git itself. In the future it might gain other functionality.
    ++A command interface to running git hooks (see linkgit:githooks[5]),
    ++for use by other scripted git commands.
     +
     +SUBCOMMANDS
     +-----------
     +
     +run::
     +	Run the `<hook-name>` hook. See linkgit:githooks[5] for
    -+	the hook names we support.
    ++	supported hook names.
     ++
    -+Any positional arguments to the hook should be passed after an
    -+optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
    -+arguments (if any) differ by hook name, see linkgit:githooks[5] for
    -+what those are.
    ++
    ++Any positional arguments to the hook should be passed after a
    ++mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
    ++linkgit:githooks[5] for arguments hooks might expect (if any).
     +
     +SEE ALSO
     +--------
    @@ builtin/hook.c (new)
     +	/* Need to take into account core.hooksPath */
     +	git_config(git_default_config, NULL);
     +
    -+	/*
    -+	 * We are not using a plain run_hooks() because we'd like to
    -+	 * detect missing hooks. Let's find it ourselves and call
    -+	 * run_hooks() instead.
    -+	 */
     +	hook_name = argv[0];
     +	hook_path = find_hook(hook_name);
     +	if (!hook_path) {
    @@ command-list.txt: git-grep                                mainporcelain
      git-gui                                 mainporcelain
      git-hash-object                         plumbingmanipulators
      git-help                                ancillaryinterrogators          complete
    -+git-hook                                mainporcelain
    ++git-hook                                purehelpers
      git-http-backend                        synchingrepositories
      git-http-fetch                          synchelpers
      git-http-push                           synchelpers
    @@ hook.c: int hook_exists(const char *name)
     +			  void **pp_task_cb)
     +{
     +	struct hook_cb_data *hook_cb = pp_cb;
    -+	struct hook *run_me = hook_cb->run_me;
    ++	const char *hook_path = hook_cb->hook_path;
     +
    -+	if (!run_me)
    ++	if (!hook_path)
     +		return 0;
     +
     +	cp->no_stdin = 1;
    @@ hook.c: int hook_exists(const char *name)
     +	cp->stdout_to_stderr = 1;
     +	cp->trace2_hook_name = hook_cb->hook_name;
     +
    -+	/* add command */
    -+	strvec_push(&cp->args, run_me->hook_path);
    -+
    -+	/*
    -+	 * add passed-in argv, without expanding - let the user get back
    -+	 * exactly what they put in
    -+	 */
    ++	strvec_push(&cp->args, hook_path);
     +	strvec_pushv(&cp->args, hook_cb->options->args.v);
     +
     +	/* Provide context for errors if necessary */
    -+	*pp_task_cb = run_me;
    ++	*pp_task_cb = (char *)hook_path;
     +
     +	/*
     +	 * This pick_next_hook() will be called again, we're only
     +	 * running one hook, so indicate that no more work will be
     +	 * done.
     +	 */
    -+	hook_cb->run_me = NULL;
    ++	hook_cb->hook_path = NULL;
     +
     +	return 1;
     +}
    @@ hook.c: int hook_exists(const char *name)
     +				void *pp_task_cp)
     +{
     +	struct hook_cb_data *hook_cb = pp_cb;
    -+	struct hook *attempted = pp_task_cp;
    ++	const char *hook_path = pp_task_cp;
     +
     +	hook_cb->rc |= 1;
     +
     +	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
    -+		    attempted->hook_path);
    ++		    hook_path);
     +
     +	return 1;
     +}
    @@ hook.c: int hook_exists(const char *name)
     +int run_hooks(const char *hook_name, const char *hook_path,
     +	      struct run_hooks_opt *options)
     +{
    -+	struct hook my_hook = {
    -+		.hook_path = hook_path,
    -+	};
     +	struct hook_cb_data cb_data = {
     +		.rc = 0,
     +		.hook_name = hook_name,
    ++		.hook_path = hook_path,
     +		.options = options,
     +	};
     +	int jobs = 1;
    @@ hook.c: int hook_exists(const char *name)
     +	if (!options)
     +		BUG("a struct run_hooks_opt must be provided to run_hooks");
     +
    -+	cb_data.run_me = &my_hook;
    -+
     +	run_processes_parallel_tr2(jobs,
     +				   pick_next_hook,
     +				   notify_start_failure,
    @@ hook.h
      #define HOOK_H
     +#include "strvec.h"
     +
    -+struct hook {
    -+	/* The path to the hook */
    -+	const char *hook_path;
    -+};
    -+
     +struct run_hooks_opt
     +{
     +	/* Environment vars to be set for each hook */
    @@ hook.h
     +	/* rc reflects the cumulative failure state */
     +	int rc;
     +	const char *hook_name;
    -+	struct hook *run_me;
    ++	const char *hook_path;
     +	struct run_hooks_opt *options;
     +};
      
    @@ hook.h: const char *find_hook(const char *name);
      int hook_exists(const char *hookname);
      
     +/**
    -+ * Clear data from an initialized "struct run_hooks-opt".
    ++ * Clear data from an initialized "struct run_hooks_opt".
     + */
     +void run_hooks_opt_clear(struct run_hooks_opt *o);
     +
 2:  dbac4204f7b =  2:  e3dc0aed81b gc: use hook library for pre-auto-gc hook
 3:  ff306debcb8 =  3:  6227a1e644d rebase: convert pre-rebase to use hook.h
 4:  b1d529ca485 =  4:  0e34eb54054 am: convert applypatch to use hook.h
 5:  15d71fc210b !  5:  a4df96c1719 hooks: convert 'post-checkout' hook to hook library
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	cp->trace2_hook_name = hook_cb->hook_name;
     +	cp->dir = hook_cb->options->dir;
      
    - 	/* add command */
    - 	strvec_push(&cp->args, run_me->hook_path);
    + 	strvec_push(&cp->args, hook_path);
    + 	strvec_pushv(&cp->args, hook_cb->options->args.v);
     @@ hook.c: static int notify_hook_finished(int result,
      int run_hooks(const char *hook_name, const char *hook_path,
      	      struct run_hooks_opt *options)
      {
     +	struct strbuf abs_path = STRBUF_INIT;
    - 	struct hook my_hook = {
    - 		.hook_path = hook_path,
    - 	};
    + 	struct hook_cb_data cb_data = {
    + 		.rc = 0,
    + 		.hook_name = hook_name,
     @@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
      	if (!options)
      		BUG("a struct run_hooks_opt must be provided to run_hooks");
      
     +	if (options->absolute_path) {
     +		strbuf_add_absolute_path(&abs_path, hook_path);
    -+		my_hook.hook_path = abs_path.buf;
    ++		hook_path = abs_path.buf;
     +	}
    - 	cb_data.run_me = &my_hook;
    - 
    ++
      	run_processes_parallel_tr2(jobs,
    + 				   pick_next_hook,
    + 				   notify_start_failure,
     @@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
      				   "hook",
      				   hook_name);
 6:  08f27f0d6be =  6:  327f916f8c3 merge: convert post-merge to use hook.h
 7:  107c14d740f !  7:  328767015b1 git hook run: add an --ignore-missing flag
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-hook.txt ##
    -@@ Documentation/git-hook.txt: git-hook - run git hooks
    +@@ Documentation/git-hook.txt: git-hook - Run git hooks
      SYNOPSIS
      --------
      [verse]
    @@ Documentation/git-hook.txt: git-hook - run git hooks
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-hook.txt: optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
    - arguments (if any) differ by hook name, see linkgit:githooks[5] for
    - what those are.
    +@@ Documentation/git-hook.txt: Any positional arguments to the hook should be passed after a
    + mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
    + linkgit:githooks[5] for arguments hooks might expect (if any).
      
     +OPTIONS
     +-------
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	};
      	int ret;
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    - 	/*
    - 	 * We are not using a plain run_hooks() because we'd like to
    - 	 * detect missing hooks. Let's find it ourselves and call
    --	 * run_hooks() instead.
    -+	 * run_hooks() instead...
    - 	 */
    + 	git_config(git_default_config, NULL);
    + 
      	hook_name = argv[0];
     +	if (ignore_missing)
    -+		/* ... act like a plain run_hooks() under --ignore-missing */
     +		return run_hooks_oneshot(hook_name, &opt);
      	hook_path = find_hook(hook_name);
      	if (!hook_path) {
 8:  1d30e2dbbe0 =  8:  6c4ebd68d56 send-email: use 'git hook run' for 'sendemail-validate'
 9:  69cc447a1e1 =  9:  b1f52733e3c git-p4: use 'git hook' to run hooks
10:  1c22b2992cf = 10:  dc31d98acdf commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
11:  e762fce32af = 11:  58b7689e4af read-cache: convert post-index-change to use hook.h
12:  d63b91196ae = 12:  ae1e2a82147 receive-pack: convert push-to-checkout hook to hook.h
13:  fe8996dda3e = 13:  289d5a2d849 run-command: remove old run_hook_{le,ve}() hook API
-- 
2.33.1.1338.g20da966911a

