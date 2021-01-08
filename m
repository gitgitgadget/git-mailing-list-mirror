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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB45C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7E123ABA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbhAHUD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbhAHUD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:03:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B7C06129C
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m5so10107770wrx.9
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ogiS5dB7FcwEbFzUilxWg7l0FMJl93G7xV7dDQotmg=;
        b=RlJ6/ZnewnLuqgVkvAORcHSSojN978bDTRkr4ss8weYeQYpX/cCMwEfpfnL1xcai0Q
         sob0jaA3ramS6sdMEmy2fW4lNRXhR6lnuKCkQDZI0OgcXMs3OP5mG2pwYR128NryA4t8
         WXK9c6l/cGOn2FnpIs6LJijVxSryzlau/tYpwrDprsrhVTb1+8uk8UH5+hxit41EpIB0
         pVoUXqGywdalXChXiFGcrPXSWFNCeQQgDykTN/V7b/rKrS9HwKoOaKJqU6Vk2I7xiZwN
         NDyno34Vk4V+ap96uHsbLahixgBfrZpLTr8BLTqH2VzeFdZZCrWMO27a5bzwGfAIo34U
         qwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4ogiS5dB7FcwEbFzUilxWg7l0FMJl93G7xV7dDQotmg=;
        b=Z778Vfh4s0bgZsCqVg4JfP7Pfnh9xvs9IihVMbUa3HU2sSVEpUh6qspeUzAZ2+7IQm
         Ij77MaxtM1gqAOyBPTvG1zKQRzVS4KLIGD9CEseQOYj2tULyHdGrnIsC+TjBdBvP/AAE
         m73gxO75NEm94JJ0fXEXpHjdnb8ANcV56XYKg87esOjPcQInXbKlqNMxnfDgs2BEjpZN
         JvXTYhhuvXAmoWkkgFAiXR7BvTT+0XNeTSa4x87tpBd3AkVHQREt0E9VQ+eedv7xsM2s
         F/3l0j7LANk8YE4fbzwAKaZYE3GzDQNgdbfN1/5MKkMI3LvII3q6zqM51txIFQM9nRqQ
         0V7w==
X-Gm-Message-State: AOAM533Bfg4UrwWtG7dyBmFMFboONWva/JTPGvqnBdbKRO1jKQEXO+9/
        Eu2A3vKcSAeOR1DLfYCVJEtDpi9nRIU=
X-Google-Smtp-Source: ABdhPJzoeFL+c1KxBvu9pId6dS8hmbD1oBk0mqeNWLxWYNDQFPBZiurJgXLRqpHXmaq4ofew2nlxBQ==
X-Received: by 2002:adf:e406:: with SMTP id g6mr5187850wrm.255.1610136182754;
        Fri, 08 Jan 2021 12:03:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm14833161wrq.64.2021.01.08.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:02 -0800 (PST)
Message-Id: <b8fcdd8b3da062e3e14a5d755870dffe313fc495.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:47 +0000
Subject: [PATCH v3 04/14] update-index: use istate->cache over active_cache
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

Also use repo->index over istate, when possible.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 22284f301dc..0c5a10f5dba 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -234,12 +234,12 @@ static int mark_ce_flags(const char *path, int flag, int mark)
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
@@ -330,7 +330,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = istate->cache[pos];
 		if (S_ISGITLINK(ce->ce_mode)) {
 
 			/* Do nothing to the index if there is no HEAD! */
@@ -346,7 +346,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 	/* Inexact match: is there perhaps a subdirectory match? */
 	pos = -pos-1;
 	while (pos < active_nr) {
-		const struct cache_entry *ce = active_cache[pos++];
+		const struct cache_entry *ce = istate->cache[pos++];
 
 		if (strncmp(ce->name, path, len))
 			break;
@@ -377,7 +377,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		return error("'%s' is beyond a symbolic link", path);
 
 	pos = cache_name_pos(path, len);
-	ce = pos < 0 ? NULL : active_cache[pos];
+	ce = pos < 0 ? NULL : istate->cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
 		 * working directory version is assumed "good"
@@ -428,7 +428,7 @@ static void chmod_path(char flip, const char *path)
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
+			const struct cache_entry *ce = repo->index->cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen))
@@ -642,7 +642,7 @@ static int unresolve_one(const char *path)
 		 */
 		pos = -pos-1;
 		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+			const struct cache_entry *ce = repo->index->cache[pos];
 			if (ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
 				fprintf(stderr,
@@ -738,7 +738,7 @@ static int do_reupdate(int ac, const char **av,
 		has_head = 0;
  redo:
 	for (pos = 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = repo->index->cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
 		char *path;
-- 
gitgitgadget

