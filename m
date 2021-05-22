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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A91C2B9FB
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCA361164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhEVN7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhEVN6v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0389C0613ED
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d11so23701797wrw.8
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nljdf+Z23/6i2jJYLWQb++EzMtltI8k+RIHGIumkbeE=;
        b=XhKI1fUcgPtJzUk9unto01nw0Hvx6TDZi+47oKl0W9/uwOXv4c9pyfqhR0UM9awyHm
         Iwv2amXWchxoYlIGGMNIScCsxgzK7q4d42MjieHApE8UegxmAkodYdemGfMOdyxwSaFc
         nKF1S+dvBEKZ2FGCNqMyYgTvgq4SrR76KsLE1VZM/wTQ6lc+RRWBkknv0ER+CoiDyMlw
         7RoYHtC7yUSbW4Qj28MxUFXZaTx7FWNha9OKKNofLjdVSKVFoM52hxgXYDIrfJDKG6V6
         fkbFSYCHwFwN1xGLoZ4iC9MgKFe/jnzrz6SDHAplzHbznSl0GY0CgrHmKRIWGAe2U7Hm
         /+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nljdf+Z23/6i2jJYLWQb++EzMtltI8k+RIHGIumkbeE=;
        b=RE2WVyimNjwMnubF+J4J2CU7x3SBP9F+2Qy7sE1Y6bXkGJgtqxYHkTR2gWLln2mn9g
         K4h4caCYJL+bNiM+k8hOZmZFBTJXEy6S5KEXoa3i0kmiptguBzMx81Oiu9VT0GQd1DLg
         2KrYJ6Ld1vF+Cnr819vNHDQg8y4jRV8bkIGIT2pqFvN/z97z258f1H9pQpUyY3OSMMCh
         HWKEd2hCDvXA+0UoGa5+V0mIKWn1f2b+l+9l2KigXpKnjymh3KWfS4p3bj9zywP92Cxk
         UyxGF6pyTMv4o8P8c7iiHE+hdXvYmc1Ta8AVEER3Il4KF6h1UEp3Co903uHT/Qmneznp
         VxUw==
X-Gm-Message-State: AOAM532Lc/t5henm3WkT5LzEufkNjwIDI7HM0MFcjQNwVQscq8OpUY9u
        5L2sKpC0eFVi+Z/1XmYfm3BLvOQdfl8=
X-Google-Smtp-Source: ABdhPJwYMpRRs4s8GaHArQY75rSWkQkhrAIcA/QrdBh3SF6pBVSPJ/o9gZCZ4lBzr64nKCKqo6jSSQ==
X-Received: by 2002:a5d:64e4:: with SMTP id g4mr14231726wri.366.1621691845530;
        Sat, 22 May 2021 06:57:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm6671149wrq.0.2021.05.22.06.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:25 -0700 (PDT)
Message-Id: <11ea2f97def686ca7f73e6c1a3eabba341bea145.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:57:03 +0000
Subject: [PATCH v2 24/28] fsmonitor: force update index after large responses
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

Set the `FSMONITOR_CHANGED` bit on `istate->cache_changed` when
FSMonitor returns a very large repsonse to ensure that the index is
written to disk.

Normally, when the FSMonitor response includes a tracked file, the
index is always updated.  Similarly, the index might be updated when
the response alters the untracked-cache (when enabled).  However, in
cases where neither of those cause the index to be considered changed,
the FSMonitor response is wasted.  Subsequent Git commands will make
requests with the same token and receive the same response.

If that response is very large, performance may suffer.  It would be
more efficient to force update the index now (and the token in the
index extension) in order to reduce the size of the response received
by future commands.

This was observed on Windows after a large checkout.  On Windows, the
kernel emits events for the files that are changed as they are
changed.  However, it might delay events for the containing
directories until the system is more idle (or someone scans the
directory (so it seems)).  The first status following a checkout would
get the list of files.  The subsequent status commands would get the
list of directories as the events trickled out.  But they would never
catch up because the token was not advanced because the index wasn't
updated.

This list of directories caused `wt_status_collect_untracked()` to
unnecessarily spend time actually scanning them during each command.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 29adf3e53ef3..22623fd228fc 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -230,6 +230,45 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	untracked_cache_invalidate_path(istate, name, 0);
 }
 
+/*
+ * The number of pathnames that we need to receive from FSMonitor
+ * before we force the index to be updated.
+ *
+ * Note that any pathname within the set of received paths MAY cause
+ * cache-entry or istate flag bits to be updated and thus cause the
+ * index to be updated on disk.
+ *
+ * However, the response may contain many paths (such as ignored
+ * paths) that will not update any flag bits.  And thus not force the
+ * index to be updated.  (This is fine and normal.)  It also means
+ * that the token will not be updated in the FSMonitor index
+ * extension.  So the next Git command will find the same token in the
+ * index, make the same token-relative request, and receive the same
+ * response (plus any newly changed paths).  If this response is large
+ * (and continues to grow), performance could be impacted.
+ *
+ * For example, if the user runs a build and it writes 100K object
+ * files but doesn't modify any source files, the index would not need
+ * to be updated.  The FSMonitor response (after the build and
+ * relative to a pre-build token) might be 5MB.  Each subsequent Git
+ * command will receive that same 100K/5MB response until something
+ * causes the index to be updated.  And `refresh_fsmonitor()` will
+ * have to iterate over those 100K paths each time.
+ *
+ * Performance could be improved if we optionally force update the
+ * index after a very large response and get an updated token into
+ * the FSMonitor index extension.  This should allow subsequent
+ * commands to get smaller and more current responses.
+ *
+ * The value chosen here does not need to be precise.  The index
+ * will be updated automatically the first time the user touches
+ * a tracked file and causes a command like `git status` to
+ * update an mtime to be updated and/or set a flag bit.
+ *
+ * NEEDSWORK: Does this need to be a config value?
+ */
+static int fsmonitor_force_update_threshold = 100;
+
 void refresh_fsmonitor(struct index_state *istate)
 {
 	struct repository *r = istate->repo ? istate->repo : the_repository;
@@ -363,19 +402,28 @@ void refresh_fsmonitor(struct index_state *istate)
 		 *
 		 * This updates both the cache-entries and the untracked-cache.
 		 */
+		int count = 0;
+
 		buf = query_result.buf;
 		for (i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
 				continue;
 			fsmonitor_refresh_callback(istate, buf + bol);
 			bol = i + 1;
+			count++;
 		}
-		if (bol < query_result.len)
+		if (bol < query_result.len) {
 			fsmonitor_refresh_callback(istate, buf + bol);
+			count++;
+		}
 
 		/* Now mark the untracked cache for fsmonitor usage */
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
+
+		if (count > fsmonitor_force_update_threshold)
+			istate->cache_changed |= FSMONITOR_CHANGED;
+
 	} else {
 		/*
 		 * We received a trivial response, so invalidate everything.
-- 
gitgitgadget

