Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B0C20985
	for <e@80x24.org>; Tue, 13 Sep 2016 00:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbcIMAee (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:34:34 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36519 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbcIMAec (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:34:32 -0400
Received: by mail-pf0-f178.google.com with SMTP id 128so57336184pfb.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 17:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmZ6K/y530QN6IJi9AWeH7nfP1bmN9l300SGejqo59g=;
        b=g0Ym6orAVCW+lJy+8Jj4yTN7ykgA3FCP6vO+1Bxtu5BcKV06rk+9Q9eLy5gVYBoLnp
         pRcJSwTo5MvTg+ZcNnzuDWWWm3azzL6OKjiTMI4jA07Xta1DS9eJcxz2Ur4+0UpeABN9
         LWsVNhhZ20iQWh7FUeAQn90GEw46F06IwrxGWYhqpOO835IXmqVLIw6y23Eeb/nF14Wz
         +PXWap8g1qOsTJW3WjeH4//Dlito1eq0oofo+nmbGwEWr2O6164s84sibC+PO1bLikLM
         fKfLm6H94SywyuZCWHCLRRhe6HpbNFbwgNfmWrux0/HEJCEBBpmDOAfShG+wJZbyvWCX
         Tfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmZ6K/y530QN6IJi9AWeH7nfP1bmN9l300SGejqo59g=;
        b=H1ax6WcKDATm58KAhIykaWbIHLl+rjOd0rsPbpIrmWV19xfi2G87PmvTZ1fi6bvCw2
         yilN/iiwL0vbAbWfTUGmRAmBbXCUqzsNIi87yxHRL26vfT1+xhPsiguR2RHwe9Y4q4/G
         TIz+gLyFf4UKnYvhmiIqWZJSFPzdLL02o1vzPK3upMB7c6ErAyGbLnJ5rxpoShiJNBxI
         XEUxgCa8jUSFwwfRup5o6qt502SOqveLIUfM29CxdYhQsYNZPfvH3fHCwG5T24SM7zOA
         Rm6by3pmwe3jPRzf2cuj5pVjYSnErH9miYnd6PejBsIaCGlPW+7HWCRxk7p2Jp+RVrfW
         SKew==
X-Gm-Message-State: AE9vXwMSqwv4H0GxUou3rsczNHgwk2TsTe9+a7NNjPARwTeJIPSEqRq9nRD5WhN00uU8Nssk
X-Received: by 10.98.194.82 with SMTP id l79mr38533240pfg.113.1473726871723;
        Mon, 12 Sep 2016 17:34:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:dc7c:11f3:c9ea:b5e7])
        by smtp.gmail.com with ESMTPSA id p73sm15915845pfj.35.2016.09.12.17.34.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 17:34:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH v2] ls-files: adding support for submodules
Date:   Mon, 12 Sep 2016 17:33:55 -0700
Message-Id: <1473726835-143289-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1473458004-41460-1-git-send-email-bmwill@google.com>
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow ls-files to recognize submodules in order to retrieve a list of
files from a repository's submodules.  This is done by forking off a
process to recursively call ls-files on all submodules. Also added an
output-path-prefix command in order to prepend paths to child processes.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-ls-files.txt         | 11 +++-
 builtin/ls-files.c                     | 60 +++++++++++++++++++++
 t/t3007-ls-files-recurse-submodules.sh | 99 ++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100755 t/t3007-ls-files-recurse-submodules.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0d933ac..a623ebf 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -18,7 +18,9 @@ SYNOPSIS
 		[--exclude-per-directory=<file>]
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
-		[--full-name] [--abbrev] [--] [<file>...]
+		[--full-name] [--recurse-submodules]
+		[--output-path-prefix=<path>]
+		[--abbrev] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -137,6 +139,13 @@ a space) at the start of each line:
 	option forces paths to be output relative to the project
 	top directory.
 
+--recurse-submodules::
+	Recursively calls ls-files on each submodule in the repository.
+	Currently there is only support for the --cached mode.
+
+--output-path-prefix=<path>::
+	Prepend the provided path to the output of each file
+
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	lines, show only a partial prefix.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 00ea91a..c0bce00 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "pathspec.h"
+#include "run-command.h"
 
 static int abbrev;
 static int show_deleted;
@@ -28,6 +29,8 @@ static int show_valid_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
+static const char *output_path_prefix = "";
+static int recurse_submodules;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -68,6 +71,21 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
 static void write_name(const char *name)
 {
 	/*
+	 * NEEDSWORK: To make this thread-safe, full_name would have to be owned
+	 * by the caller.
+	 *
+	 * full_name get reused across output lines to minimize the allocation
+	 * churn.
+	 */
+	static struct strbuf full_name = STRBUF_INIT;
+	if (output_path_prefix != '\0') {
+		strbuf_reset(&full_name);
+		strbuf_addstr(&full_name, output_path_prefix);
+		strbuf_addstr(&full_name, name);
+		name = full_name.buf;
+	}
+
+	/*
 	 * With "--full-name", prefix_len=0; this caller needs to pass
 	 * an empty string in that case (a NULL is good for "").
 	 */
@@ -152,6 +170,25 @@ static void show_killed_files(struct dir_struct *dir)
 	}
 }
 
+/**
+ * Recursively call ls-files on a submodule
+ */
+static void show_gitlink(const struct cache_entry *ce)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int status;
+
+	argv_array_push(&cp.args, "ls-files");
+	argv_array_push(&cp.args, "--recurse-submodules");
+	argv_array_pushf(&cp.args, "--output-path-prefix=%s%s/",
+			 output_path_prefix, ce->name);
+	cp.git_cmd = 1;
+	cp.dir = ce->name;
+	status = run_command(&cp);
+	if (status)
+		exit(status);
+}
+
 static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 {
 	int len = max_prefix_len;
@@ -163,6 +200,10 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 			    len, ps_matched,
 			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
 		return;
+	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
+		show_gitlink(ce);
+		return;
+	}
 
 	if (tag && *tag && show_valid_bit &&
 	    (ce->ce_flags & CE_VALID)) {
@@ -468,6 +509,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
 			N_("make the output relative to the project top directory"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
+		OPT_STRING(0, "output-path-prefix", &output_path_prefix,
+			N_("path"), N_("prepend <path> to each file")),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			N_("recurse through submodules")),
 		OPT_BOOL(0, "error-unmatch", &error_unmatch,
 			N_("if any <file> is not in the index, treat this as an error")),
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
@@ -519,6 +564,21 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
+	if (recurse_submodules &&
+	    (show_stage || show_deleted || show_others || show_unmerged ||
+	     show_killed || show_modified || show_resolve_undo ||
+	     show_valid_bit || show_tag || show_eol))
+		die("ls-files --recurse-submodules can only be used in "
+		    "--cached mode");
+
+	if (recurse_submodules && error_unmatch)
+		die("ls-files --recurse-submodules does not support "
+		    "--error-unmatch");
+
+	if (recurse_submodules && argc)
+		die("ls-files --recurse-submodules does not support path "
+		    "arguments");
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
new file mode 100755
index 0000000..caf3815
--- /dev/null
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -0,0 +1,99 @@
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
+	git init submodule &&
+	echo c >submodule/c &&
+	git -C submodule add c &&
+	git -C submodule commit -m "add c" &&
+	git submodule add ./submodule &&
+	git commit -m "added submodule"
+'
+
+test_expect_success 'ls-files correctly outputs files in submodule' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files does not output files not added to a repo' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	echo a >not_added &&
+	echo b >b/not_added &&
+	echo c >submodule/not_added &&
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-files recurses more than 1 level' '
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/.gitmodules
+	submodule/c
+	submodule/subsub/d
+	EOF
+
+	git init submodule/subsub &&
+	echo d >submodule/subsub/d &&
+	git -C submodule/subsub add d &&
+	git -C submodule/subsub commit -m "add d" &&
+	git -C submodule submodule add ./subsub &&
+	git -C submodule commit -m "added subsub" &&
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--recurse-submodules does not support using path arguments' '
+	test_must_fail git ls-files --recurse-submodules b 2>actual &&
+	test_i18ngrep "does not support path arguments" actual
+'
+
+test_expect_success '--recurse-submodules does not support --error-unmatch' '
+	test_must_fail git ls-files --recurse-submodules --error-unmatch 2>actual &&
+	test_i18ngrep "does not support --error-unmatch" actual
+'
+
+test_incompatible_with_recurse_submodules () {
+	test_expect_success "--recurse-submodules and $1 are incompatible" "
+		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
+		test_i18ngrep 'can only be used in --cached mode' actual
+	"
+}
+
+test_incompatible_with_recurse_submodules -v
+test_incompatible_with_recurse_submodules -t
+test_incompatible_with_recurse_submodules --deleted
+test_incompatible_with_recurse_submodules --modified
+test_incompatible_with_recurse_submodules --others
+test_incompatible_with_recurse_submodules --stage
+test_incompatible_with_recurse_submodules --killed
+test_incompatible_with_recurse_submodules --unmerged
+test_incompatible_with_recurse_submodules --eol
+
+test_done
-- 
2.8.0.rc3.226.g39d4020

