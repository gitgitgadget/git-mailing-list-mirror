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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F94C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D006141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhGAOu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhGAOuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB6FC0613DC
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id w13so4690859wmc.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=smA/CGHifxx0NwUOVPrq185XmIP/kTroOWItviZLrjw=;
        b=Z7qfWOYyNOnwg30GmBpez0yEtBwTu4U1NPOVs1rdmGcs6D1I/LWHT4Tg0oecAVJ3aF
         iPHT+kEWCmDapc7YEsjOduPx4CkWTG6X7cuMbvMOspoeflX8RRKG5Zle4Sq0fv6uXC7h
         tPP0PVYdLwhTuTi2GH6civaa5XAwdFcPDDBswNoi8yxSDVWDY7aRGNbXH4UafrYWBK9J
         Y5ZgpkLyM6mYjauOBCJXJRCsxuTdYpinusgJz1SdjZR9agjGcpanwb7nS8QMcx1JRPyN
         9MtUhpKBUIHxQFyLQIBXVRhLQ34FpG14YycJ4vQ9KigH7F9hUr1TPBGhfP7e5ZoxDGfE
         bxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=smA/CGHifxx0NwUOVPrq185XmIP/kTroOWItviZLrjw=;
        b=ZM0zK+l/ac0d3w5JqEku/MUqUroPbp8dtP8Cg4aOIG99p+4DekOMs8DAeVO9GMW3x4
         /cgL6Ej7mWjmk9oFig9NgsVM61LuK2vNzpi90/gcZ1xIrNKCWyw84pnpknDBcUGau2oD
         +YVJeui6yxVjJnrw0hVh92V4a25P7AKYxmyZ59dZjzmMhNLhpdQmGPkQjXeKpk/NkFJp
         QNwd1RDH+Uk3S7F1GyumsA+6o93Q/eIRbu1R1IGA+dw8EsikUi/O9smKEUVm3yLw88lm
         y+/frmnaGpnAx3T/gDiz/bkZ91vAMAeZvZi++GqYXSH1RNeYx0yX0PGFE/mOW05OKd/x
         IzPg==
X-Gm-Message-State: AOAM5307MGAqFFvWZRn7E0fjOBOV+R3HUQA1EYdf6i/znnscphUeiPv7
        CSBs5MhLXIJwLKkF4wEHhKiaf1aM9ho=
X-Google-Smtp-Source: ABdhPJydrFTZHndAaymtc0JrS2svkKUSkZjQQnWlmtsEY4uQWtBxh4MfhjemV7yZIs5pJMFn7/HNnA==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr11273161wmj.184.1625150884865;
        Thu, 01 Jul 2021 07:48:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4sm231056wmf.9.2021.07.01.07.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:04 -0700 (PDT)
Message-Id: <8b3c4f4e6dd989de88b0b7b543751e362fa0d649.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:41 +0000
Subject: [PATCH v3 31/34] fsmonitor: force update index after large responses
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
index f53791c8674..eee653f9337 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -236,6 +236,45 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
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
 	struct strbuf query_result = STRBUF_INIT;
@@ -379,19 +418,28 @@ apply_results:
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

