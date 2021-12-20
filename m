Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB720C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbhLTPVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbhLTPTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB343C0698D4
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r17so20349593wrc.3
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SGqayhR93b76Amp3jxHWYGLsMiI7oNL1kNAWJV5Lk6c=;
        b=Q2syAqYLFIjVBivss2eA5xDu6VV2PF/wrOevFXD796XAC37y7JdpXFWuEgNa7F7I18
         fRuWfqzKPBNN3zU+obzWBw5dGPWl1T7CL6h/VCwnVpk2XD6wo/Bbn7vvWcd5J+JyWExd
         SbG5Rh+auwPnFqVPSP6YZxwZ+kEstqspiGx06Ib2myii+UZYH2UV7e0vTgXqe+mJ683Y
         lxqX6+bBo7jd0jFN4KOqSOHyK1dO1m0w+Z2VMgwA+9SQgI8+BcmN2oTuNnFGcts2UZjA
         dA4D6tUkPg4qINZzmteEN07lVJJK335XCBQSmpE7p39yFfVtj+1jaYa/A1DsC+rIQ3j6
         3VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SGqayhR93b76Amp3jxHWYGLsMiI7oNL1kNAWJV5Lk6c=;
        b=Qf55764mjeL466vn/XiAWAkOY/dlzJHZpubzcIUDzEP0fVDcrG24J5Jo8uG3lbfcjR
         O1enKWode8DSjXHhmg0PKHrV8gqq8iSYBkH9Mci9eSTg6yNEJ2w/EYVcN4iG8mIJi5OJ
         bUObWRZ1kArKgsNLtYx1g+y+iTwZnbFz1xfFiYVt9g1tO85bn2AQrImAfPd2h9hDTVFY
         Q/v9Cz/vNnbcheuH1GBMGrCgj00QO40lakturyIRfhEYiSWnf5rg/deGY9LrCHpLWMax
         2I4JHTU343waylP4sZxSjUGItTeUo4D+5RwY2htEnJw3GyfC1gnKdD5NjqJT0a7CWMPh
         wK1A==
X-Gm-Message-State: AOAM5334HdhnIswsvCYMtlQIK9Em4aE/TS7vpel+ETcVglmze8fQhcrs
        LaQZqcbYwIdzFBrNceNsvJk4/CecA4s=
X-Google-Smtp-Source: ABdhPJzF4ArhuzOPgVo1vUgZM7rqXSwRY4nVFp7dT5eoMHeg/OAFZBriuL2Ho1KBEFGVQNzAou+oZw==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr2850820wrz.79.1640012472161;
        Mon, 20 Dec 2021 07:01:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b197sm15571111wmb.24.2021.12.20.07.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:11 -0800 (PST)
Message-Id: <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:03 +0000
Subject: [PATCH 3/9] trace2: defer free of TLS CTX until program exit.
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

Defer freeing of the Trace2 thread CTX data until program exit.
Create a global list of thread CTX data to own the storage.

TLS CTX data is allocated when a thread is created and associated
with that thread.  Previously, that storage was deleted when the
thread exited.  Now we simply disassociate the CTX data from the
thread when it exits and let the global CTX list manage the cleanup.

This will be used by a later commit when we add "counters" and
stopwatch-style "timers" to the Trace2 API.  We will add those
fields to the CTX block and allow threads to efficiently (without
locks) accumulate counter and timer data using TLS.  At program
exit, the main thread can run thru the global list and compute
totals before it frees them.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.c | 38 ++++++++++++++++++++++++++++----------
 trace2/tr2_tls.h |  3 ++-
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index cd8b9f2f0a0..b68d297bf51 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -15,7 +15,16 @@ static uint64_t tr2tls_us_start_process;
 static pthread_mutex_t tr2tls_mutex;
 static pthread_key_t tr2tls_key;
 
-static int tr2_next_thread_id; /* modify under lock */
+/*
+ * This list owns all of the thread-specific CTX data.
+ *
+ * While a thread is alive it is associated with a CTX (owned by this
+ * list) and that CTX is installed in the thread's TLS data area.
+ *
+ * Similarly, `tr2tls_thread_main` points to a CTX contained within
+ * this list.
+ */
+static struct tr2tls_thread_ctx *tr2tls_ctx_list; /* modify under lock */
 
 void tr2tls_start_process_clock(void)
 {
@@ -46,7 +55,12 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
 
-	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
+	pthread_mutex_lock(&tr2tls_mutex);
+	if (tr2tls_ctx_list)
+		ctx->thread_id = tr2tls_ctx_list->thread_id + 1;
+	ctx->next_ctx = tr2tls_ctx_list;
+	tr2tls_ctx_list = ctx;
+	pthread_mutex_unlock(&tr2tls_mutex);
 
 	if (ctx->thread_id)
 		strbuf_addf(&buf_name, "th%02d:", ctx->thread_id);
@@ -91,15 +105,7 @@ int tr2tls_is_main_thread(void)
 
 void tr2tls_unset_self(void)
 {
-	struct tr2tls_thread_ctx *ctx;
-
-	ctx = tr2tls_get_self();
-
 	pthread_setspecific(tr2tls_key, NULL);
-
-	free(ctx->thread_name);
-	free(ctx->array_us_start);
-	free(ctx);
 }
 
 void tr2tls_push_self(uint64_t us_now)
@@ -163,11 +169,23 @@ void tr2tls_init(void)
 
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
+		free(ctx->thread_name);
+		free(ctx->array_us_start);
+		free(ctx);
+
+		ctx = next;
+	}
 }
 
 int tr2tls_locked_increment(int *p)
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index d968da6a679..c6b6c69b25a 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -9,6 +9,7 @@
 #define TR2_MAX_THREAD_NAME (24)
 
 struct tr2tls_thread_ctx {
+	struct tr2tls_thread_ctx *next_ctx;
 	char *thread_name;
 	uint64_t *array_us_start;
 	size_t alloc;
@@ -45,7 +46,7 @@ struct tr2tls_thread_ctx *tr2tls_get_self(void);
 int tr2tls_is_main_thread(void);
 
 /*
- * Free our TLS data.
+ * Disassociate thread's TLS CTX data from the thread.
  */
 void tr2tls_unset_self(void);
 
-- 
gitgitgadget

