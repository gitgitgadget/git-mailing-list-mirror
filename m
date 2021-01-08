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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A2C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBE823AC0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbhAHUEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbhAHUEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D91C0612A3
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n16so7341834wmc.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PFxyY3CjN99QIFwMQAf6TXXsTDJK41SUyzIXVoFNe/Y=;
        b=n+Ru3JpCifiSBQkXrkxANrsfZ//GYoUlx+I0Wc4i5sjwIq9OEPrTYtzP9ruB3/ArCA
         Bsx04gQ4gejJ3qpRzMH5fpikgTZFfBkdAJ5qMEiJ7uYvcDvbYSaKclpEVi0923jjf3Zu
         uVO2Kx98CB3B2wVGItlJfbos3KGT8ZntsPQAI0p66FA7vGpsSUsrAVQ1+fr6SugmyYLH
         xflHqX3yfkm8CwhCg5QOYW4l/tJ7iiChtq0Ene1WOSL7WBnt/1tY633IIOqubwZxoJWu
         KHOzju8mwKoTVTWS8KJ0rLs37jLphQ1C5WpesY4xF/TJWnkmdQRhaIlyoyywaO4ZPAwi
         pPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PFxyY3CjN99QIFwMQAf6TXXsTDJK41SUyzIXVoFNe/Y=;
        b=sZzQlCbna3h8gXVc1kvWf9F12mFXzxxHFjH6zZXdOWwjmIDtE23ww3Mlh+q00HMfMu
         pGQge0Kow7tkPGfkpz0hISARa+WyINgih4Z5iUrjvpixFLRdsA+g88JnwIi45Id4TqPV
         8IdegFaEH3QEW+PuXeiozJI0MZJ2GDGa3g8jQ3537xyBUmuOz7br2wCX5BozkG2PR79d
         m4B0yYXDAGOan/BuQ+fFXYWD2EWUfaHm6zA8ejr6pUfjmsQvYZHCo8sBYsh5ebS2OG1w
         TyW6feyeGcfbYR67Ih//oiJb1l80HSQ39IqZriDniOR2438pQtxn5zjcxzt1YNwXG9IG
         1rpA==
X-Gm-Message-State: AOAM533VZDi1ee+HScD9kGftKj6v7wEdoRIv3yBzIqItkg/KLz7eqF4y
        R+XbT3GTrWvbL9X4Fh2jSduVNxG4IiI=
X-Google-Smtp-Source: ABdhPJyMTwqwTAinBREFJrJ1R6uRIg17jWBMDSKa/gkrF0aQC43uxzLRCw5KHWbQtI2HqvBaJcopWw==
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr4550271wml.4.1610136185693;
        Fri, 08 Jan 2021 12:03:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm19570888wmc.1.2021.01.08.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:05 -0800 (PST)
Message-Id: <fc640ae6e652c175e2bbbe7bba3b856ae20265d1.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:50 +0000
Subject: [PATCH v3 07/14] update-index: use index_name_pos() over
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
index 70ca47e712c..a24b1fc90e4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -232,7 +232,7 @@ static struct index_state *istate;
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
-	int pos = cache_name_pos(path, namelen);
+	int pos = index_name_pos(istate, path, namelen);
 	if (0 <= pos) {
 		mark_fsmonitor_invalid(istate, istate->cache[pos]);
 		if (mark)
@@ -326,7 +326,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 static int process_directory(const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
-	int pos = cache_name_pos(path, len);
+	int pos = index_name_pos(istate, path, len);
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
@@ -376,7 +376,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
 
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(istate, path, len);
 	ce = pos < 0 ? NULL : istate->cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
@@ -425,7 +425,7 @@ static void chmod_path(char flip, const char *path)
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
+	pos = index_name_pos(repo->index, path, namelen);
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_cache_entry_at(pos);
-- 
gitgitgadget

