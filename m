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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE65BC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BCC64F0D
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBZB73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhBZB7G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E691EC061786
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id x16so6163774wmk.3
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AYf6h+TZVR9f0eSmIEySlswi7Ysrojy78fdbVISGG3Y=;
        b=dW6YrUYHN8WGLZEdJ6BmiylNamNnA7kSb5DO7KQKdeiACUQNMfm6A+vagVBEPRTz0t
         jCb0nhtBhXEoobsOrvM99mJG+zvcBB5KUv7RhpT+q7wGp82nIzG+JEwN1/vul2YgY/FP
         ytsOXIzFFx+8fLy5JyCmwgMRqu/05miiftvsVpEPu1Zkr4cDmlA8roLIe4ceUAqaQPQ3
         GH74iqVQUmGQJGr78zuWIVR4LceC7PawFxw/64guKOwn5i6QqvqRM+rysLMKOe6ucdy0
         miMGPFg8CLSvDD/M67srLDqph8GWSLIlCqMNqtSTyBd9XE3FvmvHT1qaOYDUS9Uvg2bl
         iJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AYf6h+TZVR9f0eSmIEySlswi7Ysrojy78fdbVISGG3Y=;
        b=QEfvIIF8dCf5PAc8GTVfchDM6z0dkG6Q8IGAA0IzFK7mJncQv9VpMOZaUEZJERQPsP
         cTeZgGUb9Pd79PZkD1INL5khRQurH3GT4hiCDBuGWpHlYuQEz4lbaV2RJqBTMvvYDeOg
         /GuGojUMNdXx2/C1vu1iAzzhRWWQA8OGUwQnlxPsx/rJUB2kQ56ijXiw5H6ho5vIG5yQ
         ryRahIpuHdDYAVuX3oxgcpAGLErH7VgvLt0qbriP+XZF5BSKh9dmydZyl3ZxJ6IlyC6w
         R1IXntnFLhJWAWr/GinbbgBAS2gCyUJEDTwHdkkfe1R7EkGCHXZPblqpRpa1L4Qm1Wpk
         JNfQ==
X-Gm-Message-State: AOAM531g2fmRg8HN29UeF4Ko6zUxjJmvoKvPFQU02VEfCJAGkhvPjptk
        86MGKqLdLUS8/RK5BxcMH/zjiA+GznI=
X-Google-Smtp-Source: ABdhPJyHngDbryUfoN9MeyKEUi7Xma/SnEluvGQrHgkiYMxeclOrep+RVuKq4haGHlmeRweoft8XuA==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr412218wme.140.1614304704634;
        Thu, 25 Feb 2021 17:58:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u137sm9687503wmu.20.2021.02.25.17.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:24 -0800 (PST)
Message-Id: <0e14961574eab3ccb3328df79aac9143af5c2278.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:12 +0000
Subject: [PATCH v3 03/10] diffcore-rename: add a mapping of destination names
 to their indices
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

Compute a mapping of full filename to the index within rename_dst where
that filename is found, and store it in idx_map.  idx_possible_rename()
needs this to quickly finding an array entry in rename_dst given the
pathname.

While at it, add placeholder initializations for dir_rename_count and
dir_rename_guess; these will be more fully populated in subsequent
commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index edb0effb6ef4..8eeb8c73664c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -380,6 +380,45 @@ static char *get_dirname(const char *filename)
 	return slash ? xstrndup(filename, slash - filename) : xstrdup("");
 }
 
+static void initialize_dir_rename_info(struct dir_rename_info *info)
+{
+	int i;
+
+	info->setup = 1;
+
+	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
+	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
+	info->dir_rename_count = NULL;
+
+	/*
+	 * Loop setting up both info->idx_map.
+	 */
+	for (i = 0; i < rename_dst_nr; ++i) {
+		/*
+		 * For non-renamed files, make idx_map contain mapping of
+		 *   filename -> index (index within rename_dst, that is)
+		 */
+		if (!rename_dst[i].is_rename) {
+			char *filename = rename_dst[i].p->two->path;
+			strintmap_set(&info->idx_map, filename, i);
+		}
+	}
+}
+
+static void cleanup_dir_rename_info(struct dir_rename_info *info)
+{
+	if (!info->setup)
+		return;
+
+	/* idx_map */
+	strintmap_clear(&info->idx_map);
+
+	/* dir_rename_guess */
+	strmap_clear(&info->dir_rename_guess, 1);
+
+	/* Nothing to do for dir_rename_count, yet */
+}
+
 static const char *get_basename(const char *filename)
 {
 	/*
@@ -858,6 +897,11 @@ void diffcore_rename(struct diff_options *options)
 		remove_unneeded_paths_from_src(want_copies);
 		trace2_region_leave("diff", "cull after exact", options->repo);
 
+		/* Preparation for basename-driven matching. */
+		trace2_region_enter("diff", "dir rename setup", options->repo);
+		initialize_dir_rename_info(&info);
+		trace2_region_leave("diff", "dir rename setup", options->repo);
+
 		/* Utilize file basenames to quickly find renames. */
 		trace2_region_enter("diff", "basename matches", options->repo);
 		rename_count += find_basename_matches(options,
@@ -1026,6 +1070,7 @@ void diffcore_rename(struct diff_options *options)
 		if (rename_dst[i].filespec_to_free)
 			free_filespec(rename_dst[i].filespec_to_free);
 
+	cleanup_dir_rename_info(&info);
 	FREE_AND_NULL(rename_dst);
 	rename_dst_nr = rename_dst_alloc = 0;
 	FREE_AND_NULL(rename_src);
-- 
gitgitgadget

