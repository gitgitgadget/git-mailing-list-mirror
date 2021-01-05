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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF9C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5029227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbhAEEoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbhAEEoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB654C06179A
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c5so34866595wrp.6
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1hoL6dpakMgJMT9kbSjsU1Q+dHl9b5qV0/mlWtinvuQ=;
        b=h1xEHvYOmWgX2QlaGFg+VlmTcg/y4DgyVGWNgGaQCGBWHqdA0+M6pLGmH50D9e2BsO
         PcYuNOjNGxXDEr9l3rdEHeqh52KOV18JR3L+Oc+onlfN20KUb7snTUnwlhyX4nwEnYfy
         M/hzmQzuhXC1IQx2XmtGndgQeRPrqvjPTUqlwXC8nQAyfyqcRzHGhuwGKl+vYmepFbLU
         sVwHghEay4gRXaHsupFyVs8lqps+sFTVict4fWFYSGEzkzmtEMIBGI0MgeKX08OQZgww
         IcFEmJ74cl1hQV9zDU3gMwLOfuwA8k8zZcVonP8TJBNRHUFh/ZqY0SzCM6ltnyMhy+4/
         vESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1hoL6dpakMgJMT9kbSjsU1Q+dHl9b5qV0/mlWtinvuQ=;
        b=aK+jzreMGg6W9f11fh1xJ1P2Co1RPjYWvThxHuj+Bpdy7hAgAz9wEDQX+je8r2gKFl
         enB+DYcuEaYt45Uwuo+rZRQnlv69FN8BAXDeannpGU/tcSPzsYQQDAbVLKi9j3hizvXD
         H26rGw87+Q3Cf6gL57esGkcLxoobUvt2NXzI/QPBYLwK/8ypl1SciGtxUBtp9bRwmNSX
         OmClA4GmaKTEj2IaKk1UjsE/K8McccopZQ91JwlmKHtrgvlAAb8biA5nhfDgAvXwKAeo
         qij0mGqH8iPJhZVxJnnf8o5UPlOVePVkMRKvOF18n46AGq/t7kA4pgrFcHkMmEGhxxhd
         XiVA==
X-Gm-Message-State: AOAM5339BtLExMLLUQk4bUwMUdOFRQv3SXOgMeCd7wIC4NwbFXg1xPgW
        ZPqrVJ+8QslJSJwlqzs1/hzfdstBBO8=
X-Google-Smtp-Source: ABdhPJyD1MbHei7pOTuKNn+aXAe0HVRxsscFZQk6/2dQb37MUjFFomUHOAU4JEiaFGifvTlZvNqOAw==
X-Received: by 2002:a5d:678c:: with SMTP id v12mr85654065wru.115.1609821789279;
        Mon, 04 Jan 2021 20:43:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm99570401wrb.92.2021.01.04.20.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:08 -0800 (PST)
Message-Id: <6c0e019f91ce50bef8a98ac60072a61c77710080.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:54 +0000
Subject: [PATCH v2 05/14] update-index: use index->cache_nr over active_nr
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
 builtin/update-index.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3e459d2b9de..106bfdab78e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -346,7 +346,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 
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
+		if (pos < istate->cache_nr) {
 			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) == namelen &&
@@ -641,7 +641,7 @@ static int unresolve_one(const char *path)
 		 * want to do anything in the former case.
 		 */
 		pos = -pos-1;
-		if (pos < active_nr) {
+		if (pos < istate->cache_nr) {
 			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
@@ -737,7 +737,7 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
-	for (pos = 0; pos < active_nr; pos++) {
+	for (pos = 0; pos < istate->cache_nr; pos++) {
 		const struct cache_entry *ce = istate->cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
@@ -755,14 +755,14 @@ static int do_reupdate(int ac, const char **av,
 		}
 		/* Be careful.  The working tree may not have the
 		 * path anymore, in which case, under 'allow_remove',
-		 * or worse yet 'allow_replace', active_nr may decrease.
+		 * or worse yet 'allow_replace', istate->cache_nr may decrease.
 		 */
-		save_nr = active_nr;
+		save_nr = istate->cache_nr;
 		path = xstrdup(ce->name);
 		update_one(path);
 		free(path);
 		discard_cache_entry(old);
-		if (save_nr != active_nr)
+		if (save_nr != istate->cache_nr)
 			goto redo;
 	}
 	clear_pathspec(&pathspec);
-- 
gitgitgadget

