Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83CFC49EA6
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 01:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863E760FE3
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 01:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhFYB0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFYB0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 21:26:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3CDC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 18:24:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso4819877wmj.0
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 18:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PB38/TGzgaTCXtiwPYT9OjQk0vmMHdPqCPRyA2rCWTM=;
        b=Q2d5AKJxx5UtDKtYGBdDbVwJM7qpoDCqv8A7DzbwCz1x9tZ1wrjbL9Pm1DV6ojROvH
         ZSljPLmjm9Hdp6xfdbdeANu78CO9e+2EdteG0hHhMGRNxhXa8BSc+3cUiSH+T8vh2EnI
         kGdkPGcZJ0ShUo2WTbR5JBLC4tKrJuhCZ5Q3Gi3rYEKLadtjE6Tx7mVug8v7UXM81nn7
         SY8V1IDeXK+0Opr+M7BkAj/2b/hb5RYn5UQT+loceil4fg3AOHKB4YjjXChJcW75G6Bt
         lug80e/legXoiG256ANHlfZUR613xPOLtah5CU1+E1QfBjPrgYCaOS/Kw7dUgCDFIdQm
         BmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PB38/TGzgaTCXtiwPYT9OjQk0vmMHdPqCPRyA2rCWTM=;
        b=o+wsQeMMJCf0TrHcHBJys6O5QClHG1RVSn3LpN8wx6PUYF84fPkxXPkDzgr20kXDcB
         JFndtHOkZIR60ivxJDnWSHQla3zMdqaiYIv6aaB03nqkow599NF1JMCagbW3LyYw2d1c
         rw66GMiVO7QKXyVrL9gQeCPs/VcJ+d/jE5rlKQRp7b+mtJOVkRfzA5FCL8RtYmsNKs0w
         idVyGBdLEgb8bVooyplfAxYkRdwdkZ4Lh7UOzu8bkr5PPyY4c3ojXFTf3oTNpyHqIavt
         m7IhNqLNjlRprshnpZM9XQIA3mWqnDyREP03ZarCzhmK5EcB9E3fVrPXALD9TM1AVGkt
         q2Aw==
X-Gm-Message-State: AOAM531gLGwKPFlddkirzToyrtpOz2UXPQSHUUtk//Y4HLTJE6MFciM5
        OARhbX5TSrMtlD6H+EmgmJA=
X-Google-Smtp-Source: ABdhPJzZCsHgrAcrKanAHtneHcFJEuqPkkkS38NwrF3nrARO7S4+QvPu7GwDVmP3QYGAVO5/CgDXFw==
X-Received: by 2002:a1c:f70b:: with SMTP id v11mr7588159wmh.186.1624584262189;
        Thu, 24 Jun 2021 18:24:22 -0700 (PDT)
Received: from [10.17.18.5] ([46.246.3.237])
        by smtp.gmail.com with ESMTPSA id f22sm4251892wmb.46.2021.06.24.18.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 18:24:21 -0700 (PDT)
Subject: Re: [PATCH 22/25] progress.c: add a stop_progress_early() function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
References: <YNKWsTsQgB2Ijxu7@nand.local>
 <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
 <patch-22.25-e7f8314867d-20210623T155626Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <0e317e88-03fc-9d5b-6fa4-eb5bc3422f78@gmail.com>
Date:   Fri, 25 Jun 2021 03:24:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <patch-22.25-e7f8314867d-20210623T155626Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/2021 19:48, Ævar Arnfjörð Bjarmason wrote:
> In cases where we error out during processing or otherwise miss
> initial "total" estimate we'll still want to show a "done" message and
> end our trace2 region, but it won't be true that our total ==
> last_update at the end.
> 
> So let's add a "last_update" and this stop_progress_early() function
> to handle that edge case, this will be used in a subsequent commit.
> 
> We could also use a total=0 in such cases, but that would make the
> progress output worse for the common non-erroring case. Let's instead
> note that we didn't reach the total count, and snap the progress bar
> to "100%, done" at the end.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   progress.c | 20 ++++++++++++++++++++
>   progress.h |  2 ++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/progress.c b/progress.c
> index 35847d3a7f2..c1cb01ba975 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -40,6 +40,8 @@ static void display(struct progress *progress, uint64_t n,
>   	const char *tp;
>   	int show_update = 0;
>   
> +	progress->last_update = n;
> +
>   	if (progress->delay && (!progress_update || --progress->delay))
>   		return;
>   
> @@ -413,3 +415,21 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
>   	free(progress->throughput);
>   	free(progress);
>   }
> +
> +void stop_progress_early(struct progress **p_progress)
> +{
> +	struct progress *progress;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (!p_progress)
> +		BUG("don't provide NULL to stop_progress_early");
> +	progress = *p_progress;
> +	if (!progress)
> +		return;
> +
> +	strbuf_addf(&sb, _(", done at %"PRIuMAX" items, expected %"PRIuMAX"."),
> +		    progress->total, progress->last_update);

It seems that these two arguments to strbuf_addf should be swapped
around.  Done at progress->last_update, expected progress->total.

> +	progress->total = progress->last_update;
> +	stop_progress_msg(p_progress, sb.buf);
> +	strbuf_release(&sb);
> +}
> diff --git a/progress.h b/progress.h
> index ba38447d104..5c5d027d1a0 100644
> --- a/progress.h
> +++ b/progress.h
> @@ -23,6 +23,7 @@ struct progress {
>   	struct strbuf status;
>   	size_t status_len_utf8;
>   
> +	uint64_t last_update;
>   	uint64_t last_value;
>   	uint64_t total;
>   	unsigned last_percent;
> @@ -56,5 +57,6 @@ struct progress *start_delayed_sparse_progress(const char *title,
>   					       uint64_t total);
>   void stop_progress(struct progress **progress);
>   void stop_progress_msg(struct progress **progress, const char *msg);
> +void stop_progress_early(struct progress **p_progress);
>   
>   #endif
> 

