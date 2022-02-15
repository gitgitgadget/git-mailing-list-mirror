Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E85C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbiBORYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbiBORYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:24:02 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BDCDA85E
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:52 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id gj12-20020a17090b108c00b001b89b5f3dd4so2894544pjb.6
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aYnNqElXZZv/TrOWzr/fEOBK7uQ0ce/iC+53j9ReqQw=;
        b=WtoqbW6v20058XfIOJ7oKCMUwiMPMuC9mVPNfKiqw8TK/6yx+GdOeerlENFEYz73UE
         GoAWONb7GwVU3v4IaiE8x+Us1OhEqVByvDD3Z9j6h2A3NOv2kPg5mMpIL32qh1M1HzFS
         lQoFsQrMVRCAaCQANNYpN4VnB5jcDXhhruGYS/J3tuOzmirDsNTJlsbFnv5vyjFLE7jE
         L6CSDqMVkppqfpDPbPjctsi75nlSNqIeOGyCD56FGzwknQeggfj1cw/rTAv63SaLmGxF
         VwRZwMj9ehsXGqMTRETDO03ZWTGCiNq6rUNAS916IwQOcntoyN4jXWEc5EfMG3zkLNAv
         gxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aYnNqElXZZv/TrOWzr/fEOBK7uQ0ce/iC+53j9ReqQw=;
        b=BmpqERnRXzpRLlgrKRN3LSOBDg1eHj+fhIUX9buP6/8RDxgVoW904TrNpwArcKESf7
         dGXsq+JYBMMLUUHmqGVcOCrAdMjLihaTTIF3Azz7uMBs9IDSPTSL/RXMgmJXe4Ttrwbf
         i5qHIszqENiLMkhMndtgg4UfK6nr2wSd1zOBLfRGf89iiOYEjLuZ8lpakSkT2LypqXNV
         AQaGlI714tWCq10F8Ziy7ICqZZm1QO2hWiOWXjS4qt6or8bDfnjtHuGJeOWaCBXl4Biy
         d+ESZy1tGmA97NthLBTOMKAH0lVYg3Rfh1FhPn8ltP2Eh4K4iLj0oWkl/XDd/HdB//lq
         T/LA==
X-Gm-Message-State: AOAM533xqNNqztfd7C3+OD2qTTesI9hMpzKIJSJeHdsp0me08+ev9Q1K
        x6YLTeolhAP3f9rQaW6Df2o8UpJ17G/MMtYCCGCUfVu3BVDskwIgLpEmSIdsDsPH77Ec+EKmcd8
        FfS6Wt13mx9HPDBKwd+IDtQNwqvVEg/CHpI4ke4Jlw7Y/C4DZyEw18zbf0O+/YNo=
X-Google-Smtp-Source: ABdhPJx5aI7zZbj6aSVvgKhoKTG2o9ZFZyr2IWFQSrj416LMPfCvWacWfUyKDLV0lLpsFUKiS0q3wbG6VrePOA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2449:: with SMTP id
 d9mr2170129pfj.70.1644945831608; Tue, 15 Feb 2022 09:23:51 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:11 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220215172318.73533-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 2/9] t5526: use grep to assert on fetches
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous commit, we replaced test_cmp invocations with
verify_fetch_result(). Finish the process of removing test_cmp by using
grep in verify_fetch_result() instead.

This makes the tests less sensitive to changes because, instead of
checking the whole stderr, we only grep for the lines of the form

* "<old-head>..<new-head>\s+branch\s+-> origin/branch"
* "Fetching submodule <submodule-path>" (if fetching a submodule)

when we expect the repo to have fetched. If we expect the repo to not
have fetched, grep to make sure the lines are absent. Also, simplify the
assertions by using grep patterns that match only the relevant pieces of
information, e.g. <old-head> is irrelevant because we only want to know
if the fetch was performed, so we don't need to know where the branch
was before the fetch.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t5526-fetch-submodules.sh | 131 +++++++++++++-----------------------
 1 file changed, 48 insertions(+), 83 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 0e93df1665..cb18f0ac21 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -20,49 +20,52 @@ pwd=$(pwd)
 add_upstream_commit() {
 	(
 		cd submodule &&
-		head1=$(git rev-parse --short HEAD) &&
 		echo new >> subfile &&
 		test_tick &&
 		git add subfile &&
 		git commit -m new subfile &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		git rev-parse --short HEAD >../subhead
 	) &&
 	(
 		cd deepsubmodule &&
-		head1=$(git rev-parse --short HEAD) &&
 		echo new >> deepsubfile &&
 		test_tick &&
 		git add deepsubfile &&
 		git commit -m new deepsubfile &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule/subdir/deepsubmodule" > ../expect.err.deep
-		echo "From $pwd/deepsubmodule" >> ../expect.err.deep &&
-		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err.deep
+		git rev-parse --short HEAD >../deephead
 	)
 }
 
 # Verifies that the expected repositories were fetched. This is done by
-# concatenating the files expect.err.[super|sub|deep] in the correct
-# order and comparing it to the actual stderr.
+# checking that the branches of [super|sub|deep] were updated to
+# [super|sub|deep]head if the corresponding file exists.
 #
-# If a repo should not be fetched in the test, its corresponding
-# expect.err file should be rm-ed.
+# If the [super|sub|deep] head file does not exist, this verifies that
+# the corresponding repo was not fetched. Thus, if a repo should not be
+# fetched in the test, its corresponding head file should be
+# rm-ed.
 verify_fetch_result() {
 	ACTUAL_ERR=$1 &&
-	rm -f expect.err.combined &&
-	if [ -f expect.err.super ]; then
-		cat expect.err.super >>expect.err.combined
+	# Each grep pattern is guaranteed to match the correct repo
+	# because each repo uses a different name for their branch i.e.
+	# "super", "sub" and "deep".
+	if [ -f superhead ]; then
+		grep -E "\.\.$(cat superhead)\s+super\s+-> origin/super" $ACTUAL_ERR
+	else
+		! grep "super" $ACTUAL_ERR
 	fi &&
-	if [ -f expect.err.sub ]; then
-		cat expect.err.sub >>expect.err.combined
+	if [ -f subhead ]; then
+		grep "Fetching submodule submodule" $ACTUAL_ERR &&
+		grep -E "\.\.$(cat subhead)\s+sub\s+-> origin/sub" $ACTUAL_ERR
+	else
+		! grep "Fetching submodule submodule" $ACTUAL_ERR
 	fi &&
-	if [ -f expect.err.deep ]; then
-		cat expect.err.deep >>expect.err.combined
-	fi &&
-	test_cmp expect.err.combined $ACTUAL_ERR
+	if [ -f deephead ]; then
+		grep "Fetching submodule submodule/subdir/deepsubmodule" $ACTUAL_ERR &&
+		grep -E "\.\.$(cat deephead)\s+deep\s+-> origin/deep" $ACTUAL_ERR
+	else
+		! grep "Fetching submodule submodule/subdir/deepsubmodule" $ACTUAL_ERR
+	fi
 }
 
 test_expect_success setup '
@@ -274,13 +277,10 @@ test_expect_success "Recursion doesn't happen when no new commits are fetched in
 '
 
 test_expect_success "Recursion stops when no new submodule commits are fetched" '
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
-	rm expect.err.deep &&
+	git rev-parse --short HEAD >superhead &&
+	rm deephead &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -291,15 +291,12 @@ test_expect_success "Recursion stops when no new submodule commits are fetched"
 
 test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	echo a > file &&
 	git add file &&
 	git commit -m "new file" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
-	rm expect.err.sub &&
-	rm expect.err.deep &&
+	git rev-parse --short HEAD >superhead &&
+	rm subhead &&
+	rm deephead &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -318,12 +315,9 @@ test_expect_success "Recursion picks up config in submodule" '
 		)
 	) &&
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	git rev-parse --short HEAD >superhead &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err &&
@@ -345,20 +339,13 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
-		head1=$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo "Fetching submodule submodule" > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		git rev-parse --short HEAD >../subhead
 	) &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
+	git rev-parse --short HEAD >superhead &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -376,13 +363,9 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 			git fetch &&
 			git checkout -q FETCH_HEAD
 		) &&
-		head1=$(git rev-parse --short HEAD^) &&
 		git add subdir/deepsubmodule &&
 		git commit -m "new deepsubmodule" &&
-		head2=$(git rev-parse --short HEAD) &&
-		echo Fetching submodule submodule > ../expect.err.sub &&
-		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
+		git rev-parse --short HEAD >../subhead
 	) &&
 	(
 		cd downstream &&
@@ -395,12 +378,9 @@ test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
 '
 
 test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
+	git rev-parse --short HEAD >superhead &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules false &&
@@ -421,15 +401,12 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	echo a >> file &&
 	git add file &&
 	git commit -m "new file" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
-	rm expect.err.sub &&
-	rm expect.err.deep &&
+	git rev-parse --short HEAD >superhead &&
+	rm subhead &&
+	rm deephead &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
@@ -445,13 +422,10 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	) &&
 	add_upstream_commit &&
 	git config --global fetch.recurseSubmodules false &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
-	rm expect.err.deep &&
+	git rev-parse --short HEAD >superhead &&
+	rm deephead &&
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules on-demand &&
@@ -473,13 +447,10 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	) &&
 	add_upstream_commit &&
 	git config fetch.recurseSubmodules false &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
-	rm expect.err.deep &&
+	git rev-parse --short HEAD >superhead &&
+	rm deephead &&
 	(
 		cd downstream &&
 		git config submodule.submodule.fetchRecurseSubmodules on-demand &&
@@ -499,15 +470,12 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
 		cd submodule &&
 		git checkout -q HEAD^^
 	) &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "submodule rewound" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." > expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
-	rm expect.err.sub &&
+	git rev-parse --short HEAD >superhead &&
+	rm subhead &&
 	# This file does not exist, but rm -f for readability
-	rm -f expect.err.deep &&
+	rm -f deephead &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -526,14 +494,11 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		git fetch --recurse-submodules
 	) &&
 	add_upstream_commit &&
-	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git rm .gitmodules &&
 	git commit -m "new submodule without .gitmodules" &&
-	head2=$(git rev-parse --short HEAD) &&
-	echo "From $pwd/." >expect.err.super &&
-	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
-	rm expect.err.deep &&
+	git rev-parse --short HEAD >superhead &&
+	rm deephead &&
 	(
 		cd downstream &&
 		rm .gitmodules &&
-- 
2.33.GIT

