Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6FC1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdBLVyW (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:54:22 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36397 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdBLVyV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:54:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so16247719wmd.3
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uuLPiRSb/AflUuHpRhPjpmr+4Y08IPFyGZ9VJQ/bz0E=;
        b=Dizkcay66UNU/CqkFcSndYB2wIXWk+B6XFuUsz9OOx5KJe+ZDFRaHS4uX4yA92nxxr
         ZFOnqGjbzBXMCAeyp8h8chEPaDNkX/ApLIW18dO/DdgGE0GtSZYrDbOtKRfT09sNly8B
         8wI155NOmCStzKrQi+Pr9H6dzWEm6cjKRLUd1AIoj3dzfPkJkt4H41sIMn1Qrj0qdhJq
         iHt05+F3z0Lx6USR5TTxA1EExSD0nXg3M7+I/Wprt2V4jZABrPHuvO/37vhfsKXg9uoE
         0vz8a0b7IlJeknD5xOTVVTnR99ijFMy+V16m5+miYliz1gLPRu2tSCl/1E+rQRRYQpGG
         +WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uuLPiRSb/AflUuHpRhPjpmr+4Y08IPFyGZ9VJQ/bz0E=;
        b=ttyBsEQXIQdcmc918+xXaXRNmFjggimHgKeOUfPTJ0S1PbqHSgqt6qbwnzl0IY/k3R
         dLJjQ1OHKCXfN03lydElCProrjvCHylg3LN57aL0oAXCuXlETc20TRBcQx1GwDOAuRON
         budOPRLAdB+kwUpidKEphDKT69iwVqXGaSL0DXlSjty8FCqeYOynyE6rJTPeZf7DBenO
         TbcmIkot4VR77vFIvv8MSH9Xna4DzmQYVJFmmtpgNUUN93hKxzFKDCAJpO5ZcBv5wZNu
         qxhVMdLOPhdgzvvAxJNm0VTFwWNRwOP7h4fIr8zUa9GzECsmounXTqwGqNKOJqn0dnDn
         YVSQ==
X-Gm-Message-State: AMke39kb7sWFKFT95o/XZNgsphUmAum6gYk3+rJfq7/YkehkvyJ4TISglAZHia7eQKaptg==
X-Received: by 10.28.191.79 with SMTP id p76mr34673770wmf.21.1486936459909;
        Sun, 12 Feb 2017 13:54:19 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 65sm8213000wri.53.2017.02.12.13.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 13:54:19 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 0/7] stash: support pathspec argument
Date:   Sun, 12 Feb 2017 21:54:13 +0000
Message-Id: <20170212215420.16701-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g86e6ecc671.dirty
In-Reply-To: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Peff and Junio for the review of the last round.

Changes since v3:

- Instead of using ${1-...} to check for missing arguments and dying
  show the usage for stash instead, being more consistent with how the
  rest of stash behaves
- Let push_stash handle the --help argument from save_stash as well,
  passing it through directly.

- Fix the tests to not pipe the output to something, and thereby
  swallowing the error codes

- Update the commit message in 4/7 to acknowledge that there is a
  small regression between the two versions

- Correctly detect when there are no changes, and only show the
  message once
- Fix the accidental deletion of untracked files when a pathspec is
  used.  Also added test cases for that.
- Add documentation for git stash push to the usage text
- Respect the -q flag and the GIT_QUIET environment variable

- This also adds two new patches, one using push_stash instead of
  save_stash for git stash without any verb.  The other allows using a
  pathspec in the verb-less option of git stash.

Interdiff below:
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index be55e456fa..b0825f4aca 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,15 +13,15 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]]
-'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+	     [-u|--include-untracked] [-a|--all] [<message>]
+'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
-	     [--] [<pathspec>...]
+	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
-	     [-- <paths>...]
+	     [-- <pathspec>...]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
diff --git a/git-stash.sh b/git-stash.sh
index 46367d40aa..a184b1e274 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,8 +7,11 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		       [-u|--include-untracked] [-a|--all] [<message>]]
+   or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+		      [-u|--include-untracked] [-a|--all] [<message>]
+   or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+		       [-u|--include-untracked] [-a|--all] [-m <message>]
+		       [-- <pathspec>...]]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -33,8 +36,8 @@ else
 fi
 
 no_changes () {
-	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
-	git diff-files --quiet --ignore-submodules &&
+	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
+	git diff-files --quiet --ignore-submodules -- "$@" &&
 	(test -z "$untracked" || test -z "$(untracked_files)")
 }
 
@@ -64,11 +67,13 @@ create_stash () {
 		case "$1" in
 		-m|--message)
 			shift
-			stash_msg=${1?"-m needs an argument"}
+			test -z ${1+x} && usage
+			stash_msg="$1"
 			new_style=t
 			;;
 		-u|--include-untracked)
 			shift
+			test -z ${1+x} && usage
 			untracked="$1"
 			new_style=t
 			;;
@@ -104,14 +109,11 @@ create_stash () {
 	if test -z "$new_style"
 	then
 		stash_msg="$*"
-		while test $# != 0
-		do
-			shift
-		done
+		set --
 	fi
 
 	git update-index -q --refresh
-	if no_changes
+	if no_changes "$@"
 	then
 		exit 0
 	fi
@@ -270,7 +272,8 @@ push_stash () {
 			;;
 		-m|--message)
 			shift
-			stash_msg=${1?"-m needs an argument"}
+			test -z ${1+x} && usage
+			stash_msg=$1
 			;;
 		--help)
 			show_help
@@ -308,7 +311,7 @@ push_stash () {
 	fi
 
 	git update-index -q --refresh
-	if no_changes
+	if no_changes "$@"
 	then
 		say "$(gettext "No local changes to save")"
 		exit 0
@@ -325,9 +328,23 @@ push_stash () {
 	then
 		if test $# != 0
 		then
-			git ls-files -z -- "$@" | xargs -0 git reset --
-			git ls-files -z --modified -- "$@" | xargs -0 git checkout HEAD --
-			git ls-files -z --others -- "$@" | xargs -0 git clean --force --
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
 		else
 			git reset --hard ${GIT_QUIET:+-q}
 		fi
@@ -357,9 +374,6 @@ save_stash () {
 	while test $# != 0
 	do
 		case "$1" in
-		--help)
-			show_help
-			;;
 		--)
 			shift
 			break
@@ -685,17 +699,18 @@ apply_to_branch () {
 }
 
 PARSE_CACHE='--not-parsed'
-# The default command is "save" if nothing but options are given
+# The default command is "push" if nothing but options are given
 seen_non_option=
 for opt
 do
 	case "$opt" in
+	--) break ;;
 	-*) ;;
 	*) seen_non_option=t; break ;;
 	esac
 done
 
-test -n "$seen_non_option" || set "save" "$@"
+test -n "$seen_non_option" || set "push" "$@"
 
 # Main command set
 case "$1" in
@@ -746,7 +761,7 @@ branch)
 *)
 	case $# in
 	0)
-		save_stash &&
+		push_stash &&
 		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 461fe46045..22ac75377b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -274,9 +274,7 @@ test_expect_success 'stash --invalid-option' '
 	git add file2 &&
 	test_must_fail git stash --invalid-option &&
 	test_must_fail git stash save --invalid-option &&
-	test bar5,bar6 = $(cat file),$(cat file2) &&
-	git stash -- -message-starting-with-dash &&
-	test bar,bar2 = $(cat file),$(cat file2)
+	test bar5,bar6 = $(cat file),$(cat file2)
 '
 
 test_expect_success 'stash an added file' '
@@ -780,7 +778,7 @@ test_expect_success 'push -m shows right message' '
 	git add foo &&
 	git stash push -m "test message" &&
 	echo "stash@{0}: On master: test message" >expect &&
-	git stash list | head -n 1 >actual &&
+	git stash list -1 >actual &&
 	test_cmp expect actual
 '
 
@@ -789,7 +787,7 @@ test_expect_success 'create stores correct message' '
 	git add foo &&
 	STASH_ID=$(git stash create "create test message") &&
 	echo "On master: create test message" >expect &&
-	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
 	test_cmp expect actual
 '
 
@@ -798,7 +796,7 @@ test_expect_success 'create with multiple arguments for the message' '
 	git add foo &&
 	STASH_ID=$(git stash create test untracked) &&
 	echo "On master: test untracked" >expect &&
-	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
 	test_cmp expect actual
 '
 
@@ -807,7 +805,7 @@ test_expect_success 'new style stash create stores correct message' '
 	git add foo &&
 	STASH_ID=$(git stash create -m "create test message new style") &&
 	echo "On master: create test message new style" >expect &&
-	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
 	test_cmp expect actual
 '
 
@@ -839,18 +837,63 @@ test_expect_success 'stash with multiple filename arguments' '
 '
 
 test_expect_success 'stash with file including $IFS character' '
-	>"foo	bar" &&
+	>"foo bar" &&
 	>foo &&
-	>untracked &&
+	>bar &&
 	git add foo* &&
-	git stash push -- foo* &&
-	test_path_is_missing "foo	bar" &&
-	test_path_is_missing foo &&
-	test_path_is_file untracked &&
+	git stash push -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
 	git stash pop &&
-	test_path_is_file "foo	bar" &&
+	test_path_is_file "foo bar" &&
 	test_path_is_file foo &&
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
 	test_path_is_file untracked
 '
 
+test_expect_success 'stash without verb with pathspec' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash -- "foo b*" &&
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
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 9a98e31a3e..193adc7b68 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -197,16 +197,16 @@ test_expect_success 'stash push --include-untracked with pathspec' '
 '
 
 test_expect_success 'stash push with $IFS character' '
-	>"foo	bar" &&
+	>"foo bar" &&
 	>foo &&
 	>bar &&
 	git add foo* &&
-	git stash push --include-untracked -- foo* &&
-	test_path_is_missing "foo	bar" &&
-	test_path_is_missing foo &&
+	git stash push --include-untracked -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
 	test_path_is_file bar &&
 	git stash pop &&
-	test_path_is_file "foo	bar" &&
+	test_path_is_file "foo bar" &&
 	test_path_is_file foo &&
 	test_path_is_file bar
 '

Thomas Gummerer (7):
  Documentation/stash: remove mention of git reset --hard
  stash: introduce push verb
  stash: add test for the create command line arguments
  stash: introduce new format create
  stash: teach 'push' (and 'create') to honor pathspec
  stash: use stash_push for no verb form
  stash: allow pathspecs in the no verb form

 Documentation/git-stash.txt        |  21 ++++-
 git-stash.sh                       | 157 +++++++++++++++++++++++++++++++------
 t/t3903-stash.sh                   | 127 +++++++++++++++++++++++++++++-
 t/t3905-stash-include-untracked.sh |  26 ++++++
 4 files changed, 302 insertions(+), 29 deletions(-)

-- 
2.11.0.301.g86e6ecc671.dirty

