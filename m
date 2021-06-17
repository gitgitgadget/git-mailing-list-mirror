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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF7BC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B136661245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhFQKZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFQKZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C44C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c7so2331057edn.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rs54EexwIUW7+/OU2Anl7o2UQVXtLRfDxKe+aWVgoe8=;
        b=tCsDwtDczwLeSm2haovFMc8bJNmi7XHUi+cxAmxlVk+jbbhZK2IR2o/+fBeRPkY60/
         qS5X0YjUzJw8/cwbaqicsHO5ZncoWeRkzFJ4EPL+IojXEDPdCrOtDLWa7/cgHXaKaFMG
         jP8FJ4EwVBsOOhscnUgNkZwDeYiQZG9WhydHn1TD65chpIP5tCIkoING+SNhzfYFM9T9
         ALm4xM+FGyQ52FA2YKL/KMxfGyf03eQR3+aNZHdEPO/ZdN7boNWcaGarMssaQbrXTI2B
         HKmR1LL2agVpXV9tXDFaVt9pta7Cv2qQoM/zA9Xm9owxZM1KC2Pa2yYqkrYg7W68gMNq
         Autw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rs54EexwIUW7+/OU2Anl7o2UQVXtLRfDxKe+aWVgoe8=;
        b=Febzt2B9bk8vtN747b6gjawRT1cCRmcvzVSdp0Isw29KeZZSmDwRivzQrePwgk9gbm
         q60MFV6eLfPkOgGYOf0Bs9oy1JxVLcGDb0qtZ++vEOL4ZNTWf6BMXQ97SdwdzCvTW3aa
         HJ+o6GIul+qZB2YgXn11UkO5shrUA1KQpWzpSk87NjE6sP4DI+gMqVuBBHO9CBrhh3NL
         jub3TDy/urFD+zva2nUU73DViTIqPdfIt/qgfc4ZE0xSXdh9qPy464m0h1COiBQ8fx6H
         gm3FclmcxU2br+S26LjSqpp4ipMtOKX6v1knnKniyKw3cUhqwhmsnjOK2pgaXxLPPz3t
         QzhA==
X-Gm-Message-State: AOAM532ykH9BW4hou21G+EkI+0YSQ1682QDN9h2MS1vsoWrgIH2QHbPl
        72EkGqTDUCBVHYUqOOn/V8jvqbEGQBECrg==
X-Google-Smtp-Source: ABdhPJzxJvPO1TPr8xP+jXyfC1uB4yXQUUsVFk6MZ96H5Spp4nVGoaXnPnXglF1PjWOydMg9JIT9rA==
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr3873874edu.51.1623925389171;
        Thu, 17 Jun 2021 03:23:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:08 -0700 (PDT)
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
Subject: [PATCH 01/27] hook: add 'run' subcommand
Date:   Thu, 17 Jun 2021 12:22:35 +0200
Message-Id: <patch-01.27-cf4b06bfdf-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                 |   1 +
 Documentation/git-hook.txt |  38 +++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/hook.c             |  81 +++++++++++++++++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 hook.c                     | 119 +++++++++++++++++++++++++++++++++
 hook.h                     |  53 +++++++++++++++
 t/t1800-hook.sh            | 131 +++++++++++++++++++++++++++++++++++++
 11 files changed, 431 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

diff --git a/.gitignore b/.gitignore
index 6be9de41ae..66189ca3cd 100644
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
index 0000000000..660d6a992a
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
index b51959ff94..a16e62bc8c 100644
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
index 9bd31e1ac5..a52d509162 100644
--- a/Makefile
+++ b/Makefile
@@ -1106,6 +1106,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 16ecd5586f..91740c1514 100644
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
index 0000000000..7714d31ef1
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,81 @@
+#include "cache.h"
+#include "builtin.h"
+#include "config.h"
+#include "hook.h"
+#include "parse-options.h"
+#include "strbuf.h"
+#include "strvec.h"
+
+static const char * const builtin_hook_usage[] = {
+	N_("git hook <command> [...]"),
+	N_("git hook run <hook-name> [-- <hook-args>]"),
+	NULL
+};
+
+static const char * const builtin_hook_run_usage[] = {
+	N_("git hook run <hook-name> [-- <hook-args>]"),
+	NULL
+};
+
+static int run(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	int rc = 0;
+	const char *hook_name;
+	const char *hook_path;
+
+	struct option run_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, run_options,
+			     builtin_hook_run_usage,
+			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc > 1) {
+		if (strcmp(argv[1], "--") &&
+		    strcmp(argv[1], "--end-of-options"))
+			/* Having a -- for "run" is mandatory */
+			usage_with_options(builtin_hook_usage, run_options);
+		/* Add our arguments, start after -- */
+		for (i = 2 ; i < argc; i++)
+			strvec_push(&opt.args, argv[i]);
+	}
+
+	/* Need to take into account core.hooksPath */
+	git_config(git_default_config, NULL);
+
+	/*
+	 * We are not using run_hooks() because we'd like to detect
+	 * missing hooks. Let's find it ourselves and call
+	 * run_found_hooks() instead.
+	 */
+	hook_name = argv[0];
+	hook_path = find_hook(hook_name);
+	if (!hook_path) {
+		error("cannot find a hook named %s", hook_name);
+		return 1;
+	}
+	rc = run_found_hooks(hook_name, hook_path, &opt);
+
+	run_hooks_opt_clear(&opt);
+
+	return rc;
+}
+
+int cmd_hook(int argc, const char **argv, const char *prefix)
+{
+	struct option builtin_hook_options[] = {
+		OPT_END(),
+	};
+	argc = parse_options(argc, argv, NULL, builtin_hook_options,
+			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc)
+		usage_with_options(builtin_hook_usage, builtin_hook_options);
+
+	if (!strcmp(argv[0], "run"))
+		return run(argc, argv, prefix);
+	else
+		usage_with_options(builtin_hook_usage, builtin_hook_options);
+}
diff --git a/command-list.txt b/command-list.txt
index a289f09ed6..9ccd8e5aeb 100644
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
index 18bed9a996..540909c391 100644
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
index 1f1db1ec9b..4d87e98255 100644
--- a/hook.c
+++ b/hook.c
@@ -2,11 +2,14 @@
 #include "hook.h"
 #include "run-command.h"
 #include "hook-list.h"
+#include "config.h"
 
 static int known_hook(const char *name)
 {
 	const char **p;
 	size_t len = strlen(name);
+	static int test_hooks_ok = -1;
+
 	for (p = hook_name_list; *p; p++) {
 		const char *hook = *p;
 
@@ -14,6 +17,14 @@ static int known_hook(const char *name)
 			return 1;
 	}
 
+	if (test_hooks_ok == -1)
+		test_hooks_ok = git_env_bool("GIT_TEST_FAKE_HOOKS", 0);
+
+	if (test_hooks_ok &&
+	    (!strcmp(name, "test-hook") ||
+	     !strcmp(name, "does-not-exist")))
+		return 1;
+
 	return 0;
 }
 
@@ -59,3 +70,111 @@ int hook_exists(const char *name)
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
+	return 1;
+}
+
+int run_found_hooks(const char *hook_name, const char *hook_path,
+		    struct run_hooks_opt *options)
+{
+	struct hook my_hook = {
+		.hook_path = hook_path,
+	};
+	struct hook_cb_data cb_data = {
+		.rc = 0,
+		.hook_name = hook_name,
+		.options = options,
+	};
+	cb_data.run_me = &my_hook;
+
+	if (options->jobs != 1)
+		BUG("we do not handle %d or any other != 1 job number yet", options->jobs);
+
+	run_processes_parallel_tr2(options->jobs,
+				   pick_next_hook,
+				   notify_start_failure,
+				   notify_hook_finished,
+				   &cb_data,
+				   "hook",
+				   hook_name);
+
+	return cb_data.rc;
+}
+
+int run_hooks(const char *hook_name, struct run_hooks_opt *options)
+{
+	const char *hook_path;
+	int ret;
+	if (!options)
+		BUG("a struct run_hooks_opt must be provided to run_hooks");
+
+	hook_path = find_hook(hook_name);
+
+	/*
+	 * If you need to act on a missing hook, use run_found_hooks()
+	 * instead
+	 */
+	if (!hook_path)
+		return 0;
+
+	ret = run_found_hooks(hook_name, hook_path, options);
+	return ret;
+}
diff --git a/hook.h b/hook.h
index 4c547ac15e..dcc2cc2112 100644
--- a/hook.h
+++ b/hook.h
@@ -1,5 +1,8 @@
 #ifndef HOOK_H
 #define HOOK_H
+#include "strbuf.h"
+#include "strvec.h"
+#include "run-command.h"
 
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
@@ -13,4 +16,54 @@ const char *find_hook(const char *name);
  */
 int hook_exists(const char *hookname);
 
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
+
+	/*
+	 * Number of threads to parallelize across, currently a stub,
+	 * we use the parallel API for future-proofing, but we always
+	 * have one hook of a given name, so this is always an
+	 * implicit 1 for now.
+	 */
+	int jobs;
+};
+
+#define RUN_HOOKS_OPT_INIT { \
+	.jobs = 1, \
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
+
+void run_hooks_opt_clear(struct run_hooks_opt *o);
+
+/*
+ * Calls find_hook(hookname) and runs the hooks (if any) with
+ * run_found_hooks().
+ */
+int run_hooks(const char *hook_name, struct run_hooks_opt *options);
+
+/*
+ * Takes an already resolved hook and runs it. Internally the simpler
+ * run_hooks() will call this.
+ */
+int run_found_hooks(const char *hookname, const char *hook_path,
+		    struct run_hooks_opt *options);
 #endif
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
new file mode 100755
index 0000000000..ecd517b162
--- /dev/null
+++ b/t/t1800-hook.sh
@@ -0,0 +1,131 @@
+#!/bin/bash
+
+test_description='git-hook command'
+
+. ./test-lib.sh
+
+test_expect_success 'git hook usage' '
+	test_expect_code 129 git hook &&
+	test_expect_code 129 git hook -h &&
+	test_expect_code 129 git hook run -h
+'
+
+test_expect_success 'setup GIT_TEST_FAKE_HOOKS=true to permit "test-hook" and "does-not-exist" names"' '
+	GIT_TEST_FAKE_HOOKS=true &&
+	export GIT_TEST_FAKE_HOOKS
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
2.32.0.576.g59759b6ca7d

