Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A1C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 01:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiJGBKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 21:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJGBKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 21:10:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776B13FA30
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 18:10:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t4so2016974wmj.5
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUJ6gA3GrVElkb5+LPIfGlF7hIXeFnZybW4AEOtzqjk=;
        b=nX8K3MJZvzg6a2cDm2Q9S7uLsPWuNDubQMmIHmyPxRTHfxnRJzwYRz7YQV8Up9HShi
         F+la7dd6nWt0/O8+0kqzaQRoP1zL/rwgHgHRcv7iVEG0n7avumH8jW8Rre3RhPEP9R5r
         xCoz8jn5Tte3s1+/6PIJ3tJgmHTFU8AglXA2f4/SIVGXk7NEh2AbhufZz3WKn+PhfMm+
         HcmOWBmRokwArEiZ9zr9pczzT28wV26M5HFd3KCUQbSsTh9wSesQmPJRv8x1s0v6MSJQ
         C4Ywg+fi8lmKrG4Pip/d8n8TYw8FfbJ+X/9K3+M+t2rtaUQagAYgDarW8peFwHVC8mCL
         ek1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUJ6gA3GrVElkb5+LPIfGlF7hIXeFnZybW4AEOtzqjk=;
        b=CU25cKrsl7/j/9XSeWGJrpZXujbIZXaU2OPSWtDZth35CTysT2clm9tk/9JtyfJhQd
         he9W791ZbfcLZxLFXS5A4oggRJvxZLLC/g3ehanbkaxQdulvHJkHmY29yuijUojhRvIt
         9eTJt2PGRPArfS0NfFdiZj4V/0Yn+FS1osKaKkmMJEFb1HhQgA+GxWRCe3FksBGpsvwT
         xIgEmo7jxtHTLWPzGOEYTyS3bL3bNmf9hFB6s4++BI5GFJjPSMjL8DM7CX4Qad3qARHX
         5WsY1ZS2VOxF9CKe+/0vVmeEvJ+i7U2mDcC4lrkFNP47H9UTlw7ker3QUFuHCUA4ogr8
         i7PA==
X-Gm-Message-State: ACrzQf1aDncVIWmlDHrqvJKKI6UJOeTMOQqD7xlx3ArOIjIk9YAlw8nn
        Uh1DXXBhFBW5EcfPHMkwjgaxZkY7iVo=
X-Google-Smtp-Source: AMsMyM5yinaouEthvfZJzm9AObh+BSXDMXmMIaRFkrgDYrpXnOOmxndARJb+huuzuduf+Qv2d8FfSQ==
X-Received: by 2002:a05:600c:3512:b0:3b4:bcde:26ad with SMTP id h18-20020a05600c351200b003b4bcde26admr8953745wmq.164.1665105009517;
        Thu, 06 Oct 2022 18:10:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0022e3978fd07sm690169wry.39.2022.10.06.18.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 18:10:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH] trace2 API: don't save a copy of constant "thread_name"
Date:   Fri,  7 Oct 2022 03:10:06 +0200
Message-Id: <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <xmqqr0zkipva.fsf@gitster.g>
References: <xmqqr0zkipva.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since ee4512ed481 (trace2: create new combined trace facility,
2019-02-22) the "thread_name" member of "struct tr2tls_thread_ctx" has
been copied from the caller, but those callers have always passed a
constant string:

	$ git -P grep '^\s*trace2_thread_start\('
	Documentation/technical/api-trace2.txt: trace2_thread_start("preload_thread");
	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-health");
	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-listen");
	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-worker");
	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-accept");
	compat/simple-ipc/ipc-win32.c:  trace2_thread_start("ipc-server");
	t/helper/test-fsmonitor-client.c:       trace2_thread_start("hammer");
	t/helper/test-simple-ipc.c:     trace2_thread_start("multiple");

This isn't needed for optimization, but apparently[1] there's been
some confusion about the non-const-ness of the previous "struct
strbuf".

Using the caller's string here makes this more straightforward, as
it's now clear that we're not dynamically constructing these. It's
also what the progress API does with its "title" string.

Since we know we're hardcoding these thread names let's BUG() out when
we see that the length of the name plus the length of the prefix would
exceed the maximum length for the "perf" format.

1. https://lore.kernel.org/git/82f1672e180afcd876505a4354bd9952f70db49e.1664900407.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Oct 06 2022, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>> So, we don't need to strdup() and store that "preload_thread" anywhere.
>> It's already a constant string we have hardcoded in the program. We just
>> need to save a pointer to it.
>
> That sounds even simpler.

A cleaned up version of the test code I had on top of "master", RFC
because I may still be missing some context here. E.g. maybe there's a
plan to dynamically construct these thread names?

 json-writer.c          | 17 +++++++++++++++++
 json-writer.h          |  4 ++++
 trace2/tr2_tgt_event.c |  2 +-
 trace2/tr2_tgt_perf.c  | 10 +++++++---
 trace2/tr2_tls.c       | 14 +++++---------
 trace2/tr2_tls.h       |  9 +++++++--
 6 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index f1cfd8fa8c6..569a75bee51 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -161,6 +161,23 @@ void jw_object_string(struct json_writer *jw, const char *key, const char *value
 	append_quoted_string(&jw->json, value);
 }
 
+void jw_strbuf_add_thread_name(struct strbuf *sb, const char *thread_name,
+			       int thread_id)
+{
+	if (thread_id)
+		strbuf_addf(sb, "th%02d:", thread_id);
+	strbuf_addstr(sb, thread_name);
+}
+
+void jw_object_string_thread(struct json_writer *jw, const char *thread_name,
+			     int thread_id)
+{
+	object_common(jw, "thread");
+	strbuf_addch(&jw->json, '"');
+	jw_strbuf_add_thread_name(&jw->json, thread_name, thread_id);
+	strbuf_addch(&jw->json, '"');
+}
+
 void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t value)
 {
 	object_common(jw, key);
diff --git a/json-writer.h b/json-writer.h
index 209355e0f12..269c203b119 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -75,6 +75,10 @@ void jw_release(struct json_writer *jw);
 void jw_object_begin(struct json_writer *jw, int pretty);
 void jw_array_begin(struct json_writer *jw, int pretty);
 
+void jw_strbuf_add_thread_name(struct strbuf *buf, const char *thread_name,
+			       int thread_id);
+void jw_object_string_thread(struct json_writer *jw, const char *thread_name,
+			     int thread_id);
 void jw_object_string(struct json_writer *jw, const char *key,
 		      const char *value);
 void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t value);
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 37a3163be12..1308cf05df4 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -90,7 +90,7 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 
 	jw_object_string(jw, "event", event_name);
 	jw_object_string(jw, "sid", tr2_sid_get());
-	jw_object_string(jw, "thread", ctx->thread_name.buf);
+	jw_object_string_thread(jw, ctx->thread_name, ctx->thread_id);
 
 	/*
 	 * In brief mode, only emit <time> on these 2 event types.
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 8cb792488c8..ab21277eb36 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -69,6 +69,8 @@ static void perf_fmt_prepare(const char *event_name,
 			     const char *category, struct strbuf *buf)
 {
 	int len;
+	size_t oldlen;
+	int padlen;
 
 	strbuf_setlen(buf, 0);
 
@@ -107,9 +109,11 @@ static void perf_fmt_prepare(const char *event_name,
 	}
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
-	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
-		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
-		    event_name);
+	oldlen = buf->len;
+	jw_strbuf_add_thread_name(buf, ctx->thread_name, ctx->thread_id);
+	padlen = TR2_MAX_THREAD_NAME - (buf->len - oldlen);;
+	strbuf_addf(buf, "%-*s | %-*s | ", padlen, "",
+		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
 
 	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
 	if (repo)
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 7da94aba522..aa9aeb67fca 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -36,6 +36,9 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 {
 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
 
+	if (strlen(thread_name) + TR2_MAX_THREAD_NAME_PREFIX > TR2_MAX_THREAD_NAME)
+		BUG("too long thread name '%s'", thread_name);
+
 	/*
 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
 	 * time in array_us_start[0].  For the main thread this gives us the
@@ -45,15 +48,9 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
 
+	ctx->thread_name = thread_name;
 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
 
-	strbuf_init(&ctx->thread_name, 0);
-	if (ctx->thread_id)
-		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
-	strbuf_addstr(&ctx->thread_name, thread_name);
-	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
-		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
-
 	pthread_setspecific(tr2tls_key, ctx);
 
 	return ctx;
@@ -95,7 +92,6 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
-	strbuf_release(&ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
@@ -113,7 +109,7 @@ void tr2tls_pop_self(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
 	if (!ctx->nr_open_regions)
-		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
+		BUG("no open regions in thread '%s'", ctx->thread_name);
 
 	ctx->nr_open_regions--;
 }
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index b1e327a928e..f600eb22551 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -4,12 +4,17 @@
 #include "strbuf.h"
 
 /*
- * Arbitry limit for thread names for column alignment.
+ * Arbitry limit for thread names for column alignment. The overall
+ * max length is TR2_MAX_THREAD_NAME, and the
+ * TR2_MAX_THREAD_NAME_PREFIX is the length of the formatted
+ * '"th%02d:", ctx->thread_id' prefix which is added when "thread_id >
+ * 0".
  */
+#define TR2_MAX_THREAD_NAME_PREFIX (5)
 #define TR2_MAX_THREAD_NAME (24)
 
 struct tr2tls_thread_ctx {
-	struct strbuf thread_name;
+	const char *thread_name;
 	uint64_t *array_us_start;
 	int alloc;
 	int nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
-- 
2.38.0.971.ge79ff6d20e7

