Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A627C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiCJApe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbiCJApd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:45:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B93ECB0D
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:44:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dbf4238d6bso28262237b3.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 16:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bozg4nijLiLzecdCqf0knhUu2/KxfG61cwbxJu4hPRc=;
        b=YbwJunigJHaUho1j7dHn5JB2oT+UOtwMl0v/wa3C4GbSLO7pt0h8RCQyWVNbxkblpI
         qH+z5TsgQmW+Os772wsbIPno1bLhL5mdWQPr9aU+LEZsHR/087V0MmN6cmUA/qN6JH1l
         kbCULs/6Kxt1FtOrlim5ceTzxU/EvhIhMOHRnKYTPgVRNgsLkxFDOd0SHDe61FqunGF5
         dUMQ4Zyyo4w6k9ADr6eskls/OkMA5mw3gH9RAQ3gMZYDDCPu60b8G1jDEKOlr4CFDR+W
         01qOzoeLrLgmNaFpgtsA+wVvdYLC5wDqJeXUNGcAlv04gCvzhHwhSlAA9ctCGTgg1ER2
         Rd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bozg4nijLiLzecdCqf0knhUu2/KxfG61cwbxJu4hPRc=;
        b=FzGg8SjPxdJmejzSQBuMZvGaPSJG+/HmDm6SDF9Xj8zQXdTlkyRQynQjDf4LMJudc/
         +sqcgAtbShCBOGzPb5CGTsfYgK1Z4EsWrD1Dxpq04yD5QdrWS1OMOOPARZJFcBytM72P
         vF58L/XfW5S8ZmuUlppg6eeh/G5Hxm8MN2m1yI5PvjMixC4AcuXGyChzfcxBNzeDeD3s
         v+YQf55sWG327+Wqq8dbMu9EXv/swERG3muxF2MD8IGWCE6/aLbt0vLTOf7O/DNNaQRZ
         5cNijjxa0ZEk0gW8B8cnf8seGxBgIBkMRwkTtA/XvDQ4mCkkojvF8Un+VszT5ADLxLo8
         wtpw==
X-Gm-Message-State: AOAM530UGEBnTvyjMKGHs2KtmwAiPyxd7ipgvUgQWgqFkaCAwsa170Tl
        iDJTBAqLZThlEnrQBEPi+5Bdab1dH+y2DVHYWpu/cM3bsRSkaD97L3APaaxK8gVHMO/r9w3SoFB
        d/q2O5vq2bpMbzp1VIH6dGI+weo3RUs2QSIwZ/tjydDj5Cl9GDZKJ6DeycGDsbe2HMTBa314oEQ
        ==
X-Google-Smtp-Source: ABdhPJxe/9kVkgTpaD5Zo5wyrqeTRkz3uRkFEo7u5+OV3P+DGnpJ07TP2omA/OCgdtr59Z2jmboKyHo32XjTw2sEonQ=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e0ed:468:c28b:9b23])
 (user=emilyshaffer job=sendgmr) by 2002:a25:8187:0:b0:628:944c:e2cb with SMTP
 id p7-20020a258187000000b00628944ce2cbmr1990088ybk.19.1646873072549; Wed, 09
 Mar 2022 16:44:32 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:44:21 -0800
In-Reply-To: <20220310004423.2627181-1-emilyshaffer@google.com>
Message-Id: <20220310004423.2627181-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v9 1/3] t7400-submodule-basic: modernize inspect() helper
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the inspect() helper in the submodule-basic test suite was
written, 'git -C <dir>' was added. By using -C, we no longer need a
reference to the base directory for the test. This simplifies callsites,
and will make the addition of other arguments in later patches more
readable.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t7400-submodule-basic.sh | 40 +++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e7cec2e457..40cf8d89aa 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -107,23 +107,15 @@ test_expect_success 'setup - repository to add submodules to' '
 # generates, which will expand symbolic links.
 submodurl=$(pwd -P)
 
-listbranches() {
-	git for-each-ref --format='%(refname)' 'refs/heads/*'
-}
-
 inspect() {
-	dir=$1 &&
-	dotdot="${2:-..}" &&
-
-	(
-		cd "$dir" &&
-		listbranches >"$dotdot/heads" &&
-		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
-		git rev-parse HEAD >"$dotdot/head-sha1" &&
-		git update-index --refresh &&
-		git diff-files --exit-code &&
-		git clean -n -d -x >"$dotdot/untracked"
-	)
+	sub_dir=$1 &&
+
+	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
+	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
+	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
+	git -C "$sub_dir" update-index --refresh &&
+	git -C "$sub_dir" diff-files --exit-code &&
+	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
 test_expect_success 'submodule add' '
@@ -146,7 +138,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod ../.. &&
+	inspect addtest/submod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -248,7 +240,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch ../.. &&
+	inspect addtest/submod-branch &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -264,7 +256,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz ../../.. &&
+	inspect addtest/dotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -280,7 +272,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
+	inspect addtest/dotslashdotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -296,7 +288,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz ../../.. &&
+	inspect addtest/slashslashsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -312,7 +304,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod ../.. &&
+	inspect addtest/realsubmod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -328,7 +320,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 ../.. &&
+	inspect addtest/realsubmod2 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -359,7 +351,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 ../.. &&
+	inspect addtest/realsubmod3 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
-- 
2.35.1.616.g0bdcbb4464-goog

