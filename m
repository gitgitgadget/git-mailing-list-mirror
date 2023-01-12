Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E031C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjALQLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjALQLO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:11:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489512769
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:03:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u9so45954955ejo.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsLBydtvNtpWaLNd4Ik4kvzVkayM/jZP74C/LSHiSQA=;
        b=PDxivY9ft/7+HJOCyQgX95kqg3gwx30vIsfjwMCUzVQ9pqqGa4sAWqWmyvkSIl7OoM
         pi9hmtauF0rHKKabNfWkBNVbxRcJdBDuvERD7XaQPrjLNEdooTEXHuewuwyagm2GEZdL
         H0lERP/vSJVdL5xKd7XNt1K6xL1ohjunhxUhBnMY5OCpiK52oEMlD9q2U7p6XgHxj+M1
         x/i496gZwpLqkfTHXFwhpA69NEy9hQwlM/do2ysjKIqksbhlWYZuTkrX6/fwBz7Xmp/W
         r45xhSlurF2qJoU1BnXAuHZsPXm03fRr0z4Mgoks4IWQQdMhW8qTqe0wio106/50sp+9
         a1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsLBydtvNtpWaLNd4Ik4kvzVkayM/jZP74C/LSHiSQA=;
        b=YzzjkbWBrjYwC7qc7i8O/D4Q83m5owk+YVxrnnHyxK0lHtlu/YIqFl8kywQLyTE9r6
         tFAfckYwzFCJ/kseDK9kf6x3QGNkLDTJUCW/AB8fqXSMRiI+0qr/taKXC1JDjsAEDFJU
         m9ZGUBRuTglAwEcrW6rvNmwoZILYic3NW22heGDm07dQN1hc3HGoWPn/Lq3UVlvuyuYk
         I6Kizk/DDU3WSoo9S7KvRWfjwzAOgyFyZ1IA2tx7mkdqugBeCinuqTBH+k0gS4C8skNM
         GwEwtcLDZ/GzmhoTzawKQyY/GVilcqM7aCgtMmMGV3ZN7XtXU9Wp5+aK9f3Crk7x0n+r
         8jKw==
X-Gm-Message-State: AFqh2koyJ9Ivvf/lmSPXP69O3LPAwj2bcpghNi/vncKQRPFFKjRaiGxB
        v6/w9WWbZJdjqKhOlmyPoVCc1T5ooH1DSw==
X-Google-Smtp-Source: AMrXdXsVeQ7UDGDvSdhFPHYhbQWWnKQygHpuJROokbxt85m41GANQaEBLly9xzbWodhdplpJ5KpmDw==
X-Received: by 2002:a17:907:d311:b0:829:5e3f:3c92 with SMTP id vg17-20020a170907d31100b008295e3f3c92mr88723919ejc.73.1673539406899;
        Thu, 12 Jan 2023 08:03:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qw25-20020a1709066a1900b007ae1e528390sm7491897ejc.163.2023.01.12.08.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 08:03:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] env-helper: move this built-in to to "test-tool env-helper"
Date:   Thu, 12 Jan 2023 17:03:21 +0100
Message-Id: <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1215.g1ba3f685d4f
In-Reply-To: <Y71qiCs+oAS2OegH@coredump.intra.peff.net>
References: <Y71qiCs+oAS2OegH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] there has been no reason for keeping "git env--helper" a
built-in. The reason it was a built-in to begin with was to support
the GIT_TEST_GETTEXT_POISON mode removed in that commit. I.e. unlike
the rest of "test-tool" it would potentially be called by the
installed git via "git-sh-i18n.sh".

As none of that applies since [1] we should stop carrying this
technical debt, and move it to t/helper/*. As this mostly move-only
change shows this has the nice bonus that we'll stop wasting time
translating the internal-only strings it emits.

Even though this was a built-in, it was intentionally never
documented, see its introduction in [2]. It never saw use outside of
the test suite, except for the "GIT_TEST_GETTEXT_POISON" use-case
noted above.

1. d162b25f956 (tests: remove support for GIT_TEST_GETTEXT_POISON,
   2021-01-20)
2. b4f207f3394 (env--helper: new undocumented builtin wrapping
   git_env_*(), 2019-06-21)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, Jan 10 2023, Jeff King wrote:

> The interop test library sets up wrappers "git.a" and "git.b" to
> represent the two versions to be tested. It also wraps vanilla "git" to
> report an error, with the goal of catching tests which accidentally fail
> to use one of the version-specific wrappers (which could invalidate the
> tests in a very subtle way).
>
> As a result, t/interop/i5700 has refused to run since 3b072c577b (tests:
> replace test_tristate with "git env--helper", 2019-06-21). The problem
> is that lib-git-daemon.sh uses "git env--helper" to decide whether to
> run daemon tests, which triggers the vanilla wrapper. That produces an
> error, and we think that the daemon tests are disabled.
>
> Let's make our wrapper a little smarter, and allow env--helper
> specifically. It's not an interesting part of Git to test for interop,
> and it's used extensively in test setup. The matching is rudimentary
> (e.g., it would not catch "git --some-arg env--helper", but it's enough
> for our small set of interop tests).
>
> Let's likewise improve the error message from the wrapper (when it does
> complain) to show the arguments to git. That makes debugging a situation
> like this much easier, since otherwise you are clueless about who is
> calling "git" and why.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously nobody has run these for a while. I just happened to do so
> today while investigating something else. Maybe they're not worth
> keeping around, and we should consider it all a failed experiment.
> But it's easy enough to fix in the meantime.
>
> Arguably "git env--helper" should be "test-tool", which wouldn't run
> into this problem, but it's probably not worth refactoring it for the
> sake of these tests.

I think it's worth doing that, i.e. to take this alternate
approach. When I removed the GIT_TEST_GETTEXT_POISON facility I didn't
want to make that series any larger, and keeping it a built-in seemed
harmless, as there wasn't any practical difference between an
undocumented built-in and a test-tool.

But as your patch shows there is, I think we should just pay down that
technical debt, rather than adding to it by accumulating workarounds
(however small those are...).

 .gitignore                                    |  1 -
 Makefile                                      |  2 +-
 git.c                                         |  1 -
 .../helper/test-env-helper.c                  | 24 +++----
 t/helper/test-tool.c                          |  1 +
 t/helper/test-tool.h                          |  1 +
 t/t0017-env-helper.sh                         | 62 +++++++++----------
 t/test-lib-functions.sh                       |  2 +-
 t/test-lib.sh                                 |  6 +-
 9 files changed, 50 insertions(+), 50 deletions(-)
 rename builtin/env--helper.c => t/helper/test-env-helper.c (71%)

diff --git a/.gitignore b/.gitignore
index e942a83b45b..6782f3cecac 100644
--- a/.gitignore
+++ b/.gitignore
@@ -59,7 +59,6 @@
 /git-difftool
 /git-difftool--helper
 /git-describe
-/git-env--helper
 /git-fast-export
 /git-fast-import
 /git-fetch
diff --git a/Makefile b/Makefile
index db447d07383..f2f342683c1 100644
--- a/Makefile
+++ b/Makefile
@@ -799,6 +799,7 @@ TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
+TEST_BUILTINS_OBJS += test-env-helper.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
@@ -1231,7 +1232,6 @@ BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-tree.o
 BUILTIN_OBJS += builtin/diff.o
 BUILTIN_OBJS += builtin/difftool.o
-BUILTIN_OBJS += builtin/env--helper.o
 BUILTIN_OBJS += builtin/fast-export.o
 BUILTIN_OBJS += builtin/fast-import.o
 BUILTIN_OBJS += builtin/fetch-pack.o
diff --git a/git.c b/git.c
index 32a5be68a17..96b0a2837dc 100644
--- a/git.c
+++ b/git.c
@@ -507,7 +507,6 @@ static struct cmd_struct commands[] = {
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
-	{ "env--helper", cmd_env__helper },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
 	{ "fetch", cmd_fetch, RUN_SETUP },
diff --git a/builtin/env--helper.c b/t/helper/test-env-helper.c
similarity index 71%
rename from builtin/env--helper.c
rename to t/helper/test-env-helper.c
index ea04c166364..66c88b8ff3d 100644
--- a/builtin/env--helper.c
+++ b/t/helper/test-env-helper.c
@@ -1,9 +1,9 @@
-#include "builtin.h"
+#include "test-tool.h"
 #include "config.h"
 #include "parse-options.h"
 
 static char const * const env__helper_usage[] = {
-	N_("git env--helper --type=[bool|ulong] <options> <env-var>"),
+	"test-tool env-helper --type=[bool|ulong] <options> <env-var>",
 	NULL
 };
 
@@ -24,12 +24,12 @@ static int option_parse_type(const struct option *opt, const char *arg,
 	else if (!strcmp(arg, "ulong"))
 		*cmdmode = ENV_HELPER_TYPE_ULONG;
 	else
-		die(_("unrecognized --type argument, %s"), arg);
+		die("unrecognized --type argument, %s", arg);
 
 	return 0;
 }
 
-int cmd_env__helper(int argc, const char **argv, const char *prefix)
+int cmd__env_helper(int argc, const char **argv)
 {
 	int exit_code = 0;
 	const char *env_variable = NULL;
@@ -39,17 +39,17 @@ int cmd_env__helper(int argc, const char **argv, const char *prefix)
 	unsigned long ret_ulong, default_ulong;
 	enum cmdmode cmdmode = 0;
 	struct option opts[] = {
-		OPT_CALLBACK_F(0, "type", &cmdmode, N_("type"),
-			       N_("value is given this type"), PARSE_OPT_NONEG,
+		OPT_CALLBACK_F(0, "type", &cmdmode, "type",
+			       "value is given this type", PARSE_OPT_NONEG,
 			       option_parse_type),
-		OPT_STRING(0, "default", &env_default, N_("value"),
-			   N_("default for git_env_*(...) to fall back on")),
+		OPT_STRING(0, "default", &env_default, "value",
+			   "default for git_env_*(...) to fall back on"),
 		OPT_BOOL(0, "exit-code", &exit_code,
-			 N_("be quiet only use git_env_*() value as exit code")),
+			 "be quiet only use git_env_*() value as exit code"),
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, opts, env__helper_usage,
+	argc = parse_options(argc, argv, NULL, opts, env__helper_usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 	if (env_default && !*env_default)
 		usage_with_options(env__helper_usage, opts);
@@ -64,7 +64,7 @@ int cmd_env__helper(int argc, const char **argv, const char *prefix)
 		if (env_default) {
 			default_int = git_parse_maybe_bool(env_default);
 			if (default_int == -1) {
-				error(_("option `--default' expects a boolean value with `--type=bool`, not `%s`"),
+				error("option `--default' expects a boolean value with `--type=bool`, not `%s`",
 				      env_default);
 				usage_with_options(env__helper_usage, opts);
 			}
@@ -79,7 +79,7 @@ int cmd_env__helper(int argc, const char **argv, const char *prefix)
 	case ENV_HELPER_TYPE_ULONG:
 		if (env_default) {
 			if (!git_parse_ulong(env_default, &default_ulong)) {
-				error(_("option `--default' expects an unsigned long value with `--type=ulong`, not `%s`"),
+				error("option `--default' expects an unsigned long value with `--type=ulong`, not `%s`",
 				      env_default);
 				usage_with_options(env__helper_usage, opts);
 			}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 7eb1a26a305..abe8a785eb6 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -28,6 +28,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-fsmonitor", cmd__dump_fsmonitor },
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
+	{ "env-helper", cmd__env_helper },
 	{ "example-decorate", cmd__example_decorate },
 	{ "fast-rebase", cmd__fast_rebase },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 2e20a16eb82..ea2672436c9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -22,6 +22,7 @@ int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__dump_reftable(int argc, const char **argv);
+int cmd__env_helper(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index 2e42fba9567..fc14ba091cb 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -1,87 +1,87 @@
 #!/bin/sh
 
-test_description='test env--helper'
+test_description='test test-tool env-helper'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
-test_expect_success 'env--helper usage' '
-	test_must_fail git env--helper &&
-	test_must_fail git env--helper --type=bool &&
-	test_must_fail git env--helper --type=ulong &&
-	test_must_fail git env--helper --type=bool &&
-	test_must_fail git env--helper --type=bool --default &&
-	test_must_fail git env--helper --type=bool --default= &&
-	test_must_fail git env--helper --defaultxyz
+test_expect_success 'test-tool env-helper usage' '
+	test_must_fail test-tool env-helper &&
+	test_must_fail test-tool env-helper --type=bool &&
+	test_must_fail test-tool env-helper --type=ulong &&
+	test_must_fail test-tool env-helper --type=bool &&
+	test_must_fail test-tool env-helper --type=bool --default &&
+	test_must_fail test-tool env-helper --type=bool --default= &&
+	test_must_fail test-tool env-helper --defaultxyz
 '
 
-test_expect_success 'env--helper bad default values' '
-	test_must_fail git env--helper --type=bool --default=1xyz MISSING &&
-	test_must_fail git env--helper --type=ulong --default=1xyz MISSING
+test_expect_success 'test-tool env-helper bad default values' '
+	test_must_fail test-tool env-helper --type=bool --default=1xyz MISSING &&
+	test_must_fail test-tool env-helper --type=ulong --default=1xyz MISSING
 '
 
-test_expect_success 'env--helper --type=bool' '
+test_expect_success 'test-tool env-helper --type=bool' '
 	# Test various --default bool values
 	echo true >expected &&
-	git env--helper --type=bool --default=1 MISSING >actual &&
+	test-tool env-helper --type=bool --default=1 MISSING >actual &&
 	test_cmp expected actual &&
-	git env--helper --type=bool --default=yes MISSING >actual &&
+	test-tool env-helper --type=bool --default=yes MISSING >actual &&
 	test_cmp expected actual &&
-	git env--helper --type=bool --default=true MISSING >actual &&
+	test-tool env-helper --type=bool --default=true MISSING >actual &&
 	test_cmp expected actual &&
 	echo false >expected &&
-	test_must_fail git env--helper --type=bool --default=0 MISSING >actual &&
+	test_must_fail test-tool env-helper --type=bool --default=0 MISSING >actual &&
 	test_cmp expected actual &&
-	test_must_fail git env--helper --type=bool --default=no MISSING >actual &&
+	test_must_fail test-tool env-helper --type=bool --default=no MISSING >actual &&
 	test_cmp expected actual &&
-	test_must_fail git env--helper --type=bool --default=false MISSING >actual &&
+	test_must_fail test-tool env-helper --type=bool --default=false MISSING >actual &&
 	test_cmp expected actual &&
 
 	# No output with --exit-code
-	git env--helper --type=bool --default=true --exit-code MISSING >actual.out 2>actual.err &&
+	test-tool env-helper --type=bool --default=true --exit-code MISSING >actual.out 2>actual.err &&
 	test_must_be_empty actual.out &&
 	test_must_be_empty actual.err &&
-	test_must_fail git env--helper --type=bool --default=false --exit-code MISSING >actual.out 2>actual.err &&
+	test_must_fail test-tool env-helper --type=bool --default=false --exit-code MISSING >actual.out 2>actual.err &&
 	test_must_be_empty actual.out &&
 	test_must_be_empty actual.err &&
 
 	# Existing variable
-	EXISTS=true git env--helper --type=bool --default=false --exit-code EXISTS >actual.out 2>actual.err &&
+	EXISTS=true test-tool env-helper --type=bool --default=false --exit-code EXISTS >actual.out 2>actual.err &&
 	test_must_be_empty actual.out &&
 	test_must_be_empty actual.err &&
 	test_must_fail \
 		env EXISTS=false \
-		git env--helper --type=bool --default=true --exit-code EXISTS >actual.out 2>actual.err &&
+		test-tool env-helper --type=bool --default=true --exit-code EXISTS >actual.out 2>actual.err &&
 	test_must_be_empty actual.out &&
 	test_must_be_empty actual.err
 '
 
-test_expect_success 'env--helper --type=ulong' '
+test_expect_success 'test-tool env-helper --type=ulong' '
 	echo 1234567890 >expected &&
-	git env--helper --type=ulong --default=1234567890 MISSING >actual.out 2>actual.err &&
+	test-tool env-helper --type=ulong --default=1234567890 MISSING >actual.out 2>actual.err &&
 	test_cmp expected actual.out &&
 	test_must_be_empty actual.err &&
 
 	echo 0 >expected &&
-	test_must_fail git env--helper --type=ulong --default=0 MISSING >actual &&
+	test_must_fail test-tool env-helper --type=ulong --default=0 MISSING >actual &&
 	test_cmp expected actual &&
 
-	git env--helper --type=ulong --default=1234567890 --exit-code MISSING >actual.out 2>actual.err &&
+	test-tool env-helper --type=ulong --default=1234567890 --exit-code MISSING >actual.out 2>actual.err &&
 	test_must_be_empty actual.out &&
 	test_must_be_empty actual.err &&
 
-	EXISTS=1234567890 git env--helper --type=ulong --default=0 EXISTS --exit-code >actual.out 2>actual.err &&
+	EXISTS=1234567890 test-tool env-helper --type=ulong --default=0 EXISTS --exit-code >actual.out 2>actual.err &&
 	test_must_be_empty actual.out &&
 	test_must_be_empty actual.err &&
 
 	echo 1234567890 >expected &&
-	EXISTS=1234567890 git env--helper --type=ulong --default=0 EXISTS >actual.out 2>actual.err &&
+	EXISTS=1234567890 test-tool env-helper --type=ulong --default=0 EXISTS >actual.out 2>actual.err &&
 	test_cmp expected actual.out &&
 	test_must_be_empty actual.err
 '
 
-test_expect_success 'env--helper reads config thanks to trace2' '
+test_expect_success 'test-tool env-helper reads config thanks to trace2' '
 	mkdir home &&
 	git config -f home/.gitconfig include.path cycle &&
 	git config -f home/cycle include.path .gitconfig &&
@@ -93,7 +93,7 @@ test_expect_success 'env--helper reads config thanks to trace2' '
 
 	test_must_fail \
 		env HOME="$(pwd)/home" GIT_TEST_ENV_HELPER=true \
-		git -C cycle env--helper --type=bool --default=0 --exit-code GIT_TEST_ENV_HELPER 2>err &&
+		test-tool -C cycle env-helper --type=bool --default=0 --exit-code GIT_TEST_ENV_HELPER 2>err &&
 	grep "exceeded maximum include depth" err
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 54e74d5301d..525055d44bc 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1422,7 +1422,7 @@ test_bool_env () {
 		BUG "test_bool_env requires two parameters (variable name and default value)"
 	fi
 
-	git env--helper --type=bool --default="$2" --exit-code "$1"
+	test-tool env-helper --type=bool --default="$2" --exit-code "$1"
 	ret=$?
 	case $ret in
 	0|1)	# unset or valid bool value
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4fab1c1984c..01e88781dd2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1542,8 +1542,8 @@ then
 	# Normalize with test_bool_env
 	passes_sanitize_leak=
 
-	# We need to see TEST_PASSES_SANITIZE_LEAK in "git
-	# env--helper" (via test_bool_env)
+	# We need to see TEST_PASSES_SANITIZE_LEAK in "test-tool
+	# env-helper" (via test_bool_env)
 	export TEST_PASSES_SANITIZE_LEAK
 	if test_bool_env TEST_PASSES_SANITIZE_LEAK false
 	then
@@ -1682,7 +1682,7 @@ yes () {
 # The GIT_TEST_FAIL_PREREQS code hooks into test_set_prereq(), and
 # thus needs to be set up really early, and set an internal variable
 # for convenience so the hot test_set_prereq() codepath doesn't need
-# to call "git env--helper" (via test_bool_env). Only do that work
+# to call "test-tool env-helper" (via test_bool_env). Only do that work
 # if needed by seeing if GIT_TEST_FAIL_PREREQS is set at all.
 GIT_TEST_FAIL_PREREQS_INTERNAL=
 if test -n "$GIT_TEST_FAIL_PREREQS"
-- 
2.39.0.1215.g1ba3f685d4f

