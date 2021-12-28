Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2ACC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhL1QNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhL1QNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:13:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE2C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:13:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o30so9400325wms.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bNXNqpaPcY+ksjdok5JUfQ3Qmo5U79yUszGCOrkgzkw=;
        b=HcG8+gf6IoHgfOt6UnJXF5chKNu1Xy8Kffw4LhcmO+5oMc/MITDRIehjTjtw1C7I6L
         fqkyMwZXcwBQlMhIacxGRlHHwdTGZGwmlij3nrm6carjqs8TQF0vmcnLxBMD6A/C+VRV
         WJ1CA92QXKzoqUz86oD3OMv26nfU0oajt31i90g9M+1tfTsqrja8SmxvIGMTbXYb1QKk
         wpiLSgzeEyVByunnFkAVH8Yz+tL2NAHv/VGCBhOqXFlvcM/gyYpb62EBwA1Yju/YVfn1
         ZgsKkdXteYJ1Pze2jvGJeoDqebWrUJPbPA3Ned2TqFemddWoTJsrN8u7TjOXPwALikyQ
         heQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bNXNqpaPcY+ksjdok5JUfQ3Qmo5U79yUszGCOrkgzkw=;
        b=lhSgXd6WHJOT0qYDfojmdBzgrbSt9BRN2KFmj9vmyFAZVqvSOWCFK/plLMQDRlULb2
         va5qzJgVyFGRyfJJBsu8LORw8viV98ItsAf0ZXh4B70CVROSiLKxjBCIkATKcGHw/4Js
         G6KmZzhXN6Yfqhn0vwByI/MXGGcKc3dwtuVELcuHJswaL46C/5ZEL/7407GQcme8r8z1
         Wtvv7+z+2h5zOSXjmY/2OUdWr+dqO0XDgzlYCtoSVVq8F+NBF163Cm5kqiZygpM5DF2B
         qmCs66JA6QoAbHE+go7eqDRuvkrfGgJkhe3rrX5TEoxGfrS2XY4Exq6YRewkkaCVhgAO
         Uu7Q==
X-Gm-Message-State: AOAM533vjcVfxBJJ5q9V3EUNJKRbumw5dqYYvJoHISYijvIA0dtpSl8T
        4sGtAelAu1M/348Ybj+Pqy4=
X-Google-Smtp-Source: ABdhPJw1kAVj1x/PM9+7mC1JcOdEQiXQ/6dFvvLuVU0m4AwrkKSJk8kClpD8JnC0Ri4gB1bRTXX0rg==
X-Received: by 2002:a05:600c:8a7:: with SMTP id l39mr18397424wmp.138.1640708032713;
        Tue, 28 Dec 2021 08:13:52 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id q8sm18400472wrx.59.2021.12.28.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:13:52 -0800 (PST)
Date:   Tue, 28 Dec 2021 17:13:50 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v8 5/7] progress.c: add temporary variable from progress
 struct
Message-ID: <20211228161350.mzsubl3vensst2hu@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
 <patch-v8-5.7-72a31bd7191-20211228T150728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v8-5.7-72a31bd7191-20211228T150728Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 04:19:01PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Since 98a13647408 (trace2: log progress time and throughput,
> 2020-05-12) stop_progress() dereferences a "struct progress **"
> parameter in several places. Extract a dereferenced variable (like in
> stop_progress_msg()) to reduce clutter and make it clearer who needs

The "(like in stop_progress_msg())" can probably go because you explain the
added consistency in the next paragraph.

> to write to this parameter.
> 
> Now instead of using "*p_progress" several times in stop_progress() we
> check it once for NULL and then use a dereferenced "progress" variable
> thereafter. This continues the same pattern used in the above
> stop_progress() function, see ac900fddb7f (progress: don't dereference

"above stop_progress" should be "below stop_progress_msg",
because stop_progress is the one you're modifying?

> before checking for NULL, 2020-08-10).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  progress.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/progress.c b/progress.c
> index 680c6a8bf93..688749648be 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -319,21 +319,23 @@ static void finish_if_sparse(struct progress *progress)
>  
>  void stop_progress(struct progress **p_progress)
>  {
> +	struct progress *progress;

nit: in stop_progress_msg we have a blank line here, the inconsistency is
mildly surprising

>  	if (!p_progress)
>  		BUG("don't provide NULL to stop_progress");
> +	progress = *p_progress;
>  
> -	finish_if_sparse(*p_progress);
> +	finish_if_sparse(progress);
>  
> -	if (*p_progress) {
> +	if (progress) {
>  		trace2_data_intmax("progress", the_repository, "total_objects",
> -				   (*p_progress)->total);
> +				   progress->total);
>  
> -		if ((*p_progress)->throughput)
> +		if (progress->throughput)
>  			trace2_data_intmax("progress", the_repository,
>  					   "total_bytes",
> -					   (*p_progress)->throughput->curr_total);
> +					   progress->throughput->curr_total);
>  
> -		trace2_region_leave("progress", (*p_progress)->title, the_repository);
> +		trace2_region_leave("progress", progress->title, the_repository);
>  	}
>  
>  	stop_progress_msg(p_progress, _("done"));
> -- 
> 2.34.1.1257.g2af47340c7b
> 
