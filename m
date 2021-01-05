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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED87C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D50227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbhAEEoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbhAEEoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501DC061798
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r3so34908301wrt.2
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4NDrbhT170uFBvoekGGO1YbXK+r7+BGK9A0+ou0b/YM=;
        b=vJLIgw2NcIrCbzHqvQ9xZA34qrQuKdBEK4u0GeAcbUQ6sdH5DOLV+mLB28LMDFmwu4
         cLKpoaY0vVFLPuKYIkpk2SJLJSiyrbUyncY05gQWTlXWsCpYlL0v2BXrXCM4hoGnbwyh
         hSYU/t7CgjncpKFCOK7ChtlRrWByAd7MmNTrrDhrOrQGX2ecs9uVuDe98Lk7MVTO5cRf
         l1qxA7jeTJP+x9Q/sovS0Ng+tWCKPDRE6jii+FyjRCN4AwU53wfQsOfeHBvzarkjrKo3
         70yuOFXvw3CyBF1Aq9ihMKDE7942rCDPKuR+Epjkh4MkzTEj/mo9yCe+QhVWI3OT0AYg
         SnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4NDrbhT170uFBvoekGGO1YbXK+r7+BGK9A0+ou0b/YM=;
        b=hnz7xfu6HhOVoqofjjh58qE9EcM7ZFfQDOnSg3awxQeIpcU/bljWbwjawdphc8lGqv
         FUCZgx7VoZqhsW9rBiSLWzQUwEEPkGfePuNLnzsbJsAzK8MgAlLgNlxIx1ArUfmXK4Fn
         gRppycN+hnYIYNn97/LqUe+W82mCgA+HL2LjYDiwMnzPWcxITs612+m6X+ilhXR412uf
         u+J0SyCLvn/3JEsLfMOiAXNIqTebaNkmpn6dQszckGd+vUMIhvy9sP5ERUaiMEDS+JAl
         XQNh7LiMf++olPPESN20nlE32aM+ewx5V6WvfFhuCXFmC6Q06S7nI2DUVRtWqPGDz1ri
         4CBA==
X-Gm-Message-State: AOAM5331ughB4LU61T9qwtMz0p1FGwCuzab7gM/BoeDWNMkHePOy+HX2
        JmwTBVdZf3uAFURu8JMD6ERLs/TQLHc=
X-Google-Smtp-Source: ABdhPJzN9we/uHX56uaSVJJciTuvfX94LQRWN0A/kB04fGJs+Vb6rPKhczofydLEWXp43TFW/uM1lw==
X-Received: by 2002:adf:8145:: with SMTP id 63mr80059084wrm.8.1609821788440;
        Mon, 04 Jan 2021 20:43:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm2265013wmc.44.2021.01.04.20.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:07 -0800 (PST)
Message-Id: <4b509ba5fa283d29c320e39a9225fadf966e53a8.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:53 +0000
Subject: [PATCH v2 04/14] update-index: use istate->cache over active_cache
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
 builtin/update-index.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index dde5b01a949..3e459d2b9de 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -235,12 +235,12 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	int namelen = strlen(path);
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
-		mark_fsmonitor_invalid(istate, active_cache[pos]);
+		mark_fsmonitor_invalid(istate, istate->cache[pos]);
 		if (mark)
-			active_cache[pos]->ce_flags |= flag;
+			istate->cache[pos]->ce_flags |= flag;
 		else
-			active_cache[pos]->ce_flags &= ~flag;
-		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
+			istate->cache[pos]->ce_flags &= ~flag;
+		istate->cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
 		cache_tree_invalidate_path(istate, path);
 		active_cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
@@ -331,7 +331,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = istate->cache[pos];
 		if (S_ISGITLINK(ce->ce_mode)) {
 
 			/* Do nothing to the index if there is no HEAD! */
@@ -347,7 +347,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 	/* Inexact match: is there perhaps a subdirectory match? */
 	pos = -pos-1;
 	while (pos < active_nr) {
-		const struct cache_entry *ce = active_cache[pos++];
+		const struct cache_entry *ce = istate->cache[pos++];
 
 		if (strncmp(ce->name, path, len))
 			break;
@@ -378,7 +378,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		return error("'%s' is beyond a symbolic link", path);
 
 	pos = cache_name_pos(path, len);
-	ce = pos < 0 ? NULL : active_cache[pos];
+	ce = pos < 0 ? NULL : istate->cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
 		 * working directory version is assumed "good"
@@ -429,7 +429,7 @@ static void chmod_path(char flip, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
-	ce = active_cache[pos];
+	ce = istate->cache[pos];
 	if (chmod_cache_entry(ce, flip) < 0)
 		goto fail;
 
@@ -628,7 +628,7 @@ static int unresolve_one(const char *path)
 		/* already merged */
 		pos = unmerge_cache_entry_at(pos);
 		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen))
@@ -642,7 +642,7 @@ static int unresolve_one(const char *path)
 		 */
 		pos = -pos-1;
 		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
 				fprintf(stderr,
@@ -738,7 +738,7 @@ static int do_reupdate(int ac, const char **av,
 		has_head = 0;
  redo:
 	for (pos = 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = istate->cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
 		char *path;
-- 
gitgitgadget

