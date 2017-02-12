Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421521FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdBLVyb (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:54:31 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36464 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdBLVy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:54:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so16248157wmd.3
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iCboGuGBT4UJBCkdjG0yat1lPhvhCrxZX5eUlQKpLdA=;
        b=gAaHC0iGwndzo+ljHhr6LWHtYlQadpQX2M063aI8b2SRsuWq28wbwKVembbnN01j1b
         P5ed03GBi1hGpmoikzwOoxWa1To4dp3Y+oJ3gndDW6qlh6bO+5R/zR5lrtPM0uTewCAM
         xUIkN8sCOSQV2yEQMp39BwJRYhA6Uic6FBqmGwlwO1IVjh4zhUGkUm3gTp/ytBq/4EWS
         Czi+SkY8BPD+yBJF8Fbc7Z5yvaj2Pcm6ryf4S+7sQX8NWjiuiEcQ95x8hS6N1T4UMrxU
         Q2Zqig7afErTlEKdwNeomOgjRGuuYVrbrNJcG31YMew/K24MA1mPATPc+2lwG7gsMSi5
         Ak4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iCboGuGBT4UJBCkdjG0yat1lPhvhCrxZX5eUlQKpLdA=;
        b=a5fFmvHtBOyWdRBy6V/jirR95vyNnjEhELFYPQgq2k+jWwzRcaJHmBhwBGcK9ZPQ9Q
         E1rv1xeQL1ThMdStiGE+QtNcZfTcgfGPBiljmGoYaUAswvUdSSkRW5nEIhlJMqDS5WdZ
         0NFWVwk3w00leYuKuEdNk0a83JNr9D9DHkx+1xpWY/nBK2Dq7XuQk4zie6ddq2fg5Eeg
         BYwFB/rXYpamMBEIv13wKvip8wlVflp/3Rim2r8Om++g6pZIkG0gjVWJ9pPhnWZxRSfL
         51JcN+4LQiycTtgOcVBbDu5EkF/xLA302/7P5//SxbNz3K4OAxF/lhMnlWlIB8nXnh9U
         xSPA==
X-Gm-Message-State: AMke39nFvNx7Kkd4RdkYxHa5dO2i9nCrcpjQIAlYSKtW7FyKFgVXdrnOgnZ1rSZvWYL4IA==
X-Received: by 10.28.224.67 with SMTP id x64mr39044908wmg.20.1486936467011;
        Sun, 12 Feb 2017 13:54:27 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g40sm11396664wrg.19.2017.02.12.13.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 13:54:26 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 5/7] stash: teach 'push' (and 'create') to honor pathspec
Date:   Sun, 12 Feb 2017 21:54:18 +0000
Message-Id: <20170212215420.16701-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g86e6ecc671.dirty
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on a repository, it's often helpful to stash the changes
of a single or multiple files, and leave others alone.  Unfortunately
git currently offers no such option.  git stash -p can be used to work
around this, but it's often impractical when there are a lot of changes
over multiple files.

Allow 'git stash push' to take pathspec to specify which paths to stash.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt        | 11 ++++++
 git-stash.sh                       | 50 ++++++++++++++++++++------
 t/t3903-stash.sh                   | 72 ++++++++++++++++++++++++++++++++++++++
 t/t3905-stash-include-untracked.sh | 26 ++++++++++++++
 4 files changed, 148 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index a138ed6a24..f462f393b0 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -15,9 +15,13 @@ SYNOPSIS
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
+'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
+	     [--] [<pathspec>...]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
+	     [-- <pathspec>...]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
@@ -47,6 +51,7 @@ OPTIONS
 -------
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash' and roll them
 	back to HEAD (in the working tree and in the index).
@@ -56,6 +61,12 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 	only <message> does not trigger this action to prevent a misspelled
 	subcommand from making an unwanted stash.
 +
+When pathspec is given to 'git stash push', the new stash records the
+modified states only for the files that match the pathspec.  The index
+entries and working tree files are then rolled back to the state in
+HEAD only for these files, too, leaving files that do not match the
+pathspec intact.
++
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
 +
diff --git a/git-stash.sh b/git-stash.sh
index 6d629fc43f..db56cf2c66 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -11,6 +11,7 @@ USAGE="list [<options>]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
    or: $dashless push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 		      [-u|--include-untracked] [-a|--all] [-m <message>]
+		      [-- <pathspec>...]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -35,15 +36,15 @@ else
 fi
 
 no_changes () {
-	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
-	git diff-files --quiet --ignore-submodules &&
+	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
+	git diff-files --quiet --ignore-submodules -- "$@" &&
 	(test -z "$untracked" || test -z "$(untracked_files)")
 }
 
 untracked_files () {
 	excl_opt=--exclude-standard
 	test "$untracked" = "all" && excl_opt=
-	git ls-files -o -z $excl_opt
+	git ls-files -o -z $excl_opt -- "$@"
 }
 
 clear_stash () {
@@ -76,6 +77,11 @@ create_stash () {
 			untracked="$1"
 			new_style=t
 			;;
+		--)
+			shift
+			new_style=t
+			break
+			;;
 		*)
 			if test -n "$new_style"
 			then
@@ -103,10 +109,11 @@ create_stash () {
 	if test -z "$new_style"
 	then
 		stash_msg="$*"
+		set --
 	fi
 
 	git update-index -q --refresh
-	if no_changes
+	if no_changes "$@"
 	then
 		exit 0
 	fi
@@ -138,7 +145,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files | (
+			untracked_files "$@" | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
@@ -161,7 +168,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
@@ -175,7 +182,7 @@ create_stash () {
 
 		# find out what the user wants
 		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- &&
+			git add--interactive --patch=stash -- "$@" &&
 
 		# state of the working tree
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
@@ -304,7 +311,7 @@ push_stash () {
 	fi
 
 	git update-index -q --refresh
-	if no_changes
+	if no_changes "$@"
 	then
 		say "$(gettext "No local changes to save")"
 		exit 0
@@ -312,18 +319,39 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash -m "$stash_msg" -u "$untracked"
+	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
 	if test -z "$patch_mode"
 	then
-		git reset --hard ${GIT_QUIET:+-q}
+		if test $# != 0
+		then
+			saved_untracked=
+			if test -n "$(git ls-files --others -- "$@")"
+			then
+				saved_untracked=$(
+					git ls-files -z --others -- "$@" |
+					    xargs -0 git stash create -u all --)
+			fi
+			git ls-files -z -- "$@" | xargs -0 git reset ${GIT_QUIET:+-q} --
+			git ls-files -z --modified -- "$@" | xargs -0 git checkout ${GIT_QUIET:+-q} HEAD --
+			if test -n "$(git ls-files -z --others -- "$@")"
+			then
+				git ls-files -z --others -- "$@" | xargs -0 git clean --force -d ${GIT_QUIET:+-q} --
+			fi
+			if test -n "$saved_untracked"
+			then
+				git stash pop -q $saved_untracked
+			fi
+		else
+			git reset --hard ${GIT_QUIET:+-q}
+		fi
 		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
 		if test -n "$untracked"
 		then
-			git clean --force --quiet -d $CLEAN_X_OPTION
+			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
 		fi
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 812d0f7a40..8b372c35fb 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -811,4 +811,76 @@ test_expect_success 'new style stash create stores correct message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stash -- <filename> stashes and restores the file' '
+	>foo &&
+	>bar &&
+	git add foo bar &&
+	git stash push -- foo &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
+test_expect_success 'stash with multiple filename arguments' '
+	>foo &&
+	>bar &&
+	>extra &&
+	git add foo bar extra &&
+	git stash push -- foo bar &&
+	test_path_is_missing bar &&
+	test_path_is_missing foo &&
+	test_path_is_file extra &&
+	git stash pop &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	test_path_is_file extra
+'
+
+test_expect_success 'stash with file including $IFS character' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash push -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
+test_expect_success 'stash push -p with pathspec shows no changes only onece' '
+	>file &&
+	git add file &&
+	git stash push -p not-file >actual &&
+	echo "No local changes to save" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash push with pathspec shows no changes when there are none' '
+	>file &&
+	git add file &&
+	git stash push not-file >actual &&
+	echo "No local changes to save" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'untracked file is not removed when using pathspecs' '
+	>untracked &&
+	git stash push untracked &&
+	test_path_is_file untracked
+'
+
+test_expect_success 'untracked files are left in place when -u is not given' '
+	>file &&
+	git add file &&
+	>untracked &&
+	git stash push file &&
+	test_path_is_file untracked
+'
+
 test_done
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index f372fc8ca8..193adc7b68 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -185,4 +185,30 @@ test_expect_success 'stash save --all is stash poppable' '
 	test -s .gitignore
 '
 
+test_expect_success 'stash push --include-untracked with pathspec' '
+	>foo &&
+	>bar &&
+	git stash push --include-untracked -- foo &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop &&
+	test_path_is_file bar &&
+	test_path_is_file foo
+'
+
+test_expect_success 'stash push with $IFS character' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash push --include-untracked -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_done
-- 
2.11.0.301.g86e6ecc671.dirty

