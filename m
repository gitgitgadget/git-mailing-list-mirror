Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E5C4332F
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhL1Tgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhL1Tgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C149C06173F
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r17so40172477wrc.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ug8oqNMEumg2bBDk4UGGbUWbZGOzVorpz7gFeUis3PE=;
        b=GEpDMhkEOBmHOE/e1/UE+JfUbaVzXn6zUf2TmuL6CA9Vh54Auft0XvzWBAgKdNH7dq
         2OAQj2inf1krIxbhgChNC4Pswyl3DWV2ajWc/KFK+WhtxCGZ7tI0D5aoiIpWjLPDScZQ
         ncasS5Rwc9/4eXdlljmfBmYeOuXaH1TWJD0TiTkvyTR/6rtH+/yo923RRK9/nUj3gdnj
         4fYVMfYvk9vqOlRe12HuKVuARDK5+WAOR8FnKTXPtU6UH1WXP+1jJFkR8ANL6YC059xn
         /3jN0DqcZbpxSe5aV5XygScjBBZ+JhFX3H8RG3BacAXUetIfcy6b+oU3TlX0wgMrY4e3
         OahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ug8oqNMEumg2bBDk4UGGbUWbZGOzVorpz7gFeUis3PE=;
        b=qHg/xcgj0nUl81KOl3CWKJVW2OhMjBNUru5SrV7q0TiZSajrPUpdi9504ZhLzxngbE
         FJbB5WjauM3suAZR01lLCWqnWkJQKnbmo+EBWGZ8p42nA78Km2p77paMt5o33SEisenW
         uITi8xzBd52Z1VtD3M78GmWiO5V2E97sPB3MfnPyDcv9d6pwfqLlV6wwDXWaBu+w/U6v
         ggNgdcQ9fzz9rnsShf9mk3mH9GXSxrlGisCl2+i6w7uwWEwgtXqp5igJmWs05Se1++l9
         TTI3Lo3PebOu2nYX/xzcGnVgo7BG/RU/0yF09p8+Df/iVu0v+0naOWe3Vbr4HOv49P90
         CTsQ==
X-Gm-Message-State: AOAM532rGRf5zo/x2Uqv1vjiEzieTwbNfxuNP6eYho83HJAmN4SyuH62
        4Ak0f4OfudBcJlLZi1hp2Z5NkBV+wcI=
X-Google-Smtp-Source: ABdhPJwaY1WULCC5K2S8/IJikABizLDhWjv/lxxC9FZ4cB/b1UeMzJRINB8Y6HbZyzqsjTrZtGmPww==
X-Received: by 2002:a5d:64a1:: with SMTP id m1mr17265991wrp.503.1640720205447;
        Tue, 28 Dec 2021 11:36:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm24420079wrs.0.2021.12.28.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:45 -0800 (PST)
Message-Id: <11c8d8cdf1a9c0e4f840a295c7401014404e119d.1640720202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:36 +0000
Subject: [PATCH v2 3/9] trace2: defer free of thread local storage until
 program exit.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Defer freeing of the Trace2 per-thread thread local storage until
program exit.  Create a global list to own them.

Trace2 thread local storage data is allocated when a thread is created
and associated with that thread.  Previously, that storage was deleted
when the thread exited.  Now at thread exit, we simply disassociate
the data from the thread and let the global list manage the cleanup.

This will be used by a later commit when we add "counters" and
stopwatch-style "timers" to the Trace2 API.  We will add those fields
to the thread local storage block and allow each thread to efficiently
(without locks) accumulate counter and timer data.  At program exit,
the main thread will run thru the global list and compute and report
totals before freeing the list.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.c | 38 +++++++++++++++++++++++++++++++-------
 trace2/tr2_tls.h |  3 ++-
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index ed99a234b95..78538d5e522 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -15,6 +15,18 @@ static uint64_t tr2tls_us_start_process;
 static pthread_mutex_t tr2tls_mutex;
 static pthread_key_t tr2tls_key;
 
+/*
+ * This list owns all of the thread-specific CTX data.
+ *
+ * While a thread is alive it is associated with a CTX (owned by this
+ * list) and that CTX is installed in the thread's TLS data area.
+ * When a thread exits, it is disassociated from its CTX, but the (now
+ * dormant) CTX is held in this list until program exit.
+ *
+ * Similarly, `tr2tls_thread_main` points to a CTX contained within
+ * this list.
+ */
+static struct tr2tls_thread_ctx *tr2tls_ctx_list; /* modify under lock */
 static int tr2_next_thread_id; /* modify under lock */
 
 void tr2tls_start_process_clock(void)
@@ -56,6 +68,14 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
 
+	/*
+	 * Link this CTX into the CTX list and make it the head.
+	 */
+	pthread_mutex_lock(&tr2tls_mutex);
+	ctx->next_ctx = tr2tls_ctx_list;
+	tr2tls_ctx_list = ctx;
+	pthread_mutex_unlock(&tr2tls_mutex);
+
 	pthread_setspecific(tr2tls_key, ctx);
 
 	return ctx;
@@ -91,14 +111,7 @@ int tr2tls_is_main_thread(void)
 
 void tr2tls_unset_self(void)
 {
-	struct tr2tls_thread_ctx *ctx;
-
-	ctx = tr2tls_get_self();
-
 	pthread_setspecific(tr2tls_key, NULL);
-
-	free(ctx->array_us_start);
-	free(ctx);
 }
 
 void tr2tls_push_self(uint64_t us_now)
@@ -162,11 +175,22 @@ void tr2tls_init(void)
 
 void tr2tls_release(void)
 {
+	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
+
 	tr2tls_unset_self();
 	tr2tls_thread_main = NULL;
 
 	pthread_mutex_destroy(&tr2tls_mutex);
 	pthread_key_delete(tr2tls_key);
+
+	while (ctx) {
+		struct tr2tls_thread_ctx *next = ctx->next_ctx;
+
+		free(ctx->array_us_start);
+		free(ctx);
+
+		ctx = next;
+	}
 }
 
 int tr2tls_locked_increment(int *p)
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 64d97c5ac03..889010ec1ff 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 
 struct tr2tls_thread_ctx {
+	struct tr2tls_thread_ctx *next_ctx;
 	uint64_t *array_us_start;
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
@@ -37,7 +38,7 @@ struct tr2tls_thread_ctx *tr2tls_get_self(void);
 int tr2tls_is_main_thread(void);
 
 /*
- * Free our TLS data.
+ * Disassociate thread's TLS CTX data from the thread.
  */
 void tr2tls_unset_self(void);
 
-- 
gitgitgadget

