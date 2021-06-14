Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DDFC4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4256143B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhFNKib (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhFNKgT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9CC0611BC
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i94so13946135wri.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9bqX+LiL1PpM1s5e5YwGhGH9yR72VRc/oypzZflRFNk=;
        b=ZmgzTvUHZ/lilID3C7G9DwcT3i42xsNZDdCgKDdLyAdwVB13a97AMRjDNvJ1kmojiz
         yyYykdfjH9Z3Ca2ycOW+1qvDkStAEqtjW9xSf9daSDn6oGPa2xrOu6tEwqlMH8HiAaId
         FVu2ae/WP0jyNMS+XxmXcj4b0wHxkT9dB8vgcgVIBE+NyNB8qdm4tTcxMp+1q29HmCpE
         GVltzEguAPkGtRPcZT/U6HluIFf9wAR4gu7aeWLwjj1ZpIjZroyZ+oOH7Iix37QVU0bY
         ef9mvVgTKphLK5nImtEe0rGaEOeKmUos8Q2v9ZKVs3EVldSrunj8y63XiasegvwUWMEN
         v5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bqX+LiL1PpM1s5e5YwGhGH9yR72VRc/oypzZflRFNk=;
        b=fVJ0ElgR9xO4VyRXFurvpI3rJ9K7mr1fw/PqUM7DFeB8Dyd6ONULpNboQMDbHO+QJH
         klRo0FQW0iEQJVwsaDXVZCd164uLvmrP0gYZ0lCqyQ+KAR/749BLYRp/Yc/w0m0GoElb
         1XgliTSMTeDLEU+3oDYrp87Ajsy+vx/628dhp9gnRA6w59jh6BqgceB0JdmSWhI8Lul0
         oCLbVfyZ4br0PSFXPIFzy0Cf1jFr75aEkDwuBjK3lEbvb4ahnY77sTS8AoXBKjtewa76
         W7pDMKQuqjLqyrACBvajh1cr6vsWRynFSAQkBHSMtVX4etl4HGfNlx06vpJ9fzmK4Vxy
         HZ1Q==
X-Gm-Message-State: AOAM533SF0ufsrzgG3haxouedmZnRGPwMiCbp9i43HcB/f+pZi7Lbufh
        vBqCn29Uw/niXIeuq4oUjtr0ZOIVFLJ4+g==
X-Google-Smtp-Source: ABdhPJz/MtWonCmlXX6IC+OWNzsvdv4tdfUeck4QKgQ07lgnixmIKfaO57Kh9aWAJiHefYTgrPvaGg==
X-Received: by 2002:adf:f1ca:: with SMTP id z10mr18564557wro.396.1623666825281;
        Mon, 14 Jun 2021 03:33:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:44 -0700 (PDT)
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
Subject: [PATCH v2 01/30] hook: add 'run' subcommand
Date:   Mon, 14 Jun 2021 12:32:50 +0200
Message-Id: <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
 Documentation/git-hook.txt |  36 ++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   2 +
 builtin.h                  |   1 +
 builtin/hook.c             |  65 ++++++++++++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 hook.c                     | 114 ++++++++++++++++++++++++++++++++
 hook.h                     |  54 +++++++++++++++
 t/t1800-hook.sh            | 131 +++++++++++++++++++++++++++++++++++++
 11 files changed, 410 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1800-hook.sh

diff --git a/.gitignore b/.gitignore
index 311841f9bed..de39dc9961b 100644
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
index 00000000000..902b9cffaef
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,36 @@
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
+
+	Run the `<hook-name>` hook. Any positional arguments to the
+	hook should be passed after an optional "--" (or
+	"--end-of-options"). See "OPTIONS" below for the arguments
+	this accepts.
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
index c3565fc0f8f..a6b71a0fbed 100644
--- a/Makefile
+++ b/Makefile
@@ -901,6 +901,7 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
@@ -1101,6 +1102,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 16ecd5586f0..91740c15149 100644
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
index 00000000000..1b1a594fd00
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,65 @@
+#include "cache.h"
+#include "builtin.h"
+#include "config.h"
+#include "hook.h"
+#include "parse-options.h"
+#include "strbuf.h"
+#include "strvec.h"
+
+static const char * const builtin_hook_usage[] = {
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
+			     builtin_hook_usage, PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc > 2) {
+		if (strcmp(argv[2], "--") &&
+		    strcmp(argv[2], "--end-of-options"))
+			/* Having a -- for "run" is mandatory */
+			usage_with_options(builtin_hook_usage, run_options);
+		/* Add our arguments, start after -- */
+		for (i = 3 ; i < argc; i++)
+			strvec_push(&opt.args, argv[i]);
+	}
+
+	/* Need to take into account core.hooksPath */
+	git_config(git_default_config, NULL);
+
+	hook_name = argv[1];
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
+
+	if (!strcmp(argv[1], "run"))
+		return run(argc, argv, prefix);
+	usage_with_options(builtin_hook_usage, builtin_hook_options);
+	return 1;
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
index 18bed9a9964..540909c391f 100644
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
new file mode 100644
index 00000000000..aa66c968186
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,114 @@
+#include "cache.h"
+#include "hook.h"
+#include "run-command.h"
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
+		BUG("did we not return 1 in notify_hook_finished?");
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
+	/* |= rc in cb */
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
+	/* |= rc in cb */
+	hook_cb->rc |= result;
+
+	return 1;
+}
+
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
+	/* Care about nonexistence? Use run_found_hooks() */
+	if (!hook_path)
+		return 0;
+
+	ret = run_found_hooks(hook_name, hook_path, options);
+	return ret;
+}
diff --git a/hook.h b/hook.h
new file mode 100644
index 00000000000..ebfee26bcf2
--- /dev/null
+++ b/hook.h
@@ -0,0 +1,54 @@
+#ifndef HOOK_H
+#define HOOK_H
+#include "strbuf.h"
+#include "strvec.h"
+#include "run-command.h"
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
+
+	/* Number of threads to parallelize across */
+	int jobs;
+};
+
+#define RUN_HOOKS_OPT_INIT { \
+	.jobs = 1, \
+	.env = STRVEC_INIT, \
+	.args = STRVEC_INIT, \
+}
+
+/*
+ * Callback provided to feed_pipe_fn and consume_sideband_fn.
+ */
+struct hook_cb_data {
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
+#endif
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
new file mode 100755
index 00000000000..f6ff6c4a493
--- /dev/null
+++ b/t/t1800-hook.sh
@@ -0,0 +1,131 @@
+#!/bin/bash
+
+test_description='git-hook command'
+
+. ./test-lib.sh
+
+test_expect_success 'git hook run -- nonexistent hook' '
+	cat >stderr.expect <<-\EOF &&
+	error: cannot find a hook named does-not-exist
+	EOF
+	test_expect_code 1 git hook run does-not-exist 2>stderr.actual &&
+	test_cmp stderr.expect stderr.actual
+'
+
+test_expect_success 'git hook run -- basic' '
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
+test_expect_success 'git hook run -- stdout and stderr handling' '
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
+test_expect_success 'git hook run -- exit codes are passed along' '
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
+	write_script my-hooks/test-hook <<-EOF &&
+	echo Hook ran >>actual
+	EOF
+
+	cat >expect <<-\EOF &&
+	Test hook
+	Hook ran
+	Hook ran
+	Hook ran
+	Hook ran
+	EOF
+
+	# Test various ways of specifying the path. See also
+	# t1350-config-hooks-path.sh
+	>actual &&
+	git hook run test-hook 2>>actual &&
+	git -c core.hooksPath=my-hooks hook run test-hook 2>>actual &&
+	git -c core.hooksPath=my-hooks/ hook run test-hook 2>>actual &&
+	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook 2>>actual &&
+	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook 2>>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'set up a pre-commit hook in core.hooksPath' '
+	>actual &&
+	mkdir -p .git/custom-hooks .git/hooks &&
+	write_script .git/custom-hooks/pre-commit <<-\EOF &&
+	echo CUSTOM >>actual
+	EOF
+	write_script .git/hooks/pre-commit <<-\EOF
+	echo NORMAL >>actual
+	EOF
+'
+
+test_done
-- 
2.32.0.rc3.434.gd8aed1f08a7

