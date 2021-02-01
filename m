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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED0C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE7964E2C
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhBAWD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhBAWDh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F9C061794
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so613251wml.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EwY+RPdKlOlJBlCoDOs+KUc/NkIJWwGIjdTt04+8VTw=;
        b=f3riSPceJ2i5bAT5uZ8XuYicl97OZSFVB31s5zNlvauZ6L3DuZcsJxi6wpK/lXjybu
         dRF6ksUx+wj2WehJAvjX9qVldw/5mzsRXqAjsu6yAO9nKQZKR5eiMD6LRoOfqRHlbcms
         izwpKXbHcArAXfRECKvyoGXxFKWdz8yhCRgwYwAyZr9AocPIk8ff2BKsNVqhg3mDRN2F
         GZFzh+zmRIYLgFgoU6G2b/nStEZSTH8wXI7oLGJPS+SHIaIxY+1kacOZewn2lqjKJX/C
         iM9JzCBD4i5fOgigdIdpgtE3yiQJnz05E0ldtyLOWdv2lTjmWGcshVrljOorMJd3i8Wf
         glqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EwY+RPdKlOlJBlCoDOs+KUc/NkIJWwGIjdTt04+8VTw=;
        b=a99nU6j+mKuHk4y4PtwBXLhF5jScnqd9g71FWE4OdvPrp+IuAkJX+VM15EPjCd1jeo
         seYJTJSnMpZbSSiy/iX2oOW6NYXWxudN0sIigNDKi/YSLHYKMYM49kWat02Vh5i9/eiM
         xCdIwZi03SN3WiWRtb9Ng8mK9TVlnO7p5Z3mLpHsqJUjceZ+VHuYJABDNHa/FRr3hm67
         HeiGZzb2RXqdDoBnDl6CCsh3F/I2WsCd8st35zravJHIxhYCDQRz24cFbW10mG4pOUD6
         tSrggmh8ZJIi5PqBAUd8jJOVRKcvoIKZwkmct7Cs80pg3wGnOnOKF3bjTrSPpYAXdiYe
         qReg==
X-Gm-Message-State: AOAM531tMmsbSkKhAiPJhgtxmrWjZavyvErCsM0F7+4cydaE9BpF2Yqc
        QVhaeaKHnLEqJCH/wx3C5H3HzFQXCMw=
X-Google-Smtp-Source: ABdhPJwf3ZJKZ2UKzNZzvUFfk4r8kKAmHOUnhE7fGXMOExguoR2im18nWqyGOlBcIXoXh0HbSVq0sA==
X-Received: by 2002:a1c:5454:: with SMTP id p20mr786731wmi.128.1612216950364;
        Mon, 01 Feb 2021 14:02:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y18sm27738530wrt.19.2021.02.01.14.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:29 -0800 (PST)
Message-Id: <c84531f624428c19408fb1f05343f27ee88e2654.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:16 +0000
Subject: [PATCH 07/11] read-cache: log the number of scanned files to trace2
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

