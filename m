Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E0C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310DE6105A
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 22:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhJVWjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhJVWjs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:39:48 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E5C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:37:30 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w10so5799970ilc.13
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 15:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VAj2jO1BksH1puAI/BYN5rdF2GP9BzBKHR858Sh29zs=;
        b=bz2OD2a3DSYuH4EXmszSOSCuxPmOZpE4WuRPXihUXX86VWmsRzJ4grd3JxRlNCd1d9
         vjMm/ARGr0DifeaF45JgFVNxkhL4aB4N/qZfejwQfv42IzO2kpMGin9D9gGBXPuc66fu
         SKpcqH6cuamHRbQnuOmHX/Melt6XlBaec0pQGVEl9uPkNFPB0LuQwmckFWecRiynXqG9
         7M/ThL3raWMXFlZB5qhYljmFR2gU5V4E/2Ga5SpESQaTZd9NBNy1GB30wqx3EZCxeUxs
         8g8GAcVRf2ll/WEiBtk8DaXKEzEJYf4XGhIPq6QHiXQwNcWDCoM4OgLXTs2YQfmUsZ6Z
         H4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VAj2jO1BksH1puAI/BYN5rdF2GP9BzBKHR858Sh29zs=;
        b=5jPdEBnk3k+jDBbISIOE5i2kn3fKWTczuPcVsRnnHRIeSzlt+j7B7szrXavKWSaTFD
         zLdOAZ46jGD6auyY8iqlMBiD3EGDJDh/hHuehDIfAdxvT3CUUMSaY54at6RMLv8uxib7
         Buzy3gt/81R9ncC3H8YLEAnBPRzaGU0UBqknj0dIy6pNKiRQr98VnWn9DQqDEdW+d2eD
         uOEvtjrzsQD4rn6ZIlPU1Nkc6vT8AGjMF33Fe86NH+CWjFXOodXL9xRPUJ21i8SNwHZp
         Ed8+/u1mt0pXgX+Mk+emUkSzObkgH83a4/xpqfIZRluGa+Hw1aasfgG76x12gtioGB91
         7iTg==
X-Gm-Message-State: AOAM530utI8W+kUqZLr5x7ocXjDNd2aVNVbgnCSq4kM2+UGN9C/jqQlC
        kPYiOjSLAQbqGyjfHmyoDKH0dQ==
X-Google-Smtp-Source: ABdhPJxj05YTNFr6oVdF5mtsak6KTnQASYSzgmCl8ahx5mhXgvE5cfVh//BUFIHBQUbywjHA8KqOkQ==
X-Received: by 2002:a05:6e02:143:: with SMTP id j3mr1578990ilr.283.1634942250297;
        Fri, 22 Oct 2021 15:37:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k11sm4990955iov.20.2021.10.22.15.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:37:30 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:37:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 07/10] progress.c: add temporary variable from
 progress struct
Message-ID: <YXM9KVUousJXgRup@nand.local>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-07.10-cd2d27b1626-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-07.10-cd2d27b1626-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:23AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Add a temporary "progress" variable for the dereferenced p_progress
> pointer to a "struct progress *". Before 98a13647408 (trace2: log
> progress time and throughput, 2020-05-12) we didn't dereference
> "p_progress" in this function, now that we do it's easier to read the
> code if we work with a "progress" struct pointer like everywhere else,
> instead of a pointer to a pointer.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  progress.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/progress.c b/progress.c
> index 7fcc513717a..b9369e9a264 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -329,15 +329,16 @@ void stop_progress(struct progress **p_progress)
>  	finish_if_sparse(*p_progress);

This spot also wants to dereference p_progress, but doesn't access any
of the fields by dereferencing the second pointer. So this could
certainly have passed `progress` (had you scoped its declaration to the
whole function).

I don't think it hurts readability, and I definitely don't have a strong
opinion about it. Just an idle thought while reading this patch...

>  	if (*p_progress) {
> +		struct progress *progress = *p_progress;
>  		trace2_data_intmax("progress", the_repository, "total_objects",
>  				   (*p_progress)->total);
>
>  		if ((*p_progress)->throughput)
>  			trace2_data_intmax("progress", the_repository,
>  					   "total_bytes",
> -					   (*p_progress)->throughput->curr_total);
> +					   progress->throughput->curr_total);
>
> -		trace2_region_leave("progress", (*p_progress)->title, the_repository);
> +		trace2_region_leave("progress", progress->title, the_repository);

This all looks much better to me. Thanks.

Thanks,
Taylor
