Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EBAC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE8264F72
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBCBJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 20:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBCBJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 20:09:27 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4903C06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 17:08:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l18so3557871pji.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 17:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lhZtmYQLcb5NtpxZrbqVXEvpykmqw1mh4x05aWeD9/c=;
        b=F2EKpIXTj8s1ZuLYkGtV+HFDhiFepZWgDtdQCqY0A+IUua6IM6emkoJdrE5Dp7BURu
         90JJY6qhYTtyLBo/BIS6/mKwEDDYAF9HpWp2GacRkaU2f6kDydDstNl/MCjvVpjiZ81f
         TGZznlcjpVcWeNkOWPmDzko/PZtdtSqFAHoL1+4eZESFcxGSIzA5Ju+AleLtGr/wcY2+
         rnvOcjIMqOAYxbya3CVALjGrKsWnvHTLNrOzmp5eJNqhU4/IeshEspwVtf2v0y7TYZeS
         QJr5/lTtlz6qNmOfF4eLaWckzHILFLiiHeHO1nwFvlOrGKXCzYnuq2PvNVu114O7/zV1
         vS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lhZtmYQLcb5NtpxZrbqVXEvpykmqw1mh4x05aWeD9/c=;
        b=q77Aj/beATSV2ACgWpQlHCPs+r5PWgRfP/V3p0oUDc+z5SDuqUNVcu/4gefLqQGjIo
         rmQE0jEQyNP9SycaW9rw2LDN82yqQqHn3zIvJbSAvIf2zGEF6Pzu3BCa+mT7umxuKx6R
         Kigvg9+LapI3asEc5xu40k7RpMahLfOUQLDVz4V6cVnTA0ryssqG2Grv5ymNk6NNaj0W
         82lP/MB5zTeZ8GfTvjHdX6G3KSeUUVP1qW2S3xt2h+o8ckvaCYpm1WGQGwLeB0GjAtSs
         lbDaIYBYPVvqcQs1YP0FlwT2K6Qgvq9RErBlAmVxJevD/G1vMnt8HE9RLzJz9ZKYepZQ
         QOtw==
X-Gm-Message-State: AOAM533OUG2gls+GR2ETTtaE5uqRz2XZIrhr0Ez8QKIKMvyvydS0WGY0
        Po4xSvZE4NRRGbMqsCxj+od/wV4+6sM=
X-Google-Smtp-Source: ABdhPJyfzPWY0RQ7UyOlsvoKND0TMyH3lGgXbNkvJ27ootEo6tS1W3BihwIVnyDJWkf9arOmDvIuow==
X-Received: by 2002:a17:902:ee4b:b029:de:9cd1:35c8 with SMTP id 11-20020a170902ee4bb02900de9cd135c8mr678565plo.18.1612314527155;
        Tue, 02 Feb 2021 17:08:47 -0800 (PST)
Received: from localhost ([2402:800:63a8:88aa:1e51:365c:3671:d92a])
        by smtp.gmail.com with ESMTPSA id o14sm187114pjf.12.2021.02.02.17.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 17:08:46 -0800 (PST)
Date:   Wed, 3 Feb 2021 08:08:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
Message-ID: <YBn3ndkwo9qvXHFr@danh.dev>
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsg6infev.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-30 16:00:56-0800, Junio C Hamano <gitster@pobox.com> wrote:
> * mr/bisect-in-c-4 (2021-01-26) 7 commits
>  - bisect--helper: retire `--check-and-set-terms` subcommand
>  - bisect--helper: reimplement `bisect_skip` shell function in C
>  - bisect--helper: retire `--bisect-auto-next` subcommand
>  - bisect--helper: use `res` instead of return in BISECT_RESET case option
>  - bisect--helper: retire `--bisect-write` subcommand
>  - bisect--helper: reimplement `bisect_replay` shell function in C
>  - bisect--helper: reimplement `bisect_log` shell function in C
> 
>  Piecemeal of rewrite of "git bisect" in C continues.
> 
>  Will merge to 'next'.

I think the bisect_log still haven't added back the:

	We are not bisecting

as addressing in gohp6kv9bml9qc.fsf@gmail.com

-- 
Danh
