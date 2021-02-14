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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A18C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE5E64E23
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhBNIBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 03:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhBNIA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 03:00:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5691C06178B
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v14so4877758wro.7
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fVtGL9oxPIeXkpNd5TvKQjAWx6Z6VstTh0BJNl3lABw=;
        b=Gk0KcSbsNtZ914Ixrr8V+cD1/M7AwVLHuMscnK0yegRpOC8BFi1Qs5RLtzEP0qSU/g
         R4LJjezShM1+qkzCwX1+CXehjEda5OnvCMKW9Dx0+w7U0GPmXwgylCCEvrupjVJIjMsL
         YdFyfJHxFIMZH4kOOpJpuVVRJhKRtUCZRwCMKQhIg+WmN1b/gZAPDq+JckG04uQIej07
         wb1NipNJx30W8nbOcT/kG9TEpSb11kD1Yb2fbwN6vCkGhaLuwge+dOGwanskv4tlJQvG
         qnML40dozjZUCCETVhhUDFeqpSw0SWD1rHMsb+0/2Bkfmu09AtDXv+W5Xuf221kMgs4Q
         jTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fVtGL9oxPIeXkpNd5TvKQjAWx6Z6VstTh0BJNl3lABw=;
        b=t0A2NkFQCc39At+9zwRZpIi7wbrWgr3xpd6WYSDf7xU06Sbz6KOvLq+wRdsGySGKSJ
         QW4XNVTGKH0vnI04IhUVMj4LpDGHtKVPNuq6vpCsXBPLzm20v5SpZ34TTjsd5hzXnGYn
         TLA4qcYO+gJcACM2yNt5t8+DCBoG6j+vZ7GpLnrK13Rcd7SnErspS6Q1TbtteuooFSqs
         MooWdMRZWjl0U3i8ySFH8rRO4sM3Koj07ipb+Bf/GVq+f5cLfwvIuMyCRizVFwurl+LW
         YmORZ5v2k/RkC4MPpbeBsPVFvsFpkLxK3oBP7UXMTkqmP5SgdogFjpQofpfnHu6vqhGR
         9VDg==
X-Gm-Message-State: AOAM5316JDFJOX5H8vW7nSOzizxH5xnsb8HMcw507/QNQbbkedtVN/mn
        QJbtXy5rgGxRJwqTF+qpDvGCIztKe+k=
X-Google-Smtp-Source: ABdhPJzWkKUbuU6Vgca8HGgVdF+RvRlqajFxiHtB3Mk7+b2hDoz+A65mjSOZhtv7ttmzrZOQf2Zs/A==
X-Received: by 2002:a05:6000:cd:: with SMTP id q13mr12498754wrx.138.1613289548622;
        Sat, 13 Feb 2021 23:59:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm17465850wrr.89.2021.02.13.23.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:08 -0800 (PST)
Message-Id: <dffecc064dd36d9ba3885d947e544a2ce010a01d.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:58:59 +0000
Subject: [PATCH 06/10] diffcore-rename: add a mapping of destination names to
 their indices
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

Add an idx_map member to struct dir_rename_info, which tracks a mapping
of the full filename to the index within rename_dst where that filename
is found.  We will later use this for quickly finding an array entry in
rename_dst given the pathname.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 489e9cb0871e..db569e4a0b0a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -368,6 +368,7 @@ static int find_exact_renames(struct diff_options *options)
 }
 
 struct dir_rename_info {
+	struct strintmap idx_map;
 	struct strmap *dir_rename_count;
 	unsigned setup;
 };
@@ -509,10 +510,26 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 		info->dir_rename_count = xmalloc(sizeof(*dir_rename_count));
 		strmap_init(info->dir_rename_count);
 	}
+	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
 
+	/*
+	 * Loop setting up both info->idx_map, and doing setup of
+	 * info->dir_rename_count.
+	 */
 	for (i = 0; i < rename_dst_nr; ++i) {
 		/*
-		 * Make dir_rename_count contain a map of a map:
+		 * For non-renamed files, make idx_map contain mapping of
+		 *   filename -> index (index within rename_dst, that is)
+		 */
+		if (!rename_dst[i].is_rename) {
+			char *filename = rename_dst[i].p->two->path;
+			strintmap_set(&info->idx_map, filename, i);
+			continue;
+		}
+
+		/*
+		 * For everything else (i.e. renamed files), make
+		 * dir_rename_count contain a map of a map:
 		 *   old_directory -> {new_directory -> count}
 		 * In other words, for every pair look at the directories for
 		 * the old filename and the new filename and count how many
@@ -546,6 +563,9 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 	if (!info->setup)
 		return;
 
+	/* idx_map */
+	strintmap_clear(&info->idx_map);
+
 	if (!keep_dir_rename_count) {
 		partial_clear_dir_rename_count(info->dir_rename_count);
 		strmap_clear(info->dir_rename_count, 1);
-- 
gitgitgadget

