Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3019C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiCHAPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCHAPt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:15:49 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E9321BB
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:14:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e1-20020a17090a280100b001bf44b6d74bso457781pjd.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i6/DSxSE8XRNA9H3mcifWxEjXE4etz0JgkSHr/Hsvu8=;
        b=kZNAPqNx2cLrdzRElW8hLYXKqlJhg0jCiqnaNAg1zMW8eK8wuYFyIr5yZks9PQnUsz
         VNC0rVjdQ5Hx2wxadVn+0Ngfu2Iyd/31cUTwvZ4kS9G5EMrN6O5Mj/dqJDLRkbTssTes
         L+mtmxwmulCBf+Ljitk8vx9OBCX5KVdEovRdbrUtt/nbN7x+LamDEQlF4uctQ71HdWPk
         gLdf1PVqCdZajkZCH5iI/SrAfSrHjoKcJAlgLv8f+LNcNSzlsWKxUINHXLamngPXE8uU
         kX7k7HqryY9YJD+Mf54aJwbD9O6Sy6yYcVBswicFgqLuMoSY3J/t7sGRs5uQFNSOrPev
         ba3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i6/DSxSE8XRNA9H3mcifWxEjXE4etz0JgkSHr/Hsvu8=;
        b=3siHIyl7pYX+ggFKAMvL8uie34WhAw811Gfs+vUBsrqkxnm5SPHa2GpXHes35xh5TK
         AdYCkgg8w4gQGv1hx6lsNrj6py8F6Sn1uvH23SshVUEqhMbtSGXfXiTZMYZKbWKBqHZo
         gimG5W+n7Q7D9bLp7mo3uec40jdLAmq2PWwFHFgHfHIRUO5vR+/hu7bv4Z7/xziPtD+j
         coirFZYo4R4BgjY7dTc5gpsEsi0vYJxUAGb+5ANrdoS3G3c3r1i4JIh6Pv/7azfGah2r
         fpVXwd1UZUN0vZQyLpsrACoF6EEbmu72VN/2kaDf7hO+j+hmae65KE8hp1gn0xwT1XIz
         W44Q==
X-Gm-Message-State: AOAM530ZDqofg0EfHksppNWXglEXp0q0ST84PtOja9Rm/aTu9R1Qt8Qm
        wLP68b9Q9V3vLO9mXBfGrwC7UlFlWhvPZmq0bWNQISoq3ob3gLuM97+wrVZdSOIFJh66UF7tM1k
        TxNoHyZ5tX+WHSPdlKGbkFG/0Ickunr/nJQihT96og3JSKRJzcxsswXxHFYObjFg=
X-Google-Smtp-Source: ABdhPJwfy3gmWJ7JdtmkRn0AuCSDtjwOezz7Gbtxjzc501rgTVDa17RRO9/98Up84GF4UZPXHwMT0oeSl8WGGA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e7cf:b0:1bf:4f60:b191 with SMTP
 id kb15-20020a17090ae7cf00b001bf4f60b191mr270466pjb.0.1646698492370; Mon, 07
 Mar 2022 16:14:52 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:24 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 01/10] t5526: introduce test helper to assert on fetches
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

Tests in t/t5526-fetch-submodules.sh are unnecessarily noisy:

* The tests have extra logic in order to reproduce the expected stderr
  literally, but not all of these details (e.g. the head of the
  remote-tracking branch before the fetch) are relevant to the test.

* The expect.err file is constructed by the add_upstream_commit() helper
  as input into test_cmp, but most tests fetch a different combination
  of repos from expect.err. This results in noisy tests that modify
  parts of that expect.err to generate the expected output.

To address both of these issues, introduce a verify_fetch_result()
helper to t/t5526-fetch-submodules.sh that asserts on the output of "git
fetch --recurse-submodules" and handles the ordering of expect.err.

As a result, the tests no longer construct expect.err manually. Tests
still consider the old head of the remote-tracking branch ("$head1"),
but that will be fixed in a later commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5526-fetch-submodules.sh | 139 ++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 55 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 840c89cc8b..c3a67270b1 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -10,6 +10,10 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
 pwd=$(pwd)
 
+# For each submodule in the test setup, this creates a commit and writes
+# a file that contains the expected err if that new commit were fetched.
+# These output files get concatenated in the right order by
+# verify_fetch_result().
 add_upstream_commit() {
 	(
 		cd submodule &&
@@ -19,9 +23,9 @@ add_upstream_commit() {
 		git add subfile &&
 		git commit -m new subfile &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err &&
-		echo "From $pwd/submodule" >> ../expect.err &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err
+		echo "Fetching submodule submodule" > ../expect.err.sub &&
+		echo "From $pwd/submodule" >> ../expect.err.sub &&
+		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
 	) &&
 	(
 		cd deepsubmodule &&
@@ -31,12 +35,36 @@ add_upstream_commit() {
 		git add deepsubfile &&
 		git commit -m new deepsubfile &&
 		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule/subdir/deepsubmodule" >> ../expect.err
-		echo "From $pwd/deepsubmodule" >> ../expect.err &&
-		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err
+		echo "Fetching submodule submodule/subdir/deepsubmodule" > ../expect.err.deep
+		echo "From $pwd/deepsubmodule" >> ../expect.err.deep &&
+		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err.deep
 	)
 }
 
+# Verifies that the expected repositories were fetched. This is done by
+# concatenating the files expect.err.[super|sub|deep] in the correct
+# order and comparing it to the actual stderr.
+#
+# If a repo should not be fetched in the test, its corresponding
+# expect.err file should be rm-ed.
+verify_fetch_result () {
+	ACTUAL_ERR=$1 &&
+	rm -f expect.err.combined &&
+	if test -f expect.err.super
+	then
+		cat expect.err.super >>expect.err.combined
+	fi &&
+	if test -f expect.err.sub
+	then
+		cat expect.err.sub >>expect.err.combined
+	fi &&
+	if test -f expect.err.deep
+	then
+		cat expect.err.deep >>expect.err.combined
+	fi &&
+	test_cmp expect.err.combined $ACTUAL_ERR
+}
+
 test_expect_success setup '
 	mkdir deepsubmodule &&
 	(
@@ -74,7 +102,7 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "submodule.recurse option triggers recursive fetch" '
@@ -84,7 +112,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 		git -c submodule.recurse fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
@@ -94,7 +122,7 @@ test_expect_success "fetch --recurse-submodules -j2 has the same output behaviou
 		GIT_TRACE="$TRASH_DIRECTORY/trace.out" git fetch --recurse-submodules -j2 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err &&
+	verify_fetch_result actual.err &&
 	grep "2 tasks" trace.out
 '
 
@@ -124,7 +152,7 @@ test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses i
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
@@ -155,7 +183,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--quiet propagates to submodules" '
@@ -183,7 +211,7 @@ test_expect_success "--dry-run propagates to submodules" '
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "Without --dry-run propagates to submodules" '
@@ -192,7 +220,7 @@ test_expect_success "Without --dry-run propagates to submodules" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "recurseSubmodules=true propagates into submodules" '
@@ -203,7 +231,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--recurse-submodules overrides config in submodule" '
@@ -217,7 +245,7 @@ test_expect_success "--recurse-submodules overrides config in submodule" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides config setting" '
@@ -250,14 +278,14 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.sub &&
-	head -3 expect.err >> expect.err.sub &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.err.sub actual.err &&
+	verify_fetch_result actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -268,14 +296,16 @@ test_expect_success "Recursion doesn't happen when new superproject commits don'
 	git add file &&
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.file &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	rm expect.err.sub &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.file actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "Recursion picks up config in submodule" '
@@ -292,9 +322,8 @@ test_expect_success "Recursion picks up config in submodule" '
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.sub &&
-	cat expect.err >> expect.err.sub &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err &&
@@ -303,7 +332,7 @@ test_expect_success "Recursion picks up config in submodule" '
 			git config --unset fetch.recurseSubmodules
 		)
 	) &&
-	test_cmp expect.err.sub actual.err &&
+	verify_fetch_result actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -328,15 +357,13 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.2 &&
-	cat expect.err.sub >> expect.err.2 &&
-	tail -3 expect.err >> expect.err.2 &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
-	test_cmp expect.err.2 actual.err &&
+	verify_fetch_result actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -372,11 +399,8 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	tail -3 expect.err > expect.err.deepsub &&
-	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err &&
-	cat expect.err.sub >> expect.err &&
-	cat expect.err.deepsub >> expect.err &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -392,7 +416,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 		)
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
@@ -402,14 +426,16 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
 	git add file &&
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.file &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	rm expect.err.sub &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.file actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
@@ -423,9 +449,9 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
-	head -3 expect.err >> expect.err.2 &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules on-demand &&
@@ -437,7 +463,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		git config --unset fetch.recurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.2 actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
@@ -451,9 +477,9 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
-	head -3 expect.err >> expect.err.2 &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		git config submodule.submodule.fetchRecurseSubmodules on-demand &&
@@ -465,7 +491,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.2 actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "don't fetch submodule when newly recorded commits are already present" '
@@ -477,14 +503,17 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 	git add submodule &&
 	git commit -m "submodule rewound" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err &&
+	echo "From $pwd/." > expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	rm expect.err.sub &&
+	# This file does not exist, but rm -f for readability
+	rm -f expect.err.deep &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err &&
+	verify_fetch_result actual.err &&
 	(
 		cd submodule &&
 		git checkout -q sub
@@ -502,9 +531,9 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
 	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." >expect.err.2 &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
-	head -3 expect.err >>expect.err.2 &&
+	echo "From $pwd/." >expect.err.super &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	rm expect.err.deep &&
 	(
 		cd downstream &&
 		rm .gitmodules &&
@@ -520,7 +549,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		git reset --hard
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.2 actual.err &&
+	verify_fetch_result actual.err &&
 	git checkout HEAD^ -- .gitmodules &&
 	git add .gitmodules &&
 	git commit -m "new submodule restored .gitmodules"
-- 
2.33.GIT

