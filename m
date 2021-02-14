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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7439C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB89614A5
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBNICO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 03:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhBNIAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 03:00:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F9FC061794
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n4so1905119wrx.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Paoo+pQzJ8Xi5K9u8+x+UaLgBVJk1KVJ1L2MCTL/81Y=;
        b=caeLRAkyow/SDCyZHhwoDrHMhZg7Hl+pZmcJ1W+ssKRyw8kmHoyRFx2MbbA9YQeC0+
         dEAv2G3OK8WYvcns7PfvK8o39439A3fEPxoauKBA5Ky/Ne/r3f7QAZgUdHWuZ8IfWQ7F
         tZiYDWDNCrtCvwF25Nd/op0mQRUZRPFhhkNvuOuPhsFAXSYEcrnI7LezR0trsvEPjNvp
         oCMUl/9oIavnffwrQrnb2Syb/wILXnTKR0TQy506eRAm39bOIHGazlotahxNB6AARaqW
         qzN6Zu8SxhJqmZ/B8mHjlXJGckCZFmEFYuj4J2EpuiQqyv6A9P4NBAnq8NBH6irtVI8B
         G8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Paoo+pQzJ8Xi5K9u8+x+UaLgBVJk1KVJ1L2MCTL/81Y=;
        b=X6dYz5+NOJeqbMA6QSFeNKr75th0ZogrWZWwN7RKX/vPJlrjO4J0UhF/CztNZOAEzJ
         G+CF+nR95Kj+X34j3LyzGuff0L2oPEbo8o7zQQRWP94iVrOP3IwAz9MOu3adVWxp88Fg
         Tb2m1OACfGOJa+C2LfAMbTewnVcuJ6UD6B/YcFgw/vI8q0vluAw3BEy99LXOb+DK9qTA
         pB338kRhehlbO6BMAyUk8BQOfxQHOTt2tTqVa9K+83p+3Pqt+7Jas+JxkV9PC/diH+GH
         9tyeMFEjkoQVuBQchNiNCKKynpVxJ4PtdeZNHcwnvDjSe4IgzkuRFBo9eHqGR/cvZTrw
         L5mg==
X-Gm-Message-State: AOAM532lluKxq7Zz5Glsxrxz2TOpiHZH0ZZ7xlTHzjvsQuAMqunO5Uvl
        AP/8LiUI/rKb9V9e9p+Pb796SriizD0=
X-Google-Smtp-Source: ABdhPJybI7svVVdPwdp/kUY4l9+5wv3vGPyGc/Iy/BIcnr6/eSEsRl4xNmgmRxZMD9gzzLHji5p4/Q==
X-Received: by 2002:adf:facb:: with SMTP id a11mr12840315wrs.161.1613289550330;
        Sat, 13 Feb 2021 23:59:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm11499942wrp.74.2021.02.13.23.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:10 -0800 (PST)
Message-Id: <4e095ea7c4390cb47828bbba50af876249983870.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:59:02 +0000
Subject: [PATCH 09/10] diffcore-rename: limit dir_rename_counts computation to
 relevant dirs
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

