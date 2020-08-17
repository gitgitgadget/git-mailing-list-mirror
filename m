Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F3C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ACC2072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFjmLXDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgHQNXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgHQNXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 09:23:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CCC061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:23:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so13867655wme.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RgfrtBj6saJEPQY1qJEclkcFsm/IEepd/IbEMlZzF8w=;
        b=mFjmLXDfP/c/52PzJvtWkWsPFEZh8kSTEtohm+/HIc5/AdNvpov8j4mGPjyIOzu1sA
         I4DEWO//6G06ip2XVTPuzDi7Xc8SV90XEbl6naEewLTX/bjArCkpFRgbYy+CzFX4R1lv
         6ajUQtkywDlbzeQ3bOzT3rzdpl3isE8QbCyDMk+6xgd+ED2EY9Y8Pk0E9YNaLHm7KKKI
         gtB45qhawUa3wCQWq9M7WvlLzllEw9iJJewY3nde3UvkhW032pjU8NzJeSwaTA+Y9r8o
         AeDX0L4XVdEjwHhZRHT5Lbzyy6d8FAcrhGY5eWz1lwvtuDLkBGPXAcsqBcasvIf2Hdhj
         aIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RgfrtBj6saJEPQY1qJEclkcFsm/IEepd/IbEMlZzF8w=;
        b=UXKN8RodoT1ZzoA0j9Ipcofh9zLVfRs/Nn+HoPUeTjKw4PItVAulisFl/uQasshrNk
         jTZgAzSnSQ2PKRFepAn1vaXhnPvkdq5t8cgwJ42HR4cFMWVGniU7B5kutY5AQJwGC5SY
         +bK4txy7bccCa0fa39kTz0BiUGoURvA7A9hN12hMFt0K58/YqHRQ+s0j5OVLZUXNpTvq
         q6jHGE0Mfedk2q/GC7qbvLG6Nc8JlOGJT4Fj9SJFCdMNCd2tEYRs2HAO8lrnSLDCvzqm
         8Nca/4cBZT300vRPfhu57jVw3Y/oOg9V3ApW7E29kRruOQVxU5p1q7kOwa9NaKs78xPS
         mWPQ==
X-Gm-Message-State: AOAM531FP8PQx2VnyDYCyx2rhLG9DS+yTSdE5ZCEg7sge5tZGzOtjv2j
        Md2nyQuBuVfpzG1uVZ5TPRpwifDvdU0=
X-Google-Smtp-Source: ABdhPJypDdEapafa8oQ/3he24F2YZq04UXay/2nXiWz+VvlGtOAanWYAJMa4sQ3CXEn+Ek6vILpGGQ==
X-Received: by 2002:a1c:4944:: with SMTP id w65mr14126741wma.169.1597670590838;
        Mon, 17 Aug 2020 06:23:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm30200405wrp.60.2020.08.17.06.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 06:23:10 -0700 (PDT)
Message-Id: <ae6ace43af9b25ee8f67b01ed1ec50064c8b006f.1597670589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.702.git.1597670589.gitgitgadget@gmail.com>
References: <pull.702.git.1597670589.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 13:23:07 +0000
Subject: [PATCH 1/2] add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This simplifies the code slightly, especially the third case where
hunk_nr was incremented a few lines before ALLOC_GROW().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index f899389e2c..a15fa407be 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -457,11 +457,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			eol = pend;
 
 		if (starts_with(p, "diff ")) {
-			s->file_diff_nr++;
-			ALLOC_GROW(s->file_diff, s->file_diff_nr,
+			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
 				   file_diff_alloc);
 			file_diff = s->file_diff + s->file_diff_nr - 1;
-			memset(file_diff, 0, sizeof(*file_diff));
 			hunk = &file_diff->head;
 			hunk->start = p - plain->buf;
 			if (colored_p)
@@ -483,11 +481,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 				 */
 				hunk->splittable_into++;
 
-			file_diff->hunk_nr++;
-			ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
+			ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
 				   file_diff->hunk_alloc);
 			hunk = file_diff->hunk + file_diff->hunk_nr - 1;
-			memset(hunk, 0, sizeof(*hunk));
 
 			hunk->start = p - plain->buf;
 			if (colored)
@@ -511,7 +507,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			if (file_diff->mode_change)
 				BUG("double mode change?\n\n%.*s",
 				    (int)(eol - plain->buf), plain->buf);
-			if (file_diff->hunk_nr++)
+			if (file_diff->hunk_nr)
 				BUG("mode change in the middle?\n\n%.*s",
 				    (int)(eol - plain->buf), plain->buf);
 
@@ -520,9 +516,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			 * is _part of_ the header "hunk".
 			 */
 			file_diff->mode_change = 1;
-			ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
+			ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
 				   file_diff->hunk_alloc);
-			memset(file_diff->hunk, 0, sizeof(struct hunk));
 			file_diff->hunk->start = p - plain->buf;
 			if (colored_p)
 				file_diff->hunk->colored_start =
-- 
gitgitgadget

