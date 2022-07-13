Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EDCC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 09:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbiGMJJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiGMJJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 05:09:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB733D9E0A
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 02:09:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z12so14567155wrq.7
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vGHVWlgiBMJMElaoEUbPX6AMAXMyyl/vNP8Im1iwHsA=;
        b=qmyDod6sgKECCNsYDPm84y7qd51NE03SVUfSfVnvkmnzaPEDAH5TKdgmxaQucC8rm2
         vwZSBngVVpBaRZpvIaV9/WPr0RmpQ8VoIYjx5lCfH1F+zguhn7EL/Pe3rJpe8kVVTq3Y
         n1huuSNThceV6viZepYTV1kBP+Xmof8uRtVVrCuQT0frAYJvKMKgnxTjHW2rvS4k3bXc
         ZsF5agxVVTrunO+C9dzSD1NzUDIlyQnpqk8mndjWUqppufnC7X4QF4oSxN0k466rny7t
         /u/F4rkirrmOaLYXvAZ4XgBLsxsUa13KnqnEvp6w6T1wb89bCXhHIk9hTXL61/ijORfr
         y/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vGHVWlgiBMJMElaoEUbPX6AMAXMyyl/vNP8Im1iwHsA=;
        b=to+S4uhimJM+qkLW2FcST7af4KRASAZKXpS/vpwce3VWc0rVIisRE5eeCl7Wfhw+9x
         KGJmQnFmwvh37H97d+TbFVgmtduKIjuccizfmX4r5ZoYZ75IjGvy6hLizViCbYsLsYUg
         llmM6rr/qcZiWwcPy4YZaXHAqqP1EY/77wdd7eK0ewkW1250wJ4WELVj02P1VVjQjlAt
         bmWC2so2lroX88Iii66q3PLrs6j6q2ZOiajAQ+WJ199IdoQGL5Lqmlx3ZQ2VowMOh4v1
         XEF8UwqCvTKRX93dCtYgXGtIyw0Ja7nyS9nq6UH2+/+u8Sxj82KSNXvkKJuqMOvIrb2C
         Qzcw==
X-Gm-Message-State: AJIora8LyrEcSzUaEbpLz1MC4gZKJI1KfruXC4x3qqbREf6rmHEVjpRv
        n4dtjfE9Ds32yoYUE56Pcq8=
X-Google-Smtp-Source: AGRyM1t+/9eJQ+EX+FPxSUOMIIiGnXCbg2qhsOx2gPhR8aEluQgyynrEPZZTh1Yg8hKXsra39fZNbA==
X-Received: by 2002:a05:6000:1a89:b0:21d:ab1a:b19b with SMTP id f9-20020a0560001a8900b0021dab1ab19bmr2259059wry.78.1657703378834;
        Wed, 13 Jul 2022 02:09:38 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c068600b0039c96b97359sm1407792wmn.37.2022.07.13.02.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:09:38 -0700 (PDT)
Message-ID: <e86cac3b-4e05-be20-41d8-ed5006463556@gmail.com>
Date:   Wed, 13 Jul 2022 10:09:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/7] xdiff: use GALLOC_GROW(), not XDL_ALLOC_GROW()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-5.7-3665576576f-20220708T140354Z-avarab@gmail.com>
 <c2bc5c79-e71b-f9dc-ba97-261d3454e150@gmail.com>
 <220711.861qur9ays.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220711.861qur9ays.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 11/07/2022 11:48, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jul 11 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 08/07/2022 15:20, Ævar Arnfjörð Bjarmason wrote:
>>> Replace the recently introduced XDL_ALLOC_GROW() with invocations of
>>> the GALLOC_GROW() from git-shared-util.h.
>>> As this change shows the macro + function indirection of
>>> XDL_ALLOC_GROW() is something we needed only because the two callsites
>>> we used it in wanted to use it as an expression, and we thus had to
>>> pass the "sizeof" down.
>>> Let's just check the value afterwards instead, which allows us to
>>> use
>>> the shared macro, we can also remove xdl_reallo(), this was its last
>>> user.
>>
>> I don't think this expression->statement change is an
>> improvement.
> 
> I think the use-as-statement is prettier too, but I think the uglyness
> of having to pass down the sizeof() & re-implementing the macro version
> of the alloc-or-die variant outweights that.

I think this is partly a choice between prioritizing ease of 
implementation or ease of use for callers.

>> This change also removes the overflow checks that are
>> present in XDL_ALLOC_GROW()[...]
> 
> We end up calling st_mult(), which does that overflow check. Do you mean
> that the POC shimmy layer I showed in another reply for libgit2 doesn't
> have an st_mult() that detects overflows?

I was referring to

#define alloc_nr(x) (((x)+16)*3/2)

in cache.h. XDL_ALLOC_GROW() detects overflows when growing the number 
of items as well as when calculating the number of bytes to allocate.

> That's true, but as noted downthread of that we can & could ship that as
> part of the shimmy layer, but that's unrelated to this change.
> 
> In your pre-image you use LONG_MAX instead of UINTMAX_MAX & I don't see
> (but maybe I haven't looked at it carefully enough) how it does the same
> dying on overflows. Doesn't it just fall back to LONG_MAX?

It does not die on overflow as we want to return errors rather than die 
in the xdiff code. It uses long to match the existing code.

> Part of this is that it's not clear to me from your commit(s) why you
> need to rewrite alloc_nr() and rewrite (or drop?) st_mult().

So that we don't die on overflow and so that the xdiff code is self 
contained.

I'm a bit disappointed that this patch seems to have been written 
without really taking the time to understand exactly what the code it is 
replacing is doing.

Best Wishes

Phillip

>> and fails to free the old allocation when
>> realloc() fails. It is not a like for like replacement.
> 
> Yes, we should have a free() there. Wel spotted. But again, doing that
> as part of the "gently" branch seems preferrable to have duplicate
> versions for expression (non-fatal) v.s. statement (fatal) variants.
