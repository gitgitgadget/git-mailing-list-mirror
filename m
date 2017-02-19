Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF40201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 11:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdBSLLe (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 06:11:34 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35364 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdBSLLd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 06:11:33 -0500
Received: by mail-wr0-f193.google.com with SMTP id q39so9263074wrb.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 03:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x5utnKFSfMFq7qdTpiEFtzx5oTXme3TpB+Nr7w6KTJI=;
        b=qxubllup6hxHazaulBc07SiMU44qY+CcNb+jPDEIHCE1A8YItB4RwGqLTWvmr0NAIT
         Db/6m19+Nzo+gZBJEDbsNS2VBIuBf5ulnfnUTqT1FyIgv4F1fNsXlHotHkOk3UlRKTZ/
         SMk41U0GxZJFM84/6deKThMnbfWtsotdkC1O0YVcXPtTfr4/szQCKRZg0+gK93Sx7vhJ
         N92T+Ji6WDGo9XpaVrWtKCI+txFv7ACBOr5MnzWyyVM+gM9KsiOghqSO+qZqVwblHe5z
         /SxcQjknySlvPSk8Mh+C8iwxVtFYJW44YYZFIR/wr6xgqp94mrdgVse0NEVU08DGetxX
         myxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x5utnKFSfMFq7qdTpiEFtzx5oTXme3TpB+Nr7w6KTJI=;
        b=NZDrk+VoHPj56e/vB1STBAsUO8AW2KeHOVhOhKHaXWKnX0Bj9HfcbL818m7esQZzGq
         TUSluXqysI3dihiHv4aMs24qe4vVhzo125xyEc2a98nI5T9X/ptfFzH+UwWPMX9VRjbZ
         QE1dGCxrNtJZ3DjqlWJmUweYClEHfjzgsaaPC7DYx2fLpSzUw5W9OomujkxZcPFEYu36
         1MsQ+f1h2mvcpYNoHiZJPRTKjIs17TdNirpNi4ZgLlaKvzBGiR2fPaxhsUMQ1z59KydK
         D8w9i87ZpUZM1vJwQ7REojuNk2gMx6SP1+rKb4egPUAQy4Z45A2sXVujqi7cWnq4hN91
         j06w==
X-Gm-Message-State: AMke39nOll+pVWB1lmIvuXqU3omU+kXqbhOv3pdhKo+tXmrDfUTA155VJHfPYhCc10kZ5g==
X-Received: by 10.223.165.87 with SMTP id j23mr14171802wrb.79.1487502191706;
        Sun, 19 Feb 2017 03:03:11 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id w126sm8230301wmw.0.2017.02.19.03.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 03:03:11 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
Date:   Sun, 19 Feb 2017 11:03:11 +0000
Message-Id: <20170219110313.24070-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc2.399.g0ca89a282
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
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
 git-stash.sh                       | 48 +++++++++++++++++++------
 t/t3903-stash.sh                   | 72 ++++++++++++++++++++++++++++++++++++++
 t/t3905-stash-include-untracked.sh | 26 ++++++++++++++
 4 files changed, 143 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 0f602ea0c8..b7db939a06 100644
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
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -57,6 +58,12 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
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
index ef5d1b45be..b55983d1fd 100755
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
@@ -274,7 +279,7 @@ push_stash () {
 	fi
 
 	git update-index -q --refresh
-	if no_changes
+	if no_changes "$@"
 	then
 		say "$(gettext "No local changes to save")"
 		exit 0
@@ -282,18 +287,39 @@ push_stash () {
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
index ffe3549ea5..4fb800eec8 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -802,4 +802,76 @@ test_expect_success 'create with multiple arguments for the message' '
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
2.12.0.rc2.399.g0ca89a282

