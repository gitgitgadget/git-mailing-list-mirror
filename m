Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04870C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhL1Tgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbhL1Tgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751ABC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so40171101wra.6
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GFBd797eHYnH0eNzK9O41oTMilucb0iYBWz2vFrtEVo=;
        b=NEYDXU57NWPsDqKP4Nr5VNQOYV56+3dXHGlNYLi5QDYuvaAX54x0kQT6aCrIY+JbEO
         wSAPOovTra8v6omRyimND2hcBeoJu09OhUGDoGPW1lKU+mNOUKlF6KNntiS9U7L+GPoD
         7hkjujBSQ2fGUB6H/z4g+1SocfuCTHAWTzbQ+TAWNA5MQOx2ywXdjcFGnfqf9YoUmGiK
         lmLx3AkXYYWWzLLaWv8arNoxidVAlnEi4OBbnUrjLhWP5ygMba4uidTdZqWkb5/1sFx3
         1vY0yMyeNpTTuadW293jT03+/pF6HFEaTC4ImKwgXDwM4aGhLgJPVESnQYmrPJ2TKjha
         QkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GFBd797eHYnH0eNzK9O41oTMilucb0iYBWz2vFrtEVo=;
        b=7dfgc52IFugQk5R3NxYxNiGa4nFA47n630icpVj5uKq3paDBSovWaHp7u5MRoyi2HA
         JV1w5MHPKtzV8YZLECcQ+dRuxCPYRShZj9IA4MyeZJJSXWKiInhenSsKXReBtBSdkbtP
         2GBxcYYNWONYAXC7GQkCrCzoeoimGteZliKXsh0F6BoRyILMgzlhXq94HECGaN1otOzO
         n2eWIt1xbf1av1NZ1WW3B7CW8ROTyXg0X5WVbd6/T1z/LhT1DNTLozwCZ5v8rDqvRKhi
         A1JNNhvL7yVbMyNVDVToa2TZuXG2t3e4RtKEkJNxgr01jxZgz2kGznF+afZrZGoHRvQN
         5ymw==
X-Gm-Message-State: AOAM533mxc45GkiCTiJuAcMoqH9Vzu9TMs2o0WxoX+QZlWBLPwGdjnub
        r9vvHJ2PO+TJEge1SIxRfedkh/hf7R8=
X-Google-Smtp-Source: ABdhPJzbL+4KOj2HAufKYwOevV3vNbQLXllZELME/GYyOI5fIsqgABIbc4pDltXx/nlN15EphUl66Q==
X-Received: by 2002:a5d:6e8c:: with SMTP id k12mr17189356wrz.664.1640720204832;
        Tue, 28 Dec 2021 11:36:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o38sm17688444wms.11.2021.12.28.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:44 -0800 (PST)
Message-Id: <ff8df1b148ec486f565a59cb8a227bfa2ef48313.1640720202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:35 +0000
Subject: [PATCH v2 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to flex array
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

Move the thread name to a flex array at the bottom of the Trace2
thread local storage data and get rid of the strbuf.

Let the flex array have the full computed value of the thread name
without truncation.

Change the PERF target to truncate the thread name so that the columns
still line up.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_event.c |  2 +-
 trace2/tr2_tgt_perf.c  |  7 ++++---
 trace2/tr2_tls.c       | 25 +++++++++++++------------
 trace2/tr2_tls.h       | 10 +---------
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 3a0014417cc..ca48d00aebc 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -88,7 +88,7 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 
 	jw_object_string(jw, "event", event_name);
 	jw_object_string(jw, "sid", tr2_sid_get());
-	jw_object_string(jw, "thread", ctx->thread_name.buf);
+	jw_object_string(jw, "thread", ctx->thread_name);
 
 	/*
 	 * In brief mode, only emit <time> on these 2 event types.
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index e4acca13d64..fd6cce3efe5 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -23,6 +23,7 @@ static int tr2env_perf_be_brief;
 
 #define TR2FMT_PERF_FL_WIDTH (28)
 #define TR2FMT_PERF_MAX_EVENT_NAME (12)
+#define TR2FMT_PERF_MAX_THREAD_NAME (24)
 #define TR2FMT_PERF_REPO_WIDTH (3)
 #define TR2FMT_PERF_CATEGORY_WIDTH (12)
 
@@ -105,9 +106,9 @@ static void perf_fmt_prepare(const char *event_name,
 	}
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
-	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
-		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
-		    event_name);
+	strbuf_addf(buf, "%-*.*s | %-*s | ", TR2FMT_PERF_MAX_THREAD_NAME,
+		    TR2FMT_PERF_MAX_THREAD_NAME, ctx->thread_name,
+		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
 
 	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
 	if (repo)
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 7da94aba522..ed99a234b95 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -34,7 +34,18 @@ void tr2tls_start_process_clock(void)
 struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 					     uint64_t us_thread_start)
 {
-	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
+	struct tr2tls_thread_ctx *ctx;
+	struct strbuf buf_name = STRBUF_INIT;
+	int thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
+
+	if (thread_id)
+		strbuf_addf(&buf_name, "th%02d:", thread_id);
+	strbuf_addstr(&buf_name, thread_name);
+
+	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
+	strbuf_release(&buf_name);
+
+	ctx->thread_id = thread_id;
 
 	/*
 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
@@ -45,15 +56,6 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
 
-	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
-
-	strbuf_init(&ctx->thread_name, 0);
-	if (ctx->thread_id)
-		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
-	strbuf_addstr(&ctx->thread_name, thread_name);
-	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
-		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
-
 	pthread_setspecific(tr2tls_key, ctx);
 
 	return ctx;
@@ -95,7 +97,6 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
-	strbuf_release(&ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
@@ -113,7 +114,7 @@ void tr2tls_pop_self(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
 	if (!ctx->nr_open_regions)
-		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
+		BUG("no open regions in thread '%s'", ctx->thread_name);
 
 	ctx->nr_open_regions--;
 }
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index a90bd639d48..64d97c5ac03 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -3,17 +3,12 @@
 
 #include "strbuf.h"
 
-/*
- * Arbitry limit for thread names for column alignment.
- */
-#define TR2_MAX_THREAD_NAME (24)
-
 struct tr2tls_thread_ctx {
-	struct strbuf thread_name;
 	uint64_t *array_us_start;
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
+	char thread_name[FLEX_ARRAY];
 };
 
 /*
@@ -25,9 +20,6 @@ struct tr2tls_thread_ctx {
  * non-zero thread-ids to help distinguish messages from concurrent
  * threads.
  *
- * Truncate the thread name if necessary to help with column alignment
- * in printf-style messages.
- *
  * In this and all following functions the term "self" refers to the
  * current thread.
  */
-- 
gitgitgadget

