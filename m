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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C2C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5261564DF6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhBCPj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbhBCPhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:37:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177BC061797
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:35:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m13so24880449wro.12
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fkxMogoHr5h4CV44ECW6UTWZy4JBxE27oGdnxv+/Kac=;
        b=SS0P3BjWIdF+bHUn47e6NMVo6vJKuTzFbzsq1YHzNAzmtNO92UJmM2zGW9TmOgGT6D
         ZneZlienjn/0efIhYkRzRC/VGIDywVZi53g26ArBkWJCLQirRzY7Ab9B7BaXSS3+0xPP
         YUr+j1sqkpzlhARcpKekZzoRIVhri3ebypbc9ZS9KuI2fZ6hFWnVaEpOhsNIv14LZM5g
         b1Sq91GNScwXfyXLqPGtrsuyYal1UYH5VoVVHTy6/PhznecznkdtPsKzr987awSWvAR7
         7uyIFfDwJxRH+U3NG2puzUcH81ZgGNfeu98jRGNtbLpE+NPc8Q0zecusFQbm7S7toz30
         0PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fkxMogoHr5h4CV44ECW6UTWZy4JBxE27oGdnxv+/Kac=;
        b=cUocNaQOFjEnlhyxEvpGz77zTqsIV26bkT8J9ZZ6w/qHqftxtsFT2iKpbNo3lkOKbX
         z9z094mUIkTbKlkR/dgqKEftSaorN7jPIYllwkjc1ZnZEeloUwCZVTSGoN0GDgVQoBD4
         XwQgMlVCa07zNVezzepuV70hFkXxwWgPpmm3T/IrTbVBgdQ4w70Ya8tkLlu82Io1b91C
         oMk9vK7oMsNYFtRDosMHmBkzaRjm3QMs84BcpKoAl4U+QrymQ2hVBkLMLSrpvZhcVqEW
         xdZgMfE0+HuF2wpgEEdyYoJhEFCo+LO1Iqwzc1nmJNieuVerbHlY9USGjihiXKXKqpXp
         Dw3w==
X-Gm-Message-State: AOAM532l6nfxlmY5S+Us1jc587Z4o+YYQfjW54FF50vfRXUh1A0kUGkp
        tBd0RGVfABf5J1fhqZFPzzYRS6IVYSo=
X-Google-Smtp-Source: ABdhPJz1iWB37dDjXRd2BeEwDeytstcglRB9Pdz0Bsq1m0nu3MSIqFqVLv5T9yoBuc1xuA8i51SkkQ==
X-Received: by 2002:a5d:6092:: with SMTP id w18mr4169446wrt.75.1612366498883;
        Wed, 03 Feb 2021 07:34:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm3053871wmb.38.2021.02.03.07.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:58 -0800 (PST)
Message-Id: <d150a2d4576e1519e3a4b228a30ad3c3e63fa150.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:45 +0000
Subject: [PATCH v2 06/11] read-cache: log the number of lstat calls to trace2
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

