Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497F5C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E602B613DA
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhE1MN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhE1MNV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD076C061761
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z17so3081727wrq.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTVbZXgRxlqhR2DS5qjOlkOa3hp/mGSB4OSCG90absM=;
        b=TwActfOCwzLMq1zCEhmixOi737hN8Xdq/hJ50pyIWBc+uD59ittu4pKpmd91u/WRgp
         5eCHXAU8fVwPb0z0ltKKBN1+fCRuTF9kIymEfO1xl8sxyTHF32QheP4RiKQpGZKY19eZ
         iRQ9ahU0jy1x2O+ynJZhUkV1jStlk+YQAPRo3VZ/OIKAQml15wlfVRpaAfsA2miIuT8n
         4c2oJBjCFP87NaJW/iRHdtDBa/wWXZKo09n3ta4As2XTOH5FFNovR1NtjJ5ERFyMP33t
         QY4AwaN9Xwo1+pN8eGf6ZbKQeDf8scn3AGRA4+oOn43oH3+gwNOfsqrSgKdQ1L2RVIFp
         bQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTVbZXgRxlqhR2DS5qjOlkOa3hp/mGSB4OSCG90absM=;
        b=uAGGm9/e+9TvpfZldscKnLYJlbShZaS1GGYkobWeSRH3DpSKVpri0hm8hV+T6y02NJ
         Fc+xZjL0pvUi/5+uLWvVJE0PKqcTGCX947ecFNVIzVs6u+cBw12+wbr5Cbvjeo4O6hhd
         V08KNXWWP/UcxqC78i8NkAersKvaFOhtCcTh6+kfn27EYfJfO6VBPPKtRkCzejkPL6uz
         63GeIngs/zEqS1b+hSPT4xvJEQvwPBxUYEnyyG1cY6ObUUry5jqAHZzfj44rcqUI1Z7Q
         YaQo5e9+MnOncCjBv2X9FXG9xZohHh6Wdo7xz20MSS9/KbrGhBrfNDWOQpnsslJG72Qn
         B5Mg==
X-Gm-Message-State: AOAM530nJZQuTcpSVm2cDJX3rU4RjVajistb13UPP+1L4IzoQoKW6pbF
        f/ngVOVB21A2FauSwl1rHMRz1L4I48BA3A==
X-Google-Smtp-Source: ABdhPJw7asJwk/PTADrhUP4/IX2bF1fAWYxE+TED5X650ZflYlGd+pjiSwDstrpGaprngf3SFEOCrQ==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr8222044wrv.354.1622203900847;
        Fri, 28 May 2021 05:11:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:40 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/31] minimal restart of "config-based-hooks"
Date:   Fri, 28 May 2021 14:11:02 +0200
Message-Id: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <87lf80l1m6.fsf@evledraar.gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After suggesting[1] an another round that the config-based-hook
topic[2] should take a more incremental approach to reach its end goal
I thought I'd try hacking that up.

So this is a proposed restart of that topic which if the consensus
favors it should replace it, and the config-based hooks topic should
be rebased on top of this.

As noted in [1] there are no user-visible behavior changes here. All
that's being done is to consolidate hook dispatch into the new
hook.[ch] library, and the "git hook run" command (used by
git-send-email and git-p4).

The range-diff below is scary, I recommend just reading this from
scratch. Some incomplete notes on changed things from Emily's v9:

 * First off, we've gone from:

    54 files changed, 2689 insertions(+), 713 deletions(-)

   to:

    41 files changed, 1293 insertions(+), 555 deletions(-)

   So while there's a similar number of patches the change is much
   smaller.

 * There's no config via hooks, design doc etc. in this series. It's
   meant as a basis on which to build that. We still only support
   running .git/hook/<hook>, and we run those with .jobs=1 by
   definition.

 * There's absolutely no behavior change in how we run these hooks,
   unlike in Emily's version. E.g. in hers sometimes we'd always pass
   absolute paths when before we didn't, now we just do that for "git
   worktree" via a flag as on the current "master". There were also
   some other subtle changes as seen in the tests. Now the only test
   changes are the addition of more and missing tests.

   Some of this (e.g. git-send-email's insistance on GIT_DIR being
   set) is something we'll probably need to change sooner than later,
   but for now we've got bug-for-bug compatibility.

 * This has been re-arranged as much as possible to start using
   minimal bits of the library as soon as we can. E.g. in Emily's the
   whole of hook.c is implemented before any hook is migrated over to
   it.

   In this version we barely know how to do anything yet (no stdin
   handling etc.) when we can move the pre-auto-gc hook over, we then
   do a few more hooks and add stdin support, migrate the hooks that
   need that etc.

 * In Emily's there's a mid-series switch from the run_command() API
   to run_processes_parallel_tr2() as we learn parallel execution. I
   thought this was more complex to read and just reflected the past
   evolution of the topic.

   That's now squashed together, we always have the parallel API use,
   we just have .jobs=1 throughout.

 * I tried as much as possible to similarly squash together
   e.g. removing an unused API along with the commit that removes the
   last user of it, not introducing APIs without simultaneously
   introducing users of them etc.

 * The "git hook run" command now takes arguments as:

        git hook run a-hook -- some arg u ments

   Not:

        git hook run -a some -a arg -a u -a ments a-hook

    The "-e" for "pass this env variable" is also gone, nothing
    actually made use of it.

    If we need it in the future surely we can just set them in the
    environment instead, and ask the relevant command run APIs not to
    clobber things.

    I think the -- (or --end-of-options) is easier to work
    with. Changing this allowed removing the whole
    parse-options-strvec part of Emily's series. It's now replaced
    with PARSE_OPT_KEEP_DASHDASH + 2-4 lines of code around that in
    builtin/hook.c.

 * Even though this extracted the "config based hooks" part, and .jobs
   != 1 support I've tried as much as possible to keep the same code
   layout, to the point where hooks e.g. set .jobs=1 still if they
   insist that one job should be run. It should thus be fairly drop-in
   compatible for building .jobs > 1 support on top, config-based hooks
   etc.

 * The two last patches are new, a couple of minor bugfixes of mine
   that I noticed while hacking on this. One solves a long-standing
   TOCTOU in run_a_hook() and then have_hook() to see if we ran it (we
   now just remember if we ran it), and there's now a generated and
   canonical hook-list.h similar to config-list.h, except this one's
   more strict. We'll die on unknown hooks unless they're in
   Documentation/githooks.txt.

1. https://lore.kernel.org/git/87lf80l1m6.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/20210527000856.695702-1-emilyshaffer@google.com/

Emily Shaffer (25):
  hook: add 'run' subcommand
  hook.c: add a hook_exists() wrapper and use it in bugreport.c
  gc: use hook library for pre-auto-gc hook
  rebase: teach pre-rebase to use hook.h
  am: convert applypatch hooks to use config
  hooks: convert 'post-checkout' hook to hook library
  merge: use config-based hooks for post-merge hook
  send-email: use 'git hook run' for 'sendemail-validate'
  git-p4: use 'git hook' to run hooks
  commit: use hook.h to execute hooks
  read-cache: convert post-index-change hook to use config
  receive-pack: convert push-to-checkout hook to hook.h
  run-command: allow stdin for run_processes_parallel
  hook: support passing stdin to hooks
  am: convert 'post-rewrite' hook to hook.h
  run-command: add stdin callback for parallelization
  hook: provide stdin by string_list or callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook.h
  transport: convert pre-push hook to use config
  reference-transaction: use hook.h to run hooks
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  receive-pack: convert 'update' hook to hook.h
  post-update: use hook.h library
  receive-pack: convert receive hooks to hook.h

Ævar Arnfjörð Bjarmason (6):
  hooks tests: don't leave "actual" nonexisting on failure
  gc tests: add a test for the "pre-auto-gc" hook
  run-command.h: move find_hook() to hook.h
  git hook run: add an --ignore-missing flag
  hooks: fix a TOCTOU in "did we run a hook?" heuristic
  hook-list.h: add a generated list of hooks, like config-list.h

 .gitignore                   |   2 +
 Documentation/git-hook.txt   |  49 ++++++
 Documentation/githooks.txt   |   4 +
 Makefile                     |  16 +-
 builtin.h                    |   1 +
 builtin/am.c                 |  34 ++--
 builtin/bugreport.c          |  46 ++----
 builtin/checkout.c           |  17 +-
 builtin/clone.c              |   7 +-
 builtin/commit.c             |  19 ++-
 builtin/fetch.c              |   1 +
 builtin/gc.c                 |   8 +-
 builtin/hook.c               |  72 +++++++++
 builtin/merge.c              |  22 ++-
 builtin/rebase.c             |   9 +-
 builtin/receive-pack.c       | 299 ++++++++++++++++++-----------------
 builtin/submodule--helper.c  |   2 +-
 builtin/worktree.c           |  31 ++--
 command-list.txt             |   1 +
 commit.c                     |  17 +-
 commit.h                     |   3 +-
 generate-hooklist.sh         |  20 +++
 git-p4.py                    |  72 +--------
 git-send-email.perl          |  20 ++-
 git.c                        |   1 +
 hook.c                       | 224 ++++++++++++++++++++++++++
 hook.h                       | 122 ++++++++++++++
 read-cache.c                 |  12 +-
 refs.c                       |  43 ++---
 reset.c                      |  15 +-
 run-command.c                | 157 +++++++++---------
 run-command.h                |  55 ++++---
 sequencer.c                  |  88 +++++------
 submodule.c                  |   1 +
 t/helper/test-run-command.c  |  46 +++++-
 t/t0061-run-command.sh       |  37 +++++
 t/t1350-config-hooks-path.sh |   1 +
 t/t1800-hook.sh              | 166 +++++++++++++++++++
 t/t6500-gc.sh                |  46 ++++++
 t/t9001-send-email.sh        |   4 +-
 transport.c                  |  58 ++-----
 41 files changed, 1293 insertions(+), 555 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 generate-hooklist.sh
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1800-hook.sh

Range-diff:
 1:  9540c006dc0 <  -:  ----------- doc: propose hooks managed by the config
 -:  ----------- >  1:  8ac2efc71a0 hooks tests: don't leave "actual" nonexisting on failure
 -:  ----------- >  2:  eb37693f7dc gc tests: add a test for the "pre-auto-gc" hook
 2:  2f50cfe7b92 !  3:  1ad4e69f7da hook: introduce git-hook subcommand
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    hook: introduce git-hook subcommand
    +    hook: add 'run' subcommand
     
    -    Add a new subcommand, git-hook, which will be used to ease config-based
    -    hook management. This command will handle parsing configs to compose a
    -    list of hooks to run for a given event, as well as adding or modifying
    -    hook configs in an interactive fashion.
    +    In order to enable hooks to be run as an external process, by a
    +    standalone Git command, or by tools which wrap Git, provide an external
    +    means to run all configured hook commands for a given hook event.
     
    -    Start with 'git hook list <hookname>', which checks the known configs in
    -    order to create an ordered list of hooks to run on a given hook event.
    -
    -    Multiple commands can be specified for a given hook by providing
    -    multiple "hook.<hookname>.command = <path-to-hook>" lines. Hooks will be
    -    run in config order. If more properties need to be set on a given hook
    -    in the future, commands can also be specified by providing
    -    "hook.<hookname>.command = <hookcmd-name>", as well as a "[hookcmd
    -    <hookcmd-name>]" subsection; this subsection should contain a
    -    "hookcmd.<hookcmd-name>.command = <path-to-hook>" line.
    -
    -    For example:
    -
    -      $ git config --list | grep ^hook
    -      hook.pre-commit.command=baz
    -      hook.pre-commit.command=~/bar.sh
    -      hookcmd.baz.command=~/baz/from/hookcmd.sh
    -
    -      $ git hook list pre-commit
    -      global: ~/baz/from/hookcmd.sh
    -      local: ~/bar.sh
    +    Most of our hooks require more complex functionality than this, but
    +    let's start with the bare minimum required to support our simplest
    +    hooks.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .gitignore ##
     @@
    @@ .gitignore
      /git-http-fetch
      /git-http-push
     
    - ## Documentation/config/hook.txt (new) ##
    -@@
    -+hook.<command>.command::
    -+	A command to execute during the <command> hook event. This can be an
    -+	executable on your device, a oneliner for your shell, or the name of a
    -+	hookcmd. See linkgit:git-hook[1].
    -+
    -+hookcmd.<name>.command::
    -+	A command to execute during a hook for which <name> has been specified
    -+	as a command. This can be an executable on your device or a oneliner for
    -+	your shell. See linkgit:git-hook[1].
    -
      ## Documentation/git-hook.txt (new) ##
     @@
     +git-hook(1)
    @@ Documentation/git-hook.txt (new)
     +
     +NAME
     +----
    -+git-hook - Manage configured hooks
    ++git-hook - run git hooks
     +
     +SYNOPSIS
     +--------
     +[verse]
    -+'git hook' list <hook-name>
    ++'git hook' run <hook-name> [-- <hook-args>]
     +
     +DESCRIPTION
     +-----------
    -+You can list configured hooks with this command. Later, you will be able to run,
    -+add, and modify hooks with this command.
    -+
    -+This command parses the default configuration files for sections `hook` and
    -+`hookcmd`. `hook` is used to describe the commands which will be run during a
    -+particular hook event; commands are run in the order Git encounters them during
    -+the configuration parse (see linkgit:git-config[1]). `hookcmd` is used to
    -+describe attributes of a specific command. If additional attributes don't need
    -+to be specified, a command to run can be specified directly in the `hook`
    -+section; if a `hookcmd` by that name isn't found, Git will attempt to run the
    -+provided value directly. For example:
    -+
    -+Global config
    -+----
    -+  [hook "post-commit"]
    -+    command = "linter"
    -+    command = "~/typocheck.sh"
     +
    -+  [hookcmd "linter"]
    -+    command = "/bin/linter --c"
    -+----
    ++This command is an interface to git hooks (see linkgit:githooks[5]).
    ++Currently it only provides a convenience wrapper for running hooks for
    ++use by git itself. In the future it might gain other functionality.
     +
    -+Local config
    -+----
    -+  [hook "prepare-commit-msg"]
    -+    command = "linter"
    -+  [hook "post-commit"]
    -+    command = "python ~/run-test-suite.py"
    -+----
    ++SUBCOMMANDS
    ++-----------
     +
    -+With these configs, you'd then see:
    ++run::
     +
    -+----
    -+$ git hook list "post-commit"
    -+global: /bin/linter --c
    -+global: ~/typocheck.sh
    -+local: python ~/run-test-suite.py
    ++	Run the `<hook-name>` hook. Any positional arguments to the
    ++	hook should be passed after an optional "--" (or
    ++	"--end-of-options"). See "OPTIONS" below for the arguments
    ++	this accepts.
     +
    -+$ git hook list "prepare-commit-msg"
    -+local: /bin/linter --c
    -+----
    -+
    -+COMMANDS
    ++SEE ALSO
     +--------
    -+
    -+list `<hook-name>`::
    -+
    -+List the hooks which have been configured for `<hook-name>`. Hooks appear
    -+in the order they should be run, and print the config scope where the relevant
    -+`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
    -+This output is human-readable and the format is subject to change over time.
    -+
    -+CONFIGURATION
    -+-------------
    -+include::config/hook.txt[]
    ++linkgit:githooks[5]
     +
     +GIT
     +---
     +Part of the linkgit:git[1] suite
     
    + ## Documentation/githooks.txt ##
    +@@ Documentation/githooks.txt: and "0" meaning they were not.
    + Only one parameter should be set to "1" when the hook runs.  The hook
    + running passing "1", "1" should not be possible.
    + 
    ++SEE ALSO
    ++--------
    ++linkgit:git-hook[1]
    ++
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
    +
      ## Makefile ##
     @@ Makefile: LIB_OBJS += hash-lookup.o
      LIB_OBJS += hashmap.o
    @@ builtin/hook.c (new)
     +#include "hook.h"
     +#include "parse-options.h"
     +#include "strbuf.h"
    ++#include "strvec.h"
     +
     +static const char * const builtin_hook_usage[] = {
    -+	N_("git hook list <hookname>"),
    ++	N_("git hook run <hook-name> [-- <hook-args>]"),
     +	NULL
     +};
     +
    -+static int list(int argc, const char **argv, const char *prefix)
    ++static int run(int argc, const char **argv, const char *prefix)
     +{
    -+	struct list_head *head, *pos;
    -+	const char *hookname = NULL;
    ++	int i;
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    ++	int rc = 0;
    ++	const char *hook_name;
    ++	const char *hook_path;
     +
    -+	struct option list_options[] = {
    ++	struct option run_options[] = {
     +		OPT_END(),
     +	};
     +
    -+	argc = parse_options(argc, argv, prefix, list_options,
    -+			     builtin_hook_usage, 0);
    -+
    -+	if (argc < 1) {
    -+		usage_msg_opt(_("You must specify a hook event name to list."),
    -+			      builtin_hook_usage, list_options);
    ++	argc = parse_options(argc, argv, prefix, run_options,
    ++			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
    ++
    ++	if (argc > 2) {
    ++		if (strcmp(argv[2], "--") &&
    ++		    strcmp(argv[2], "--end-of-options"))
    ++			/* Having a -- for "run" is mandatory */
    ++			usage_with_options(builtin_hook_usage, run_options);
    ++		/* Add our arguments, start after -- */
    ++		for (i = 3 ; i < argc; i++)
    ++			strvec_push(&opt.args, argv[i]);
     +	}
     +
    -+	hookname = argv[0];
    -+
    -+	head = hook_list(hookname);
    -+
    -+	if (list_empty(head)) {
    -+		printf(_("no commands configured for hook '%s'\n"),
    -+		       hookname);
    -+		return 0;
    -+	}
    ++	/* Need to take into account core.hooksPath */
    ++	git_config(git_default_config, NULL);
     +
    -+	list_for_each(pos, head) {
    -+		struct hook *item = list_entry(pos, struct hook, list);
    -+		if (item)
    -+			printf("%s: %s\n",
    -+			       config_scope_name(item->origin),
    -+			       item->command.buf);
    ++	hook_name = argv[1];
    ++	hook_path = find_hook(hook_name);
    ++	if (!hook_path) {
    ++		error("cannot find a hook named %s", hook_name);
    ++		return 1;
     +	}
    ++	rc = run_found_hooks(hook_name, hook_path, &opt);
     +
    -+	clear_hook_list(head);
    ++	run_hooks_opt_clear(&opt);
     +
    -+	return 0;
    ++	return rc;
     +}
     +
     +int cmd_hook(int argc, const char **argv, const char *prefix)
    @@ builtin/hook.c (new)
     +	struct option builtin_hook_options[] = {
     +		OPT_END(),
     +	};
    -+	if (argc < 2)
    -+		usage_with_options(builtin_hook_usage, builtin_hook_options);
    -+
    -+	if (!strcmp(argv[1], "list"))
    -+		return list(argc - 1, argv + 1, prefix);
     +
    ++	if (!strcmp(argv[1], "run"))
    ++		return run(argc, argv, prefix);
     +	usage_with_options(builtin_hook_usage, builtin_hook_options);
    ++	return 1;
     +}
     
      ## command-list.txt ##
    @@ git.c: static struct cmd_struct commands[] = {
      	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
      	{ "hash-object", cmd_hash_object },
      	{ "help", cmd_help },
    -+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
    ++	{ "hook", cmd_hook, RUN_SETUP },
      	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
      	{ "init", cmd_init_db },
      	{ "init-db", cmd_init_db },
    @@ git.c: static struct cmd_struct commands[] = {
      ## hook.c (new) ##
     @@
     +#include "cache.h"
    -+
     +#include "hook.h"
    -+#include "config.h"
    ++#include "run-command.h"
     +
    -+void free_hook(struct hook *ptr)
    ++void run_hooks_opt_clear(struct run_hooks_opt *o)
     +{
    -+	if (ptr) {
    -+		strbuf_release(&ptr->command);
    -+		free(ptr);
    -+	}
    ++	strvec_clear(&o->env);
    ++	strvec_clear(&o->args);
     +}
     +
    -+static void append_or_move_hook(struct list_head *head, const char *command)
    ++static int pick_next_hook(struct child_process *cp,
    ++			  struct strbuf *out,
    ++			  void *pp_cb,
    ++			  void **pp_task_cb)
     +{
    -+	struct list_head *pos = NULL, *tmp = NULL;
    -+	struct hook *to_add = NULL;
    ++	struct hook_cb_data *hook_cb = pp_cb;
    ++	struct hook *run_me = hook_cb->run_me;
    ++
    ++	if (!run_me)
    ++		BUG("did we not return 1 in notify_hook_finished?");
    ++
    ++	cp->no_stdin = 1;
    ++	cp->env = hook_cb->options->env.v;
    ++	cp->stdout_to_stderr = 1;
    ++	cp->trace2_hook_name = hook_cb->hook_name;
    ++
    ++	/* add command */
    ++	strvec_push(&cp->args, run_me->hook_path);
     +
     +	/*
    -+	 * remove the prior entry with this command; we'll replace it at the
    -+	 * end.
    ++	 * add passed-in argv, without expanding - let the user get back
    ++	 * exactly what they put in
     +	 */
    -+	list_for_each_safe(pos, tmp, head) {
    -+		struct hook *it = list_entry(pos, struct hook, list);
    -+		if (!strcmp(it->command.buf, command)) {
    -+		    list_del(pos);
    -+		    /* we'll simply move the hook to the end */
    -+		    to_add = it;
    -+		    break;
    -+		}
    -+	}
    -+
    -+	if (!to_add) {
    -+		/* adding a new hook, not moving an old one */
    -+		to_add = xmalloc(sizeof(*to_add));
    -+		strbuf_init(&to_add->command, 0);
    -+		strbuf_addstr(&to_add->command, command);
    -+	}
    ++	strvec_pushv(&cp->args, hook_cb->options->args.v);
     +
    -+	/* re-set the scope so we show where an override was specified */
    -+	to_add->origin = current_config_scope();
    ++	/* Provide context for errors if necessary */
    ++	*pp_task_cb = run_me;
     +
    -+	list_add_tail(&to_add->list, head);
    ++	return 1;
     +}
     +
    -+static void remove_hook(struct list_head *to_remove)
    ++static int notify_start_failure(struct strbuf *out,
    ++				void *pp_cb,
    ++				void *pp_task_cp)
     +{
    -+	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
    -+	list_del(to_remove);
    -+	free_hook(hook_to_remove);
    -+}
    ++	struct hook_cb_data *hook_cb = pp_cb;
    ++	struct hook *attempted = pp_task_cp;
     +
    -+void clear_hook_list(struct list_head *head)
    -+{
    -+	struct list_head *pos, *tmp;
    -+	list_for_each_safe(pos, tmp, head)
    -+		remove_hook(pos);
    ++	/* |= rc in cb */
    ++	hook_cb->rc |= 1;
    ++
    ++	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
    ++		    attempted->hook_path);
    ++
    ++	return 1;
     +}
     +
    -+struct hook_config_cb
    ++static int notify_hook_finished(int result,
    ++				struct strbuf *out,
    ++				void *pp_cb,
    ++				void *pp_task_cb)
     +{
    -+	struct strbuf *hookname;
    -+	struct list_head *list;
    -+};
    ++	struct hook_cb_data *hook_cb = pp_cb;
     +
    -+static int hook_config_lookup(const char *key, const char *value, void *cb_data)
    -+{
    -+	struct hook_config_cb *data = cb_data;
    -+	const char *hook_key = data->hookname->buf;
    -+	struct list_head *head = data->list;
    -+
    -+	if (!strcmp(key, hook_key)) {
    -+		const char *command = value;
    -+		struct strbuf hookcmd_name = STRBUF_INIT;
    -+
    -+		/*
    -+		 * Check if a hookcmd with that name exists. If it doesn't,
    -+		 * 'git_config_get_value()' is documented not to touch &command,
    -+		 * so we don't need to do anything.
    -+		 */
    -+		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
    -+		git_config_get_value(hookcmd_name.buf, &command);
    -+
    -+		if (!command) {
    -+			strbuf_release(&hookcmd_name);
    -+			BUG("git_config_get_value overwrote a string it shouldn't have");
    -+		}
    -+
    -+		/*
    -+		 * TODO: implement an option-getting callback, e.g.
    -+		 *   get configs by pattern hookcmd.$value.*
    -+		 *   for each key+value, do_callback(key, value, cb_data)
    -+		 */
    -+
    -+		append_or_move_hook(head, command);
    -+
    -+		strbuf_release(&hookcmd_name);
    -+	}
    ++	/* |= rc in cb */
    ++	hook_cb->rc |= result;
     +
    -+	return 0;
    ++	return 1;
     +}
     +
    -+struct list_head* hook_list(const char* hookname)
    ++
    ++int run_found_hooks(const char *hook_name, const char *hook_path,
    ++		    struct run_hooks_opt *options)
     +{
    -+	struct strbuf hook_key = STRBUF_INIT;
    -+	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
    -+	struct hook_config_cb cb_data = { &hook_key, hook_head };
    ++	struct hook my_hook = {
    ++		.hook_path = hook_path,
    ++	};
    ++	struct hook_cb_data cb_data = {
    ++		.rc = 0,
    ++		.hook_name = hook_name,
    ++		.options = options,
    ++	};
    ++	cb_data.run_me = &my_hook;
    ++
    ++	if (options->jobs != 1)
    ++		BUG("we do not handle %d or any other != 1 job number yet", options->jobs);
     +
    -+	INIT_LIST_HEAD(hook_head);
    ++	run_processes_parallel_tr2(options->jobs,
    ++				   pick_next_hook,
    ++				   notify_start_failure,
    ++				   notify_hook_finished,
    ++				   &cb_data,
    ++				   "hook",
    ++				   hook_name);
     +
    -+	if (!hookname)
    -+		return NULL;
    ++	return cb_data.rc;
    ++}
    ++
    ++int run_hooks(const char *hook_name, struct run_hooks_opt *options)
    ++{
    ++	const char *hook_path;
    ++	int ret;
    ++	if (!options)
    ++		BUG("a struct run_hooks_opt must be provided to run_hooks");
     +
    -+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
    ++	hook_path = find_hook(hook_name);
     +
    -+	git_config(hook_config_lookup, &cb_data);
    ++	/* Care about nonexistence? Use run_found_hooks() */
    ++	if (!hook_path)
    ++		return 0;
     +
    -+	strbuf_release(&hook_key);
    -+	return hook_head;
    ++	ret = run_found_hooks(hook_name, hook_path, options);
    ++	return ret;
     +}
     
      ## hook.h (new) ##
     @@
    -+#include "config.h"
    -+#include "list.h"
    ++#ifndef HOOK_H
    ++#define HOOK_H
     +#include "strbuf.h"
    ++#include "strvec.h"
    ++#include "run-command.h"
     +
     +struct hook {
    -+	struct list_head list;
    -+	/*
    -+	 * Config file which holds the hook.*.command definition.
    -+	 * (This has nothing to do with the hookcmd.<name>.* configs.)
    -+	 */
    -+	enum config_scope origin;
    -+	/* The literal command to run. */
    -+	struct strbuf command;
    ++	/* The path to the hook */
    ++	const char *hook_path;
    ++};
    ++
    ++struct run_hooks_opt
    ++{
    ++	/* Environment vars to be set for each hook */
    ++	struct strvec env;
    ++
    ++	/* Args to be passed to each hook */
    ++	struct strvec args;
    ++
    ++	/* Number of threads to parallelize across */
    ++	int jobs;
     +};
     +
    ++#define RUN_HOOKS_OPT_INIT { \
    ++	.jobs = 1, \
    ++	.env = STRVEC_INIT, \
    ++	.args = STRVEC_INIT, \
    ++}
    ++
     +/*
    -+ * Provides a linked list of 'struct hook' detailing commands which should run
    -+ * in response to the 'hookname' event, in execution order.
    ++ * Callback provided to feed_pipe_fn and consume_sideband_fn.
     + */
    -+struct list_head* hook_list(const char *hookname);
    ++struct hook_cb_data {
    ++	int rc;
    ++	const char *hook_name;
    ++	struct hook *run_me;
    ++	struct run_hooks_opt *options;
    ++};
     +
    -+/* Free memory associated with a 'struct hook' */
    -+void free_hook(struct hook *ptr);
    -+/* Empties the list at 'head', calling 'free_hook()' on each entry */
    -+void clear_hook_list(struct list_head *head);
    ++void run_hooks_opt_clear(struct run_hooks_opt *o);
    ++
    ++/*
    ++ * Calls find_hook(hookname) and runs the hooks (if any) with
    ++ * run_found_hooks().
    ++ */
    ++int run_hooks(const char *hook_name, struct run_hooks_opt *options);
    ++
    ++/*
    ++ * Takes an already resolved hook and runs it. Internally the simpler
    ++ * run_hooks() will call this.
    ++ */
    ++int run_found_hooks(const char *hookname, const char *hook_path,
    ++		    struct run_hooks_opt *options);
    ++#endif
     
    - ## t/t1360-config-based-hooks.sh (new) ##
    + ## t/t1800-hook.sh (new) ##
     @@
     +#!/bin/bash
     +
    -+test_description='config-managed multihooks, including git-hook command'
    ++test_description='git-hook command'
     +
     +. ./test-lib.sh
     +
    -+ROOT=
    -+if test_have_prereq MINGW
    -+then
    -+	# In Git for Windows, Unix-like paths work only in shell scripts;
    -+	# `git.exe`, however, will prefix them with the pseudo root directory
    -+	# (of the Unix shell). Let's accommodate for that.
    -+	ROOT="$(cd / && pwd)"
    -+fi
    -+
    -+setup_hooks () {
    -+	test_config hook.pre-commit.command "/path/ghi" --add
    -+	test_config_global hook.pre-commit.command "/path/def" --add
    -+}
    ++test_expect_success 'setup .git/hooks' '
    ++	mkdir .git/hooks
    ++'
     +
    -+setup_hookcmd () {
    -+	test_config hook.pre-commit.command "abc" --add
    -+	test_config_global hookcmd.abc.command "/path/abc" --add
    -+}
    ++test_expect_success 'git hook run -- nonexistent hook' '
    ++	cat >stderr.expect <<-\EOF &&
    ++	error: cannot find a hook named does-not-exist
    ++	EOF
    ++	test_expect_code 1 git hook run does-not-exist 2>stderr.actual &&
    ++	test_cmp stderr.expect stderr.actual
    ++'
     +
    -+test_expect_success 'git hook rejects commands without a mode' '
    -+	test_must_fail git hook pre-commit
    ++test_expect_success 'git hook run -- basic' '
    ++	write_script .git/hooks/test-hook <<-EOF &&
    ++	echo Test hook
    ++	EOF
    ++
    ++	cat >expect <<-\EOF &&
    ++	Test hook
    ++	EOF
    ++	git hook run test-hook 2>actual &&
    ++	test_cmp expect actual
     +'
     +
    ++test_expect_success 'git hook run -- stdout and stderr handling' '
    ++	write_script .git/hooks/test-hook <<-EOF &&
    ++	echo >&1 Will end up on stderr
    ++	echo >&2 Will end up on stderr
    ++	EOF
     +
    -+test_expect_success 'git hook rejects commands without a hookname' '
    -+	test_must_fail git hook list
    ++	cat >stderr.expect <<-\EOF &&
    ++	Will end up on stderr
    ++	Will end up on stderr
    ++	EOF
    ++	git hook run test-hook >stdout.actual 2>stderr.actual &&
    ++	test_cmp stderr.expect stderr.actual &&
    ++	test_must_be_empty stdout.actual
     +'
     +
    -+test_expect_success 'git hook runs outside of a repo' '
    -+	setup_hooks &&
    ++test_expect_success 'git hook run -- exit codes are passed along' '
    ++	write_script .git/hooks/test-hook <<-EOF &&
    ++	exit 1
    ++	EOF
    ++
    ++	test_expect_code 1 git hook run test-hook &&
     +
    -+	cat >expected <<-EOF &&
    -+	global: $ROOT/path/def
    ++	write_script .git/hooks/test-hook <<-EOF &&
    ++	exit 2
     +	EOF
     +
    -+	nongit git config --list --global &&
    ++	test_expect_code 2 git hook run test-hook &&
     +
    -+	nongit git hook list pre-commit >actual &&
    -+	test_cmp expected actual
    -+'
    ++	write_script .git/hooks/test-hook <<-EOF &&
    ++	exit 128
    ++	EOF
     +
    -+test_expect_success 'git hook list orders by config order' '
    -+	setup_hooks &&
    ++	test_expect_code 128 git hook run test-hook &&
     +
    -+	cat >expected <<-EOF &&
    -+	global: $ROOT/path/def
    -+	local: $ROOT/path/ghi
    ++	write_script .git/hooks/test-hook <<-EOF &&
    ++	exit 129
     +	EOF
     +
    -+	git hook list pre-commit >actual &&
    -+	test_cmp expected actual
    ++	test_expect_code 129 git hook run test-hook
     +'
     +
    -+test_expect_success 'git hook list dereferences a hookcmd' '
    -+	setup_hooks &&
    -+	setup_hookcmd &&
    ++test_expect_success 'git hook run arg u ments without -- is not allowed' '
    ++	test_expect_code 129 git hook run test-hook arg u ments
    ++'
    ++
    ++test_expect_success 'git hook run -- pass arguments' '
    ++	write_script .git/hooks/test-hook <<-\EOF &&
    ++	echo $1
    ++	echo $2
    ++	EOF
     +
    -+	cat >expected <<-EOF &&
    -+	global: $ROOT/path/def
    -+	local: $ROOT/path/ghi
    -+	local: $ROOT/path/abc
    ++	cat >expect <<-EOF &&
    ++	arg
    ++	u ments
     +	EOF
     +
    -+	git hook list pre-commit >actual &&
    -+	test_cmp expected actual
    ++	git hook run test-hook -- arg "u ments" 2>actual &&
    ++	test_cmp expect actual
     +'
     +
    -+test_expect_success 'git hook list reorders on duplicate commands' '
    -+	setup_hooks &&
    ++test_expect_success 'git hook run -- out-of-repo runs excluded' '
    ++	write_script .git/hooks/test-hook <<-EOF &&
    ++	echo Test hook
    ++	EOF
     +
    -+	test_config hook.pre-commit.command "/path/def" --add &&
    ++	nongit test_must_fail git hook run test-hook
    ++'
     +
    -+	cat >expected <<-EOF &&
    -+	local: $ROOT/path/ghi
    -+	local: $ROOT/path/def
    ++test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
    ++	mkdir my-hooks &&
    ++	write_script my-hooks/test-hook <<-EOF &&
    ++	echo Hook ran >>actual
     +	EOF
     +
    -+	git hook list pre-commit >actual &&
    -+	test_cmp expected actual
    ++	cat >expect <<-\EOF &&
    ++	Test hook
    ++	Hook ran
    ++	Hook ran
    ++	Hook ran
    ++	Hook ran
    ++	EOF
    ++
    ++	# Test various ways of specifying the path. See also
    ++	# t1350-config-hooks-path.sh
    ++	>actual &&
    ++	git hook run test-hook 2>>actual &&
    ++	git -c core.hooksPath=my-hooks hook run test-hook 2>>actual &&
    ++	git -c core.hooksPath=my-hooks/ hook run test-hook 2>>actual &&
    ++	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook 2>>actual &&
    ++	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook 2>>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'set up a pre-commit hook in core.hooksPath' '
    ++	>actual &&
    ++	mkdir -p .git/custom-hooks .git/hooks &&
    ++	write_script .git/custom-hooks/pre-commit <<-\EOF &&
    ++	echo CUSTOM >>actual
    ++	EOF
    ++	write_script .git/hooks/pre-commit <<-\EOF
    ++	echo NORMAL >>actual
    ++	EOF
     +'
     +
     +test_done
 3:  faa4a655183 <  -:  ----------- hook: include hookdir hook in list
 4:  c43a7e0dd52 <  -:  ----------- hook: teach hook.runHookDir
 5:  81e453baea2 <  -:  ----------- hook: implement hookcmd.<name>.skip
 6:  71f9ee9ab82 <  -:  ----------- parse-options: parse into strvec
 7:  e43a7a94163 <  -:  ----------- hook: add 'run' subcommand
 8:  807ad9cf2f3 <  -:  ----------- hook: introduce hook_exists()
35:  43d2383af49 !  4:  1a67a1cc065 run-command: stop thinking about hooks
    @@
      ## Metadata ##
    -Author: Emily Shaffer <emilyshaffer@google.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    run-command: stop thinking about hooks
    +    run-command.h: move find_hook() to hook.h
     
    -    hook.h has replaced all run-command.h hook-related functionality.
    -    run-command.h:run_hooks_le/ve and find_hook are no longer used anywhere
    -    in the codebase. So, let's delete the dead code - or, in the one case
    -    where it's still needed, move it to an internal function in hook.c.
    +    Move the find_hook() command to hook.h. Eventually all the hook
    +    related code will live there, let's move this function over as-is.
     
    -    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +
    + ## builtin/am.c ##
    +@@
    + #include "parse-options.h"
    + #include "dir.h"
    + #include "run-command.h"
    ++#include "hook.h"
    + #include "quote.h"
    + #include "tempfile.h"
    + #include "lockfile.h"
    +
    + ## builtin/bugreport.c ##
    +@@
    + #include "strbuf.h"
    + #include "help.h"
    + #include "compat/compiler.h"
    +-#include "run-command.h"
    ++#include "hook.h"
    + 
    + 
    + static void get_system_info(struct strbuf *sys_info)
    +
    + ## builtin/commit.c ##
    +@@
    + #include "revision.h"
    + #include "wt-status.h"
    + #include "run-command.h"
    ++#include "hook.h"
    + #include "refs.h"
    + #include "log-tree.h"
    + #include "strbuf.h"
    +
    + ## builtin/merge.c ##
    +@@
    + #include "builtin.h"
    + #include "lockfile.h"
    + #include "run-command.h"
    ++#include "hook.h"
    + #include "diff.h"
    + #include "diff-merges.h"
    + #include "refs.h"
    +
    + ## builtin/receive-pack.c ##
    +@@
    + #include "pkt-line.h"
    + #include "sideband.h"
    + #include "run-command.h"
    ++#include "hook.h"
    + #include "exec-cmd.h"
    + #include "commit.h"
    + #include "object.h"
    +
    + ## builtin/worktree.c ##
    +@@
    + #include "branch.h"
    + #include "refs.h"
    + #include "run-command.h"
    ++#include "hook.h"
    + #include "sigchain.h"
    + #include "submodule.h"
    + #include "utf8.h"
     
      ## hook.c ##
    -@@ hook.c: static int should_include_hookdir(const char *path, enum hookdir_opt cfg)
    - 	}
    - }
    +@@
    + #include "hook.h"
    + #include "run-command.h"
      
    -+static const char *find_legacy_hook(const char *name)
    ++const char *find_hook(const char *name)
     +{
     +	static struct strbuf path = STRBUF_INIT;
     +
    @@ hook.c: static int should_include_hookdir(const char *path, enum hookdir_opt cfg
     +}
     +
     +
    - struct list_head* hook_list(const char* hookname)
    ++
    + void run_hooks_opt_clear(struct run_hooks_opt *o)
      {
    - 	struct strbuf hook_key = STRBUF_INIT;
    -@@ hook.c: struct list_head* hook_list(const char* hookname)
    - 	git_config(hook_config_lookup, &cb_data);
    - 
    - 	if (have_git_dir()) {
    --		const char *legacy_hook_path = find_hook(hookname);
    -+		const char *legacy_hook_path = find_legacy_hook(hookname);
    - 
    - 		/* Unconditionally add legacy hook, but annotate it. */
    - 		if (legacy_hook_path) {
    -@@ hook.c: int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
    - 	could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
    - 				should_run_hookdir == HOOKDIR_WARN ||
    - 				should_run_hookdir == HOOKDIR_YES)
    --				&& !!find_hook(hookname);
    -+				&& !!find_legacy_hook(hookname);
    + 	strvec_clear(&o->env);
    +
    + ## hook.h ##
    +@@ hook.h: struct hook_cb_data {
    + 	struct run_hooks_opt *options;
    + };
      
    - 	strbuf_addf(&hook_key, "hook.%s.command", hookname);
    ++/*
    ++ * Returns the path to the hook file, or NULL if the hook is missing
    ++ * or disabled. Note that this points to static storage that will be
    ++ * overwritten by further calls to find_hook and run_hook_*.
    ++ */
    ++const char *find_hook(const char *name);
    ++
    + void run_hooks_opt_clear(struct run_hooks_opt *o);
      
    + /*
    +
    + ## refs.c ##
    +@@
    + #include "refs.h"
    + #include "refs/refs-internal.h"
    + #include "run-command.h"
    ++#include "hook.h"
    + #include "object-store.h"
    + #include "object.h"
    + #include "tag.h"
     
      ## run-command.c ##
    +@@
    + #include "string-list.h"
    + #include "quote.h"
    + #include "config.h"
    ++#include "hook.h"
    + 
    + void child_process_init(struct child_process *child)
    + {
     @@ run-command.c: int async_with_fork(void)
      #endif
      }
    @@ run-command.c: int async_with_fork(void)
     -	return path.buf;
     -}
     -
    --int run_hook_ve(const char *const *env, const char *name, va_list args)
    --{
    --	struct child_process hook = CHILD_PROCESS_INIT;
    --	const char *p;
    --
    --	p = find_hook(name);
    --	if (!p)
    --		return 0;
    --
    --	strvec_push(&hook.args, p);
    --	while ((p = va_arg(args, const char *)))
    --		strvec_push(&hook.args, p);
    --	hook.env = env;
    --	hook.no_stdin = 1;
    --	hook.stdout_to_stderr = 1;
    --	hook.trace2_hook_name = name;
    --
    --	return run_command(&hook);
    --}
    --
    --int run_hook_le(const char *const *env, const char *name, ...)
    --{
    --	va_list args;
    --	int ret;
    --
    --	va_start(args, name);
    --	ret = run_hook_ve(env, name, args);
    --	va_end(args);
    --
    --	return ret;
    --}
    --
    - struct io_pump {
    - 	/* initialized by caller */
    - 	int fd;
    + int run_hook_ve(const char *const *env, const char *name, va_list args)
    + {
    + 	struct child_process hook = CHILD_PROCESS_INIT;
     
      ## run-command.h ##
     @@ run-command.h: int finish_command_in_signal(struct child_process *);
    @@ run-command.h: int finish_command_in_signal(struct child_process *);
     - */
     -const char *find_hook(const char *name);
     -
    --/**
    -- * Run a hook.
    -- * The first argument is a pathname to an index file, or NULL
    -- * if the hook uses the default index file or no index is needed.
    -- * The second argument is the name of the hook.
    -- * The further arguments correspond to the hook arguments.
    -- * The last argument has to be NULL to terminate the arguments list.
    -- * If the hook does not exist or is not executable, the return
    -- * value will be zero.
    -- * If it is executable, the hook will be executed and the exit
    -- * status of the hook is returned.
    -- * On execution, .stdout_to_stderr and .no_stdin will be set.
    -- */
    --LAST_ARG_MUST_BE_NULL
    --int run_hook_le(const char *const *env, const char *name, ...);
    --int run_hook_ve(const char *const *env, const char *name, va_list args);
    --
    - /*
    -  * Trigger an auto-gc
    -  */
    + /**
    +  * Run a hook.
    +  * The first argument is a pathname to an index file, or NULL
    +
    + ## sequencer.c ##
    +@@
    + #include "sequencer.h"
    + #include "tag.h"
    + #include "run-command.h"
    ++#include "hook.h"
    + #include "exec-cmd.h"
    + #include "utf8.h"
    + #include "cache-tree.h"
    +
    + ## transport.c ##
    +@@
    + #include "config.h"
    + #include "transport.h"
    + #include "run-command.h"
    ++#include "hook.h"
    + #include "pkt-line.h"
    + #include "fetch-pack.h"
    + #include "remote.h"
33:  33043b33b04 !  5:  a6f0817ad81 bugreport: use hook_exists instead of find_hook
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    bugreport: use hook_exists instead of find_hook
    +    hook.c: add a hook_exists() wrapper and use it in bugreport.c
     
    -    By using the helper in hook.h instead of the one in run-command.h, we
    -    can also check whether a hook exists in the config - not just whether it
    -    exists in the hookdir.
    +    Add a boolean version of the find_hook() function for those callers
    +    who are only interested in checking whether the hook exists, not what
    +    the path to it is.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bugreport.c ##
    -@@
    - #include "strbuf.h"
    - #include "help.h"
    - #include "compat/compiler.h"
    --#include "run-command.h"
    -+#include "hook.h"
    - 
    - 
    - static void get_system_info(struct strbuf *sys_info)
     @@ builtin/bugreport.c: static void get_populated_hooks(struct strbuf *hook_info, int nongit)
      	}
      
      	for (i = 0; i < ARRAY_SIZE(hook); i++)
     -		if (find_hook(hook[i]))
    -+		if (hook_exists(hook[i], HOOKDIR_USE_CONFIG))
    ++		if (hook_exists(hook[i]))
      			strbuf_addf(hook_info, "%s\n", hook[i]);
      }
      
    +
    + ## hook.c ##
    +@@ hook.c: const char *find_hook(const char *name)
    + 	return path.buf;
    + }
    + 
    +-
    ++int hook_exists(const char *name)
    ++{
    ++	return !!find_hook(name);
    ++}
    + 
    + void run_hooks_opt_clear(struct run_hooks_opt *o)
    + {
    +
    + ## hook.h ##
    +@@ hook.h: struct hook_cb_data {
    +  */
    + const char *find_hook(const char *name);
    + 
    ++/*
    ++ * A boolean version of find_hook()
    ++ */
    ++int hook_exists(const char *hookname);
    ++
    + void run_hooks_opt_clear(struct run_hooks_opt *o);
    + 
    + /*
20:  2006e2709f6 !  6:  b186fde43e1 gc: use hook library for pre-auto-gc hook
    @@ Commit message
         well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It
    - takes no parameter, and exiting with non-zero status from this script
    - causes the `git gc --auto` to abort.
    - 
    -+Hooks run during 'pre-auto-gc' will be run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - post-rewrite
    - ~~~~~~~~~~~~
    - 
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/gc.c ##
     @@
    @@ builtin/gc.c: static void add_repack_incremental_option(void)
      
      static int need_to_gc(void)
      {
    -+	struct run_hooks_opt hook_opt;
    ++	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
     +
      	/*
      	 * Setting gc.auto to 0 or negative can disable the
    @@ builtin/gc.c: static int need_to_gc(void)
      		return 0;
      
     -	if (run_hook_le(NULL, "pre-auto-gc", NULL))
    -+	run_hooks_opt_init_async(&hook_opt);
     +	if (run_hooks("pre-auto-gc", &hook_opt)) {
     +		run_hooks_opt_clear(&hook_opt);
      		return 0;
21:  62f6f9ab90d !  7:  528402fac69 rebase: teach pre-rebase to use hook.h
    @@ Metadata
      ## Commit message ##
         rebase: teach pre-rebase to use hook.h
     
    -    By using hook.h instead of run-command.h to run hooks, pre-rebase hooks
    -    can now be specified in the config as well as in the hookdir. pre-rebase
    -    is not called anywhere besides builtin/rebase.c.
    +    Move the pre-rebase hook away from run-command.h to and over to the
    +    new hook.h library.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: two parameters.  The first parameter is the upstream from which
    - the series was forked.  The second parameter is the branch being
    - rebased, and is not set when rebasing the current branch.
    - 
    -+Hooks executed during 'pre-rebase' will run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - post-checkout
    - ~~~~~~~~~~~~~
    - 
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/rebase.c ##
     @@
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      	char *squash_onto_name = NULL;
      	int reschedule_failed_exec = -1;
      	int allow_preemptive_ff = 1;
    -+	struct run_hooks_opt hook_opt;
    ++	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
      	struct option builtin_rebase_options[] = {
      		OPT_STRING(0, "onto", &options.onto_name,
      			   N_("revision"),
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      	}
      
      	/* If a hook exists, give it a chance to interrupt*/
    -+	run_hooks_opt_init_async(&hook_opt);
     +	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
      	if (!ok_to_skip_pre_rebase &&
     -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
18:  744e156ae91 !  8:  69842c74383 am: convert applypatch hooks to use config
    @@ Commit message
         am: convert applypatch hooks to use config
     
         Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
    -    hook.h library instead of the run-command.h library. This enables use of
    -    hooks specified in the config, in addition to those in the hookdir.
    -    These three hooks are called only by builtin/am.c.
    +    hook.h library instead of the run-command.h library.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: the message file.
    - The default 'applypatch-msg' hook, when enabled, runs the
    - 'commit-msg' hook, if the latter is enabled.
    - 
    -+Hooks run during 'applypatch-msg' will not be parallelized, because hooks are
    -+expected to edit the file holding the commit log message.
    -+
    - pre-applypatch
    - ~~~~~~~~~~~~~~
    - 
    -@@ Documentation/githooks.txt: make a commit if it does not pass certain test.
    - The default 'pre-applypatch' hook, when enabled, runs the
    - 'pre-commit' hook, if the latter is enabled.
    - 
    -+Hooks run during 'pre-applypatch' will be run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - post-applypatch
    - ~~~~~~~~~~~~~~~
    - 
    -@@ Documentation/githooks.txt: and is invoked after the patch is applied and a commit is made.
    - This hook is meant primarily for notification, and cannot affect
    - the outcome of `git am`.
    - 
    -+Hooks run during 'post-applypatch' will be run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - pre-commit
    - ~~~~~~~~~~
    - 
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/am.c ##
    -@@
    - #include "string-list.h"
    - #include "packfile.h"
    - #include "repository.h"
    -+#include "hook.h"
    - 
    - /**
    -  * Returns the length of the first line of msg.
     @@ builtin/am.c: static void am_destroy(const struct am_state *state)
      static int run_applypatch_msg_hook(struct am_state *state)
      {
      	int ret;
    -+	struct run_hooks_opt opt;
    -+
    -+	run_hooks_opt_init_sync(&opt);
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
      
      	assert(state->msg);
     -	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
    @@ builtin/am.c: static void do_commit(const struct am_state *state)
      	struct commit_list *parents = NULL;
      	const char *reflog_msg, *author, *committer = NULL;
      	struct strbuf sb = STRBUF_INIT;
    -+	struct run_hooks_opt hook_opt;
    -+
    -+	run_hooks_opt_init_async(&hook_opt);
    ++	struct run_hooks_opt hook_opt_pre = RUN_HOOKS_OPT_INIT;
    ++	struct run_hooks_opt hook_opt_post = RUN_HOOKS_OPT_INIT;
      
     -	if (run_hook_le(NULL, "pre-applypatch", NULL))
    -+	if (run_hooks("pre-applypatch", &hook_opt)) {
    -+		run_hooks_opt_clear(&hook_opt);
    ++	if (run_hooks("pre-applypatch", &hook_opt_pre)) {
    ++		run_hooks_opt_clear(&hook_opt_pre);
      		exit(1);
     +	}
    -+
    -+	run_hooks_opt_clear(&hook_opt);
      
      	if (write_cache_as_tree(&tree, 0, NULL))
      		die(_("git write-tree failed to write a tree"));
    @@ builtin/am.c: static void do_commit(const struct am_state *state)
      	}
      
     -	run_hook_le(NULL, "post-applypatch", NULL);
    -+	run_hooks_opt_init_async(&hook_opt);
    -+	run_hooks("post-applypatch", &hook_opt);
    ++	run_hooks("post-applypatch", &hook_opt_post);
      
    -+	run_hooks_opt_clear(&hook_opt);
    ++	run_hooks_opt_clear(&hook_opt_pre);
    ++	run_hooks_opt_clear(&hook_opt_post);
      	strbuf_release(&sb);
      }
      
25:  a13a690bebb !  9:  9b32c14669b hooks: convert 'post-checkout' hook to hook library
    @@ Metadata
      ## Commit message ##
         hooks: convert 'post-checkout' hook to hook library
     
    -    By using the 'hook.h' library, 'post-checkout' hooks can now be
    -    specified in the config as well as in the hook directory.
    +    Move the running of the 'post-checkout' hook away from run-command.h
    +    to the new hook.h library. For "worktree" this requires a change to it
    +    to run the hooks from a given directory.
     
    -    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    We could strictly speaking skip the "absolute_path" flag and just
    +    check if "dir" is specified, but let's split them up for clarity, as
    +    well as for any future user who'd like to set "dir" but not implicitly
    +    change the argument to an absolute path.
     
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: This hook can be used to perform repository validity checks, auto-display
    - differences from the previous HEAD if different, or set working dir metadata
    - properties.
    - 
    -+Hooks executed during 'post-checkout' will not be parallelized.
    -+
    - post-merge
    - ~~~~~~~~~~
    - 
    +    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/checkout.c ##
     @@
    @@ builtin/checkout.c: struct branch_info {
     -			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
     -			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
     -			   changed ? "1" : "0", NULL);
    -+	struct run_hooks_opt opt;
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	int rc;
    -+
    -+	run_hooks_opt_init_sync(&opt);
     +
      	/* "new_commit" can be NULL when checking out from the index before
      	   a commit exists. */
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      	struct tree *tree;
      	struct tree_desc t;
      	int err = 0;
    -+	struct run_hooks_opt hook_opt;
    ++	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
      
      	if (option_no_checkout)
      		return 0;
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      
     -	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
     -			   oid_to_hex(&oid), "1", NULL);
    -+	run_hooks_opt_init_sync(&hook_opt);
     +	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid), "1", NULL);
     +	err |= run_hooks("post-checkout", &hook_opt);
     +	run_hooks_opt_clear(&hook_opt);
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      		struct strvec args = STRVEC_INIT;
     
      ## builtin/worktree.c ##
    -@@
    - #include "utf8.h"
    - #include "worktree.h"
    - #include "quote.h"
    -+#include "hook.h"
    - 
    - static const char * const worktree_usage[] = {
    - 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
      	 * is_junk is cleared, but do return appropriate code when hook fails.
      	 */
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
     -				     "1", NULL);
     -			ret = run_command(&cp);
     -		}
    -+		struct run_hooks_opt opt;
    -+
    -+		run_hooks_opt_init_sync(&opt);
    ++		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +
     +		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
     +		strvec_pushl(&opt.args,
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
     +			     "1",
     +			     NULL);
     +		opt.dir = path;
    ++		opt.absolute_path = 1;
     +
     +		ret = run_hooks("post-checkout", &opt);
     +
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      
      	strvec_clear(&child_env);
     
    + ## hook.c ##
    +@@ hook.c: static int pick_next_hook(struct child_process *cp,
    + 	cp->env = hook_cb->options->env.v;
    + 	cp->stdout_to_stderr = 1;
    + 	cp->trace2_hook_name = hook_cb->hook_name;
    ++	cp->dir = hook_cb->options->dir;
    + 
    + 	/* add command */
    + 	strvec_push(&cp->args, run_me->hook_path);
    +@@ hook.c: static int notify_hook_finished(int result,
    + int run_found_hooks(const char *hook_name, const char *hook_path,
    + 		    struct run_hooks_opt *options)
    + {
    ++	struct strbuf abs_path = STRBUF_INIT;
    + 	struct hook my_hook = {
    + 		.hook_path = hook_path,
    + 	};
    +@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    + 		.hook_name = hook_name,
    + 		.options = options,
    + 	};
    ++	if (options->absolute_path) {
    ++		strbuf_add_absolute_path(&abs_path, hook_path);
    ++		my_hook.hook_path = abs_path.buf;
    ++	}
    + 	cb_data.run_me = &my_hook;
    + 
    + 	if (options->jobs != 1)
    +@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    + 				   &cb_data,
    + 				   "hook",
    + 				   hook_name);
    ++	if (options->absolute_path)
    ++		strbuf_release(&abs_path);
    + 
    + 	return cb_data.rc;
    + }
    +
    + ## hook.h ##
    +@@ hook.h: struct run_hooks_opt
    + 
    + 	/* Number of threads to parallelize across */
    + 	int jobs;
    ++
    ++	/* Resolve and run the "absolute_path(hook)" instead of
    ++	 * "hook". Used for "git worktree" hooks
    ++	 */
    ++	int absolute_path;
    ++
    ++	/* Path to initial working directory for subprocess */
    ++	const char *dir;
    ++
    + };
    + 
    + #define RUN_HOOKS_OPT_INIT { \
    +
      ## read-cache.c ##
     @@
    + #include "thread-utils.h"
      #include "progress.h"
      #include "sparse-index.h"
    - #include "hook.h"
    -->>>>>>> 9524a9d29d (read-cache: convert post-index-change hook to use config)
    ++#include "hook.h"
      
      /* Mask for the name length in ce_flags in the on-disk index */
      
    @@ reset.c: int reset_head(struct repository *r, struct object_id *oid, const char
     -			    oid_to_hex(orig ? orig : null_oid()),
     -			    oid_to_hex(oid), "1", NULL);
     +	if (run_hook) {
    -+		struct run_hooks_opt opt;
    -+
    -+		run_hooks_opt_init_sync(&opt);
    ++		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +		strvec_pushl(&opt.args,
     +			     oid_to_hex(orig ? orig : null_oid()),
     +			     oid_to_hex(oid),
19:  be1d7c7636b ! 10:  201c654bb0c merge: use config-based hooks for post-merge hook
    @@ Commit message
         builtin/merge.c.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: save and restore any form of metadata associated with the working tree
    - (e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
    - for an example of how to do this.
    - 
    -+Hooks executed during 'post-merge' will run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - pre-push
    - ~~~~~~~~
    - 
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/merge.c ##
     @@ builtin/merge.c: static void finish(struct commit *head_commit,
      		   const struct object_id *new_head, const char *msg)
      {
      	struct strbuf reflog_message = STRBUF_INIT;
    -+	struct run_hooks_opt opt;
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
      	const struct object_id *head = &head_commit->object.oid;
      
      	if (!msg)
    @@ builtin/merge.c: static void finish(struct commit *head_commit,
      
      	/* Run a post-merge hook */
     -	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
    -+	run_hooks_opt_init_async(&opt);
     +	strvec_push(&opt.args, squash ? "1" : "0");
     +	run_hooks("post-merge", &opt);
     +	run_hooks_opt_clear(&opt);
      
      	apply_autostash(git_path_merge_autostash(the_repository));
      	strbuf_release(&reflog_message);
    +@@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
    + 	 * and write it out as a tree.  We must do this before we invoke
    + 	 * the editor and after we invoke run_status above.
    + 	 */
    +-	if (find_hook("pre-merge-commit"))
    ++	if (hook_exists("pre-merge-commit"))
    + 		discard_cache();
    + 	read_cache_from(index_file);
    + 	strbuf_addbuf(&msg, &merge_msg);
 -:  ----------- > 11:  e65d8bd6e6f git hook run: add an --ignore-missing flag
34:  832136eb930 ! 12:  8795e9ceab8 git-send-email: use 'git hook run' for 'sendemail-validate'
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    git-send-email: use 'git hook run' for 'sendemail-validate'
    +    send-email: use 'git hook run' for 'sendemail-validate'
     
    -    By using the new 'git hook run' subcommand to run 'sendemail-validate',
    -    we can reduce the boilerplate needed to run this hook in perl. Using
    -    config-based hooks also allows us to run 'sendemail-validate' hooks that
    -    were configured globally when running 'git send-email' from outside of a
    -    Git directory, alongside other benefits like multihooks and
    -    parallelization.
    +    Change the "sendmail-validate" hook to be run via the "git hook run"
    +    wrapper instead of via a direct invocation.
    +
    +    This is the smallest possibly change to get "send-email" using "git
    +    hook run". We still check the hook itself with "-x", and set a
    +    "GIT_DIR" variable, both of which are asserted by our tests. We'll
    +    need to get rid of this special behavior if we start running N hooks,
    +    but for now let's be as close to bug-for-bug compatible as possible.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-send-email.perl ##
    -@@ git-send-email.perl: sub unique_email_list {
    - sub validate_patch {
    +@@ git-send-email.perl: sub format_2822_time {
    + my $editor;
    + 
    + sub system_or_msg {
    +-	my ($args, $msg) = @_;
    ++	my ($args, $msg, $cmd_name) = @_;
    + 	system(@$args);
    + 	my $signalled = $? & 127;
    + 	my $exit_code = $? >> 8;
    + 	return unless $signalled or $exit_code;
    + 
    +-	my @sprintf_args = ($args->[0], $exit_code);
    ++	my @sprintf_args = ($cmd_name ? $cmd_name : $args->[0], $exit_code);
    + 	if (defined $msg) {
    + 		# Quiet the 'redundant' warning category, except we
    + 		# need to support down to Perl 5.8, so we can't do a
    +@@ git-send-email.perl: sub validate_patch {
      	my ($fn, $xfer_encoding) = @_;
      
    --	if ($repo) {
    --		my $validate_hook = catfile($repo->hooks_path(),
    + 	if ($repo) {
    ++		my $hook_name = 'sendemail-validate';
    + 		my $hooks_path = $repo->command_oneline('rev-parse', '--git-path', 'hooks');
    +-		my $validate_hook = catfile($hooks_path,
     -					    'sendemail-validate');
    --		my $hook_error;
    --		if (-x $validate_hook) {
    --			my $target = abs_path($fn);
    --			# The hook needs a correct cwd and GIT_DIR.
    --			my $cwd_save = cwd();
    --			chdir($repo->wc_path() or $repo->repo_path())
    --				or die("chdir: $!");
    --			local $ENV{"GIT_DIR"} = $repo->repo_path();
    ++		my $validate_hook = catfile($hooks_path, $hook_name);
    + 		my $hook_error;
    + 		if (-x $validate_hook) {
    + 			my $target = abs_path($fn);
    +@@ git-send-email.perl: sub validate_patch {
    + 			chdir($repo->wc_path() or $repo->repo_path())
    + 				or die("chdir: $!");
    + 			local $ENV{"GIT_DIR"} = $repo->repo_path();
     -			$hook_error = system_or_msg([$validate_hook, $target]);
    --			chdir($cwd_save) or die("chdir: $!");
    --		}
    --		if ($hook_error) {
    ++			my @validate_hook = ("git", "hook", "run", "--ignore-missing", $hook_name, "--", $target);
    ++			$hook_error = system_or_msg(\@validate_hook, undef,
    ++						       "git hook run $hook_name -- <patch>");
    + 			chdir($cwd_save) or die("chdir: $!");
    + 		}
    + 		if ($hook_error) {
     -			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
     -				       "%s\n" .
     -				       "warning: no patches were sent\n"), $fn, $hook_error);
    --		}
    --	}
    -+	my $target = abs_path($fn);
    -+
    -+	system_or_die(["git", "hook", "run", "sendemail-validate", "-j1", "-a", $target],
    -+		sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
    -+			   "warning: no patches were sent\n"),
    -+		        $fn));
    ++			$hook_error = sprintf(__("fatal: %s: rejected by %s hook\n" .
    ++						 $hook_error . "\n" .
    ++						 "warning: no patches were sent\n"),
    ++					      $fn, $hook_name);
    ++			die $hook_error;
    + 		}
    + 	}
      
    - 	# Any long lines will be automatically fixed if we use a suitable transfer
    - 	# encoding.
     
      ## t/t9001-send-email.sh ##
     @@ t/t9001-send-email.sh: test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
      	test_path_is_file my-hooks.ran &&
      	cat >expect <<-EOF &&
      	fatal: longline.patch: rejected by sendemail-validate hook
    --	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
    +-	fatal: command '"'"'my-hooks/sendemail-validate'"'"' died with exit code 1
    ++	fatal: command '"'"'git hook run sendemail-validate -- <patch>'"'"' died with exit code 1
      	warning: no patches were sent
      	EOF
      	test_cmp expect actual
    @@ t/t9001-send-email.sh: test_expect_success $PREREQ "--validate respects absolute
      	test_path_is_file my-hooks.ran &&
      	cat >expect <<-EOF &&
      	fatal: longline.patch: rejected by sendemail-validate hook
    --	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with exit code 1
    +-	fatal: command '"'"'$hooks_path/sendemail-validate'"'"' died with exit code 1
    ++	fatal: command '"'"'git hook run sendemail-validate -- <patch>'"'"' died with exit code 1
      	warning: no patches were sent
      	EOF
      	test_cmp expect actual
    -@@ t/t9001-send-email.sh: test_expect_success $PREREQ 'invoke hook' '
    - 	mkdir -p .git/hooks &&
    - 
    - 	write_script .git/hooks/sendemail-validate <<-\EOF &&
    --	# test that we have the correct environment variable, pwd, and
    --	# argument
    --	case "$GIT_DIR" in
    --	*.git)
    --		true
    --		;;
    --	*)
    --		false
    --		;;
    --	esac &&
    -+	# test that we have the correct argument
    - 	test -f 0001-add-main.patch &&
    - 	grep "add main" "$1"
    - 	EOF
24:  f4c92f0dbc1 ! 13:  03129460fd2 git-p4: use 'git hook' to run hooks
    @@ Commit message
         git-p4: use 'git hook' to run hooks
     
         Instead of duplicating the behavior of run-command.h:run_hook_le() in
    -    Python, we can directly call 'git hook run'. As a bonus, this means
    -    git-p4 learns how to find hook specifications from the Git config as
    -    well as from the hookdir.
    +    Python, we can directly call 'git hook run'. We emulate the existence
    +    check with the --ignore-missing flag.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-p4.py ##
     @@ git-p4.py: def decode_path(path):
    +         return path
      
      def run_git_hook(cmd, param=[]):
    -     """Execute a hook if the hook exists."""
    +-    """Execute a hook if the hook exists."""
     -    if verbose:
     -        sys.stderr.write("Looking for hook: %s\n" % cmd)
     -        sys.stderr.flush()
    @@ git-p4.py: def decode_path(path):
     -                    return True
     -
     -    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
    -+    if not cmd:
    -         return True
    - 
    +-        return True
    +-
     -    return run_hook_command(hook_file, param) == 0
     -
     -def run_hook_command(cmd, param):
    @@ git-p4.py: def decode_path(path):
     -        else:
     -            use_shell = True
     -    return subprocess.call(cli, shell=use_shell)
    +-
     +    """args are specified with -a <arg> -a <arg> -a <arg>"""
    -+    args = (['git', 'hook', 'run'] +
    -+            ["-a" + arg for arg in param] +
    -+            [cmd])
    - 
    ++    args = ['git', 'hook', 'run', '--ignore-missing', cmd]
    ++    if param:
    ++        args.append("--")
    ++        for p in param:
    ++            args.append(p)
     +    return subprocess.call(args) == 0
      
      def write_pipe(c, stdin):
 -:  ----------- > 14:  3f3610f5ed3 commit: use hook.h to execute hooks
22:  0e405276551 ! 15:  6482a3e4cb8 read-cache: convert post-index-change hook to use config
    @@ Commit message
         can now be specified in the config in addition to the hookdir.
         post-index-change is not run anywhere besides in read-cache.c.
     
    -    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    This removes the last direct user of run_hook_ve(), so we can make the
    +    function static now. It'll be removed entirely soon.
     
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: and "0" meaning they were not.
    - Only one parameter should be set to "1" when the hook runs.  The hook
    - running passing "1", "1" should not be possible.
    - 
    -+Hooks run during 'post-index-change' will be run in parallel, unless hook.jobs
    -+is configured to 1.
    -+
    - GIT
    - ---
    - Part of the linkgit:git[1] suite
    +    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## read-cache.c ##
    -@@
    - #include "thread-utils.h"
    - #include "progress.h"
    - #include "sparse-index.h"
    -+#include "hook.h"
    -+>>>>>>> 9524a9d29d (read-cache: convert post-index-change hook to use config)
    - 
    - /* Mask for the name length in ce_flags in the on-disk index */
    - 
     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struct lock_file *l
      {
      	int ret;
      	int was_full = !istate->sparse_index;
    -+	struct run_hooks_opt hook_opt;
    ++	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
      
      	ret = convert_to_sparse(istate);
      
    @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struc
     -	run_hook_le(NULL, "post-index-change",
     -			istate->updated_workdir ? "1" : "0",
     -			istate->updated_skipworktree ? "1" : "0", NULL);
    -+	run_hooks_opt_init_async(&hook_opt);
     +	strvec_pushl(&hook_opt.args,
     +		     istate->updated_workdir ? "1" : "0",
     +		     istate->updated_skipworktree ? "1" : "0",
    @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struc
      	istate->updated_workdir = 0;
      	istate->updated_skipworktree = 0;
      
    +
    + ## run-command.c ##
    +@@ run-command.c: int async_with_fork(void)
    + #endif
    + }
    + 
    +-int run_hook_ve(const char *const *env, const char *name, va_list args)
    ++static int run_hook_ve(const char *const *env, const char *name, va_list args)
    + {
    + 	struct child_process hook = CHILD_PROCESS_INIT;
    + 	const char *p;
    +
    + ## run-command.h ##
    +@@ run-command.h: int run_command(struct child_process *);
    +  */
    + LAST_ARG_MUST_BE_NULL
    + int run_hook_le(const char *const *env, const char *name, ...);
    +-int run_hook_ve(const char *const *env, const char *name, va_list args);
    + 
    + /*
    +  * Trigger an auto-gc
23:  a793508373e ! 16:  a16163d4fb5 receive-pack: convert push-to-checkout hook to hook.h
    @@ Commit message
         hooks can now be specified in the config as well as in the hookdir.
         push-to-checkout is not called anywhere but in builtin/receive-pack.c.
     
    -    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    This is the last user of the run_hook_le() API, so let's remove it
    +    while we're at it, since run_hook_le() itself is the last user of
    +    run_hook_ve() we can remove that too. The last direct user of
    +    run_hook_le() was removed in the commit preceding this one.
     
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: that switches branches while
    - keeping the local changes in the working tree that do not interfere
    - with the difference between the branches.
    - 
    -+Hooks executed during 'push-to-checkout' will not be parallelized.
    - 
    - pre-auto-gc
    - ~~~~~~~~~~~
    +    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/receive-pack.c ##
    -@@
    - #include "commit-reach.h"
    - #include "worktree.h"
    - #include "shallow.h"
    -+#include "hook.h"
    - 
    - static const char * const receive_pack_usage[] = {
    - 	N_("git receive-pack <git-dir>"),
     @@ builtin/receive-pack.c: static const char *push_to_checkout(unsigned char *hash,
      				    struct strvec *env,
      				    const char *work_tree)
      {
    -+	struct run_hooks_opt opt;
    -+
    -+	run_hooks_opt_init_sync(&opt);
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +
      	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
     -	if (run_hook_le(env->v, push_to_checkout_hook,
    @@ builtin/receive-pack.c: static const char *update_worktree(unsigned char *sha1,
      	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
      
     -	if (!find_hook(push_to_checkout_hook))
    -+	if (!hook_exists(push_to_checkout_hook, HOOKDIR_USE_CONFIG))
    ++	if (!hook_exists(push_to_checkout_hook))
      		retval = push_to_deploy(sha1, &env, work_tree);
      	else
      		retval = push_to_checkout(sha1, &env, work_tree);
    +
    + ## run-command.c ##
    +@@ run-command.c: int async_with_fork(void)
    + #endif
    + }
    + 
    +-static int run_hook_ve(const char *const *env, const char *name, va_list args)
    +-{
    +-	struct child_process hook = CHILD_PROCESS_INIT;
    +-	const char *p;
    +-
    +-	p = find_hook(name);
    +-	if (!p)
    +-		return 0;
    +-
    +-	strvec_push(&hook.args, p);
    +-	while ((p = va_arg(args, const char *)))
    +-		strvec_push(&hook.args, p);
    +-	hook.env = env;
    +-	hook.no_stdin = 1;
    +-	hook.stdout_to_stderr = 1;
    +-	hook.trace2_hook_name = name;
    +-
    +-	return run_command(&hook);
    +-}
    +-
    +-int run_hook_le(const char *const *env, const char *name, ...)
    +-{
    +-	va_list args;
    +-	int ret;
    +-
    +-	va_start(args, name);
    +-	ret = run_hook_ve(env, name, args);
    +-	va_end(args);
    +-
    +-	return ret;
    +-}
    +-
    + struct io_pump {
    + 	/* initialized by caller */
    + 	int fd;
    +
    + ## run-command.h ##
    +@@ run-command.h: int finish_command_in_signal(struct child_process *);
    +  */
    + int run_command(struct child_process *);
    + 
    +-/**
    +- * Run a hook.
    +- * The first argument is a pathname to an index file, or NULL
    +- * if the hook uses the default index file or no index is needed.
    +- * The second argument is the name of the hook.
    +- * The further arguments correspond to the hook arguments.
    +- * The last argument has to be NULL to terminate the arguments list.
    +- * If the hook does not exist or is not executable, the return
    +- * value will be zero.
    +- * If it is executable, the hook will be executed and the exit
    +- * status of the hook is returned.
    +- * On execution, .stdout_to_stderr and .no_stdin will be set.
    +- */
    +-LAST_ARG_MUST_BE_NULL
    +-int run_hook_le(const char *const *env, const char *name, ...);
    +-
    + /*
    +  * Trigger an auto-gc
    +  */
10:  744437273de ! 17:  7020cf10c8e run-command: allow stdin for run_processes_parallel
    @@ Commit message
         on child output in stderr.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## run-command.c ##
     @@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
 9:  3e07045894f ! 18:  4745dcfce49 hook: support passing stdin to hooks
    @@ Commit message
         interim file themselves.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-hook.txt ##
    -@@ Documentation/git-hook.txt: SYNOPSIS
    +@@ Documentation/git-hook.txt: git-hook - run git hooks
    + SYNOPSIS
      --------
      [verse]
    - 'git hook' list <hook-name>
    --'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hook-name>
    -+'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>]
    -+	<hook-name>
    +-'git hook' run [--ignore-missing] <hook-name> [-- <hook-args>]
    ++'git hook' run [--to-stdin=<path>] [--ignore-missing] <hook-name> [-- <hook-args>]
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-hook.txt: in the order they should be run, and print the config scope where the relevant
    - `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
    - This output is human-readable and the format is subject to change over time.
    - 
    --run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] `<hook-name>`::
    -+run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] [--to-stdin=<path>] `<hook-name>`::
    - 
    - Runs hooks configured for `<hook-name>`, in the same order displayed by `git
    - hook list`. Hooks configured this way may be run prepended with `sh -c`, so
    -@@ Documentation/git-hook.txt: Specify arguments to pass to every hook that is run.
    - +
    - Specify environment variables to set for every hook that is run.
    +@@ Documentation/git-hook.txt: run::
    + OPTIONS
    + -------
      
     +--to-stdin::
    -+	Only valid for `run`.
    -++
    -+Specify a file which will be streamed into stdin for every hook that is run.
    -+Each hook will receive the entire file from beginning to EOF.
    ++	For "run"; Specify a file which will be streamed into the
    ++	hook's stdin. The hook will receive the entire file from
    ++	beginning to EOF.
     +
    - CONFIGURATION
    - -------------
    - include::config/hook.txt[]
    + --ignore-missing::
    + 	Ignore any missing hook by quietly returning zero. Used for
    + 	tools that want to do a blind one-shot run of a hook that may
     
      ## builtin/hook.c ##
     @@
    + #include "strvec.h"
      
      static const char * const builtin_hook_usage[] = {
    - 	N_("git hook list <hookname>"),
    --	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hookname>"),
    -+	N_("git hook run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...]"
    -+	   "[--to-stdin=<path>] <hookname>"),
    +-	N_("git hook run <hook-name> [-- <hook-args>]"),
    ++	N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]"),
      	NULL
      };
      
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    - 			   N_("environment variables for hook to use")),
    - 		OPT_STRVEC('a', "arg", &opt.args, N_("args"),
    - 			   N_("argument to pass to hook")),
    + 	struct option run_options[] = {
    + 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
    + 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
     +		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
     +			   N_("file to read into hooks' stdin")),
      		OPT_END(),
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      
     
      ## hook.c ##
    -@@ hook.c: void run_hooks_opt_init(struct run_hooks_opt *o)
    - {
    - 	strvec_init(&o->env);
    - 	strvec_init(&o->args);
    -+	o->path_to_stdin = NULL;
    - 	o->run_hookdir = configured_hookdir_opt();
    - }
    - 
    -@@ hook.c: static void prepare_hook_cp(const char *hookname, struct hook *hook,
    - 	if (!hook)
    - 		return;
    +@@ hook.c: static int pick_next_hook(struct child_process *cp,
    + 	if (!run_me)
    + 		BUG("did we not return 1 in notify_hook_finished?");
      
     -	cp->no_stdin = 1;
     +	/* reopen the file for stdin; run_command closes it. */
    -+	if (options->path_to_stdin)
    -+		cp->in = xopen(options->path_to_stdin, O_RDONLY);
    -+	else
    ++	if (hook_cb->options->path_to_stdin) {
    ++		cp->no_stdin = 0;
    ++		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
    ++	} else {
     +		cp->no_stdin = 1;
    -+
    - 	cp->env = options->env.v;
    ++	}
    + 	cp->env = hook_cb->options->env.v;
      	cp->stdout_to_stderr = 1;
    - 	cp->trace2_hook_name = hookname;
    + 	cp->trace2_hook_name = hook_cb->hook_name;
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    - 	 * to be overridden if the user can override it at the command line.
    - 	 */
    - 	enum hookdir_opt run_hookdir;
    -+
    + 	/* Path to initial working directory for subprocess */
    + 	const char *dir;
    + 
     +	/* Path to file which should be piped to stdin for each hook */
     +	const char *path_to_stdin;
      };
      
    - void run_hooks_opt_init(struct run_hooks_opt *o);
    -@@ hook.h: int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
    - 
    - /*
    -  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
    -- * passed 'env' and 'args'.
    -+ * passed 'env' and 'args'. The file at 'stdin_path' will be closed and reopened
    -+ * for each hook that runs.
    -  */
    - int run_hooks(const char *hookname, struct run_hooks_opt *options);
    - 
    + #define RUN_HOOKS_OPT_INIT { \
     
    - ## t/t1360-config-based-hooks.sh ##
    -@@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir is tolerant to unknown values' '
    - 	test_cmp expected actual
    + ## t/t1800-hook.sh ##
    +@@ t/t1800-hook.sh: test_expect_success 'set up a pre-commit hook in core.hooksPath' '
    + 	EOF
      '
      
    -+test_expect_success 'stdin to multiple hooks' '
    -+	git config --add hook.test.command "xargs -P1 -I% echo a%" &&
    -+	git config --add hook.test.command "xargs -P1 -I% echo b%" &&
    -+	test_when_finished "test_unconfig hook.test.command" &&
    -+
    -+	cat >input <<-EOF &&
    -+	1
    -+	2
    -+	3
    ++test_expect_success 'stdin to hooks' '
    ++	write_script .git/hooks/test-hook <<-\EOF &&
    ++	echo BEGIN stdin
    ++	cat
    ++	echo END stdin
     +	EOF
     +
    -+	cat >expected <<-EOF &&
    -+	a1
    -+	a2
    -+	a3
    -+	b1
    -+	b2
    -+	b3
    ++	cat >expect <<-EOF &&
    ++	BEGIN stdin
    ++	hello
    ++	END stdin
     +	EOF
     +
    -+	git hook run --to-stdin=input test 2>actual &&
    -+	test_cmp expected actual
    ++	echo hello >input &&
    ++	git hook run --to-stdin=input test-hook 2>actual &&
    ++	test_cmp expect actual
     +'
     +
      test_done
11:  e6c789629d6 <  -:  ----------- hook: allow parallel hook execution
12:  26e2d14bc1a <  -:  ----------- hook: allow specifying working directory for hooks
 -:  ----------- > 19:  986bfd89a54 am: convert 'post-rewrite' hook to hook.h
13:  e721d45efc6 ! 20:  756f52af22d run-command: add stdin callback for parallelization
    @@ Commit message
         match the rest of the API reduces mental load on the user.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int fetch_multiple(struct string_list *list, int max_children)
    @@ builtin/submodule--helper.c: static int update_submodules(struct submodule_updat
      
     
      ## hook.c ##
    -@@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
    +@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
      	run_processes_parallel_tr2(options->jobs,
      				   pick_next_hook,
      				   notify_start_failure,
14:  5d74ea3ed3f ! 21:  3748f128763 hook: provide stdin by string_list or callback
    @@ Commit message
         with instead.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## hook.c ##
    -@@
    - 
    - void free_hook(struct hook *ptr)
    - {
    --	if (ptr)
    -+	if (ptr) {
    - 		strbuf_release(&ptr->command);
    -+		free(ptr->feed_pipe_cb_data);
    -+	}
    - 	free(ptr);
    - }
    - 
    -@@ hook.c: static void append_or_move_hook(struct list_head *head, const char *command)
    - 		strbuf_init(&to_add->command, 0);
    - 		strbuf_addstr(&to_add->command, command);
    - 		to_add->from_hookdir = 0;
    -+		to_add->feed_pipe_cb_data = NULL;
    - 	}
    - 
    - 	/* re-set the scope so we show where an override was specified */
    -@@ hook.c: void run_hooks_opt_init_sync(struct run_hooks_opt *o)
    - 	o->run_hookdir = configured_hookdir_opt();
    - 	o->jobs = 1;
    - 	o->dir = NULL;
    -+	o->feed_pipe = NULL;
    -+	o->feed_pipe_ctx = NULL;
    - }
    - 
    - void run_hooks_opt_init_async(struct run_hooks_opt *o)
     @@ hook.c: void run_hooks_opt_clear(struct run_hooks_opt *o)
      	strvec_clear(&o->args);
      }
    @@ hook.c: void run_hooks_opt_clear(struct run_hooks_opt *o)
     +{
     +	int *item_idx;
     +	struct hook *ctx = pp_task_cb;
    -+	struct string_list *to_pipe = ((struct hook_cb_data*)pp_cb)->options->feed_pipe_ctx;
    ++	struct hook_cb_data *hook_cb = pp_cb;
    ++	struct string_list *to_pipe = hook_cb->options->feed_pipe_ctx;
     +
     +	/* Bootstrap the state manager if necessary. */
     +	if (!ctx->feed_pipe_cb_data) {
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	} else {
      		cp->no_stdin = 1;
      	}
    -@@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
    - 	if (!options)
    - 		BUG("a struct run_hooks_opt must be provided to run_hooks");
    - 
    -+	if (options->path_to_stdin && options->feed_pipe)
    -+		BUG("choose only one method to populate stdin");
    -+
    - 	to_run = hook_list(hookname);
    +@@ hook.c: static int notify_hook_finished(int result,
    + 	return 1;
    + }
      
    - 	list_for_each_safe(pos, tmp, to_run) {
    -@@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
    +-
    + int run_found_hooks(const char *hook_name, const char *hook_path,
    + 		    struct run_hooks_opt *options)
    + {
    +@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
      	run_processes_parallel_tr2(options->jobs,
      				   pick_next_hook,
      				   notify_start_failure,
    @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
      				   notify_hook_finished,
      				   &cb_data,
      				   "hook",
    +@@ hook.c: int run_hooks(const char *hook_name, struct run_hooks_opt *options)
    + 	if (!options)
    + 		BUG("a struct run_hooks_opt must be provided to run_hooks");
    + 
    ++	if (options->path_to_stdin && options->feed_pipe)
    ++		BUG("choose only one method to populate stdin");
    ++
    + 	hook_path = find_hook(hook_name);
    + 
    + 	/* Care about nonexistence? Use run_found_hooks() */
     
      ## hook.h ##
     @@
    - #include "list.h"
    - #include "strbuf.h"
    - #include "strvec.h"
    -+#include "run-command.h"
    - 
      struct hook {
    - 	struct list_head list;
    -@@ hook.h: struct hook {
    - 	/* The literal command to run. */
    - 	struct strbuf command;
    - 	unsigned from_hookdir : 1;
    + 	/* The path to the hook */
    + 	const char *hook_path;
     +
     +	/*
     +	 * Use this to keep state for your feed_pipe_fn if you are using
    @@ hook.h: struct hook {
     +	void *feed_pipe_cb_data;
      };
      
    - /*
    + struct run_hooks_opt
     @@ hook.h: struct run_hooks_opt
      
      	/* Path to file which should be piped to stdin for each hook */
      	const char *path_to_stdin;
    ++
     +	/*
     +	 * Callback and state pointer to ask for more content to pipe to stdin.
     +	 * Will be called repeatedly, for each hook. See
    @@ hook.h: struct run_hooks_opt
     +	 */
     +	feed_pipe_fn feed_pipe;
     +	void *feed_pipe_ctx;
    - 
    - 	/* Number of threads to parallelize across */
    - 	int jobs;
    - 
    - 	/* Path to initial working directory for subprocess */
    - 	const char *dir;
    -+
      };
      
    + #define RUN_HOOKS_OPT_INIT { \
    +@@ hook.h: struct run_hooks_opt
    + 	.args = STRVEC_INIT, \
    + }
    + 
     +/*
     + * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
     + * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
26:  6d804ca20fd ! 22:  0cf0b1fea93 hook: convert 'post-rewrite' hook to config
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    hook: convert 'post-rewrite' hook to config
    +    hook: convert 'post-rewrite' hook in sequencer.c to hook.h
     
         By using 'hook.h' for 'post-rewrite', we simplify hook invocations by
    -    not needing to put together our own 'struct child_process' and we also
    -    learn to run hooks specified in the config as well as the hook dir.
    +    not needing to put together our own 'struct child_process'.
     
    -    The signal handling that's being removed by this commit now takes place
    -    in run-command.h:run_processes_parallel(), so it is OK to remove them
    -    here.
    +    The signal handling that's being removed by this commit now takes
    +    place in run-command.h:run_processes_parallel(), so it is OK to remove
    +    them here.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: The hook always runs after the automatic note copying (see
    - "notes.rewrite.<command>" in linkgit:git-config[1]) has happened, and
    - thus has access to these notes.
    - 
    -+Hooks run during 'post-rewrite' will be run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - The following command-specific comments apply:
    - 
    - rebase::
    -
    - ## builtin/am.c ##
    -@@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
    -  */
    - static int run_post_rewrite_hook(const struct am_state *state)
    - {
    --	struct child_process cp = CHILD_PROCESS_INIT;
    --	const char *hook = find_hook("post-rewrite");
    -+	struct run_hooks_opt opt;
    - 	int ret;
    - 
    --	if (!hook)
    --		return 0;
    -+	run_hooks_opt_init_async(&opt);
    - 
    --	strvec_push(&cp.args, hook);
    --	strvec_push(&cp.args, "rebase");
    -+	strvec_push(&opt.args, "rebase");
    -+	opt.path_to_stdin = am_path(state, "rewritten");
    - 
    --	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
    --	cp.stdout_to_stderr = 1;
    --	cp.trace2_hook_name = "post-rewrite";
    -+	ret = run_hooks("post-rewrite", &opt);
    - 
    --	ret = run_command(&cp);
    --
    --	close(cp.in);
    -+	run_hooks_opt_clear(&opt);
    - 	return ret;
    - }
    - 
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## sequencer.c ##
     @@
    + #include "commit-reach.h"
      #include "rebase-interactive.h"
      #include "reset.h"
    - #include "hook.h"
     +#include "string-list.h"
      
      #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
    @@ sequencer.c: int update_head_with_reflog(const struct commit *old_head,
      {
     -	struct child_process proc = CHILD_PROCESS_INIT;
     -	const char *argv[3];
    -+	struct run_hooks_opt opt;
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	struct strbuf tmp = STRBUF_INIT;
     +	struct string_list to_stdin = STRING_LIST_INIT_DUP;
      	int code;
    @@ sequencer.c: int update_head_with_reflog(const struct commit *old_head,
     -	argv[0] = find_hook("post-rewrite");
     -	if (!argv[0])
     -		return 0;
    -+	run_hooks_opt_init_async(&opt);
    ++	strvec_push(&opt.args, "amend");
      
     -	argv[1] = "amend";
     -	argv[2] = NULL;
    @@ sequencer.c: int update_head_with_reflog(const struct commit *old_head,
     -	strbuf_release(&sb);
     -	sigchain_pop(SIGPIPE);
     -	return finish_command(&proc);
    -+	strvec_push(&opt.args, "amend");
    -+
     +	strbuf_addf(&tmp,
     +		    "%s %s",
     +		    oid_to_hex(oldoid),
    @@ sequencer.c: static int pick_commits(struct repository *r,
     -			strvec_push(&child.args, "copy");
     -			strvec_push(&child.args, "--for-rewrite=rebase");
     +			struct child_process notes_cp = CHILD_PROCESS_INIT;
    -+			struct run_hooks_opt hook_opt;
    -+
    -+			run_hooks_opt_init_async(&hook_opt);
    ++			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
     +
     +			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
     +			notes_cp.git_cmd = 1;
27:  e761410a1e8 ! 23:  c59443a3b05 transport: convert pre-push hook to use config
    @@ Commit message
         the config as well as in the hookdir.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push` will abort without
    - pushing anything.  Information about why the push is rejected may be sent
    - to the user by writing to standard error.
    - 
    -+Hooks executed during 'pre-push' will run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - [[pre-receive]]
    - pre-receive
    - ~~~~~~~~~~~
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## transport.c ##
    -@@
    - #include "protocol.h"
    - #include "object-store.h"
    - #include "color.h"
    -+#include "hook.h"
    - 
    - static int transport_use_color = -1;
    - static char transport_colors[][COLOR_MAXLEN] = {
     @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_pushing)
      static int run_pre_push_hook(struct transport *transport,
      			     struct ref *remote_refs)
      {
     -	int ret = 0, x;
     +	int ret = 0;
    -+	struct run_hooks_opt opt;
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	struct strbuf tmp = STRBUF_INIT;
      	struct ref *r;
     -	struct child_process proc = CHILD_PROCESS_INIT;
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
     -
     -	sigchain_push(SIGPIPE, SIG_IGN);
     +	struct string_list to_stdin = STRING_LIST_INIT_DUP;
    -+	run_hooks_opt_init_async(&opt);
      
     -	strbuf_init(&buf, 256);
     +	strvec_push(&opt.args, transport->remote->name);
28:  e43f9f93d7b ! 24:  f7c8c97cb81 reference-transaction: look for hooks in config
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    reference-transaction: look for hooks in config
    +    reference-transaction: use hook.h to run hooks
     
    -    By using the hook.h library, reference-transaction hooks can be
    -    specified in the config instead.
    -
    -    The expected output of the test is not fully updated to reflect the
    -    absolute path of the hook called because the 'update' hook has not yet
    -    been converted to use hook.h.
    +    By using the hook.h library, we get closer to removing the hook code
    +    in run-command.c.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: The exit status of the hook is ignored for any state except for the
    - cause the transaction to be aborted. The hook will not be called with
    - "aborted" state in that case.
    - 
    -+Hooks run during 'reference-transaction' will be run in parallel, unless
    -+hook.jobs is configured to 1.
    -+
    - push-to-checkout
    - ~~~~~~~~~~~~~~~~
    - 
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs.c ##
    -@@
    - #include "strvec.h"
    - #include "repository.h"
    - #include "sigchain.h"
    -+#include "hook.h"
    - 
    - /*
    -  * List of all available backends
     @@ refs.c: int ref_update_reject_duplicates(struct string_list *refnames,
      static int run_transaction_hook(struct ref_transaction *transaction,
      				const char *state)
    @@ refs.c: int ref_update_reject_duplicates(struct string_list *refnames,
     -	struct child_process proc = CHILD_PROCESS_INIT;
      	struct strbuf buf = STRBUF_INIT;
     -	const char *hook;
    -+	struct run_hooks_opt opt;
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	struct string_list to_stdin = STRING_LIST_INIT_DUP;
      	int ret = 0, i;
     +	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
      
     -	hook = find_hook("reference-transaction");
     -	if (!hook)
    --		return ret;
    --
    ++	if (!hook_exists("reference-transaction"))
    + 		return ret;
    + 
     -	strvec_pushl(&proc.args, hook, state, NULL);
     -	proc.in = -1;
     -	proc.stdout_to_stderr = 1;
     -	proc.trace2_hook_name = "reference-transaction";
    -+	run_hooks_opt_init_async(&opt);
    - 
    +-
     -	ret = start_command(&proc);
     -	if (ret)
    -+	if (!hook_exists("reference-transaction", HOOKDIR_USE_CONFIG))
    - 		return ret;
    - 
    +-		return ret;
    +-
     -	sigchain_push(SIGPIPE, SIG_IGN);
     +	strvec_push(&opt.args, state);
      
    @@ refs.c: int ref_update_reject_duplicates(struct string_list *refnames,
      	return ret;
      }
      
    -
    - ## t/t1416-ref-transaction-hooks.sh ##
    -@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '
    - 
    - 	cat >expect <<-EOF &&
    - 		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
    --		hooks/reference-transaction prepared
    --		hooks/reference-transaction committed
    -+		$(pwd)/target-repo.git/hooks/reference-transaction prepared
    -+		$(pwd)/target-repo.git/hooks/reference-transaction committed
    - 		hooks/update refs/tags/POST $ZERO_OID $POST_OID
    --		hooks/reference-transaction prepared
    --		hooks/reference-transaction committed
    -+		$(pwd)/target-repo.git/hooks/reference-transaction prepared
    -+		$(pwd)/target-repo.git/hooks/reference-transaction committed
    - 	EOF
    - 
    - 	git push ./target-repo.git PRE POST &&
    -
    - ## transport.c ##
    -@@ transport.c: static int run_pre_push_hook(struct transport *transport,
    - 	struct strbuf tmp = STRBUF_INIT;
    - 	struct ref *r;
    - 	struct string_list to_stdin = STRING_LIST_INIT_DUP;
    -+
    - 	run_hooks_opt_init_async(&opt);
    - 
    - 	strvec_push(&opt.args, transport->remote->name);
15:  84fe7a21976 ! 25:  f240a51ec4e run-command: allow capturing of collated output
    @@ Commit message
         instead hand it to the caller.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int fetch_multiple(struct string_list *list, int max_children)
    @@ builtin/submodule--helper.c: static int update_submodules(struct submodule_updat
      
     
      ## hook.c ##
    -@@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
    +@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
      				   pick_next_hook,
      				   notify_start_failure,
      				   options->feed_pipe,
16:  f23bcba44a0 ! 26:  7f10efb7858 hooks: allow callers to capture output
    @@ Commit message
         sideband instead of printing directly to stderr. Expose that capability.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## hook.c ##
    -@@ hook.c: void run_hooks_opt_init_sync(struct run_hooks_opt *o)
    - 	o->dir = NULL;
    - 	o->feed_pipe = NULL;
    - 	o->feed_pipe_ctx = NULL;
    -+	o->consume_sideband = NULL;
    - }
    - 
    - void run_hooks_opt_init_async(struct run_hooks_opt *o)
    -@@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
    +@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
      				   pick_next_hook,
      				   notify_start_failure,
      				   options->feed_pipe,
    @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *options)
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    + 	 */
      	feed_pipe_fn feed_pipe;
      	void *feed_pipe_ctx;
    - 
    ++
     +	/*
     +	 * Populate this to capture output and prevent it from being printed to
     +	 * stderr. This will be passed directly through to
    @@ hook.h: struct run_hooks_opt
     +	 * for an example.
     +	 */
     +	consume_sideband_fn consume_sideband;
    -+
    - 	/* Number of threads to parallelize across */
    - 	int jobs;
    + };
      
    + #define RUN_HOOKS_OPT_INIT { \
29:  7931831dc6e ! 27:  c39c608e5cc receive-pack: convert 'update' hook to hook.h
    @@ Metadata
      ## Commit message ##
         receive-pack: convert 'update' hook to hook.h
     
    -    By using hook.h to invoke the 'update' hook, now hooks can be specified
    -    in the config in addition to the hookdir.
    +    By using hook.h to invoke the 'update' hook we closer to removing the
    +    hooks code in run-command.c.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: The default 'update' hook, when enabled--and with
    - `hooks.allowunannotated` config option unset or set to false--prevents
    - unannotated tags to be pushed.
    - 
    -+Hooks executed during 'update' are run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - [[proc-receive]]
    - proc-receive
    - ~~~~~~~~~~~~
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/receive-pack.c ##
     @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      	return status;
      }
      
    +-static int run_update_hook(struct command *cmd)
     +static void hook_output_to_sideband(struct strbuf *output, void *cb_data)
    -+{
    + {
    +-	const char *argv[5];
    +-	struct child_process proc = CHILD_PROCESS_INIT;
    +-	int code;
     +	int keepalive_active = 0;
    -+
    + 
    +-	argv[0] = find_hook("update");
    +-	if (!argv[0])
    +-		return 0;
     +	if (keepalive_in_sec <= 0)
     +		use_keepalive = KEEPALIVE_NEVER;
     +	if (use_keepalive == KEEPALIVE_ALWAYS)
     +		keepalive_active = 1;
    -+
    + 
    +-	argv[1] = cmd->ref_name;
    +-	argv[2] = oid_to_hex(&cmd->old_oid);
    +-	argv[3] = oid_to_hex(&cmd->new_oid);
    +-	argv[4] = NULL;
     +	/* send a keepalive if there is no data to write */
     +	if (keepalive_active && !output->len) {
     +		static const char buf[] = "0005\1";
     +		write_or_die(1, buf, sizeof(buf) - 1);
     +		return;
     +	}
    -+
    + 
    +-	proc.no_stdin = 1;
    +-	proc.stdout_to_stderr = 1;
    +-	proc.err = use_sideband ? -1 : 0;
    +-	proc.argv = argv;
    +-	proc.trace2_hook_name = "update";
     +	if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
     +		const char *first_null = memchr(output->buf, '\0', output->len);
     +		if (first_null) {
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +	send_sideband(1, 2, output->buf, output->len, use_sideband);
     +}
     +
    - static int run_update_hook(struct command *cmd)
    - {
    --	const char *argv[5];
    --	struct child_process proc = CHILD_PROCESS_INIT;
    -+	struct run_hooks_opt opt;
    - 	int code;
    - 
    --	argv[0] = find_hook("update");
    --	if (!argv[0])
    --		return 0;
    -+	run_hooks_opt_init_async(&opt);
    - 
    --	argv[1] = cmd->ref_name;
    --	argv[2] = oid_to_hex(&cmd->old_oid);
    --	argv[3] = oid_to_hex(&cmd->new_oid);
    --	argv[4] = NULL;
    ++static int run_update_hook(struct command *cmd)
    ++{
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    ++	int code;
    ++
     +	strvec_pushl(&opt.args,
     +		     cmd->ref_name,
     +		     oid_to_hex(&cmd->old_oid),
     +		     oid_to_hex(&cmd->new_oid),
     +		     NULL);
      
    --	proc.no_stdin = 1;
    --	proc.stdout_to_stderr = 1;
    --	proc.err = use_sideband ? -1 : 0;
    --	proc.argv = argv;
    --	proc.trace2_hook_name = "update";
    --
     -	code = start_command(&proc);
     -	if (code)
     -		return code;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      }
      
      static struct command *find_command_by_refname(struct command *list,
    -
    - ## t/t1416-ref-transaction-hooks.sh ##
    -@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '
    - 	EOF
    - 
    - 	cat >expect <<-EOF &&
    --		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
    -+		$(pwd)/target-repo.git/hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
    - 		$(pwd)/target-repo.git/hooks/reference-transaction prepared
    - 		$(pwd)/target-repo.git/hooks/reference-transaction committed
    --		hooks/update refs/tags/POST $ZERO_OID $POST_OID
    -+		$(pwd)/target-repo.git/hooks/update refs/tags/POST $ZERO_OID $POST_OID
    - 		$(pwd)/target-repo.git/hooks/reference-transaction prepared
    - 		$(pwd)/target-repo.git/hooks/reference-transaction committed
    - 	EOF
31:  efbe55fcb13 ! 28:  3519068a634 post-update: use hook.h library
    @@ Commit message
         be specified in the config as well as the hookdir.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: Both standard output and standard error output are forwarded to
    - `git send-pack` on the other end, so you can simply `echo` messages
    - for the user.
    - 
    -+Hooks run during 'post-update' will be run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - reference-transaction
    - ~~~~~~~~~~~~~~~~~~~~~
    - 
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/receive-pack.c ##
     @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct shallow_info *si)
    @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
      	struct command *cmd;
     -	struct child_process proc = CHILD_PROCESS_INIT;
     -	const char *hook;
    -+	struct run_hooks_opt opt;
    - 
    +-
     -	hook = find_hook("post-update");
     -	if (!hook)
     -		return;
    -+	run_hooks_opt_init_async(&opt);
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
      
      	for (cmd = commands; cmd; cmd = cmd->next) {
      		if (cmd->error_string || cmd->did_not_exist)
32:  26e08bd5257 ! 29:  3466f17af08 receive-pack: convert receive hooks to hook.h
    @@ Metadata
      ## Commit message ##
         receive-pack: convert receive hooks to hook.h
     
    -    By using the hook.h library to run receive hooks, they can be specified
    -    in the config as well as in the hookdir.
    +    By using the hook.h library to run receive hooks we get closer to
    +    deleting the hook functions in run-command.c
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
    - See the section on "Quarantine Environment" in
    - linkgit:git-receive-pack[1] for some caveats.
    - 
    -+Hooks executed during 'pre-receive' will not be parallelized.
    -+
    - [[update]]
    - update
    - ~~~~~~
    -@@ Documentation/githooks.txt: environment variables will not be set. If the client selects
    - to use push options, but doesn't transmit any, the count variable
    - will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
    - 
    -+Hooks executed during 'post-receive' are run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - [[post-update]]
    - post-update
    - ~~~~~~~~~~~
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/receive-pack.c ##
     @@ builtin/receive-pack.c: static int check_cert_push_options(const struct string_list *push_options)
    @@ builtin/receive-pack.c: static void hook_output_to_sideband(struct strbuf *outpu
     +			    int skip_broken,
     +			    const struct string_list *push_options)
     +{
    -+	struct run_hooks_opt opt;
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	struct receive_hook_feed_context ctx;
     +	int rc;
     +	struct command *iter = commands;
     +
    -+	run_hooks_opt_init_async(&opt);
    -+
     +	/* if there are no valid commands, don't invoke the hook at all. */
     +	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
     +		iter = iter->next;
    @@ builtin/receive-pack.c: static void hook_output_to_sideband(struct strbuf *outpu
     +
      static int run_update_hook(struct command *cmd)
      {
    - 	struct run_hooks_opt opt;
    + 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
17:  edb22d675b7 ! 30:  d93bdc0c294 commit: use config-based hooks
    @@
      ## Metadata ##
    -Author: Emily Shaffer <emilyshaffer@google.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    commit: use config-based hooks
    +    hooks: fix a TOCTOU in "did we run a hook?" heuristic
     
    -    As part of the adoption of config-based hooks, teach run_commit_hook()
    -    to call hook.h instead of run-command.h. This covers 'pre-commit',
    -    'commit-msg', and 'prepare-commit-msg'. Additionally, ask the hook
    -    library - not run-command - whether any hooks will be run, as it's
    -    possible hooks may exist in the config but not the hookdir.
    +    Fix a race in code added in 680ee550d72 (commit: skip discarding the
    +    index if there is no pre-commit hook, 2017-08-14) by changing the
    +    hook.c API to optionally indicate whether or not the requested hook
    +    ran or not. This was suggested in the discussion around
    +    680ee550d72[1].
     
    -    Because all but 'post-commit' hooks are expected to make some state
    -    change, force all but 'post-commit' hook to run in series. 'post-commit'
    -    "is meant primarily for notification, and cannot affect the outcome of
    -    `git commit`," so it is fine to run in parallel.
    +    Let's also change this for the pre-merge-commit hook, see
    +    6098817fd7f (git-merge: honor pre-merge-commit hook, 2019-08-07) for
    +    the introduction of the previous behavior.
     
    -    Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Let's also change this for the push-to-checkout hook. Now instead of
    +    checking if the hook exists and either doing a push to checkout or a
    +    push to deploy we'll always attempt a push to checkout. If the hook
    +    doesn't exist we'll fall back on push to deploy. The same behavior as
    +    before, without the TOCTOU race. See 0855331941b (receive-pack:
    +    support push-to-checkout hook, 2014-12-01) for the introduction of the
    +    previous behavior.
     
    - ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: The default 'pre-commit' hook, when enabled--and with the
    - `hooks.allownonascii` config option unset or set to false--prevents
    - the use of non-ASCII filenames.
    - 
    -+Hooks executed during 'pre-commit' will not be parallelized.
    -+
    - pre-merge-commit
    - ~~~~~~~~~~~~~~~~
    - 
    -@@ Documentation/githooks.txt: need to be resolved and the result committed separately (see
    - linkgit:git-merge[1]). At that point, this hook will not be executed,
    - but the 'pre-commit' hook will, if it is enabled.
    - 
    -+Hooks executed during 'pre-merge-commit' will not be parallelized.
    -+
    - prepare-commit-msg
    - ~~~~~~~~~~~~~~~~~~
    - 
    -@@ Documentation/githooks.txt: be used as replacement for pre-commit hook.
    - The sample `prepare-commit-msg` hook that comes with Git removes the
    - help message found in the commented portion of the commit template.
    - 
    -+Hooks executed during 'prepare-commit-msg' will not be parallelized, because
    -+hooks are expected to edit the file containing the commit log message.
    -+
    - commit-msg
    - ~~~~~~~~~~
    - 
    -@@ Documentation/githooks.txt: file.
    - The default 'commit-msg' hook, when enabled, detects duplicate
    - `Signed-off-by` trailers, and aborts the commit if one is found.
    - 
    -+Hooks executed during 'commit-msg' will not be parallelized, because hooks are
    -+expected to edit the file containing the proposed commit log message.
    -+
    - post-commit
    - ~~~~~~~~~~~
    - 
    -@@ Documentation/githooks.txt: invoked after a commit is made.
    - This hook is meant primarily for notification, and cannot affect
    - the outcome of `git commit`.
    - 
    -+Hooks executed during 'post-commit' will run in parallel, unless hook.jobs is
    -+configured to 1.
    -+
    - pre-rebase
    - ~~~~~~~~~~
    - 
    +    This leaves uses of hook_exists() in two places that matter. The
    +    "reference-transaction" check in refs.c, see 67541597670 (refs:
    +    implement reference transaction hook, 2020-06-19), and the
    +    prepare-commit-msg hook, see 66618a50f9c (sequencer: run
    +    'prepare-commit-msg' hook, 2018-01-24).
    +
    +    In both of those cases we're saving ourselves CPU time by not
    +    preparing data for the hook that we'll then do nothing with if we
    +    don't have the hook, so using this "invoked_hook" pattern doesn't make
    +    sense there purely for optimization purposes.
    +
    +    More importantly, in those cases the worst we'll do is miss that we
    +    "should" run the hook because a new hook appeared, whereas in the
    +    pre-commit and pre-merge-commit cases we'll skip an important
    +    discard_cache() on the bases of our faulty guess.
    +
    +    I do think none of these races really matter in practice. It would be
    +    some one-off issue as a hook was added or removed. I did think it was
    +    stupid that we didn't pass a "did this run?" flag instead of doing
    +    this guessing at a distance though, so now we're not guessing anymore.
    +
    +    1. https://lore.kernel.org/git/20170810191613.kpmhzg4seyxy3cpq@sigill.intra.peff.net/
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/commit.c ##
    -@@
    - #include "help.h"
    - #include "commit-reach.h"
    - #include "commit-graph.h"
    -+#include "hook.h"
    - 
    - static const char * const builtin_commit_usage[] = {
    - 	N_("git commit [<options>] [--] <pathspec>..."),
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
    + 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
    + 	int old_display_comment_prefix;
    + 	int merge_contains_scissors = 0;
    ++	int invoked_hook = 0;
    + 
      	/* This checks and barfs if author is badly specified */
      	determine_author_info(author_ident);
      
     -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
    -+	if (!no_verify && run_commit_hook(use_editor, 0, index_file, "pre-commit", NULL))
    ++	if (!no_verify && run_commit_hook(use_editor, index_file, &invoked_hook,
    ++					  "pre-commit", NULL))
      		return 0;
      
      	if (squash_message) {
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      		return 0;
      	}
      
    --	if (!no_verify && find_hook("pre-commit")) {
    -+	if (!no_verify && hook_exists("pre-commit", HOOKDIR_USE_CONFIG)) {
    +-	if (!no_verify && hook_exists("pre-commit")) {
    ++	if (!no_verify && invoked_hook) {
      		/*
    - 		 * Re-read the index as pre-commit hook could have updated it,
    - 		 * and write it out as a tree.  We must do this before we invoke
    +-		 * Re-read the index as pre-commit hook could have updated it,
    +-		 * and write it out as a tree.  We must do this before we invoke
    ++		 * Re-read the index as the pre-commit-commit hook was invoked
    ++		 * and could have updated it. We must do this before we invoke
    + 		 * the editor and after we invoke run_status above.
    + 		 */
    + 		discard_cache();
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
      		return 0;
      	}
      
     -	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
    -+	if (run_commit_hook(use_editor, 0, index_file, "prepare-commit-msg",
    ++	if (run_commit_hook(use_editor, index_file, NULL, "prepare-commit-msg",
      			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
      		return 0;
      
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      
      	if (!no_verify &&
     -	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
    -+	    run_commit_hook(use_editor, 0, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
    ++	    run_commit_hook(use_editor, index_file, NULL, "commit-msg",
    ++			    git_path_commit_editmsg(), NULL)) {
      		return 0;
      	}
      
    @@ builtin/commit.c: int cmd_commit(int argc, const char **argv, const char *prefix
      	repo_rerere(the_repository, 0);
      	run_auto_maintenance(quiet);
     -	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
    -+	run_commit_hook(use_editor, 1, get_index_file(), "post-commit", NULL);
    ++	run_commit_hook(use_editor, get_index_file(), NULL, "post-commit",
    ++			NULL);
      	if (amend && !no_post_rewrite) {
      		commit_post_rewrite(the_repository, current_head, &oid);
      	}
     
      ## builtin/merge.c ##
    -@@
    - #include "commit-reach.h"
    - #include "wt-status.h"
    - #include "commit-graph.h"
    -+#include "hook.h"
    - 
    - #define DEFAULT_TWOHEAD (1<<0)
    - #define DEFAULT_OCTOPUS (1<<1)
     @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
    + {
      	struct strbuf msg = STRBUF_INIT;
      	const char *index_file = get_index_file();
    ++	int invoked_hook = 0;
      
     -	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
    -+	if (!no_verify && run_commit_hook(0 < option_edit, 0, index_file, "pre-merge-commit", NULL))
    ++	if (!no_verify && run_commit_hook(0 < option_edit, index_file,
    ++					  &invoked_hook, "pre-merge-commit",
    ++					  NULL))
      		abort_commit(remoteheads, NULL);
      	/*
    - 	 * Re-read the index as pre-merge-commit hook could have updated it,
    - 	 * and write it out as a tree.  We must do this before we invoke
    +-	 * Re-read the index as pre-merge-commit hook could have updated it,
    +-	 * and write it out as a tree.  We must do this before we invoke
    ++	 * Re-read the index as the pre-merge-commit hook was invoked
    ++	 * and could have updated it. We must do this before we invoke
      	 * the editor and after we invoke run_status above.
      	 */
    --	if (find_hook("pre-merge-commit"))
    -+	if (hook_exists("pre-merge-commit", HOOKDIR_USE_CONFIG))
    +-	if (hook_exists("pre-merge-commit"))
    ++	if (invoked_hook)
      		discard_cache();
      	read_cache_from(index_file);
      	strbuf_addbuf(&msg, &merge_msg);
    @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
      	write_merge_heads(remoteheads);
      	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
     -	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
    -+	if (run_commit_hook(0 < option_edit, 0, get_index_file(), "prepare-commit-msg",
    ++	if (run_commit_hook(0 < option_edit, get_index_file(), NULL,
    ++			    "prepare-commit-msg",
      			    git_path_merge_msg(the_repository), "merge", NULL))
      		abort_commit(remoteheads, NULL);
      	if (0 < option_edit) {
     @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
    - 			abort_commit(remoteheads, NULL);
      	}
      
    --	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
    -+	if (!no_verify && run_commit_hook(0 < option_edit, 0, get_index_file(),
    - 					  "commit-msg",
    + 	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
    +-					  "commit-msg",
    ++					  NULL, "commit-msg",
      					  git_path_merge_msg(the_repository), NULL))
      		abort_commit(remoteheads, NULL);
    -
    - ## commit.c ##
    -@@
    - #include "commit-reach.h"
    - #include "run-command.h"
    - #include "shallow.h"
    -+#include "hook.h"
      
    - static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
    - 
    -@@ commit.c: size_t ignore_non_trailer(const char *buf, size_t len)
    - 	return boc ? len - boc : len - cutoff;
    - }
    +
    + ## builtin/receive-pack.c ##
    +@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    + static const char *push_to_checkout_hook = "push-to-checkout";
    + 
    + static const char *push_to_checkout(unsigned char *hash,
    ++				    int *invoked_hook,
    + 				    struct strvec *env,
    + 				    const char *work_tree)
    + {
    + 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    ++	opt.invoked_hook = invoked_hook;
      
    --int run_commit_hook(int editor_is_used, const char *index_file,
    -+int run_commit_hook(int editor_is_used, int parallelize, const char *index_file,
    - 		    const char *name, ...)
    + 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
    + 	strvec_pushv(&opt.env, env->v);
    +@@ builtin/receive-pack.c: static const char *update_worktree(unsigned char *sha1, const struct worktree *w
      {
    --	struct strvec hook_env = STRVEC_INIT;
    -+	struct run_hooks_opt opt;
    - 	va_list args;
    -+	const char *arg;
    - 	int ret;
    + 	const char *retval, *work_tree, *git_dir = NULL;
    + 	struct strvec env = STRVEC_INIT;
    ++	int invoked_hook = 0;
      
    --	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
    -+	run_hooks_opt_init_sync(&opt);
    -+
    -+	if (parallelize)
    -+		opt.jobs = configured_hook_jobs();
    -+
    -+	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
    + 	if (worktree && worktree->path)
    + 		work_tree = worktree->path;
    +@@ builtin/receive-pack.c: static const char *update_worktree(unsigned char *sha1, const struct worktree *w
      
    - 	/*
    - 	 * Let the hook know that no editor will be launched.
    - 	 */
    - 	if (!editor_is_used)
    --		strvec_push(&hook_env, "GIT_EDITOR=:");
    -+		strvec_push(&opt.env, "GIT_EDITOR=:");
    + 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
      
    - 	va_start(args, name);
    --	ret = run_hook_ve(hook_env.v, name, args);
    -+	while ((arg = va_arg(args, const char *)))
    -+		strvec_push(&opt.args, arg);
    - 	va_end(args);
    --	strvec_clear(&hook_env);
    -+
    -+	ret = run_hooks(name, &opt);
    -+	run_hooks_opt_clear(&opt);
    +-	if (!hook_exists(push_to_checkout_hook))
    ++	retval = push_to_checkout(sha1, &invoked_hook, &env, work_tree);
    ++	if (!invoked_hook)
    + 		retval = push_to_deploy(sha1, &env, work_tree);
    +-	else
    +-		retval = push_to_checkout(sha1, &env, work_tree);
      
    - 	return ret;
    + 	strvec_clear(&env);
    + 	return retval;
    +
    + ## commit.c ##
    +@@ commit.c: size_t ignore_non_trailer(const char *buf, size_t len)
      }
    + 
    + int run_commit_hook(int editor_is_used, const char *index_file,
    ++		    int *invoked_hook,
    + 		    const char *name, ...)
    + {
    + 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     
      ## commit.h ##
     @@ commit.h: int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
    @@ commit.h: int compare_commits_by_commit_date(const void *a_, const void *b_, voi
      
      LAST_ARG_MUST_BE_NULL
     -int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
    -+int run_commit_hook(int editor_is_used, int parallelize, const char *index_file,
    -+		    const char *name, ...);
    ++int run_commit_hook(int editor_is_used, const char *index_file,
    ++		    int *invoked_hook, const char *name, ...);
      
      /* Sign a commit or tag buffer, storing the result in a header. */
      int sign_with_header(struct strbuf *buf, const char *keyid);
     
    - ## sequencer.c ##
    -@@
    - #include "commit-reach.h"
    - #include "rebase-interactive.h"
    - #include "reset.h"
    -+#include "hook.h"
    + ## hook.c ##
    +@@ hook.c: static int notify_hook_finished(int result,
    + 	/* |= rc in cb */
    + 	hook_cb->rc |= result;
      
    - #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
    ++	if (hook_cb->invoked_hook)
    ++		*hook_cb->invoked_hook = 1;
    ++
    + 	return 1;
    + }
      
    +@@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
    + 		.rc = 0,
    + 		.hook_name = hook_name,
    + 		.options = options,
    ++		.invoked_hook = options->invoked_hook,
    + 	};
    + 	if (options->absolute_path) {
    + 		strbuf_add_absolute_path(&abs_path, hook_path);
    +
    + ## hook.h ##
    +@@ hook.h: struct run_hooks_opt
    + 	 * for an example.
    + 	 */
    + 	consume_sideband_fn consume_sideband;
    ++
    ++	/*
    ++	 * A pointer which if provided will be set to 1 or 0 depending
    ++	 * on if a hook was invoked (i.e. existed), regardless of
    ++	 * whether or not that was successful. Used for avoiding
    ++	 * TOCTOU races in code that would otherwise call hook_exist()
    ++	 * after a "maybe hook run" to see if a hook was invoked.
    ++	 */
    ++	int *invoked_hook;
    + };
    + 
    + #define RUN_HOOKS_OPT_INIT { \
    +@@ hook.h: struct hook_cb_data {
    + 	const char *hook_name;
    + 	struct hook *run_me;
    + 	struct run_hooks_opt *options;
    ++	int *invoked_hook;
    + };
    + 
    + /*
    +
    + ## sequencer.c ##
     @@ sequencer.c: static int run_prepare_commit_msg_hook(struct repository *r,
      	} else {
      		arg1 = "message";
      	}
     -	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
    -+	if (run_commit_hook(0, 0, r->index_file, "prepare-commit-msg", name,
    ++	if (run_commit_hook(0, r->index_file, NULL, "prepare-commit-msg", name,
      			    arg1, arg2, NULL))
      		ret = error(_("'prepare-commit-msg' hook failed"));
      
    -@@ sequencer.c: static int try_to_commit(struct repository *r,
    - 		}
    - 	}
    - 
    --	if (find_hook("prepare-commit-msg")) {
    -+	if (hook_exists("prepare-commit-msg", HOOKDIR_USE_CONFIG)) {
    - 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
    - 		if (res)
    - 			goto out;
     @@ sequencer.c: static int try_to_commit(struct repository *r,
      		goto out;
      	}
      
     -	run_commit_hook(0, r->index_file, "post-commit", NULL);
    -+	run_commit_hook(0, 1, r->index_file, "post-commit", NULL);
    ++	run_commit_hook(0, r->index_file, NULL, "post-commit", NULL);
      	if (flags & AMEND_MSG)
      		commit_post_rewrite(r, current_head, oid);
      
    -
    - ## t/t7503-pre-commit-and-pre-merge-commit-hooks.sh ##
    -@@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - . ./test-lib.sh
    - 
    - HOOKDIR="$(git rev-parse --git-dir)/hooks"
    --PRECOMMIT="$HOOKDIR/pre-commit"
    --PREMERGE="$HOOKDIR/pre-merge-commit"
    -+PRECOMMIT="$(pwd)/$HOOKDIR/pre-commit"
    -+PREMERGE="$(pwd)/$HOOKDIR/pre-merge-commit"
    - 
    - # Prepare sample scripts that write their $0 to actual_hooks
    - test_expect_success 'sample script setup' '
    -@@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'with succeeding hook' '
    - 	test_cmp expected_hooks actual_hooks
    - '
    - 
    -+# NEEDSWORK: when 'git hook add' and 'git hook remove' have been added, use that
    -+# instead
    -+test_expect_success 'with succeeding hook (config-based)' '
    -+	test_when_finished "git config --unset hook.pre-commit.command success.sample" &&
    -+	test_when_finished "rm -f expected_hooks actual_hooks" &&
    -+	git config hook.pre-commit.command "$HOOKDIR/success.sample" &&
    -+	echo "$HOOKDIR/success.sample" >expected_hooks &&
    -+	echo "more" >>file &&
    -+	git add file &&
    -+	git commit -m "more" &&
    -+	test_cmp expected_hooks actual_hooks
    -+'
    -+
    - test_expect_success 'with succeeding hook (merge)' '
    - 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
    - 	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
30:  c9d8c1581de <  -:  ----------- proc-receive: acquire hook list from hook.h
36:  4caea3e6805 <  -:  ----------- doc: clarify fsmonitor-watchman specification
37:  f2e1003b62a <  -:  ----------- docs: link githooks and git-hook manpages
 -:  ----------- > 31:  896956250f6 hook-list.h: add a generated list of hooks, like config-list.h
-- 
2.32.0.rc1.458.gd885d4f985c

