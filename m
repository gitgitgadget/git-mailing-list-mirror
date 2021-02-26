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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8DC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 02:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E5864F03
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 02:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBZCAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 21:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBZB7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:47 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E832DC061794
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p3so6188784wmc.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FwoZfx3fRfvSrfbF1DeZqBwqtBEH4orRtaTDc8bPDtY=;
        b=T4DxEK7ZOeUlwYnzpVnat0jpPvlu26zNGgvX3oLAtfYMEWz64NR72bD4JFVRJ7SblD
         GG1i/xrpPrHbAlKoBgD3kgOEC6rO8OddMcqNRREys0CpQmrG8TfbRlGhOg2K3j0YaDmF
         vmdzyENjUNK73q6Xr41Qjr06O8f3NHeW6pvzNcqZpgeuYzl7G/knHkIHCZXOlVQUZs8T
         7LoNOEcfh5CDuvkuLUoxF8AFeAnna/3qOIWCfstOOinQkQQTR18Ub/ZFVqsteQm9Ms10
         yYOOVjr6S2ON95qPA4UI6byt2Mo8DfJI/D98Xl6yvAz5n2KPFnjECJkZJ439bLJiRG4r
         46Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FwoZfx3fRfvSrfbF1DeZqBwqtBEH4orRtaTDc8bPDtY=;
        b=V6/2iJ550RlXf5ddTM+lVq3buDDcmKNfaYwgObdIZ9wDIdrM2IwgvWaIQerBE2b5gj
         gRZEa9WnRvlFNIBP/U2Pvgd5P3kXrNCPWYkvaGlEeIPjXHg2uWg5NygoCmYRpVWPrNSE
         rUGF0I+9801pCOT92MSBJSMvmzEwpW732rt8HBhVS74hZ6t/C8Pqiq/+IFgxcMVAx1M2
         RIFAOnyyqmEDpy4nEcBlb5JyP/D4hZzZ1z6iA4LvJj6GrkhhnXPVlmVEF8+i6ZlAag2C
         fxqOY9/+KY1V2KlPOr+75jademBgJHsNjQ18VYL2ixy1PSuBOnNsZZGaxCZiJG4jvGyq
         EGFg==
X-Gm-Message-State: AOAM530mId2Pjl7XoWvfbVrt3efsrQplv/WcxvVKaVFVgd0h6yFw/JJL
        mdbgH2q2Um7wrBiVnJ/VsVMe6Qu5iDU=
X-Google-Smtp-Source: ABdhPJxxRi8sL3IyJZuje5TC/cwwLhe6F0ImoL9P6HCA0AmFmJN9cC1fOH3bAMs5QFV5IgiF9yAr3g==
X-Received: by 2002:a1c:1c9:: with SMTP id 192mr424075wmb.150.1614304708744;
        Thu, 25 Feb 2021 17:58:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a21sm10760864wmb.5.2021.02.25.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:28 -0800 (PST)
Message-Id: <752aff3a799544e398c4b3ff10a6b1b03dec524a.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:18 +0000
Subject: [PATCH v3 09/10] diffcore-rename: limit dir_rename_counts computation
 to relevant dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We are using dir_rename_counts to count the number of other directories
that files within a directory moved to.  We only need this information
for directories that disappeared, though, so we can return early from
update_dir_rename_counts() for other paths.

If dirs_removed is passed to diffcore_rename_extended(), then it
provides the relevant bits of information for us to limit this counting
to relevant dirs.  If dirs_removed is not passed, we would need to
compute some replacement in order to do this limiting.  Introduce a new
info->relevant_source_dirs variable for this purpose, even though at
this stage we will only set it to dirs_removed for simplicity.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 10f8f4a301e3..e5fa0cb555dd 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -371,6 +371,7 @@ struct dir_rename_info {
 	struct strintmap idx_map;
 	struct strmap dir_rename_guess;
 	struct strmap *dir_rename_count;
+	struct strset *relevant_source_dirs;
 	unsigned setup;
 };
 
@@ -442,7 +443,13 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 		return;
 
 	while (1) {
+		/* Get old_dir, skip if its directory isn't relevant. */
 		dirname_munge(old_dir);
+		if (info->relevant_source_dirs &&
+		    !strset_contains(info->relevant_source_dirs, old_dir))
+			break;
+
+		/* Get new_dir */
 		dirname_munge(new_dir);
 
 		/*
@@ -521,6 +528,9 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
 	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
 
+	/* Setup info->relevant_source_dirs */
+	info->relevant_source_dirs = dirs_removed;
+
 	/*
 	 * Loop setting up both info->idx_map, and doing setup of
 	 * info->dir_rename_count.
-- 
gitgitgadget

