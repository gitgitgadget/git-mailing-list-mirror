Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34DAC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243953AbiFCLQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbiFCLPj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:15:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649A3C48B
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:15:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso6204379wma.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJzir6ET2xnPKw+dN7VJd4EA8hvDqGjdHMcGgjbhsDU=;
        b=BTtVFXj0FzVWq4tYsbzWHnI/Ba3nRlgBpIkopcnsGp8a6IGu8vB18PqvMlic4r2poU
         IjJ9YsQFiJv3sC8ESPwZqVP0RUEOVO/lhekfMhGzZU+XCemj5BXmvgGVFx9/n1aFg20A
         a4mZj39c+UvGohCrBs5KQ7dKW6vAIuCimTkXZI6UZPYTbQk69uMUOr+XuHiDL0ge6jIk
         gKPnpeMkpa7/2XrWHY1b29165Xib6yhERlkdDBAslNC3eQAq4T7NTYwHXTzGboO+iZH9
         OTu58tVCBRBKQ6/euwTPFgM4gqiF5GVessA2iBkg3t3iMlwnkXwFSRPdXWqfGzKj4L4l
         I31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJzir6ET2xnPKw+dN7VJd4EA8hvDqGjdHMcGgjbhsDU=;
        b=jhpbdpgdXGjsbIzu6BvofQk7gxSe4tUISgk0a/7AL/1ha7HuBdjRfBLzDQz91//k9R
         4Y89w/5KqSnKRqhMeApJ6iSNg13DmEM/LrxQ/kfUTlDBRIhgwxzIXCW+eL29wk3Ajd34
         BfIB6MfkRQbgA9qGNAUaLtgV8S5eavquJUi7jVZY8dymJavVqTYyKA3p3P51dVa5FrTd
         gBvRd+Bk5jOHL3gS9DunzXDREueAi5x/1aByPiAaCFhnEukSRDurgIiLQvol1Y6L0vz1
         YqdVUSEjUdKD4+9GY2XM9CkugVt8xLlhc6dICgKZsk8/bUtu09hqJar9De1uIx+ulIN3
         zYGg==
X-Gm-Message-State: AOAM532esN0Hmm3WleoKc3eQze/e+reqve7a6ahYGbykQyCc0Dko+wIv
        lkrkDJRDcLHaNiiX2IvIBUDIpUN4+hxjnA==
X-Google-Smtp-Source: ABdhPJwScus/f5WEt0dFxBImHkeyvdjGogJnV/VLM5UzCEUKH0xkQqiV+KRdRJW0sfjNR2/NKnylJQ==
X-Received: by 2002:a05:600c:1ca5:b0:39b:a66b:7805 with SMTP id k37-20020a05600c1ca500b0039ba66b7805mr23761007wms.87.1654254936305;
        Fri, 03 Jun 2022 04:15:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7184357wrb.79.2022.06.03.04.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:15:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] tests: don't assume a .git/info for .git/info/sparse-checkout
Date:   Fri,  3 Jun 2022 13:15:09 +0200
Message-Id: <patch-v2-7.7-0149c80f09c-20220603T110506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change those tests that assumed that a .git/info directory would be
created for them when writing .git/info/sparse-checkout to explicitly
create the directory by setting "TEST_CREATE_REPO_NO_TEMPLATE=1"
before sourcing test-lib.sh, and using the "--template=" argument to
"git clone".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh   | 2 ++
 t/t1090-sparse-checkout-scope.sh       | 5 ++++-
 t/t2018-checkout-branch.sh             | 4 +++-
 t/t3507-cherry-pick-conflict.sh        | 2 ++
 t/t6435-merge-sparse.sh                | 2 ++
 t/t7418-submodule-sparse-gitmodules.sh | 3 ++-
 6 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 63a553d7b32..742f0fa909f 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -11,6 +11,7 @@ test_description='sparse checkout tests
   A	init.t
 '
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
@@ -53,6 +54,7 @@ test_expect_success 'read-tree without .git/info/sparse-checkout' '
 '
 
 test_expect_success 'read-tree with .git/info/sparse-checkout but disabled' '
+	mkdir .git/info &&
 	echo >.git/info/sparse-checkout &&
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index d1833c0f31b..3a14218b245 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -5,6 +5,7 @@ test_description='sparse checkout scope tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 test_expect_success 'setup' '
@@ -25,6 +26,7 @@ test_expect_success 'create feature branch' '
 
 test_expect_success 'perform sparse checkout of main' '
 	git config --local --bool core.sparsecheckout true &&
+	mkdir .git/info &&
 	echo "!/*" >.git/info/sparse-checkout &&
 	echo "/a" >>.git/info/sparse-checkout &&
 	echo "/c" >>.git/info/sparse-checkout &&
@@ -73,7 +75,7 @@ test_expect_success 'skip-worktree on files outside sparse patterns' '
 
 test_expect_success 'in partial clone, sparse checkout only fetches needed blobs' '
 	test_create_repo server &&
-	git clone "file://$(pwd)/server" client &&
+	git clone --template= "file://$(pwd)/server" client &&
 
 	test_config -C server uploadpack.allowfilter 1 &&
 	test_config -C server uploadpack.allowanysha1inwant 1 &&
@@ -85,6 +87,7 @@ test_expect_success 'in partial clone, sparse checkout only fetches needed blobs
 	git -C server commit -m message &&
 
 	test_config -C client core.sparsecheckout 1 &&
+	mkdir client/.git/info &&
 	echo "!/*" >client/.git/info/sparse-checkout &&
 	echo "/a" >>client/.git/info/sparse-checkout &&
 	git -C client fetch --filter=blob:none origin &&
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 52e51b0726f..771c3c3c50e 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -2,6 +2,7 @@
 
 test_description='checkout'
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Arguments: [!] <branch> <oid> [<checkout options>]
@@ -257,11 +258,12 @@ test_expect_success 'checkout -b to a new branch preserves mergeable changes des
 		git checkout branch1-scratch &&
 		test_might_fail git branch -D branch3 &&
 		git config core.sparseCheckout false &&
-		rm .git/info/sparse-checkout" &&
+		rm -rf .git/info" &&
 
 	test_commit file2 &&
 
 	echo stuff >>file1 &&
+	mkdir .git/info &&
 	echo file2 >.git/info/sparse-checkout &&
 	git config core.sparseCheckout true &&
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 979e843c65a..f32799e0463 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -12,6 +12,7 @@ test_description='test cherry-pick and revert with conflicts
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 pristine_detach () {
@@ -558,6 +559,7 @@ test_expect_success 'cherry-pick preserves sparse-checkout' '
 		echo \"/*\" >.git/info/sparse-checkout
 		git read-tree --reset -u HEAD
 		rm .git/info/sparse-checkout" &&
+	mkdir .git/info &&
 	echo /unrelated >.git/info/sparse-checkout &&
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick -Xours picked>actual &&
diff --git a/t/t6435-merge-sparse.sh b/t/t6435-merge-sparse.sh
index 74562e12356..fde4aa3cd1a 100755
--- a/t/t6435-merge-sparse.sh
+++ b/t/t6435-merge-sparse.sh
@@ -2,6 +2,7 @@
 
 test_description='merge with sparse files'
 
+TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # test_file $filename $content
@@ -26,6 +27,7 @@ test_expect_success 'setup' '
 	git rm modify_delete &&
 	test_commit_this ours &&
 	git config core.sparseCheckout true &&
+	mkdir .git/info &&
 	echo "/checked-out" >.git/info/sparse-checkout &&
 	git reset --hard &&
 	test_must_fail git merge theirs
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
index f87e524d6d4..57d7ab3eced 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -31,8 +31,9 @@ test_expect_success 'sparse checkout setup which hides .gitmodules' '
 		test_tick &&
 		git commit -m "Add submodule"
 	) &&
-	git clone upstream super &&
+	git clone --template= upstream super &&
 	(cd super &&
+		mkdir .git/info &&
 		cat >.git/info/sparse-checkout <<-\EOF &&
 		/*
 		!/.gitmodules
-- 
2.36.1.1119.g5a713b43bd4

