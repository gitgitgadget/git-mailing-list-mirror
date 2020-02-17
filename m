Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFEBC34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D28D208C4
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E22UQxOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgBQRZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:25:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgBQRZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:25:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so20685321wrs.12
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XPx4ASDYR2fnaQiWxe0tNHGusrRUUIG4Ac3NwH2Bvsg=;
        b=E22UQxOcrStBddJQdey2kZc4GHCje9MA4ZYi4ZdqDuOUFJjzNH08awjUiM/N7G+FGK
         G/lbNKw30yJ+DyCPVGmfnTrc3awRugdL1xNE1FcejDogX2nBZiUNCVrPN3BudAocgXRZ
         LRBiDxTtp3mB5Hkj0eIpzTX/2nhIccmwUIi5kbBmU+79jTBMft1Ml7GR8CsDJ2aYLCJ8
         /O9nZumMUHoWLknn7wT/RhtSmaBlztc+6xOxGanB1cl0y5oQqlBmvQzf8s/w+n1gWcyI
         5rP3UHGheRgH0hc1EtaqrM+PjlKWWP59NxewOc407cQOQbbXPEDfAxt0b+lOl+/0dO/q
         JJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XPx4ASDYR2fnaQiWxe0tNHGusrRUUIG4Ac3NwH2Bvsg=;
        b=ZPysn4AxOG/wRMMvfCxqpsFhE1M99Z0/mbH8z11NseqL0V9StKKrcjatvZLrp1XIzV
         ennU1ySUmwqUjuu3Wan79rvBatPwFLVSaUTAAOz2TWqoTCjzlwTXGHoqTXZw37QVxep/
         4Slxrk1Wmjjl3Xn82rL60pULBrCdvYWHMLrZUQxOUtwpBFCWqDweRexwSq5fVSrdSW90
         vok+vQ9lcepAz7dHHd6cJE1ROJBs1eZgL7r1IGLgFw5T3hpm1d+nIlzgmLVLWRw0t1Xg
         a4CLxNOzNXKoRj+FPsaoHzXbgBF8C3P39IxU9+GGpaD0tj+fzGFzQLgYsBw6E7lB0eG9
         I/lQ==
X-Gm-Message-State: APjAAAXgQWIyDWojJKOcYO+5k/Dd/ysrtXT3WUxdLpYyp7fMc5Jd73T/
        lCCOpcxdnoYR4HdV5ui2sTIBEE7T
X-Google-Smtp-Source: APXvYqwlr7p9RIRrlqtnqTnFKQofgB0aJBu8165bWSxr8H+Wk1vR7xTo1YV/2nghKgMepANriVxPPQ==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr23126066wru.173.1581960324943;
        Mon, 17 Feb 2020 09:25:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm2004023wrp.9.2020.02.17.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:25:24 -0800 (PST)
Message-Id: <7c657dea89e900a023af1130545f6c3341841840.1581960322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
References: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:25:16 +0000
Subject: [PATCH v3 2/8] rm: support the --pathspec-from-file option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Decisions taken for simplicity:
1) It is not allowed to pass pathspec in both args and file.

Adjustments were needed for `if (!argc)` block:

This code actually means "pathspec is not present". Previously, pathspec
could only come from commandline arguments, so testing for `argc` was a
valid way of testing for the presence of pathspec. But this is no longer
true with `--pathspec-from-file`.

During the entire `--pathspec-from-file` story, I tried to keep its
behavior very close to giving pathspec on commandline, so that switching
from one to another doesn't involve any surprises.

However, throwing usage at user in the case of empty
`--pathspec-from-file` would puzzle because there's nothing wrong with
"usage" (that is, argc/argv array).

On the other hand, throwing usage in the old case also feels bad to me.
While it's less of a puzzle, I (as user) never liked the experience of
comparing my commandline to "usage", trying to spot a difference. Since
it's already known what the error is, it feels a lot better to give that
specific error to user.

Judging from [1] it doesn't seem that showing usage in this case was
important (the patch was to avoid segfault), and it doesn't fit into how
other commands react to empty pathspec (see for example `git add` with a
custom message).

Therefore, I decided to show new error text in both cases. In order to
continue testing for error early, I moved `parse_pathspec()` higher. Now
it happens before `read_cache()` / `hold_locked_index()` /
`setup_work_tree()`, which shouldn't cause any issues.

[1] Commit 7612a1ef ("git-rm: honor -n flag" 2006-06-09)

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-rm.txt    | 17 +++++++-
 builtin/rm.c                | 28 ++++++++++---
 t/t3601-rm-pathspec-file.sh | 79 +++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 7 deletions(-)
 create mode 100755 t/t3601-rm-pathspec-file.sh

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index e02a08e5efd..ab750367fde 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,9 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <pathspec>...
+'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
+	  [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	  [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -73,6 +75,19 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 	`git rm` normally outputs one line (in the form of an `rm` command)
 	for each file removed. This option suppresses that output.
 
+--pathspec-from-file=<file>::
+	Pathspec is passed in `<file>` instead of commandline args. If
+	`<file>` is exactly `-` then standard input is used. Pathspec
+	elements are separated by LF or CR/LF. Pathspec elements can be
+	quoted as explained for the configuration variable `core.quotePath`
+	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
+	global `--literal-pathspecs`.
+
+--pathspec-file-nul::
+	Only meaningful with `--pathspec-from-file`. Pathspec elements are
+	separated with NUL character and all other characters are taken
+	literally (including newlines and quotes).
+
 
 REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
 --------------------------------------------------------
diff --git a/builtin/rm.c b/builtin/rm.c
index 19ce95a901b..4858631e0f0 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -235,7 +235,8 @@ static int check_local_mod(struct object_id *head, int index_only)
 }
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
-static int ignore_unmatch = 0;
+static int ignore_unmatch = 0, pathspec_file_nul;
+static char *pathspec_from_file;
 
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -245,6 +246,8 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
+	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
 };
 
@@ -259,8 +262,24 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
 			     builtin_rm_usage, 0);
-	if (!argc)
-		usage_with_options(builtin_rm_usage, builtin_rm_options);
+
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD,
+		       prefix, argv);
+
+	if (pathspec_from_file) {
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&pathspec, 0,
+				    PATHSPEC_PREFER_CWD,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
+	if (!pathspec.nr)
+		die(_("No pathspec was given. Which files should I remove?"));
 
 	if (!index_only)
 		setup_work_tree();
@@ -270,9 +289,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD,
-		       prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL, NULL);
 
 	seen = xcalloc(pathspec.nr, 1);
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
new file mode 100755
index 00000000000..7de21f8bcff
--- /dev/null
+++ b/t/t3601-rm-pathspec-file.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='rm --pathspec-from-file'
+
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success setup '
+	echo A >fileA.t &&
+	echo B >fileB.t &&
+	echo C >fileC.t &&
+	echo D >fileD.t &&
+	git add fileA.t fileB.t fileC.t fileD.t &&
+	git commit -m "files" &&
+
+	git tag checkpoint
+'
+
+restore_checkpoint () {
+	git reset --hard checkpoint
+}
+
+verify_expect () {
+	git status --porcelain --untracked-files=no -- fileA.t fileB.t fileC.t fileD.t >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'simplest' '
+	restore_checkpoint &&
+
+	cat >expect <<-\EOF &&
+	D  fileA.t
+	EOF
+
+	echo fileA.t | git rm --pathspec-from-file=- &&
+	verify_expect
+'
+
+test_expect_success '--pathspec-file-nul' '
+	restore_checkpoint &&
+
+	cat >expect <<-\EOF &&
+	D  fileA.t
+	D  fileB.t
+	EOF
+
+	printf "fileA.t\0fileB.t\0" | git rm --pathspec-from-file=- --pathspec-file-nul &&
+	verify_expect
+'
+
+test_expect_success 'only touches what was listed' '
+	restore_checkpoint &&
+
+	cat >expect <<-\EOF &&
+	D  fileB.t
+	D  fileC.t
+	EOF
+
+	printf "fileB.t\nfileC.t\n" | git rm --pathspec-from-file=- &&
+	verify_expect
+'
+
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+
+	test_must_fail git rm --pathspec-from-file=list -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git rm --pathspec-file-nul 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+
+	>empty_list &&
+	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
+	test_i18ngrep -e "No pathspec was given. Which files should I remove?" err
+'
+
+test_done
-- 
gitgitgadget

