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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E7DC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C301861245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhFQKZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhFQKZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB92C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n20so3248841edv.8
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9ORIR4QGQ2QiNe0aKhi9gzbd4igkRsg7+bpQAxRTJ0=;
        b=f27+UzP7+Y2/2QKvXUXHRwPAK7V75N8/Ee2Kuei443HOFsYHwqBi+H6uEYg3xW539B
         7Xt67AR01cvpVGS+Somn8nRHDB/Tp7J8BHszj+mjozThfONX5oo+iU7TPKsJeZO/y99H
         RPX1VfP47bF22xh81WhI3PKlURRNr6ylIiwzWtR41BynR6yLk1pVTLMQznTW0gYgXz/1
         +Kh8P4xeXkIoIN1ZzV/05Lkatt9bIcOHSE/zz+g+natfvLqkElu7u+ZfcbV93a93zcjU
         /6ZGUFAVZ4NnhQcNYaOm1HLn8qY9jB20cVZGrgWcP24oBC7fEsb9SAe9kS7el9VHW4WZ
         /NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9ORIR4QGQ2QiNe0aKhi9gzbd4igkRsg7+bpQAxRTJ0=;
        b=qszZMiZ5y3+meAIqjAD2ArC8eIkVEac4K4+yE9wNc21c3zOJ1i5P7Vj+vsAuSZHAK0
         srt2IQJRZzKzCGKDkdJMfFhRTN3dp+en9bo4yeUXGmC9ShwKKRQhwcdAZ10sCwKcH4FW
         THk60M1s5AAAIMCZug/F3jXJtu3OYaGHOPOAsm9AiAMTx1QzBdj4g3PWg2+8C3wdtOwI
         0BIaYfW6twxaZdxa/KwsPqCXIK3+IWWdEXIPYNWBmNlQ606lsfJrOpKr0+/5YCzAqTaC
         R0eotE0bRfbHoN1UiHkB4Guqbi+O1npn11OqysiWprV1r5L0Jo0CPRMPpnZyGjD28Ypj
         0BdA==
X-Gm-Message-State: AOAM533Pi5QYwUvLsJTSWrYphPK4cGGwoG2ukno3aRToM2FS4S6QgIz3
        5FTpaZ2SxahIrM3W3LRamTAmJBNTPWBpxA==
X-Google-Smtp-Source: ABdhPJwWsXHxQmC8adCvXL8NT0z2pUySDdkBroShtjjT9knGuW1zJmNXdmeDxQBknv3q7XDTRedP6g==
X-Received: by 2002:aa7:c3ce:: with SMTP id l14mr5449219edr.99.1623925388199;
        Thu, 17 Jun 2021 03:23:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:07 -0700 (PDT)
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
Subject: [PATCH 00/27] Base for "config-based-hooks"
Date:   Thu, 17 Jun 2021 12:22:34 +0200
Message-Id: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v3 of the "Base for 'config-based-hooks'" topic is >95% a
slimmed-down versio nof Emily Schaffer's work to introduce a mechanism
to drive hooks via config.

This topic doesn't do that, but moves all hook execution (C libary and
Perl|Python script) to either the new hook.[ch] library code, or the
"git hook run" utility.

See previous iterations for more details:

 v0 (Emily's): http://lore.kernel.org/git/20210527000856.695702-1-emilyshaffer@google.com
 v1: https://lore.kernel.org/git/cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com/
 v2: http://lore.kernel.org/git/cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com

This series gained two new dependencies since v2, my just-submitted
preparatory topics:

    https://lore.kernel.org/git/cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com/
    https://lore.kernel.org/git/cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com/

And hopefully addreses all the feedback on v2, mainly/entirely from
Emily at https://lore.kernel.org/git/YMfLO9CT+iIDR3OA@google.com

I'd normally have waited longer for a v3, but as discussed in the
small hook.[ch] topic that precedes this one building the new
hook-list.h had an error on Windows CI due to a missing CMake change,
that's now fixed.

Other changes can be seen in the range-diff, all rather trivial fixes
like comment fixes, trimming off "argc/argv" before we pass things to
"git hook run", removing a redundant test setup etc.

I also added a GIT_TEST_FAKE_HOOKS=true for use in the test suite to
make us support a "test-hook" and a "does-not-exist" hook, we'd
previously accept those outside the test environment.

Emily Shaffer (25):
  hook: add 'run' subcommand
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
  run-command: remove old run_hook_{le,ve}() hook API
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

Ævar Arnfjörð Bjarmason (2):
  git hook run: add an --ignore-missing flag
  hooks: fix a TOCTOU in "did we run a hook?" heuristic

 .gitignore                  |   1 +
 Documentation/git-hook.txt  |  51 ++++++
 Documentation/githooks.txt  |   4 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/am.c                |  33 ++--
 builtin/checkout.c          |  17 +-
 builtin/clone.c             |   7 +-
 builtin/commit.c            |  18 ++-
 builtin/fetch.c             |   1 +
 builtin/gc.c                |   8 +-
 builtin/hook.c              |  90 +++++++++++
 builtin/merge.c             |  21 ++-
 builtin/rebase.c            |   9 +-
 builtin/receive-pack.c      | 298 ++++++++++++++++++------------------
 builtin/submodule--helper.c |   2 +-
 builtin/worktree.c          |  30 ++--
 command-list.txt            |   1 +
 commit.c                    |  17 +-
 commit.h                    |   3 +-
 git-p4.py                   |  72 +--------
 git-send-email.perl         |  20 ++-
 git.c                       |   1 +
 hook.c                      | 170 ++++++++++++++++++++
 hook.h                      | 109 +++++++++++++
 read-cache.c                |  12 +-
 refs.c                      |  42 ++---
 reset.c                     |  15 +-
 run-command.c               | 122 ++++++++++-----
 run-command.h               |  48 ++++--
 sequencer.c                 |  87 +++++------
 submodule.c                 |   1 +
 t/helper/test-run-command.c |  46 +++++-
 t/t0061-run-command.sh      |  37 +++++
 t/t1800-hook.sh             | 154 +++++++++++++++++++
 t/t9001-send-email.sh       |   4 +-
 transport.c                 |  57 ++-----
 37 files changed, 1136 insertions(+), 474 deletions(-)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

Range-diff:
 1:  447d349c73 !  1:  cf4b06bfdf hook: add 'run' subcommand
    @@ Documentation/git-hook.txt (new)
     +-----------
     +
     +run::
    -+
    -+	Run the `<hook-name>` hook. Any positional arguments to the
    -+	hook should be passed after an optional "--" (or
    -+	"--end-of-options"). See "OPTIONS" below for the arguments
    -+	this accepts.
    ++	Run the `<hook-name>` hook. See linkgit:githooks[5] for
    ++	the hook names we support.
    +++
    ++Any positional arguments to the hook should be passed after an
    ++optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
    ++arguments (if any) differ by hook name, see linkgit:githooks[5] for
    ++what those are.
     +
     +SEE ALSO
     +--------
    @@ Documentation/githooks.txt: and "0" meaning they were not.
      Part of the linkgit:git[1] suite
     
      ## Makefile ##
    -@@ Makefile: LIB_OBJS += hash-lookup.o
    - LIB_OBJS += hashmap.o
    - LIB_OBJS += help.o
    - LIB_OBJS += hex.o
    -+LIB_OBJS += hook.o
    - LIB_OBJS += ident.o
    - LIB_OBJS += json-writer.o
    - LIB_OBJS += kwset.o
     @@ Makefile: BUILTIN_OBJS += builtin/get-tar-commit-id.o
      BUILTIN_OBJS += builtin/grep.o
      BUILTIN_OBJS += builtin/hash-object.o
    @@ builtin/hook.c (new)
     +#include "strvec.h"
     +
     +static const char * const builtin_hook_usage[] = {
    ++	N_("git hook <command> [...]"),
    ++	N_("git hook run <hook-name> [-- <hook-args>]"),
    ++	NULL
    ++};
    ++
    ++static const char * const builtin_hook_run_usage[] = {
     +	N_("git hook run <hook-name> [-- <hook-args>]"),
     +	NULL
     +};
    @@ builtin/hook.c (new)
     +	};
     +
     +	argc = parse_options(argc, argv, prefix, run_options,
    -+			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
    ++			     builtin_hook_run_usage,
    ++			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
     +
    -+	if (argc > 2) {
    -+		if (strcmp(argv[2], "--") &&
    -+		    strcmp(argv[2], "--end-of-options"))
    ++	if (argc > 1) {
    ++		if (strcmp(argv[1], "--") &&
    ++		    strcmp(argv[1], "--end-of-options"))
     +			/* Having a -- for "run" is mandatory */
     +			usage_with_options(builtin_hook_usage, run_options);
     +		/* Add our arguments, start after -- */
    -+		for (i = 3 ; i < argc; i++)
    ++		for (i = 2 ; i < argc; i++)
     +			strvec_push(&opt.args, argv[i]);
     +	}
     +
     +	/* Need to take into account core.hooksPath */
     +	git_config(git_default_config, NULL);
     +
    -+	hook_name = argv[1];
    ++	/*
    ++	 * We are not using run_hooks() because we'd like to detect
    ++	 * missing hooks. Let's find it ourselves and call
    ++	 * run_found_hooks() instead.
    ++	 */
    ++	hook_name = argv[0];
     +	hook_path = find_hook(hook_name);
     +	if (!hook_path) {
     +		error("cannot find a hook named %s", hook_name);
    @@ builtin/hook.c (new)
     +	struct option builtin_hook_options[] = {
     +		OPT_END(),
     +	};
    ++	argc = parse_options(argc, argv, NULL, builtin_hook_options,
    ++			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
    ++	if (!argc)
    ++		usage_with_options(builtin_hook_usage, builtin_hook_options);
     +
    -+	if (!strcmp(argv[1], "run"))
    ++	if (!strcmp(argv[0], "run"))
     +		return run(argc, argv, prefix);
    -+	usage_with_options(builtin_hook_usage, builtin_hook_options);
    -+	return 1;
    ++	else
    ++		usage_with_options(builtin_hook_usage, builtin_hook_options);
     +}
     
      ## command-list.txt ##
    @@ git.c: static struct cmd_struct commands[] = {
      	{ "init", cmd_init_db },
      	{ "init-db", cmd_init_db },
     
    - ## hook.c (new) ##
    + ## hook.c ##
     @@
    -+#include "cache.h"
    -+#include "hook.h"
    -+#include "run-command.h"
    + #include "hook.h"
    + #include "run-command.h"
    + #include "hook-list.h"
    ++#include "config.h"
    + 
    + static int known_hook(const char *name)
    + {
    + 	const char **p;
    + 	size_t len = strlen(name);
    ++	static int test_hooks_ok = -1;
    ++
    + 	for (p = hook_name_list; *p; p++) {
    + 		const char *hook = *p;
    + 
    +@@ hook.c: static int known_hook(const char *name)
    + 			return 1;
    + 	}
    + 
    ++	if (test_hooks_ok == -1)
    ++		test_hooks_ok = git_env_bool("GIT_TEST_FAKE_HOOKS", 0);
    ++
    ++	if (test_hooks_ok &&
    ++	    (!strcmp(name, "test-hook") ||
    ++	     !strcmp(name, "does-not-exist")))
    ++		return 1;
    ++
    + 	return 0;
    + }
    + 
    +@@ hook.c: int hook_exists(const char *name)
    + {
    + 	return !!find_hook(name);
    + }
     +
     +void run_hooks_opt_clear(struct run_hooks_opt *o)
     +{
    @@ hook.c (new)
     +	struct hook_cb_data *hook_cb = pp_cb;
     +	struct hook *run_me = hook_cb->run_me;
     +
    -+	if (!run_me)
    -+		BUG("did we not return 1 in notify_hook_finished?");
    -+
     +	cp->no_stdin = 1;
     +	cp->env = hook_cb->options->env.v;
     +	cp->stdout_to_stderr = 1;
    @@ hook.c (new)
     +	struct hook_cb_data *hook_cb = pp_cb;
     +	struct hook *attempted = pp_task_cp;
     +
    -+	/* |= rc in cb */
     +	hook_cb->rc |= 1;
     +
     +	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
    @@ hook.c (new)
     +{
     +	struct hook_cb_data *hook_cb = pp_cb;
     +
    -+	/* |= rc in cb */
     +	hook_cb->rc |= result;
     +
     +	return 1;
     +}
     +
    -+
     +int run_found_hooks(const char *hook_name, const char *hook_path,
     +		    struct run_hooks_opt *options)
     +{
    @@ hook.c (new)
     +
     +	hook_path = find_hook(hook_name);
     +
    -+	/* Care about nonexistence? Use run_found_hooks() */
    ++	/*
    ++	 * If you need to act on a missing hook, use run_found_hooks()
    ++	 * instead
    ++	 */
     +	if (!hook_path)
     +		return 0;
     +
    @@ hook.c (new)
     +	return ret;
     +}
     
    - ## hook.h (new) ##
    + ## hook.h ##
     @@
    -+#ifndef HOOK_H
    -+#define HOOK_H
    + #ifndef HOOK_H
    + #define HOOK_H
     +#include "strbuf.h"
     +#include "strvec.h"
     +#include "run-command.h"
    -+
    + 
    + /*
    +  * Returns the path to the hook file, or NULL if the hook is missing
    +@@ hook.h: const char *find_hook(const char *name);
    +  */
    + int hook_exists(const char *hookname);
    + 
     +struct hook {
     +	/* The path to the hook */
     +	const char *hook_path;
    @@ hook.h (new)
     +	/* Args to be passed to each hook */
     +	struct strvec args;
     +
    -+	/* Number of threads to parallelize across */
    ++	/*
    ++	 * Number of threads to parallelize across, currently a stub,
    ++	 * we use the parallel API for future-proofing, but we always
    ++	 * have one hook of a given name, so this is always an
    ++	 * implicit 1 for now.
    ++	 */
     +	int jobs;
     +};
     +
    @@ hook.h (new)
     +	.args = STRVEC_INIT, \
     +}
     +
    -+/*
    -+ * Callback provided to feed_pipe_fn and consume_sideband_fn.
    -+ */
     +struct hook_cb_data {
    ++	/* rc reflects the cumulative failure state */
     +	int rc;
     +	const char *hook_name;
     +	struct hook *run_me;
    @@ hook.h (new)
     + */
     +int run_found_hooks(const char *hookname, const char *hook_path,
     +		    struct run_hooks_opt *options);
    -+#endif
    + #endif
     
      ## t/t1800-hook.sh (new) ##
     @@
    @@ t/t1800-hook.sh (new)
     +
     +. ./test-lib.sh
     +
    -+test_expect_success 'git hook run -- nonexistent hook' '
    ++test_expect_success 'git hook usage' '
    ++	test_expect_code 129 git hook &&
    ++	test_expect_code 129 git hook -h &&
    ++	test_expect_code 129 git hook run -h
    ++'
    ++
    ++test_expect_success 'setup GIT_TEST_FAKE_HOOKS=true to permit "test-hook" and "does-not-exist" names"' '
    ++	GIT_TEST_FAKE_HOOKS=true &&
    ++	export GIT_TEST_FAKE_HOOKS
    ++'
    ++
    ++test_expect_success 'git hook run: nonexistent hook' '
     +	cat >stderr.expect <<-\EOF &&
    -+	error: cannot find a hook named does-not-exist
    ++	error: cannot find a hook named test-hook
     +	EOF
    -+	test_expect_code 1 git hook run does-not-exist 2>stderr.actual &&
    ++	test_expect_code 1 git hook run test-hook 2>stderr.actual &&
     +	test_cmp stderr.expect stderr.actual
     +'
     +
    -+test_expect_success 'git hook run -- basic' '
    ++test_expect_success 'git hook run: basic' '
     +	write_script .git/hooks/test-hook <<-EOF &&
     +	echo Test hook
     +	EOF
    @@ t/t1800-hook.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'git hook run -- stdout and stderr handling' '
    ++test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
     +	write_script .git/hooks/test-hook <<-EOF &&
     +	echo >&1 Will end up on stderr
     +	echo >&2 Will end up on stderr
    @@ t/t1800-hook.sh (new)
     +	test_must_be_empty stdout.actual
     +'
     +
    -+test_expect_success 'git hook run -- exit codes are passed along' '
    ++test_expect_success 'git hook run: exit codes are passed along' '
     +	write_script .git/hooks/test-hook <<-EOF &&
     +	exit 1
     +	EOF
    @@ t/t1800-hook.sh (new)
     +
     +test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
     +	mkdir my-hooks &&
    -+	write_script my-hooks/test-hook <<-EOF &&
    -+	echo Hook ran >>actual
    ++	write_script my-hooks/test-hook <<-\EOF &&
    ++	echo Hook ran $1 >>actual
     +	EOF
     +
     +	cat >expect <<-\EOF &&
     +	Test hook
    -+	Hook ran
    -+	Hook ran
    -+	Hook ran
    -+	Hook ran
    ++	Hook ran one
    ++	Hook ran two
    ++	Hook ran three
    ++	Hook ran four
     +	EOF
     +
     +	# Test various ways of specifying the path. See also
     +	# t1350-config-hooks-path.sh
     +	>actual &&
    -+	git hook run test-hook 2>>actual &&
    -+	git -c core.hooksPath=my-hooks hook run test-hook 2>>actual &&
    -+	git -c core.hooksPath=my-hooks/ hook run test-hook 2>>actual &&
    -+	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook 2>>actual &&
    -+	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook 2>>actual &&
    ++	git hook run test-hook -- ignored 2>>actual &&
    ++	git -c core.hooksPath=my-hooks hook run test-hook -- one 2>>actual &&
    ++	git -c core.hooksPath=my-hooks/ hook run test-hook -- two 2>>actual &&
    ++	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook -- three 2>>actual &&
    ++	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook -- four 2>>actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'set up a pre-commit hook in core.hooksPath' '
    -+	>actual &&
    -+	mkdir -p .git/custom-hooks .git/hooks &&
    -+	write_script .git/custom-hooks/pre-commit <<-\EOF &&
    -+	echo CUSTOM >>actual
    -+	EOF
    -+	write_script .git/hooks/pre-commit <<-\EOF
    -+	echo NORMAL >>actual
    -+	EOF
    -+'
    -+
     +test_done
 2:  85195a78cf <  -:  ---------- run-command.h: move find_hook() to hook.h
 3:  eb5bdd993c <  -:  ---------- hook.c: add a hook_exists() wrapper and use it in bugreport.c
 4:  da2763192a =  2:  7209f73f28 gc: use hook library for pre-auto-gc hook
 5:  51e6e72f23 =  3:  e9a1e7cf61 rebase: teach pre-rebase to use hook.h
 6:  d2f3b26d46 =  4:  1d08726930 am: convert applypatch hooks to use config
 7:  d884465aab !  5:  32eec5dc2f hooks: convert 'post-checkout' hook to hook library
    @@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    - 
    - 	/* Number of threads to parallelize across */
    + 	 * implicit 1 for now.
    + 	 */
      	int jobs;
     +
     +	/* Resolve and run the "absolute_path(hook)" instead of
 8:  ad6e750784 =  6:  e9fa3f6759 merge: use config-based hooks for post-merge hook
 9:  8d8b2d2645 !  7:  12347d901b git hook run: add an --ignore-missing flag
    @@ Documentation/git-hook.txt: git-hook - run git hooks
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-hook.txt: run::
    - 	"--end-of-options"). See "OPTIONS" below for the arguments
    - 	this accepts.
    +@@ Documentation/git-hook.txt: optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
    + arguments (if any) differ by hook name, see linkgit:githooks[5] for
    + what those are.
      
     +OPTIONS
     +-------
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	};
      
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    - 	hook_name = argv[1];
    + 	/*
    + 	 * We are not using run_hooks() because we'd like to detect
    + 	 * missing hooks. Let's find it ourselves and call
    +-	 * run_found_hooks() instead.
    ++	 * run_found_hooks() instead...
    + 	 */
    + 	hook_name = argv[0];
      	hook_path = find_hook(hook_name);
      	if (!hook_path) {
    ++		/* ... act like run_hooks() under --ignore-missing */
     +		if (ignore_missing)
     +			return 0;
      		error("cannot find a hook named %s", hook_name);
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	}
     
      ## t/t1800-hook.sh ##
    -@@ t/t1800-hook.sh: test_expect_success 'git hook run -- nonexistent hook' '
    +@@ t/t1800-hook.sh: test_expect_success 'git hook run: nonexistent hook' '
      	test_cmp stderr.expect stderr.actual
      '
      
    -+test_expect_success 'git hook run -- nonexistent hook with --ignore-missing' '
    +-test_expect_success 'git hook run: basic' '
    ++test_expect_success 'git hook run: nonexistent hook with --ignore-missing' '
     +	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
     +	test_must_be_empty stderr.actual
     +'
     +
    - test_expect_success 'git hook run -- basic' '
    ++test_expect_success 'git hook run -- basic' '
      	write_script .git/hooks/test-hook <<-EOF &&
      	echo Test hook
    + 	EOF
10:  1953326d1d =  8:  71d209b407 send-email: use 'git hook run' for 'sendemail-validate'
11:  aa970a8175 !  9:  246a82b55b git-p4: use 'git hook' to run hooks
    @@ Commit message
         Python, we can directly call 'git hook run'. We emulate the existence
         check with the --ignore-missing flag.
     
    +    As this is the last hook execution in git.git to not go through "git
    +    hook run" or the hook.[ch] library we can now be absolutely sure that
    +    our assertion in hook.c that only hooks known by the generated (from
    +    githooks(5)) hook-list.h are permitted.
    +
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
12:  7756f10aac = 10:  e3f8482d80 commit: use hook.h to execute hooks
13:  0300607a9b = 11:  6ed61071c5 read-cache: convert post-index-change hook to use config
14:  ec4ad437f8 = 12:  e4ef3f4548 receive-pack: convert push-to-checkout hook to hook.h
15:  477eb2245c = 13:  e3dda367ec run-command: remove old run_hook_{le,ve}() hook API
16:  53a3877a47 = 14:  477d75bf57 run-command: allow stdin for run_processes_parallel
17:  c4f60db606 ! 15:  b7c0ee9719 hook: support passing stdin to hooks
    @@ Documentation/git-hook.txt: git-hook - run git hooks
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-hook.txt: run::
    +@@ Documentation/git-hook.txt: what those are.
      OPTIONS
      -------
      
    @@ Documentation/git-hook.txt: run::
     
      ## builtin/hook.c ##
     @@
    - #include "strvec.h"
      
      static const char * const builtin_hook_usage[] = {
    + 	N_("git hook <command> [...]"),
     -	N_("git hook run <hook-name> [-- <hook-args>]"),
    ++	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
    + 	NULL
    + };
    + 
    + static const char * const builtin_hook_run_usage[] = {
    + 	N_("git hook run <hook-name> [-- <hook-args>]"),
     +	N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]"),
      	NULL
      };
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
     
      ## hook.c ##
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
    - 	if (!run_me)
    - 		BUG("did we not return 1 in notify_hook_finished?");
    + 	struct hook_cb_data *hook_cb = pp_cb;
    + 	struct hook *run_me = hook_cb->run_me;
      
     -	cp->no_stdin = 1;
    ++
     +	/* reopen the file for stdin; run_command closes it. */
     +	if (hook_cb->options->path_to_stdin) {
     +		cp->no_stdin = 0;
    @@ hook.h: struct run_hooks_opt
      #define RUN_HOOKS_OPT_INIT { \
     
      ## t/t1800-hook.sh ##
    -@@ t/t1800-hook.sh: test_expect_success 'set up a pre-commit hook in core.hooksPath' '
    - 	EOF
    +@@ t/t1800-hook.sh: test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
    + 	test_cmp expect actual
      '
      
     +test_expect_success 'stdin to hooks' '
18:  febf05ef23 = 16:  4035069a98 am: convert 'post-rewrite' hook to hook.h
19:  7baf2469d5 = 17:  c847a19581 run-command: add stdin callback for parallelization
20:  2edf9dea41 ! 18:  da46c859c1 hook: provide stdin by string_list or callback
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	} else {
      		cp->no_stdin = 1;
      	}
    -@@ hook.c: static int notify_hook_finished(int result,
    - 	return 1;
    - }
    - 
    --
    - int run_found_hooks(const char *hook_name, const char *hook_path,
    - 		    struct run_hooks_opt *options)
    - {
     @@ hook.c: int run_found_hooks(const char *hook_name, const char *hook_path,
      	run_processes_parallel_tr2(options->jobs,
      				   pick_next_hook,
    @@ hook.c: int run_hooks(const char *hook_name, struct run_hooks_opt *options)
     +
      	hook_path = find_hook(hook_name);
      
    - 	/* Care about nonexistence? Use run_found_hooks() */
    + 	/*
     
      ## hook.h ##
    -@@
    +@@ hook.h: int hook_exists(const char *hookname);
      struct hook {
      	/* The path to the hook */
      	const char *hook_path;
    @@ hook.h: struct run_hooks_opt
     + */
     +int pipe_from_string_list(struct strbuf *pipe, void *pp_cb, void *pp_task_cb);
     +
    - /*
    -  * Callback provided to feed_pipe_fn and consume_sideband_fn.
    -  */
    + struct hook_cb_data {
    + 	/* rc reflects the cumulative failure state */
    + 	int rc;
21:  303b31ee62 = 19:  7343be28ef hook: convert 'post-rewrite' hook in sequencer.c to hook.h
22:  62eecafb3f = 20:  85bf13a083 transport: convert pre-push hook to use config
23:  6049b1cdc7 = 21:  331014bad1 reference-transaction: use hook.h to run hooks
24:  26ebbe4c54 = 22:  f7f56d0a3b run-command: allow capturing of collated output
25:  251085b752 = 23:  7f7fcc0688 hooks: allow callers to capture output
26:  e11a8f6007 = 24:  e74d49e559 receive-pack: convert 'update' hook to hook.h
27:  ecaedd13b8 = 25:  0bdc4878ac post-update: use hook.h library
28:  bb9d57f809 = 26:  db70b59b3b receive-pack: convert receive hooks to hook.h
29:  793f112f7a ! 27:  d86fedf041 hooks: fix a TOCTOU in "did we run a hook?" heuristic
    @@ commit.h: int compare_commits_by_commit_date(const void *a_, const void *b_, voi
     
      ## hook.c ##
     @@ hook.c: static int notify_hook_finished(int result,
    - 	/* |= rc in cb */
    + 
      	hook_cb->rc |= result;
      
     +	if (hook_cb->invoked_hook)
    @@ hook.h: struct hook_cb_data {
     +	int *invoked_hook;
      };
      
    - /*
    + void run_hooks_opt_clear(struct run_hooks_opt *o);
     
      ## sequencer.c ##
     @@ sequencer.c: static int run_prepare_commit_msg_hook(struct repository *r,
30:  bc086454d6 <  -:  ---------- hook-list.h: add a generated list of hooks, like config-list.h
-- 
2.32.0.576.g59759b6ca7d

