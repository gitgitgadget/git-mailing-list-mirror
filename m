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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6C5C433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3252D60F38
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhIPTzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbhIPTzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2416C061767
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so8222150wmq.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SbbdgLi1cHIa2BbYx4STh/bPoVh7i9SdShiJl1YSCVc=;
        b=lbhB1AnDQZQ/FGTinyn9OOstxTniH7QG0aWX9eLXAaZN8HsL8zq9RQ6G+aSewFrgSX
         tkAzzXjTmFSxC0opRsFrADPZb856IFqN21TCq9qnC2QZbD/rwDl37sr6pPeIXKFBSoS3
         wN0EMW2NwVi0dmx1tvh1KBlzeHH16525ZN+xVTQ9QVAvUpA1ENLJNuyTiFTkDjl3j6dc
         x2+ge15VysdzLcmphXxJ3mngnbIDxz3KKFozGDyoODLoM3c/dqts2JUHPkr4R4VFWSYp
         idVOLyQ02GN1xb+RfH9uieDI+JmDxtOvOB7pqLSClgcU/tWwr6WTIryMe5vy2VeKT/15
         1cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SbbdgLi1cHIa2BbYx4STh/bPoVh7i9SdShiJl1YSCVc=;
        b=03+rSOR0jXZuh4mcBsBytwL4428lWC5cwSZGFyg6Wmm2+ql2tFzwsnYVrV3EgxWzDl
         u43MH0YmP+2PvvgJoMa9313id5Wr3H2cua7+Op3MVIAIqa3RGNedinBv30XRPmbvOwSI
         d9vC/mq97IOc79LdzvGu26WnK0Tkj1YzHebnbJKDUM1R1P3fMnoOFrcHft06ZBX3wSae
         htkK6rsTWqtUB1qMxSk6qerC7wiD3uce7sjfUc8IpsTfw+urfkHV262Q8N0qCRVKYIHd
         GvMFNlLrPJYUZ4miKQCj08JtFSD4W2Sj9tDjToucDEfNpUy3WX091tI7iEs166elwhTS
         lZQw==
X-Gm-Message-State: AOAM533sYJjIyYRIMR+Z9n73H5iayd8VWlY4SVAcNeez8DYXBqIVldwz
        Ernxkb9nmsPTr8xX6RwhuwN1wzxSIkg=
X-Google-Smtp-Source: ABdhPJyggq6a5ayg0nW96u5GWEyZWqfEGzXglQ39NfeqBBN65+OaZPI8//hfJKUPfuwbLb4cZWL3Hw==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr11696289wmj.182.1631822065445;
        Thu, 16 Sep 2021 12:54:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g143sm8579624wme.16.2021.09.16.12.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:54:25 -0700 (PDT)
Message-Id: <6be687ba39d49f56a0729d3197ecbf3a64041357.1631822063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Sep 2021 19:54:19 +0000
Subject: [PATCH 1/5] fsmonitor: enhance existing comments
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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ab9bfc60b34..ec4c46407c5 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -301,9 +301,25 @@ void refresh_fsmonitor(struct index_state *istate)
 			core_fsmonitor, query_success ? "success" : "failure");
 	}
 
-	/* a fsmonitor process can return '/' to indicate all entries are invalid */
+	/*
+	 * The response from FSMonitor (excluding the header token) is
+	 * either:
+	 *
+	 * [a] a (possibly empty) list of NUL delimited relative
+	 *     pathnames of changed paths.  This list can contain
+	 *     files and directories.  Directories have a trailing
+	 *     slash.
+	 *
+	 * [b] a single '/' to indicate the provider had no
+	 *     information and that we should consider everything
+	 *     invalid.  We call this a trivial response.
+	 */
 	if (query_success && query_result.buf[bol] != '/') {
-		/* Mark all entries returned by the monitor as dirty */
+		/*
+		 * Mark all pathnames returned by the monitor as dirty.
+		 *
+		 * This updates both the cache-entries and the untracked-cache.
+		 */
 		buf = query_result.buf;
 		for (i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
@@ -318,11 +334,15 @@ void refresh_fsmonitor(struct index_state *istate)
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
 	} else {
-
-		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
-		 * if we actually changed entries or not */
+		/*
+		 * We received a trivial response, so invalidate everything.
+		 *
+		 * We only want to run the post index changed hook if
+		 * we've actually changed entries, so keep track if we
+		 * actually changed entries or not.
+		 */
 		int is_cache_changed = 0;
-		/* Mark all entries invalid */
+
 		for (i = 0; i < istate->cache_nr; i++) {
 			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
 				is_cache_changed = 1;
@@ -330,7 +350,10 @@ void refresh_fsmonitor(struct index_state *istate)
 			}
 		}
 
-		/* If we're going to check every file, ensure we save the results */
+		/*
+		 * If we're going to check every file, ensure we save
+		 * the results.
+		 */
 		if (is_cache_changed)
 			istate->cache_changed |= FSMONITOR_CHANGED;
 
-- 
gitgitgadget

