Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4AFC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F9FE64E2C
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhBAWEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhBAWDi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70DC0617A9
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g10so18295081wrx.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MgDPgj7GedDHVjjkk/EtAODaaSn6gWGGMNTT5xfwao8=;
        b=rQ9ox0YpyQsKf88pXDu/z8EqvFTTKGIiCsKzNsHfjSj611kyoP4If86abkOTMb+8r9
         cuTjWxcopjvS4tuQgDeJlU+UEmtGiDdj9nnSvYjwI3Cz8UzlXTl8PVOSfvlrJ6v540uN
         vkIFsUNW+3MWRmukwFV69h/flDca0EpZh4WOQIltYS7YysC3kXzRVy3ZklPAI3lC1pi9
         kINPDH0J+YR02CtlFZxR1GXm3DPi9y3tHxJmU+nxEHFXNi0OSBfp8aCqwcz55wzTV2W4
         S7QPq1i73UJhdNAFVTeBvrHQeVFI/ObceM7pMwL51UZhBDnsn02hZ6Hxh1f94BzzezFV
         tDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MgDPgj7GedDHVjjkk/EtAODaaSn6gWGGMNTT5xfwao8=;
        b=jOrg64ljiHqzB1MUJsjkj6Dp0BzYilWFG8RYIotz4BIn9yaCzPFaJnhXzt0wVFVsJC
         AdM7wVRPqp0SyDqAR78jrdILyzBv23OvwrZGmMNUS5TH0veUn9B7BNSCTSxzvJfFx6mk
         SZ04p1Gsak2rfl/ZnvESM2oBBEswr1QwOWaYSCtQ85HljV8erfhnXiP4ogUhJXKrSE32
         JdGoEwwMF5Yt79DKKbiMofb2hRsyL0CgRWNStigrtbC05Jz+wjf17nvFPMUBNBgWmKgX
         P/DobnjSU8gRC0gurqOWKbTpDWq6iBIvB+vCAAw1YZk/hkKJb7x8T68ivs0OVO7EBGce
         wtnA==
X-Gm-Message-State: AOAM53041lDPElrbTWMZzklFGuyd8O9f0vfhewdhah6sBzF4cw5ISvzA
        G6B9GJZkdQ3PhGodof8hxnto7ppc+yM=
X-Google-Smtp-Source: ABdhPJyLLwckQadFXbOnITja8HInfo2W1Z2k4kHizSLr0ScCaMVR+z4w7zyEQOe9MCvqmYsdXr1n2w==
X-Received: by 2002:a05:6000:186f:: with SMTP id d15mr20465937wri.237.1612216953346;
        Mon, 01 Feb 2021 14:02:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14sm28255307wro.86.2021.02.01.14.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:32 -0800 (PST)
Message-Id: <384d2eff8637b7dd4cfbb116dd4b3ce30de5e381.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:19 +0000
Subject: [PATCH 10/11] fsmonitor: allow all entries for a folder to be
 invalidated
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <Kevin.Willford@microsoft.com>

Allow fsmonitor to report directory changes by reporting paths with a
trailing slash.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Kevin Willford <Kevin.Willford@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsmonitor.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 3105dc370ab..64deeda597e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -190,13 +190,34 @@ int fsmonitor_is_trivial_response(const struct strbuf *query_result)
 	return is_trivial;
 }
 
-static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
+static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
-	int pos = index_name_pos(istate, name, strlen(name));
+	int i, len = strlen(name);
+	if (name[len - 1] == '/') {
+
+		/*
+		 * TODO We should binary search to find the first path with
+		 * TODO this directory prefix.  Then linearly update entries
+		 * TODO while the prefix matches.  Taking care to search without
+		 * TODO the trailing slash -- because '/' sorts after a few
+		 * TODO interesting special chars, like '.' and ' '.
+		 */
+
+		/* Mark all entries for the folder invalid */
+		for (i = 0; i < istate->cache_nr; i++) {
+			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID &&
+			    starts_with(istate->cache[i]->name, name))
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		}
+		/* Need to remove the / from the path for the untracked cache */
+		name[len - 1] = '\0';
+	} else {
+		int pos = index_name_pos(istate, name, strlen(name));
 
-	if (pos >= 0) {
-		struct cache_entry *ce = istate->cache[pos];
-		ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		if (pos >= 0) {
+			struct cache_entry *ce = istate->cache[pos];
+			ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		}
 	}
 
 	/*
-- 
gitgitgadget

