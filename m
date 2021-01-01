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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7B5C43381
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E76B2222D
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbhAANIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbhAANIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:08:35 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98659C06179F
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 3so8999720wmg.4
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZYUrHXcPlVY5K+6jnNEXRdluLuJzzsuNnPoeZiIYESA=;
        b=YuBb7JZciWCHFFWJRq0L+fZj2dx82DNC4UuZcPDc42169XRh6gVIB9rs2hwNbKY5WQ
         Bd76xPTa9hSunpvp7hcRYUQIv7hbYjCHbCe3LJBgxCxjhCUn7BXCwRu2LkjlZ5R5+YK4
         VGNOp4yxiX7vkKGeazM8AOZvHS0JmUbePE7km/rlr3Tl0BNyPEnzcP0qqka4xldOgqSE
         OOHxV3ES+OLdpjT3NYzIlD1Y4o6fz/zdGejVAMFrsHYi+gKpeSNopZ1dWf4gUS4nF2o+
         spfnVVML0sgPi8ncz32OVjTMrolSAtZRj+T6XtYZQKDVHOu6lBfzTsChm5/OA/Ld2SrR
         UImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZYUrHXcPlVY5K+6jnNEXRdluLuJzzsuNnPoeZiIYESA=;
        b=tnMNPCqP0CxU+6cUBIS1vgunsD+MzTcNVU80jk3NxqSJwTEUSp2FoiO+me515kC3xJ
         SX9hPrV1rbzSxtU47FVO/HN+gUNlwIwaoUvB+eaXDX8A8Pd+YgbbE3B/ytEz6MIuOHwW
         3gFc2gTX98qzAELKgXxpljGxDI7jvyau1Xg2G2vgWKf5bB1ZSlABED6EFnI8VAeLNctt
         GZzXbBKFLvHLpvm5FgHoJFsxz4/iKv1zPdLiupP8BUMyPF28NXNHH+ChhcMik2jk9Gfk
         KpOnfv47FrA048McSqhZp9EVyvoiLeehfM9ZAMIwskNsGv2GEY636ItKsfJmhNFKKLFD
         Yc7g==
X-Gm-Message-State: AOAM532z4hE8rRbeGDxPrlfyOqsc0yinf0TSSbC5RFwxR3LTmG1Vf1vK
        U75RCCzPYoe8qyr6mSRWpUJ6esY+G1k=
X-Google-Smtp-Source: ABdhPJwZ5rvqMObFrvAWa1V7URF71jTVn6QF1ZqTvYeZKSbZFHzRGyRs6kTckndpW6/vtWk8XEqYnw==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr15720427wmi.179.1609506439273;
        Fri, 01 Jan 2021 05:07:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g192sm17162062wme.48.2021.01.01.05.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:18 -0800 (PST)
Message-Id: <d7856e2e772afdd07ba9531377a528099b46b8c2.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:07 +0000
Subject: [PATCH 11/12] update-index: replace several compatibility macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is also the last usage of unmerge_cache_entry_at(), so it can be
removed from cache.h.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 11 ++++++-----
 cache.h                |  1 -
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 577ae2391b7..4da0c169dc7 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -441,7 +441,7 @@ static void chmod_path(char flip, const char *path)
 	if (pos < 0)
 		goto fail;
 	ce = istate->cache[pos];
-	if (chmod_cache_entry(ce, flip) < 0)
+	if (chmod_index_entry(istate, ce, flip) < 0)
 		goto fail;
 
 	report("chmod %cx '%s'", flip, path);
@@ -637,7 +637,7 @@ static int unresolve_one(const char *path)
 	pos = index_name_pos(istate, path, namelen);
 	if (0 <= pos) {
 		/* already merged */
-		pos = unmerge_cache_entry_at(pos);
+		pos = unmerge_index_entry_at(istate, pos);
 		if (pos < istate->cache_nr) {
 			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_stage(ce) &&
@@ -788,8 +788,9 @@ struct refresh_params {
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
-	read_cache();
-	*o->has_errors |= refresh_cache(o->flags | flag);
+	repo_read_index(repo);
+	*o->has_errors |= refresh_index(istate, o->flags | flag,
+					NULL, NULL, NULL);
 	return 0;
 }
 
@@ -825,7 +826,7 @@ static int resolve_undo_clear_callback(const struct option *opt,
 {
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	resolve_undo_clear();
+	resolve_undo_clear_index(istate);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 7bfb8195d97..dfcbc4923e2 100644
--- a/cache.h
+++ b/cache.h
@@ -421,7 +421,6 @@ extern struct index_state the_index;
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
-#define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
-- 
gitgitgadget

