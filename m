Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65400C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA6D611B0
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhJSXXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhJSXXl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0A1C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so6260501wmd.5
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ITaAw5pzJd27nCuA6vsE5sN0xgBvf35Mll9bGzSrC+I=;
        b=UXrMuSNW4Zm08VWr9TSS1zl22ARjn+E+SPN2fZG1BZdjJ0AC1RKl8It+UmQV4gHc7f
         P8wu1URTaU8wATJwsKeylY5Uy/A4EPDv/XvKoArOrwBdw3S/F8Tz8/BX9XaMpbpzd3RF
         JwFuAHICw8KokZ7x2F8re+8fg83kzRDTWlgA15cvfbya4WYOWkNPpqEOjeMf1/nZZjhy
         +bbcsFmWvywnXPCCCN7Wrp3zdCV1rNCLhwWTKDXSbOngceC+ibDupy0/mc3Tm7Izac79
         CcSZzWqNg15QZ1Jv8Nj0wyO5iuJuqy+Y7cCgNiSunm8UAsNx02j6aEcAT7hSxJZt0iL4
         vWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ITaAw5pzJd27nCuA6vsE5sN0xgBvf35Mll9bGzSrC+I=;
        b=4a45+G5qyLZ/v3N6xI0e0GTsfcXaneRrKzv+s1yLox3hRcjKyJkeNo187ewudu7vrQ
         aFVwHf5AcabkEGRalJsy41Fm5Vv/wUl6FdMun6B/cW6XoHQC4DahgGx4xgBf2LjJfjgJ
         JnvfQdWlDXMlw++qksSLwUzeZh4dqRL1FjvsthGV0cBN6O7VNxML3L6QIEFFLX5C2U/p
         diz+V40pG0rB9uuIee4fTT+CbjZvJpi+Ga1Xu7QuwIHlV7Pzej5x+OB1gAYBgBAwpVl9
         GtquS38G1szE53nGrN85kxZZo5zElFu6ohoD+dAl4XV2q6bXlw8f31LWWLEu4WU9yOXz
         Jzjg==
X-Gm-Message-State: AOAM532EwH+urueGJERDnpWZlzCxvbDjuSy/UyieG5IEBTsah8ftijfg
        n2Y0VFVGUIIK8IG8wErEICONBANqHwSnYw==
X-Google-Smtp-Source: ABdhPJyafASznOM38+qVieKsdCX0a4J5JwzpcAYVmAGyhS9OYExgZIp7gJpXyOWAdBgD6zg3+9Ic0g==
X-Received: by 2002:a5d:47c6:: with SMTP id o6mr47917046wrc.416.1634685686173;
        Tue, 19 Oct 2021 16:21:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:25 -0700 (PDT)
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
Subject: [PATCH v3 01/13] hook: add 'run' subcommand
Date:   Wed, 20 Oct 2021 01:20:39 +0200
Message-Id: <patch-v3-01.13-02fd699e699-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

In order to enable hooks to be run as an external process, by a
standalone Git command, or by tools which wrap Git, provide an external
means to run all configured hook commands for a given hook event.

Most of our hooks require more complex functionality than this, but
let's start with the bare minimum required to support our simplest
hooks.

In terms of implementation the usage_with_options() and "goto usage"
pattern here mirrors that of
builtin/{commit-graph,multi-pack-index}.c.

Some of the implementation here, such as a function being named
run_hooks() when it's tasked with running one hook, to using the
run_processes_parallel_tr2() API to run with jobs=1 is somewhere
between a bit odd and and an overkill for the current features of this
"hook run" command and the hook.[ch] API.

This code will eventually be able to run multiple hooks declared in
config in parallel, by starting out with these names and APIs we
reduce the later churn of renaming functions, switching from the
run_command() to run_processes_parallel_tr2() API etc.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                 |   1 +
 Documentation/git-hook.txt |  37 +++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/hook.c             |  85 ++++++++++++++++++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 hook.c                     |  91 ++++++++++++++++++++++++++
 hook.h                     |  34 ++++++++++
 t/t1800-hook.sh            | 129 +++++++++++++++++++++++++++++++++++++
 11 files changed, 385 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

diff --git a/.gitignore b/.gitignore
index 054249b20a8..f817c509ec0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-hook
 /git-http-backend
 /git-http-fetch
 /git-http-push
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
new file mode 100644
index 00000000000..e39b1b5d069
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,37 @@
+git-hook(1)
+===========
+
+NAME
+----
+git-hook - Run git hooks
+
+SYNOPSIS
+--------
+[verse]
+'git hook' run <hook-name> [-- <hook-args>]
+
+DESCRIPTION
+-----------
+
+A command interface to running git hooks (see linkgit:githooks[5]),
+for use by other scripted git commands.
+
+SUBCOMMANDS
+-----------
+
+run::
+	Run the `<hook-name>` hook. See linkgit:githooks[5] for
+	supported hook names.
++
+
+Any positional arguments to the hook should be passed after a
+mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
+linkgit:githooks[5] for arguments hooks might expect (if any).
+
+SEE ALSO
+--------
+linkgit:githooks[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b51959ff941..a16e62bc8c8 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -698,6 +698,10 @@ and "0" meaning they were not.
 Only one parameter should be set to "1" when the hook runs.  The hook
 running passing "1", "1" should not be possible.
 
+SEE ALSO
+--------
+linkgit:git-hook[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 381bed2c1d2..1eef009def2 100644
--- a/Makefile
+++ b/Makefile
@@ -1107,6 +1107,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 8a58743ed63..83379f3832c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -164,6 +164,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
 int cmd_hash_object(int argc, const char **argv, const char *prefix);
 int cmd_help(int argc, const char **argv, const char *prefix);
+int cmd_hook(int argc, const char **argv, const char *prefix);
 int cmd_index_pack(int argc, const char **argv, const char *prefix);
 int cmd_init_db(int argc, const char **argv, const char *prefix);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
diff --git a/builtin/hook.c b/builtin/hook.c
new file mode 100644
index 00000000000..41dd15550cf
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,85 @@
+#include "cache.h"
+#include "builtin.h"
+#include "config.h"
+#include "hook.h"
+#include "parse-options.h"
+#include "strbuf.h"
+#include "strvec.h"
+
+#define BUILTIN_HOOK_RUN_USAGE \
+	N_("git hook run <hook-name> [-- <hook-args>]")
+
+static const char * const builtin_hook_usage[] = {
+	BUILTIN_HOOK_RUN_USAGE,
+	NULL
+};
+
+static const char * const builtin_hook_run_usage[] = {
+	BUILTIN_HOOK_RUN_USAGE,
+	NULL
+};
+
+static int run(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	const char *hook_name;
+	const char *hook_path;
+	struct option run_options[] = {
+		OPT_END(),
+	};
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, run_options,
+			     builtin_hook_run_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (!argc)
+		goto usage;
+
+	/*
+	 * Having a -- for "run" when providing <hook-args> is
+	 * mandatory.
+	 */
+	if (argc > 1 && strcmp(argv[1], "--") &&
+	    strcmp(argv[1], "--end-of-options"))
+		goto usage;
+
+	/* Add our arguments, start after -- */
+	for (i = 2 ; i < argc; i++)
+		strvec_push(&opt.args, argv[i]);
+
+	/* Need to take into account core.hooksPath */
+	git_config(git_default_config, NULL);
+
+	hook_name = argv[0];
+	hook_path = find_hook(hook_name);
+	if (!hook_path) {
+		error("cannot find a hook named %s", hook_name);
+		return 1;
+	}
+
+	ret = run_hooks(hook_name, hook_path, &opt);
+	run_hooks_opt_clear(&opt);
+	return ret;
+usage:
+	usage_with_options(builtin_hook_run_usage, run_options);
+}
+
+int cmd_hook(int argc, const char **argv, const char *prefix)
+{
+	struct option builtin_hook_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL, builtin_hook_options,
+			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc)
+		goto usage;
+
+	if (!strcmp(argv[0], "run"))
+		return run(argc, argv, prefix);
+
+usage:
+	usage_with_options(builtin_hook_usage, builtin_hook_options);
+}
diff --git a/command-list.txt b/command-list.txt
index a289f09ed6f..17c3958802e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -103,6 +103,7 @@ git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
+git-hook                                purehelpers
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
diff --git a/git.c b/git.c
index 5ff21be21f3..a5be02b04b8 100644
--- a/git.c
+++ b/git.c
@@ -538,6 +538,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "hook", cmd_hook, RUN_SETUP },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index 55e1145a4b7..20a1a4fec33 100644
--- a/hook.c
+++ b/hook.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "hook.h"
 #include "run-command.h"
+#include "config.h"
 
 const char *find_hook(const char *name)
 {
@@ -40,3 +41,93 @@ int hook_exists(const char *name)
 {
 	return !!find_hook(name);
 }
+
+void run_hooks_opt_clear(struct run_hooks_opt *o)
+{
+	strvec_clear(&o->env);
+	strvec_clear(&o->args);
+}
+
+static int pick_next_hook(struct child_process *cp,
+			  struct strbuf *out,
+			  void *pp_cb,
+			  void **pp_task_cb)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	const char *hook_path = hook_cb->hook_path;
+
+	if (!hook_path)
+		return 0;
+
+	cp->no_stdin = 1;
+	cp->env = hook_cb->options->env.v;
+	cp->stdout_to_stderr = 1;
+	cp->trace2_hook_name = hook_cb->hook_name;
+
+	strvec_push(&cp->args, hook_path);
+	strvec_pushv(&cp->args, hook_cb->options->args.v);
+
+	/* Provide context for errors if necessary */
+	*pp_task_cb = (char *)hook_path;
+
+	/*
+	 * This pick_next_hook() will be called again, we're only
+	 * running one hook, so indicate that no more work will be
+	 * done.
+	 */
+	hook_cb->hook_path = NULL;
+
+	return 1;
+}
+
+static int notify_start_failure(struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cp)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	const char *hook_path = pp_task_cp;
+
+	hook_cb->rc |= 1;
+
+	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
+		    hook_path);
+
+	return 1;
+}
+
+static int notify_hook_finished(int result,
+				struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cb)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+
+	hook_cb->rc |= result;
+
+	return 0;
+}
+
+int run_hooks(const char *hook_name, const char *hook_path,
+	      struct run_hooks_opt *options)
+{
+	struct hook_cb_data cb_data = {
+		.rc = 0,
+		.hook_name = hook_name,
+		.hook_path = hook_path,
+		.options = options,
+	};
+	int jobs = 1;
+
+	if (!options)
+		BUG("a struct run_hooks_opt must be provided to run_hooks");
+
+	run_processes_parallel_tr2(jobs,
+				   pick_next_hook,
+				   notify_start_failure,
+				   notify_hook_finished,
+				   &cb_data,
+				   "hook",
+				   hook_name);
+
+	return cb_data.rc;
+}
diff --git a/hook.h b/hook.h
index 6aa36fc7ff9..a9317c3f95e 100644
--- a/hook.h
+++ b/hook.h
@@ -1,5 +1,28 @@
 #ifndef HOOK_H
 #define HOOK_H
+#include "strvec.h"
+
+struct run_hooks_opt
+{
+	/* Environment vars to be set for each hook */
+	struct strvec env;
+
+	/* Args to be passed to each hook */
+	struct strvec args;
+};
+
+#define RUN_HOOKS_OPT_INIT { \
+	.env = STRVEC_INIT, \
+	.args = STRVEC_INIT, \
+}
+
+struct hook_cb_data {
+	/* rc reflects the cumulative failure state */
+	int rc;
+	const char *hook_name;
+	const char *hook_path;
+	struct run_hooks_opt *options;
+};
 
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
@@ -13,4 +36,15 @@ const char *find_hook(const char *name);
  */
 int hook_exists(const char *hookname);
 
+/**
+ * Clear data from an initialized "struct run_hooks_opt".
+ */
+void run_hooks_opt_clear(struct run_hooks_opt *o);
+
+/**
+ * Takes an already resolved hook found via find_hook() and runs
+ * it. Does not call run_hooks_opt_clear() for you.
+ */
+int run_hooks(const char *hookname, const char *hook_path,
+	      struct run_hooks_opt *options);
 #endif
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
new file mode 100755
index 00000000000..3aea1b105f0
--- /dev/null
+++ b/t/t1800-hook.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+test_description='git-hook command'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'git hook usage' '
+	test_expect_code 129 git hook &&
+	test_expect_code 129 git hook run &&
+	test_expect_code 129 git hook run -h &&
+	test_expect_code 129 git hook run --unknown 2>err &&
+	grep "unknown option" err
+'
+
+test_expect_success 'git hook run: nonexistent hook' '
+	cat >stderr.expect <<-\EOF &&
+	error: cannot find a hook named test-hook
+	EOF
+	test_expect_code 1 git hook run test-hook 2>stderr.actual &&
+	test_cmp stderr.expect stderr.actual
+'
+
+test_expect_success 'git hook run: basic' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
+	cat >expect <<-\EOF &&
+	Test hook
+	EOF
+	git hook run test-hook 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo >&1 Will end up on stderr
+	echo >&2 Will end up on stderr
+	EOF
+
+	cat >stderr.expect <<-\EOF &&
+	Will end up on stderr
+	Will end up on stderr
+	EOF
+	git hook run test-hook >stdout.actual 2>stderr.actual &&
+	test_cmp stderr.expect stderr.actual &&
+	test_must_be_empty stdout.actual
+'
+
+test_expect_success 'git hook run: exit codes are passed along' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	exit 1
+	EOF
+
+	test_expect_code 1 git hook run test-hook &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	exit 2
+	EOF
+
+	test_expect_code 2 git hook run test-hook &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	exit 128
+	EOF
+
+	test_expect_code 128 git hook run test-hook &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	exit 129
+	EOF
+
+	test_expect_code 129 git hook run test-hook
+'
+
+test_expect_success 'git hook run arg u ments without -- is not allowed' '
+	test_expect_code 129 git hook run test-hook arg u ments
+'
+
+test_expect_success 'git hook run -- pass arguments' '
+	write_script .git/hooks/test-hook <<-\EOF &&
+	echo $1
+	echo $2
+	EOF
+
+	cat >expect <<-EOF &&
+	arg
+	u ments
+	EOF
+
+	git hook run test-hook -- arg "u ments" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git hook run -- out-of-repo runs excluded' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
+	nongit test_must_fail git hook run test-hook
+'
+
+test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
+	mkdir my-hooks &&
+	write_script my-hooks/test-hook <<-\EOF &&
+	echo Hook ran $1 >>actual
+	EOF
+
+	cat >expect <<-\EOF &&
+	Test hook
+	Hook ran one
+	Hook ran two
+	Hook ran three
+	Hook ran four
+	EOF
+
+	# Test various ways of specifying the path. See also
+	# t1350-config-hooks-path.sh
+	>actual &&
+	git hook run test-hook -- ignored 2>>actual &&
+	git -c core.hooksPath=my-hooks hook run test-hook -- one 2>>actual &&
+	git -c core.hooksPath=my-hooks/ hook run test-hook -- two 2>>actual &&
+	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook -- three 2>>actual &&
+	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook -- four 2>>actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.33.1.1338.g20da966911a

