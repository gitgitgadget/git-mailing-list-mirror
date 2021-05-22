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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C216C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C91610A6
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhEVN7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhEVN6w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395AC06138F
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d11so23701783wrw.8
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GEJvB6DkpLBq+oWPB2TvhNaTQQmMiQL+xy7JCCvEvbs=;
        b=MpDddXo/shbtTsjsnfLeKD8Tve1iGhhOrCDv8Fpp5coXEkaTzWtLuppW7YF4GVRNpd
         h+r835JPnHLvNCe2eu2Oku+gupqQo30dVkFJcsoYSN70PsgCLsGTg4+CAZHsOKqm3RaV
         CVO72jR4JetjkS4ZpjGXNLGabPDnYaLdbhyyfN6eRcnaWDbYqHQIj1wFCyt9/cL1UeyD
         u9buFPY1l4umJft0+H0LoJvKOY/9EiyF25sLwkeLRBRA1Pr68u3jhoX0QZVm07gRO6wQ
         et77N0A/Nje5t3A7IxL1BJ1UwZxHwPOnh+pjhjrXHdql5dWFI6ftX/nuJRJ06ORp6QV+
         n+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GEJvB6DkpLBq+oWPB2TvhNaTQQmMiQL+xy7JCCvEvbs=;
        b=UUEij8UFLayer4LIF+i5baMZO9ugWTFvC6t+hLtgJ3I7Q5qIW1ma7/7bwa2sTBHvq9
         Cn7TVUVDDg9yX7jFF3/7YBfiriM+YgGEvIPAhnc8dShrUTZCQVOiKdNL3hTmzgmqTGZX
         6U6iXFyxXKLVMM0igIppng7w9ujF2lF6Jl2WPl6PNelo4gwPU+6OXb4aLueYd5CEKbMx
         G4xlL/1fCrO812iYQ72qu+usOlawFQVRr8uVbI9iZz6xQA8zPRzTJPpKAOUy01roZk44
         KbiUMtsFajniDCH9n/0AyDSa6wXTZPCmAkAhTqmzSSNDLgtF884g8xTdxm3o5z1xl4Bp
         I+1Q==
X-Gm-Message-State: AOAM533gALtI1nWQMYSamitTUVJSPis0PzmfVSJ+mXr74JDd1+J4ARJ+
        XXK/0kjt9Lv23SFofzYfrbC2zLhvuAo=
X-Google-Smtp-Source: ABdhPJxqUc85HixHqNrC0KWyyO/CabpCaP0A/LlOsOu3amA37jCfAApNFsrcl08swk1zR/EGICWhLA==
X-Received: by 2002:a5d:4c91:: with SMTP id z17mr14497860wrs.349.1621691844983;
        Sat, 22 May 2021 06:57:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm2576137wmi.42.2021.05.22.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:24 -0700 (PDT)
Message-Id: <102e17cbc87533ab7e95d32c1c258404b73252e5.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:57:02 +0000
Subject: [PATCH v2 23/28] fsmonitor: enhance existing comments
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
index c6d3c34ad78e..29adf3e53ef3 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -344,9 +344,25 @@ void refresh_fsmonitor(struct index_state *istate)
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
@@ -361,11 +377,15 @@ void refresh_fsmonitor(struct index_state *istate)
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
@@ -373,7 +393,10 @@ void refresh_fsmonitor(struct index_state *istate)
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

