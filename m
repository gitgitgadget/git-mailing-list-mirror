Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53533C432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EFB60BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbhHCTj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbhHCTjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3BBC061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so83615wmd.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7xQIdS/XbRt96OVnbxr3buh4UHdIdVowcDj1icwCqU=;
        b=umMvSgJbe2yoMCM1h44Et0GFnWBc86unA1FTcUiL6icJNzSl44bcaxgBSnGacWrYMS
         J7SmUoNv8xyjXrgdwiHKpy+0DYWlNkCIeqSGQbSzPoyLl/0xCZt5p6VWRH8hicqt/6of
         SQ9oefEsV8fLNqsgGa0z4QbxC0LK0ZqYr2gxxn7sQ/3sCatZvNb+6Qeis9NfqPjsmSrH
         FcPCkiaN823NRZnC2J0qhLzKLRx35D8Vfj/lVyZf9zM5DuPlqiM77Q/8mtZa4guC53q4
         rGO32UQsjCs4aNQoytUiZkXm4lRA108V/xaJWsFaFmROAbTkyL2k2+G7mOWmFxume34t
         f3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7xQIdS/XbRt96OVnbxr3buh4UHdIdVowcDj1icwCqU=;
        b=B6rZCM8CNvQ6AMF0mNhc619evkr2+4m8th4LQFVyUyIqzcAuXK8S2As+tVdBUrp19A
         26b4WpZkkm1HJUBk6oqSFRwTJb1syhBDDkANMvm/WBxLphQn1476RS0nOY5KCCFMoA5f
         w/T40yYGlRBOrc1r7pHONNLjM933BLs0bD04fgI2bmoMCvenyCEaUE/Z28hdIXjQidvp
         NDmsQyJp8FNf48RhmY5wAEsWx/wX4/cNws5pnfrzH0u8fvu00r4UVTNUWd3m8vJgJeLq
         6vBH9+ctJ2974ojlxM8FlnfgWHreE5ZNl5Z+N+00uzfl5wLziF2uhP/m1nT6qYYXbj9g
         EJJw==
X-Gm-Message-State: AOAM533fbV6kLLT+A3iwsirtf4FI69qQvW8M0FCjLh07ZXm8I2Jlmqva
        QK2oRuGplToR68ysfZZUw8UkrqwD8Nd0FA==
X-Google-Smtp-Source: ABdhPJwE+ymsjUFwjjAIYiTaUcrXiUaFif+2Hg0K4TKnkjkoel9TTUfxzCY4KVMeBrmHxiGUhjlPtg==
X-Received: by 2002:a1c:7208:: with SMTP id n8mr5631859wmc.89.1628019550436;
        Tue, 03 Aug 2021 12:39:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/36] Run hooks via "git run hook" & hook library
Date:   Tue,  3 Aug 2021 21:38:26 +0200
Message-Id: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a v4 re-roll of the "Base for "config-based-hooks" topic.

It's grown from 27 to 36 patches mainly because I re-folded the two
topics it depended on into it, i.e.:

    https://lore.kernel.org/git/cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com/
    https://lore.kernel.org/git/cover-0.3-0000000000-20210629T183325Z-avarab@gmail.com/

I think those have long since reached a level of stability suitable
for being merged down, but since Junio didn't pick them up
separately[1][2] there wasn't much point in keeping them split-up.

This re-roll mostly addresses Emily's comments on the v3:
https://lore.kernel.org/git/YQHAasrmcbdiCDQF@google.com/

I.e.:

 * I did not change the part where I die on hooks that aren't known to
   git itself. I think it makes sense to keep this topic purely for
   bug-for-bug compatibility with existing behavior, and to flip the
   RUN_SETUP_GENTLY flag in her follow-up feature topic.

 * The (ab)use of the run_processes_parallel() API should be gone. I
   just misunderstood how it worked.

 * The v3 would segfault on a plain "git hook run". I've changed
   builtin/hook.c to use the same pattern for subcommands as
   builtin/commit-graph.c et al. This also makes the usage output more
   consistent.

 * The stub "jobs" member of the struct is now gone, and it's
   hardcoded to 1. Emily's feature topic can add it back (per her
   suggestion).

Other updates:

 * In the base topic the s/Signed-off-by/Reviewed-by/g from René
   change that Junio applied locally has been folded in.

 * Almost all the callers were just "one-shot" callers, I introduced a
   new run_hooks_oneshot() function for those, which gets rid of the
   verbosity around memory management, see e.g. the "builtin/gc.c" in
   the range-diff below. That run_hooks_oneshot() can also take a NULL
   set of options.

 * We'd leak memory from "my_hook.feed_pipe_cb_data" in hook.c, we now
   free() it.

 * Some s/STRING_LIST_INIT_DUP/STRING_LIST_INIT_NODUP &
   strbuf_detach()/ changes in transport.c and reference-transaction
   to avoid needless verbosity around memory management.

 * A new 'hook.c users: use "hook_exists()" insted of "find_hook()"'
   patch in what was previously one of the base topics, makes
   subsequent changes smaller.

1. https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87a6mevkrx.fsf@evledraar.gmail.com/

Emily Shaffer (26):
  hook.c: add a hook_exists() wrapper and use it in bugreport.c
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
  run-command: allow stdin for run_processes_parallel
  hook: support passing stdin to hooks
  am: convert 'post-rewrite' hook to hook.h
  run-command: add stdin callback for parallelization
  hook: provide stdin by string_list or callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook.h
  transport: convert pre-push hook to hook.h
  reference-transaction: use hook.h to run hooks
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  receive-pack: convert 'update' hook to hook.h
  post-update: use hook.h library
  receive-pack: convert receive hooks to hook.h

Ævar Arnfjörð Bjarmason (10):
  Makefile: mark "check" target as .PHONY
  Makefile: stop hardcoding {command,config}-list.h
  Makefile: remove an out-of-date comment
  hook.[ch]: move find_hook() to this new library
  hook.c users: use "hook_exists()" insted of "find_hook()"
  hook-list.h: add a generated list of hooks, like config-list.h
  git hook run: add an --ignore-missing flag
  hook tests: test for exact "pre-push" hook input
  hook tests: use a modern style for "pre-push" tests
  hooks: fix a TOCTOU in "did we run a hook?" heuristic

 .gitignore                          |   2 +
 Documentation/git-hook.txt          |  51 +++++
 Documentation/githooks.txt          |   4 +
 Makefile                            |  26 ++-
 builtin.h                           |   1 +
 builtin/am.c                        |  29 +--
 builtin/bugreport.c                 |  46 +----
 builtin/checkout.c                  |  14 +-
 builtin/clone.c                     |   6 +-
 builtin/commit.c                    |  19 +-
 builtin/fetch.c                     |   1 +
 builtin/gc.c                        |   3 +-
 builtin/hook.c                      |  92 +++++++++
 builtin/merge.c                     |  21 +-
 builtin/rebase.c                    |   6 +-
 builtin/receive-pack.c              | 285 +++++++++++++---------------
 builtin/submodule--helper.c         |   2 +-
 builtin/worktree.c                  |  29 ++-
 command-list.txt                    |   1 +
 commit.c                            |  16 +-
 commit.h                            |   3 +-
 compat/vcbuild/README               |   2 +-
 config.mak.uname                    |   6 +-
 contrib/buildsystems/CMakeLists.txt |   7 +
 generate-hooklist.sh                |  18 ++
 git-p4.py                           |  72 +------
 git-send-email.perl                 |  20 +-
 git.c                               |   1 +
 hook.c                              | 246 ++++++++++++++++++++++++
 hook.h                              | 126 ++++++++++++
 read-cache.c                        |  11 +-
 refs.c                              |  41 ++--
 reset.c                             |  14 +-
 run-command.c                       | 157 +++++++--------
 run-command.h                       |  55 +++---
 sequencer.c                         |  86 ++++-----
 submodule.c                         |   1 +
 t/helper/test-run-command.c         |  46 ++++-
 t/t0061-run-command.sh              |  37 ++++
 t/t1800-hook.sh                     | 156 +++++++++++++++
 t/t5571-pre-push-hook.sh            |  94 +++++----
 t/t9001-send-email.sh               |   4 +-
 transport.c                         |  57 ++----
 43 files changed, 1303 insertions(+), 611 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 generate-hooklist.sh
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1800-hook.sh

Range-diff against v3:
 1:  27c94247f87 =  1:  81fe1ed90d5 Makefile: mark "check" target as .PHONY
 2:  6e164edb0b0 !  2:  0f749530777 Makefile: stop hardcoding {command,config}-list.h
    @@ Commit message
         added in 029bac01a8 (Makefile: add {program,xdiff,test,git,fuzz}-objs
         & objects targets, 2021-02-23).
     
    +    A subsequent commit will add a new generated hook-list.h. By doing
    +    this refactoring we'll only need to add the new file to the
    +    GENERATED_H variable, not EXCEPT_HDRS, the vcbuild/README etc.
    +
         I have not tested the Windows-specific change in config.mak.uname
         being made here, but we use other variables from the Makefile in the
         same block, and the GENERATED_H is fully defined before we include
         config.mak.uname.
     
         Hardcoding command-list.h there seems to have been a case of
    -    copy/paste programming in dce7d29551 (msvc: support building Git using
    -    MS Visual C++, 2019-06-25). The config-list.h was added later in
    -    709df95b78 (help: move list_config_help to builtin/help, 2020-04-16).
    +    copy/paste programming in 976aaedca0 (msvc: add a Makefile target to
    +    pre-generate the Visual Studio solution, 2019-07-29). The
    +    config-list.h was added later in 709df95b78 (help: move
    +    list_config_help to builtin/help, 2020-04-16).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 3:  ddae86802e2 !  3:  644b31fe281 Makefile: remove an out-of-date comment
    @@ Commit message
         The rest of it was also somewhere between inaccurate and outdated,
         since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
         it's not followed by a list of header files, that got moved earlier in
    -    the file into LIB_H in b8ba629264 (Makefile: fold MISC_H into LIB_H,
    -    2012-06-20).
    +    the file into LIB_H in 60d24dd255 (Makefile: fold XDIFF_H and VCSSVN_H
    +    into LIB_H, 2012-07-06).
     
         Let's just remove it entirely, to the extent that we have anything
         useful to say here the comment on the
    @@ Makefile: ifneq ($(dep_files_present),)
     -# Dependencies on automatically generated headers such as command-list.h
     -# should _not_ be included here, since they are necessary even when
     -# building an object for the first time.
    - 
    +-
      $(OBJECTS): $(LIB_H) $(GENERATED_H)
      endif
    + 
 4:  58c37e4f06e =  4:  89c4d44b0c3 hook.[ch]: move find_hook() to this new library
 5:  0cf7e078ef4 =  5:  3514e0c0251 hook.c: add a hook_exists() wrapper and use it in bugreport.c
 -:  ----------- >  6:  d5ef40f77dc hook.c users: use "hook_exists()" insted of "find_hook()"
 6:  f343fc7ae66 !  7:  4cfd72722c1 hook-list.h: add a generated list of hooks, like config-list.h
    @@ Commit message
          - 976aaedca0 (msvc: add a Makefile target to pre-generate the Visual
            Studio solution, 2019-07-29)
     
    +    The LC_ALL=C is needed because at least in my locale the dash ("-") is
    +    ignored for the purposes of sorting, which results in a different
    +    order. I'm not aware of anything in git that has a hard dependency on
    +    the order, but e.g. the bugreport output would end up using whatever
    +    locale was in effect when git was compiled.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Helped-by: René Scharfe <l.s.r@web.de>
     
      ## .gitignore ##
     @@
    @@ Makefile: command-list.h: $(wildcard Documentation/git*.txt)
      		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
      		command-list.txt >$@+ && mv $@+ $@
      
    -+hook-list.h: generate-hooklist.sh
    -+hook-list.h: Documentation/githooks.txt
    ++hook-list.h: generate-hooklist.sh Documentation/githooks.txt
     +	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh \
     +		>$@+ && mv $@+ $@
     +
    @@ contrib/buildsystems/CMakeLists.txt: if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-li
      ## generate-hooklist.sh (new) ##
     @@
     +#!/bin/sh
    ++#
    ++# Usage: ./generate-hooklist.sh >hook-list.h
     +
    -+echo "/* Automatically generated by generate-hooklist.sh */"
    ++cat <<EOF
    ++/* Automatically generated by generate-hooklist.sh */
     +
    -+print_hook_list () {
    -+	cat <<EOF
     +static const char *hook_name_list[] = {
     +EOF
    -+	perl -ne '
    -+		chomp;
    -+		@l[$.] = $_;
    -+		push @h => $l[$. - 1] if /^~~~+$/s;
    -+		END {
    -+			print qq[\t"$_",\n] for sort @h;
    -+		}
    -+	' <Documentation/githooks.txt
    -+	cat <<EOF
    ++
    ++sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
    ++	<Documentation/githooks.txt |
    ++	LC_ALL=C sort
    ++
    ++cat <<EOF
     +	NULL,
     +};
     +EOF
    -+}
    -+
    -+echo
    -+print_hook_list
     
      ## hook.c ##
     @@
 7:  cf4b06bfdf8 !  8:  7cb4a4cb69e hook: add 'run' subcommand
    @@ Commit message
         let's start with the bare minimum required to support our simplest
         hooks.
     
    +    In terms of implementation the usage_with_options() and "goto usage"
    +    pattern here mirrors that of
    +    builtin/{commit-graph,multi-pack-index}.c.
    +
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/hook.c (new)
     +#include "strbuf.h"
     +#include "strvec.h"
     +
    ++#define BUILTIN_HOOK_RUN_USAGE \
    ++	N_("git hook run <hook-name> [-- <hook-args>]")
    ++
     +static const char * const builtin_hook_usage[] = {
    -+	N_("git hook <command> [...]"),
    -+	N_("git hook run <hook-name> [-- <hook-args>]"),
    ++	BUILTIN_HOOK_RUN_USAGE,
     +	NULL
     +};
     +
     +static const char * const builtin_hook_run_usage[] = {
    -+	N_("git hook run <hook-name> [-- <hook-args>]"),
    ++	BUILTIN_HOOK_RUN_USAGE,
     +	NULL
     +};
     +
    @@ builtin/hook.c (new)
     +{
     +	int i;
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	int rc = 0;
     +	const char *hook_name;
     +	const char *hook_path;
    -+
     +	struct option run_options[] = {
     +		OPT_END(),
     +	};
    ++	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, run_options,
     +			     builtin_hook_run_usage,
    -+			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
    -+
    -+	if (argc > 1) {
    -+		if (strcmp(argv[1], "--") &&
    -+		    strcmp(argv[1], "--end-of-options"))
    -+			/* Having a -- for "run" is mandatory */
    -+			usage_with_options(builtin_hook_usage, run_options);
    -+		/* Add our arguments, start after -- */
    -+		for (i = 2 ; i < argc; i++)
    -+			strvec_push(&opt.args, argv[i]);
    -+	}
    ++			     PARSE_OPT_KEEP_DASHDASH);
     +
    -+	/* Need to take into account core.hooksPath */
    -+	git_config(git_default_config, NULL);
    ++	if (!argc)
    ++		goto usage;
     +
     +	/*
    -+	 * We are not using run_hooks() because we'd like to detect
    -+	 * missing hooks. Let's find it ourselves and call
    -+	 * run_found_hooks() instead.
    ++	 * Having a -- for "run" when providing <hook-args> is
    ++	 * mandatory.
     +	 */
    ++	if (argc > 1 && strcmp(argv[1], "--") &&
    ++	    strcmp(argv[1], "--end-of-options"))
    ++		goto usage;
    ++
    ++	/* Add our arguments, start after -- */
    ++	for (i = 2 ; i < argc; i++)
    ++		strvec_push(&opt.args, argv[i]);
    ++
    ++	/* Need to take into account core.hooksPath */
    ++	git_config(git_default_config, NULL);
    ++
     +	hook_name = argv[0];
     +	hook_path = find_hook(hook_name);
     +	if (!hook_path) {
     +		error("cannot find a hook named %s", hook_name);
     +		return 1;
     +	}
    -+	rc = run_found_hooks(hook_name, hook_path, &opt);
     +
    ++	ret = run_hooks(hook_name, hook_path, &opt);
     +	run_hooks_opt_clear(&opt);
    -+
    -+	return rc;
    ++	return ret;
    ++usage:
    ++	usage_with_options(builtin_hook_run_usage, run_options);
     +}
     +
     +int cmd_hook(int argc, const char **argv, const char *prefix)
    @@ builtin/hook.c (new)
     +	struct option builtin_hook_options[] = {
     +		OPT_END(),
     +	};
    ++
     +	argc = parse_options(argc, argv, NULL, builtin_hook_options,
     +			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
     +	if (!argc)
    -+		usage_with_options(builtin_hook_usage, builtin_hook_options);
    ++		goto usage;
     +
     +	if (!strcmp(argv[0], "run"))
     +		return run(argc, argv, prefix);
    -+	else
    -+		usage_with_options(builtin_hook_usage, builtin_hook_options);
    ++
    ++usage:
    ++	usage_with_options(builtin_hook_usage, builtin_hook_options);
     +}
     
      ## command-list.txt ##
    @@ hook.c: int hook_exists(const char *name)
     +	struct hook_cb_data *hook_cb = pp_cb;
     +	struct hook *run_me = hook_cb->run_me;
     +
    ++	if (!run_me)
    ++		return 0;
    ++
     +	cp->no_stdin = 1;
     +	cp->env = hook_cb->options->env.v;
     +	cp->stdout_to_stderr = 1;
    @@ hook.c: int hook_exists(const char *name)
     +	/* Provide context for errors if necessary */
     +	*pp_task_cb = run_me;
     +
    ++	/*
    ++	 * This pick_next_hook() will be called again, we're only
    ++	 * running one hook, so indicate that no more work will be
    ++	 * done.
    ++	 */
    ++	hook_cb->run_me = NULL;
    ++
     +	return 1;
     +}
     +
    @@ hook.c: int hook_exists(const char *name)
     +
     +	hook_cb->rc |= result;
     +
    -+	return 1;
    ++	return 0;
     +}
     +
    -+int run_found_hooks(const char *hook_name, const char *hook_path,
    -+		    struct run_hooks_opt *options)
    ++int run_hooks(const char *hook_name, const char *hook_path,
    ++	      struct run_hooks_opt *options)
     +{
     +	struct hook my_hook = {
     +		.hook_path = hook_path,
    @@ hook.c: int hook_exists(const char *name)
     +		.hook_name = hook_name,
     +		.options = options,
     +	};
    -+	cb_data.run_me = &my_hook;
    ++	int jobs = 1;
    ++
    ++	if (!options)
    ++		BUG("a struct run_hooks_opt must be provided to run_hooks");
     +
    -+	if (options->jobs != 1)
    -+		BUG("we do not handle %d or any other != 1 job number yet", options->jobs);
    ++	cb_data.run_me = &my_hook;
     +
    -+	run_processes_parallel_tr2(options->jobs,
    ++	run_processes_parallel_tr2(jobs,
     +				   pick_next_hook,
     +				   notify_start_failure,
     +				   notify_hook_finished,
    @@ hook.c: int hook_exists(const char *name)
     +				   hook_name);
     +
     +	return cb_data.rc;
    -+}
    -+
    -+int run_hooks(const char *hook_name, struct run_hooks_opt *options)
    -+{
    -+	const char *hook_path;
    -+	int ret;
    -+	if (!options)
    -+		BUG("a struct run_hooks_opt must be provided to run_hooks");
    -+
    -+	hook_path = find_hook(hook_name);
    -+
    -+	/*
    -+	 * If you need to act on a missing hook, use run_found_hooks()
    -+	 * instead
    -+	 */
    -+	if (!hook_path)
    -+		return 0;
    -+
    -+	ret = run_found_hooks(hook_name, hook_path, options);
    -+	return ret;
     +}
     
      ## hook.h ##
    @@ hook.h: const char *find_hook(const char *name);
     +
     +	/* Args to be passed to each hook */
     +	struct strvec args;
    -+
    -+	/*
    -+	 * Number of threads to parallelize across, currently a stub,
    -+	 * we use the parallel API for future-proofing, but we always
    -+	 * have one hook of a given name, so this is always an
    -+	 * implicit 1 for now.
    -+	 */
    -+	int jobs;
     +};
     +
     +#define RUN_HOOKS_OPT_INIT { \
    -+	.jobs = 1, \
     +	.env = STRVEC_INIT, \
     +	.args = STRVEC_INIT, \
     +}
     +
    ++/*
    ++ * Callback provided to feed_pipe_fn and consume_sideband_fn.
    ++ */
     +struct hook_cb_data {
     +	/* rc reflects the cumulative failure state */
     +	int rc;
    @@ hook.h: const char *find_hook(const char *name);
     +
     +void run_hooks_opt_clear(struct run_hooks_opt *o);
     +
    -+/*
    -+ * Calls find_hook(hookname) and runs the hooks (if any) with
    -+ * run_found_hooks().
    -+ */
    -+int run_hooks(const char *hook_name, struct run_hooks_opt *options);
    -+
    -+/*
    -+ * Takes an already resolved hook and runs it. Internally the simpler
    -+ * run_hooks() will call this.
    ++/**
    ++ * Takes an already resolved hook found via find_hook() and runs
    ++ * it. Does not call run_hooks_opt_clear() for you.
     + */
    -+int run_found_hooks(const char *hookname, const char *hook_path,
    -+		    struct run_hooks_opt *options);
    ++int run_hooks(const char *hookname, const char *hook_path,
    ++	      struct run_hooks_opt *options);
      #endif
     
      ## t/t1800-hook.sh (new) ##
    @@ t/t1800-hook.sh (new)
     +
     +test_expect_success 'git hook usage' '
     +	test_expect_code 129 git hook &&
    -+	test_expect_code 129 git hook -h &&
    -+	test_expect_code 129 git hook run -h
    ++	test_expect_code 129 git hook run &&
    ++	test_expect_code 129 git hook run -h &&
    ++	test_expect_code 129 git hook run --unknown 2>err &&
    ++	grep "unknown option" err
     +'
     +
     +test_expect_success 'setup GIT_TEST_FAKE_HOOKS=true to permit "test-hook" and "does-not-exist" names"' '
 8:  7209f73f281 !  9:  2b8500aa675 gc: use hook library for pre-auto-gc hook
    @@ Metadata
      ## Commit message ##
         gc: use hook library for pre-auto-gc hook
     
    -    Using the hook.h library instead of the run-command.h library to run
    -    pre-auto-gc means that those hooks can be set up in config files, as
    -    well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.
    +    Move the pre-auto-gc hook away from run-command.h to and over to the
    +    new hook.h library.
    +
    +    To do this introduce a simple run_hooks_oneshot() wrapper, we'll be
    +    using it extensively for these simple cases of wanting to run a single
    +    hook under a given name, and having it free the memory we allocate for
    +    us.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/gc.c
      
      #define FAILED_RUN "failed to run %s"
      
    -@@ builtin/gc.c: static void add_repack_incremental_option(void)
    - 
    - static int need_to_gc(void)
    - {
    -+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
    -+
    - 	/*
    - 	 * Setting gc.auto to 0 or negative can disable the
    - 	 * automatic gc.
     @@ builtin/gc.c: static int need_to_gc(void)
      	else
      		return 0;
      
     -	if (run_hook_le(NULL, "pre-auto-gc", NULL))
    -+	if (run_hooks("pre-auto-gc", &hook_opt)) {
    -+		run_hooks_opt_clear(&hook_opt);
    ++	if (run_hooks_oneshot("pre-auto-gc", NULL))
      		return 0;
    -+	}
    -+	run_hooks_opt_clear(&hook_opt);
      	return 1;
      }
    +
    + ## hook.c ##
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
      
    + 	return cb_data.rc;
    + }
    ++
    ++int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
    ++{
    ++	const char *hook_path;
    ++	int ret;
    ++	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
    ++
    ++	if (!options)
    ++		options = &hook_opt_scratch;
    ++
    ++	hook_path = find_hook(hook_name);
    ++	if (!hook_path) {
    ++		ret = 0;
    ++		goto cleanup;
    ++	}
    ++
    ++	ret = run_hooks(hook_name, hook_path, options);
    ++cleanup:
    ++	run_hooks_opt_clear(options);
    ++	return ret;
    ++}
    +
    + ## hook.h ##
    +@@ hook.h: void run_hooks_opt_clear(struct run_hooks_opt *o);
    + /**
    +  * Takes an already resolved hook found via find_hook() and runs
    +  * it. Does not call run_hooks_opt_clear() for you.
    ++ *
    ++ * See run_hooks_oneshot() for the simpler one-shot API.
    +  */
    + int run_hooks(const char *hookname, const char *hook_path,
    + 	      struct run_hooks_opt *options);
    ++
    ++/**
    ++ * Calls find_hook() on your "hook_name" and runs the hooks (if any)
    ++ * with run_hooks().
    ++ *
    ++ * If "options" is provided calls run_hooks_opt_clear() on it for
    ++ * you. If "options" is NULL a scratch one will be provided for you
    ++ * before calling run_hooks().
    ++ */
    ++int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
    ++
    + #endif
 9:  e9a1e7cf61e ! 10:  3ee55d2c10f rebase: teach pre-rebase to use hook.h
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    rebase: teach pre-rebase to use hook.h
    +    rebase: convert pre-rebase to use hook.h
     
         Move the pre-rebase hook away from run-command.h to and over to the
         new hook.h library.
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      	if (!ok_to_skip_pre_rebase &&
     -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
     -			argc ? argv[0] : NULL, NULL))
    -+	    run_hooks("pre-rebase", &hook_opt)) {
    -+		run_hooks_opt_clear(&hook_opt);
    ++	    run_hooks_oneshot("pre-rebase", &hook_opt))
      		die(_("The pre-rebase hook refused to rebase."));
    -+	}
    -+	run_hooks_opt_clear(&hook_opt);
      
      	if (options.flags & REBASE_DIFFSTAT) {
    - 		struct diff_options opts;
10:  1d087269303 ! 11:  050f20d14f0 am: convert applypatch hooks to use config
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    am: convert applypatch hooks to use config
    +    am: convert applypatch to use hook.h
     
         Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
         hook.h library instead of the run-command.h library.
    @@ builtin/am.c: static void am_destroy(const struct am_state *state)
      	assert(state->msg);
     -	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
     +	strvec_push(&opt.args, am_path(state, "final-commit"));
    -+	ret = run_hooks("applypatch-msg", &opt);
    -+	run_hooks_opt_clear(&opt);
    ++	ret = run_hooks_oneshot("applypatch-msg", &opt);
      
      	if (!ret) {
      		FREE_AND_NULL(state->msg);
     @@ builtin/am.c: static void do_commit(const struct am_state *state)
    - 	struct commit_list *parents = NULL;
      	const char *reflog_msg, *author, *committer = NULL;
      	struct strbuf sb = STRBUF_INIT;
    -+	struct run_hooks_opt hook_opt_pre = RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt hook_opt_post = RUN_HOOKS_OPT_INIT;
      
     -	if (run_hook_le(NULL, "pre-applypatch", NULL))
    -+	if (run_hooks("pre-applypatch", &hook_opt_pre)) {
    -+		run_hooks_opt_clear(&hook_opt_pre);
    ++	if (run_hooks_oneshot("pre-applypatch", NULL))
      		exit(1);
    -+	}
      
      	if (write_cache_as_tree(&tree, 0, NULL))
    - 		die(_("git write-tree failed to write a tree"));
     @@ builtin/am.c: static void do_commit(const struct am_state *state)
      		fclose(fp);
      	}
      
     -	run_hook_le(NULL, "post-applypatch", NULL);
    -+	run_hooks("post-applypatch", &hook_opt_post);
    ++	run_hooks_oneshot("post-applypatch", NULL);
      
    -+	run_hooks_opt_clear(&hook_opt_pre);
    -+	run_hooks_opt_clear(&hook_opt_post);
      	strbuf_release(&sb);
      }
    - 
11:  32eec5dc2f0 ! 12:  ac875d284da hooks: convert 'post-checkout' hook to hook library
    @@ builtin/checkout.c: struct branch_info {
     -			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
     -			   changed ? "1" : "0", NULL);
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	int rc;
     +
      	/* "new_commit" can be NULL when checking out from the index before
      	   a commit exists. */
    @@ builtin/checkout.c: struct branch_info {
     +		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
     +		     changed ? "1" : "0",
     +		     NULL);
    -+	rc = run_hooks("post-checkout", &opt);
    -+	run_hooks_opt_clear(&opt);
    -+	return rc;
    ++	return run_hooks_oneshot("post-checkout", &opt);
      }
      
      static int update_some(const struct object_id *oid, struct strbuf *base,
    @@ builtin/clone.c: static int checkout(int submodule_progress)
     -	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
     -			   oid_to_hex(&oid), "1", NULL);
     +	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid), "1", NULL);
    -+	err |= run_hooks("post-checkout", &hook_opt);
    -+	run_hooks_opt_clear(&hook_opt);
    ++	err |= run_hooks_oneshot("post-checkout", &hook_opt);
      
      	if (!err && (option_recurse_submodules.nr > 0)) {
      		struct strvec args = STRVEC_INIT;
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
     +		opt.dir = path;
     +		opt.absolute_path = 1;
     +
    -+		ret = run_hooks("post-checkout", &opt);
    -+
    -+		run_hooks_opt_clear(&opt);
    ++		ret = run_hooks_oneshot("post-checkout", &opt);
      	}
      
      	strvec_clear(&child_env);
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	/* add command */
      	strvec_push(&cp->args, run_me->hook_path);
     @@ hook.c: static int notify_hook_finished(int result,
    - int run_found_hooks(const char *hook_name, const char *hook_path,
    - 		    struct run_hooks_opt *options)
    + int run_hooks(const char *hook_name, const char *hook_path,
    + 	      struct run_hooks_opt *options)
      {
     +	struct strbuf abs_path = STRBUF_INIT;
      	struct hook my_hook = {
      		.hook_path = hook_path,
      	};
    -@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    - 		.hook_name = hook_name,
    - 		.options = options,
    - 	};
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
    + 	if (!options)
    + 		BUG("a struct run_hooks_opt must be provided to run_hooks");
    + 
     +	if (options->absolute_path) {
     +		strbuf_add_absolute_path(&abs_path, hook_path);
     +		my_hook.hook_path = abs_path.buf;
     +	}
      	cb_data.run_me = &my_hook;
      
    - 	if (options->jobs != 1)
    -@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    - 				   &cb_data,
    + 	run_processes_parallel_tr2(jobs,
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
      				   "hook",
      				   hook_name);
    + 
     +	if (options->absolute_path)
     +		strbuf_release(&abs_path);
    - 
    ++
      	return cb_data.rc;
      }
    + 
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    - 	 * implicit 1 for now.
    - 	 */
    - 	int jobs;
    + 
    + 	/* Args to be passed to each hook */
    + 	struct strvec args;
     +
     +	/* Resolve and run the "absolute_path(hook)" instead of
     +	 * "hook". Used for "git worktree" hooks
    @@ hook.h: struct run_hooks_opt
     +
     +	/* Path to initial working directory for subprocess */
     +	const char *dir;
    -+
      };
      
      #define RUN_HOOKS_OPT_INIT { \
     
      ## read-cache.c ##
     @@
    - #include "progress.h"
      #include "sparse-index.h"
      #include "csum-file.h"
    + #include "promisor-remote.h"
     +#include "hook.h"
      
      /* Mask for the name length in ce_flags in the on-disk index */
    @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char
     +			     oid_to_hex(oid),
     +			     "1",
     +			     NULL);
    -+		run_hooks("post-checkout", &opt);
    -+		run_hooks_opt_clear(&opt);
    ++		run_hooks_oneshot("post-checkout", &opt);
     +	}
      
      leave_reset_head:
12:  e9fa3f67593 ! 13:  69763bc2255 merge: use config-based hooks for post-merge hook
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    merge: use config-based hooks for post-merge hook
    +    merge: convert post-merge to use hook.h
     
    -    Teach post-merge to use the hook.h library instead of the run-command.h
    -    library to run hooks. This means that post-merge hooks can come from the
    -    config as well as from the hookdir. post-merge is invoked only from
    -    builtin/merge.c.
    +    Teach post-merge to use the hook.h library instead of the
    +    run-command.h library to run hooks.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/merge.c: static void finish(struct commit *head_commit,
      	/* Run a post-merge hook */
     -	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
     +	strvec_push(&opt.args, squash ? "1" : "0");
    -+	run_hooks("post-merge", &opt);
    -+	run_hooks_opt_clear(&opt);
    ++	run_hooks_oneshot("post-merge", &opt);
      
      	apply_autostash(git_path_merge_autostash(the_repository));
      	strbuf_release(&reflog_message);
    -@@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
    - 	 * and write it out as a tree.  We must do this before we invoke
    - 	 * the editor and after we invoke run_status above.
    - 	 */
    --	if (find_hook("pre-merge-commit"))
    -+	if (hook_exists("pre-merge-commit"))
    - 		discard_cache();
    - 	read_cache_from(index_file);
    - 	strbuf_addbuf(&msg, &merge_msg);
13:  12347d901bb ! 14:  2ca1ca1b8e4 git hook run: add an --ignore-missing flag
    @@ Documentation/git-hook.txt: optional `--` (or `--end-of-options`, see linkgit:gi
      linkgit:githooks[5]
     
      ## builtin/hook.c ##
    +@@
    + #include "strvec.h"
    + 
    + #define BUILTIN_HOOK_RUN_USAGE \
    +-	N_("git hook run <hook-name> [-- <hook-args>]")
    ++	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
    + 
    + static const char * const builtin_hook_usage[] = {
    + 	BUILTIN_HOOK_RUN_USAGE,
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    + {
      	int i;
      	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    - 	int rc = 0;
     +	int ignore_missing = 0;
      	const char *hook_name;
      	const char *hook_path;
    - 
      	struct option run_options[] = {
     +		OPT_BOOL(0, "ignore-missing", &ignore_missing,
     +			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
      		OPT_END(),
      	};
    - 
    + 	int ret;
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    - 	/*
    - 	 * We are not using run_hooks() because we'd like to detect
    - 	 * missing hooks. Let's find it ourselves and call
    --	 * run_found_hooks() instead.
    -+	 * run_found_hooks() instead...
    - 	 */
    + 	git_config(git_default_config, NULL);
    + 
      	hook_name = argv[0];
    ++	if (ignore_missing)
    ++		return run_hooks_oneshot(hook_name, &opt);
      	hook_path = find_hook(hook_name);
      	if (!hook_path) {
    -+		/* ... act like run_hooks() under --ignore-missing */
    -+		if (ignore_missing)
    -+			return 0;
      		error("cannot find a hook named %s", hook_name);
    - 		return 1;
    - 	}
     
      ## t/t1800-hook.sh ##
     @@ t/t1800-hook.sh: test_expect_success 'git hook run: nonexistent hook' '
      	test_cmp stderr.expect stderr.actual
      '
      
    --test_expect_success 'git hook run: basic' '
     +test_expect_success 'git hook run: nonexistent hook with --ignore-missing' '
     +	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
     +	test_must_be_empty stderr.actual
     +'
     +
    -+test_expect_success 'git hook run -- basic' '
    + test_expect_success 'git hook run: basic' '
      	write_script .git/hooks/test-hook <<-EOF &&
      	echo Test hook
    - 	EOF
14:  71d209b4077 ! 15:  5b66b04bec7 send-email: use 'git hook run' for 'sendemail-validate'
    @@ git-send-email.perl: sub validate_patch {
      	if ($repo) {
     +		my $hook_name = 'sendemail-validate';
      		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
    --		my $validate_hook = catfile($hooks_path,
    + 		require File::Spec;
    +-		my $validate_hook = File::Spec->catfile($hooks_path,
     -					    'sendemail-validate');
    -+		my $validate_hook = catfile($hooks_path, $hook_name);
    ++		my $validate_hook = File::Spec->catfile($hooks_path, $hook_name);
      		my $hook_error;
      		if (-x $validate_hook) {
    - 			my $target = abs_path($fn);
    + 			require Cwd;
     @@ git-send-email.perl: sub validate_patch {
      			chdir($repo->wc_path() or $repo->repo_path())
      				or die("chdir: $!");
15:  246a82b55b2 = 16:  14a37a43db2 git-p4: use 'git hook' to run hooks
16:  e3f8482d803 ! 17:  ad5d0e0e7de commit: use hook.h to execute hooks
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    commit: use hook.h to execute hooks
    +    commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
     
    -    Teach run_commit_hook() to call hook.h instead of run-command.h. This
    -    covers 'pre-commit', 'commit-msg', and
    -    'prepare-commit-msg'.
    -
    -    Additionally, ask the hook library - not run-command - whether any
    -    hooks will be run, as it's possible hooks may exist in the config but
    -    not the hookdir.
    -
    -    Because all but 'post-commit' hooks are expected to make some state
    -    change, force all but 'post-commit' hook to run in series. 'post-commit'
    -    "is meant primarily for notification, and cannot affect the outcome of
    -    `git commit`," so it is fine to run in parallel.
    +    Move these hooks hook away from run-command.h to and over to the new
    +    hook.h library.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/commit.c ##
    -@@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
    - 		return 0;
    - 	}
    - 
    --	if (!no_verify && find_hook("pre-commit")) {
    -+	if (!no_verify && hook_exists("pre-commit")) {
    - 		/*
    - 		 * Re-read the index as pre-commit hook could have updated it,
    - 		 * and write it out as a tree.  We must do this before we invoke
    -
      ## commit.c ##
     @@
      #include "commit-reach.h"
    @@ commit.c: size_t ignore_non_trailer(const char *buf, size_t len)
     -	struct strvec hook_env = STRVEC_INIT;
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
      	va_list args;
    +-	int ret;
     +	const char *arg;
    - 	int ret;
    --
    + 
     -	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
     +	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
      
    @@ commit.c: size_t ignore_non_trailer(const char *buf, size_t len)
     +		strvec_push(&opt.args, arg);
      	va_end(args);
     -	strvec_clear(&hook_env);
    -+
    -+	ret = run_hooks(name, &opt);
    -+	run_hooks_opt_clear(&opt);
      
    - 	return ret;
    +-	return ret;
    ++	return run_hooks_oneshot(name, &opt);
      }
    -
    - ## sequencer.c ##
    -@@ sequencer.c: static int try_to_commit(struct repository *r,
    - 		}
    - 	}
    - 
    --	if (find_hook("prepare-commit-msg")) {
    -+	if (hook_exists("prepare-commit-msg")) {
    - 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
    - 		if (res)
    - 			goto out;
17:  6ed61071c5e ! 18:  3d3a33e2674 read-cache: convert post-index-change hook to use config
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    read-cache: convert post-index-change hook to use config
    +    read-cache: convert post-index-change to use hook.h
     
    -    By using hook.h instead of run-command.h to run, post-index-change hooks
    -    can now be specified in the config in addition to the hookdir.
    -    post-index-change is not run anywhere besides in read-cache.c.
    +    Move the post-index-change hook away from run-command.h to and over to
    +    the new hook.h library.
     
         This removes the last direct user of run_hook_ve(), so we can make the
         function static now. It'll be removed entirely soon.
    @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struc
     +		     istate->updated_workdir ? "1" : "0",
     +		     istate->updated_skipworktree ? "1" : "0",
     +		     NULL);
    -+	run_hooks("post-index-change", &hook_opt);
    -+	run_hooks_opt_clear(&hook_opt);
    ++	run_hooks_oneshot("post-index-change", &hook_opt);
     +
      	istate->updated_workdir = 0;
      	istate->updated_skipworktree = 0;
18:  e4ef3f4548a ! 19:  893f8666301 receive-pack: convert push-to-checkout hook to hook.h
    @@ Metadata
      ## Commit message ##
         receive-pack: convert push-to-checkout hook to hook.h
     
    -    By using hook.h instead of run-command.h to invoke push-to-checkout,
    -    hooks can now be specified in the config as well as in the hookdir.
    -    push-to-checkout is not called anywhere but in builtin/receive-pack.c.
    +    Move the push-to-checkout hook away from run-command.h to and over to
    +    the new hook.h library.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/receive-pack.c: static const char *push_to_checkout(unsigned char *hash,
     -			hash_to_hex(hash), NULL))
     +	strvec_pushv(&opt.env, env->v);
     +	strvec_push(&opt.args, hash_to_hex(hash));
    -+	if (run_hooks(push_to_checkout_hook, &opt)) {
    -+		run_hooks_opt_clear(&opt);
    ++	if (run_hooks_oneshot(push_to_checkout_hook, &opt))
      		return "push-to-checkout hook declined";
    --	else
    -+	} else {
    -+		run_hooks_opt_clear(&opt);
    - 		return NULL;
    -+	}
    - }
    - 
    - static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
    -@@ builtin/receive-pack.c: static const char *update_worktree(unsigned char *sha1, const struct worktree *w
    - 
    - 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
    - 
    --	if (!find_hook(push_to_checkout_hook))
    -+	if (!hook_exists(push_to_checkout_hook))
    - 		retval = push_to_deploy(sha1, &env, work_tree);
      	else
    - 		retval = push_to_checkout(sha1, &env, work_tree);
    + 		return NULL;
19:  e3dda367ec9 = 20:  070433deba5 run-command: remove old run_hook_{le,ve}() hook API
20:  477d75bf579 = 21:  1028e0c1667 run-command: allow stdin for run_processes_parallel
21:  b7c0ee9719a ! 22:  639e59e9ed0 hook: support passing stdin to hooks
    @@ Documentation/git-hook.txt: what those are.
     
      ## builtin/hook.c ##
     @@
    + #include "strvec.h"
      
    - static const char * const builtin_hook_usage[] = {
    - 	N_("git hook <command> [...]"),
    --	N_("git hook run <hook-name> [-- <hook-args>]"),
    -+	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
    - 	NULL
    - };
    - 
    - static const char * const builtin_hook_run_usage[] = {
    - 	N_("git hook run <hook-name> [-- <hook-args>]"),
    -+	N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]"),
    - 	NULL
    - };
    + #define BUILTIN_HOOK_RUN_USAGE \
    +-	N_("git hook run [--ignore-missing] <hook-name> [-- <hook-args>]")
    ++	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
      
    + static const char * const builtin_hook_usage[] = {
    + 	BUILTIN_HOOK_RUN_USAGE,
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	struct option run_options[] = {
      		OPT_BOOL(0, "ignore-missing", &ignore_missing,
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
     +			   N_("file to read into hooks' stdin")),
      		OPT_END(),
      	};
    - 
    + 	int ret;
     
      ## hook.c ##
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
    - 	struct hook_cb_data *hook_cb = pp_cb;
    - 	struct hook *run_me = hook_cb->run_me;
    + 	if (!run_me)
    + 		return 0;
      
     -	cp->no_stdin = 1;
    -+
     +	/* reopen the file for stdin; run_command closes it. */
     +	if (hook_cb->options->path_to_stdin) {
     +		cp->no_stdin = 0;
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    + 
      	/* Path to initial working directory for subprocess */
      	const char *dir;
    - 
    ++
     +	/* Path to file which should be piped to stdin for each hook */
     +	const char *path_to_stdin;
      };
22:  4035069a98c ! 23:  7d1925cca48 am: convert 'post-rewrite' hook to hook.h
    @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
      {
     -	struct child_process cp = CHILD_PROCESS_INIT;
     -	const char *hook = find_hook("post-rewrite");
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    - 	int ret;
    - 
    +-	int ret;
    +-
     -	if (!hook)
     -		return 0;
     -
    @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
     -	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
     -	cp.stdout_to_stderr = 1;
     -	cp.trace2_hook_name = "post-rewrite";
    -+	strvec_push(&opt.args, "rebase");
    -+	opt.path_to_stdin = am_path(state, "rewritten");
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
      
     -	ret = run_command(&cp);
    -+	ret = run_hooks("post-rewrite", &opt);
    ++	strvec_push(&opt.args, "rebase");
    ++	opt.path_to_stdin = am_path(state, "rewritten");
      
     -	close(cp.in);
    -+	run_hooks_opt_clear(&opt);
    - 	return ret;
    +-	return ret;
    ++	return run_hooks_oneshot("post-rewrite", &opt);
      }
      
    + /**
23:  c847a19581a ! 24:  0c24221b522 run-command: add stdin callback for parallelization
    @@ builtin/submodule--helper.c: static int update_submodules(struct submodule_updat
      
     
      ## hook.c ##
    -@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    - 	run_processes_parallel_tr2(options->jobs,
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
    + 	run_processes_parallel_tr2(jobs,
      				   pick_next_hook,
      				   notify_start_failure,
     +				   NULL,
    @@ run-command.h: typedef int (*task_finished_fn)(int result,
     +			       feed_pipe_fn, task_finished_fn, void *pp_cb,
      			       const char *tr2_category, const char *tr2_label);
      
    - #endif
    + /**
     
      ## submodule.c ##
     @@ submodule.c: int fetch_populated_submodules(struct repository *r,
24:  da46c859c1c ! 25:  05d1085f7eb hook: provide stdin by string_list or callback
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	} else {
      		cp->no_stdin = 1;
      	}
    -@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    - 	run_processes_parallel_tr2(options->jobs,
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
    + 	run_processes_parallel_tr2(jobs,
      				   pick_next_hook,
      				   notify_start_failure,
     -				   NULL,
    @@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
      				   notify_hook_finished,
      				   &cb_data,
      				   "hook",
    -@@ hook.c: int run_hooks(const char *hook_name, struct run_hooks_opt *options)
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
    + 
    + 	if (options->absolute_path)
    + 		strbuf_release(&abs_path);
    ++	free(my_hook.feed_pipe_cb_data);
    + 
    + 	return cb_data.rc;
    + }
    +@@ hook.c: int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
      	if (!options)
    - 		BUG("a struct run_hooks_opt must be provided to run_hooks");
    + 		options = &hook_opt_scratch;
      
     +	if (options->path_to_stdin && options->feed_pipe)
     +		BUG("choose only one method to populate stdin");
     +
      	hook_path = find_hook(hook_name);
    - 
    - 	/*
    + 	if (!hook_path) {
    + 		ret = 0;
     
      ## hook.h ##
     @@ hook.h: int hook_exists(const char *hookname);
    @@ hook.h: struct run_hooks_opt
     + */
     +int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb);
     +
    - struct hook_cb_data {
    - 	/* rc reflects the cumulative failure state */
    - 	int rc;
    + /*
    +  * Callback provided to feed_pipe_fn and consume_sideband_fn.
    +  */
25:  7343be28ef4 ! 26:  4b7175af2e5 hook: convert 'post-rewrite' hook in sequencer.c to hook.h
    @@ sequencer.c: int update_head_with_reflog(const struct commit *old_head,
     +	opt.feed_pipe = pipe_from_string_list;
     +	opt.feed_pipe_ctx = &to_stdin;
     +
    -+	code = run_hooks("post-rewrite", &opt);
    ++	code = run_hooks_oneshot("post-rewrite", &opt);
     +
    -+	run_hooks_opt_clear(&opt);
     +	strbuf_release(&tmp);
     +	string_list_clear(&to_stdin, 0);
     +	return code;
    @@ sequencer.c: static int pick_commits(struct repository *r,
     +
     +			hook_opt.path_to_stdin = rebase_path_rewritten_list();
     +			strvec_push(&hook_opt.args, "rebase");
    -+			run_hooks("post-rewrite", &hook_opt);
    -+			run_hooks_opt_clear(&hook_opt);
    ++			run_hooks_oneshot("post-rewrite", &hook_opt);
      		}
      		apply_autostash(rebase_path_autostash());
      
26:  85bf13a0835 ! 27:  3f24e056410 transport: convert pre-push hook to use config
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    transport: convert pre-push hook to use config
    +    transport: convert pre-push hook to hook.h
     
    -    By using the hook.h:run_hooks API, pre-push hooks can be specified in
    -    the config as well as in the hookdir.
    +    Move the pre-push hook away from run-command.h to and over to the new
    +    hook.h library.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
     -	int ret = 0, x;
     +	int ret = 0;
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	struct strbuf tmp = STRBUF_INIT;
      	struct ref *r;
     -	struct child_process proc = CHILD_PROCESS_INIT;
     -	struct strbuf buf;
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
     -		finish_command(&proc);
     -		return -1;
     -	}
    --
    --	sigchain_push(SIGPIPE, SIG_IGN);
    -+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
    ++	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
      
    +-	sigchain_push(SIGPIPE, SIG_IGN);
    +-
     -	strbuf_init(&buf, 256);
     +	strvec_push(&opt.args, transport->remote->name);
     +	strvec_push(&opt.args, transport->url);
      
      	for (r = remote_refs; r; r = r->next) {
    ++		struct strbuf buf = STRBUF_INIT;
    ++
      		if (!r->peer_ref) continue;
    -@@ transport.c: static int run_pre_push_hook(struct transport *transport,
    + 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
    + 		if (r->status == REF_STATUS_REJECT_STALE) continue;
      		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
      		if (r->status == REF_STATUS_UPTODATE) continue;
      
     -		strbuf_reset(&buf);
     -		strbuf_addf( &buf, "%s %s %s %s\n",
    -+		strbuf_reset(&tmp);
    -+		strbuf_addf(&tmp, "%s %s %s %s",
    ++		strbuf_addf(&buf, "%s %s %s %s",
      			 r->peer_ref->name, oid_to_hex(&r->new_oid),
      			 r->name, oid_to_hex(&r->old_oid));
     -
    @@ transport.c: static int run_pre_push_hook(struct transport *transport,
     -				ret = -1;
     -			break;
     -		}
    -+		string_list_append(&to_stdin, tmp.buf);
    ++		string_list_append(&to_stdin, strbuf_detach(&buf, NULL));
      	}
      
     -	strbuf_release(&buf);
    @@ transport.c: static int run_pre_push_hook(struct transport *transport,
     -	x = finish_command(&proc);
     -	if (!ret)
     -		ret = x;
    -+	ret = run_hooks("pre-push", &opt);
    -+	run_hooks_opt_clear(&opt);
    -+	strbuf_release(&tmp);
    ++	ret = run_hooks_oneshot("pre-push", &opt);
    ++	to_stdin.strdup_strings = 1;
     +	string_list_clear(&to_stdin, 0);
      
      	return ret;
 -:  ----------- > 28:  ecf75f33233 hook tests: test for exact "pre-push" hook input
 -:  ----------- > 29:  2c961be94b4 hook tests: use a modern style for "pre-push" tests
27:  331014bad17 ! 30:  1ce456f9d9d reference-transaction: use hook.h to run hooks
    @@ refs.c: int ref_update_reject_duplicates(struct string_list *refnames,
      				const char *state)
      {
     -	struct child_process proc = CHILD_PROCESS_INIT;
    - 	struct strbuf buf = STRBUF_INIT;
    +-	struct strbuf buf = STRBUF_INIT;
     -	const char *hook;
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
    ++	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
      	int ret = 0, i;
    -+	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
      
     -	hook = find_hook("reference-transaction");
     -	if (!hook)
    -+	if (!hook_exists("reference-transaction"))
    - 		return ret;
    - 
    +-		return ret;
    +-
     -	strvec_pushl(&proc.args, hook, state, NULL);
     -	proc.in = -1;
     -	proc.stdout_to_stderr = 1;
    @@ refs.c: int ref_update_reject_duplicates(struct string_list *refnames,
     -
     -	ret = start_command(&proc);
     -	if (ret)
    --		return ret;
    --
    ++	if (!hook_exists("reference-transaction"))
    + 		return ret;
    + 
     -	sigchain_push(SIGPIPE, SIG_IGN);
     +	strvec_push(&opt.args, state);
      
      	for (i = 0; i < transaction->nr; i++) {
      		struct ref_update *update = transaction->updates[i];
    -+		oid_to_hex_r(o, &update->old_oid);
    -+		oid_to_hex_r(n, &update->new_oid);
    ++		struct strbuf buf = STRBUF_INIT;
      
    - 		strbuf_reset(&buf);
    +-		strbuf_reset(&buf);
     -		strbuf_addf(&buf, "%s %s %s\n",
    --			    oid_to_hex(&update->old_oid),
    --			    oid_to_hex(&update->new_oid),
    --			    update->refname);
    ++		strbuf_addf(&buf, "%s %s %s",
    + 			    oid_to_hex(&update->old_oid),
    + 			    oid_to_hex(&update->new_oid),
    + 			    update->refname);
     -
     -		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
     -			if (errno != EPIPE)
     -				ret = -1;
     -			break;
     -		}
    -+		strbuf_addf(&buf, "%s %s %s", o, n, update->refname);
    -+		string_list_append(&to_stdin, buf.buf);
    ++		string_list_append(&to_stdin, strbuf_detach(&buf, NULL));
      	}
      
     -	close(proc.in);
     -	sigchain_pop(SIGPIPE);
    +-	strbuf_release(&buf);
     +	opt.feed_pipe = pipe_from_string_list;
     +	opt.feed_pipe_ctx = &to_stdin;
     +
    -+	ret = run_hooks("reference-transaction", &opt);
    -+	run_hooks_opt_clear(&opt);
    - 	strbuf_release(&buf);
    ++	ret = run_hooks_oneshot("reference-transaction", &opt);
    ++	to_stdin.strdup_strings = 1;
     +	string_list_clear(&to_stdin, 0);
      
     -	ret |= finish_command(&proc);
28:  f7f56d0a3bb ! 31:  6e5f1f5bd3a run-command: allow capturing of collated output
    @@ builtin/submodule--helper.c: static int update_submodules(struct submodule_updat
      
     
      ## hook.c ##
    -@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
      				   pick_next_hook,
      				   notify_start_failure,
      				   options->feed_pipe,
    @@ run-command.h: int run_processes_parallel(int n,
     +			       task_finished_fn, void *pp_cb,
      			       const char *tr2_category, const char *tr2_label);
      
    - #endif
    + /**
     
      ## submodule.c ##
     @@ submodule.c: int fetch_populated_submodules(struct repository *r,
29:  7f7fcc06885 ! 32:  0b6e9c6d07a hooks: allow callers to capture output
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## hook.c ##
    -@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
      				   pick_next_hook,
      				   notify_start_failure,
      				   options->feed_pipe,
    @@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
      				   notify_hook_finished,
      				   &cb_data,
      				   "hook",
    + 				   hook_name);
    + 
    ++
    + 	if (options->absolute_path)
    + 		strbuf_release(&abs_path);
    + 	free(my_hook.feed_pipe_cb_data);
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
30:  e74d49e5593 ! 33:  dcf63634338 receive-pack: convert 'update' hook to hook.h
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +static int run_update_hook(struct command *cmd)
     +{
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	int code;
     +
     +	strvec_pushl(&opt.args,
     +		     cmd->ref_name,
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     -	return finish_command(&proc);
     +		opt.consume_sideband = hook_output_to_sideband;
     +
    -+	code = run_hooks("update", &opt);
    -+	run_hooks_opt_clear(&opt);
    -+	return code;
    ++	return run_hooks_oneshot("update", &opt);
      }
      
      static struct command *find_command_by_refname(struct command *list,
31:  0bdc4878ac8 ! 34:  f352a485e59 post-update: use hook.h library
    @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
     -			copy_to_sideband(proc.err, -1, NULL);
     -		finish_command(&proc);
     -	}
    -+	run_hooks("post-update", &opt);
    -+	run_hooks_opt_clear(&opt);
    ++	run_hooks_oneshot("post-update", &opt);
      }
      
      static void check_aliased_update_internal(struct command *cmd,
32:  db70b59b3bd ! 35:  ceef2f3e804 receive-pack: convert receive hooks to hook.h
    @@ builtin/receive-pack.c: static void hook_output_to_sideband(struct strbuf *outpu
     +{
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	struct receive_hook_feed_context ctx;
    -+	int rc;
     +	struct command *iter = commands;
     +
     +	/* if there are no valid commands, don't invoke the hook at all. */
    @@ builtin/receive-pack.c: static void hook_output_to_sideband(struct strbuf *outpu
     +	if (!iter)
     +		return 0;
     +
    -+	/* pre-receive hooks should run in series as the hook updates refs */
    -+	if (!strcmp(hook_name, "pre-receive"))
    -+		opt.jobs = 1;
    -+
     +	if (push_options) {
     +		int i;
     +		for (i = 0; i < push_options->nr; i++)
    @@ builtin/receive-pack.c: static void hook_output_to_sideband(struct strbuf *outpu
     +	opt.feed_pipe = feed_receive_hook_cb;
     +	opt.feed_pipe_ctx = &ctx;
     +
    -+	rc = run_hooks(hook_name, &opt);
    -+	run_hooks_opt_clear(&opt);
    -+	return rc;
    ++	return run_hooks_oneshot(hook_name, &opt);
     +}
     +
      static int run_update_hook(struct command *cmd)
33:  d86fedf041c ! 36:  b71d7628b40 hooks: fix a TOCTOU in "did we run a hook?" heuristic
    @@ hook.c: static int notify_hook_finished(int result,
     +	if (hook_cb->invoked_hook)
     +		*hook_cb->invoked_hook = 1;
     +
    - 	return 1;
    + 	return 0;
      }
      
    -@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    +@@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
      		.rc = 0,
      		.hook_name = hook_name,
      		.options = options,
     +		.invoked_hook = options->invoked_hook,
      	};
    - 	if (options->absolute_path) {
    - 		strbuf_add_absolute_path(&abs_path, hook_path);
    + 	int jobs = 1;
    + 
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
-- 
2.33.0.rc0.595.ge31e012651d

