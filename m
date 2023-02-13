Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF1AC64EC7
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBMSWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjBMSWV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:22:21 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413220073
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:06 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z8-20020a170902834800b001990ad8de5bso7770740pln.10
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676312526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nh4j4y0rRE6Y7+356e1tgpoREu4tfQKkql0MR4ZIT94=;
        b=BRiOCIMo+qzr0DCM05GtC5C4Fl0wo0ua6KqpMKcVtwjGTXqMIvDoQMdEAa28y5kq6/
         FUVmJNUqGt1zURZCN8XRsjQ5cK8ND1CxL1fpV0INkQ3s/MLeOz0h88wSiMFPRUf2aIMg
         p7enlXe2B1Qx1eWuJCXIP9EV2zMLMG+742jZWly/69KDuCULjcWqZYT+S5rnPYde+W5r
         nJSHbPnnr5wVGqpgxEFZ6GaIi/+xAYxqrDQhGJjNFNUqgb85aigpTBgDA+21tMBzrWEG
         b0CHDrFtacP/hLVtS3uBALLa7aCUuOqa/aIuoTGZZMjnqhSHfIWM2Nn3Gr/VeW/SiWXr
         2ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676312526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh4j4y0rRE6Y7+356e1tgpoREu4tfQKkql0MR4ZIT94=;
        b=BcsMgHuSV6VhI5aBQffggwMPIqMvhMsfyUhASCPYMbiWXWS28iY4UNYI+Fq3wznf3T
         idOIK2Xvm/Ief3HSXCwAYbLo0I/LxVdMZomWqjUqUeTzUl4E0x8j+jRJiDNtFWOQIuqp
         hc7dTKoOMWLfRZSpBp4/45BCU+o++KW6E8iSHOzdqp9nj/5xaqDvOHXj3c6ghOy7HdBo
         vFe7n70pzMgKOj4mjKcfWNVHEf0EjhJuh5jVRNyLzTMkypnCZIrLn9y48VDy3kRmJZG5
         +6s2+E4R/PjzD8ioH87BJUYbZGcoPQpbyA+MZr8x9LA2pIAgJlQElkM9yltCHq4V8Q6P
         iOLg==
X-Gm-Message-State: AO0yUKWa3ixHY1zZtbfXSdiFqho4oi65o0Dle7Bko/6J1ANTLuIUQgPp
        AzrFVNLpgJgCSAvFPkx0tYVQp3MQOhMZYXMC55avyhUT5fylOYQS0YcuXIewplR1x6KBaqTnyDo
        Ou+a2FjaS3g63O2MCWZkC+vq4lYGko3pB0/bnmd4mJTXmCvFjliszttsaesemlNclqw==
X-Google-Smtp-Source: AK7set+S8+7ggp++x0rDf8F1Jp9Xx8fI2SmJ0Zuo6MyHB2VRo5GucYFUkZvYFbi/w9JiFAedIr7fYqhY5LUN8TY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:db0f:b0:198:e13d:a05d with SMTP
 id m15-20020a170902db0f00b00198e13da05dmr5797918plx.12.1676312526349; Mon, 13
 Feb 2023 10:22:06 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:21:31 +0000
In-Reply-To: <20230213182134.2173280-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213182134.2173280-4-calvinwan@google.com>
Subject: [RFC PATCH 3/6] tests: Use `git submodule add` instead of `git add`
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

Since 532139940c (add: warn when adding an embedded repository,
2017-06-14), we have recognized that adding embedded repositories is a
subpar user experience compared to submodules. Embedded repositories
lack a .gitmodules entry, which means clones of the top-level repo will
be unable to obtain the nested repo. We issue advice about this
situation in the case where a user adds an embedded repository.

However, many tests predate this advice, and directly add embedded
repositories instead of using submodules. This commit cleans up such
test cases where minimal other changes are required (e.g., committing
later changes to .gitmodules or changing the counts of committed files
in the worktree). Future commits will handle tests requiring more
complicated adjustments.

These changes will enable us to switch the default behavior of git-add
from warning about embedded repositories to rejecting them outright. See
later commits for a further discussion of that topic.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 t/t0008-ignores.sh                     |  2 +-
 t/t2013-checkout-submodule.sh          |  4 +++-
 t/t2103-update-index-ignore-missing.sh |  2 +-
 t/t2107-update-index-basic.sh          |  2 +-
 t/t3040-subprojects-basic.sh           |  2 +-
 t/t3050-subprojects-fetch.sh           |  3 ++-
 t/t3404-rebase-interactive.sh          |  3 ++-
 t/t3701-add-interactive.sh             |  5 +++--
 t/t4010-diff-pathspec.sh               |  2 +-
 t/t4020-diff-external.sh               |  2 +-
 t/t4035-diff-quiet.sh                  |  1 +
 t/t5531-deep-submodule-push.sh         |  4 ++--
 t/t6416-recursive-corner-cases.sh      | 12 ++++++------
 t/t6430-merge-recursive.sh             |  1 +
 t/t6437-submodule-merge.sh             | 12 ++++++------
 t/t7401-submodule-summary.sh           |  4 ++--
 t/t7402-submodule-rebase.sh            |  2 +-
 17 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index c70d11bc91..ea58d415ba 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -191,7 +191,7 @@ test_expect_success 'setup' '
 		git add a &&
 		git commit -m"commit in submodule"
 	) &&
-	git add a/submodule &&
+	git submodule add ./a/submodule ./a/submodule &&
 	cat <<-\EOF >.gitignore &&
 		one
 		ignored-*
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index b2bdd1fcb4..dd2858648b 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -10,7 +10,7 @@ test_expect_success 'setup' '
 	(cd submodule &&
 	 git init &&
 	 test_commit first) &&
-	git add submodule &&
+	git submodule add ./submodule &&
 	test_tick &&
 	git commit -m superproject &&
 	(cd submodule &&
@@ -51,6 +51,7 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .gitm
 	git config diff.ignoreSubmodules none &&
 	git config -f .gitmodules submodule.submodule.path submodule &&
 	git config -f .gitmodules submodule.submodule.ignore untracked &&
+	git commit -m "Update patterns in .gitmodules" .gitmodules &&
 	git checkout HEAD >actual 2>&1 &&
 	test_must_be_empty actual
 '
@@ -59,6 +60,7 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	git config -f .gitmodules submodule.submodule.ignore none &&
 	git config submodule.submodule.path submodule &&
 	git config submodule.submodule.ignore all &&
+	git commit -m "Update patterns in .gitmodules" .gitmodules &&
 	git checkout HEAD >actual 2>&1 &&
 	test_must_be_empty actual
 '
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index e9451cd567..f43a57350c 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -36,7 +36,7 @@ test_expect_success basics '
 		git add file &&
 		git commit -m "sub initial"
 	) &&
-	git add xyzzy &&
+	git submodule add ./xyzzy &&
 
 	test_tick &&
 	git commit -m initial &&
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 07e6de84e6..465b41ccdc 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -49,7 +49,7 @@ test_expect_success '--cacheinfo does not accept blob null sha1' '
 test_expect_success '--cacheinfo does not accept gitlink null sha1' '
 	git init submodule &&
 	(cd submodule && test_commit foo) &&
-	git add submodule &&
+	git submodule add ./submodule &&
 	git rev-parse :submodule >expect &&
 	test_must_fail git update-index --cacheinfo 160000 $ZERO_OID submodule &&
 	git rev-parse :submodule >actual &&
diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index bd65dfcffc..61da7e3b94 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -69,7 +69,7 @@ test_expect_success 'check if clone works' '
 test_expect_success 'removing and adding subproject' '
 	git update-index --force-remove -- sub2 &&
 	mv sub2 sub3 &&
-	git add sub3 &&
+	git submodule add ./sub3 &&
 	git commit -q -m "renaming a subproject" &&
 	test_expect_code 1 git diff -M --name-status --exit-code HEAD^ HEAD
 '
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index f1f09abdd9..9a692274b9 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -14,7 +14,8 @@ test_expect_success setup '
 		git commit -m "subproject commit #1"
 	) &&
 	>mainfile &&
-	git add sub mainfile &&
+	git add mainfile &&
+	git submodule add ./sub &&
 	test_tick &&
 	git commit -m "superproject commit #1"
 '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 462cefd25d..1d0574216b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -675,7 +675,8 @@ test_expect_success 'submodule rebase setup' '
 		git add elif && git commit -m "submodule initial"
 	) &&
 	echo 1 >file1 &&
-	git add file1 sub &&
+	git add file1 &&
+	git submodule add ./sub &&
 	test_tick &&
 	git commit -m "One" &&
 	echo 2 >file1 &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5841f280fb..715c4fcc62 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -913,8 +913,9 @@ test_expect_success 'setup different kinds of dirty submodules' '
 		) &&
 		cp -R dirty-head dirty-otherwise &&
 		cp -R dirty-head dirty-both-ways &&
-		git add dirty-head &&
-		git add dirty-otherwise dirty-both-ways &&
+		git submodule add ./dirty-head &&
+		git submodule add ./dirty-otherwise &&
+		git submodule add ./dirty-both-ways &&
 		git commit -m initial &&
 
 		cd dirty-head &&
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 9d9650eba7..844258c418 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -117,7 +117,7 @@ test_expect_success 'setup submodules' '
 	test_tick &&
 	git init submod &&
 	( cd submod && test_commit first ) &&
-	git add submod &&
+	git submodule add ./submod &&
 	git commit -m first &&
 	( cd submod && test_commit second ) &&
 	git add submod &&
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index c1ac09ecc7..ca2a23a78f 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -253,7 +253,7 @@ test_expect_success 'clean up crlf leftovers' '
 test_expect_success 'submodule diff' '
 	git init sub &&
 	( cd sub && test_commit sub1 ) &&
-	git add sub &&
+	git submodule add ./sub &&
 	test_tick &&
 	git commit -m "add submodule" &&
 	( cd sub && test_commit sub2 ) &&
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 76f8034c60..23ef222006 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -66,6 +66,7 @@ test_expect_success 'git diff-index --cached HEAD^' '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
 	echo 3 >c &&
+	git submodule add ./test-outside/repo ./test-outside/repo &&
 	git add . &&
 	test_expect_code 1 git diff-index --quiet --cached HEAD^ >cnt &&
 	test_line_count = 0 cnt
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 302e4cbdba..f8ef70b5a2 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -28,7 +28,7 @@ test_expect_success setup '
 			git add junk &&
 			git commit -m "Initial junk"
 		) &&
-		git add gar/bage &&
+		git submodule add ./gar/bage ./gar/bage &&
 		git commit -m "Initial superproject"
 	)
 '
@@ -367,7 +367,7 @@ test_expect_success 'push succeeds if submodule has no remote and is on the firs
 			git add junk &&
 			git commit -m "initial"
 		) &&
-		git add b &&
+		git submodule add ./b &&
 		git commit -m "added submodule" &&
 		git push --recurse-submodules=check origin main
 	)
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 17b54d625d..b366dd77e5 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -1270,7 +1270,7 @@ test_expect_success 'setup submodule modify/modify' '
 		) &&
 
 		git -C submod reset --hard A &&
-		git add submod &&
+		git submodule add ./submod &&
 		git commit -m A &&
 		git tag A &&
 
@@ -1303,7 +1303,7 @@ test_expect_merge_algorithm failure success 'check submodule modify/modify' '
 		test_must_fail git merge -s recursive E^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 3 out &&
+		test_line_count = 4 out &&
 		git ls-files -u >out &&
 		test_line_count = 3 out &&
 		git ls-files -o >out &&
@@ -1364,12 +1364,12 @@ test_expect_success 'setup submodule add/add' '
 
 		git checkout -b B A &&
 		git -C submod reset --hard B &&
-		git add submod &&
+		git submodule add ./submod &&
 		git commit -m B &&
 
 		git checkout -b C A &&
 		git -C submod reset --hard C &&
-		git add submod &&
+		git submodule add ./submod &&
 		git commit -m C &&
 
 		git checkout -q B^0 &&
@@ -1391,7 +1391,7 @@ test_expect_merge_algorithm failure success 'check submodule add/add' '
 		test_must_fail git merge -s recursive E^0 &&
 
 		git ls-files -s >out &&
-		test_line_count = 3 out &&
+		test_line_count = 4 out &&
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
@@ -1439,7 +1439,7 @@ test_expect_success 'setup conflicting entry types (submodule vs symlink)' '
 
 		git checkout -b B A &&
 		git -C path reset --hard B &&
-		git add path &&
+		git submodule add ./path &&
 		git commit -m B &&
 
 		git checkout -b C A &&
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index 07067bb347..8962db8faa 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -677,6 +677,7 @@ test_expect_success 'merging with triple rename across D/F conflict' '
 	echo content3 >sub2/file3 &&
 	mkdir simple &&
 	echo base >simple/bar &&
+	git -c protocol.file.allow=always submodule add ./sym &&
 	git add -A &&
 	test_tick &&
 	git commit -m base &&
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index c9a86f2e94..7f6e89f541 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -30,7 +30,7 @@ test_expect_success setup '
 	 git add file &&
 	 test_tick &&
 	 git commit -m sub-root) &&
-	git add sub &&
+	git submodule add ./sub &&
 	test_tick &&
 	git commit -m root &&
 
@@ -85,7 +85,7 @@ test_expect_success 'setup for merge search' '
 	 git branch sub-a) &&
 	git commit --allow-empty -m init &&
 	git branch init &&
-	git add sub &&
+	git submodule add ./sub &&
 	git commit -m "a" &&
 	git branch a &&
 
@@ -132,7 +132,7 @@ test_expect_success 'finish setup for merge-search' '
 	git checkout -b g init &&
 	(cd sub &&
 	 git checkout -b sub-g sub-c) &&
-	git add sub &&
+	git submodule add ./sub &&
 	git commit -a -m "g")
 '
 
@@ -296,7 +296,7 @@ test_expect_success 'setup for recursive merge with submodule' '
 	  git checkout -b sub-cb sub-c &&
 	  git merge sub-b &&
 	  git checkout main) &&
-	 git add sub &&
+	 git submodule add ./sub &&
 	 git commit -m a &&
 	 git checkout -b top-b main &&
 	 (cd sub && git checkout sub-b) &&
@@ -520,7 +520,7 @@ test_expect_success 'setup for null merge base' '
 	git commit --allow-empty -m init &&
 	git branch init &&
 	git checkout -b a init &&
-	git add sub &&
+	git submodule add ./sub &&
 	git commit -m "a" &&
 	git switch main &&
 	(cd sub &&
@@ -532,7 +532,7 @@ test_expect_success 'setup for null merge base' '
 test_expect_success 'merging should fail with no merge base' '
 	(cd no-merge-base &&
 	git checkout -b b init &&
-	git add sub &&
+	git submodule add ./sub &&
 	git commit -m "b" &&
 	test_must_fail git merge a >actual &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 542b3331a7..73fd09edb6 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -45,7 +45,7 @@ add_file . foo >/dev/null
 head1=$(add_file sm1 foo1 foo2)
 
 test_expect_success 'added submodule' "
-	git add sm1 &&
+	git submodule add ./sm1 &&
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
 	* sm1 0000000...$head1 (2):
@@ -253,7 +253,7 @@ test_expect_success 'deleted submodule' "
 test_expect_success 'create second submodule' '
 	test_create_repo sm2 &&
 	head7=$(add_file sm2 foo8 foo9) &&
-	git add sm2
+	git submodule add ./sm2
 '
 
 test_expect_success 'multiple submodules' "
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index ebeca12a71..abc2092741 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -14,7 +14,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m initial &&
 	git clone . submodule &&
-	git add submodule &&
+	git submodule add ./submodule &&
 	test_tick &&
 	git commit -m submodule &&
 	echo second line >> file &&
-- 
2.39.1.581.gbfd45094c4-goog

