Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F552C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbhLTQgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhLTQgT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 11:36:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1053EC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:36:19 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j21so36271383edt.9
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tXt0PzRZeXYTBwWyZVvuUxkykS3gTIhOByJsz48lfZ0=;
        b=JhrQhfsU9/xIhehmoSRZWTzjMYE92fpmKYT/IH5Vk5Z4UREOEUq1e4fYuxel4tfhtU
         Lf5RHu4odpBYigLg6JUg/rQWzS6I88178NjhkasZKv/sxUGpEyagsVTrSej76siPlFs8
         MoqK0Rq5HENa2Y1Y9wyyrEnFW8mNh/JrF4BbzelEZMXD/58iypaiZvgRcI8XR/i6xBj/
         Dr457vTIxojpoobfNrlr77hb26GVYmOW1/F/AO1XnObNRRlObZZcVjwh5PDhdUXCWGwm
         HL4Ik6++5n9gLTSWaFit1kLhKgMuYelz3FPs4DVsDkVkXg2L+6otRcixGkRvX16Natsd
         XhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tXt0PzRZeXYTBwWyZVvuUxkykS3gTIhOByJsz48lfZ0=;
        b=AkpezxlwsL3KcI3wLCqCiWI8lKWKcLlQpERonE3fpXbvE9hp4YherMAL3EN231gWKK
         d0RJmvYsb9hBIfwO6BXDem0xBksBaVWGEp0eE6j3fhQK2yhOgFQ8eKVok+fII76m6U+l
         Mgvl9pbWyfYRLRMJujCkGweiCaxov5ndB2AECAnS2jshPLM7b9AluUSRDo9KtHNgbSGP
         lmIiI5RlYF3nsqmjT3BciuMnUJPZMIyi/+bVMrTxK9cCzng2AQbvo+DM/ma9RbLx1RVK
         blJdSdQ5wJxnoCv5CW9+Lf6i1pBKTQpLshAQsQtgTClNiP7rY6ZQVxwxqCo4IFC2qXht
         wsyA==
X-Gm-Message-State: AOAM531wbUEnZe1CTrT12t+6bTyAXtG3oXOLnigDEqogX/Wr4laUNX4C
        ip0Wlz39Rl2ftQJNrk3lNDORHtmSTqw85w==
X-Google-Smtp-Source: ABdhPJzUB6h7cESYWMHF2GTFo93IZKoBunUMEhHvSfmQzRhPgJpxIT4n12UTjpue8bH/uicRNNiF3w==
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr16767285edf.60.1640018177539;
        Mon, 20 Dec 2021 08:36:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sd5sm691506ejc.37.2021.12.20.08.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 08:36:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzLe4-000TDy-Ng;
        Mon, 20 Dec 2021 17:36:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to char*
Date:   Mon, 20 Dec 2021 17:31:27 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
Message-ID: <211220.86pmprutbz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Use a 'char *' to hold the thread name rather than a 'struct strbuf'.
> The thread name is set when the thread is created and should not be
> be modified afterwards.  Replace the strbuf with an allocated pointer
> to make that more clear.
>
> This was discussed in: https://lore.kernel.org/all/xmqqa6kdwo24.fsf@gitster.g/
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  trace2/tr2_tgt_event.c |  2 +-
>  trace2/tr2_tgt_perf.c  |  2 +-
>  trace2/tr2_tls.c       | 16 +++++++++-------
>  trace2/tr2_tls.h       |  2 +-
>  4 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index 3a0014417cc..ca48d00aebc 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -88,7 +88,7 @@ static void event_fmt_prepare(const char *event_name, const char *file,
>  
>  	jw_object_string(jw, "event", event_name);
>  	jw_object_string(jw, "sid", tr2_sid_get());
> -	jw_object_string(jw, "thread", ctx->thread_name.buf);
> +	jw_object_string(jw, "thread", ctx->thread_name);
>  
>  	/*
>  	 * In brief mode, only emit <time> on these 2 event types.
> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> index e4acca13d64..c3e57fcb3c0 100644
> --- a/trace2/tr2_tgt_perf.c
> +++ b/trace2/tr2_tgt_perf.c
> @@ -106,7 +106,7 @@ static void perf_fmt_prepare(const char *event_name,
>  
>  	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
>  	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
> -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
> +		    ctx->thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
>  		    event_name);
>  
>  	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
> diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
> index 7da94aba522..cd8b9f2f0a0 100644
> --- a/trace2/tr2_tls.c
> +++ b/trace2/tr2_tls.c
> @@ -35,6 +35,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>  					     uint64_t us_thread_start)
>  {
>  	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
> +	struct strbuf buf_name = STRBUF_INIT;
>  
>  	/*
>  	 * Implicitly "tr2tls_push_self()" to capture the thread's start
> @@ -47,12 +48,13 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>  
>  	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
>  
> -	strbuf_init(&ctx->thread_name, 0);
>  	if (ctx->thread_id)
> -		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
> -	strbuf_addstr(&ctx->thread_name, thread_name);
> -	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
> -		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
> +		strbuf_addf(&buf_name, "th%02d:", ctx->thread_id);
> +	strbuf_addstr(&buf_name, thread_name);
> +	if (buf_name.len > TR2_MAX_THREAD_NAME)
> +		strbuf_setlen(&buf_name, TR2_MAX_THREAD_NAME);
> +
> +	ctx->thread_name = strbuf_detach(&buf_name, NULL);
>  
>  	pthread_setspecific(tr2tls_key, ctx);
>  
> @@ -95,7 +97,7 @@ void tr2tls_unset_self(void)
>  
>  	pthread_setspecific(tr2tls_key, NULL);
>  
> -	strbuf_release(&ctx->thread_name);
> +	free(ctx->thread_name);
>  	free(ctx->array_us_start);
>  	free(ctx);
>  }
> @@ -113,7 +115,7 @@ void tr2tls_pop_self(void)
>  	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
>  
>  	if (!ctx->nr_open_regions)
> -		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
> +		BUG("no open regions in thread '%s'", ctx->thread_name);
>  
>  	ctx->nr_open_regions--;
>  }
> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
> index a90bd639d48..d968da6a679 100644
> --- a/trace2/tr2_tls.h
> +++ b/trace2/tr2_tls.h
> @@ -9,7 +9,7 @@
>  #define TR2_MAX_THREAD_NAME (24)
>  
>  struct tr2tls_thread_ctx {
> -	struct strbuf thread_name;
> +	char *thread_name;
>  	uint64_t *array_us_start;
>  	size_t alloc;
>  	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */

Junio's suggestion in the linked E-Mail was to make this a "const char *".

Narrowly, I don't see why not just add a "const" to the "struct strbuf
*" instead.

But less narrowly if we're not going to change it why malloc a new one
at all? Can't we just use the "const char *" passed into
tr2tls_create_self(), and for the "th%02d:" case have the code that's
formatting it handle that case?

I.e. have the things that use it as a "%s" now call a function that
formats things as a function of the "ctx->thread_id" (which may be 0)
and limit it by TR2_MAX_THREAD_NAME?
