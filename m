Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2892C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 12:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA36D6195B
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 12:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhC3MHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 08:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhC3MHD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 08:07:03 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D3C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 05:07:02 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id c3so6811968qvz.7
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WYg4owy9leD1PtAdeljwWQX5R89IF0ELQLt9Knes6Ng=;
        b=iJH78XgJQ0bqoFGqNi+gQ0YEWg7fNVJWtx4xXK0TxqEOJunsRx7OVqzYP57xCL11hR
         5VBo5VCwxjl1mozajhjOHWVPLyoy6GgACd0+rztXZ9U+GN7qdEaojGPV10Qrhg6Kc3Eg
         jRbLqZeua2XchUMB6SfvnG0p5pmCpYzCnWh49ptJXyGJ56U+eY7bMw8K23FPICeL59Fc
         sm21xWhbPHvM2m/q1UzwNJIgCNgu9lIzQaohy63X2Xr2pBQmAXcBo+kxojcQezETIP5K
         kjDj65yHOWXEZiIYtS3cpVN+mGXom4u6wIlmhsqpw2msBYnGzJ+llQVKUl+Wk03if1vF
         aoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WYg4owy9leD1PtAdeljwWQX5R89IF0ELQLt9Knes6Ng=;
        b=aadhEeoFsEiN8px6pEVxWs1ixoYobT//8Xn//Y2Mt5vyTY+J9XNsVkZnvkptHEN3au
         Tf9Rlaeh9G19NWgg1hPj5TZsV+HWIhdf7WJaANwE/o6pNzrP/oCNJy/Rp2GOG/7y9y1k
         Jt5aYj32K+yv29owiy/dZrzqf0Yf2PTgJhpPjZsHlYf1TdsM1Y6Kr69ccidrWAb+bvHi
         N++4FaMNd5ayO2BWnYh3CHwEqRW05Fr38joaY6Q8tSHBe+Qd1SEa5OWi3KczaadFi9gI
         FQQcGrpmDvcRVNf6g5RnqohhNJN8UJVljTMMc128SEgDuCz5sbMZyOtoLSGbTQELPjGe
         Iuvg==
X-Gm-Message-State: AOAM532D7oMW7rDcUtRUR8PRkUyVQC0izSPBf3Uykw5kSSsL6CCDM957
        ZgL2V6LMJtFNEZoTCwIp2gA=
X-Google-Smtp-Source: ABdhPJwnpc5ih46a2lACnPTE6273SI2f4zeF5/xCM/5BtHWeuBUZACCa3OPsbMxAHJQxona4TBYP1A==
X-Received: by 2002:a0c:e148:: with SMTP id c8mr29656349qvl.56.1617106022047;
        Tue, 30 Mar 2021 05:07:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id n2sm12440198qta.61.2021.03.30.05.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 05:07:01 -0700 (PDT)
Subject: Re: [PATCH 0/7] Optimization batch 11: avoid repeatedly detecting
 same renames
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <xmqqv99gw6n3.fsf@gitster.g>
 <CABPp-BGMhyn1ricXzx539n-09+BYRHPeruNd4MG2PyQzWaRKow@mail.gmail.com>
 <xmqqzgyrukic.fsf@gitster.g>
 <CABPp-BGrevGj+xrm9bVcX5bp_WRv9cYP+g0hrAtjZK0u=sTHzQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6ef0eb33-05c8-6793-b53f-9bd60a20f9f3@gmail.com>
Date:   Tue, 30 Mar 2021 08:07:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGrevGj+xrm9bVcX5bp_WRv9cYP+g0hrAtjZK0u=sTHzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/29/2021 6:34 PM, Elijah Newren wrote:...
> After sending the initial series, I decided to type up a more thorough
> document that
>   * spelled out in more detail how the sequence of cherry-picks work
>   * proved why the renames in one pick are always a superset of the
> renames in the next
>   * proved why the renames in one pick are _almost_ always also a
> rename in the next
>   * discussed the counterexample cases in more detail, and why the
> optimization is still reasonable
> I figured the more extended document would be useful in case people
> decide to change how things work in the future (e.g. what if someone
> wants to turn on break detection?), and wants to be able to check
> whether all the conditions and cases still hold.
> 
> I then also added details about how things work with directory
> renames, in the case that merge.directoryRenames is not the default of
> "conflict" (which is trivially handled by stopping and dropping the
> cache) but is set to true...and found a case that needed more care due
> to interactions with some of the earlier optimizations.  (The earlier
> optimizations could result in bypassing directory rename detection in
> one merge because there was no file added to the old directory, but
> the no-directory-rename would be cached for subsequent rebases.)
> 
> So I need to get that fixed up and resubmit this series.

I look forward to that document. I attempted reading this series
yesterday, but did not have the mental energy to convince myself
of the correctness (because of things like not knowing this logic
that you plan to document). Instead, I'll promise to give round 2
a quicker response.

Thanks,
-Stolee
