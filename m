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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C18C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E0164F58
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhBCPju (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhBCPhY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:37:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C58C0617A7
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:35:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f16so38293wmq.5
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EwY+RPdKlOlJBlCoDOs+KUc/NkIJWwGIjdTt04+8VTw=;
        b=FwCTxLrAfmFKlb2PZ+ixgcn7lo8RjYxdRLBnSMw+7nNYi8WzrvYVbgFoxD89OaT/h6
         j90wyUVLiHuDln4gLLIGOdIgkGIBGiJaUHnRZAjsZnLgwxDezQHx5xEm3+kFjC5EZ8+C
         EfaTrU3j1DZmMUofRbF7iFgzB66eTzoIIYFpuNlGvJ/gLgf41nfgUS7uOe7ZDqctG7bB
         Ti/q70CINpeTG18K71FDzX11aqs9iTeCqpGQ3BYRhm6FwbfSh1ULOdS/BtybfU4yCJjL
         3/D1jXO4q+fKYcOT9qym6rFXZ+GMF1ldeO8eQF2UuOO7/wwTNy+HKo+sEISjDvWLzrZa
         b20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EwY+RPdKlOlJBlCoDOs+KUc/NkIJWwGIjdTt04+8VTw=;
        b=uUw7QdxmlIz55V7TG0Egyl3juzYmc6c0b916XxrzS1lYJnM33q3kYqVPH+7jcaLoIp
         p/qmlHeK0mENnz6zHjI/28X7OszIE9bQZQplPkJl3HLFfH9VcuAZi0L/c/fFS49fJp2m
         iJeCmX/+YNSGPBbu6zrKmvBOP//ivrm8E7L7SdLIAEx6HBwif06Fh5OYLIPbm8FXlZz1
         RoyPPh2x1L1dpfX+vLNkjbWMcwUiodl3XOafkFCYVNFFPtJJ1jQyBzauI3LCTNExaZAU
         q6bHYgCpn5OpBrmakvxrpTWFNH/AbS1WwkezBorsSyzsqFkoo4PrwY2evk5ss3Yr5j/6
         RISQ==
X-Gm-Message-State: AOAM531PiRnugh/O5dOVWHSCC3N8mVswiHtOcoE0KeFWWFT2DKNZ2LL6
        SkSq/JMI9XX9/s1HS5BZzc40Sg1m54I=
X-Google-Smtp-Source: ABdhPJycqrYtXZRaXjkrBHMUPkvClP5eeaYALe+afygsB/sFP3OuhkmVZgwtv0szub9h1i4foiJd6Q==
X-Received: by 2002:a1c:25c2:: with SMTP id l185mr3352026wml.62.1612366499830;
        Wed, 03 Feb 2021 07:34:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 143sm1602467wmb.47.2021.02.03.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:59 -0800 (PST)
Message-Id: <33cc0b838fadcfd8fc9cf769d77b83f3775e363f.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:46 +0000
Subject: [PATCH v2 07/11] read-cache: log the number of scanned files to
 trace2
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

Report the number of files in the working directory that were read and
their hashes verified in `refresh_index()`.

FSMonitor improves the performance of commands like `git status` by
avoiding scanning the disk for changed files.  Let's measure this.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 read-cache.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 893cc41e1d9..c9dd7f4015e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1365,7 +1365,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 					     struct cache_entry *ce,
 					     unsigned int options, int *err,
 					     int *changed_ret,
-					     int *t2_did_lstat)
+					     int *t2_did_lstat,
+					     int *t2_did_scan)
 {
 	struct stat st;
 	struct cache_entry *updated;
@@ -1445,6 +1446,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		}
 	}
 
+	if (t2_did_scan)
+		*t2_did_scan = 1;
 	if (ie_modified(istate, ce, &st, options)) {
 		if (err)
 			*err = EINVAL;
@@ -1523,6 +1526,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	const char *unmerged_fmt;
 	struct progress *progress = NULL;
 	int t2_sum_lstat = 0;
+	int t2_sum_scan = 0;
 
 	if (flags & REFRESH_PROGRESS && isatty(2))
 		progress = start_delayed_progress(_("Refresh index"),
@@ -1547,6 +1551,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		int changed = 0;
 		int filtered = 0;
 		int t2_did_lstat = 0;
+		int t2_did_scan = 0;
 
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
@@ -1574,8 +1579,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 
 		new_entry = refresh_cache_ent(istate, ce, options,
 					      &cache_errno, &changed,
-					      &t2_did_lstat);
+					      &t2_did_lstat, &t2_did_scan);
 		t2_sum_lstat += t2_did_lstat;
+		t2_sum_scan += t2_did_scan;
 		if (new_entry == ce)
 			continue;
 		if (progress)
@@ -1612,6 +1618,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		replace_index_entry(istate, i, new_entry);
 	}
 	trace2_data_intmax("index", NULL, "refresh/sum_lstat", t2_sum_lstat);
+	trace2_data_intmax("index", NULL, "refresh/sum_scan", t2_sum_scan);
 	trace2_region_leave("index", "refresh", NULL);
 	if (progress) {
 		display_progress(progress, istate->cache_nr);
@@ -1625,7 +1632,7 @@ struct cache_entry *refresh_cache_entry(struct index_state *istate,
 					struct cache_entry *ce,
 					unsigned int options)
 {
-	return refresh_cache_ent(istate, ce, options, NULL, NULL, NULL);
+	return refresh_cache_ent(istate, ce, options, NULL, NULL, NULL, NULL);
 }
 
 
-- 
gitgitgadget

