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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87953C433E6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5513B22CA1
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbhAXKzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAXKzM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 05:55:12 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905FC061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:54:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g10so9382204wrx.1
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bLslohkwHWtcE7ThFzu7S1dggo95CxS7F8DkFmWda2k=;
        b=A0pqH/SWKNmdThoWl2CyUolxfXsy38gcVhvZqjiHdcV/SaerAAD/pOx3LRlXEOxSIF
         P2fhiIjeWdup7+j33W1GRYRLddSn/K9oy4KK2U+hlsQ47sn2FcGtetsL4sUHes6BklpA
         YoRvNVTUF2iQHOBx0/H1ErP96bPj1QKO/I3Qx5cxBiOiOXR8/bvrcKFP8bRU0n04zt07
         XIQ7VZ2zIPn7RkR7kkkZ1qu98eClTgCd1nbjSci885wVfTIa4yHh7LWpDKnBC4Ro/D+T
         unkFWPJ2B8543VArH1bgBj8eF67cvI1UCDViqfC/JTu2Ao5rBgG/AurvNbjxDo+MhoZc
         R2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bLslohkwHWtcE7ThFzu7S1dggo95CxS7F8DkFmWda2k=;
        b=XI/FYoGbIIE6hz7T+P2ES1YSDoi85WqaTJPATzlPYvBvG9aUdQonfvKYiXB8u1E7fs
         sUebleA6Qbzzz3bY1n3EIg5amdZHoc28CzRVEijvufp8wO+RB/CZ7qtRQ4tJfLbXg2Pg
         +cIHiH525UGCJxlzBUnkGqqncxWgKsBqdlZAk+wwH0xYYtbCjmK9DuRlSAMJKQhRPyML
         qiuQI/f8knGr2s9v6Qa55IZLj+s1SfsNeMwVczqPGFvu/Ge0Lj7ay+eNE11a82pVZygQ
         1Vs6nFbDM16+iVxR991s/aEPpcSWUiGd56I6A8xWQm4psE62Vk7YS3gc4zNcNYNcqRNy
         5/HQ==
X-Gm-Message-State: AOAM532FMatzhQreeDGaataOGz32DRS5+BHH7ufkkuVE9RNdTmS8EyAE
        xEicSSZd84b6KBF+pleezNWCp5bKr+o=
X-Google-Smtp-Source: ABdhPJzbrng6/5NlyspsS6IjhmSBe7RQOXSFrImt9KAB+tTy3v3X4fCVjmmr0Qg/VOLukQNm/8iEIA==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr2455490wrx.139.1611485669506;
        Sun, 24 Jan 2021 02:54:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20sm20109461wrh.82.2021.01.24.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 02:54:29 -0800 (PST)
Message-Id: <8b02367a359e62d7721b9078ac8393a467d83724.1611485667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
        <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Jan 2021 10:54:25 +0000
Subject: [PATCH v7 1/3] ls_files.c: bugfix for --deleted and --modified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

This situation may occur in the original code: lstat() failed
but we use `&st` to feed ie_modified() later.

Therefore, we can directly execute show_ce without the judgment of
ie_modified() when lstat() has failed.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
[jc: fixed misindented code]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b82..1e264bd1329 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -335,7 +335,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 		for (i = 0; i < repo->index->cache_nr; i++) {
 			const struct cache_entry *ce = repo->index->cache[i];
 			struct stat st;
-			int err;
+			int stat_err;
 
 			construct_fullname(&fullname, repo, ce);
 
@@ -346,11 +346,14 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 				continue;
 			if (ce_skip_worktree(ce))
 				continue;
-			err = lstat(fullname.buf, &st);
-			if (show_deleted && err)
+			stat_err = lstat(fullname.buf, &st);
+			if (stat_err && (errno != ENOENT && errno != ENOTDIR))
+				error_errno("cannot lstat '%s'", fullname.buf);
+			if (stat_err && show_deleted)
 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			if (show_modified &&
+				(stat_err || ie_modified(repo->index, ce, &st, 0)))
+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
 		}
 	}
 
-- 
gitgitgadget

