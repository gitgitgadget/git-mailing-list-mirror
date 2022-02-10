Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F90C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiBJEmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:42:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiBJEmE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:42:04 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C5D1AB
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:42:05 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id n21-20020a628f15000000b004e05a90ebfdso2168214pfd.8
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=66KfgZMamYnH+VV69MTVJzWXHjEOzcYsC2QaLw8JH38=;
        b=l5XB7QCuSSqXoEPsznR052RltZWYVI6owNo5KVUMF99i4396uOek6QgBuDHbmrA//P
         f9lt6V+IdNqtExM5f68rJkC4y8js9WNVFzBlgp1rf16qAX6dwUtOTL0QU71NQy5jtvJs
         QNCar94kCu7UnmrG4vzXZG2ApFBwdsYYy62XHcqeiPhmMe+k+zSvA1J+JX4Ofjj4HDGR
         37I0vcbT9dV8eqPew8nqgEHFIk9HEtIrJg49do3ryigUs/9EH4m9lxSk22g10z5Z0b50
         zLKs435RPdV/QLDDfWMhSBlQ1W1QdB+luXTkJ3gtLWldtpdp1Yox/Af75K0KgorO51He
         lf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=66KfgZMamYnH+VV69MTVJzWXHjEOzcYsC2QaLw8JH38=;
        b=5eTudysO75ZDZh2zvrVcUXQL7tbHCRiOQWBG4vSA3wcwT674fUA1zcp2kdaNGLsOvZ
         3o6TS2CQluSaZUX/EwqKrrKOfd9nRmO0oh6CF9EcPPJNIYMuh1MjvpsYg8B7yrwl228E
         Ub0EMTQzizXuJ3oK4evkiTFgNbclCJA48msu+ZsHEuzLi5oGSWyxk+o1bByGLoxTsnsJ
         JnNB5WeZwNQLb1g0vXjntupoiXVNHN72r0Bgg78Oj8vt6mQ+oY4kuCeKr5OeGpOnh81+
         Sp1Aay2znXMhs8Eqf3as1uxX+JO8pdIn78iW067xKOB24QHd2OMnxD67/Ei0evy2xayA
         2Rmg==
X-Gm-Message-State: AOAM5302J1iOUUvAVsOim3E0eHloQhAiFGrQz82D4xIcX3hWUllEX0r1
        cwIh21RVGxUQzrj/v5UJq5Wo42rdEN6EGpX9Or7l7TuwRL5I0wKPxPIeLGZ8gfL+VvpY4p+KbiX
        RgGKQ8wBExkeOKZc6llb6aCVjtJ1STAt4dWFrhmpUDoKmyTlnveNoRwRehy5Ak8c=
X-Google-Smtp-Source: ABdhPJzaaItFKOWYKK+vy8e6MztAMVBXOlXLhSvxPAtaJq2IKFWplfKFmC0UF0AC0Iz1nIPFOW0zPjC7A0Dj0Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4c8e:: with SMTP id
 my14mr214617pjb.0.1644468124170; Wed, 09 Feb 2022 20:42:04 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:41:48 +0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com>
Message-Id: <20220210044152.78352-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 4/8] t5526: introduce test helper to assert on fetches
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future commit will change the stderr of "git fetch
--recurse-submodules" and add new tests to t/t5526-fetch-submodules.sh.
This poses two challenges:

* The tests use test_cmp to assert on the stderr, which will fail on the
  future test because the stderr changes slightly, even though it still
  contains the information we expect.
* The expect.err file is constructed by the add_upstream_commit() helper
  as input into test_cmp, but most tests fetch a different combination
  of repos from expect.err. This results in noisy tests that modify
  parts of that expect.err to generate the expected output.

To address both of these issues, introduce a verify_fetch_result()
helper to t/t5526-fetch-submodules.sh that asserts on the output of "git
fetch --recurse-submodules" and handles the ordering of expect.err.

As a result, the tests no longer construct expect.err manually. test_cmp
is still invoked by verify_fetch_result(), but that will be replaced in
a later commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5526-fetch-submodules.sh | 136 +++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 55 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 2dc75b80db..0e93df1665 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -13,6 +13,10 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
 pwd=$(pwd)
 
+# For each submodule in the test setup, this creates a commit and writes
+# a file that contains the expected err if that new commit were fetched.
+# These output files get concatenated in the right order by
+# verify_fetch_result().
 add_upstream_commit() {
 	(
 		cd submodule &&
@@ -22,9 +26,9 @@ add_upstream_commit() {
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
@@ -34,12 +38,33 @@ add_upstream_commit() {
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
+verify_fetch_result() {
+	ACTUAL_ERR=$1 &&
+	rm -f expect.err.combined &&
+	if [ -f expect.err.super ]; then
+		cat expect.err.super >>expect.err.combined
+	fi &&
+	if [ -f expect.err.sub ]; then
+		cat expect.err.sub >>expect.err.combined
+	fi &&
+	if [ -f expect.err.deep ]; then
+		cat expect.err.deep >>expect.err.combined
+	fi &&
+	test_cmp expect.err.combined $ACTUAL_ERR
+}
+
 test_expect_success setup '
 	mkdir deepsubmodule &&
 	(
@@ -77,7 +102,7 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "submodule.recurse option triggers recursive fetch" '
@@ -87,7 +112,7 @@ test_expect_success "submodule.recurse option triggers recursive fetch" '
 		git -c submodule.recurse fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
@@ -97,7 +122,7 @@ test_expect_success "fetch --recurse-submodules -j2 has the same output behaviou
 		GIT_TRACE="$TRASH_DIRECTORY/trace.out" git fetch --recurse-submodules -j2 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err &&
+	verify_fetch_result actual.err &&
 	grep "2 tasks" trace.out
 '
 
@@ -127,7 +152,7 @@ test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses i
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
@@ -158,7 +183,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--quiet propagates to submodules" '
@@ -186,7 +211,7 @@ test_expect_success "--dry-run propagates to submodules" '
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "Without --dry-run propagates to submodules" '
@@ -195,7 +220,7 @@ test_expect_success "Without --dry-run propagates to submodules" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "recurseSubmodules=true propagates into submodules" '
@@ -206,7 +231,7 @@ test_expect_success "recurseSubmodules=true propagates into submodules" '
 		git fetch >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--recurse-submodules overrides config in submodule" '
@@ -220,7 +245,7 @@ test_expect_success "--recurse-submodules overrides config in submodule" '
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "--no-recurse-submodules overrides config setting" '
@@ -253,14 +278,14 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
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
 
@@ -271,14 +296,16 @@ test_expect_success "Recursion doesn't happen when new superproject commits don'
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
@@ -295,9 +322,8 @@ test_expect_success "Recursion picks up config in submodule" '
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
@@ -306,7 +332,7 @@ test_expect_success "Recursion picks up config in submodule" '
 			git config --unset fetch.recurseSubmodules
 		)
 	) &&
-	test_cmp expect.err.sub actual.err &&
+	verify_fetch_result actual.err &&
 	test_must_be_empty actual.out
 '
 
@@ -331,15 +357,13 @@ test_expect_success "Recursion picks up all submodules when necessary" '
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
 
@@ -375,11 +399,8 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
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
@@ -395,7 +416,7 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 		)
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
@@ -405,14 +426,16 @@ test_expect_success "'--recurse-submodules=on-demand' stops when no new submodul
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
@@ -426,9 +449,9 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
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
@@ -440,7 +463,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		git config --unset fetch.recurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.2 actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
@@ -454,9 +477,9 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
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
@@ -468,7 +491,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
-	test_cmp expect.err.2 actual.err
+	verify_fetch_result actual.err
 '
 
 test_expect_success "don't fetch submodule when newly recorded commits are already present" '
@@ -480,14 +503,17 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
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
@@ -505,9 +531,9 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
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
@@ -523,7 +549,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
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

