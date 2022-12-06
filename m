Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50018C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiLFCRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiLFCRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:17:34 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2CB1D31E
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:17:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bj12so2781697ejb.13
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqK2Vk+dnGKRHPJvF+5vj/RFodLyTczHXw8WjxzfqxQ=;
        b=hfiG24ARugwyWpraNjWhUl1Og+ber7UddZdNzsG4tHlO77Y2Lbu2bImkitJyrxtV8L
         bjZluncoohpSLdUF6oR3To5hnXiKz8tDwLe7/HA0D9iJVt9u1KDvrEKEVAELAWks7QKl
         pWmHN8gl4Vmk0or3NxodGBbUdYbUpWsRdI3fYYH5HqdlLwzx3DqCPrq8ict6hhfx6ir+
         YZFIWs/fr/c/SgoBAJ+bMpofxhLj+Q2TU0UQmgl7pOzobpFKiK628zS1n21NaBaE2dvQ
         47zWQDOHVJj8wc5fBLRODUty4Z/A0nJXyXw3shyXyxEyujcaIzD4B6XlohO8CbqtB+uv
         rVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqK2Vk+dnGKRHPJvF+5vj/RFodLyTczHXw8WjxzfqxQ=;
        b=T5/BZBSi5exqBS3/ODVOxf59pxJKRyOWmIdzA32SVhP1wV0ModBiHjT5s1G16L3V9h
         gVVWiKyaKoL9F5pLptPFoaITEBnp8y22wES2H3Ni+UUCAFcanjTbCe4/3DQ44NxdM9B3
         vWxv6y4aLnD2s5lIpQXvSVs5JeS5M0k1bq1WN7pm/LU06ullg2vyAz/vVLVl6xNohX7m
         CJhFgyZBT/CkEPb5QPecO07cJqEL3HN/F+y5NVhSj96U8MPCFO/76EYxTwPLPraX2iKw
         co4inUThBhy2UV0WQZNkos4N+B16BO5ET9fCGyZ5hbW2pfqTHnl5YeF+BB3M+gTR+Cw6
         iZbg==
X-Gm-Message-State: ANoB5pnxrMoIzqVXSTJ5zXGHdu/mU91VdMfI0SfA4UQkR2P/aKfeITz2
        VNIuG3MdSr56Vnevci/tr0EU3mTC4jcARw==
X-Google-Smtp-Source: AA0mqf41V9JKyyWUOk9Gw6px1Hbf9VBq0SWkdgjAHBMQEJskxhrAKSFQ05J5I7DLOGL/ShZkZwZaiw==
X-Received: by 2002:a17:906:1985:b0:7ad:d1ab:2431 with SMTP id g5-20020a170906198500b007add1ab2431mr68924076ejd.213.1670293049954;
        Mon, 05 Dec 2022 18:17:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906680200b0077077c62cadsm6768544ejr.31.2022.12.05.18.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:17:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2NWT-003QFZ-0U;
        Tue, 06 Dec 2022 03:17:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Date:   Tue, 06 Dec 2022 03:12:08 +0100
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <xmqqedtdpfoe.fsf@gitster.g> <Y46M4oksPQkqwmTC@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y46M4oksPQkqwmTC@nand.local>
Message-ID: <221206.86r0xdcm2u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 05 2022, Taylor Blau wrote:

> On Tue, Dec 06, 2022 at 08:57:21AM +0900, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > In git.git, it is sometimes common to write something like:
>> >
>> >     T *ptr;
>> >     CALLOC_ARRAY(ptr, 1);
>> >
>> > ...but that is confusing, since we're not initializing an array.
>>
>> Given that "man calloc" tells us that calloc takes two parameters,
>>
>>     void *calloc(size_t nmemb, size_t size);
>>
>> I personally find CALLOC() that takes only a single parameter and is
>> capable only to allocate a single element array very much confusing.
>
> Hmm. I have always considered "calloc" a mental shorthand for "zero
> initialize some bytes on the heap". It seemed like you were in favor of
> such a change in:
>
>     https://lore.kernel.org/git/xmqq8rl8ivlb.fsf@gitster.g/
>
> ...but it's entirely possible that I misread your message, in which case
> I would not be sad if you dropped this patch on the floor since I don't
> feel that strongly about it.
>
> I'd be fine to call it CALLOC_ONE() or something, but I'm not sure at
> that point if it's significantly better to write "CALLOC_ONE(x)" versus
> "CALLOC_ARRAY(foo, 1)"
>
>> It _might_ be arguable that the order of the parameters CALLOC_ARRAY
>> takes should have been reversed in that the number of elements in
>> the array should come first just like in calloc(), while the pointer
>> that is used to infer the size of an array element should come next,
>> but that is water under the bridge.
>
> Yes, I agree that that would be better. But it would be frustrating to
> make a tree-wide change of that magnitude at this point. So I agree it's
> water under the bridge ;-).

I'm not saying you *should*, but now that we use C99 macros we *could*
also make the "1" an optional argument. I.e. these would be the same
thing:

	CALLOC(x)
	CALLOC(x, 1)

And you could also do:

	CALLOC(x, 123)

Whether that makes the interface even nastier is another matter.

That can be done by dispatching to an underlying function, and defining
the macro as:

	#define CALLOC(...) mycallocfn_1(__VA_ARGS__, NULL)

I.e. for the above you'd get either "x, NULL, NULL", "x, 1, NULL", or
"x, 123, NULL". The function could then manually check the arity.

Maybe I've just been corrupted by reading the P99 library :)
