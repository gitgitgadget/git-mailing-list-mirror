Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6910AC43461
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD41613D9
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhEHUAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhEHUAP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EE1C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d11so12553969wrw.8
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Ij47Mjwsrw/MbJBXGq1dM35BMyHwa2i9Tp1xlUXtHo=;
        b=Kd3QJcZ9f8Zcr110nOCScqBMtUc2dPaQuJHoMsiDBXJAlOnRWMOOHkwfBeQ86J0+ry
         Yh16+MNdnHtiZvOrvb2QGK1y0U95wryIip3O5CzQITRsK0yUVh3Qe3KudKxwdqSPDDNF
         wTsCP6prX4mIRlXBlyRiMuINvvuMSpKOvtGBSFqN+PLuNSp1WZRHDAjDliIQbarTXgE+
         jTIkUlM5GxG6pbup9tN+I9+B16uM71qzGTwvqmjEgsuU8OQXyGvH34Bhu74tfng4TfxD
         i5BA7+Oh2Mh2tDOHRyMUVwvQ7rH6FYT5YvWWDLRrcXfyGPrcdHc7j9/muD7yVGx3wWJl
         j/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Ij47Mjwsrw/MbJBXGq1dM35BMyHwa2i9Tp1xlUXtHo=;
        b=aRaaflDrHxY/rSpMuzOIDujXYKEgRhM5u5q/Uz+kfk+k8hz3cyu9XiCVGLI8bFYkmU
         uQtK/JHvGaT4X0WScVo1B8YugLjYRS2MiZfODoDBRYkVz4NU3FC1Dde0sdTIsvsIyLVX
         bqCc+3Jq4vJQ5wdPvTa8BRzvaVhjo1/zDVykAhyZIZwjYGzRwV1rVIa9N2LxjbXvMDz3
         aAdJaOszeOfFin9SlpJsU6A7RHZoNc178cqD8sMu9fAMrkKR/gzdUsCzYltPUmxp1ClY
         j7hUBfNQdVf7inwxv5yLYRMKw5rkQT/ayhBLEsYfELrYIwXs0P5z2PlM6bzzzBotuH/u
         k3ag==
X-Gm-Message-State: AOAM531+7fdW2rVX+w81Kdawz3dH4Q+tLJa0aMu/PwsuH2A9fb5epFko
        SqMfldXPn9aPDeSFKgLT9gX7Xjeh26M=
X-Google-Smtp-Source: ABdhPJzEhgUcMsZuVLN3Bb+zRhU54XxoymfdXkRIzCYJbgKXcpQ4xFvxJORSZvFp/pjXvhBrBV7E2Q==
X-Received: by 2002:adf:f251:: with SMTP id b17mr20729836wrp.410.1620503952294;
        Sat, 08 May 2021 12:59:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13sm15659739wrt.65.2021.05.08.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:12 -0700 (PDT)
Message-Id: <acde436b220e9bc9d1e1f3ae499331297ceb721e.1620503946.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:59:03 +0000
Subject: [PATCH v3 7/8] dir: traverse into untracked directories if they may
 have ignored subfiles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A directory that is untracked does not imply that all files under it
should be categorized as untracked; in particular, if the caller is
interested in ignored files, many files or directories underneath the
untracked directory may be ignored.  We previously partially handled
this right with DIR_SHOW_IGNORED_TOO, but missed DIR_SHOW_IGNORED.  It
was not obvious, though, because the logic for untracked and excluded
files had been fused together making it harder to reason about.  The
previous commit split that logic out, making it easier to notice that
DIR_SHOW_IGNORED was missing.  Add it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                              | 10 ++++++----
 t/t3001-ls-files-others-exclude.sh |  2 +-
 t/t7300-clean.sh                   |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 3f2cfef2c2bb..f5d9732d9e68 100644
--- a/dir.c
+++ b/dir.c
@@ -1877,15 +1877,17 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 	/*
 	 * Other than the path_recurse case above, we only need to
-	 * recurse into untracked directories if either of the following
+	 * recurse into untracked directories if any of the following
 	 * bits is set:
-	 *   - DIR_SHOW_IGNORED_TOO (because then we need to determine if
-	 *                           there are ignored entries below)
+	 *   - DIR_SHOW_IGNORED (because then we need to determine if
+	 *                       there are ignored entries below)
+	 *   - DIR_SHOW_IGNORED_TOO (same as above)
 	 *   - DIR_HIDE_EMPTY_DIRECTORIES (because we have to determine if
 	 *                                 the directory is empty)
 	 */
 	if (!excluded &&
-	    !(dir->flags & (DIR_SHOW_IGNORED_TOO |
+	    !(dir->flags & (DIR_SHOW_IGNORED |
+			    DIR_SHOW_IGNORED_TOO |
 			    DIR_HIDE_EMPTY_DIRECTORIES))) {
 		return path_untracked;
 	}
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index ac05d1a17931..516c95ea0e82 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -292,7 +292,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure 'ls-files with "**" patterns and --directory' '
+test_expect_success 'ls-files with "**" patterns and --directory' '
 	# Expectation same as previous test
 	git ls-files --directory -o -i --exclude "**/a.1" >actual &&
 	test_cmp expect actual
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index a1d695ee9fe9..751764c0f1ae 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -768,7 +768,7 @@ test_expect_success 'avoid traversing into ignored directories' '
 	test_cmp trace.expect trace.relevant
 '
 
-test_expect_failure 'traverse into directories that may have ignored entries' '
+test_expect_success 'traverse into directories that may have ignored entries' '
 	test_when_finished rm -f output &&
 	test_create_repo need-to-traverse-into-hierarchy &&
 	(
-- 
gitgitgadget

