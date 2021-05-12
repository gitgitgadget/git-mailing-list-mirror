Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD4C2B9F5
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6C861413
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhELRos (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347765AbhELR3l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B2BC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so3441740wmv.1
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8SiUoiHeOJgGU6jKM10WleHVXxI8fdxp+WTvsfb1z7o=;
        b=rN1xtZ4Pee+86W/Xr9boqAAZDbx0h5o/CeVxB3fR9AWnoMGA1ZqfdR876DqwP80FY8
         d3HjaWB9uK9KUMAj6sT1zKswHzp6b5d3eva7gtQ+gRClhquuq8+9ircfZR9S3nyaR2Bq
         GPnT4cVCle8tWdWeHWhB6mHnZqVM7WDwxaUWyioj4lAFm8znnZN9HAAwJyj+2k2N7f/s
         F/JYgwBBD6fB7bg7eK9XWaiGW+te/Fn3ed6lIeBWwFNwuh67zIU7qrcwGznw//X6OKw8
         ofgdlY+Crfk8VD7R4sYYk2+CQrfUU65DNMnXcMEAXgAiAvHAN0Jk06dveQCpjG5MUJZm
         XgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8SiUoiHeOJgGU6jKM10WleHVXxI8fdxp+WTvsfb1z7o=;
        b=Ht+6+YjrWj5+ZN2158Sq/NeOwCkuSOPbDP2ftFKHyEr8KMZZ+0ax1OrIAfEPX2N7Lh
         628d3/S6nfF6b/QX2jKt6FZDVqWx/Ft+JHLNsFK9HrqPv1UURpwgqEYzXynjKpSdq2di
         SbyxE9bkmfQgTaXKgG8KHYFO00NpoJCaLsrV30qrUgTVgGt00lgQab12AwYNI0L5qxkW
         AMqP7PIQewTHj1Qc6Aroa33gJBTpwJABfgw3mwQV3bYvv9+OGFAJWp0MceFxVieNRbDd
         Sk44bU4jnrkukW+aLQ/DyFX2DfzbAsXqZg5VREN2pCi8xd7qD45fqk94Zgc3JX6choos
         6B8g==
X-Gm-Message-State: AOAM531WgkyL9FoxXKmnXJ1wSVQLB+dA5Zp5cZwm+OC4Bts01vME7r7E
        q5s1LuRo3ERoLisZnMJAP26KsjNkFlE=
X-Google-Smtp-Source: ABdhPJx1cYh/l1OQYLQVyv3BS+NtslsOO5DBVdLvk/vkJIjBvB5YdJXvNk0KiMAIwcLGk718N4ihtQ==
X-Received: by 2002:a1c:1f95:: with SMTP id f143mr12764448wmf.77.1620840511052;
        Wed, 12 May 2021 10:28:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm332545wrx.31.2021.05.12.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:30 -0700 (PDT)
Message-Id: <6fa1e85edf2fbfbf902d4f726c9aaee6aa9df308.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:20 +0000
Subject: [PATCH v5 7/9] dir: traverse into untracked directories if they may
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
index db2ae516a3aa..c0233bbba36c 100644
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

