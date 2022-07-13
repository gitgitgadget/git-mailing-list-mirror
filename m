Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F7C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiGMNVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiGMNVh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:21:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF312E3
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:21:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so1214334wma.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DC+8r2+i09aoLiT/YqplNjCTNBTXjfRtYPMwwgBuylg=;
        b=P4aLOLaX1RZNYtytjpCeIX1uU4mwhs8zNeU8Of+4swUAXVKosG9clF+8VMHxK4VlWi
         J8Rg3LHucFck93mn1mBldDhMkmrnefbKokDQnDJCrceFPqI4bVLBAMHa3kATdhEeCPZy
         5DfKfOCaMqnVmh8jx12A56Jh0n8J9aZZW0idP8lEadZ6K4N6B0t/NHGUdbu5JXhReF3M
         tPWzwefoS6tkkD9VX8Hd/JCX591DEKX3ILyvTbYAKc+PNUVFjWUNc+06wvjw0G+iqiug
         eSLvmSwKbvI5wWri1ay5Dris88T99qZo6G3PgoJyPXnQ+k0y9uf4iY5eWLE9P1Z8M8HX
         /Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DC+8r2+i09aoLiT/YqplNjCTNBTXjfRtYPMwwgBuylg=;
        b=AaS/KaVZFLLsrqbN1xUudeYdsOtOkj5cJNjsrnEG67HsjCyyQ+0xymrKGn2ZF+oZ4c
         XCNWCGb/bWxk/eYqiCT0dbJsia6CkpoMlpGM0yE+ZOPs5rQcfO6IZIZDYdzMO7Zva48/
         Rwt62EY9t4xVBsowWnipA6oIyzGfNtoKzaTisvrqYp41o7ryG1kVtLZZbrOepL6HmSWP
         W0DzLlZANV5TyRMOfpN1lBzJyo7TAAfC1pbbsIUi+1B4GfS7aZP+7XYM+clrD7lV7nBL
         814zLCqqnWHOS288ed7MC6lZn8cbIBjWJKSi+68sSg/7WdKrLUBQn1sa+DRWcsAf8TWz
         Sppw==
X-Gm-Message-State: AJIora8+DFQ2uo5hX6V51ZnFZVIRKCRUPEDCnEv/ube96FhErTNzSJet
        /bBG75IQCHRCC5F08uoDDzw=
X-Google-Smtp-Source: AGRyM1stZaAJhfEYi81H0Ekh0wgfePqwGq1nG4cSIJfg36D2NbhCHxFj07t4ifPWupX4T03GCjC7pg==
X-Received: by 2002:a05:600c:511c:b0:3a2:d480:9390 with SMTP id o28-20020a05600c511c00b003a2d4809390mr3505683wms.93.1657718495388;
        Wed, 13 Jul 2022 06:21:35 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id r3-20020adfe683000000b0021b81855c1csm13141808wrm.27.2022.07.13.06.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 06:21:35 -0700 (PDT)
Message-ID: <24148494-72ab-23f8-58b5-c8371c44d167@gmail.com>
Date:   Wed, 13 Jul 2022 14:21:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/7] xdiff: use GALLOC_GROW(), not XDL_ALLOC_GROW()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-5.7-3665576576f-20220708T140354Z-avarab@gmail.com>
 <c2bc5c79-e71b-f9dc-ba97-261d3454e150@gmail.com>
 <220711.861qur9ays.gmgdl@evledraar.gmail.com>
 <e86cac3b-4e05-be20-41d8-ed5006463556@gmail.com>
 <220713.86edyp46ld.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220713.86edyp46ld.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2022 11:48, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jul 13 2022, Phillip Wood wrote:
>>
>> I'm a bit disappointed that this patch seems to have been written
>> without really taking the time to understand exactly what the code it
>> is replacing is doing.
> 
> Well, there's a lot to understand :) So it's also an implicit comment on
> the complexity of your series.

I'm surprised you think it is complex, the implementation of 
XDL_ALLOC_GROW() and its helper is pretty short.

> In case it wasn't clear the main thrust of what I've been commenting on
> here is asking why what you have here needs to *structurally* look the
> way it does, i.e. why you think the malloc() & free() naming can't
> resolve to libgit2's wrappers (per the thread ending at [1]).

I think the different structural approach stems in part from the subtle 
differences between ALLOC_GROW() and XDL_ALLOC_GROW(). Once one 
appreciates that the latter needs to free the original allocation on 
overflow and allocation failure and work with code that uses long rather 
than size_t then there is not much code left to be shared between them.

> And, if we can't end up with an xdiff/* in our tree that doesn't have
> return value checking flying in the face of xmalloc's NORETURN()
> behavior on allocation failures.

I don't think xmalloc() is marked as NORETURN in wrapper.h so the 
compiler would need somehow determine that from looking at the 
implementation in wrapper.c but even if it is using LTO I'm not sure 
it'll have that information when creating xdiff/lib.a

> But yes, the suggested replacement isn't behaving exactly as yours does,
> but I think that's just an implementation detail as far as the stuctural
> questions above go. I.e.:
> 
>   * You're trying to fix a long-standing overflow issue in alloc_nr(),
>     but in such a way that only leaves xdiff/* with the fix.

I didn't set out to fix that issue per-se, I only realized it existed 
when I reviewed this series.

>     Can't we address that seperately (e.g. turning alloc_nr into a static
>     inline function using the st_* helper), and then make xdiff and
>     cache.h use that new shared helper?

As I've said before xdiff does not want to die on overflow so it cannot 
use st_mult(). Also you cannot assume that you're dealing with size_t 
when you do the overflow check in alloc_nr() so I think it is a tricky 
problem to solve.

>   * You seem to be set on the idea that you absolutely must be rewriting
>     large parts of the existing allocation macro, because you'd really
>     like to use it as an expression v.s. a statement.

It is not just that - there are plenty of differences that stem from 
returning an error rather that dying that reduce the amount of common 
code. Having a separate definition was also driven by a desire to keep 
the xdiff code self contained.

This will likely be the last message from me in this thread for a while 
- I'm going offline later next week and want to make sure I have time to 
review Stolee's rebase patches before then.

Best Wishes

Phillip
