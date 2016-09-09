Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A1141F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 21:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754927AbcIIVy1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 17:54:27 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34478 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754746AbcIIVy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 17:54:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id p64so33239780pfb.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=S5RgRhkp2DwEw68ii/o8jEylo0ZRYRWLWZxZoYlqItc=;
        b=OSVdGxYqk+4qsOA4PSrFHPfeG/iOkQHV97gC8C0k4VzH3xT0jUN7SSvmm504FWT71/
         NvRWDjwjCO1gROToNOFm4UQxfNEDxAr57G8NpvvAdqM/i1uiOYRd+hHVT917lIFRcRhj
         xJ+3Y1eZS+T5uMT0mdfTn50Aalyz4Rwi1tSCFEqw7aGm66vEtgBvGVLqrI2jT/Gf/HaY
         eeJNmh+hziyJAKKFi1iX/PERFX1DSIT6QHBtgO6b5v79jgq28sPOPlYpuPi/Myc8YgAl
         ELovi98MJcsVXzEzbMPNoIFmlnI3qTei5baKU5iQdLRsdxPiMg/K2jbFUHpiNtr1p4UK
         Dd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S5RgRhkp2DwEw68ii/o8jEylo0ZRYRWLWZxZoYlqItc=;
        b=mojGhxuVPTXDGjH9Wvudxt4vXQCgw+O33QfJwN6AaqpiSmctfCNGKkQtGBMN6SJKLD
         Cb4tA2lirU08dvXskLrvnLw7n8kYTwpnDkgyWks37gPLNiLuV1rEj5y+PuqaKBtvDS+L
         zrIBB/k64iJ9ryxuvsX8AA7lZamSEHb1x7Xej8QWXfD3XBVaGaMeHjMmtCCsDTEFuJ4a
         moM5MvjYAuZp0HpM8ktNgK8qrSfr9guoXtqFQEHGYN91yFRmwyclX73lMlzgRCtQmoWU
         hkz4gAluLQEg5z+iMWsUCSKBJ1T0rc/ym0cj4N2Ton+/BUTAtODd0S+UicU/iZ9MN5VT
         a37Q==
X-Gm-Message-State: AE9vXwPdFPOMVddRFLlPMzjF80MKY1byAPUH0e3uD+O+cy+QjkIxHjN5pDx1ZPvMjOxRchdt
X-Received: by 10.98.89.91 with SMTP id n88mr10270667pfb.119.1473458065655;
        Fri, 09 Sep 2016 14:54:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4449:1c2f:1897:e2e4])
        by smtp.gmail.com with ESMTPSA id f16sm3337830pfd.84.2016.09.09.14.54.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 14:54:24 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [RFC/PATCH] ls-files: adding support for submodules
Date:   Fri,  9 Sep 2016 14:53:24 -0700
Message-Id: <1473458004-41460-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow ls-files to recognize submodules in order to retrieve a list of
files from a repository's submodules.  This is done by forking off a
process to recursively call ls-files on all submodules.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
Hey git developers!

I'm new to the community and this is the first patch for an open source project
that I have worked on.

I'm looking forward to working on the project!
Brandon Williams

 Documentation/git-ls-files.txt         |   7 ++-
 builtin/ls-files.c                     |  58 +++++++++++++++++++
 t/t3007-ls-files-recurse-submodules.sh | 103 +++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 t/t3007-ls-files-recurse-submodules.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0d933ac..446209e 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -18,7 +18,8 @@ SYNOPSIS
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
-		[--full-name] [--abbrev] [--] [<file>...]
+		[--full-name] [--recurse-submodules]
+		[--abbrev] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -137,6 +138,10 @@ a space) at the start of each line:
 	option forces paths to be output relative to the project
 	top directory.
 
+--recurse-submodules::
+	Recursively calls ls-files on each submodule in the repository.
+	Currently there is only support for the --cached mode.
+
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show only a partial prefix.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 00ea91a..c428a51 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "pathspec.h"
+#include "run-command.h"
 
 static int abbrev;
 static int show_deleted;
@@ -28,6 +29,7 @@ static int show_valid_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
+static int recurse_submodules;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -152,6 +154,45 @@ static void show_killed_files(struct dir_struct *dir)
 	}
 }
 
+/**
+ *  Recursively call ls-files on a submodule
+ */
+static void show_gitlink(const struct cache_entry *ce)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf name = STRBUF_INIT;
+	int submodule_name_len;
+	FILE *fp;
+
+	argv_array_push(&cp.args, "ls-files");
+	argv_array_push(&cp.args, "--recurse-submodules");
+	cp.git_cmd = 1;
+	cp.dir = ce->name;
+	cp.out = -1;
+	start_command(&cp);
+	fp = fdopen(cp.out, "r");
+
+	/*
+	 * The ls-files child process produces filenames relative to
+	 * the submodule. Prefix each line with the submodule path
+	 * to make it relative to the current repository.
+	 */
+	strbuf_addstr(&name, ce->name);
+	strbuf_addch(&name, '/');
+	submodule_name_len = name.len;
+	while (strbuf_getline(&buf, fp) != EOF) {
+		strbuf_addbuf(&name, &buf);
+		write_name(name.buf);
+		strbuf_setlen(&name, submodule_name_len);
+	}
+
+	finish_command(&cp);
+	strbuf_release(&buf);
+	strbuf_release(&name);
+	fclose(fp);
+}
+
 static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 {
 	int len = max_prefix_len;
@@ -163,6 +204,10 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 			    len, ps_matched,
 			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
 		return;
+	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
+		show_gitlink(ce);
+		return;
+	}
 
 	if (tag && *tag && show_valid_bit &&
 	    (ce->ce_flags & CE_VALID)) {
@@ -468,6 +513,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
 			N_("make the output relative to the project top directory"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			N_("recurse through submodules")),
 		OPT_BOOL(0, "error-unmatch", &error_unmatch,
 			N_("if any <file> is not in the index, treat this as an error")),
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
@@ -519,6 +566,17 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
+	if (recurse_submodules &&
+	    (show_stage || show_deleted || show_others || show_unmerged ||
+	     show_killed || show_modified || show_resolve_undo ||
+	     show_valid_bit || show_tag || show_eol))
+		die("ls-files --recurse-submodules can only be used in "
+		    "--cached mode");
+
+	if (recurse_submodules && argc)
+		die("ls-files --recurse-submodules does not support path "
+		    "arguments");
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
new file mode 100644
index 0000000..78deded
--- /dev/null
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='Test ls-files recurse-submodules feature
+
+This test verifies the recurse-submodules feature correctly lists files from
+submodules.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup directory structure and submodules' '
+	echo a >a &&
+	mkdir b &&
+	echo b >b/b &&
+	git add a b &&
+	git commit -m "add a and b" &&
+	mkdir submodule &&
+	(
+		cd submodule &&
+		git init &&
+		echo c >c &&
+		git add c &&
+		git commit -m "add c"
+	) &&
+	git submodule add ./submodule &&
+	git commit -m "added submodule"
+'
+
+cat >expect <<EOF
+.gitmodules
+a
+b/b
+submodule/c
+EOF
+
+test_expect_success 'ls-files correctly outputs files in submodule' '
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files does not output files not added to a repo' '
+	echo a >not_added &&
+	echo b >b/not_added &&
+	(
+		cd submodule &&
+		echo c >not_added
+	) &&
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
+.gitmodules
+a
+b/b
+submodule/.gitmodules
+submodule/c
+submodule/subsub/d
+EOF
+
+test_expect_success 'ls-files recurses more than 1 level' '
+	(
+		cd submodule &&
+		mkdir subsub &&
+		(
+			cd subsub &&
+			git init &&
+			echo d >d &&
+			git add d &&
+			git commit -m "add d"
+		) &&
+		git submodule add ./subsub &&
+		git commit -m "added subsub"
+	) &&
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+cat >expect_error <<EOF
+fatal: ls-files --recurse-submodules does not support path arguments
+EOF
+
+test_expect_success 'error when using path arguments' '
+	test_must_fail git ls-files --recurse-submodules b 2>actual &&
+	test_cmp expect_error actual
+'
+
+cat >expect_error <<EOF
+fatal: ls-files --recurse-submodules can only be used in --cached mode
+EOF
+
+test_expect_success 'error when using different modes' '
+	for opt in {v,t}; do
+		test_must_fail git ls-files --recurse-submodules -$opt 2>actual &&
+		test_cmp expect_error actual
+	done &&
+	for opt in {deleted,modified,others,ignored,stage,killed,unmerged,eol}; do
+		test_must_fail git ls-files --recurse-submodules --$opt 2>actual &&
+		test_cmp expect_error actual
+	done
+'
+
+test_done
-- 
2.8.0.rc3.226.g39d4020

