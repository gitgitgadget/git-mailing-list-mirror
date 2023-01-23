Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF5C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjAWRP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjAWRPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:23 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAD62DE45
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:14 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ss4so32272620ejb.11
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DI3IT048dEAymnWN3RxTz84hB4jm9RIj240AUTcTabI=;
        b=mn6IG8e4A8VxM3sMbfvodJb8NtsBLsHpwQlzTZVJqTTTbngOXNWTubKlab8y05sy/K
         eTLH2MroeKgE4MxD1JcPeGPdjQRe814PUn2PZ4NlmR1MTxLB5dbGRd3SSEwAR6dyb2Gc
         CL41Am3D5mNzkyLa4UgcoEBnYYT8F5AtRXbMYWFAYPEX7F5z4/n4wa5klL+rEFE5vhtL
         yPtNipYwpuwveXrqLiq4W/6YCoUhUVJIZfBDF8QqulKvjqKwsE/FWsI8c+zCa6Kc/3/h
         ozeXYhlaVVAXlKggYDg9hJ2fsAzPzLjTEgVx74y5ceoD8IokNHh/88ZEddEdtcyqaGDH
         35JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI3IT048dEAymnWN3RxTz84hB4jm9RIj240AUTcTabI=;
        b=nTHOkBMxjcQZDFjCqOxel40GnOB0Ovr/putvDt6CEbzcv4mukF16USgsOFJzmdQqh/
         8Bi3/cFk320v+CK02tc+sQGMQonQuIj6D83Ewaxo1aBI5F7AXCFVCGOrSK55fdCvWDuI
         5gZy0msU9kwqfDXwp/CW4j+oDbMyMYWHgHAzNmA9lUTCZvIlBmJe6oF16NwpRPSj+5xA
         V0bjrpGgoy4B+08Xszm3BI44bWWYZcB85EmcD9gkjvDADpNUfj9W1VEzixgG7o3EsP4x
         eaoy652TnGrcb2rLdztckKooCf2sZPpue9FT8Vj5XedZoXE5vxxYdfmAQUkUxp9LDqnQ
         QY2A==
X-Gm-Message-State: AFqh2kpLR4hipvGwDC6MjBq341p1S4NxynioQHIsoFaJI89xhK8yY0LC
        ZWWY5+AtfHxlZA02+jChOkuTPaR20hbxPA==
X-Google-Smtp-Source: AMrXdXuoZHEVw+NLfDYy3LzUU0cDZmU6imB7saIBXcuocC7n3rQpmJ+7zNYE0Gdr5rmGahqdzNfn+A==
X-Received: by 2002:a17:906:1c55:b0:7c0:1db5:ea10 with SMTP id l21-20020a1709061c5500b007c01db5ea10mr27336394ejg.53.1674494112485;
        Mon, 23 Jan 2023 09:15:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b007c11e5ac250sm22771754ejd.91.2023.01.23.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] hook API: support stdin, convert post-rewrite
Date:   Mon, 23 Jan 2023 18:15:04 +0100
Message-Id: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1301.gffb37c08dee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The greater "config-based-hooks" topic has been stalled for a while.

In the last couple of cycles it was held up by run-command.c API
changes (which will make the rest of this much simpler), and lack of
time on my part.

But let's get the ball rolling again. The last time this was
on-list[1] it was part of a 36 patch series, these 5 patches only
convert one hook (implemented by both sequencer & git-am) to the hook
API, but it's an important step: To do so we need so support reading
from stdin, and passing that to the hooks.

The (passing) CI & topic branch for this is at[2].

The immediate motivation for this is to supply a "stdin" interface
that git-send-email.perl can use, see [3].

Changes since the [1] v5:

 * A new 1/5 here, picked from
   https://lore.kernel.org/git/patch-v2-07.22-b90961ae76d-20221012T084850Z-avarab@gmail.com/;
   A small while-at-it cleanup of a related API.

 * Updates for the aforementioned run-command API changes.

 * Commit message updates & clarifications.

 * The previous version of the "sequencer.c" change changed a variable
   name while at it, now it doesn't, making the diff much easier to
   read.

 * Updates for the *.txt and -h usage, so that we'll pass the
   since-added t0450 test.

1. https://lore.kernel.org/git/cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com/
2. https://github.com/avar/git/tree/es-avar/config-based-hooks-the-beginning
3. https://lore.kernel.org/git/230123.86wn5ds602.gmgdl@evledraar.gmail.com/

Emily Shaffer (4):
  run-command: allow stdin for run_processes_parallel
  hook API: support passing stdin to hooks, convert am's 'post-rewrite'
  sequencer: use the new hook API for the simpler "post-rewrite" call
  hook: support a --to-stdin=<path> option for testing

Ævar Arnfjörð Bjarmason (1):
  run-command.c: remove dead assignment in while-loop

 Documentation/git-hook.txt |  7 ++++++-
 builtin/am.c               | 20 ++++----------------
 builtin/hook.c             |  4 +++-
 hook.c                     |  8 +++++++-
 hook.h                     |  5 +++++
 run-command.c              | 13 +++++++++----
 sequencer.c                | 18 ++++--------------
 t/t1800-hook.sh            | 18 ++++++++++++++++++
 8 files changed, 56 insertions(+), 37 deletions(-)

Range-diff:
 1:  ac419613fdc <  -:  ----------- Makefile: mark "check" target as .PHONY
 2:  a161b7f0a5c <  -:  ----------- Makefile: stop hardcoding {command,config}-list.h
 3:  ffef1d3257e <  -:  ----------- Makefile: remove an out-of-date comment
 4:  545e16c6f04 <  -:  ----------- hook.[ch]: move find_hook() from run-command.c to hook.c
 5:  a9bc4519e9a <  -:  ----------- hook.c: add a hook_exists() wrapper and use it in bugreport.c
 6:  e99ec2e6f8f <  -:  ----------- hook.c users: use "hook_exists()" instead of "find_hook()"
 7:  2ffb2332c8a <  -:  ----------- hook-list.h: add a generated list of hooks, like config-list.h
 8:  72dd1010f5b <  -:  ----------- hook: add 'run' subcommand
 9:  821cc9bf11e <  -:  ----------- gc: use hook library for pre-auto-gc hook
10:  d71c90254ea <  -:  ----------- rebase: convert pre-rebase to use hook.h
11:  ea3af2ccc4d <  -:  ----------- am: convert applypatch to use hook.h
12:  fed0b52f88f <  -:  ----------- hooks: convert 'post-checkout' hook to hook library
13:  53d8721a0e3 <  -:  ----------- merge: convert post-merge to use hook.h
14:  d60827a2856 <  -:  ----------- git hook run: add an --ignore-missing flag
15:  d4976a0821f <  -:  ----------- send-email: use 'git hook run' for 'sendemail-validate'
16:  99f3dcd1945 <  -:  ----------- git-p4: use 'git hook' to run hooks
17:  509761454e6 <  -:  ----------- commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
18:  e2c94d95427 <  -:  ----------- read-cache: convert post-index-change to use hook.h
19:  fa7d0d24ea2 <  -:  ----------- receive-pack: convert push-to-checkout hook to hook.h
20:  428bb5a6792 <  -:  ----------- run-command: remove old run_hook_{le,ve}() hook API
 -:  ----------- >  1:  351c6a55a41 run-command.c: remove dead assignment in while-loop
21:  994f6ad8602 !  2:  81eef2f60a0 run-command: allow stdin for run_processes_parallel
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## run-command.c ##
    -@@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
    - 	if (i == pp->max_processes)
    +@@ run-command.c: static int pp_start_one(struct parallel_processes *pp,
    + 	if (i == opts->processes)
      		BUG("bookkeeping is hard");
      
     +	/*
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
     +	 */
     +	pp->children[i].process.no_stdin = 1;
     +
    - 	code = pp->get_next_task(&pp->children[i].process,
    - 				 &pp->children[i].err,
    - 				 pp->data,
    -@@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
    + 	code = opts->get_next_task(&pp->children[i].process,
    + 				   opts->ungroup ? NULL : &pp->children[i].err,
    + 				   opts->data,
    +@@ run-command.c: static int pp_start_one(struct parallel_processes *pp,
    + 		pp->children[i].process.err = -1;
    + 		pp->children[i].process.stdout_to_stderr = 1;
      	}
    - 	pp->children[i].process.err = -1;
    - 	pp->children[i].process.stdout_to_stderr = 1;
     -	pp->children[i].process.no_stdin = 1;
      
      	if (start_command(&pp->children[i].process)) {
    - 		code = pp->start_failure(&pp->children[i].err,
    + 		if (opts->start_failure)
23:  f548e3d15e7 !  3:  c6b9b69c516 am: convert 'post-rewrite' hook to hook.h
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    am: convert 'post-rewrite' hook to hook.h
    +    hook API: support passing stdin to hooks, convert am's 'post-rewrite'
    +
    +    Convert the invocation of the 'post-rewrite' hook run by 'git am' to
    +    use the hook.h library. To do this we need to add a "path_to_stdin"
    +    member to "struct run_hooks_opt".
    +
    +    In our API this is supported by asking for a file path, rather
    +    than by reading stdin. Reading directly from stdin would involve caching
    +    the entire stdin (to memory or to disk) once the hook API is made to
    +    support "jobs" larger than 1, along with support for executing N hooks
    +    at a time (i.e. the upcoming config-based hooks).
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
     -
     -	if (!hook)
     -		return 0;
    --
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    + 
     -	strvec_push(&cp.args, hook);
     -	strvec_push(&cp.args, "rebase");
    --
    ++	strvec_push(&opt.args, "rebase");
    ++	opt.path_to_stdin = am_path(state, "rewritten");
    + 
     -	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
     -	cp.stdout_to_stderr = 1;
     -	cp.trace2_hook_name = "post-rewrite";
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    - 
    +-
     -	ret = run_command(&cp);
    -+	strvec_push(&opt.args, "rebase");
    -+	opt.path_to_stdin = am_path(state, "rewritten");
    - 
    +-
     -	close(cp.in);
     -	return ret;
    -+	return run_hooks_oneshot("post-rewrite", &opt);
    ++	return run_hooks_opt("post-rewrite", &opt);
      }
      
      /**
    +
    + ## hook.c ##
    +@@ hook.c: static int pick_next_hook(struct child_process *cp,
    + 	if (!hook_path)
    + 		return 0;
    + 
    +-	cp->no_stdin = 1;
    + 	strvec_pushv(&cp->env, hook_cb->options->env.v);
    ++	/* reopen the file for stdin; run_command closes it. */
    ++	if (hook_cb->options->path_to_stdin) {
    ++		cp->no_stdin = 0;
    ++		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
    ++	} else {
    ++		cp->no_stdin = 1;
    ++	}
    + 	cp->stdout_to_stderr = 1;
    + 	cp->trace2_hook_name = hook_cb->hook_name;
    + 	cp->dir = hook_cb->options->dir;
    +
    + ## hook.h ##
    +@@ hook.h: struct run_hooks_opt
    + 	 * was invoked.
    + 	 */
    + 	int *invoked_hook;
    ++
    ++	/**
    ++	 * Path to file which should be piped to stdin for each hook.
    ++	 */
    ++	const char *path_to_stdin;
    + };
    + 
    + #define RUN_HOOKS_OPT_INIT { \
 -:  ----------- >  4:  7a55c95f60f sequencer: use the new hook API for the simpler "post-rewrite" call
22:  3ccc654a664 !  5:  cb9ef7a89c4 hook: support passing stdin to hooks
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    hook: support passing stdin to hooks
    +    hook: support a --to-stdin=<path> option for testing
     
    -    Some hooks (such as post-rewrite) need to take input via stdin.
    -    Previously, callers provided stdin to hooks by setting
    -    run-command.h:child_process.in, which takes a FD. Callers would open the
    -    file in question themselves before calling run-command(). However, since
    -    we will now need to seek to the front of the file and read it again for
    -    every hook which runs, hook.h:run_command() takes a path and handles FD
    -    management itself. Since this file is opened for read only, it should
    -    not prevent later parallel execution support.
    -
    -    On the frontend, this is supported by asking for a file path, rather
    -    than by reading stdin. Reading directly from stdin would involve caching
    -    the entire stdin (to memory or to disk) and reading it back from the
    -    beginning to each hook. We'd want to support cases like insufficient
    -    memory or storage for the file. While this may prove useful later, for
    -    now the path of least resistance is to just ask the user to make this
    -    interim file themselves.
    +    Expose the "path_to_stdin" API added in the preceding commit in the
    +    "git hook run" command. For now we won't be using this command
    +    interface outside of the tests, but exposing this functionality makes
    +    it easier to test the hook API.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-hook.txt ##
    -@@ Documentation/git-hook.txt: git-hook - run git hooks
    +@@ Documentation/git-hook.txt: git-hook - Run git hooks
      SYNOPSIS
      --------
      [verse]
     -'git hook' run [--ignore-missing] <hook-name> [-- <hook-args>]
    -+'git hook' run [--to-stdin=<path>] [--ignore-missing] <hook-name> [-- <hook-args>]
    ++'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-hook.txt: what those are.
    +@@ Documentation/git-hook.txt: linkgit:githooks[5] for arguments hooks might expect (if any).
      OPTIONS
      -------
      
    @@ builtin/hook.c
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	struct option run_options[] = {
      		OPT_BOOL(0, "ignore-missing", &ignore_missing,
    - 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
    + 			 N_("silently ignore missing requested <hook-name>")),
     +		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
     +			   N_("file to read into hooks' stdin")),
      		OPT_END(),
      	};
      	int ret;
     
    - ## hook.c ##
    -@@ hook.c: static int pick_next_hook(struct child_process *cp,
    - 	if (!run_me)
    - 		return 0;
    - 
    --	cp->no_stdin = 1;
    -+	/* reopen the file for stdin; run_command closes it. */
    -+	if (hook_cb->options->path_to_stdin) {
    -+		cp->no_stdin = 0;
    -+		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
    -+	} else {
    -+		cp->no_stdin = 1;
    -+	}
    - 	cp->env = hook_cb->options->env.v;
    - 	cp->stdout_to_stderr = 1;
    - 	cp->trace2_hook_name = hook_cb->hook_name;
    -
    - ## hook.h ##
    -@@ hook.h: struct run_hooks_opt
    - 
    - 	/* Path to initial working directory for subprocess */
    - 	const char *dir;
    -+
    -+	/* Path to file which should be piped to stdin for each hook */
    -+	const char *path_to_stdin;
    - };
    - 
    - #define RUN_HOOKS_OPT_INIT { \
    -
      ## t/t1800-hook.sh ##
    -@@ t/t1800-hook.sh: test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
    +@@ t/t1800-hook.sh: test_expect_success 'git hook run a hook with a bad shebang' '
      	test_cmp expect actual
      '
      
24:  bb119fa7cc0 <  -:  ----------- run-command: add stdin callback for parallelization
25:  2439f7752b8 <  -:  ----------- hook: provide stdin by string_list or callback
26:  48a380b3a91 <  -:  ----------- hook: convert 'post-rewrite' hook in sequencer.c to hook.h
27:  af6b9292aaa <  -:  ----------- transport: convert pre-push hook to hook.h
28:  957691f0b6d <  -:  ----------- hook tests: test for exact "pre-push" hook input
29:  88fe2621549 <  -:  ----------- hook tests: use a modern style for "pre-push" tests
30:  1d905e81779 <  -:  ----------- reference-transaction: use hook.h to run hooks
31:  fac56a9d8af <  -:  ----------- run-command: allow capturing of collated output
32:  7d185cdf9d1 <  -:  ----------- hooks: allow callers to capture output
33:  c8150e1239f <  -:  ----------- receive-pack: convert 'update' hook to hook.h
34:  a20ad847c14 <  -:  ----------- post-update: use hook.h library
35:  79c380be6ed <  -:  ----------- receive-pack: convert receive hooks to hook.h
36:  fe056098534 <  -:  ----------- hooks: fix a TOCTOU in "did we run a hook?" heuristic
-- 
2.39.1.1301.gffb37c08dee

