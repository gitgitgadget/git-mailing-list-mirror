Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E94C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C931A65049
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhCIWJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 17:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCIWIl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 17:08:41 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED214C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 14:08:40 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id x78so16751263oix.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 14:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W5O+pv6ULU+RpWwTy+mUIbqDxtMqjK+E0g3A0hwI0aw=;
        b=CY+NgA64lp3dCC4Gy/RtxlEAKXb5beGInZyYbwBjLIMDr+RQa33pJ8WsPVhBd+z65O
         Ny2axnZHebSw3KMSGEuqtCMAOL+9qjV+BbLNvlLoy9hqmwn8ozKYVy2XctrrJZhAnYdM
         L8iP9QGafavphdtBpMYpiJGco9fKW4wywQ4mPumPD+0U5wn+4oyETjQ7QB/sofTXcKLP
         AA+82yuoO7k/0//p02p1C37bqdm6G0I7KuZi5BfsNgMMvarO3w4SvZHI39Lt3V5egpPT
         4J35PvhgBThTFBfl/2AI59Rlkkh57ikLujRyXL0N1u2QsaR/0GgZluqk63HFJgpb6PWd
         TAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W5O+pv6ULU+RpWwTy+mUIbqDxtMqjK+E0g3A0hwI0aw=;
        b=TmATfJRbNCC/jX7/knJbjXzpBu9X6bTkmAFpXWBFL/bky85JdpqyCIcns5sjSLQ8Gd
         nGZt65WwNnchfD9n4lHVauVhY2gWot4b1snmdm5y2RkIoa0eOLE7q10BvN+7CiAs/6HV
         cRMT+XxKXXVZmzJS8HApDlh7res1Nr3qo+3LOM2dpCFqbJRUWqST3ERehRy0eFeHFKsk
         Qyc4GZC1gC3Thlk9cgv7ujIwNiV+873XOpB2rIBtO6w3Ktgum5daKpNwAUkdcrhX5qBj
         z9UFKD5hLzgNVTw70ajn/ChpxyEFYxSK1FHuK7b4uKcoZ5xCKqLpa970SE9VtNvoZWkp
         85CQ==
X-Gm-Message-State: AOAM532B+H6GnUfSP35sedfFExYl8yS6Bpi7kb4MpMx5TPDWRBssn9eO
        dTV4ZyH6SmLnckoOKuT0+HM=
X-Google-Smtp-Source: ABdhPJxOX2CqpO3U3Rj7C8g6s+L6yBDqrBrfYwzOAMPWQsaN3BgnlcXORMeU5RreBKps2MGbnDx0Rw==
X-Received: by 2002:aca:57c5:: with SMTP id l188mr194848oib.159.1615327718750;
        Tue, 09 Mar 2021 14:08:38 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id i20sm3758422otf.17.2021.03.09.14.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 14:08:38 -0800 (PST)
Subject: Re: [PATCH v2 0/8] Optimization batch 9: avoid detecting irrelevant
 renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
 <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9fce692f-86f9-59c1-07de-1eaabdbcb827@gmail.com>
Date:   Tue, 9 Mar 2021 17:08:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2021 7:09 PM, Elijah Newren via GitGitGadget wrote:> The basic idea here is:
> 
> We only need expensive rename detection on the subset of files changed on
> both sides of history (for the most part).
> 
> This is because:
> 
>  1. The primary reason for rename detection in merges is enabling three-way
>     content merges
>  2. The purpose of three-way content merges is reconciling changes when
> 
> both sides of history modified some file 3. If a file was only modified by
> the side that renamed the file, then detecting the rename is irrelevant;
> we'll get the same answer without knowing about the rename. 4. (Well...there
> are rare cases where we need the rename for reasons other than three-way
> content merges. Patch 5 explains those.)

Makes sense. Don't compute information you won't need. I look forward to
trying to figure out the special cases here.
 
>                      Before Series           After Series
> no-renames:       12.596 s ±  0.061 s     5.680 s ±  0.096 s
> mega-renames:    130.465 s ±  0.259 s    13.812 s ±  0.162 s
> just-one-mega:     3.958 s ±  0.010 s   506.0  ms ±  3.9  ms

These are _very_ impressive numbers for such a "simple" idea.
 
> However, interestingly, if we had ignored the basename-guided rename
> detection optimizations[2][3], then this optimization series would have
> improved the performance as follows:
> 
>                Before Basename Series   After Just This Series
> no-renames:      13.815 s ±  0.062 s      5.728 s ±  0.104 s
> mega-renames:  1799.937 s ±  0.493 s     18.213 s ±  0.139 s
> just-one-mega    51.289 s ±  0.019 s    891.9  ms ±  7.0  ms

And here it is even more impressive. I see that your optimizations are
having combined effects but also are doing valuable things on their
own.

> We get best results by prioritizing them as follows:
> 
>  1. exact rename detection
>  2. skip-because-unnecessary
>  3. basename-guided rename detection

This makes sense to me, since even the basename-guided rename is
doing some non-trivial work. It would be good to reduce that
effort.

> it means that our remaining optimization potential is
> somewhat limited, and subsequent optimization series will have to fight for
> much smaller gains.

This is a good place to end up. Let the code rest for a bit after
we are done here, and maybe we'll find new cases to care about
later. We could chase the long tail forever, but these steps are
a huge accomplishment!

Getting to reading now.

-Stolee
