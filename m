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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F5C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F2861164
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbhIPTzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbhIPTzt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805D4C061756
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so6348494wmh.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OPR/cD4g5iSikjECMnICO/QPaQt/LlN2JVqikY/G/54=;
        b=U16H2MZddLyPc7ccgKxjeIE14uCSLCPKqcyqDOVyixzWXo0j+RfhDbgJGqfupRAyuf
         /B6k0QkdOSDCR48DNK+kUTj1SN/IBSyczGIb+NcZQiBMaG8NZ+xICYtU29ABVj0kGkoW
         voAZKmNZk1+P6fsL04Au86LgGjL5VUNhFW2HlUb/1QaUBIzJthhRoVGnVAb7rmEm1vNn
         vVvhEwKfGs6i27H6XyjWM09UfjGUd4UAsiiWGDIaNJanHedfsAwaPsU+df5amgDBqFxO
         FFI+CQPa52ResVsS9gxs8Nqh3LJqsnxVDPpzXJevfPgR6RkuzSRkPK4tovTj46oDbkvp
         ZyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OPR/cD4g5iSikjECMnICO/QPaQt/LlN2JVqikY/G/54=;
        b=vlnc4o9r20ay8ilyqN63VGBeTPJTMEV8NdFecIz/X1Wk23WdnI53iMTLC3E1mQKO+U
         ZkLmx5RJHFKse+0lupGnxykuk1sYjhHAS0tqfgtzcRJmbDImxLNQgmV2jgNEETiR5Y0p
         GBP3Rxp9ohqXnjU80Mo0eA7HgD2usQ/Akshx9V+m2BYtvVbDQj3ySYV4+Q0k+LCVkA5V
         k1J5H3AtvZEYDTVTZy17a+cy/4VyC87RVNQ0u9YEdMEd0fTxNM7ExgIqnz1eGk20d5Fo
         Mt3/jnaWHUapwGsPnJKyIToTnSRNtJEIPOHMcztUxWTAhewQ6oSPdrMoSfYzFAL1m2PX
         6VhA==
X-Gm-Message-State: AOAM531s+Fa67ZRAeNW3omzJZiKfcWlfDGxt1kCdf0jemfl9GyE+ygXT
        iIF4HgpEHBgfTu3nDyH++o2/TNZSIRQ=
X-Google-Smtp-Source: ABdhPJxL9F+OWMbAdkGPGkNOzd9MksGs6DffI1G2gu4GEmEMTi5SpLJDOCcstCbaLrHgG8jDz4ljkQ==
X-Received: by 2002:a05:600c:d3:: with SMTP id u19mr11724220wmm.142.1631822067137;
        Thu, 16 Sep 2021 12:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d70sm4222948wmd.3.2021.09.16.12.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
Message-Id: <f2e5da9e5c622d9142baafee47c3e1cdffbef666.1631822063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Sep 2021 19:54:22 +0000
Subject: [PATCH 4/5] fsmonitor: use IPC to query the builtin FSMonitor daemon
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
 fsmonitor.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 63174630c0e..695fb0ce4e7 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -254,8 +254,37 @@ void refresh_fsmonitor(struct index_state *istate)
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
 
 	if (fsm_mode == FSMONITOR_MODE_IPC) {
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
+		goto apply_results;
 	}
 
 	assert(fsm_mode == FSMONITOR_MODE_HOOK);
@@ -321,6 +350,7 @@ void refresh_fsmonitor(struct index_state *istate)
 				 query_success ? "success" : "failure");
 	}
 
+apply_results:
 	/*
 	 * The response from FSMonitor (excluding the header token) is
 	 * either:
-- 
gitgitgadget

