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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F6DC43461
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15AB610CC
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhETGLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhETGLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED24C061760
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q5so16288587wrs.4
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VFJAojdBfJivKSDTeQnlRY27x1j06yeybqkAPaBsqfc=;
        b=vYHSqL0D2Mm+bOQiTDGxEdFG7jHBtVItuLfyF5eU/hi+GKzFgP97QJ2zuETfx2wPRY
         CWtH4vV8yxoPbv3+w7QsCoaz/diSzz+L8C+IZUYL8RlvihYwJ58kRgQ5rEd1Egu8WkMX
         rDZPEBvcHxQ0qMQkCiUOZb/M3OAztuk5oMRAg6pc2OpK/xf9ZWIjMqBD8vPdbUbdwyOh
         689p3JDXpRGzJ9yi4v9o85GVUipKzretW936+Bi346kXx7uKoLUKxiIUeVI2+/3+EdQl
         AM+x/df0KeLO6yPhy9bEuZ1XlTnux1b5QMBJCmZEpuj6fTLfyrtYcfTcVICwsrL7el5B
         PwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VFJAojdBfJivKSDTeQnlRY27x1j06yeybqkAPaBsqfc=;
        b=p/pWgjaVtWxlSV4nRZsPWmPCFJwPapYIOf5GCbrvoiftkb0jBytWcE9UIeqXYh0oWZ
         7a/Pmqh27fz9hlJKugJ6WtWNVyPWS/StpVwQUtfBnWfv01BlJTmdoAkPGurgqZCGwVjH
         jCxQyS/DpoEWzoR5yKjKbKE9oX9IDS4cNjyCus/XLz2a/YkNkBQ1++W/l6ox7LAryyOG
         GjXuHG+ks1/+HwSJjB8suTwzMnddLfRSTnEm/jlM+R9Q+HcYifJw8Dx2awnZS2T2Nlyy
         bQif9tnkBJPm1xsJgZb4snEpqvPoHE0KntG0h8OYLOIb/KJXj+yTE2/mI6y0PVbeLHL1
         13Vg==
X-Gm-Message-State: AOAM5310vmzkRHpz8hpsrLC/iQDcbVQrPq1rud2Dsm45oFZ4o5GKC3bA
        3pguFLgoH0a6CqbarCvQJtgtmYd4h1U=
X-Google-Smtp-Source: ABdhPJznbHheG60dqoD2L5CpXEEwink6ifaBS33K64igPVScxT+x0phxtEshyB7hwpcPexFdWpeyAw==
X-Received: by 2002:adf:f04f:: with SMTP id t15mr2259386wro.377.1621490987502;
        Wed, 19 May 2021 23:09:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm1711594wrt.97.2021.05.19.23.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:47 -0700 (PDT)
Message-Id: <304a2768c97b190ce982ea4090f461268b1e0b10.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:34 +0000
Subject: [PATCH v3 06/13] merge-ort: add data structures for in-memory caching
 of rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
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
 merge-ort.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b1795d838eaf..709445e817ad 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -140,6 +140,48 @@ struct rename_info {
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
+	 * If we try to detect a rename for a source path and succeed, it's
+	 * part of a rename.  If we try to detect a rename for a source path
+	 * and fail, then it's a delete.  If we do not try to detect a rename
+	 * for a path, then we don't know if it's a rename or a delete.  If
+	 * merge-ort doesn't think the path is relevant, then we just won't
+	 * cache anything for that path.  But there's a slight problem in
+	 * that merge-ort can think a path is RELEVANT_LOCATION, but due to
+	 * commit 9bd342137e ("diffcore-rename: determine which
+	 * relevant_sources are no longer relevant", 2021-03-13),
+	 * diffcore-rename can downgrade the path to RELEVANT_NO_MORE.  To
+	 * avoid excessive calls to diffcore_rename_extended() we still need
+	 * to cache such paths, though we cannot record them as either
+	 * renames or deletes.  So we cache them here as a "turned out to be
+	 * irrelevant *for this commit*" as they are often also irrelevant
+	 * for subsequent commits, though we will have to do some extra
+	 * checking to see whether such paths become relevant for rename
+	 * detection when cherry-picking/rebasing subsequent commits.
+	 */
+	struct strset cached_irrelevant[3];
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
@@ -382,6 +424,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		reinitialize ? strmap_partial_clear : strmap_clear;
 	void (*strintmap_func)(struct strintmap *) =
 		reinitialize ? strintmap_partial_clear : strintmap_clear;
+	void (*strset_func)(struct strset *) =
+		reinitialize ? strset_partial_clear : strset_clear;
 
 	/*
 	 * We marked opti->paths with strdup_strings = 0, so that we
@@ -425,6 +469,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_func(&renames->dir_renames[i], 0);
 
 		strintmap_func(&renames->relevant_sources[i]);
+		strset_func(&renames->cached_target_names[i]);
+		strmap_func(&renames->cached_pairs[i], 1);
+		strset_func(&renames->cached_irrelevant[i]);
 	}
 
 	if (!reinitialize) {
@@ -3667,6 +3714,12 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
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

