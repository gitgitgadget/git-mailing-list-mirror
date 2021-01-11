Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A99C433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C7722BEF
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbhAKRKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbhAKRKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 12:10:10 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D5C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 09:09:30 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d20so371793otl.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 09:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SXDTnzOdmgTgzuG07HpcJ8BkkdQvlu1b/oGIQEmyI+E=;
        b=dpwY5zi1i+lcCyPhiZ/rg/M0iK8koafowXq9zd0gBrWpyUqqpdx6ikTAWZVuzV+/wH
         SfdZD0pFJP9z7MVxbarPkjqZ/FMTrBduGYApWo9hQ2xC9NUj2UMxTRdeRgtEJvwby+eS
         JWS/lZFUqxQeii5K9AshDVnHFlErC/QvMUCTJ4c4gxmQlBVyx72qpvTG3lgv+BwgAvFR
         ZRXJihudonIWbcH2VWXgpw6u9ikEd7FRYCKeWtMF6sWonD0k6ggMX+yL3DFU08NFX/oh
         znIeD+Xn5YWBMczQ6dEQKQhV3fmqDX2/4x62kZQ6NfrwkLSNrfA+A6PLPWnOVRJxAlT+
         1QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXDTnzOdmgTgzuG07HpcJ8BkkdQvlu1b/oGIQEmyI+E=;
        b=jNbyVGPE4sHLdQrzxf4G2Z5EbfVQ+FlxauDGPDC3udGoOCdGm1jKSiYP277xrUqkON
         KQZlJY/BSiPAPgriAlQo2Ntjk+AfOp/rEQutplwb1knVBDeGm/MtT5oL9omLtv3/ZLCE
         faRdpdkG0q/aFjVnHG+ONnLgEKJrE5fI5M4u4l6j/ffZOU27mLMVPJwhP5SHePdZIo9i
         LD8lPAwDKSUvm/88ExK6H7ZpxIa5UYqDgwOGajMWMZ3mq6T9mREy6K8x8hDeC4ZZfeZ/
         yL7HzxDZ6F5U6cifDngQSDSf6pTu+iLSJ2e/5IFEpko0huvjXe++VuPd6rl1SBrISfyR
         iZ+A==
X-Gm-Message-State: AOAM533WIoCms1S0RUNBX0FZprHbaufYko/Hof2QkA2hlprPwteACaRP
        T2YN737Jx2uzwIymN2pXQCU=
X-Google-Smtp-Source: ABdhPJweYmxByQiNi/sm5cO1I6ojaH7BBZCaB0YppZG6FGjA7bYIHJVlgShONWBHX8uCBUoyiD9xWg==
X-Received: by 2002:a05:6830:30a8:: with SMTP id g8mr77578ots.291.1610384969614;
        Mon, 11 Jan 2021 09:09:29 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id s26sm73813otd.8.2021.01.11.09.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 09:09:28 -0800 (PST)
Subject: Re: [PATCH 16/20] builtin/gc.c: guess the size of the revindex
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
References: <cover.1610129796.git.me@ttaylorr.com>
 <7c17db7a7df8b524f13969efd1cb5e6e95de5a2d.1610129796.git.me@ttaylorr.com>
 <87cd1b2c-7a28-da77-4ae4-99ffbbdfda72@gmail.com>
 <X/x7mrcwfxGO8xH7@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <13c28eca-81d5-10c9-c92c-162547416014@gmail.com>
Date:   Mon, 11 Jan 2021 12:09:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <X/x7mrcwfxGO8xH7@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/11/2021 11:23 AM, Taylor Blau wrote:
> On Mon, Jan 11, 2021 at 06:52:24AM -0500, Derrick Stolee wrote:
>> This is so far the only not-completely-obvious change.
>>
>>> But, this is an approximation anyway, and it does remove a use of the
>>> 'struct revindex_entry' from outside of pack-revindex internals.
>>
>> And this might be enough justification for it, but...
>>
>>> -	heap += sizeof(struct revindex_entry) * nr_objects;
>>> +	heap += (sizeof(off_t) + sizeof(uint32_t)) * nr_objects;
>>
>> ...outside of the estimation change, will this need another change
>> when the rev-index is mmap'd? Should this instead be an API call,
>> such as estimate_rev_index_memory(nr_objects)? That would
>> centralize the estimate to be next to the code that currently
>> interacts with 'struct revindex_entry' and will later interact with
>> the mmap region.
> 
> I definitely did consider this, and it seems that I made a mistake in
> not documenting my consideration (since I assumed that it was so benign
> nobody would notice / care ;-)).
> 
> The reason I didn't pursue it here was that we haven't yet loaded the
> reverse index by this point. So, you'd want a function that at least
> stats the '*.rev' file (and either does or doesn't parse it [1]), or
> aborts early to indicate otherwise.

In this patch, I would expect it to use sizeof(struct revindex_entry).
Later, the method would know if a .rev file exists and do the right
thing instead. (Also, should mmap'd data count towards this estimate?)

> One would hope that 'load_pack_revindex()' would do just that, but it
> falls back to load a reverse index in memory, which involves exactly the
> slow sort that we're trying to avoid. (Of course, we're going to have to
> do it later anyway, but allocating many GB of heap just to provide an
> estimation seems ill-advised to me ;-).)
> 
> So, we'd have to expand the API in some way or another, and to me it
> didn't seem worth it. As I mentioned in the commit message, I'm
> skeptical of the value of being accurate here, since this is (after all)
> an estimation.

Yes, I'm probably just poking somewhere it was easy to poke. This is
probably not worth the time I'm spending asking about it.

Feel free to disregard.

-Stolee
