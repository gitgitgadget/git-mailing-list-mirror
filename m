Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEE51F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 20:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbdA2UlR (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 15:41:17 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35177 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdA2UlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 15:41:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so4430801wmu.2
        for <git@vger.kernel.org>; Sun, 29 Jan 2017 12:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MuNaiEXrEicI8+EJjWzTTwV1GdNlN7hHDRPABxH2hrU=;
        b=KTmnTR61XjnnQxL38nqYh7xh/sLqzDnEKAVL/TtCbJYn1xw/kONr7ZnToGxI5xP5TE
         z51PLtV9uY9RJ3zFi4TVj7d9qo21/Ytsm3Mc6EByTdZjTijgeI4nZr49fQr7+dOPL7rm
         RzA/TMxYl4UemB0/uPxdsLFVdYxBemaBETQjbBmH4+SWFk1cCUfMkDT437WluIslHABU
         Ip68S0gx9gGNNBksrPkte1aPe29PmC6gtdU6waLuqSksS/gU76f0g0rvkofPd6svSPd1
         CNd/0l8PMw7iB+s08PwLhncPBe/mO/sDMGuUqZs1n5NG81jgeYcBk5HKi5y03dRfBvsG
         O6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MuNaiEXrEicI8+EJjWzTTwV1GdNlN7hHDRPABxH2hrU=;
        b=VACK8w5/Uy+GFfJ6J/+lcvg/ZJTOKDg6mxu2P396cnFIUE74Qu6ve71KxXeQnEq/fV
         3Yw0t6mN4yfMfzczN0SOdLt+nQP75o2+TTQxlCP6R+FryO2Lgr87Rvl0yt1G7vRLWYrn
         jaO0FwvWkTiKTj045HCke8+upY6jbDNimbWOF5gESjw3W2cj3SzS2TzSVPjv1nt/MR71
         Epz5QLib44Pxb5KC0v69zHgxzhMCWSkGeEP3saHNbgnbExz6jmimDAiig+3rmg8vdk7B
         wJooeIyjRZWlfAkVcU9ifrkWILm/nMEw5nospstR1IsA81ZidCISACAyq9inOdtqSV4J
         fS9Q==
X-Gm-Message-State: AIkVDXIp166hsG1e2JVxsr8krNZIbSCN6ND3liTJ75e+Gvbxgp7jSfTT68xG4YwJ1uedtA==
X-Received: by 10.223.147.1 with SMTP id 1mr6213862wro.60.1485720955070;
        Sun, 29 Jan 2017 12:15:55 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g71sm15276773wmc.9.2017.01.29.12.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jan 2017 12:15:54 -0800 (PST)
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
Subject: [PATCH v2 4/4] stash: support filename argument
Date:   Sun, 29 Jan 2017 20:16:04 +0000
Message-Id: <20170129201604.30445-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.297.g9a2118ac0b.dirty
In-Reply-To: <20170129201604.30445-1-t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170129201604.30445-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on a repository, it's often helpful to stash the changes
of a single or multiple files, and leave others alone.  Unfortunately
git currently offers no such option.  git stash -p can be used to work
around this, but it's often impractical when there are a lot of changes
over multiple files.

Add an optional filename argument to git stash push, which allows for
stashing a single (or multiple) files.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt |  9 +++++++++
 git-stash.sh                | 30 +++++++++++++++++++++++-------
 t/t3903-stash.sh            | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 0bce33e3fc..8306bac397 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -15,9 +15,13 @@ SYNOPSIS
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
+'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
+	     [--] [<paths>...]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
+	     [-- <paths>...]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
@@ -47,6 +51,7 @@ OPTIONS
 -------
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<paths>...]::
 
 	Save your local modifications to a new 'stash' and roll them
 	back both in the working tree and in the index.
@@ -56,6 +61,10 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 	only <message> does not trigger this action to prevent a misspelled
 	subcommand from making an unwanted stash.
 +
+If the paths argument is given in 'git stash push', only these files
+are put in the new 'stash'.  In addition only the indicated files are
+changed in the working tree to match the index.
++
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
 +
diff --git a/git-stash.sh b/git-stash.sh
index 5f08b43967..0072a38b4c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -41,7 +41,7 @@ no_changes () {
 untracked_files () {
 	excl_opt=--exclude-standard
 	test "$untracked" = "all" && excl_opt=
-	git ls-files -o -z $excl_opt
+	git ls-files -o -z $excl_opt -- $1
 }
 
 clear_stash () {
@@ -59,6 +59,7 @@ create_stash () {
 	stash_msg=
 	untracked=
 	new_style=
+	files=
 	while test $# != 0
 	do
 		case "$1" in
@@ -72,6 +73,12 @@ create_stash () {
 			untracked="$1"
 			new_style=t
 			;;
+		--)
+			shift
+			files="$@"
+			new_style=t
+			break
+			;;
 		*)
 			if test -n "$new_style"
 			then
@@ -134,7 +141,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files | (
+			untracked_files $files | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
@@ -157,7 +164,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff-index --name-only -z HEAD -- $files >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
@@ -171,7 +178,7 @@ create_stash () {
 
 		# find out what the user wants
 		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- &&
+			git add--interactive --patch=stash -- $files &&
 
 		# state of the working tree
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
@@ -293,6 +300,8 @@ push_stash () {
 		shift
 	done
 
+	files="$*"
+
 	if test -n "$patch_mode" && test -n "$untracked"
 	then
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
@@ -307,18 +316,25 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash -m "$stash_msg" -u "$untracked"
+	create_stash -m "$stash_msg" -u "$untracked" -- $files
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
 	if test -z "$patch_mode"
 	then
-		git reset --hard ${GIT_QUIET:+-q}
+		if test -n "$files"
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
+			git clean --force --quiet -d $CLEAN_X_OPTION -- $files
 		fi
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 34e9610bb6..ca4c44aa9c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -802,4 +802,46 @@ test_expect_success 'new style stash create stores correct message' '
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
-- 
2.11.0.297.g9a2118ac0b.dirty

