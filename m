Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250901F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 20:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750900AbdAUUIH (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 15:08:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35093 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdAUUIA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 15:08:00 -0500
Received: by mail-wm0-f65.google.com with SMTP id d140so15602478wmd.2
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 12:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2vJIPyehP45EOG7ZIwf1xA1tLydBO6ejzJwHSkMm2YU=;
        b=ig9/hu4iEwpRGcldSKzfBHVjEA0q9rPpuZJRArboO1pA5dw7Rw9UlK8jP/fEIiEmQ2
         HnyjHLWVBGj6m5FtqsUdK/TnxCT1T0qlzkToTzvglF+pg9IxwVhJSpBGPiHpsQACT6EP
         MSPY1Muvi1qfDmgMCE/KAbRbJCtLstfAULdx1vabp6JyD1mRWYax5CwiMYSJ6ZV8kC1n
         V0u4/Ynf3Am6XnkXm2PBqMhnR6OAcQMtXL2WFMSbZJLZ6vOg8VDGppFw6/Z83wBV8SQo
         tJWWhuQtn4PnSwr4sHLM7wQN3QZ0wWK14zMy2xZGZgHCKhCL3g0R0WvCtjvD5HIrfraC
         NFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2vJIPyehP45EOG7ZIwf1xA1tLydBO6ejzJwHSkMm2YU=;
        b=inO+gtAoglfVnTeH4qy/SoqrVzVHmzKaDm0Yn3KPi1EkFYyuEknR/g3q+fz2hsMHPq
         XqVKjwpAJ5WrOA5hMy12t49mzHiAWQfBEpYp/l6YatzwpFY3E4rSsoElRH3qsBWKaNBx
         9+RSMccNKaWqV0sj/7vSAzRaZqpW7qGbCXO59oz07RDJyhgz5PqtCnnuj+PFoJD49H+z
         SR0bVq0AFpnTag9sKg6ty/U3Xt7r2ugYXSbit50tRUiqMtJd5aW2Wh9cD7YPfEEtgTGU
         5vrYGLcOCiyUX+nWtxA/+tb2FBhhzkBlTbFkM7J9INtpk7cY2028+4YiWAJG6oX/t39m
         Xk9A==
X-Gm-Message-State: AIkVDXJzURWEmpKh832skpqundsu8fxV8yCU2uPVhoAHB23EmVbz62vLyFgn3m5pgQHsTw==
X-Received: by 10.28.57.131 with SMTP id g125mr131541wma.33.1485029278916;
        Sat, 21 Jan 2017 12:07:58 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id u198sm12405527wmf.9.2017.01.21.12.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jan 2017 12:07:58 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/3] stash: support filename argument
Date:   Sat, 21 Jan 2017 20:08:04 +0000
Message-Id: <20170121200804.19009-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c
In-Reply-To: <20170121200804.19009-1-t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
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
 Documentation/git-stash.txt |  8 ++++++++
 git-stash.sh                | 42 ++++++++++++++++++++++++++++++++++--------
 t/t3903-stash.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 0ad5335a3e..871a3b246c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -15,6 +15,9 @@ SYNOPSIS
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
+'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
+	     [--] [<paths>...]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
@@ -46,6 +49,7 @@ OPTIONS
 -------
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<paths>...]::
 
 	Save your local modifications to a new 'stash', and revert the
 	the changes in the working tree to match the index.
@@ -55,6 +59,10 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
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
index d6b4ae3290..7dcce629bd 100755
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
@@ -56,6 +56,23 @@ clear_stash () {
 }
 
 create_stash () {
+	files=
+	while test $# != 0
+	do
+		case "$1" in
+		--)
+			shift
+			break
+			;;
+		--files)
+			;;
+		*)
+			files="$1 $files"
+			;;
+		esac
+		shift
+	done
+
 	stash_msg="$1"
 	untracked="$2"
 
@@ -92,7 +109,7 @@ create_stash () {
 		# Untracked files are stored by themselves in a parentless commit, for
 		# ease of unpacking later.
 		u_commit=$(
-			untracked_files | (
+			untracked_files $files | (
 				GIT_INDEX_FILE="$TMPindex" &&
 				export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
@@ -115,7 +132,7 @@ create_stash () {
 			git read-tree --index-output="$TMPindex" -m $i_tree &&
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
-			git diff-index --name-only -z HEAD -- >"$TMP-stagenames" &&
+			git diff-index --name-only -z HEAD -- $files >"$TMP-stagenames" &&
 			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
@@ -129,7 +146,7 @@ create_stash () {
 
 		# find out what the user wants
 		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- &&
+			git add--interactive --patch=stash -- $files &&
 
 		# state of the working tree
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
@@ -251,6 +268,8 @@ push_stash () {
 		shift
 	done
 
+	files="$*"
+
 	if test -n "$patch_mode" && test -n "$untracked"
 	then
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
@@ -265,18 +284,25 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash "$stash_msg" $untracked
+	create_stash --files $files -- "$stash_msg" "$untracked"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
 	if test -z "$patch_mode"
 	then
-		git reset --hard ${GIT_QUIET:+-q}
+		if test -n "$files"
+		then
+			git reset -- $files
+			git checkout HEAD -- $(git ls-files --modified -- $files)
+			git clean --force --quiet -- $(git ls-files --others -- $files)
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
@@ -702,7 +728,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	create_stash -- "$*" && echo "$w_commit"
 	;;
 store)
 	shift
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0171b824c9..3e763ff766 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -784,4 +784,31 @@ test_expect_success 'push -m shows right message' '
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
 test_done
-- 
2.11.0.483.g087da7b7c

