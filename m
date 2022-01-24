Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4744CC433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 01:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiAXB1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 20:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiAXB1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 20:27:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2240C06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 17:26:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso26517503wms.4
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 17:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=C8f3Olval2Ny2/xkdLNw7noZiDV/R8RyWkC/tVTj4BU=;
        b=X9VzWRW3b8x9qk1vFcmygYrIFEGUDC7OP5aKo+8ukftLGbIh+olhTUFrntdGI+rUta
         2sKVt8WyfJeALNBowcWLc1p2Wt68zrHUxNQx+Ectf862Q4yS0F0eCI4+UVF+bAw+qg6m
         dVj/4LIu8TK+OkC3mZE3Jfx4gkRTHgdxQ11tT/srvauR7QjnbbN9YmwtXGL3LkDfW+mk
         cO9qwZM51DOq7Dz4qsBu6mSsH9XDPibnAho5NS4+GRoI/ynCzhOokDk5zmYIOimN4tR7
         PZhP9IrftyV8fOYvk/lpf3CyPnMKdQa9xixqHOdLnGdljAnmzHaRiYTnnaTiyYsT0O2g
         PVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C8f3Olval2Ny2/xkdLNw7noZiDV/R8RyWkC/tVTj4BU=;
        b=qsvvNFN053jSZUcI7gPGhZBIz0lUKeYVuGzjQc2ROTpp25Y9VLy6oRLupuytCuAdF/
         9MDo96u2+UV9d2xA4fsxFM6e18JPKalr5MFLMLF4pHwSBB+smMvdZlYHebwnMasLsflg
         AOE0XhE2SLLvNifDKQFD0IWVztxSt5m2vJV9swhXVFQNpGa1RCBTC3d9kJR1J0j6UtYJ
         Xqn051uwK9dhxQMgDcJ10G6A/LHv0XdK3jGKhdG6pd1m2bBzaiPM/ZHZcNGJ4ePtEdhO
         lRZgqSrt2CJ31bNhkZCYeXqYNsNs1H5X/uS2M/pDw0sDcO6PbEFkBjYzvWcX2dMUlM3k
         QkXw==
X-Gm-Message-State: AOAM532/yTx4L9Szvb0BylzBz5eMr/zoO5i8/INrJTQLVLcs33GCqs5W
        IIy8dJF6sLSy4v1mLB9/oU15Qg4JtCc=
X-Google-Smtp-Source: ABdhPJxCJQdO36RroQU8jgXIrfIF0RLpS3rQlhbvN9Yr2DCNRz2jCC9tgzrgtQhGYAbL+zY+U7Z2LQ==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr9743756wmk.95.1642987617967;
        Sun, 23 Jan 2022 17:26:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm14747874wri.19.2022.01.23.17.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 17:26:57 -0800 (PST)
Message-Id: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
From:   "BoJun via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 01:26:56 +0000
Subject: [PATCH] receive-pack: purge temporary data if no command is ready to
 run
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     BoJun <bojun.cbj@gmail.com>, Chen Bojun <bojun.cbj@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chen Bojun <bojun.cbj@alibaba-inc.com>

When pushing a hidden ref, e.g.:

    $ git push origin HEAD:refs/hidden/foo

"receive-pack" will reject our request with an error message like this:

    ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidden ref)

The remote side ("git-receive-pack") will not create the hidden ref as
expected, but the pack file sent by "git-send-pack" is left inside the
remote repository. I.e. the quarantine directory is not purged as it
should be.

Add a checkpoint before calling "tmp_objdir_migrate()" and after calling
the "pre-receive" hook to purge that temporary data in the quarantine
area when there is no command ready to run.

The reason we do not add the checkpoint before the "pre-receive" hook,
but after it, is that the "pre-receive" hook is called with a switch-off
"skip_broken" flag, and all commands, even broken ones, should be fed
by calling "feed_receive_hook()".

Add a new test case and fix some formatting issues in t5516 as well.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Helped-by: Teng Long <dyroneteng@gmail.com>
Signed-off-by: Chen Bojun <bojun.cbj@alibaba-inc.com>
---
    receive-pack: purge temporary data if no command is ready to run
    
    When pushing a hidden ref, e.g.:
    
    $ git push origin HEAD:refs/hidden/foo
    
    
    "receive-pack" will reject our request with an error message like this:
    
    ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidden ref)
    
    
    The remote side ("git-receive-pack") will not create the hidden ref as
    expected, but the pack file sent by "git-send-pack" is left inside the
    remote repository. I.e. the quarantine directory is not purged as it
    should be.
    
    Add a checkpoint before calling "tmp_objdir_migrate()" and after calling
    the "pre-receive" hook to purge that temporary data in the quarantine
    area when there is no command ready to run.
    
    The reason we do not add the checkpoint before the "pre-receive" hook,
    but after it, is that the "pre-receive" hook is called with a switch-off
    "skip_broken" flag, and all commands, even broken ones, should be fed by
    calling "feed_receive_hook()".
    
    Add a new test case and fix some formatting issues in t5516 as well.
    
    Helped-by: Jiang Xin zhiyou.jx@alibaba-inc.com Helped-by: Teng Long
    dyroneteng@gmail.com Signed-off-by: Chen Bojun bojun.cbj@alibaba-inc.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1124%2FBerger7%2Fberger7%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1124/Berger7/berger7/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1124

 builtin/receive-pack.c |   8 +++
 t/t5516-fetch-push.sh  | 149 ++++++++++++++++++++---------------------
 2 files changed, 81 insertions(+), 76 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf..301dbc4824e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1971,6 +1971,14 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	/*
+	 * If there is no command ready to run, should return directly to destroy
+	 * temporary data in the quarantine area.
+	 */
+	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next);
+	if (!cmd)
+		return;
+
 	/*
 	 * Now we'll start writing out refs, which means the objects need
 	 * to be in their final positions so that other processes can see them.
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2f04cf9a1c7..b71182ae13b 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -21,99 +21,91 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 D=$(pwd)
 
-mk_empty () {
+mk_empty() {
 	repo_name="$1"
 	rm -fr "$repo_name" &&
-	mkdir "$repo_name" &&
-	(
-		cd "$repo_name" &&
-		git init &&
-		git config receive.denyCurrentBranch warn &&
-		mv .git/hooks .git/hooks-disabled
-	)
+		mkdir "$repo_name" &&
+		(
+			cd "$repo_name" &&
+				git init &&
+				git config receive.denyCurrentBranch warn &&
+				mv .git/hooks .git/hooks-disabled
+		)
 }
 
-mk_test () {
+mk_test() {
 	repo_name="$1"
 	shift
 
 	mk_empty "$repo_name" &&
-	(
-		for ref in "$@"
-		do
-			git push "$repo_name" $the_first_commit:refs/$ref ||
-			exit
-		done &&
-		cd "$repo_name" &&
-		for ref in "$@"
-		do
-			echo "$the_first_commit" >expect &&
-			git show-ref -s --verify refs/$ref >actual &&
-			test_cmp expect actual ||
-			exit
-		done &&
-		git fsck --full
-	)
+		(
+			for ref in "$@"; do
+				git push "$repo_name" $the_first_commit:refs/$ref ||
+					exit
+			done &&
+				cd "$repo_name" &&
+				for ref in "$@"; do
+					echo "$the_first_commit" >expect &&
+						git show-ref -s --verify refs/$ref >actual &&
+						test_cmp expect actual ||
+						exit
+				done &&
+				git fsck --full
+		)
 }
 
 mk_test_with_hooks() {
 	repo_name=$1
 	mk_test "$@" &&
-	(
-		cd "$repo_name" &&
-		mkdir .git/hooks &&
-		cd .git/hooks &&
-
-		cat >pre-receive <<-'EOF' &&
-		#!/bin/sh
-		cat - >>pre-receive.actual
-		EOF
-
-		cat >update <<-'EOF' &&
-		#!/bin/sh
-		printf "%s %s %s\n" "$@" >>update.actual
-		EOF
-
-		cat >post-receive <<-'EOF' &&
-		#!/bin/sh
-		cat - >>post-receive.actual
-		EOF
-
-		cat >post-update <<-'EOF' &&
-		#!/bin/sh
-		for ref in "$@"
-		do
-			printf "%s\n" "$ref" >>post-update.actual
-		done
-		EOF
-
-		chmod +x pre-receive update post-receive post-update
-	)
+		(
+			cd "$repo_name" &&
+				mkdir .git/hooks &&
+				cd .git/hooks &&
+				cat >pre-receive <<-'EOF' &&
+					#!/bin/sh
+					cat - >>pre-receive.actual
+				EOF
+				cat >update <<-'EOF' &&
+					#!/bin/sh
+					printf "%s %s %s\n" "$@" >>update.actual
+				EOF
+				cat >post-receive <<-'EOF' &&
+					#!/bin/sh
+					cat - >>post-receive.actual
+				EOF
+				cat >post-update <<-'EOF' &&
+					#!/bin/sh
+					for ref in "$@"
+					do
+						printf "%s\n" "$ref" >>post-update.actual
+					done
+				EOF
+				chmod +x pre-receive update post-receive post-update
+		)
 }
 
 mk_child() {
 	rm -rf "$2" &&
-	git clone "$1" "$2"
+		git clone "$1" "$2"
 }
 
-check_push_result () {
+check_push_result() {
 	test $# -ge 3 ||
-	BUG "check_push_result requires at least 3 parameters"
+		BUG "check_push_result requires at least 3 parameters"
 
 	repo_name="$1"
 	shift
 
 	(
 		cd "$repo_name" &&
-		echo "$1" >expect &&
-		shift &&
-		for ref in "$@"
-		do
-			git show-ref -s --verify refs/$ref >actual &&
-			test_cmp expect actual ||
-			exit
-		done &&
-		git fsck --full
+			echo "$1" >expect &&
+			shift &&
+			for ref in "$@"; do
+				git show-ref -s --verify refs/$ref >actual &&
+					test_cmp expect actual ||
+					exit
+			done &&
+			git fsck --full
 	)
 }
 
@@ -191,7 +183,7 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 	)
 '
 
-grep_wrote () {
+grep_wrote() {
 	object_count=$1
 	file_name=$2
 	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
@@ -477,8 +469,7 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
-for head in HEAD @
-do
+for head in HEAD @; do
 
 	test_expect_success "push with $head" '
 		mk_test testrepo heads/main &&
@@ -1020,7 +1011,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
-test_force_push_tag () {
+test_force_push_tag() {
 	tag_type_description=$1
 	tag_args=$2
 
@@ -1066,7 +1057,7 @@ test_force_push_tag () {
 test_force_push_tag "lightweight tag" "-f"
 test_force_push_tag "annotated tag" "-f -a -m'tag message'"
 
-test_force_fetch_tag () {
+test_force_fetch_tag() {
 	tag_type_description=$1
 	tag_args=$2
 
@@ -1158,8 +1149,7 @@ test_expect_success 'push --prune refspec' '
 	! check_push_result testrepo $the_first_commit tmp/foo tmp/bar
 '
 
-for configsection in transfer receive
-do
+for configsection in transfer receive; do
 	test_expect_success "push to update a ref hidden by $configsection.hiderefs" '
 		mk_test testrepo heads/main hidden/one hidden/two hidden/three &&
 		(
@@ -1250,8 +1240,7 @@ test_expect_success 'fetch exact SHA1 in protocol v2' '
 	git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
 '
 
-for configallowtipsha1inwant in true false
-do
+for configallowtipsha1inwant in true false; do
 	test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
 		mk_empty testrepo &&
 		(
@@ -1809,4 +1798,12 @@ test_expect_success 'refuse fetch to current branch of bare repository worktree'
 	git -C bare.git fetch -u .. HEAD:wt
 '
 
+test_expect_success 'refuse to push a hidden ref, and make sure do not pollute the repository' '
+	mk_empty testrepo &&
+	git -C testrepo config receive.hiderefs refs/hidden &&
+	git -C testrepo config receive.unpackLimit 1 &&
+	test_must_fail git push testrepo HEAD:refs/hidden/foo &&
+	test_dir_is_empty testrepo/.git/objects/pack
+'
+
 test_done

base-commit: 297ca895a27a6bbdb7906371d533f72a12ad25b2
-- 
gitgitgadget
