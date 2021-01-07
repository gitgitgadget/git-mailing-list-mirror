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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB2C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C656823444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbhAGUCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbhAGUCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F8C0612FD
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c124so6104182wma.5
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4JP1HOJAF5tmslgBv1jJeKDuRrchYeWGkW2hGbQECY0=;
        b=Nd7qC/DYENxcM3UNuUSUkwQ3y6nepmk4E09I6PB0Qlo4nNy5rmGULuH6kImopn9wQn
         2Wt6vNswPlGflLkkFHNhzJUY2IL2c6LzrgyWLnEiPE/PbHel8bchCHdoUC657riecK7B
         cgqgM/PPgb/6KX/qAdDhpY8a8LkIN8H/bBDTFW7+539XW44xrJY2Jh900/oFEsS7NAyM
         evA07W5+w+ENYB0xX3UeVKugH25avdl3jwt+PXxFZ0VCHk+HhT0KoScrMs8p8wzrZ6Hn
         R4stSvf/1HCkDc9QkdhmSPpA8B1C7RAMdKAERqDTh9yebEPcxScXvamcW6c95JGa2EOk
         IZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4JP1HOJAF5tmslgBv1jJeKDuRrchYeWGkW2hGbQECY0=;
        b=ROIyfswAjUrjfDK4YiHdYDbknRavqrXu0Xfa612yCgLDnKM6NOczTc18UhvVRV9Ced
         0pa3SQH9mRmNMutvczm4e13t+8m2mjpBuZZETsxULi3RLowGm/ywBaVwasc54gt8NcPc
         nSDqIbikH3vbvc3Rj9NXyE0ZjJ5Vpxahqas5VK0HOUzOKW6oaLFK1hHZrylYDwPQ+ErV
         bRIHjhO2tCuQALGfro7qLm9aBggdq0tk1MD/xtjCRgQuEFUUdA7otN8a2HJ594YCcmwT
         WcVt/9pWS3iuASmg5sutNQ0tCCscChpqGKE2wIM/VkmdGXVlG2Za0rIzjXAt0v4LogTt
         oyNA==
X-Gm-Message-State: AOAM532g0igpoxr8LtbK1t7t4rvzjjTCl8YXu8VspR561Ul/4P8+3lPo
        f5mCNOVEnhlJw4288eZQCkUva2XmRWY=
X-Google-Smtp-Source: ABdhPJxLJB3g8beJ7dIBz61F4Nr8/EY2SVu56Ea/r4Fj6x+rxeOkQf+v5zPnlRHrB7rqVu/lIlvdTQ==
X-Received: by 2002:a05:600c:2042:: with SMTP id p2mr173251wmg.152.1610049695674;
        Thu, 07 Jan 2021 12:01:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm10006218wrv.44.2021.01.07.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:35 -0800 (PST)
Message-Id: <1e48cde01b9e2fe24eeda063e0298db8421b13a7.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:16 +0000
Subject: [PATCH 07/18] merge-ort: implement compute_rename_counts()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This function is based on the first half of get_directory_renames() from
merge-recursive.c

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7e0cc597055..a8fcc026031 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,7 +721,6 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
-MAYBE_UNUSED
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -825,11 +824,61 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	*new_dir = xstrndup(new_path, end_of_new - new_path);
 }
 
+static void increment_count(struct strmap *dir_rename_count,
+			    char *old_dir,
+			    char *new_dir)
+{
+	struct strintmap *counts;
+	struct strmap_entry *e;
+
+	/* Get the {new_dirs -> counts} mapping using old_dir */
+	e = strmap_get_entry(dir_rename_count, old_dir);
+	if (e) {
+		counts = e->value;
+	} else {
+		counts = xmalloc(sizeof(*counts));
+		strintmap_init_with_options(counts, 0, NULL, 1);
+		strmap_put(dir_rename_count, old_dir, counts);
+	}
+
+	/* Increment the count for new_dir */
+	strintmap_incr(counts, new_dir, 1);
+}
+
 static void compute_rename_counts(struct diff_queue_struct *pairs,
 				  struct strmap *dir_rename_count,
 				  struct strset *dirs_removed)
 {
-	die("Not yet implemented!");
+	int i;
+
+	for (i = 0; i < pairs->nr; ++i) {
+		char *old_dir, *new_dir;
+		struct diff_filepair *pair = pairs->queue[i];
+
+		if (pair->status != 'R')
+			continue;
+
+		/* Get the old and new directory names */
+		get_renamed_dir_portion(pair->one->path, pair->two->path,
+					&old_dir,        &new_dir);
+		if (!old_dir)
+			/* Directory didn't change at all; ignore this one. */
+			continue;
+
+		/*
+		 * Make dir_rename_count contain a map of a map:
+		 *   old_directory -> {new_directory -> count}
+		 * In other words, for every pair look at the directories for
+		 * the old filename and the new filename and count how many
+		 * times that pairing occurs.
+		 */
+		if (strset_contains(dirs_removed, old_dir))
+			increment_count(dir_rename_count, old_dir, new_dir);
+
+		/* Free resources we don't need anymore */
+		free(old_dir);
+		free(new_dir);
+	}
 }
 
 static void get_provisional_directory_renames(struct merge_options *opt,
-- 
gitgitgadget

