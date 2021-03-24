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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB3EC433E2
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D40F61A24
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhCXVcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbhCXVci (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:32:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69AC06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x16so249910wrn.4
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2rWkcFDLnOgbEh3iq32tzYD1sEh6ZH0IimGam4RIGZE=;
        b=DsQpXNDAYhCbfq/KaApdsa77mp/GStDHCAPeARt8hzzNo6roX4dywzpI72oFS1bCxA
         Jyos7Q07Lpybuz1shjSm22XjxbnNv1MBZpAC7r6KPEPeD+lSwymctYgHjjbKrzoeZ1w3
         HFSes+8QMoDh2elEJZHJxkM+sCKTGLRCrVg3XSlNACAYMGv/ruPBdRyBdX6/QPN5OzEQ
         xg76PVHC/cTJ12u8QE/5ezQ7ZadDYXdmSTipuXa2+zGMaghUE81o+lYiG6CB+zg46DwT
         nTJsWbQE3B2BuhLVM38ElqWxTBb/rpkMCH0ITUMQibDjJ2UNzwIZ9PuWsa5/JZdN+RGD
         4mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2rWkcFDLnOgbEh3iq32tzYD1sEh6ZH0IimGam4RIGZE=;
        b=HLEbtSogf2eOzIkYU1JLmAEqL2P9dDGoZlY3AtPU3Y3NtgdXceNoqlceB3iIN4hcsQ
         +M4YBQPyb25z8z1GHtWtX7TCs3xZbEHOkKazPYH6QDTZ7JiG9jZBn9dRt5lvNBcYJqqb
         X66H1cqngOxCkw6trdLRWUQDTVSxX08aWNhEtCdwo54GaovKjc/cJYIaGRQWxPtxHTTj
         MO5YknHsyz8IlLjEjOsCtgYCmk/+Nbg8v/KuxIZAp9l3PzfgyVf38F8Jh/rv0pBP08Q0
         6pxGhaKSZkcOc68ix8Q+wOtJkNhtq/a+i4ibwPfE7M3DtTlU8xbTBNICHB77t0b6Rb4h
         5GEA==
X-Gm-Message-State: AOAM532ToM/0jCXeFpSCXQfsLC+ruLPmQFQVZORCSvw7WDC8PkGsbmBE
        01M9CK81mwKXxvBfSQBnX1ELdT5b7H8=
X-Google-Smtp-Source: ABdhPJz7zmGI8HBTKBcM/7sSUF9igy3fik9SYVxpfPS8wc5gVIqVHW8WQKmh/08IlrsvT5/YON4B0A==
X-Received: by 2002:a5d:58c9:: with SMTP id o9mr5545465wrf.181.1616621556322;
        Wed, 24 Mar 2021 14:32:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm3769431wmd.21.2021.03.24.14.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:32:35 -0700 (PDT)
Message-Id: <689a7de56483fd9dbd87ad9cc358ccf671ccc1a7.1616621553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.git.1616621553.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 21:32:27 +0000
Subject: [PATCH 1/7] merge-ort: add data structures for in-memory caching of
 rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When there are many renames between the old base of a series of commits
and the new base for a series of commits, the sequence of merges
employed to transplant those commits (from a cherry-pick or rebase
operation) will repeatedly detect the exact same renames.  This is
wasted effort.

Add data structures which will be used to cache rename detection
results, along with the initialization and deallocation of these data
structures.  Future commits will populate these caches, detect the
appropriate circumstances when they can be used, and employ them to
avoid re-detecting the same renames repeatedly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 8258d3fd621e..0774152ea64a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -139,6 +139,37 @@ struct rename_info {
 	int callback_data_nr, callback_data_alloc;
 	char *callback_data_traverse_path;
 
+	/*
+	 * cached_pairs: Caching of renames and deletions.
+	 *
+	 * These are mappings recording renames and deletions of individual
+	 * files (not directories).  They are thus a map from an old
+	 * filename to either NULL (for deletions) or a new filename (for
+	 * renames).
+	 */
+	struct strmap cached_pairs[3];
+
+	/*
+	 * cached_target_names: just the destinations from cached_pairs
+	 *
+	 * We sometimes want a fast lookup to determine if a given filename
+	 * is one of the destinations in cached_pairs.  cached_target_names
+	 * is thus duplicative information, but it provides a fast lookup.
+	 */
+	struct strset cached_target_names[3];
+
+	/*
+	 * cached_irrelevant: Caching of rename_sources that aren't relevant.
+	 *
+	 * cached_pairs records both renames and deletes.  Sometimes we
+	 * do not know if a path is a rename or a delete because we pass
+	 * RELEVANT_LOCATION to diffcore_rename_extended() and based on
+	 * various optimizations it returns without detecting whether that
+	 * path is actually a rename or a delete.  We need to cache such
+	 * paths too, but separately from cached_pairs.
+	 */
+	struct strset cached_irrelevant[3];
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
@@ -381,6 +412,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		reinitialize ? strmap_partial_clear : strmap_clear;
 	void (*strintmap_func)(struct strintmap *) =
 		reinitialize ? strintmap_partial_clear : strintmap_clear;
+	void (*strset_func)(struct strset *) =
+		reinitialize ? strset_partial_clear : strset_clear;
 
 	/*
 	 * We marked opti->paths with strdup_strings = 0, so that we
@@ -424,6 +457,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_func(&renames->dir_renames[i], 0);
 
 		strintmap_func(&renames->relevant_sources[i]);
+		strset_func(&renames->cached_target_names[i]);
+		strmap_func(&renames->cached_pairs[i], 1);
+		strset_func(&renames->cached_irrelevant[i]);
 	}
 
 	if (!reinitialize) {
@@ -3675,6 +3711,12 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 					 NULL, 0);
 		strintmap_init_with_options(&renames->relevant_sources[i],
 					    0, NULL, 0);
+		strmap_init_with_options(&renames->cached_pairs[i],
+					 NULL, 1);
+		strset_init_with_options(&renames->cached_irrelevant[i],
+					 NULL, 1);
+		strset_init_with_options(&renames->cached_target_names[i],
+					 NULL, 0);
 	}
 
 	/*
-- 
gitgitgadget

