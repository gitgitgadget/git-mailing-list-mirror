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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EAEC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C5B23AC0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbhAHUEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbhAHUEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504ABC06129D
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n16so7341792wmc.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xMtarFkCXXf3v10b7WLr59mTF67kLoe+kFVV2c39wR4=;
        b=nTpeTRX6nG63PjMNzj5vGMcYqsG1HQce/OEVG/mozIy8hSJ5/kBnV611qwfThVZeBv
         jB7w3NAvecFpcg+jlMy/u3AEzfidn8FicWDvwGrzKyL7HluyNAPZs5v+cnMpRgMih6i8
         BkPDNNPcAFjhhDeY49eHA/n2eWLftQdhx2gOBV6C9rRHXtkpdLWDgz6SVKjDyhEglCh1
         xUT713v5kLJaQmTzjUogLrb5CIQHvjbdqaDJ+JX3hr3znGx6VJ6RLLv/xxxsqQhYLahN
         3SlNSyTfqfUFMjqZpaaNPd3mY8G6O5sh+awHpLRrVZip3lpdesfyRuBYKEnEs4ztRHuP
         knpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xMtarFkCXXf3v10b7WLr59mTF67kLoe+kFVV2c39wR4=;
        b=k61TKiC//tKUceh8uSRoEnEdaGwr0MDyK4Tg1K915v5srfyX+OvA63GqbZ2K0EmKm6
         omX4YOMsMhxpVjbw4XITtsk2432pmJp3UTWXunDIfjyB7VWbJWkgjahvkFQ5t4cIn7Up
         hb4Vdt2P5GcmYM2SY9SbNdLKbD8CMVSLvtVdffbM0782Ip4wjPBb4shtA/qtLIPlvx3/
         2HPTN0YnZO1yggQcDh2YEoa/k1LZ2+N0LQRoZhpY82GoNTRneyUifbck2hNjZCIe5Zzc
         PCoHgYRZdcNaW5ipJ1R16J748BeZXGAyQYVdCCQrSOnaBfTtrR44Tg4tmZf4nTtrQw8g
         Ssgg==
X-Gm-Message-State: AOAM5328Sa6WWdyGWGZZyn1wN0SQCcYwTJZIkD3PfmREC3vfB+N/4ezm
        UtJCkdWEf5mC9TkxuX1q2nnPJquBmU8=
X-Google-Smtp-Source: ABdhPJwK2yavMHMzD7Jelf84d0QHQUtQ0295GbL9+iO3Pkmaxg7i7HXEs/CR+VirmVTXoxegHCkhCg==
X-Received: by 2002:a1c:c204:: with SMTP id s4mr4369110wmf.73.1610136183696;
        Fri, 08 Jan 2021 12:03:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm12428162wmc.44.2021.01.08.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:03 -0800 (PST)
Message-Id: <586371ee769f61cc42957bd53bd6a257eacec211.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:48 +0000
Subject: [PATCH v3 05/14] update-index: use istate->cache_nr over active_nr
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

Also use "repo->index" over "istate" when possible.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 0c5a10f5dba..2b03b29261b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -345,7 +345,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* Inexact match: is there perhaps a subdirectory match? */
 	pos = -pos-1;
-	while (pos < active_nr) {
+	while (pos < istate->cache_nr) {
 		const struct cache_entry *ce = istate->cache[pos++];
 
 		if (strncmp(ce->name, path, len))
@@ -627,7 +627,7 @@ static int unresolve_one(const char *path)
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_cache_entry_at(pos);
-		if (pos < active_nr) {
+		if (pos < repo->index->cache_nr) {
 			const struct cache_entry *ce = repo->index->cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) == namelen &&
@@ -641,7 +641,7 @@ static int unresolve_one(const char *path)
 		 * want to do anything in the former case.
 		 */
 		pos = -pos-1;
-		if (pos < active_nr) {
+		if (pos < repo->index->cache_nr) {
 			const struct cache_entry *ce = repo->index->cache[pos];
 			if (ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
@@ -737,7 +737,7 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
-	for (pos = 0; pos < active_nr; pos++) {
+	for (pos = 0; pos < repo->index->cache_nr; pos++) {
 		const struct cache_entry *ce = repo->index->cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
@@ -755,14 +755,14 @@ static int do_reupdate(int ac, const char **av,
 		}
 		/* Be careful.  The working tree may not have the
 		 * path anymore, in which case, under 'allow_remove',
-		 * or worse yet 'allow_replace', active_nr may decrease.
+		 * or worse yet 'allow_replace', repo->index->cache_nr may decrease.
 		 */
-		save_nr = active_nr;
+		save_nr = repo->index->cache_nr;
 		path = xstrdup(ce->name);
 		update_one(path);
 		free(path);
 		discard_cache_entry(old);
-		if (save_nr != active_nr)
+		if (save_nr != repo->index->cache_nr)
 			goto redo;
 	}
 	clear_pathspec(&pathspec);
-- 
gitgitgadget

