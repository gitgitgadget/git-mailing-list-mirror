Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FABCC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6E160EB6
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhJLNdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhJLNc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:32:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3BC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:30:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d3so53495495edp.3
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GLpHuGbhe2M2R8zJwcIFHRXRnV6eD2bJ2zrB69DyMs=;
        b=RzQApunXrdPCOZQz3mQnZvqYvsVfIyefRW5bZXl91S0LC3b8tg4rpFnAPWjm8Ole+G
         PM+L/u3eoUFW5F/hHSpNxD2NvkeWiztfKC2zn5e7YWbHYRz18D7FaM0tR7/TPZ5lK1Cz
         tI5ZDpLg3l33hWXQ97is39JYLKRbVAwOb8Sqju23r4BUU6CxFqVcK8dPGnF8gED6TLuS
         HxBgBNX+bhdBmt6XUlJ7o1uhAmrIDWvmeWiCw6m2kPshlJ3MrW4JWlhXyucCb0l2vz8q
         l6b/P+4KYhFOsMG3VfE5bOTFApN+5Zg5svxKNX+IF9KA5JuljIodedHmESjJaoAhiPt3
         IJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GLpHuGbhe2M2R8zJwcIFHRXRnV6eD2bJ2zrB69DyMs=;
        b=2HNsQk854Y8uYj2GmqeKlfDhfQlt7tzOGTGWHCEtKYtnKtibvAoMLNY8tJDv7yTAjX
         7x3ac1l0vtGAz/3IIi+ylqm2aB7KsRbiDkOk6IQhbO9IY8RkaeGJXBLK1aZlXiZhuxI+
         fegM11Ryg9mC7DGam+6sDU2thx4HxUEpB5LhB94IX4nW0a8TAyNQZJRqMcy68xuuRxUJ
         GwEtuCybZbZeeYzzh9pOtIcxcDQZ2fsji09p7Axb/ea3V2EWL7pQz5WyyiOszMyMRerx
         xEztABFG9kE7IObBlq0VMrvsJJFd3Kh5TLmOwr42afXxDD5CEamuScc23j5epfLSl4JU
         NnEA==
X-Gm-Message-State: AOAM531WMdK0HQLoiMTL/ANvck0Jpj1Tmyu7Sgj2cuN9FCet9E1aefbl
        5Z0yADz2lg69FX/LNZlgMnrvmUsWQ7kOLw==
X-Google-Smtp-Source: ABdhPJzdkcMHbWuvpAO1hccf1ItPB57mi215jSgjXzAhKBevLPdYbICCLNJ9Pz8zavhO8XRo4cOPvg==
X-Received: by 2002:a17:906:5e52:: with SMTP id b18mr19867227eju.560.1634045451221;
        Tue, 12 Oct 2021 06:30:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:30:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/13] hook: add 'run' subcommand
Date:   Tue, 12 Oct 2021 15:30:26 +0200
Message-Id: <patch-01.13-a39c0748d3f-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                 |   1 +
 Documentation/git-hook.txt |  38 +++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/hook.c             |  90 ++++++++++++++++++++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 hook.c                     | 101 +++++++++++++++++++++++++++++
 hook.h                     |  39 +++++++++++
 t/t1800-hook.sh            | 129 +++++++++++++++++++++++++++++++++++++
 11 files changed, 406 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

diff --git a/.gitignore b/.gitignore
index 6be9de41ae8..66189ca3cdc 100644
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
index 00000000000..660d6a992a0
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,38 @@
+git-hook(1)
+===========
+
+NAME
+----
+git-hook - run git hooks
+
+SYNOPSIS
+--------
+[verse]
+'git hook' run <hook-name> [-- <hook-args>]
+
+DESCRIPTION
+-----------
+
+This command is an interface to git hooks (see linkgit:githooks[5]).
+Currently it only provides a convenience wrapper for running hooks for
+use by git itself. In the future it might gain other functionality.
+
+SUBCOMMANDS
+-----------
+
+run::
+	Run the `<hook-name>` hook. See linkgit:githooks[5] for
+	the hook names we support.
++
+Any positional arguments to the hook should be passed after an
+optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
+arguments (if any) differ by hook name, see linkgit:githooks[5] for
+what those are.
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
index 877492386ee..12b481fdabe 100644
--- a/Makefile
+++ b/Makefile
@@ -1108,6 +1108,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
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
index 00000000000..012a2973b38
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,90 @@
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
+	/*
+	 * We are not using a plain run_hooks() because we'd like to
+	 * detect missing hooks. Let's find it ourselves and call
+	 * run_hooks() instead.
+	 */
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
index a289f09ed6f..9ccd8e5aebe 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -103,6 +103,7 @@ git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
+git-hook                                mainporcelain
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
diff --git a/git.c b/git.c
index 60c2784be45..e5891e02021 100644
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
index 55e1145a4b7..240270db64e 100644
--- a/hook.c
+++ b/hook.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "hook.h"
 #include "run-command.h"
+#include "config.h"
 
 const char *find_hook(const char *name)
 {
@@ -40,3 +41,103 @@ int hook_exists(const char *name)
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
+	struct hook *run_me = hook_cb->run_me;
+
+	if (!run_me)
+		return 0;
+
+	cp->no_stdin = 1;
+	cp->env = hook_cb->options->env.v;
+	cp->stdout_to_stderr = 1;
+	cp->trace2_hook_name = hook_cb->hook_name;
+
+	/* add command */
+	strvec_push(&cp->args, run_me->hook_path);
+
+	/*
+	 * add passed-in argv, without expanding - let the user get back
+	 * exactly what they put in
+	 */
+	strvec_pushv(&cp->args, hook_cb->options->args.v);
+
+	/* Provide context for errors if necessary */
+	*pp_task_cb = run_me;
+
+	/*
+	 * This pick_next_hook() will be called again, we're only
+	 * running one hook, so indicate that no more work will be
+	 * done.
+	 */
+	hook_cb->run_me = NULL;
+
+	return 1;
+}
+
+static int notify_start_failure(struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cp)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct hook *attempted = pp_task_cp;
+
+	hook_cb->rc |= 1;
+
+	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
+		    attempted->hook_path);
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
+	struct hook my_hook = {
+		.hook_path = hook_path,
+	};
+	struct hook_cb_data cb_data = {
+		.rc = 0,
+		.hook_name = hook_name,
+		.options = options,
+	};
+	int jobs = 1;
+
+	if (!options)
+		BUG("a struct run_hooks_opt must be provided to run_hooks");
+
+	cb_data.run_me = &my_hook;
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
index 6aa36fc7ff9..111c5cf9296 100644
--- a/hook.h
+++ b/hook.h
@@ -1,5 +1,33 @@
 #ifndef HOOK_H
 #define HOOK_H
+#include "strvec.h"
+
+struct hook {
+	/* The path to the hook */
+	const char *hook_path;
+};
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
+	struct hook *run_me;
+	struct run_hooks_opt *options;
+};
 
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
@@ -13,4 +41,15 @@ const char *find_hook(const char *name);
  */
 int hook_exists(const char *hookname);
 
+/**
+ * Clear data from an initialized "struct run_hooks-opt".
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
2.33.0.1567.g7b23ce7ed9e

