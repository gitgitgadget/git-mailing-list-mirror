Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B9C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 12:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165352225A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 12:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pql2Ljrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgJOMtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJOMtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 08:49:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A34C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 05:49:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n6so3272304wrm.13
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GJlgomozRyvponr91F8dSZYiYUrxRziDiVbrAFusZlQ=;
        b=pql2LjrlUZUOQcKhLTG41m4yaeVtPpIqBcHaHEHbgIQ68RLaNYEmODiVqWZrTwWXw9
         4Ysg7phvvhXRIOcAUxwQYP4p6vvMEFC9JJjia4XWUnN7pcrBIu5itqsD2yvvU5Sf61c6
         cCzwcBz49DItPDCPbxJlxqFvWIHUrWNkl7DMdvfBVr72fJ0ZyOIJN0SLn0W4c3QqU4AJ
         81K1JzoauREI8LnjcBxGbHpKaCLEKNLTpmawvPh3GGXFuW3YQKHkqR++qYSrtyzETNSr
         YrIEYu0qFSnODgjiAKDE4MBUeUES/U0gIDpGTJS7nytJ/EQYSF1rcsy3iCrfXPzhFGPn
         DHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GJlgomozRyvponr91F8dSZYiYUrxRziDiVbrAFusZlQ=;
        b=hIkwxz4evK0poo3kvoqLg1cdf4AEGEF0DyJn8OTxRRYb0g5e7Oxoj07dY9PfHuFD5A
         O03c+Fy9V1CQqM6oUwymwSazV87j+nnjY/yLIajQt92WA0HRHesa3RXsWBMyRDY/dd6j
         /gbDE5vCC9pA5UyGYr7lI/MG0Pmuj3oLyZkUsq1kjeAY0zYnM1PbekvZ3Bmzor2cFcPc
         FfQa1S7rOaHTX7Rt2t0h4xqYh5gZkXVGzmcdVORDzhdItO3DfNwhsIxcDr5Q4CJWVBAJ
         XUCjZkPrRSU2NJ4tdv12gAy9KtOP/NCj5S48JtTzYiLI3IJQPDwRuiSSgBjkGFrGFhWq
         LYyQ==
X-Gm-Message-State: AOAM531ZU0TIi+tMuiWMfQUwonOXAFyUbSfnNtoZ+aiyJGsireHsWv4y
        QYdHoWV0Qo61Os/aFEtXX46C3g+tUa0=
X-Google-Smtp-Source: ABdhPJx5tYVgewVErRmUJjKJi7Eb9JPSVMoR6JyrOOuE+pF8EEEyFhVXB0fHd1mGL4R0MNlueudy2A==
X-Received: by 2002:a5d:5612:: with SMTP id l18mr4185486wrv.7.1602766162120;
        Thu, 15 Oct 2020 05:49:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm4080782wmm.29.2020.10.15.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 05:49:21 -0700 (PDT)
Message-Id: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 12:49:20 +0000
Subject: [PATCH] dir.c: fix comments to agree with argument name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Vandiver <alexmv@dropbox.com>

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
    dir.c: Fix comments to agree with argument name
    
    Comments are out of date with the variable names.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-757%2Fnipunn1313%2Fcomments-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-757/nipunn1313/comments-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/757

 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 78387110e6..4c79c4f0e1 100644
--- a/dir.c
+++ b/dir.c
@@ -1040,9 +1040,9 @@ static int add_patterns_from_buffer(char *buf, size_t size,
  * an index if 'istate' is non-null), parse it and store the
  * exclude rules in "pl".
  *
- * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
+ * If "oid_stat" is not NULL, compute SHA-1 of the exclude file and fill
  * stat data from disk (only valid if add_patterns returns zero). If
- * ss_valid is non-zero, "ss" must contain good value as input.
+ * oid_stat.valid is non-zero, "oid_stat" must contain good value as input.
  */
 static int add_patterns(const char *fname, const char *base, int baselen,
 			struct pattern_list *pl, struct index_state *istate,
@@ -1090,7 +1090,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			int pos;
 			if (oid_stat->valid &&
 			    !match_stat_data_racy(istate, &oid_stat->stat, &st))
-				; /* no content change, ss->sha1 still good */
+				; /* no content change, oid_stat->oid still good */
 			else if (istate &&
 				 (pos = index_name_pos(istate, fname, strlen(fname))) >= 0 &&
 				 !ce_stage(istate->cache[pos]) &&

base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
-- 
gitgitgadget
