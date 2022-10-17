Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A24C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJQMKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJQMKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:10:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE31A213
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a3so18220945wrt.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzyHZOoywTy77IdmEqu3NglRt7Zc+HCpDjQgz+rDtlg=;
        b=b3JvtGDkMMltJyRDsD+/a5KfLuDWLnJBel9RHfbgp8RlFkeM9Pz3WML2kATSsackR+
         ku/v+2m7IqLMXzqS+vSf8E5omIF+kpYXjS3HsN4spCEcsF12MaSatayGyKM2/YLr66ZB
         S97bUGIpgLlpKtCeUwzRPxtO0MZqCYbT+pi7NbQ9IiibPxKCbnScfCpUmLtCiok3iDrG
         Smna9o0OiHzbQnMNxrckRPm17Wh9/bSCha03zZOqQ+SFhKt6mfypGuHWTtRh6/xMZ0cJ
         B4MyYJELs9ilgqsoEJeR5/uN00OKBHL/TBX0oyW+Nc2mGCeh3A7qVyDYPdNflhesc6BN
         1SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzyHZOoywTy77IdmEqu3NglRt7Zc+HCpDjQgz+rDtlg=;
        b=iL4Y3TckTc8oX+6IvalY/W0HRTGmhxOPvtO80yde5c52ougwa9fKl/Eg9tBVeDgMsS
         4p3TTCaThTJF166d3VEF9nZ+GOmYweqa7evCOf12K86z6iTCY/yGC8bC92U3wF1wQ+uP
         n1W4tR+wjKCqoNC3jDlhSqb4HbAZ+osFHi9cz60c6Jlx0RL5oyj6kXawjoXgZpnYESvE
         qfKrhnOEPbm4qXBTzWmncbU0xKCCfRyh/0H8Ngdh1MMm4GIZkeBCdyA9OCUcxkActUac
         ACWJwi3R1GZHwBgje+7PaynrXCGuY22la2TWH10kOwFanpHTvtpeNoAlRMINbnzvxCj0
         FoKw==
X-Gm-Message-State: ACrzQf0bv/ccfxb4/OOCcCF3OvYNJC/zyKoGRu+Y1/DUmWy721rfgk1+
        RXxUNmed2zeW1RjkwFzHRgm7GdhOYfbtHQ==
X-Google-Smtp-Source: AMsMyM5k2S8t9f3GwyLhCYXYjeMYtVHsyj7f9KAek1JDDl7zc3j/Rd/QIBFr4XKPNv/9NycXAtNj3w==
X-Received: by 2002:adf:e70a:0:b0:22c:da3f:36ee with SMTP id c10-20020adfe70a000000b0022cda3f36eemr6249152wrm.414.1666008577724;
        Mon, 17 Oct 2022 05:09:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] submodule: make it a built-in, remove git-submodule.sh
Date:   Mon, 17 Oct 2022 14:09:22 +0200
Message-Id: <patch-07.10-2c77ed38d90-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the "git-submodule.sh" script with a built-in
"builtin/submodule.c. For" now this new command is only a dumb
dispatcher that uses run-command.c to invoke "git submodule--helper",
just as "git-submodule.sh" used to do.

This is obviously not ideal, and we should eventually follow-up and
merge the "builtin/submodule--helper.c" code into
"builtin/submodule.c". Doing it this way makes it easy to review that
this new C implementation isn't doing anything more clever than the
old shellscript implementation.

This is a large win for performance, we're now more than 4x as fast as
before in terms of the fixed cost of invoking any "git submodule"
command[1]:

	$ git hyperfine -L rev HEAD~1,HEAD -s 'make CFLAGS=-O3' './git --exec-path=$PWD submodule foreach "echo \$name"'
	Benchmark 1: ./git --exec-path=$PWD submodule foreach "echo \$name"' in 'HEAD~1
	  Time (mean ± σ):      42.2 ms ±   0.4 ms    [User: 34.9 ms, System: 9.1 ms]
	  Range (min … max):    41.3 ms …  43.2 ms    70 runs

	Benchmark 2: ./git --exec-path=$PWD submodule foreach "echo \$name"' in 'HEAD
	  Time (mean ± σ):       9.7 ms ±   0.1 ms    [User: 7.6 ms, System: 2.2 ms]
	  Range (min … max):     9.5 ms …  10.3 ms    282 runs

	Summary
	  './git --exec-path=$PWD submodule foreach "echo \$name"' in 'HEAD' ran
	    4.33 ± 0.07 times faster than './git --exec-path=$PWD submodule foreach "echo \$name"' in 'HEAD~1'

We're taking pains here to faithfully reproduce existing
"git-submodule.sh" behavior, even when that behavior is stupid. Some
of it we'll fix in subsequent commits, but let's first faithfully
reproduce the behavior.

One exception is the change in the behavior of the exit code
stand-alone "-h" and "--" yield, see the altered tests. Returning 129
instead of 0 and 1 for "-h" and "--" respectively is a concession to
basic sanity.

The pattern of using "define BUILTIN_" macros here isn't needed for
now, but as we'll move code out of "builtin/submodule--helper.c" we'll
want to re-use these strings. See 8757b35d443 (commit-graph: define
common usage with a macro, 2021-08-23) and 1e91d3faf6c (reflog: move
"usage" variables and use macros, 2022-03-17) for prior art using this
pattern.

The "(argc < 2 || !strcmp(argv[1], "-h"))" path at the top of
cmd_submodule__helper() could now be a "(argc < 2)" if not for
t0012-help.sh (which invokes all built-ins manually with "-h"). Let's
leave it for now, eventually we'll consolidate the two.

1. Using the "git hyperfine" wrapper for "hyperfine":
   https://lore.kernel.org/git/211201.86r1aw9gbd.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                   |   2 +-
 builtin.h                  |   1 +
 builtin/submodule.c        | 151 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh           |  91 ----------------------
 git.c                      |   1 +
 t/t7400-submodule-basic.sh |  12 ++-
 6 files changed, 159 insertions(+), 99 deletions(-)
 create mode 100644 builtin/submodule.c
 delete mode 100755 git-submodule.sh

diff --git a/Makefile b/Makefile
index 6bfb62cbe94..d8e2c02ad42 100644
--- a/Makefile
+++ b/Makefile
@@ -635,7 +635,6 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
@@ -1235,6 +1234,7 @@ BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/sparse-checkout.o
 BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
+BUILTIN_OBJS += builtin/submodule.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
diff --git a/builtin.h b/builtin.h
index 8901a34d6bf..475c79b6a5a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -224,6 +224,7 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
 int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stash(int argc, const char **argv, const char *prefix);
 int cmd_stripspace(int argc, const char **argv, const char *prefix);
+int cmd_submodule(int argc, const char **argv, const char *prefix);
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 int cmd_switch(int argc, const char **argv, const char *prefix);
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/submodule.c b/builtin/submodule.c
new file mode 100644
index 00000000000..7e3499f3376
--- /dev/null
+++ b/builtin/submodule.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright (c) 2007-2022 Lars Hjemli & others
+ * Copyright(c) 2022 Ævar Arnfjörð Bjarmason
+ */
+#include "builtin.h"
+#include "parse-options.h"
+#include "run-command.h"
+#include "strvec.h"
+
+#define BUILTIN_SUBMODULE_USAGE \
+	"git submodule [--quiet] [--cached]"
+
+#define BUILTIN_SUBMODULE_ADD_USAGE \
+	N_("git submodule [--quiet] add [-b <branch>] [-f | --force] [--name <name>]\n" \
+	   "              [--reference <repository>] [--] <repository> [<path>]")
+
+#define BUILTIN_SUBMODULE_STATUS_USAGE \
+	N_("git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]")
+
+#define BUILTIN_SUBMODULE_INIT_USAGE \
+	N_("git submodule [--quiet] init [--] [<path>...]")
+
+#define BUILTIN_SUBMODULE_DEINIT_USAGE \
+	N_("git submodule [--quiet] deinit [-f | --force] (--all | [--] <path>...)")
+
+#define BUILTIN_SUBMODULE_UPDATE_USAGE \
+	N_("git submodule [--quiet] update [-v] [--init [--filter=<filter-spec>]]\n" \
+	   "              [--remote] [-N | --no-fetch] [-f | --force] [--checkout |--merge | --rebase]\n" \
+	   "              [--[no-]recommend-shallow] [--reference <repository>] [--recursive]\n" \
+	   "              [--[no-]single-branch] [--] [<path>...]")
+
+#define BUILTIN_SUBMODULE_SET_BRANCH_USAGE \
+	N_("git submodule [--quiet] set-branch (--default | --branch <branch>) [--] <path>")
+
+#define BUILTIN_SUBMODULE_SET_URL_USAGE \
+	N_("git submodule [--quiet] set-url [--] <path> <newurl>")
+
+#define BUILTIN_SUBMODULE_SUMMARY_USAGE \
+	N_("git submodule [--quiet] summary [--cached | --files] [--summary-limit <n>]\n"  \
+	   "              [commit] [--] [<path>...]")
+#define BUILTIN_SUBMODULE_FOREACH_USAGE \
+	N_("git submodule [--quiet] foreach [--recursive] <command>")
+
+#define BUILTIN_SUBMODULE_SYNC_USAGE \
+	N_("git submodule [--quiet] sync [--recursive] [--] [<path>...]")
+
+#define BUILTIN_SUBMODULE_ABSORBGITDIRS_USAGE \
+	N_("git submodule [--quiet] absorbgitdirs [--] [<path>...]")
+
+static const char * const git_submodule_usage[] = {
+	BUILTIN_SUBMODULE_USAGE,
+	BUILTIN_SUBMODULE_ADD_USAGE,
+	BUILTIN_SUBMODULE_STATUS_USAGE,
+	BUILTIN_SUBMODULE_INIT_USAGE,
+	BUILTIN_SUBMODULE_DEINIT_USAGE,
+	BUILTIN_SUBMODULE_UPDATE_USAGE,
+	BUILTIN_SUBMODULE_SET_BRANCH_USAGE,
+	BUILTIN_SUBMODULE_SET_URL_USAGE,
+	BUILTIN_SUBMODULE_SUMMARY_USAGE,
+	BUILTIN_SUBMODULE_FOREACH_USAGE,
+	BUILTIN_SUBMODULE_SYNC_USAGE,
+	BUILTIN_SUBMODULE_ABSORBGITDIRS_USAGE,
+	NULL,
+};
+
+static void setup_helper_args(int argc, const char **argv, const char *prefix,
+			      int quiet, int cached, struct strvec *args,
+			      const struct option *options)
+{
+	const char *cmd;
+	int do_quiet_cache = 1;
+	int do_prefix = 1;
+
+	strvec_push(args, "submodule--helper");
+
+	/* No command word defaults to "status" */
+	if (!argc) {
+		strvec_push(args, "status");
+		return;
+	}
+
+	/* Did we get --cached with a command? */
+	if (cached)
+		usage_msg_optf(_("'%s' option is only supported with explicit 'status'"),
+			       git_submodule_usage, options, "--cached");
+
+
+	/* Either a valid command, or submodule--helper will barf! */
+	cmd = argv[0];
+	strvec_push(args, cmd);
+	argv++;
+	argc--;
+
+	/*
+	  * This is stupid, but don't support "[--]" to
+	 * subcommand-less "git-submodule" for now.
+	 */
+	if (!strcmp(cmd, "--") || !strcmp(cmd, "--end-of-options"))
+		usage_msg_optf(_("need explicit sub-command name to delimit with '%s'"),
+			       git_submodule_usage, options, cmd);
+
+	/* Options that need to go before user-supplied options */
+	if (!strcmp(cmd, "absorbgitdirs"))
+		do_quiet_cache = 0;
+	else if (!strcmp(cmd, "update"))
+		;
+	else
+		do_prefix = 0;
+	if (do_quiet_cache) {
+		if (quiet)
+			strvec_push(args, "--quiet");
+		if (cached)
+			strvec_push(args, "--cached");
+
+		if (prefix && do_prefix)
+			strvec_pushl(args, "--prefix", prefix, NULL);
+	}
+
+	/* All commands get argv, including a "--", if any */
+	strvec_pushv(args, argv);
+}
+
+int cmd_submodule(int argc, const char **argv, const char *prefix)
+{
+	int opt_quiet = 0;
+	int opt_cached = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct option options[] = {
+		OPT__QUIET(&opt_quiet, N_("be quiet")),
+		OPT_BOOL(0, "cached", &opt_cached,
+			 N_("print the OID of submodules")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, git_submodule_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_KEEP_DASHDASH);
+
+	/*
+	 * Tell the rest of git that any URLs we get don't come
+	 * directly from the user, so it can apply policy as appropriate.
+	 */
+	strvec_push(&cp.env, "GIT_PROTOCOL_FROM_USER=0");
+	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
+			  &cp.args, options);
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 0; /* for git submodule foreach */
+	cp.dir = startup_info->original_cwd;
+
+	return run_command(&cp);
+}
diff --git a/git-submodule.sh b/git-submodule.sh
deleted file mode 100755
index 4f8f62ce981..00000000000
--- a/git-submodule.sh
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/sh
-#
-# git-submodule.sh: add, init, update or list git submodules
-#
-# Copyright (c) 2007 Lars Hjemli
-
-dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] [--cached]
-   or: $dashless [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
-   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
-   or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
-   or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
-   or: $dashless [--quiet] set-url [--] <path> <newurl>
-   or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach [--recursive] <command>
-   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
-   or: $dashless [--quiet] absorbgitdirs [--] [<path>...]"
-OPTIONS_SPEC=
-SUBDIRECTORY_OK=Yes
-. git-sh-setup
-require_work_tree
-wt_prefix=$(git rev-parse --show-prefix)
-cd_to_toplevel
-
-# Tell the rest of git that any URLs we get don't come
-# directly from the user, so it can apply policy as appropriate.
-GIT_PROTOCOL_FROM_USER=0
-export GIT_PROTOCOL_FROM_USER
-
-command=
-quiet=
-cached=
-
-while test $# != 0 && test -z "$command"
-do
-	case "$1" in
-	add | foreach | init | deinit | update | set-branch | set-url | status | summary | sync | absorbgitdirs)
-		command=$1
-		;;
-	-q|--quiet)
-		quiet=1
-		;;
-	--cached)
-		if test -z "$command"
-		then
-			cached=1 &&
-			shift &&
-			break
-		else
-			usage
-		fi
-		;;
-	--)
-		break
-		;;
-	-*)
-		usage
-		;;
-	*)
-		break
-		;;
-	esac
-	shift
-done
-
-# No command word defaults to "status"
-if test -z "$command"
-then
-    if test $# = 0
-    then
-	command=status
-    else
-	usage
-    fi
-fi
-
-case "$command" in
-absorbgitdirs)
-	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
-	;;
-update)
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-		${quiet:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
-	;;
-add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-		${quiet:+--quiet} ${cached:+--cached} "$@"
-	;;
-esac
diff --git a/git.c b/git.c
index da411c53822..2ad14f1e38f 100644
--- a/git.c
+++ b/git.c
@@ -610,6 +610,7 @@ static struct cmd_struct commands[] = {
 	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
+	{ "submodule", cmd_submodule, RUN_SETUP | NEED_WORK_TREE },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d8f7d6ee29a..19df3407ef1 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -15,20 +15,18 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success 'submodule usage: -h' '
-	git submodule -h >out 2>err &&
+	test_expect_code 129 git submodule -h >out 2>err &&
 	grep "^usage: git submodule" out &&
 	test_must_be_empty err
 '
 
 test_expect_success 'submodule usage: --recursive' '
-	test_expect_code 1 git submodule --recursive >out 2>err &&
-	grep "^usage: git submodule" err &&
-	test_must_be_empty out
+	test_expect_code 129 git submodule --recursive
 '
 
 test_expect_success 'submodule usage: status --' '
-	test_expect_code 1 git submodule -- &&
-	test_expect_code 1 git submodule --end-of-options
+	test_expect_code 129 git submodule -- &&
+	test_expect_code 129 git submodule --end-of-options
 '
 
 for opt in '--quiet'
@@ -45,7 +43,7 @@ do
 	test_expect_success "submodule usage: status $opt" '
 		git submodule $opt &&
 		git submodule status $opt &&
-		test_expect_code 1 git submodule $opt status >out 2>err &&
+		test_expect_code 129 git submodule $opt status >out 2>err &&
 		grep "^usage: git submodule" err &&
 		test_must_be_empty out
 	'
-- 
2.38.0.1091.gf9d18265e59

