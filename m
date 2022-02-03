Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0DC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355615AbiBCV71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiBCV7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:59:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6799C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:59:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u11-20020a25ab0b000000b0061a3e951dceso8741055ybi.15
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=so/6OrSdbV/cyutuX/kcHN5Omtld7AewWEJGXcwjGrU=;
        b=cfqGqJJ8JlPP82+Yi7BqYTQjmD3u1VrlWdk8HRO79WHLVtQ9PWe3WoQFb5djXnXnd1
         /7a50edj4PfAnJRrfFtMqzROyBB1ISNL0lXLVlf/vGMHS5GpFKiUf+AVHJO01rn2YSKI
         8ukNeR/EWgFIotsb5rt+sxBJey0BoUkVFIpjaxzByemxzA1cKPJMVAbSL7vOzUMy6t7V
         O1x/EZWXO0kQcqnVp3kt75MSLTQneKxMd8sXyI1hSQNmpS7WHTPh8DgIJNTklyOJqWS4
         ShfFFv9rhHFQCleTwDc2R1KxISfoh2GpCbiOWXxkNDLrJMid3jX0ipXGHenF2xPCE7ND
         UdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=so/6OrSdbV/cyutuX/kcHN5Omtld7AewWEJGXcwjGrU=;
        b=2Cq80VXMWTYhKWtdzfBh2bKf0EvuTjf/b/5321Qi2i4P0CH1GM4Ipg1MiGVPg4bKpz
         JOiJ+UJ3Z9Gf0e4o5/VUTFW1Wz/y4u5p6pmIVTUGBqjW7iAiw4dKU5+YtE0MElRXYAMs
         NBNDk5PpuwVUCFSJSLEerWVqZvzgiVHAYElnq5ub0B8tqi9TZbPYyFZA/CRAIYNlNgk1
         VrFI4B2tOKcvsnmH74q/IUVazR8sshhXK48oSUAx3n2rA2LyMMLodVedX+l4W6CuYFzd
         c5TkoF8+AUlJPG+PpZ9XIqmdqg/nlB7r/OVRvlbJ/DodHY8Hh1B+55ARGOcnIhYdS84F
         mLKQ==
X-Gm-Message-State: AOAM5330rY9nukeiIM8Ow9vHtXJh3jfb5IXWhVGQtp1yWmmtIHNbObIR
        sKHDvCBsGfrMww49DWsoTJqfYTBQDmaD7kdNskSqK7AXiQwjhviadJKatNME+XfIDKl9LXlLJjq
        RwE24Oh4dmNRgRYFiO6n16T1AURPKqo7a31JzIWe5+C88wecar1IhvlcnB3zD2Xnu9E4JB1975w
        ==
X-Google-Smtp-Source: ABdhPJziXKpNbvKOc3MW7H+xIFmeD7Rec2KwenzGwS6CZVsixWelOOQevOwazapJOqXBxedvS6kxDeGDGhjFYBvhpWc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:662:cd2f:9dc:846b])
 (user=emilyshaffer job=sendgmr) by 2002:a25:783:: with SMTP id
 125mr219789ybh.58.1643925562931; Thu, 03 Feb 2022 13:59:22 -0800 (PST)
Date:   Thu,  3 Feb 2022 13:59:11 -0800
In-Reply-To: <20220203215914.683922-1-emilyshaffer@google.com>
Message-Id: <20220203215914.683922-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 1/4] t7400-submodule-basic: modernize inspect() helper
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
2.35.0.263.gb82422642f-goog

