Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FDCC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCFF21582
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjctdbta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgIPSLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgIPSK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:10:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F1C06178B
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a9so4000315wmm.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eFfCfL2fVYM46GHt+9xlO1j7LYZ8fwv/l63YTHjQ2lQ=;
        b=Pjctdbtaqnxj6BX6aOagxCgiHmYAB9kdXYdCjqrhrAxjg/eV9zJ3FnO05hchALgxUj
         MZ3cL69gHHPT5sRSoBiLCCyfm+uIPSLVN/EeZoLZk8ADtuYvHMlAGd10oDJISwXXo7BN
         5WUM330X8WiyRV+MVqDX0jqjtLQgdV+10XjaupefzQNV4pGv5h4Ppo//my0dLyG+sX3E
         OGaXVf+gPyY7thefEZh8P2krK8xe8I5VCdzMlflPEYmHK22JvB2K0wchxZJzei1A8l6r
         kyQkWQiQXk5v83KIB0BdPepyHYGUk57FSljrwJkqTYIeCXJa1pK8FEv095/YVzLpxLP+
         zMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eFfCfL2fVYM46GHt+9xlO1j7LYZ8fwv/l63YTHjQ2lQ=;
        b=q5acu/SH1tImMu19yX88sCmgCkgo2XDsenOcmaqEfed9hhQqvWpy379CDkFrOM091r
         dPRChNvqxP1sLNmReQjTeEWCNyTo8UmNVW3E48B/Z5JZ630KXL1Hf/xccMnz2D6Rl9pt
         +PcOQkVsT+gI2Gk/RqiyGYnQToMrd6n8krzYwdf9wN4s+VpVFAhv/sfuHL4pViKoWs5w
         rqinClGrKChMErJy7ckKoMFxq1cYMw3798ulet0BIiNcVrYqSpuzimm3t4yfo1W63emm
         bsMBCqPnW/XD4tSDhpUVa7sCHS8wRe7l7cIAlTVjSi1pQkxd+uoqwUCLg6uE2XeZUwW7
         XVag==
X-Gm-Message-State: AOAM531/wb/1VK9tfjCOoOqVcqwy9upqRiJ+n/zOYnKagL0VrXAoRDAC
        QAbvOs9A0dkxnH+U4mehvkVc5EvhSqY=
X-Google-Smtp-Source: ABdhPJw1E0iHiYAagYkLfB8EJrh/DTDb59e261KpW+2IVe37xklu6jEb/FgW/WBY7KPVU090tiLzCA==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr5942837wmi.186.1600279857520;
        Wed, 16 Sep 2020 11:10:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm35471066wrb.28.2020.09.16.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:10:57 -0700 (PDT)
Message-Id: <a532053e6097f8a3b0f9bb5c67f56b4315ab9b96.1600279853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.git.1600279853.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 18:10:52 +0000
Subject: [PATCH 4/5] tests: avoid variations of the `master` branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The term `master` has a loaded history that serves as a constant
reminder of racial injustice. The Git project has no desire to
perpetuate this and already started avoiding it.

The test suite uses variations of this name for branches other than the
default one. Apart from t3200, where we just addressed this in the
previous commit, those instances can be renamed in an automated manner
because they do not require any changes outside of the test script, so
let's do that.

Seeing as `main` seems to be materializing as the favorite default
branch name of many Open Source projects, we use that name in our
replacements, too.

This trick was performed by this (GNU) sed invocation:

	$ sed -i 's/master\([a-z0-9]\)/main\1/g' t/t*.sh

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh    | 42 ++++++++++++++++++------------------
 t/t4150-am.sh                |  8 +++----
 t/t5515-fetch-merge-logic.sh |  6 +++---
 t/t5523-push-upstream.sh     | 20 ++++++++---------
 t/t6018-rev-list-glob.sh     |  6 +++---
 t/t6040-tracking-info.sh     | 20 ++++++++---------
 t/t6409-merge-subtree.sh     | 14 ++++++------
 7 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 79e43a370b..ba27e9d603 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -15,12 +15,12 @@ commit_message() {
 # this test script tries to document them.  First, the following commit history
 # is generated (the onelines are shown, time flows from left to right):
 #
-# master1 - master2 - master3
+# main1 - main2 - main3
 #                             \
-# README ---------------------- Add subproject master - master4 - files_subtree/master5
+# README ---------------------- Add subproject master - main4 - files_subtree/main5
 #
 # Where the merge moves the files master[123].t into the subdirectory
-# files_subtree/ and master4 as well as files_subtree/master5 add files to that
+# files_subtree/ and main4 as well as files_subtree/main5 add files to that
 # directory directly.
 #
 # Then, in subsequent test cases, `git filter-branch` is used to distill just
@@ -28,11 +28,11 @@ commit_message() {
 # an empty commit is added on top. The pre-rebase commit history looks like
 # this:
 #
-# Add subproject master - master4 - files_subtree/master5 - Empty commit
+# Add subproject master - main4 - files_subtree/main5 - Empty commit
 #
-# where the root commit adds three files: master1.t, master2.t and master3.t.
+# where the root commit adds three files: main1.t, main2.t and main3.t.
 #
-# This commit history is then rebased onto `master3` with the
+# This commit history is then rebased onto `main3` with the
 # `-Xsubtree=files_subtree` option in three different ways:
 #
 # 1. using `--preserve-merges`
@@ -43,9 +43,9 @@ test_expect_success 'setup' '
 	test_commit README &&
 
 	git init files &&
-	test_commit -C files master1 &&
-	test_commit -C files master2 &&
-	test_commit -C files master3 &&
+	test_commit -C files main1 &&
+	test_commit -C files main2 &&
+	test_commit -C files main3 &&
 
 	: perform subtree merge into files_subtree/ &&
 	git fetch files refs/heads/master:refs/heads/files-master &&
@@ -55,8 +55,8 @@ test_expect_success 'setup' '
 	git commit -m "Add subproject master" &&
 
 	: add two extra commits to rebase &&
-	test_commit -C files_subtree master4 &&
-	test_commit files_subtree/master5 &&
+	test_commit -C files_subtree main4 &&
+	test_commit files_subtree/main5 &&
 
 	git checkout -b to-rebase &&
 	git fast-export --no-data HEAD -- files_subtree/ |
@@ -66,22 +66,22 @@ test_expect_success 'setup' '
 	git commit -m "Empty commit" --allow-empty
 '
 
-# FAILURE: Does not preserve master4.
+# FAILURE: Does not preserve main4.
 test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "master4" &&
-	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
+	verbose test "$(commit_message HEAD~)" = "main4" &&
+	verbose test "$(commit_message HEAD)" = "files_subtree/main5"
 '
 
-# FAILURE: Does not preserve master4.
+# FAILURE: Does not preserve main4.
 test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "master4" &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
+	verbose test "$(commit_message HEAD~2)" = "main4" &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/main5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
@@ -91,8 +91,8 @@ test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
 	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --onto files-master master &&
 	: first pick results in no changes &&
 	git rebase --skip &&
-	verbose test "$(commit_message HEAD~2)" = "master4" &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
+	verbose test "$(commit_message HEAD~2)" = "main4" &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/main5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
@@ -102,8 +102,8 @@ test_expect_success 'Rebase -Xsubtree --empty=ask --rebase-merges --onto commit'
 	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --rebase-merges --onto files-master --root &&
 	: first pick results in no changes &&
 	git rebase --skip &&
-	verbose test "$(commit_message HEAD~2)" = "master4" &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
+	verbose test "$(commit_message HEAD~2)" = "main4" &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/main5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 1da8ab120b..3d8dc7eb12 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -465,7 +465,7 @@ test_expect_success 'am changes committer and keeps author' '
 test_expect_success 'am --signoff adds Signed-off-by: line' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-	git checkout -b master2 first &&
+	git checkout -b main2 first &&
 	git am --signoff <patch2 &&
 	{
 		printf "third\n\nSigned-off-by: %s <%s>\n\n" \
@@ -479,7 +479,7 @@ test_expect_success 'am --signoff adds Signed-off-by: line' '
 '
 
 test_expect_success 'am stays in branch' '
-	echo refs/heads/master2 >expected &&
+	echo refs/heads/main2 >expected &&
 	git symbolic-ref HEAD >actual &&
 	test_cmp expected actual
 '
@@ -540,7 +540,7 @@ test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
 	git reset --hard HEAD^ &&
 	git am <patch4 &&
 	git rev-parse HEAD >expected &&
-	git rev-parse master2 >actual &&
+	git rev-parse main2 >actual &&
 	test_cmp expected actual
 '
 
@@ -567,7 +567,7 @@ test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
 test_expect_success 'setup am -3' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-	git checkout -b base3way master2 &&
+	git checkout -b base3way main2 &&
 	sed -n -e "3,\$p" msg >file &&
 	head -n 9 msg >>file &&
 	git add file &&
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 9d6a46ff56..b1c18cc993 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -15,7 +15,7 @@ export GIT_TEST_PROTOCOL_VERSION
 
 build_script () {
 	script="$1" &&
-	for i in one three_file master master2 one_tree three two two2 three2
+	for i in one three_file master main2 one_tree three two two2 three2
 	do
 		echo "s/$(test_oid --hash=sha1 "$i")/$(test_oid "$i")/g" >>"$script"
 	done
@@ -52,8 +52,8 @@ test_expect_success setup '
 	two sha1:525b7fb068d59950d185a8779dc957c77eed73ba
 	two sha256:3b21de3440cd38c2a9e9b464adb923f7054949ed4c918e1a0ac4c95cd52774db
 
-	master2 sha1:754b754407bf032e9a2f9d5a9ad05ca79a6b228f
-	master2 sha256:6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0
+	main2 sha1:754b754407bf032e9a2f9d5a9ad05ca79a6b228f
+	main2 sha256:6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0
 
 	two2 sha1:6134ee8f857693b96ff1cc98d3e2fd62b199e5a8
 	two2 sha256:87a2d3ee29c83a3dc7afd41c0606b11f67603120b910a7be7840accdc18344d4
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index c0df81a014..6b5f2e373d 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -41,20 +41,20 @@ test_expect_success 'push -u --dry-run master:otherX' '
 	check_config master upstream refs/heads/other
 '
 
-test_expect_success 'push -u master2:master2' '
-	git branch master2 &&
-	git push -u upstream master2:master2 &&
-	check_config master2 upstream refs/heads/master2
+test_expect_success 'push -u main2:main2' '
+	git branch main2 &&
+	git push -u upstream main2:main2 &&
+	check_config main2 upstream refs/heads/main2
 '
 
-test_expect_success 'push -u master2:other2' '
-	git push -u upstream master2:other2 &&
-	check_config master2 upstream refs/heads/other2
+test_expect_success 'push -u main2:other2' '
+	git push -u upstream main2:other2 &&
+	check_config main2 upstream refs/heads/other2
 '
 
-test_expect_success 'push -u :master2' '
-	git push -u upstream :master2 &&
-	check_config master2 upstream refs/heads/other2
+test_expect_success 'push -u :main2' '
+	git push -u upstream :main2 &&
+	check_config main2 upstream refs/heads/other2
 '
 
 test_expect_success 'push -u --all' '
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index b31ff7eeec..5df38a39e5 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -32,11 +32,11 @@ test_expect_success 'setup' '
 	git checkout -b someref master &&
 	commit some &&
 	git checkout master &&
-	commit master2 &&
+	commit main2 &&
 	git tag foo/bar master &&
-	commit master3 &&
+	commit main3 &&
 	git update-ref refs/remotes/foo/baz master &&
-	commit master4 &&
+	commit main4 &&
 	git update-ref refs/remotes/upstream/one subspace/one &&
 	git update-ref refs/remotes/upstream/two subspace/two &&
 	git update-ref refs/remotes/upstream/x subspace-x &&
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index ad1922b999..946d05c879 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -264,25 +264,25 @@ test_expect_success 'fail to track annotated tags' '
 test_expect_success '--set-upstream-to does not change branch' '
 	git branch from-master master &&
 	git branch --set-upstream-to master from-master &&
-	git branch from-master2 master &&
-	test_must_fail git config branch.from-master2.merge > actual &&
-	git rev-list from-master2 &&
-	git update-ref refs/heads/from-master2 from-master2^ &&
-	git rev-parse from-master2 >expect2 &&
-	git branch --set-upstream-to master from-master2 &&
+	git branch from-main2 master &&
+	test_must_fail git config branch.from-main2.merge > actual &&
+	git rev-list from-main2 &&
+	git update-ref refs/heads/from-main2 from-main2^ &&
+	git rev-parse from-main2 >expect2 &&
+	git branch --set-upstream-to master from-main2 &&
 	git config branch.from-master.merge > actual &&
-	git rev-parse from-master2 >actual2 &&
+	git rev-parse from-main2 >actual2 &&
 	grep -q "^refs/heads/master$" actual &&
 	cmp expect2 actual2
 '
 
 test_expect_success '--set-upstream-to @{-1}' '
 	git checkout follower &&
-	git checkout from-master2 &&
-	git config branch.from-master2.merge > expect2 &&
+	git checkout from-main2 &&
+	git config branch.from-main2.merge > expect2 &&
 	git branch --set-upstream-to @{-1} from-master &&
 	git config branch.from-master.merge > actual &&
-	git config branch.from-master2.merge > actual2 &&
+	git config branch.from-main2.merge > actual2 &&
 	git branch --set-upstream-to follower from-master &&
 	git config branch.from-master.merge > expect &&
 	test_cmp expect2 actual2 &&
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index 793f0c8bf3..8189c7879e 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -94,10 +94,10 @@ test_expect_success 'merge update' '
 	echo git-gui2 > git-gui.sh &&
 	o3=$(git hash-object git-gui.sh) &&
 	git add git-gui.sh &&
-	git checkout -b master2 &&
+	git checkout -b main2 &&
 	git commit -m "update git-gui" &&
 	cd ../git &&
-	git pull -s subtree gui master2 &&
+	git pull -s subtree gui main2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh" &&
@@ -109,7 +109,7 @@ test_expect_success 'merge update' '
 test_expect_success 'initial ambiguous subtree' '
 	cd ../git &&
 	git reset --hard master &&
-	git checkout -b master2 &&
+	git checkout -b main2 &&
 	git merge -s ours --no-commit gui/master &&
 	git read-tree --prefix=git-gui2/ -u gui/master &&
 	git commit -m "Merge git-gui2 as our subdirectory" &&
@@ -125,8 +125,8 @@ test_expect_success 'initial ambiguous subtree' '
 
 test_expect_success 'merge using explicit' '
 	cd ../git &&
-	git reset --hard master2 &&
-	git pull -Xsubtree=git-gui gui master2 &&
+	git reset --hard main2 &&
+	git pull -Xsubtree=git-gui gui main2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh" &&
@@ -138,8 +138,8 @@ test_expect_success 'merge using explicit' '
 
 test_expect_success 'merge2 using explicit' '
 	cd ../git &&
-	git reset --hard master2 &&
-	git pull -Xsubtree=git-gui2 gui master2 &&
+	git reset --hard main2 &&
+	git pull -Xsubtree=git-gui2 gui main2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	git-gui/git-gui.sh" &&
-- 
gitgitgadget

