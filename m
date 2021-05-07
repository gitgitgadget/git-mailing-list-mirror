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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF72C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0476613EB
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEGEGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhEGEGF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:06:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D129C0613ED
        for <git@vger.kernel.org>; Thu,  6 May 2021 21:05:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5755177wmc.1
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RCD1WrFJxMrytQ2QmONFIxMjkN4xZtTfbmf/jmcKbn0=;
        b=UrVo1IhoBazkvL1yUdT8RXHz7yxj1bk10RQg+Rcn79Rwhas5W81qa6TDiXfmSMEqfy
         XbeAtcm+kczCw80VZcCwABGuUeKz7uU85gV09uhx1+zYneqa5TKrs6Vi/dY8jl+HsQ6f
         laaE48TSYUtO46H+rVJWK8ID16aapyugC/XdlY47TD0BgVcObrCid9AJkHJCkdlxCRBW
         CWiljUWNl4oYxBSKWGYJAYuGwkxZgqJJpZkkUJhwSvxTCObZiVoCmrsy8eDY3GX1sNml
         xFq9YkvO4dSUfqEz0iyypDvyajXNxff4zvv/YZlpY6Sgeu5eDxdHlEDx02ljsicB0X/l
         TjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RCD1WrFJxMrytQ2QmONFIxMjkN4xZtTfbmf/jmcKbn0=;
        b=AswtJSi2PpSjBIC3PYzpGul12Kms9MSLywo1FWtt0e1u25L9vZdd6WIa6UrxFaHZJG
         0hxNdRdHpDTnHxjUPcudQ3ugBwMF3o1DsGLSUWPY6XB31UXODgapV+fMDBl0w5sYcoD0
         sgI1essYDkAyIlXds9fR8xAgC57GtupAW7wpvfriO39fq8pBWyrsdVKiAYe8E8PrUMs4
         5SNtDKJtdQ+OMbFPHfKlI6S8MgZm9H6z9iib8fXMGlWdRkt2U8CxrUeztPeRrvtxUKbY
         jwMjO9+2mWM0ttxtOAkrVi4gzjcdqiGLhdyBA3pJHr8BZ83oYiknxJFArIKrYitnE62l
         xtrg==
X-Gm-Message-State: AOAM532dTwgyQ9TcS2nhattt4kw6oNzSB0D1fmSTak3azym76eZC2fjg
        ozxD+qiJIR+927/jXYMLQW+XJLFk47I=
X-Google-Smtp-Source: ABdhPJxnUUVg5Cn8F2oS+doYvy6PenSYg+9US8S9mrwW2ve1f3m36MJfsAxqLtoka9iY9ck5/Rxbew==
X-Received: by 2002:a1c:7501:: with SMTP id o1mr7717678wmc.65.1620360303878;
        Thu, 06 May 2021 21:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9sm5777116wmi.17.2021.05.06.21.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 21:05:03 -0700 (PDT)
Message-Id: <fad048339b8131391f9f8952e215849a21145ea8.1620360300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 May 2021 04:04:59 +0000
Subject: [PATCH 4/5] dir: traverse into untracked directories if they may have
 ignored subfiles
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
index 4b183749843e..3beb8e17a839 100644
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
index 00e5fa35dae3..c2a3b7b6a52b 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -786,7 +786,7 @@ test_expect_success 'avoid traversing into ignored directories' '
 	)
 '
 
-test_expect_failure 'traverse into directories that may have ignored entries' '
+test_expect_success 'traverse into directories that may have ignored entries' '
 	test_when_finished rm -f output &&
 	test_create_repo need-to-traverse-into-hierarchy &&
 	(
-- 
gitgitgadget

