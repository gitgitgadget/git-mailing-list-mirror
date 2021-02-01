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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C1C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518E864EC3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhBAWE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhBAWDh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B65C061793
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o10so745451wmc.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fkxMogoHr5h4CV44ECW6UTWZy4JBxE27oGdnxv+/Kac=;
        b=N1IujNPiS87yitCLyOV80brW7kkdbs56Pa1eOML1Cabr+JH8FjkJe1tEVDPAWuda6n
         P2BFXZq6f4kJGwixY1C0noOUEFebHkoNU/S5WTNXuR7QTXrZnb0gMVx/M/1+y/WcyIT+
         NgvTTyKP7g1QBMtmQwjgz5/hH/gnteebM69b4uogseWBDA/2uBBZUHRGxm5VZP8M7doJ
         h+FuH5kxN2233wbqW6W/HO3g90Gu8PeNDEctnbtVeiGu5t+y/zQwqthKsQpuytn4E48Z
         X5hOTpdVYJbKIzXkJ2gZgGlnfV4fR8T0ZHXpWVoJecp4abLvjo7E8q0vJX0nH2o7eQQ+
         DW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fkxMogoHr5h4CV44ECW6UTWZy4JBxE27oGdnxv+/Kac=;
        b=klstmC/peRr2RJPZtbNAvUvn3/sTdDHTNrOacwKwMMrawBa1P/MhrhQYaXi5GHa6GI
         8E4RsA9KuBJAapvAfU49UrTbX++D/P9rfTJH9V76Q4Cdfp+qMyofgRDX1m18EfC+WsV0
         9mbnzKw5NYLjjBP+8eVfkFR1dh79x1nNSMSU7rUHGa9NY1I+ibVv0Eyf4ARFcrRc1F2G
         9Ev6pDbzb62RGijRKRE238dPLQbncwBdvNELIuw0aZnM25xQxI/as+e8/lHTM85RsQ8W
         yuUndDCOzUj0WWa5wxTnz/r9tKjGE6iKrSe9grvjJiqaqYwJl+t+H05XN2pZa22Htv1P
         nQOg==
X-Gm-Message-State: AOAM532JyJoQd2EAvQtyb62S2mbU6LIZkwWlm/cheJn4cfSeIxzGhE8w
        YluKRG7AMvYUZB1Yhnjc4a4w7KxaW+4=
X-Google-Smtp-Source: ABdhPJyRKODBAGwDWm0VY5VT1TAOSzjqvxb9EI2Pulj+IXp1jbLjH8PYzH2EX9w5FGhFqDEx6ptRyA==
X-Received: by 2002:a05:600c:4e92:: with SMTP id f18mr791155wmq.126.1612216949410;
        Mon, 01 Feb 2021 14:02:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m205sm30951wmf.40.2021.02.01.14.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:28 -0800 (PST)
Message-Id: <65488f7a1bfa8313a7b7d59e208e54cb7f7c18ae.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:15 +0000
Subject: [PATCH 06/11] read-cache: log the number of lstat calls to trace2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Report the total number of calls made to lstat() inside of refresh_index().

FSMonitor improves the performance of commands like `git status` by
avoiding scanning the disk for changed files.  This can be seen in
`refresh_index()`.  Let's measure this.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index ecf6f689940..893cc41e1d9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1364,7 +1364,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 					     struct cache_entry *ce,
 					     unsigned int options, int *err,
-					     int *changed_ret)
+					     int *changed_ret,
+					     int *t2_did_lstat)
 {
 	struct stat st;
 	struct cache_entry *updated;
@@ -1406,6 +1407,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		return NULL;
 	}
 
+	if (t2_did_lstat)
+		*t2_did_lstat = 1;
 	if (lstat(ce->name, &st) < 0) {
 		if (ignore_missing && errno == ENOENT)
 			return ce;
@@ -1519,6 +1522,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	const char *added_fmt;
 	const char *unmerged_fmt;
 	struct progress *progress = NULL;
+	int t2_sum_lstat = 0;
 
 	if (flags & REFRESH_PROGRESS && isatty(2))
 		progress = start_delayed_progress(_("Refresh index"),
@@ -1536,11 +1540,13 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 * we only have to do the special cases that are left.
 	 */
 	preload_index(istate, pathspec, 0);
+	trace2_region_enter("index", "refresh", NULL);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
 		int changed = 0;
 		int filtered = 0;
+		int t2_did_lstat = 0;
 
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
@@ -1566,7 +1572,10 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (filtered)
 			continue;
 
-		new_entry = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
+		new_entry = refresh_cache_ent(istate, ce, options,
+					      &cache_errno, &changed,
+					      &t2_did_lstat);
+		t2_sum_lstat += t2_did_lstat;
 		if (new_entry == ce)
 			continue;
 		if (progress)
@@ -1602,6 +1611,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		replace_index_entry(istate, i, new_entry);
 	}
+	trace2_data_intmax("index", NULL, "refresh/sum_lstat", t2_sum_lstat);
+	trace2_region_leave("index", "refresh", NULL);
 	if (progress) {
 		display_progress(progress, istate->cache_nr);
 		stop_progress(&progress);
@@ -1614,7 +1625,7 @@ struct cache_entry *refresh_cache_entry(struct index_state *istate,
 					struct cache_entry *ce,
 					unsigned int options)
 {
-	return refresh_cache_ent(istate, ce, options, NULL, NULL);
+	return refresh_cache_ent(istate, ce, options, NULL, NULL, NULL);
 }
 
 
-- 
gitgitgadget

