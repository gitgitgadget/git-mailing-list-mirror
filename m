Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C2AC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC5161053
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhJHEBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhJHEBt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:01:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B2C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 20:59:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id a73so1914985pge.0
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 20:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z42kPMDWN0ovttZ0ZrpF0Jk4I7N2fC3pho1a1fZ5tGM=;
        b=aLSB95KDZwwzza4Kwns2Rd3UCpUK6Sxw5qoZ6kxt5LhnFhMbwCeKtNfBU6DU6gBhW3
         UrzbFUQJd8w4Ellq0CtWLlXxAV5F28afYqQ2Soqm/k7w7yFr8JZ+g1KQIQF2+uk+sgsg
         UfTRj5HiB1/hwdWUeBWNzfpub9HD0/YYOLP6krpF4EtTb80Wa2NjxCZuO0tVatNxmxIf
         fRZ0hdYxMUEG86yep2ICqe1bIXXuesW7CS9OuSTckEYJyF8BsJT0DNMNsWeyqFdoYMjl
         vvnyR4uyW5+KSHGyh0uL5MOlOhKcdeaJOs45Mqn8RjNKTyv2cy7OhyrmM8DPgnFK0w6k
         K6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z42kPMDWN0ovttZ0ZrpF0Jk4I7N2fC3pho1a1fZ5tGM=;
        b=gmKuhlOoLcCUTgMwP4bR23ZN21DFqXfszZFMnZeFbr1EMZrxDiVPTEOuNW9ZR9x3QA
         zRrZW22P6G82WuSAKXwPvH2xDPmt5Q1By53XhiITB39MHiCwK8UP6xJfhc/1lGIOL23j
         /K5KGlUbmxhNtRWy7j0TLq/gmtUZj/DcjutC5SfjbzOcmYJQ8Uke59gqufnxXmS+QAht
         UrGVPAOdE+uKPqgoYthHPlfxK51ZfOf5mRoErAJ5NRwiFHqBfNiXeORthVh72fciSvuI
         BXvJ6msUGOgzTvRP4d+Go55Z8Su08HfEXNYWkPQye4HBfFZzUxnPmT+XFhanuCiiwerS
         7Dgg==
X-Gm-Message-State: AOAM533m914mDS7JfTXNH62hqDLq1aqLqD3KCZ6gj2ikpjGQe4f/ODm2
        LnWEIjtms89le3V26OplT2Vz6A==
X-Google-Smtp-Source: ABdhPJyi++ZILrNj+ljE69PxHF0IVuNbmfnjb5rnh+ggzLwl33f28YuAiu13waORfPfjNlYBcfDYOw==
X-Received: by 2002:a63:3301:: with SMTP id z1mr2800234pgz.120.1633665594354;
        Thu, 07 Oct 2021 20:59:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:970b:a182:aca1:37a6])
        by smtp.gmail.com with ESMTPSA id u24sm835935pfm.85.2021.10.07.20.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 20:59:53 -0700 (PDT)
Date:   Thu, 7 Oct 2021 20:59:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 5/8] progress.c: stop eagerly fflush(stderr) when not
 a terminal
Message-ID: <YV/CNSdntvm1QetC@google.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-5.8-250e50667c2-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-5.8-250e50667c2-20210920T225701Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:09:26AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> It's the clear intention of the combination of 137a0d0ef56 (Flush
> progress message buffer in display()., 2007-11-19) and
> 85cb8906f0e (progress: no progress in background, 2015-04-13) to call
> fflush(stderr) when we have a stderr in the foreground, but we ended
> up always calling fflush(stderr) seemingly by omission. Let's not.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  progress.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/progress.c b/progress.c
> index 7fcc513717a..1fade5808de 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -91,7 +91,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
>  	}
>  
>  	if (show_update) {
> -		if (is_foreground_fd(fileno(stderr)) || done) {
> +		int stderr_is_foreground_fd = is_foreground_fd(fileno(stderr));
> +		if (stderr_is_foreground_fd || done) {
>  			const char *eol = done ? done : "\r";
>  			size_t clear_len = counters_sb->len < last_count_len ?
>  					last_count_len - counters_sb->len + 1 :
> @@ -115,7 +116,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
>  				fprintf(stderr, "%s: %s%*s", progress->title,
>  					counters_sb->buf, (int) clear_len, eol);
>  			}
> -			fflush(stderr);
> +			if (stderr_is_foreground_fd)
> +				fflush(stderr);

Looks like a straightforward refactor, although I wonder what's the
difference between is_foreground_fd(fileno(stderr)) and isatty() in
practice.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

>  		}
>  		progress_update = 0;
>  	}
> -- 
> 2.33.0.1098.gf02a64c1a2d
> 
