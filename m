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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593C2C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFAB227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbhAEEoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbhAEEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58300C06179F
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a6so1869813wmc.2
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N0hmkF+LncZsfqN5AU5+oGPwMIQ48eBXCRGzFvacOos=;
        b=QWal3aRbyTJdseFX4V5FI46fGMizNW49/OpJkWXnJsvmDhZo43CVEHCWeJmRuzxdsU
         v6g+7DiyLQba4g/pGPz5e3B/P3/0GwDspdjZhxRtpGCbhlg3j9YfZxG38nzWXzuEBfLQ
         0ohWZcDLsTFhmuFSNcsXLJnWCUf+K/hqBXLCxtGaQi80R0hhGIqrwM0SF19JrYgd32FK
         Q9Q/5JjN5JJpMDvq7wAPexpix9Bdj4+1GaidNkRGS7941cY5bB+1kdmOvVzOK+1nHTuA
         KcK5sq1NGdDLKvyXY5EP99tHZyeJc0/Z2zGJXQIMfIMJqh+Pcl6iEHYlO2wi3VFUZwYn
         0ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N0hmkF+LncZsfqN5AU5+oGPwMIQ48eBXCRGzFvacOos=;
        b=rY2m3eExfJXrnzLaD7mFoJ7FDoTUEoyVzydoTbFpluOsKoYbFo7TKXMNUvSpHMVrRk
         KtTvC1SeoDW1ZOr68bDNq43X40um6Iwx8Ht2YIZ5Ac6xrSFfgpoboGR9ldXpfJI8L6N2
         QxNuaZ8LMk3S3ucZGA6NXy0ycIdqZSompypyRq6L/G0FjWBTE/NJ+E0sPi4R50ByQEUM
         gc+IS/RfdXp2yR0soMCpUiuJ4XWA/ITq/bQr6nbYQGcawXSt/01tJzMB0rwV1zU8FW6h
         kXilm69cGVs+1cWPvmQqs+0Pjuy3YfjUMu5tyWzBHXynn/HtPkaXrzJpvtO5s/QzL3Rm
         MYQw==
X-Gm-Message-State: AOAM530g5fLunqvcTlLfhABFkY7mfjCJIekuLQdtz60ixdIV5UzkP5/J
        ZjmpzJtjmKIRUdg1TD6Lw5hyfxNgO5I=
X-Google-Smtp-Source: ABdhPJyhIUJB74OQuOBJK0SJWV15qfnwqBpo/g+dGDa6W2yE0qmNNpzJH50mtAqFByrj+OHV7SgIMA==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr1685800wmi.113.1609821790980;
        Mon, 04 Jan 2021 20:43:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm98128917wro.27.2021.01.04.20.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:10 -0800 (PST)
Message-Id: <5b14fa10a4bec330bb31e9c7cb2c4375ce914ca9.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:56 +0000
Subject: [PATCH v2 07/14] update-index: use index_name_pos() over
 cache_name_pos()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 346d798c60b..096cbdfa8ac 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -233,7 +233,7 @@ static int test_if_untracked_cache_is_supported(void)
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
-	int pos = cache_name_pos(path, namelen);
+	int pos = index_name_pos(istate, path, namelen);
 	if (0 <= pos) {
 		mark_fsmonitor_invalid(istate, istate->cache[pos]);
 		if (mark)
@@ -327,7 +327,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 static int process_directory(const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
-	int pos = cache_name_pos(path, len);
+	int pos = index_name_pos(istate, path, len);
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
@@ -377,7 +377,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
 
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(istate, path, len);
 	ce = pos < 0 ? NULL : istate->cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
@@ -426,7 +426,7 @@ static void chmod_path(char flip, const char *path)
 	int pos;
 	struct cache_entry *ce;
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(istate, path, strlen(path));
 	if (pos < 0)
 		goto fail;
 	ce = istate->cache[pos];
@@ -623,7 +623,7 @@ static int unresolve_one(const char *path)
 	struct cache_entry *ce_2 = NULL, *ce_3 = NULL;
 
 	/* See if there is such entry in the index. */
-	pos = cache_name_pos(path, namelen);
+	pos = index_name_pos(istate, path, namelen);
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_cache_entry_at(pos);
-- 
gitgitgadget

