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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF08C4332D
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781B42223E
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbhAANIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbhAANId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:08:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4DAC0613ED
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d26so21922601wrb.12
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9pGFETYdqulowBLIqdiA0ZUCZfR86+rle0TskkGe5u8=;
        b=KzrYRFY8Ahdn21M45JdHPzyfzLbg/YJwJFao+ULjuvuuoWhyO3N6rNb4plN4Dznh8V
         t389wHrrWurR+hGPj6imjk6MEz/w9ahweP0wewQDK1jQEEkzEr+eorCdlIiXcKpzyyV5
         whZE9PluWzULR/QLVktvyEuuiyVhSPYrQIJynChGY9Mjlc1DWt/pk+fCRIagDFkiIE1i
         aq0V7l/NphOiX5RJVYx58hDBLB7G5YMAVwtqzAmPpI68chPFd6u6KSqONZC0gWmVT1re
         A0BtQxplfEh9bApki5GezyzIJaycgcOSUm9O5mY6AUrKQ7BKshrNvX1PeuJIU+pkmDBd
         M3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9pGFETYdqulowBLIqdiA0ZUCZfR86+rle0TskkGe5u8=;
        b=mCe8tXMtmXYqisSmhKUzKpeaSlQf63STKMf1r/ZsbMuYF+VK3ETISbtRwG6A/TSgy5
         e1qeaF7/6aJRUqnCb9I+RchOBvQ7Sf5MFgOd+3m9+OYtoU2zohM8KP2ERpUihbQA1j66
         7GKxj8fY/MGaDyZB0MpKN0Y8o+Bt2mw0cSYPrHvFWdpQXhJQG3utnW2hwDdjsjKxm2HJ
         NlKhJLqWl/dEl1FKpVurbYcsDqJxnP81O6T4z5OavlRtICqGUaiN1VxNvkGK6qFDJipg
         5JNJT48sS7ouaFtXEx2U5XJAU+U8DJ3lHNXV2+iU/CHVtJljaTMTrVQFwtkqXd+uAIYf
         Vkzw==
X-Gm-Message-State: AOAM530ZSGsObxGHHMw2n1b+qnFCt9a3TOugFna9iZqwshc/P4ZK7oHL
        YsS+deuudc0BLhmrpAldhPaZZxLa798=
X-Google-Smtp-Source: ABdhPJykBbDI6bDgqKhhXjF8/PokwuEwEeDX536mrYnp7c8P6NjTC6yTj4Pj/j5sOKVfORmuV6kmIg==
X-Received: by 2002:a5d:4241:: with SMTP id s1mr68773377wrr.269.1609506434566;
        Fri, 01 Jan 2021 05:07:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm74632892wrt.10.2021.01.01.05.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:14 -0800 (PST)
Message-Id: <cc5df3566dfa015b57582fe76f3f6e940d549017.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:01 +0000
Subject: [PATCH 05/12] update-index: use istate->cache over active_cache
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index c9a6cde97da..0616c786410 100644
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
@@ -440,7 +440,7 @@ static void chmod_path(char flip, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
-	ce = active_cache[pos];
+	ce = istate->cache[pos];
 	if (chmod_cache_entry(ce, flip) < 0)
 		goto fail;
 
@@ -639,7 +639,7 @@ static int unresolve_one(const char *path)
 		/* already merged */
 		pos = unmerge_cache_entry_at(pos);
 		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen))
@@ -653,7 +653,7 @@ static int unresolve_one(const char *path)
 		 */
 		pos = -pos-1;
 		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
 				fprintf(stderr,
@@ -749,7 +749,7 @@ static int do_reupdate(int ac, const char **av,
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

