Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529DB1FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 20:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754509AbdBEU0h (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 15:26:37 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32804 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdBEU0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 15:26:35 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so17857129wmv.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=30cd/i6R1l3cqB1poN3kybkmo7hsZuDr/1MBE5U52BY=;
        b=amc9SyF1zWUIOuSgl37fcEvICOb4bsxcCGwcYdNAMnY1oYJDVbwyU1zR/5dZ5aWSPf
         McMo33nm2wWfiGol5Eth3nfo6i6Ft6YlSjoptn2PQun0nR2YwYufhE2TD2kZ7v1Oba0F
         jsK4vOUAWvhEYSqcAJ/zEVEdh0IaM+ntLMAe0PntupKUxJ0I6yQAcGav8rlFzK9cqtGd
         LyTTZ9X2Sl0/lJu4B0/1HcrGdJOn/RpfaXZSvTcLi9aN2AYiX6ZMLzzs27MW9W7tPrng
         WgUzWX/QtpE/nwuzdfFB4zkIKqkRT51ufDxq71Nbu+A8c0yMk/Sb0TzyDMh+Joq6hXhb
         U7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=30cd/i6R1l3cqB1poN3kybkmo7hsZuDr/1MBE5U52BY=;
        b=aYK/A0Dw+RAXtrqEcb4JMp3VoVRszioVZIkRJ62cIX5rHOdxJl+TOe0NLgj1Ty+fuX
         lSrPoHUW0zpDPhXcpA+1+FXli552UKXTny9neJ5GWgGzftakRYvDXgWwT08/CsLwxBRH
         kg1iKZ8iYbVjXaZbbvI0LceS5Ufq9P0JNXFfV4FQs5fZ7oeKaOI82DUk0HiBDd/MKJvF
         AtmiN9CeT20d4YNU0nrFxBDJ4i2RD7+h4qS1OKa2zKQNJGVaOakx6Xjp3vZLbqAnJEix
         GANWzfTabgvFR7cSFp0BzH/fbokJYD6Ntonh/zwYlE1glTA0rb02KdFe2rmiJowyL/jU
         bJ3g==
X-Gm-Message-State: AMke39mo/teFLUaQ1C7H0XnHymNv3W5tGpqfmq7jbBWyx9P+OJmTrHkifRrDRJBE6ZIXLg==
X-Received: by 10.28.221.7 with SMTP id u7mr5621284wmg.33.1486326383736;
        Sun, 05 Feb 2017 12:26:23 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id h75sm56482313wrh.37.2017.02.05.12.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 12:26:23 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 5/5] stash: teach 'push' (and 'create') to honor pathspec
Date:   Sun,  5 Feb 2017 20:26:42 +0000
Message-Id: <20170205202642.14216-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.208.g81c5d00b20.dirty
In-Reply-To: <20170205202642.14216-1-t.gummerer@gmail.com>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
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
 Documentation/git-stash.txt        | 11 ++++++++++
 git-stash.sh                       | 30 ++++++++++++++++++++-------
 t/t3903-stash.sh                   | 42 ++++++++++++++++++++++++++++++++++++++
 t/t3905-stash-include-untracked.sh | 26 +++++++++++++++++++++++
 4 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index a138ed6a24..be55e456fa 100644
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
+	     [-- <paths>...]
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
index 33b2d0384c..46367d40aa 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -41,7 +41,7 @@ no_changes () {
 untracked_files () {
 	excl_opt=--exclude-standard
 	test "$untracked" = "all" && excl_opt=
-	git ls-files -o -z $excl_opt
+	git ls-files -o -z $excl_opt -- "$@"
 }
 
 clear_stash () {
@@ -72,6 +72,11 @@ create_stash () {
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
@@ -99,6 +104,10 @@ create_stash () {
 	if test -z "$new_style"
 	then
 		stash_msg="$*"
+		while test $# != 0
+		do
+			shift
+		done
 	fi
 
 	git update-index -q --refresh
@@ -134,7 +143,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files | (
+			untracked_files "$@" | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
@@ -157,7 +166,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
@@ -171,7 +180,7 @@ create_stash () {
 
 		# find out what the user wants
 		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- &&
+			git add--interactive --patch=stash -- "$@" &&
 
 		# state of the working tree
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
@@ -307,18 +316,25 @@ push_stash () {
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
+			git ls-files -z -- "$@" | xargs -0 git reset --
+			git ls-files -z --modified -- "$@" | xargs -0 git checkout HEAD --
+			git ls-files -z --others -- "$@" | xargs -0 git clean --force --
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
index b859e51086..461fe46045 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -811,4 +811,46 @@ test_expect_success 'new style stash create stores correct message' '
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
+	>"foo	bar" &&
+	>foo &&
+	>untracked &&
+	git add foo* &&
+	git stash push -- foo* &&
+	test_path_is_missing "foo	bar" &&
+	test_path_is_missing foo &&
+	test_path_is_file untracked &&
+	git stash pop &&
+	test_path_is_file "foo	bar" &&
+	test_path_is_file foo &&
+	test_path_is_file untracked
+'
+
 test_done
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index f372fc8ca8..9a98e31a3e 100755
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
+	>"foo	bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash push --include-untracked -- foo* &&
+	test_path_is_missing "foo	bar" &&
+	test_path_is_missing foo &&
+	test_path_is_file bar &&
+	git stash pop &&
+	test_path_is_file "foo	bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_done
-- 
2.12.0.rc0.208.g81c5d00b20.dirty

