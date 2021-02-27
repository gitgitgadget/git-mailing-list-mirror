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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F3C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BEF64E4E
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhB0Acq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhB0AcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:32:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6379C061797
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p3so8674176wmc.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AOjAsjDCnHz5JovKtZiMourT7thcpzEqmHnNEavBoco=;
        b=QoASgKJc2kWjy0X5LXE4OLVkTsG9Q9Lf9Z8+2RLCIRA1Cm3/1T+LQR+ZspDjNhHxPh
         vUU3sXfe9X5qw3rXrHlarkJLrO8LbtiAK1YLDK2kqXLeuI+KrxuTMrjf/I0rm1tmHC5e
         GRJ+2M4lXhbt+mRYIH8AUZIVwaGg2Z0qcUsS+8phjG19G3cJBkidydEHYpOEUTgZcXZq
         QYxOUN6tGSeMtm26uxMLY7A9J7qfFotKwv0BF72pCz9LMQlUVyiRhXb2rPOwtcdL26q2
         g9Ue2aqp7/oVIgnTYu0FkOoddoR4kLeVMteZhX+BcrEhEhpIpO4KjboEy60FuTJah1fk
         Gyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AOjAsjDCnHz5JovKtZiMourT7thcpzEqmHnNEavBoco=;
        b=s4N4QSGkdwFo3dbP4E7xNIBmsIucIJSMG8u6o3iYY/fAABtIUg74091yiX7sa+isyQ
         gKXSeGaQEmuvczRumc4zOGBNs7/KMps4f8QR5JHT4tjmO4BS+a9/hJOFynnW7ltI6Wim
         HNzSCVNbxsqGKQU5FWS5SA4lI5ybNjItW9yWSok2SXbAzQpzbsoQ7L0PGHhKF8a63hKw
         +jdw3J6IdO+LNxkJDmbYCwkfgpNuHJ20IHdDlfFyuwJ9MJEaNvM31DIGyNT6wKxf+IjH
         gu0yBAFtKAwhDViZw27tkit+TP3r0nL1Tt/dlu3WuUyZSYtaz+S37jCIbBedQ8zDYOAW
         Xmog==
X-Gm-Message-State: AOAM530PB7N6QOUnn3F5HbYyAaigBWeBvTStk5WMoMTCGSlUgNpKTmxe
        1KW3wd/kmjscEOx3N8p539VqUN0MEtw=
X-Google-Smtp-Source: ABdhPJw5jHaVLA/xudW6PYAgxtI0WR9I+Ud4Y2qOxhpoj1VlbLoUTiuHB7HiaVMC9LV/hcXwg0LBdw==
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr5038679wmq.3.1614385856585;
        Fri, 26 Feb 2021 16:30:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm15945882wrx.70.2021.02.26.16.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:56 -0800 (PST)
Message-Id: <46304aaebf5aa4120df81284c37efcb554cface5.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:47 +0000
Subject: [PATCH v4 09/10] diffcore-rename: limit dir_rename_counts computation
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

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
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

