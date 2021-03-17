Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A0C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71CD64E28
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhCQUfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCQUeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:34:50 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C05C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:34:50 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u198so335784oia.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PtRnq26XKq9a0SMZA9QQgxdbhAmGkDRFWQbe1RsurjE=;
        b=gZzAx9UpVq0Vc4oT67WhlODi8t1GAufbFjyl9CpQkJhGcVzWa34D25+Kiyjk/I4LhU
         gkyaarAUplDhZwdcIAS/VeuDHkCaoZ0QQCXgYuCbHucEzN/a9CluONtQfUJcK2YwGaUz
         Ohm387HAs1dNOyvTCaLrV+2Ow89cXzILk0ki60zeeSByZhgBLGw/Fj2aN2gy68yLk+uW
         KuVK0i8ShEhyUVVvGQCquPKMyJf2AAfq+ubUfgx/hbhswuxDkZf1dAiXSVDvEPp0Qzbf
         tZwcucaC2775YjYXZ2nIQZV3w1oAW72Lq90s0if5t4AU23xrlAJUDb2r40WK/i6P99pn
         1QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PtRnq26XKq9a0SMZA9QQgxdbhAmGkDRFWQbe1RsurjE=;
        b=oU6IE/vztVyKXvA8eGEfVoAv47Se6xIrLabgHhGz13MQNzsiauJ6FfQIClHtEM4PeW
         wpY+ZTlbgNEuwvG+52vhaUJjn9VyB2qtkGeemge9dxZSYObvN+iXFJ+qIXvgCejEtF8r
         zLKtC0OUOUspoktrUfv1FqcvAHj7dwYmt3XKcLpvlzNfqmDRsFWROVupZ0rTKu+xi/LE
         fGbOwkXNc33uSLvfnYddiVxbELW8vNiDg7aeoXuPbE70H76mYFqymIPJRAinU/XNiadz
         W5bHNGAQnj1EOQ0GI2+NaaZ/dP6OgF+nba0OBBWeFYnFHiuPC8xtbgyMxSWAgGGn+7P1
         hNUQ==
X-Gm-Message-State: AOAM5337bvfCAe9Ff8wDPjYZlUCq4HlDnPTCudf9I/xho/PirfMJLSid
        6NjJaU+HT5P2aNJcZSdFkIk=
X-Google-Smtp-Source: ABdhPJz7GU33615X21Dm0l32zPPCz84c+aU0yqAInivBneiYfrKj8g5WcBuy2SIM9q3AHhnoyUpWOw==
X-Received: by 2002:aca:3f87:: with SMTP id m129mr503183oia.82.1616013289684;
        Wed, 17 Mar 2021 13:34:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id 53sm8702970oti.77.2021.03.17.13.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:34:49 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/5] Re: [PATCH v3 07/20] test-read-cache: print cache
 entries with --table
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-1-avarab@gmail.com>
 <CABPp-BGS7BxbxiPvk7zoO1XdbZSkpyrfYLuyiNnR+d6orPn+rw@mail.gmail.com>
 <d93300ad-9a3b-6de4-c497-acd56eff30dc@gmail.com>
 <CABPp-BHh_QgF8xej8=xUJh+mYfKTB_d-7Su+xwcfRyaHEPz1mA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c799406-7369-336e-bbec-0d852ad19f3d@gmail.com>
Date:   Wed, 17 Mar 2021 16:34:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHh_QgF8xej8=xUJh+mYfKTB_d-7Su+xwcfRyaHEPz1mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 4:26 PM, Elijah Newren wrote:
> On Wed, Mar 17, 2021 at 12:46 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/17/2021 2:28 PM, Elijah Newren wrote:
>>> On Wed, Mar 17, 2021 at 6:28 AM Ævar Arnfjörð Bjarmason
>>> <avarab@gmail.com> wrote:
>>>>
>>>>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>>>>
>>>> So we have a test tool that's mostly ls-files but mocks the output
>>>> ls-tree would emit, won't these tests eventually care about what stage
>>>> things are in?
>>>>
>>>> What follows is an RFC series on top that's the result of me wondering
>>>> why if we're adding new index constructs we aren't updating our
>>>> plumbing to emit that data, can we just add this to ls-files and drop
>>>> this test helper?
>>>>
>>>> Turns out: Yes we can.
>>>
>>> I like the idea of having ls-files be usable to show the entries that
>>> are in the index; that seems great to me.  I very much dislike the
>>> --sparse flag to ls-files, as noted on that commit.
>>
>> I don't like this idea. I don't think exposing internal structures
>> like this is something we want to do so quickly.
> 
> Not sure I follow; ls-files was already about exposing three bits of
> internal structures for index entries: mode, hash, and stage number.
> These are quantities that are well-defined for sparse directories too.
> It would not be exposing any new or different internal structures, nor
> changing the output format.  (Ævar changed the tests to not look for
> "tree" but to look for the "040000" mode number.)

True, that is some internal information already.

>>  Further, I intend
>> to use this test tool in the future to _also_ show the stored stat()
>> data, which would be inappropriate here in ls-files.
>>
>> I would prefer to continue using the test helper here and leave
>> functional changes to ls-files be considered independently.
> 
> Well, I was okay with it being in a test helper regardless of whether
> it could be done with ls-files, and then just circling back and fixing
> up ls-files later.  But perhaps it's worth calling out in the commit
> message about your plans to add stat() data and how that future piece
> can't be done in ls-files (without functional changes of some sort)
> just to make it clearer why we're using a test helper instead of
> front-loading the port of ls-files over to sparse-indexes?

Adding this justification to the commit message would definitely be
helpful, so I will do that.

Thanks,
-Stolee
