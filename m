Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F361EC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DCA21D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkgESMl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbgJWQBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460371AbgJWQBj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264C7C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so2463680wrm.13
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HaRwDLTydUy7FLPVpRuFefJ2uY7gfvz15ejRfMX1vHE=;
        b=UkgESMl5nBHqaF8zBv8Qv5DhTUmaj/5cdrrpF2Hf60aWfmdoKvJTGNulSZCjBku5Ym
         ubO8VkWKaQGQmmzIccjzTJjLYP0AcAilMr/5aTPTAvN/VewwtM/NYNrqeM4m3F2CZD1c
         LiHtLKhGvrTSMNNROK4qdBLwKXm6ynkXanF5F4RLDePw4nMZhuiRDDtD2jE/zFL0rIPs
         TWAAqR+muNfjU4Rj6nwLt0cstFrZUKFAkG8pwxTmt0RxVd/Kt3CmJeFSk9R0mVRaxZ4g
         wHHxu4yguQzYCfbfSS0YNLLsKwt9QYfevuTKvYzOfdoeRTjJ6zqu/oBlnRJD/QJk8x2g
         AfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HaRwDLTydUy7FLPVpRuFefJ2uY7gfvz15ejRfMX1vHE=;
        b=Tm8TjjqVYxqY6bWMWqi0N4o4wVn7x48oQKCYAj3W9UVi6QMiDsvC6NnOepewzbkObF
         yofG0KW3YAMEnfB/dlEiX1/zTsNEqIVEVYTl5mnGdLrSr7x3F3c+JPbRLdRQsR2aYQ3Y
         Kj0XPyrHwy57Z4qlZDgCMO6L8w8tOVJeqe9LM3Ixv97/a1VQ49GiIkN0ja4I+pE80zU2
         U/YK27H4SIzQUfJViZU3R6nM2JeGH3h3kg1eTh6X18QarhdrLSXCidZDeDh6/CkASQHb
         kTbRKsOawUivehqaU0RwtR5CclyE8AbWEGUs/f5dZH9tX5CztpF6mwanzqe70zzFjFvN
         BiVw==
X-Gm-Message-State: AOAM5324fYqNB01dOa6yz4peOHrazm9Lz9MBWsYlCw1v+QZ2y9G+rw5m
        hFpLUtyhckgM8Dtjjrg+wWUz7/VsIk0=
X-Google-Smtp-Source: ABdhPJzB1lqKPxF9X2Ke/3AorrljGhX8V0KM7w+IYWj32BY3WAqM1E8bs3r+MUILNGEY1cGRZMfH9Q==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr3358506wru.307.1603468896649;
        Fri, 23 Oct 2020 09:01:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm4513548wrg.4.2020.10.23.09.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:36 -0700 (PDT)
Message-Id: <2aa44c1f13ac1fd70167770f7749611eadc396d4.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.git.1603468885.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:21 +0000
Subject: [PATCH 6/9] merge tests: expect slight differences in output for
 recursive vs. ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The ort merge strategy has some slight differences in commit
descriptions (shortened hashes), stdout vs stderr, and in conflict
messages.  Also, builtin/merge.c reports usage of "ort" as "Merge made
by the 'ort' strategy" -- while it is meant as a drop in replacement for
"recursive" it is not yet treated as though it is recursive.  Update the
testcases to expect different output for the different merge backends.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6402-merge-rename.sh       | 14 ++++++++++++--
 t/t6437-submodule-merge.sh    | 25 +++++++++++++++++++++----
 t/t7602-merge-octopus-many.sh |  4 ++++
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 47d4434d64..3f64f62224 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -320,7 +320,12 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 
 	test_i18ngrep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	test_i18ngrep "Auto-merging dir" output &&
-	test_i18ngrep "Adding as dir~HEAD instead" output &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_i18ngrep "moving it to dir~HEAD instead" output
+	else
+		test_i18ngrep "Adding as dir~HEAD instead" output
+	fi &&
 
 	test 3 -eq "$(git ls-files -u | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
@@ -342,7 +347,12 @@ test_expect_success 'Same as previous, but merged other way' '
 	! grep "error: refusing to lose untracked file at" errors &&
 	test_i18ngrep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	test_i18ngrep "Auto-merging dir" output &&
-	test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_i18ngrep "moving it to dir~renamed-file-has-no-conflicts instead" output
+	else
+		test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output
+	fi &&
 
 	test 3 -eq "$(git ls-files -u | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 6a1e5f8232..3ead2b726f 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -127,7 +127,12 @@ test_expect_success 'merging should conflict for non fast-forward' '
 	 git checkout -b test-nonforward b &&
 	 (cd sub &&
 	  git rev-parse sub-d > ../expect) &&
-	 test_must_fail git merge c 2> actual  &&
+	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	  then
+		test_must_fail git merge c >actual
+	  else
+		test_must_fail git merge c 2> actual
+	  fi &&
 	 grep $(cat expect) actual > /dev/null &&
 	 git reset --hard)
 '
@@ -138,9 +143,21 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	(cd sub &&
 	 git checkout -b ambiguous sub-b &&
 	 git merge sub-c &&
-	 git rev-parse sub-d > ../expect1 &&
-	 git rev-parse ambiguous > ../expect2) &&
-	test_must_fail git merge c 2> actual &&
+	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	 then
+		git rev-parse --short sub-d >../expect1 &&
+		git rev-parse --short ambiguous >../expect2
+	 else
+		git rev-parse sub-d > ../expect1 &&
+		git rev-parse ambiguous > ../expect2
+	 fi
+	 ) &&
+	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	 then
+		test_must_fail git merge c >actual
+	 else
+		test_must_fail git merge c 2> actual
+	 fi &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
 	git reset --hard)
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 6abe441ae3..b205b5619e 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -77,6 +77,10 @@ Merge made by the 'recursive' strategy.
 EOF
 
 test_expect_success 'merge reduces irrelevant remote heads' '
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		sed -i'' s/recursive/ort/ expected
+	fi &&
 	GIT_MERGE_VERBOSITY=0 git merge c4 c5 >actual &&
 	test_i18ncmp expected actual
 '
-- 
gitgitgadget

