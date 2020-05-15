Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89308C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7DD207F9
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Phm2IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOQtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 12:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEOQtu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 12:49:50 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CFC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 09:49:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 190so3250413qki.1
        for <git@vger.kernel.org>; Fri, 15 May 2020 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nhkH46bHdOEVoGL0upCK7fcG+gLIE3T2r9mdg3wBgeI=;
        b=H7Phm2INadaN3/vx5yWI16zU/AWa3F4bMSR9mXnEZLhwzqgO+8LPMQeRPh53w+Ts8O
         AGEbhqgnkC0BVAuWN8GW438gBycdx/hXufR1faox2d1WLcwkH3icaO3pCk2qh5eT5XO9
         C5Zoodtzgp9VQbmuRMseBNX9P8P1N9Nv60A1Grf5+jB31CXqzDY3jdPojC6bAZGHwW4+
         scb05q2wlmf0e5nsyiLm+GVrTIwrMLect1ICR39tEZkgLxagYlt+H4DYfcp0JVuhRFGL
         h0P+zbxzcmgs6LgToQ3Izi3NwrXSiBZH26p8GRkzJLcjXblOVxsBfUac9xWMJVrodQpZ
         zmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nhkH46bHdOEVoGL0upCK7fcG+gLIE3T2r9mdg3wBgeI=;
        b=JYsdFXP3EyW27HpsL5k5Orv57Sj4UAy7O8FKVgMNHgEDYbILUQ+bD/w4+paKkeIcAm
         Ho2mu/+/bD9qbQocOts0iZQDXQ1DXaIpA9MAeGupODpYgvxfW3vpH9T3R1izJ1C87Q6K
         PMG4YAnvT4B9seaRlwvLs2WmEamRGzo8AxYFVwl287terL85PIIcFGD7zXr1FK4aom7k
         BzxSf5M7Fgv8ve0emZHaQx1QkUZeDEDKf9RU7kVG4FuX625BZ+jLJ4eVC6YZByzFulnq
         5y90qSTlr8GZO5QJ2B8jHeTdcoB04IgT/UxOCCDlUh40nMZsV3r/5T1VqDHaCSSrChoE
         iy4w==
X-Gm-Message-State: AOAM5321aghfuenImwnv+aHH/ttu5skTniny9B+wC2Fa7HXML/+DwI3o
        /EiRgq+1B8OBkWvXm+ts3O0=
X-Google-Smtp-Source: ABdhPJzm5Kyl9/f/LmWHykHXP3s3bJsoLLIBAZ3GYSYWMVyE/kKj9u+zokBtbMTn+ayNPrXf8iunuQ==
X-Received: by 2002:a05:620a:142:: with SMTP id e2mr4326891qkn.331.1589561389167;
        Fri, 15 May 2020 09:49:49 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w67sm74165qkb.102.2020.05.15.09.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 09:49:48 -0700 (PDT)
Subject: Re: [PATCH] trace2: log progress time and throughput
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
References: <20200512214420.36329-1-emilyshaffer@google.com>
 <8f159f13-ed61-61ea-8e9a-c1ffbc5fddb3@gmail.com>
 <xmqqzha9md5d.fsf@gitster.c.googlers.com>
 <xmqqtv0hmb7r.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e7b0eaf-3deb-31e4-6927-45429c6deed4@gmail.com>
Date:   Fri, 15 May 2020 12:49:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <xmqqtv0hmb7r.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2020 12:09 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Derrick Stolee <stolee@gmail.com> writes:
>> ...
>>> This trace2_region_leave() needs to be conditional on the progress
>>> being non-null. The pattern used by consumers of the progress API is:
>>>
>>> 	if (my_progress_condition)
>>> 		start_progress(&progress);
>>>
>>> 	do {
>>> 		display_progress(&progress, count);
>>> 	} while (condition);
>>>
>>> 	stop_progress(&progress);
>>>
>>> The condition to show progress or not is conditional on an option that
>>> is external to the progress API.
>>>
>>> The fix for this patch is simple: make the trace2_region_leave() be
>>> conditional on "p_progress && *p_progress".
> 
> Oops.  That means that we need to apply the fix before -rc1 to
> 'master' X-<.

Sorry I didn't catch this in time for rc0!

> Something like this?

The patch below is exactly what I would have recommended. It looks like
I wrote it, too! ;)

> -- >8 --
> Subject: progress: call trace2_region_leave() only after calling _enter()
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> A user of progress API calls start_progress() conditionally and
> depends on the display_progress() and stop_progress() functions to
> become no-op when start_progress() hasn't been called.
> 
> As we added a call to trace2_region_enter() to start_progress(), the
> calls to other trace2 API calls from the progress API functions must
> make sure that these trace2 calls are skipped when start_progress()
> hasn't been called on the progress struct.  Specifically, do not
> call trace2_region_leave() from stop_progress() when we haven't
> called start_progress(), which would have called the matching
> trace2_region_enter().
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  progress.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/progress.c b/progress.c
> index 6d2dcff0b6..3eda914518 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -329,13 +329,9 @@ void stop_progress(struct progress **p_progress)
>  			trace2_data_intmax("progress", the_repository,
>  					   "total_bytes",
>  					   (*p_progress)->throughput->curr_total);
> -	}
>  
> -	trace2_region_leave("progress",
> -			    p_progress && *p_progress
> -				? (*p_progress)->title
> -				: NULL,
> -			    the_repository);
> +		trace2_region_leave("progress", (*p_progress)->title, the_repository);
> +	}
>  
>  	stop_progress_msg(p_progress, _("done"));
>  }

Thanks,
-Stolee

