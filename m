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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4405BC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 00:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E73C64E7C
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 00:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhBXAAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 19:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhBWXro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:47:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D482CC0617AA
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so130739wrx.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Paoo+pQzJ8Xi5K9u8+x+UaLgBVJk1KVJ1L2MCTL/81Y=;
        b=MDRcqMAglAmWFssoaNKL2Jkp80c8z5aSWE6VpwQEqhXfMR+Fx2xU9UOnpRdoUXJfhP
         Xw1HQYsfuLaACFIfGUPlXa95joS5FNAbPsRznE2otZFvBGapepL5ZzNs6LjXCJviJJGb
         CX06wLwItSFgyUBBA5MsJ3KO8h2Ozv0M0pHXZgakPcWOKvPqzUduJm/CQJgwo80z9WRL
         XGNE45TUWC9kgoljeN3wuiw1dZCLo9UwkxZV6ziVUJWWSOUy6nOaRM2+htbNMhfnQLLM
         NLX4oS6lsFJhYOKLWjfquBRU+NjerCgfqZsC2sS+Kb+JAiq9zuXZ/hQM3rNY2lyH/c3V
         4TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Paoo+pQzJ8Xi5K9u8+x+UaLgBVJk1KVJ1L2MCTL/81Y=;
        b=dmuQW3c6TS/ex0MLlBMD5T+HRCyZcKJh0fENqqqAtrpdZusJCFCgxKE2AWfZlZ5unx
         OFzlf1dciQwriWxtRljnO16tvymSfODhvgkpGYtMxWJvY8Y0z32s43k8dKN1CbOOLUpn
         d7uavhcYUPj6e4PqFFdH1NxhDhaZL9pSN3H2jL8diT+SOxlY18mU+SN0r9wM5eAyz5D1
         Eqf4e9ZKWRa/43b2OD5a5UrU0a1fgG/uDIy90VEg5Pa60UYmLROqx9QrwnyjLu4mjgUo
         9mSfIy6uj7TEIbY/IcEakxT1tZ+FBFi7rA6HdmIwTwtydq8gn3DEPIh/L45Qt45yITTZ
         v9nw==
X-Gm-Message-State: AOAM531oPGpCp+A3HVIe4I2bypDThs9ZNByB/okRVsOjzm0Y7OaYdV8I
        wMi+9rhoQL8uSE4O0UDtVVXRJe9EJ9M=
X-Google-Smtp-Source: ABdhPJwEV/CYS0SaBqBBPOg/u1dXQDnDWYSzZEW9qENLgybP32LFEyIW5RhuP47kqM9x0qgt81CUvA==
X-Received: by 2002:adf:c14a:: with SMTP id w10mr3123648wre.282.1614123854623;
        Tue, 23 Feb 2021 15:44:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm395437wrc.12.2021.02.23.15.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:44:14 -0800 (PST)
Message-Id: <4e095ea7c4390cb47828bbba50af876249983870.1614123848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 23:44:06 +0000
Subject: [PATCH v2 09/10] diffcore-rename: limit dir_rename_counts computation
 to relevant dirs
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

We are using dir_rename_counts to count the number of other directories
that files within a directory moved to.  We only need this information
for directories that disappeared, though, so we can return early from
update_dir_rename_counts() for other paths.

While dirs_removed provides the relevant information for us right now,
we introduce a new info->relevant_source_dirs parameter because future
optimizations will want to change how things are called somewhat.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1e4a56adde2c..5de4497e04fa 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -371,6 +371,7 @@ struct dir_rename_info {
 	struct strintmap idx_map;
 	struct strmap dir_rename_guess;
 	struct strmap *dir_rename_count;
+	struct strset *relevant_source_dirs;
 	unsigned setup;
 };
 
@@ -460,7 +461,13 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
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
@@ -540,6 +547,9 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
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

