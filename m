Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808CDC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 11:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiGMLE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiGMLEH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 07:04:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02CB5006A
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:04:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m16so13584457edb.11
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2hnT+FVoA1KWE9QSQoRBmbYVdjD7ZHY+VE33dPJR2wE=;
        b=iUH+Dxj0uN1QKfP/YwoIhcgWsRqK6sufD6TgImMMzDJNMlr6oPiW89owHYSGvPt2zZ
         E2Qg3GpSGxpeB1x626jJzsTj/ooGmhpqe8s6GitjcIw+tiptLzndwvYwoI8eJONkWl23
         KVg7557kGFl8CCodu/Kd9mM5X4l4EEw00ANcumdECA6rDWNF8hkC2ORQNHRqgmdsA5q1
         ENxYOrP4rbMmv1IaSGY+iZhFdWmjxZfrO5jc33VtwrKNNCwjLqhGecyCH8xPGOJZ9ocN
         e7ilsBFyAnBjlUCBt0VwOCVGedsSQ02xbyTApbZ8xBaV+vO0eLmaQ0CWyOtNgDJuC69J
         1GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2hnT+FVoA1KWE9QSQoRBmbYVdjD7ZHY+VE33dPJR2wE=;
        b=ov9/eZ4A/bLAmUk2LMyKZCvTGRs87Zoc5CXe1ctthCBdW8w8cySuKcxNWEXPvA1RoN
         lP9MNav0l4KYouqMK0mAKt1gKMIurAQ5itcM15jYt/qSEhlHT0+bw1Wtl8Tzbld6RcWE
         TckZ16l8IMYADro674y9PrKR0Vv0ECmIjU9r9yk9FJIpx/IvBRV19d2bpkYaIS5DW0sj
         0YFLtVHVEq5x+yeXxKYDNmyQyjquNHNOYBQCIAv1IJL2zFAFxUp8nxUaf6FiWjVP8y1c
         488hcAozEmyHz+MpRrl+4GHHfKEqKlkwtooNnEHDWXEmRvPo9dGi05y0MY51n1yx2tK8
         uGgA==
X-Gm-Message-State: AJIora/vLj3j5HRVfS3wJ8EQMYqJoiV57Du2qKFZvNUTaXkx2reljZk6
        aOMhLA7+ihfuGJXNktq6gwU=
X-Google-Smtp-Source: AGRyM1uayYD+1KZP5vU2q11wlydhRzrqiKDh2/iT4HZ8LfP1du4C5E6ESqhubSFcj8VyWqMqxlHV1A==
X-Received: by 2002:a05:6402:4301:b0:43a:e374:1557 with SMTP id m1-20020a056402430100b0043ae3741557mr4135393edc.229.1657710240255;
        Wed, 13 Jul 2022 04:04:00 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h4-20020a50ed84000000b0043a85d7d15esm7661579edr.12.2022.07.13.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:03:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBa9u-001gvm-Ar;
        Wed, 13 Jul 2022 13:03:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/7] xdiff: use GALLOC_GROW(), not XDL_ALLOC_GROW()
Date:   Wed, 13 Jul 2022 12:48:22 +0200
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-5.7-3665576576f-20220708T140354Z-avarab@gmail.com>
 <c2bc5c79-e71b-f9dc-ba97-261d3454e150@gmail.com>
 <220711.861qur9ays.gmgdl@evledraar.gmail.com>
 <e86cac3b-4e05-be20-41d8-ed5006463556@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <e86cac3b-4e05-be20-41d8-ed5006463556@gmail.com>
Message-ID: <220713.86edyp46ld.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 11/07/2022 11:48, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Jul 11 2022, Phillip Wood wrote:
>>=20
>>> Hi =C3=86var
>>>
>>> On 08/07/2022 15:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Replace the recently introduced XDL_ALLOC_GROW() with invocations of
>>>> the GALLOC_GROW() from git-shared-util.h.
>>>> As this change shows the macro + function indirection of
>>>> XDL_ALLOC_GROW() is something we needed only because the two callsites
>>>> we used it in wanted to use it as an expression, and we thus had to
>>>> pass the "sizeof" down.
>>>> Let's just check the value afterwards instead, which allows us to
>>>> use
>>>> the shared macro, we can also remove xdl_reallo(), this was its last
>>>> user.
>>>
>>> I don't think this expression->statement change is an
>>> improvement.
>> I think the use-as-statement is prettier too, but I think the
>> uglyness
>> of having to pass down the sizeof() & re-implementing the macro version
>> of the alloc-or-die variant outweights that.
>
> I think this is partly a choice between prioritizing ease of
> implementation or ease of use for callers.
>
>>> This change also removes the overflow checks that are
>>> present in XDL_ALLOC_GROW()[...]
>> We end up calling st_mult(), which does that overflow check. Do you
>> mean
>> that the POC shimmy layer I showed in another reply for libgit2 doesn't
>> have an st_mult() that detects overflows?
>
> I was referring to
>
> #define alloc_nr(x) (((x)+16)*3/2)
>
> in cache.h. XDL_ALLOC_GROW() detects overflows when growing the number
> of items as well as when calculating the number of bytes to allocate.
>
>> That's true, but as noted downthread of that we can & could ship that as
>> part of the shimmy layer, but that's unrelated to this change.
>> In your pre-image you use LONG_MAX instead of UINTMAX_MAX & I don't
>> see
>> (but maybe I haven't looked at it carefully enough) how it does the same
>> dying on overflows. Doesn't it just fall back to LONG_MAX?
>
> It does not die on overflow as we want to return errors rather than
> die in the xdiff code. It uses long to match the existing code.
>
>> Part of this is that it's not clear to me from your commit(s) why you
>> need to rewrite alloc_nr() and rewrite (or drop?) st_mult().
>
> So that we don't die on overflow and so that the xdiff code is self
> contained.
>
> I'm a bit disappointed that this patch seems to have been written
> without really taking the time to understand exactly what the code it
> is replacing is doing.

Well, there's a lot to understand :) So it's also an implicit comment on
the complexity of your series.

In case it wasn't clear the main thrust of what I've been commenting on
here is asking why what you have here needs to *structurally* look the
way it does, i.e. why you think the malloc() & free() naming can't
resolve to libgit2's wrappers (per the thread ending at [1]).

And, if we can't end up with an xdiff/* in our tree that doesn't have
return value checking flying in the face of xmalloc's NORETURN()
behavior on allocation failures.

But yes, the suggested replacement isn't behaving exactly as yours does,
but I think that's just an implementation detail as far as the stuctural
questions above go. I.e.:

 * You're trying to fix a long-standing overflow issue in alloc_nr(),
   but in such a way that only leaves xdiff/* with the fix.

   Can't we address that seperately (e.g. turning alloc_nr into a static
   inline function using the st_* helper), and then make xdiff and
   cache.h use that new shared helper?

 * You seem to be set on the idea that you absolutely must be rewriting
   large parts of the existing allocation macro, because you'd really
   like to use it as an expression v.s. a statement.

   I really disagree with that trade-off, i.e. the whole endeavor of
   duplicating the implementation in ways that are mostly the same but
   not quite (e.g. that alloc_grow case) doesn't seem worth it
   v.s. sharing the behavior.

   But likewise it seems to be an implementation detail of your series
   that we can't have both, i.e. if you're set on using these as an
   expression factoring the shared behavior in cache.h out into some
   static inline functions, then calling those from both variants.

1. https://lore.kernel.org/git/220711.865yk47x54.gmgdl@evledraar.gmail.com/
