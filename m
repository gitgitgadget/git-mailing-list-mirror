Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77596C433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhLTPVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhLTPTq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17039C0698D0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i12so7067434wmq.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tg2UHx+MujxPA9p6uiM/b/hpHEmiOdWIZd94cwYVGwE=;
        b=ZMlWf1DngZEEf01Sf9jbnTmOsNUmT+w70PVqfYe4BTw8nz6HJS2thXINclMVIbI3YO
         ZE1H5vCEg7RTHlt8R59d9SULbJQ6SwONCgrx+7894RpYwJzVNU5EM/DCS69+uB7dK51I
         LEWq7UDWsiciF+rdcVed09AX7t/H5sckzR6CXmcTpIuykk61VDV85hYSxrtGjxNUUyUk
         SAkr0ZNnn35Cwq35Xo2wGUjCseqMxJMtyBMPdwADD9Nm9EJ9qikonVI2p5GTRs98eJWL
         +H3LvJEcQEdrepvUHmKW9R0bRlLyfjKXfUyrDKU8Y2jmXOQmzuzjc01LxJvauKl/m81S
         C43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tg2UHx+MujxPA9p6uiM/b/hpHEmiOdWIZd94cwYVGwE=;
        b=FydLRSGbZMxpBWz7IaFOuIRGk+A5Oulvpa+gyucjNl58prCz24q5jf5dJ9vDo8uP1n
         EEfmP6+AYaWNQRi4Cj5cbTk821CrbpCuaVFdlBKVR8mXhvnYn/Y8Mq1PfK4tnp+brYxT
         Y2rYD6mqM0NWLDZnU7tdsgwq2hxrdIh+At1V++hG9qp6+Q68AHvmeMIAcpQekySB/YKL
         nzu9yF1i5JCvo8UZ/d72lsHfmdVFFnUPUuXi2LwFU1LwlVc+7xIl4mjBp+xRMbYMd4iE
         AFFj/P4J3tZ9OfphnwJchl26HbcEwQxp76itHjRW+Yr//VN6FcU2hkO/ZKyLp4SrbTIK
         aBwQ==
X-Gm-Message-State: AOAM530o8lLIvEHnTdSDDD18uMJdPHPd3ghCJM++iOJUXd/0QbUtbcbn
        Q/+2zD7r7CiGTktPEXJZOcBoGpVEpIk=
X-Google-Smtp-Source: ABdhPJw1TC8tHvugZdqdoz59isbwZj8uvd5NlL0apdZN7BfjLvuZ6/0cUvP6AIROU0FEO7cIsF81+w==
X-Received: by 2002:a05:600c:a06:: with SMTP id z6mr21292153wmp.9.1640012471549;
        Mon, 20 Dec 2021 07:01:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm1552746wmq.11.2021.12.20.07.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:11 -0800 (PST)
Message-Id: <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:02 +0000
Subject: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from strbuf
 to char*
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

Use a 'char *' to hold the thread name rather than a 'struct strbuf'.
The thread name is set when the thread is created and should not be
be modified afterwards.  Replace the strbuf with an allocated pointer
to make that more clear.

This was discussed in: https://lore.kernel.org/all/xmqqa6kdwo24.fsf@gitster.g/

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_event.c |  2 +-
 trace2/tr2_tgt_perf.c  |  2 +-
 trace2/tr2_tls.c       | 16 +++++++++-------
 trace2/tr2_tls.h       |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

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
index e4acca13d64..c3e57fcb3c0 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -106,7 +106,7 @@ static void perf_fmt_prepare(const char *event_name,
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
 	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
-		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
+		    ctx->thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
 		    event_name);
 
 	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 7da94aba522..cd8b9f2f0a0 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -35,6 +35,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 					     uint64_t us_thread_start)
 {
 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
+	struct strbuf buf_name = STRBUF_INIT;
 
 	/*
 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
@@ -47,12 +48,13 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 
 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
 
-	strbuf_init(&ctx->thread_name, 0);
 	if (ctx->thread_id)
-		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
-	strbuf_addstr(&ctx->thread_name, thread_name);
-	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
-		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
+		strbuf_addf(&buf_name, "th%02d:", ctx->thread_id);
+	strbuf_addstr(&buf_name, thread_name);
+	if (buf_name.len > TR2_MAX_THREAD_NAME)
+		strbuf_setlen(&buf_name, TR2_MAX_THREAD_NAME);
+
+	ctx->thread_name = strbuf_detach(&buf_name, NULL);
 
 	pthread_setspecific(tr2tls_key, ctx);
 
@@ -95,7 +97,7 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
-	strbuf_release(&ctx->thread_name);
+	free(ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
@@ -113,7 +115,7 @@ void tr2tls_pop_self(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
 	if (!ctx->nr_open_regions)
-		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
+		BUG("no open regions in thread '%s'", ctx->thread_name);
 
 	ctx->nr_open_regions--;
 }
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index a90bd639d48..d968da6a679 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -9,7 +9,7 @@
 #define TR2_MAX_THREAD_NAME (24)
 
 struct tr2tls_thread_ctx {
-	struct strbuf thread_name;
+	char *thread_name;
 	uint64_t *array_us_start;
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
-- 
gitgitgadget

