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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C3C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798F06141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhGAOuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbhGAOuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2838C061765
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u6so8581640wrs.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UFxndu8AKBnI+OL+LbIJO1y+ehiYxgLiTHwS0jWo67M=;
        b=Gt1rIpvq2KfnOmgs9W4cmBQ9sKMcZ3clakZESd1zHbKmKAXbE468wPKVVu3ROYq8/Z
         CRmH1T4vgSzEBxDDSnu0cr588viqDXm1syI8noPo2IvUnL8RagQKxtbp4WHhref/bDJf
         nqWzuXfHBmnvP1GSoQP/TaxJgA6Pa1YD6gn9tY1PuzZ6x0QfUXTVxzE+97R1rjDUmsEk
         f0leJ9piSsmrRKl+9u8VWb54BN9XZljAAVNubejYeRrlcUiBVTGFZwv7NoxQF6mEMkFu
         WfDY9Ou9l/D4MLzUD+dhgbRZL+kyonXJVbrXh41iNhY7xjMNGdi5qyzRcNJXatmgfSR/
         aBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UFxndu8AKBnI+OL+LbIJO1y+ehiYxgLiTHwS0jWo67M=;
        b=Puo4KxyhA3vqF5bdGr3nQchrf/Bo+eghIgh2AWHLTUMSeCdgK7SoPyrXQd1KXyQnc5
         ZqWwliCd7k528fWwd07FjNkORoJWlTzS7qGC6y9NzXY+SD5XxDVcxrVWNf2dyw1jf/RD
         /Z4TYQd1uI4NnrrKFebTvTksy0av25HaMQsgLsns3W0XzWVFu8w8vwi8y7AusCu7F2vj
         8aMUTKW01EPeboGLoMO7/iXG0CxgkEaq2IQ/tQ/kFPQxxa5jmqAZjazFSBRwcEfVAqta
         O2TZdhkoO1XKsSViOEtQ39hAYDdLQFU6Ps/2EsDK7KqE6JLQdMOB2mQonqglNGtfQxle
         tKDw==
X-Gm-Message-State: AOAM530F1U+aWf3BoCT1NoY6/a+5De/JSx7VJsXuzFWJMNqYhLr0M1nz
        AQUnngYqH+d/8CfAv1nDaAuVSABvr4k=
X-Google-Smtp-Source: ABdhPJzaOquRpd9cZ81Cz70ul/bcNGudVPuhoDh+DU2u8gpOlEICn+o79Pu+OH5VozAgCX+cqwVLug==
X-Received: by 2002:a5d:6502:: with SMTP id x2mr45398200wru.327.1625150884348;
        Thu, 01 Jul 2021 07:48:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20sm202659wmk.12.2021.07.01.07.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:02 -0700 (PDT)
Message-Id: <75bb4bc846364ec80e087d15bb1cb84265257ce3.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:40 +0000
Subject: [PATCH v3 30/34] fsmonitor: enhance existing comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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
index 3719ddfeec9..f53791c8674 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -360,9 +360,25 @@ void refresh_fsmonitor(struct index_state *istate)
 	}
 
 apply_results:
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
@@ -377,11 +393,15 @@ apply_results:
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
@@ -389,7 +409,10 @@ apply_results:
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

