Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1451AC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1DB6190A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhEKSf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhEKSfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:35:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CBC06174A
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso118244wmh.0
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JYOIWhcU1wWE09XHgXzMLhLiGJ0m9k3vSdMWS9bT/FQ=;
        b=gHIwZIiorzYLKqTVVOuPU8z7x58fs86myfIsBRiW/PHUc5uuwK7YdAqcf0Lz0v2H7l
         3lmgO1GyMVXXhrey3557XeWUTEDgknQO8ESaTSjABXVzHP4kyrk+ZGevnBiFmIpttO2j
         D1tV84gS/+BgbV2+72/mJ6rrSv2hewMvBj0V85L/sDp5NbOs2tFu0+ih77OTNd+8iXjh
         7c9XQ5mx6ohKq7wzM+/487I6SmBs7Zo3W+J17n+zZBNIuJH5+G53XNp7xbGTeylBySNd
         69MvIQTPZYH4bwLjce5qsj7WFwLJlVmxOBgP8PMlgmDF5dt1AHf4QvxCaZC4IUywOlU2
         hckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JYOIWhcU1wWE09XHgXzMLhLiGJ0m9k3vSdMWS9bT/FQ=;
        b=pLbD4P9bIK+RX4V2gLMSG7EphiHnVrUBs9SW9KPa3KPgowqzjZfJF7HbFPy9Nvn/k3
         nsBfvzaxnCRuVFePjBEpEinVGOoJr2ZNNcm3OOzbkeZHfMfSVDbkYb+2KbKAc5x1gztQ
         KsThUy6jR1oJ1X8Q2DZ5z5lWfjkOntu9DPBivhyn+95UBKega5mDZkb04nONNfkz60MA
         EiTxEswfqOnTfpfgrIRC2rYEdiHOBvyNPT8rNy6c+vOxfPi6iaolsSQC/Kn8rRXSCF91
         K3gouKQ63h5fxTVOEujI2aXwOlNT7c4By5pIYwmP6dlVsb8dq14aLKC2w5nh36qFUpvI
         w5HA==
X-Gm-Message-State: AOAM531EinkPy7WGiEi6nZldNzEfAx59bEemJiEcEbiHP77GcbOxTtzS
        0a3QcSX/h2FV32t4rXXBIxgxcBGvf9s=
X-Google-Smtp-Source: ABdhPJy0CQKsZ4N+efDB3yg1Mhm9HNdm7Dbp7/yRg3NrsfCiV7LmZB71v2yFNKPnAyMO8jl+C/T7Pw==
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr12290196wmq.83.1620758055916;
        Tue, 11 May 2021 11:34:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10sm5462686wmf.0.2021.05.11.11.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:34:15 -0700 (PDT)
Message-Id: <4a561e1229e46124030856530258d6a89ce5e938.1620758049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 18:34:07 +0000
Subject: [PATCH v4 7/8] dir: traverse into untracked directories if they may
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
        Jeff Hostetler <git@jeffhostetler.com>,
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
index 0126e2f08af7..deeff1a58319 100644
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
index 21e48b3ba591..0399701e6276 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -769,7 +769,7 @@ test_expect_success 'avoid traversing into ignored directories' '
 	test_cmp trace.expect trace.relevant
 '
 
-test_expect_failure 'traverse into directories that may have ignored entries' '
+test_expect_success 'traverse into directories that may have ignored entries' '
 	test_when_finished rm -f output &&
 	test_create_repo need-to-traverse-into-hierarchy &&
 	(
-- 
gitgitgadget

