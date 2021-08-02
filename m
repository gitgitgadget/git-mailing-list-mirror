Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F23BC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4EC610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhHBPF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhHBPF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 11:05:58 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD4C061760
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 08:05:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t66so16890180qkb.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T9aYMifCPbJKMBcVPNRErmkSmx9O06Qpc23dqLmPVjs=;
        b=jMIipOP9jC7A4KURYA5f05Xtg1Jj0MvmlkCzdyQ7TaeeYb67FAXhkV4TKLgjL7sPPJ
         7N43etksIW1f1HgH3Z+ryj3skO2YZZ8LEBfSUvvzO4nAVHkvyP3aYSaUoNQhnuF6kwjP
         Y8KWTUbuXayKDbDMGW8KGE/NXHaGHgbo6KcZAj1o6fBLoSD+M/DBv7XQLmTOzJcR0Xrk
         L6W+rANZxjgprdtdETKeVZ+bJB31os5feugvRzhkBE8NHS4Zin5SktdKod6VJa4/9JDF
         NNl5IP/R3M0v8YzaxKxQJclm8FvuM0UXpnaCgD6JZc5SVDPV8+12GPfLndcYsi5DnvxS
         jO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T9aYMifCPbJKMBcVPNRErmkSmx9O06Qpc23dqLmPVjs=;
        b=pEIZdBbDJCcGiZwvlz0MHmCSnCKrw27wf+krv8nIAUX51xtQvjwSO6l/6zc54Mq03n
         WyKToTGym4dQi4kVH3E4fSAXCXzfxSQ86CJ/eph1qGX18P7XlzahJukr6fE58MQp4LJl
         H/VD9vwGoY/hmi/l0W2PjRS+pBgtukBwzEmbSsHthLfU3bz+ztiZVFdPIFLom+XskM30
         ytlM/UKtoBIo95OoUEZXJxZtoEBXsIALXPsmlJvu0KPcF8FSoUVpaOxsCs9vo84kaepE
         RqPy4iznTBvcC4dADwAtbOQXaAIO/3Gkkt8PNKnbxwm7GXtQBG+FyEbA6tLI8K50+jyT
         fb4g==
X-Gm-Message-State: AOAM531zH168Cc61Q/Ze91APFCx8pnL1uBeRDyL3+zipaQcbNd6QdvVt
        D4HFeuADQ4tc00kkuLX9ZJc=
X-Google-Smtp-Source: ABdhPJwuUZd14D8GzOPfavpaQWH8oM8TJ6i8jO/BXos2ps5jT5kWRKGbLe66O5J17XIg1oGRD+6wIA==
X-Received: by 2002:ae9:e40a:: with SMTP id q10mr10618443qkc.172.1627916747501;
        Mon, 02 Aug 2021 08:05:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc? ([2600:1700:e72:80a0:34d1:2d41:f9b7:ccbc])
        by smtp.gmail.com with ESMTPSA id l25sm1239650qtv.69.2021.08.02.08.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:05:46 -0700 (PDT)
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to
 ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ec1bb449-347a-924d-7462-3cef6facc0e9@gmail.com>
Date:   Mon, 2 Aug 2021 11:05:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/31/2021 8:07 PM, Elijah Newren via GitGitGadget wrote:
> This is an RFC series designed to spur feedback about switching the default
> merge backend (reviewing the patches is of secondary importance at this
> point). Some questions:
> 
>  * Are there things others want before this series is considered for
>    inclusion?
>  * What kind of timeline do others think is reasonable?
>  * Would it be beneficial to let this series sit in 'next' for an extended
>    duration to gain more feedback?
> 
> Some potentially useful context in relation to the above:
> 
>  * I've personally used the ort backend for well over a year
>  * I have ~50 testers using ort as the default merge backend since Nov.
>    2020.
>  * ort fixes known bugs in recursive, and there are no known regressions
>    (more testers may change that)
>  * ort is significantly faster than recursive
>  * ort provides one new feature already, and enables more that are on the
>    way
>  * The commit message of patch 1 has more details about the last three items
>    above
> 
> So...thoughts?

I fully endorse this change as soon as possible. I've applied the patches
you supplied here and submitted a PR to microsoft/git [1] to take them.

[1] https://github.com/microsoft/git/pull/404

I've done my own share of testing on some of our private monorepos to see
how ORT compares to the recursive algorithm. My data is not perhaps as
rigorous as yours, but I did notice that the ORT algorithm was consistently
within the 5-6 second range while the recursive algorithm would vary within
the 7-20 second range (and some outliers near 30s).

Of course, I'm particularly excited about the benefits to the sparse index
work. I also have a prototype of a 'git merge' integration with sparse
index which was not very hard because the ORT strategy does not use the
index as a data structure. With that change, my tests dropped to between
0.5s and 1.5 seconds. (This shows just how much my earlier timings were
stuck on index reads and writes.) Now, the largest indicator of time is
how long it takes to resolve text conflicts.

Thanks! What a monumental effort.

-Stolee
