Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B83C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiCDA7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiCDA66 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:58:58 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A709DE2F1
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:12 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id s12-20020a17090a13cc00b001bee1e1677fso3091687pjf.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sjsCTsfNsW+DgcsxwDdXr8+Pg/0xxaH4ZN6XwoYz89o=;
        b=Jr316B7dhf3Kz4pCc5OZOBSbeMxNHfXHIMvF9JXW+8cxwtTuB0SpLH6y6kGm1CIJ2S
         P2FKILMnKRNvzkfnkbmYqi0xa0xlfCjTXyT0eXzhamAc6UkpjN/tZhLJLphZRHO3opVI
         1qKfwV4qiaQbT3ai4BAuIquoAHstaR8JQTR7aZ30IjpfhY1nIglFwCUdcEs5PnAqiY5x
         /5KVaO0OL2Ctcvo+ErBdF8Yxy+OHVLPFFCpd16KWsbbR6okVy+g4grg15DCAUFuMXndl
         O6lNFUTqqkg0cST4zy/s1vQLm6UYd7JeGu7UYGMLWFuth6Ps45LcFEWPKeP7oCb+oqpq
         9WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sjsCTsfNsW+DgcsxwDdXr8+Pg/0xxaH4ZN6XwoYz89o=;
        b=O5zH1WJlTq/kp+FHTt7R1VtobZx8SMjIglVtpfap+jaXVHbCmm8nj81aIeSq7sXn60
         GJWq4iITzozoVb5ODFSSeq05aF1+7Hns40ZIwVKHn8hIgkJjC42asCyMT5XmsI66VMn2
         MVz25++aug6osQ5GoU0AhnS905GREKYiir9NBSFiYTuaRiwmAtxoCqpRvdw0NPO2JS5p
         Tjn8lPZUVlN0Nd6ZTdWRqYl0Q4A/4ULt9CXPieb0cbGa9lN0iTS+c28oEHyfWX8K3EPQ
         zzyAShoP94AM/FDs2F1oao25TJ1v4moxk1lwb1cnttcmnP9Ls/yj4uB1VbhtMOfBcW0c
         Ojmw==
X-Gm-Message-State: AOAM532JCw8rlFJl0h9N1bBKzm5xXNGWfzZkR6LJgkTrBjF4EYGlCkqV
        8KfihuAyioAYLEVaEzPTSRAC8v/iieXCv+M0C7QN2FBhO31ySUzzue2MlLvnV8Dhhh/Xu9X7L1V
        kd7go2AdDGxliJjjtoxqe9ThcExfIjeiJsglrnlZaMy/udfXOKa6UZVcOMgVgFyA=
X-Google-Smtp-Source: ABdhPJw1K2iPgjsV71YKeE+lgWAO3P0gPsB29Zf5UbAHxjG3v7DB/9JPRxxfBCXev3et4pBbJ38IiDsw9Obk9Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:945:b0:1bd:561e:b24d with SMTP id
 dw5-20020a17090b094500b001bd561eb24dmr8191832pjb.202.1646355491467; Thu, 03
 Mar 2022 16:58:11 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:50 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 03/10] t5526: create superproject commits with test helper
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few tests in t5526 use this pattern as part of their setup:

1. Create new commits in the upstream submodules (using
   add_upstream_commit()).
2. In the upstream superprojects, add the new submodule commits from the
   previous step.

A future commit will add more tests with this pattern, so reduce the
verbosity of present and future tests by introducing a test helper that
creates superproject commits. Since we now have two helpers that add
upstream commits, rename add_upstream_commit() to
add_submodule_commits().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5526-fetch-submodules.sh | 94 +++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6b24d37b2b..4cae2e4f7c 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -40,7 +40,7 @@ check_super () {
 # a file that contains the expected err if that new commit were fetched.
 # These output files get concatenated in the right order by
 # verify_fetch_result().
-add_upstream_commit() {
+add_submodule_commits () {
 	(
 		cd submodule &&
 		echo new >> subfile &&
@@ -61,6 +61,30 @@ add_upstream_commit() {
 	)
 }
 
+# For each superproject in the test setup, update its submodule, add the
+# submodule and create a new commit with the submodule change.
+#
+# This requires add_submodule_commits() to be called first, otherwise
+# the submodules will not have changed and cannot be "git add"-ed.
+add_superproject_commits () {
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	super_head=$(git rev-parse --short HEAD) &&
+	sub_head=$(git -C submodule rev-parse --short HEAD) &&
+	check_super $super_head &&
+	check_sub $sub_head
+}
+
 # Verifies that the expected repositories were fetched. This is done by
 # concatenating the files expect.err.[super|sub|deep] in the correct
 # order and comparing it to the actual stderr.
@@ -117,7 +141,7 @@ test_expect_success setup '
 '
 
 test_expect_success "fetch --recurse-submodules recurses into submodules" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
@@ -127,7 +151,7 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 '
 
 test_expect_success "submodule.recurse option triggers recursive fetch" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git -c submodule.recurse fetch >../actual.out 2>../actual.err
@@ -137,7 +161,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		GIT_TRACE="$TRASH_DIRECTORY/trace.out" git fetch --recurse-submodules -j2 2>../actual.err
@@ -148,7 +172,7 @@ test_expect_success "fetch --recurse-submodules -j2 has the same output behaviou
 '
 
 test_expect_success "fetch alone only fetches superproject" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -177,7 +201,7 @@ test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses i
 '
 
 test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
@@ -226,7 +250,7 @@ test_expect_success "--quiet propagates to parallel submodules" '
 '
 
 test_expect_success "--dry-run propagates to submodules" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
@@ -245,7 +269,7 @@ test_expect_success "Without --dry-run propagates to submodules" '
 '
 
 test_expect_success "recurseSubmodules=true propagates into submodules" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules true &&
@@ -256,7 +280,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 '
 
 test_expect_success "--recurse-submodules overrides config in submodule" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		(
@@ -270,7 +294,7 @@ test_expect_success "--recurse-submodules overrides config in submodule" '
 '
 
 test_expect_success "--no-recurse-submodules overrides config setting" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules true &&
@@ -309,7 +333,7 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 '
 
 test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	echo a > file &&
 	git add file &&
 	git commit -m "new file" &&
@@ -334,7 +358,7 @@ test_expect_success "Recursion picks up config in submodule" '
 			git config fetch.recurseSubmodules true
 		)
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git add submodule &&
 	git commit -m "new submodule" &&
 	new_head=$(git rev-parse --short HEAD) &&
@@ -352,23 +376,8 @@ test_expect_success "Recursion picks up config in submodule" '
 '
 
 test_expect_success "Recursion picks up all submodules when necessary" '
-	add_upstream_commit &&
-	(
-		cd submodule &&
-		(
-			cd subdir/deepsubmodule &&
-			git fetch &&
-			git checkout -q FETCH_HEAD
-		) &&
-		git add subdir/deepsubmodule &&
-		git commit -m "new deepsubmodule" &&
-		new_head=$(git rev-parse --short HEAD) &&
-		check_sub $new_head
-	) &&
-	git add submodule &&
-	git commit -m "new submodule" &&
-	new_head=$(git rev-parse --short HEAD) &&
-	check_super $new_head &&
+	add_submodule_commits &&
+	add_superproject_commits &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -378,19 +387,7 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 '
 
 test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
-	add_upstream_commit &&
-	(
-		cd submodule &&
-		(
-			cd subdir/deepsubmodule &&
-			git fetch &&
-			git checkout -q FETCH_HEAD
-		) &&
-		git add subdir/deepsubmodule &&
-		git commit -m "new deepsubmodule" &&
-		new_head=$(git rev-parse --short HEAD) &&
-		check_sub $new_head
-	) &&
+	add_submodule_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules true &&
@@ -402,10 +399,7 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 '
 
 test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
-	git add submodule &&
-	git commit -m "new submodule" &&
-	new_head=$(git rev-parse --short HEAD) &&
-	check_super $new_head &&
+	add_superproject_commits &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -425,7 +419,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 '
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
-	add_upstream_commit &&
+	add_submodule_commits &&
 	echo a >> file &&
 	git add file &&
 	git commit -m "new file" &&
@@ -446,7 +440,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		cd downstream &&
 		git fetch --recurse-submodules
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git config --global fetch.recurseSubmodules false &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -472,7 +466,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		cd downstream &&
 		git fetch --recurse-submodules
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git config fetch.recurseSubmodules false &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -522,7 +516,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		cd downstream &&
 		git fetch --recurse-submodules
 	) &&
-	add_upstream_commit &&
+	add_submodule_commits &&
 	git add submodule &&
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
-- 
2.33.GIT

