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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD5C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA0A6141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhGAOu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhGAOuW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DAC0613DC
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j1so8559894wrn.9
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uUlEGZcJ8HWSol8QoU0XdH0dmL3aUVI9LugPaHK4haA=;
        b=mmVy1P9TNwy7CzeAmkSzq552r+pAYCYPDIsCu3bwW3vat1h+gdj18kcRhqm9f4MJpq
         4GlW29cRWxDm8lP4qbueatobkExBOZCw/ayu/aWZHxsyBwEGeBPi9JmOXwn7Cku0jwON
         bF4R2MrM+HP0VbAyheUUzlMy3v8G/Oy8rPBB82yojSkKu6JcdDH1ITDNDgy/xpoHQ2ZN
         AjUfpZMH/R+2Z8C+M0VnKv5ChfSlmSHO/d78T67obMsXgPNs5BIExLLIqSERqQsBXk4Q
         LdQxbBwBbgHBvzOddokE54htBWzndaqlWVWkFflrkjF1jCRuv7cE9sCawzzaXk9nnKvK
         McsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uUlEGZcJ8HWSol8QoU0XdH0dmL3aUVI9LugPaHK4haA=;
        b=SAfoTnfE91a3Vr5aOQIsCTVBk9+zeP27lB1rK02TWjwd1eLnwhJ3PvOj5guZmIQJN+
         RQHKz47OybL4txqqrkMx6IYHNNEE2grZTYLfiz4IZ3srb65l29FdnBvjTkK+EEj5jM8w
         QT34w36aTkhzl9VXSxUWkVAxj6I+uMSFvMdefq/bwjxAAHrp2+snucWHw0uMg2gNnLYX
         PXd/OH8itXA1FKRcjKCua1Wgse1GtITGiuET0XKQ5ylTr0v/GI5yyyt3jiZHia2LwFBP
         yVz/TiN9YyKwRWXxFw5PuoRDZ7xrzOi8/G48sernVtYRSjh9vUWWUOVSsCRyoNMw8bFB
         2/8A==
X-Gm-Message-State: AOAM532Yt0JsLJ1fiDalXEVe6IulhDZYicv0/4j8SXfmLpqrOBExlcTz
        ZIsqAp5Adl4FY0m2qY6B1pZtnywCV4w=
X-Google-Smtp-Source: ABdhPJyF6CcmVmbQ66z9QQKR9qzlNXxxFT2v/lBaATvAgPYOYF20jd/STW6iGvjxmRg7+JcqXSVt+A==
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr46723512wrx.203.1625150869835;
        Thu, 01 Jul 2021 07:47:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm175619wrd.25.2021.07.01.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:49 -0700 (PDT)
Message-Id: <c86b5651ecc63f885701e0850b351db62b6d5478.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:17 +0000
Subject: [PATCH v3 07/34] fsmonitor: use IPC to query the builtin FSMonitor
 daemon
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

Use simple IPC to directly communicate with the new builtin file
system monitor daemon when `core.useBuiltinFSMonitor` is set.

The `core.fsmonitor` setting has already been defined as a HOOK
pathname.  Historically, this has been set to a HOOK script that will
talk with Watchman.  For compatibility reasons, we do not want to
overload that definition (and cause problems if users have multiple
versions of Git installed).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 374189be7d9..3719ddfeec9 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -256,8 +256,44 @@ void refresh_fsmonitor(struct index_state *istate)
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
 
 	if (r->settings.fsmonitor_mode == FSMONITOR_MODE_IPC) {
-		/* TODO */
-		return;
+		query_success = !fsmonitor_ipc__send_query(
+			istate->fsmonitor_last_update ?
+			istate->fsmonitor_last_update : "builtin:fake",
+			&query_result);
+		if (query_success) {
+			/*
+			 * The response contains a series of nul terminated
+			 * strings.  The first is the new token.
+			 *
+			 * Use `char *buf` as an interlude to trick the CI
+			 * static analysis to let us use `strbuf_addstr()`
+			 * here (and only copy the token) rather than
+			 * `strbuf_addbuf()`.
+			 */
+			buf = query_result.buf;
+			strbuf_addstr(&last_update_token, buf);
+			bol = last_update_token.len + 1;
+		} else {
+			/*
+			 * The builtin daemon is not available on this
+			 * platform -OR- we failed to get a response.
+			 *
+			 * Generate a fake token (rather than a V1
+			 * timestamp) for the index extension.  (If
+			 * they switch back to the hook API, we don't
+			 * want ambiguous state.)
+			 */
+			strbuf_addstr(&last_update_token, "builtin:fake");
+		}
+
+		/*
+		 * Regardless of whether we successfully talked to a
+		 * fsmonitor daemon or not, we skip over and do not
+		 * try to use the hook.  The "core.useBuiltinFSMonitor"
+		 * config setting ALWAYS overrides the "core.fsmonitor"
+		 * hook setting.
+		 */
+		goto apply_results;
 	}
 
 	assert(r->settings.fsmonitor_mode == FSMONITOR_MODE_HOOK);
@@ -323,6 +359,7 @@ void refresh_fsmonitor(struct index_state *istate)
 				 query_success ? "success" : "failure");
 	}
 
+apply_results:
 	/* a fsmonitor process can return '/' to indicate all entries are invalid */
 	if (query_success && query_result.buf[bol] != '/') {
 		/* Mark all entries returned by the monitor as dirty */
-- 
gitgitgadget

