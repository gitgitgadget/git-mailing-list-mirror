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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19FFC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734FB611CD
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhEDCNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhEDCNW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F98C061574
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v12so7571623wrq.6
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XS1CQERRQXHEjAgU2tvYDdnFDoyFf+4tzduFgU874gM=;
        b=ZBtHeCb6ndXLPEP1gLxYnsf6JaMH9znorj4YBeGEEiDw0WEcw4uEalmfgVOlTcqPSz
         E+TTlBcArWAjLQXYw2Q198o3VnTpZIax5yqH54tvcU22T4Ytpc0YPSbfCrg92ilXbmCu
         JOF0yYPseTGAJDWiWb3qZUm9CRsZ497x4v76SoSvxMMdNlkbM3J/hxyqYg9xA77w1NEm
         IcyANvZB02IvM1ZQvPIi6/aagUWQAFd6r4yEp/pu0+DVynf6cbqMOgfOLSisRA7PMk0B
         xdlc1ZPjfxYCgevqRfTqD64jj/k18YxrNZEL6+XVphWjLn96n2LtnITJiJimXRgbbPtc
         2TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XS1CQERRQXHEjAgU2tvYDdnFDoyFf+4tzduFgU874gM=;
        b=Zzx5eML4FgC65wCOzVBCgCb7nreROTzo4tQ8dNX2Mkcf7dYsQTO1qqyXgQKByXtVMC
         Ikpk5hDiKkmrzUCgMdUc8foK7kqlSXZ9ywjdQqN7rwel2fQB6MX8aUul55xSrnBAEf5U
         kSJf3elmS+hLb4lTXrfrAeaE78mWb3fnmueWGWFaW6JtpXni1d/t/25g6u40LFkTPwXX
         UOwtjAkaR2Q2e4sib+zaVFgRQ3ZnHllWKu5ShzW2Vn8AO9MV1U3owHBE0sxlBBSnoT+z
         6AlN+v61y/k3Qe8cGXmFM9tKhj44bzuLljMSddU1LchOjyV0aNEXcTonqEt2ktABUlBH
         IyNQ==
X-Gm-Message-State: AOAM533NjJamxPwD2ilyVwX7CGUmh/RU+fSEFylQM7R9D1gsm71O/mTV
        BNZJrz2zY5U8lmGBzssfR3/6UhDGOMs=
X-Google-Smtp-Source: ABdhPJwjcqBTxcNSu7ge6WlNIpHEWuxsLdgOGXohMxOUEi6tZ5eX8usfjzIY95Jqagl8GLBoT375sQ==
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr20213426wrt.131.1620094346588;
        Mon, 03 May 2021 19:12:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9sm1168604wmc.38.2021.05.03.19.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:26 -0700 (PDT)
Message-Id: <2a9e73de2beef5f51ad76fe1d9aaaed926a5fce8.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:12 +0000
Subject: [PATCH v2 06/13] merge-ort: add data structures for in-memory caching
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
 merge-ort.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b1795d838eaf..8602f88a960c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -140,6 +140,37 @@ struct rename_info {
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
@@ -382,6 +413,8 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		reinitialize ? strmap_partial_clear : strmap_clear;
 	void (*strintmap_func)(struct strintmap *) =
 		reinitialize ? strintmap_partial_clear : strintmap_clear;
+	void (*strset_func)(struct strset *) =
+		reinitialize ? strset_partial_clear : strset_clear;
 
 	/*
 	 * We marked opti->paths with strdup_strings = 0, so that we
@@ -425,6 +458,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_func(&renames->dir_renames[i], 0);
 
 		strintmap_func(&renames->relevant_sources[i]);
+		strset_func(&renames->cached_target_names[i]);
+		strmap_func(&renames->cached_pairs[i], 1);
+		strset_func(&renames->cached_irrelevant[i]);
 	}
 
 	if (!reinitialize) {
@@ -3667,6 +3703,12 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
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

