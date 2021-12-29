Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE90C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 01:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhL2BOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 20:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbhL2BOS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 20:14:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B27C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 17:14:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l5so45438543edj.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 17:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FqwpVOtSQflcIWuJLNuPm/UCz2ZC5ipDknweJKREeF4=;
        b=a3K53mwsTmkjaxN1Pkr9V/T8+g/4eaxCvga1yV0FRstsnY4oWqfwIlDsNxpUoHchH5
         HxupASHL4rjP+QQ4r+xlWRrsTnjf3t7/ORx1LrEZfFTLQbrGcX6g2dxIN+9h0raznzqh
         GDR0HHb6SG/YAtcerIv29u5L5LLFAduGMq8YocPaZZgJ7+n+ejGsU+Jf+RgjUC8veuD5
         UQhYj6NWmp6sTVF1752u1NaKNX5w+0raIWffJa0o8Jp/UlDxqMjSSRabXmBHJX8jjMvu
         VryLep/pWGkFSeg3IUVbOcgB06oyDJ/a5M7mh4CAv54+0csDY7OjV6YCgR8BQ9qFRopc
         jQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FqwpVOtSQflcIWuJLNuPm/UCz2ZC5ipDknweJKREeF4=;
        b=Xzn/++5t3+he2vr5T8pnZv2PVAV7ixFQl+COXIyXEvUe1z7svUfaHeoemZNvJpkfnA
         xPK8pe6wdtCo3u9Fwhc3h6VdjRWRI8dgkRaMqB5tnWlXy0IQ+tj8B/GmJMlf1Rac5PQJ
         LqivEdp6HOhaOAbMpdHbibJztm/Db/+U6X6oZZDaJptYbOcH/GGQkOyHB5m1R/z5GxhU
         m/B+a6m9p/lhn/jeookCbboSxrv5F0PS/jp4oe5HD7lDtq5UCd387scZh6L80PKT5A/A
         aaF4lwx2cW2SzGHsrwTf+D2wUf4Kchh3Ek1F/7cY+xDk9VJCNSnJa0xg0JM3CyxEDBIF
         aF1A==
X-Gm-Message-State: AOAM533QnZrUEGadpYevR+52nWYPrdbIE1Oks6JYc2p7zhkbHnKARPCn
        YyufhsBAOZJhb7qkUcmPb/b9wcji88kdxzBA
X-Google-Smtp-Source: ABdhPJyPW5de5YRauf5kQdm6EXQvkePaRqxU5GknNg5w6zyi1hRoPZ6plBTfoQgp1bQwyt9pUvb8MA==
X-Received: by 2002:a05:6402:40cd:: with SMTP id z13mr23187840edb.103.1640740456394;
        Tue, 28 Dec 2021 17:14:16 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id t9sm7960847edd.94.2021.12.28.17.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 17:14:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2NXj-000Hak-6k;
        Wed, 29 Dec 2021 02:14:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 2/9] trace2: convert tr2tls_thread_ctx.thread_name
 from strbuf to flex array
Date:   Wed, 29 Dec 2021 02:11:50 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
 <ff8df1b148ec486f565a59cb8a227bfa2ef48313.1640720202.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ff8df1b148ec486f565a59cb8a227bfa2ef48313.1640720202.git.gitgitgadget@gmail.com>
Message-ID: <211229.86mtkkgql4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 28 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Move the thread name to a flex array at the bottom of the Trace2
> thread local storage data and get rid of the strbuf.
>
> Let the flex array have the full computed value of the thread name
> without truncation.
>
> Change the PERF target to truncate the thread name so that the columns
> still line up.

This commit message really doesn't help in explaining what we're trying
to do here and why it's needed. I'm not saying it's not, but why not a
strbuf, why a flex array? The diff below also shows changes unrelated to
this.

I tried this local fixup on top of this series which works, so I wonder
if we're just trying to get rid of the strbuf to signal that this
shouldn't change why not just strbuf_detach() and keep a "const char
*thread_name"?

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 28ea55863d1..35d49b27b2e 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -48,7 +48,7 @@ void tr2tls_start_process_clock(void)
 struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 					     uint64_t us_thread_start)
 {
-	struct tr2tls_thread_ctx *ctx;
+	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(struct tr2tls_thread_ctx));
 	struct strbuf buf_name = STRBUF_INIT;
 	int thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
 
@@ -56,8 +56,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 		strbuf_addf(&buf_name, "th%02d:", thread_id);
 	strbuf_addstr(&buf_name, thread_name);
 
-	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
-	strbuf_release(&buf_name);
+	ctx->thread_name = strbuf_detach(&buf_name, NULL);
 
 	ctx->thread_id = thread_id;
 
@@ -188,6 +187,7 @@ void tr2tls_release(void)
 	while (ctx) {
 		struct tr2tls_thread_ctx *next = ctx->next_ctx;
 
+		free((char *)ctx->thread_name);
 		free(ctx->array_us_start);
 		free(ctx);
 
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 503829bbd44..bc6c6f12e38 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -6,6 +6,7 @@
 #include "trace2/tr2_tmr.h"
 
 struct tr2tls_thread_ctx {
+	const char *thread_name;
 	struct tr2tls_thread_ctx *next_ctx;
 	uint64_t *array_us_start;
 	size_t alloc;
@@ -14,8 +15,6 @@ struct tr2tls_thread_ctx {
 
 	struct tr2_timer_block timers;
 	struct tr2_counter_block counters;
-
-	char thread_name[FLEX_ARRAY];
 };
 
 /*

> [...]
> index 7da94aba522..ed99a234b95 100644
> --- a/trace2/tr2_tls.c
> +++ b/trace2/tr2_tls.c
> @@ -34,7 +34,18 @@ void tr2tls_start_process_clock(void)
>  struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>  					     uint64_t us_thread_start)
>  {
> -	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
> +	struct tr2tls_thread_ctx *ctx;
> +	struct strbuf buf_name = STRBUF_INIT;
> +	int thread_id = tr2tls_locked_increment(&tr2_next_thread_id);

Here's the looks-to-be-unrelated to this strbuf conversion code I
mentioned above.

> +
> +	if (thread_id)
> +		strbuf_addf(&buf_name, "th%02d:", thread_id);
> +	strbuf_addstr(&buf_name, thread_name);
> +
> +	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
> +	strbuf_release(&buf_name);
> +
> +	ctx->thread_id = thread_id;
>  
>  	/*
> [...]
