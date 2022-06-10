Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D38C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbiFJCC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345960AbiFJCCS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB457BDA3A
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:02:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p10so34633101wrg.12
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bJNiKchi+yd4bLr8Hs8/H73KcvPvRXcjPn6HIppkwg=;
        b=I0p6/ZzN+7eRVtOSi/Cqk/pEaT7tOcSFMlQ3EGUGCdXTR639CTy0FZdU2Xwjt28X+k
         3x2iTNVfGlwwtv4bFF1qKbz9yLL5re2BMAUwhK7Q//qUxnGbHj8FmxZDh63e3cMmWTVz
         6LYsHgSxIOIX9pgPkbYfbMgnPxCi6QM3xNG9tH6JEHIl2KB+O/xU34gn+LmifEgNPt9+
         6nc7O0Jw6SpujH0x7xw0UxaTMqF1M+T0X/dWrasDh11+2i+pY/IEgOpnwAfUwBmvC6Wi
         iwJd3h4kplqZ7uHZQ4FauCj/avSW0MNmG61BqtapF2A+YN6bIH5OXYx1ufKTOTig6A6s
         Rn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bJNiKchi+yd4bLr8Hs8/H73KcvPvRXcjPn6HIppkwg=;
        b=x8/GEALh/YiRFA9cK6izHodwvB+GkGc2k7QhAdjMW2X4DWNhFQx8FAY7BDvQ5jb9gf
         DFUhUb1pw9OqBRRZg7hIAwe0N9y2XLJ0QXGo5DGknrk0Bg2eThLrrXRQSMEpAFkmvK8E
         Bmg/rovCCIqgWU5QZoUuXpvxTkGr6bNm+TcZOajVqxnfRb48P2nayt/7IVG4tJNvfvAX
         2Lj9BYMnR9wn4r5AXPPWpTh4yMYAA3oU9Ip7RkBepfzXFiGqnlt4qzi9QaR3YSReoMeL
         Ky1g+kY/BR1G+lK0SKCU4soYjE8NGJncMfr3AouAvTJa1QkGt64zTpukfAm5OWBg+tD2
         IjRQ==
X-Gm-Message-State: AOAM533akJ1iLpS9YrXV5SxmlMI1pp1aOD1jdczOqN9rGgjOmHBMmL0U
        Qbq/de/geE53ipnN96sBdqhp30wNPzkRZw==
X-Google-Smtp-Source: ABdhPJzaCBwCzJYqEpAWqt6I/sKJTDZwWeUN/moO+bdSQUErzMzgj7CzLPG0M7xNZFQdLW85/OyzjA==
X-Received: by 2002:adf:f3ce:0:b0:211:55a:a604 with SMTP id g14-20020adff3ce000000b00211055aa604mr40986065wrp.213.1654826524634;
        Thu, 09 Jun 2022 19:02:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:02:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 19/20] submodule: make it a built-in, remove git-submodule.sh
Date:   Fri, 10 Jun 2022 04:01:31 +0200
Message-Id: <RFC-patch-19.20-1423950de08-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the now-trivial git-submodule.sh script with a built-in
builtin/submodule.c. For now this new command is only a dumb
dispatcher that uses run-command.c to invoke "git submodule--helper",
just as "git-submodule.sh" used to do.

This is obviously not ideal, and we should follow-up and merge the
builtin/submodule--helper.c code into builtin/submodule.c, but doing it
this way makes it easy to review that this new C implementation isn't
doing anything more clever than the old shellscript implementation.

The "define BUILTIN_" macros will help with that, i.e. the usage
information we emit can be merged with what
builtin/submodule--helper.c is now emitting. See
8757b35d443 (commit-graph: define common usage with a macro,
2021-08-23) and 1e91d3faf6c (reflog: move "usage" variables and use
macros, 2022-03-17) for prior art using this pattern.

The "(argc < 2 || !strcmp(argv[1], "-h"))" path at the top of
cmd_submodule__helper() could now be a "(argc < 2)" if not for
t0012-help.sh (which invokes all built-ins manually with "-h"). Let's
leave it for now, eventually we'll consolidate the two.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile            |   2 +-
 builtin.h           |   1 +
 builtin/submodule.c | 138 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh    |  80 -------------------------
 git.c               |   1 +
 5 files changed, 141 insertions(+), 81 deletions(-)
 create mode 100644 builtin/submodule.c
 delete mode 100755 git-submodule.sh

diff --git a/Makefile b/Makefile
index 790382bd1e3..635ab791a8a 100644
--- a/Makefile
+++ b/Makefile
@@ -622,7 +622,6 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_LIB += git-mergetool--lib
@@ -1213,6 +1212,7 @@ BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/sparse-checkout.o
 BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
+BUILTIN_OBJS += builtin/submodule.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
diff --git a/builtin.h b/builtin.h
index 40e9ecc8485..c8cf4a2ae3b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -223,6 +223,7 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
 int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stash(int argc, const char **argv, const char *prefix);
 int cmd_stripspace(int argc, const char **argv, const char *prefix);
+int cmd_submodule(int argc, const char **argv, const char *prefix);
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 int cmd_switch(int argc, const char **argv, const char *prefix);
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/submodule.c b/builtin/submodule.c
new file mode 100644
index 00000000000..b777787169e
--- /dev/null
+++ b/builtin/submodule.c
@@ -0,0 +1,138 @@
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
+			      int quiet, int cached, struct strvec *args)
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
+	/* Either a valid command, or submodule--helper will barf! */
+	cmd = argv[0];
+	strvec_push(args, cmd);
+	argv++;
+	argc--;
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
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, git_submodule_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	/*
+	 * Tell the rest of git that any URLs we get don't come
+	 * directly from the user, so it can apply policy as appropriate.
+	 */
+	strvec_push(&cp.env_array, "GIT_PROTOCOL_FROM_USER=0");
+	setup_helper_args(argc, argv, prefix, opt_quiet, opt_cached,
+			  &cp.args);
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 0; /* for git submodule foreach */
+	cp.dir = startup_info->original_cwd;
+	ret = run_command(&cp);
+
+	return ret;
+}
diff --git a/git-submodule.sh b/git-submodule.sh
deleted file mode 100755
index 0274b253297..00000000000
--- a/git-submodule.sh
+++ /dev/null
@@ -1,80 +0,0 @@
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
-   or: $dashless [--quiet] update [-v] [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
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
-quiet=
-cached=
-
-while test $# != 0
-do
-	case "$1" in
-	-q|--quiet)
-		quiet=1 &&
-		shift
-		;;
-	--cached)
-		cached=1 &&
-		shift
-		;;
-	*)
-		break
-		;;
-	esac
-done
-
-# No command word defaults to "status"
-command=
-if test $# = 0
-then
-	command=status
-else
-	case "$1" in
-	add | foreach | init | deinit | update | set-branch | set-url | status | summary | sync | absorbgitdirs)
-		command=$1 &&
-		shift
-		;;
-	*)
-		usage
-	esac
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
-*)
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-		${quiet:+--quiet} ${cached:+--cached} "$@"
-	;;
-esac
diff --git a/git.c b/git.c
index 5ff4f3e25b7..047fc262cd2 100644
--- a/git.c
+++ b/git.c
@@ -609,6 +609,7 @@ static struct cmd_struct commands[] = {
 	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
+	{ "submodule", cmd_submodule, RUN_SETUP | NEED_WORK_TREE },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-- 
2.36.1.1178.gb5b1747c546

