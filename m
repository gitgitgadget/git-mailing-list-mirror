Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A68920248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfBYXRb (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44095 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfBYXRb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id w2so11802068wrt.11
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0l0wTL9qFiLZ1NukxQLfQpg6OCXmghkpKrWuSzOiFQ=;
        b=bzpc54fVFQEA7N732PTG0ARkvt0HWDUc2edB/+mVpXOETQRItU8OmTv0VH/2BlPijl
         S/5pMGV7W4mcqOXIozGWFMNXIDQxdm7uL6BZNaY+DDxIOKXERyiOQu7+bDX8EXioENc9
         c/zI8m9IeJfCKCFQHl1vohqvjnFnss6rRC9MlMBT45FyBDVKuJksjiEvtqkhGBCl7TST
         rv0M/kjp+NUH/s2Tp1nUw/QoAZ/NbSiXvNTF5KlJ8wctk9pwmXr6ugKNrehR2mJwJ8Wx
         FxUELo1tesvyQNwBhaxZJTYpMJ3n+gWEwoMXkV/GY79nl+3KT7qr1iB8t80Wr+DKGNpS
         Zb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0l0wTL9qFiLZ1NukxQLfQpg6OCXmghkpKrWuSzOiFQ=;
        b=UCWpNF+RbS7Ji6wenC5OEZ6S79MWFW50eNGbnh9711HmvRb9xAXnskqUiRa+rDmI5q
         vcRUwj56qnPLyoxm10EO9NxmTLjRlVTyTUCa3McsInqKunaElH/BK6Y6HDQzoAVTbrj1
         hn/+BBHizA2/4UMqXCqptTGnlpG8ltKGDJ8hyVCObgLizhvcix2Akb6EfXLmpMA1Puls
         iW1h1FYAQcorIL5zB400R61T4myb2WVAtD8knN9T2+wlBEJ5kmwCKVLn/nAv20k73fAn
         OXAfDBma+xEU1lK513OPJoriT7tD4EOd7YD6P0Ob9Jqc2kOFvWfDmXSUFAboKEHn0J9d
         P3Yg==
X-Gm-Message-State: AHQUAuZjCARIrNJJjzUgeQI7sPaZ+x64pnXjlNs0jk9arWBd50Z00gyw
        Yx83/0g9FGnVgeJ1aBjVBG9kK9NP
X-Google-Smtp-Source: AHgI3IYuJ7fu/wBBvSdQl8pAoud1zH2HyP1Xthtm2sZ6QIUKMGVLipq3pEffsVjDqdayu4eeSaiQEw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr14676111wrm.127.1551136647653;
        Mon, 25 Feb 2019 15:17:27 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id l130sm9025780wmf.13.2019.02.25.15.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:26 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 24/27] stash: convert `stash--helper.c` into `stash.c`
Date:   Mon, 25 Feb 2019 23:16:28 +0000
Message-Id: <20190225231631.30507-25-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

The old shell script `git-stash.sh`  was removed and replaced
entirely by `builtin/stash.c`. In order to do that, `create` and
`push` were adapted to work without `stash.sh`. For example, before
this commit, `git stash create` called `git stash--helper create
--message "$*"`. If it called `git stash--helper create "$@"`, then
some of these changes wouldn't have been necessary.

This commit also removes the word `helper` since now stash is
called directly and not by a shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 .gitignore                           |   1 -
 Makefile                             |   3 +-
 builtin.h                            |   2 +-
 builtin/{stash--helper.c => stash.c} | 156 +++++++++++++++------------
 git-stash.sh                         | 153 --------------------------
 git.c                                |   2 +-
 6 files changed, 92 insertions(+), 225 deletions(-)
 rename builtin/{stash--helper.c => stash.c} (91%)
 delete mode 100755 git-stash.sh

diff --git a/.gitignore b/.gitignore
index 6ecab90ab2..0d77ea5894 100644
--- a/.gitignore
+++ b/.gitignore
@@ -162,7 +162,6 @@
 /git-show-ref
 /git-stage
 /git-stash
-/git-stash--helper
 /git-status
 /git-stripspace
 /git-submodule
diff --git a/Makefile b/Makefile
index c246fc7078..8cee2731aa 100644
--- a/Makefile
+++ b/Makefile
@@ -619,7 +619,6 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-legacy-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
@@ -1117,7 +1116,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
-BUILTIN_OBJS += builtin/stash--helper.o
+BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index ff4460aff7..b78ab6e30b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -225,7 +225,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
-extern int cmd_stash__helper(int argc, const char **argv, const char *prefix);
+extern int cmd_stash(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash--helper.c b/builtin/stash.c
similarity index 91%
rename from builtin/stash--helper.c
rename to builtin/stash.c
index 5f8c99c12f..d9f3956ef5 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash.c
@@ -16,75 +16,70 @@
 
 #define INCLUDE_ALL_FILES 2
 
-static const char * const git_stash_helper_usage[] = {
-	N_("git stash--helper list [<options>]"),
-	N_("git stash--helper show [<options>] [<stash>]"),
-	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
-	N_("git stash--helper branch <branchname> [<stash>]"),
-	N_("git stash--helper clear"),
-	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_usage[] = {
+	N_("git stash list [<options>]"),
+	N_("git stash show [<options>] [<stash>]"),
+	N_("git stash drop [-q|--quiet] [<stash>]"),
+	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash branch <branchname> [<stash>]"),
+	N_("git stash clear"),
+	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--] [<pathspec>...]]"),
-	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_list_usage[] = {
-	N_("git stash--helper list [<options>]"),
+static const char * const git_stash_list_usage[] = {
+	N_("git stash list [<options>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_show_usage[] = {
-	N_("git stash--helper show [<options>] [<stash>]"),
+static const char * const git_stash_show_usage[] = {
+	N_("git stash show [<options>] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_drop_usage[] = {
-	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+static const char * const git_stash_drop_usage[] = {
+	N_("git stash drop [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_pop_usage[] = {
-	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+static const char * const git_stash_pop_usage[] = {
+	N_("git stash pop [--index] [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_apply_usage[] = {
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+static const char * const git_stash_apply_usage[] = {
+	N_("git stash apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_branch_usage[] = {
-	N_("git stash--helper branch <branchname> [<stash>]"),
+static const char * const git_stash_branch_usage[] = {
+	N_("git stash branch <branchname> [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_clear_usage[] = {
-	N_("git stash--helper clear"),
+static const char * const git_stash_clear_usage[] = {
+	N_("git stash clear"),
 	NULL
 };
 
-static const char * const git_stash_helper_store_usage[] = {
-	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
+static const char * const git_stash_store_usage[] = {
+	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
 	NULL
 };
 
-static const char * const git_stash_helper_create_usage[] = {
-	N_("git stash--helper create [<message>]"),
-	NULL
-};
-
-static const char * const git_stash_helper_push_usage[] = {
-	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_push_usage[] = {
+	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--] [<pathspec>...]]"),
 	NULL
 };
 
-static const char * const git_stash_helper_save_usage[] = {
-	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_save_usage[] = {
+	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
@@ -220,7 +215,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_clear_usage,
+			     git_stash_clear_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc)
@@ -521,7 +516,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_apply_usage, 0);
+			     git_stash_apply_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -594,7 +589,7 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_drop_usage, 0);
+			     git_stash_drop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -620,7 +615,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_pop_usage, 0);
+			     git_stash_pop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -647,7 +642,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_branch_usage, 0);
+			     git_stash_branch_usage, 0);
 
 	if (!argc) {
 		fprintf_ln(stderr, _("No branch name specified"));
@@ -682,7 +677,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_list_usage,
+			     git_stash_list_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!ref_exists(ref_stash))
@@ -762,7 +757,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (argc > 1) {
 		free_stash_info(&info);
-		usage_with_options(git_stash_helper_show_usage, options);
+		usage_with_options(git_stash_show_usage, options);
 	}
 
 	rev.diffopt.flags.recursive = 1;
@@ -808,7 +803,7 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_store_usage,
+			     git_stash_store_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (argc != 1) {
@@ -1221,30 +1216,19 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 
 static int create_stash(int argc, const char **argv, const char *prefix)
 {
-	int include_untracked = 0;
 	int ret = 0;
-	const char *stash_msg = NULL;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct stash_info info;
 	struct pathspec ps;
-	struct option options[] = {
-		OPT_BOOL('u', "include-untracked", &include_untracked,
-			 N_("include untracked files in stash")),
-		OPT_STRING('m', "message", &stash_msg, N_("message"),
-			 N_("stash message")),
-		OPT_END()
-	};
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_create_usage,
-			     0);
+	/* Starting with argv[1], since argv[0] is "create" */
+	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
 	if (!check_changes_tracked_files(ps))
 		return 0;
 
-	strbuf_addstr(&stash_msg_buf, stash_msg);
-	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
+	ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1476,9 +1460,10 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_push_usage,
-			     0);
+	if (argc)
+		argc = parse_options(argc, argv, prefix, options,
+				     git_stash_push_usage,
+				     0);
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
 	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
@@ -1511,7 +1496,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_save_usage,
+			     git_stash_save_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (argc)
@@ -1525,10 +1510,12 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+int cmd_stash(int argc, const char **argv, const char *prefix)
 {
+	int i = -1;
 	pid_t pid = getpid();
 	const char *index_file;
+	struct argv_array args = ARGV_ARRAY_INIT;
 
 	struct option options[] = {
 		OPT_END()
@@ -1536,16 +1523,16 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
+	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
 	index_file = get_index_file();
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (argc < 1)
-		usage_with_options(git_stash_helper_usage, options);
-	if (!strcmp(argv[0], "apply"))
+	if (!argc)
+		return !!push_stash(0, NULL, prefix);
+	else if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "clear"))
 		return !!clear_stash(argc, argv, prefix);
@@ -1567,7 +1554,42 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!push_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
+	else if (*argv[0] != '-')
+		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
+			      git_stash_usage, options);
+
+	if (strcmp(argv[0], "-p")) {
+		while (++i < argc && strcmp(argv[i], "--")) {
+			/*
+			 * `akpqu` is a string which contains all short options,
+			 * except `-m` which is verified separately.
+			 */
+			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
+			    strchr("akpqu", argv[i][1]))
+				continue;
+
+			if (!strcmp(argv[i], "--all") ||
+			    !strcmp(argv[i], "--keep-index") ||
+			    !strcmp(argv[i], "--no-keep-index") ||
+			    !strcmp(argv[i], "--patch") ||
+			    !strcmp(argv[i], "--quiet") ||
+			    !strcmp(argv[i], "--include-untracked"))
+				continue;
+
+			/*
+			 * `-m` and `--message=` are verified separately because
+			 * they need to be immediately followed by a string
+			 * (i.e.`-m"foobar"` or `--message="foobar"`).
+			 */
+			if (starts_with(argv[i], "-m") ||
+			    starts_with(argv[i], "--message="))
+				continue;
+
+			usage_with_options(git_stash_usage, options);
+		}
+	}
 
-	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
-		      git_stash_helper_usage, options);
+	argv_array_push(&args, "push");
+	argv_array_pushv(&args, argv);
+	return !!push_stash(args.argc, args.argv, prefix);
 }
diff --git a/git-stash.sh b/git-stash.sh
deleted file mode 100755
index 695f1feba3..0000000000
--- a/git-stash.sh
+++ /dev/null
@@ -1,153 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2007, Nanako Shiraishi
-
-dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="list [<options>]
-   or: $dashless show [<stash>]
-   or: $dashless drop [-q|--quiet] [<stash>]
-   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-   or: $dashless branch <branchname> [<stash>]
-   or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		      [-u|--include-untracked] [-a|--all] [<message>]
-   or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		       [-u|--include-untracked] [-a|--all] [-m <message>]
-		       [-- <pathspec>...]]
-   or: $dashless clear"
-
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
-START_DIR=$(pwd)
-. git-sh-setup
-require_work_tree
-prefix=$(git rev-parse --show-prefix) || exit 1
-cd_to_toplevel
-
-TMP="$GIT_DIR/.git-stash.$$"
-TMPindex=${GIT_INDEX_FILE-"$(git rev-parse --git-path index)"}.stash.$$
-trap 'rm -f "$TMP-"* "$TMPindex"' 0
-
-ref_stash=refs/stash
-
-if git config --get-colorbool color.interactive; then
-       help_color="$(git config --get-color color.interactive.help 'red bold')"
-       reset_color="$(git config --get-color '' reset)"
-else
-       help_color=
-       reset_color=
-fi
-
-#
-# Parses the remaining options looking for flags and
-# at most one revision defaulting to ${ref_stash}@{0}
-# if none found.
-#
-# Derives related tree and commit objects from the
-# revision, if one is found.
-#
-# stash records the work tree, and is a merge between the
-# base commit (first parent) and the index tree (second parent).
-#
-#   REV is set to the symbolic version of the specified stash-like commit
-#   IS_STASH_LIKE is non-blank if ${REV} looks like a stash
-#   IS_STASH_REF is non-blank if the ${REV} looks like a stash ref
-#   s is set to the SHA1 of the stash commit
-#   w_commit is set to the commit containing the working tree
-#   b_commit is set to the base commit
-#   i_commit is set to the commit containing the index tree
-#   u_commit is set to the commit containing the untracked files tree
-#   w_tree is set to the working tree
-#   b_tree is set to the base tree
-#   i_tree is set to the index tree
-#   u_tree is set to the untracked files tree
-#
-#   GIT_QUIET is set to t if -q is specified
-#   INDEX_OPTION is set to --index if --index is specified.
-#   FLAGS is set to the remaining flags (if allowed)
-#
-# dies if:
-#   * too many revisions specified
-#   * no revision is specified and there is no stash stack
-#   * a revision is specified which cannot be resolve to a SHA1
-#   * a non-existent stash reference is specified
-#   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
-#
-
-test "$1" = "-p" && set "push" "$@"
-
-PARSE_CACHE='--not-parsed'
-# The default command is "push" if nothing but options are given
-seen_non_option=
-for opt
-do
-	case "$opt" in
-	--) break ;;
-	-*) ;;
-	*) seen_non_option=t; break ;;
-	esac
-done
-
-test -n "$seen_non_option" || set "push" "$@"
-
-# Main command set
-case "$1" in
-list)
-	shift
-	git stash--helper list "$@"
-	;;
-show)
-	shift
-	git stash--helper show "$@"
-	;;
-save)
-	shift
-	cd "$START_DIR"
-	git stash--helper save "$@"
-	;;
-push)
-	shift
-	cd "$START_DIR"
-	git stash--helper push "$@"
-	;;
-apply)
-	shift
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	;;
-clear)
-	shift
-	git stash--helper clear "$@"
-	;;
-create)
-	shift
-	git stash--helper create --message "$*"
-	;;
-store)
-	shift
-	git stash--helper store "$@"
-	;;
-drop)
-	shift
-	git stash--helper drop "$@"
-	;;
-pop)
-	shift
-	cd "$START_DIR"
-	git stash--helper pop "$@"
-	;;
-branch)
-	shift
-	cd "$START_DIR"
-	git stash--helper branch "$@"
-	;;
-*)
-	case $# in
-	0)
-		cd "$START_DIR"
-		git stash--helper push &&
-		say "$(gettext "(To restore them type \"git stash apply\")")"
-		;;
-	*)
-		usage
-	esac
-	;;
-esac
diff --git a/git.c b/git.c
index 76ee02802e..49ab91b4ec 100644
--- a/git.c
+++ b/git.c
@@ -554,7 +554,7 @@ static struct cmd_struct commands[] = {
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
-- 
2.21.0.rc2.291.g17236886c5

