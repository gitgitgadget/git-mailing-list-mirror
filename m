Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041A1201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbdBYU3b (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:29:31 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35428 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbdBYU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:28:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so7804438wmu.2
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VuWIffM9LCL4J/mKRO4ydztLZojcpZaoH2g51//RSQw=;
        b=miqb56YQ17m+5aXG7psO3xfjNWrto7g1CanDsdboWIbWLQyHeb60f6pyxHIUTzS3Kt
         G3h5Az3keQb0hGsHTM8z9j4HlT3Z4lX6eaPiSjgJTYrZoYLN6flP3LG1i0j9oUsD8srQ
         7LGjDThVDse9alLTT4h43DqJ4ReeHPvWezzzOMrnguYXwNtYQe8tlc8YOa7EAt+FTeG4
         yABy6UhAK+hno3uieuBvRZZQj/ObbuiH8v77hX+I006cHURCYsF7S1ZwHhTBBc65Abp0
         HK7dcLGxCIcC3AsYaZm2pSsXOHQUYe1SaRIuQQ3jsbmBFVCny20c/9cLL5Y6gbby8NuX
         UjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VuWIffM9LCL4J/mKRO4ydztLZojcpZaoH2g51//RSQw=;
        b=pJVKbP3yjPBCQYOF+Vv8AkWeZAaFUQqUXi/E08i1OMRn107t3K1LBQLef7gH6c4Lg5
         z+rcL+1LJEBQZ3XvdIER5bNLA0BDrBV4g8PEBjbULptGzQYfEC8IiQwRFX2NbZIxKK6r
         2eT8uD0u0oXu8nRGu4jRRvHEFYSevrFsL2K6yGw0h/nHJppqa6H1VZGvGzsIp5iVFFSK
         CasK54UxSaksmSduVpiQUbjnB3UvT+WV9+A8UOsor+axpdO5Vg2u6zI8ndgzF/TJMA0V
         cJRdiTpt9/r7S7flNAu7qrPaQzj6IMHC3QZag1zhh+v/yvg+26h1phA7AjdYhpw43f32
         hzGw==
X-Gm-Message-State: AMke39lUP7MbkYxwtgGH40o97uyiy3GxBINBotiahtLKpT09k8wMktk/cYF8a4cZR8NIVg==
X-Received: by 10.28.158.82 with SMTP id h79mr7929781wme.30.1488054453510;
        Sat, 25 Feb 2017 12:27:33 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id x193sm2741192wme.23.2017.02.25.12.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 12:27:32 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
Date:   Sat, 25 Feb 2017 21:33:04 +0000
Message-Id: <20170225213306.2410-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g275aeb250c.dirty
In-Reply-To: <20170225213306.2410-1-t.gummerer@gmail.com>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170225213306.2410-1-t.gummerer@gmail.com>
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
 Documentation/git-stash.txt        |  9 ++++-
 git-stash.sh                       | 37 +++++++++++++------
 t/t3903-stash.sh                   | 76 ++++++++++++++++++++++++++++++++++++++
 t/t3905-stash-include-untracked.sh | 26 +++++++++++++
 4 files changed, 136 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index d240df4af7..88369ed8b6 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
+	     [--] [<pathspec>...]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
@@ -48,7 +49,7 @@ OPTIONS
 -------
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
-push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash' and roll them
 	back to HEAD (in the working tree and in the index).
@@ -58,6 +59,12 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
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
index ef5d1b45be..57828f926d 100755
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
@@ -71,12 +72,16 @@ create_stash () {
 			shift
 			untracked=${1?"BUG: create_stash () -u requires an argument"}
 			;;
+		--)
+			shift
+			break
+			;;
 		esac
 		shift
 	done
 
 	git update-index -q --refresh
-	if no_changes
+	if no_changes "$@"
 	then
 		exit 0
 	fi
@@ -108,7 +113,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files | (
+			untracked_files "$@" | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
@@ -131,7 +136,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
@@ -145,7 +150,7 @@ create_stash () {
 
 		# find out what the user wants
 		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- &&
+			git add--interactive --patch=stash -- "$@" &&
 
 		# state of the working tree
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
@@ -273,27 +278,37 @@ push_stash () {
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
 	fi
 
+	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
+
 	git update-index -q --refresh
-	if no_changes
+	if no_changes "$@"
 	then
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
+
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
+			git reset ${GIT_QUIET:+-q} -- "$@"
+			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")
+			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
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
index ffe3549ea5..4d8a096773 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -802,4 +802,80 @@ test_expect_success 'create with multiple arguments for the message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stash -- <pathspec> stashes and restores the file' '
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
+test_expect_success 'stash with multiple pathspec arguments' '
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
+test_expect_success 'stash push -p with pathspec shows no changes only once' '
+	>foo &&
+	git add foo &&
+	git commit -m "tmp" &&
+	git stash push -p foo >actual &&
+	echo "No local changes to save" >expect &&
+	git reset --hard HEAD~ &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash push with pathspec shows no changes when there are none' '
+	>foo &&
+	git add foo &&
+	git commit -m "tmp" &&
+	git stash push foo >actual &&
+	echo "No local changes to save" >expect &&
+	git reset --hard HEAD~ &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stash push with pathspec not in the repository errors out' '
+	>untracked &&
+	test_must_fail git stash push untracked &&
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
2.11.0.301.g275aeb250c.dirty

