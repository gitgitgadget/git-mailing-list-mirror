Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6BDC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1606611AE
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhFHXUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhFHXUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 19:20:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01980C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 16:18:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g8so35358328ejx.1
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eYL2zCfGJZR4rrKJRK8llZ8aIul+DphxUzfJEQXz9oI=;
        b=SsYqnpQv5oHEUXx1DYjsRoSSeFKBzguyIG9tYNvW2C2IQoEHHWNU/zIkACmSU/SJcj
         cHuOXnywC2ySsE9MXg+OftlKRhoaoYcnbDD8WWPCedrEgib+7wYzzMXLTNS6v2Ipg+9b
         PO3xhiYHp7ulCX/OkYBVJ1LlGvL0jxDUvXlMv5gcy1GjzFMsyXBmlOafM0nsrxF4+kTe
         jSO1Yg4uRJNuJdt3SS/JZgwMtJWwm/sfkL+NFzQrKEsKeDFI3YGGtXSA2LuE3aZEID+a
         iL/bY2vD4uoQs8SUOulTyoMWJW+CuWuRZuAIBfXT6tfU2EhtRElBHXCA2NoUt4yWERZ8
         Wy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eYL2zCfGJZR4rrKJRK8llZ8aIul+DphxUzfJEQXz9oI=;
        b=JPUXd+VAtciNuPfn1NPPQ+txb+2EaL/o0Yp6vvxXCSZJ9UicxOHelaxs1czC07PYl1
         GYe3/1hMS+/N9RJ8njTQh+2kMg2FSuSeGzo131HAZjq94x4CUCdpIC2Mn8li6G0D/1sg
         DijRKuf3OGwF/rReAJ7OeIc6bg+pNNS48NC0ghsE+iS0GuCRTAaVS8+hLlt6Lrgb3dt+
         FP3EeGW2sYeDJmHJNX42mP5yFEFttEXxLICHJE1nOox1Eps2uf1VYVsSPzKkGBCly+JX
         Dj4ZXI6eCcySqOXr+2xI5UuVGtcZC39dDW+4NxqHT9biX7bPUrty05+Mx9l7ouNO04m7
         pFHw==
X-Gm-Message-State: AOAM531WXGrdm7D1uMYo+0PGhpy0ChMQ9E3f8YfwL3tf9hWQDwCiIBge
        HOo/w/0Tgxx94GjWxSKpPeE=
X-Google-Smtp-Source: ABdhPJw3CmhlgEETL5PMnP8jJAD800UM6HAzfX9zQlEyE1TPS/90wscjecQG25AhUBxyneZUR2FMzw==
X-Received: by 2002:a17:906:3b87:: with SMTP id u7mr26231739ejf.548.1623194306346;
        Tue, 08 Jun 2021 16:18:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q14sm432835eds.2.2021.06.08.16.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:18:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
Date:   Wed, 09 Jun 2021 00:12:58 +0200
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
 <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
 <87wnr4394y.fsf@evledraar.gmail.com>
 <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
Message-ID: <87lf7k2bem.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 08 2021, Ren=C3=A9 Scharfe wrote:

> Am 08.06.21 um 12:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Tue, Jun 08 2021, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>>> So I think this pattern works:
>>>>>
>>>>> 	for (i =3D 0; i < nr; i++) {
>>>>> 		display_progress(p, i);
>>>>> 		/* work work work */
>>>>> 	}
>>>>> 	display_progress(p, nr);
>>>>>
>>>>> Alternatively, if the work part doesn't contain continue statements:
>>>>>
>>>>> 	for (i =3D 0; i < nr; i++) {
>>>>> 		/* work work work */
>>>>> 		display_progress(p, i + 1);
>>>>> 	}
>>>>
>>>> But yes, I agree with the issue in theory, but I think in practice we
>>>> don't need to worry about these 100% cases.
>>>
>>> Hmph, but in practice we do need to worry, don't we?  Otherwise you
>>> wouldn't have started this thread and Ren=C3=A9 wouldn't have responded.
>>
>> I started this thread because of:
>>
>> 	for (i =3D 0; i < large_number; i++) {
>> 		if (maybe_branch_here())
>> 			continue;
>> 		/* work work work */
>> 		display_progress(p, i);
>> 	}
>> 	display_progress(p, large_number);
>>
>> Mainly because it's a special snowflake in how the process.c API is
>> used, with most other callsites doing:
>>
>> 	for (i =3D 0; i < large_number; i++) {
>> 		display_progress(p, i + 1);
>> 		/* work work work */
>> 	}
>
> Moving the first call to the top of the loop makes sense.  It ensures
> all kind of progress -- skipping and actual work -- is reported without
> undue delay.
>
> Adding one would introduce an off-by-one error.  Removing the call after
> the loop would leave the progress report at one short of 100%.  I don't
> see any benefits of these additional changes, only downsides.
>
> If other callsites have an off-by-one error and we care enough then we
> should fix them.  Copying their style and spreading the error doesn't
> make sense -- correctness trumps consistency.
>
>> Fair enough, but in the meantime can we take this patch? I think fixing
>> that (IMO in practice hypothetical issue) is much easier when we
>> consistently use that "i + 1" pattern above (which we mostly do
>> already). We can just search-replace "++i" to "i++" and "i + 1" to "i"
>> and have stop_progress() be what bumps it to 100%.
>
> This assumes the off-by-one error is consistent.  Even if that is the
> case you could apply your mechanical fix and leave out read-cache.
> This would happen automatically because when keeping i there is no ++i
> to be found.
>
> stop_progress() doesn't set the progress to 100%:
>
>    $ (echo progress 0; echo update) |
>      ./t/helper/test-tool progress --total 1 test
>    test:   0% (0/1), done.
>

I was too quick with that "But yes, I agree with the issue in theory".

Having thought about it some more I think you're wrong, it doesn't make
sense to use the API in the way you're suggesting.

There's an off-by-one error, but it's in the pattern you're
suggesting. Calling "i + 1" on the "first item" doesn't just make for
less verbose code, it's also more correct.

Why? Because:

    /* 1. Setup progress */
    large_number =3D 3;
    progress =3D start_progress(title, total);

    /* 2. Before we "actually" do anything */
    for (i =3D 0; i < 3; i++) {
        /* 3. Now doing O(large_number) work */
        display_progress(progress, i + 1);
    }

    /* 4. Done */
    stop_progress(&progress);

As you'll see if you insert a sleep or whatever at "2" we'll signal and
display the progress bar even if we haven't called display_progress()
yet.

Thus calling display_progress with n=3D0 makes "we are doing the first
item" indistinguishable from "we haven't gotten to the first item
yet". When you're in the loop the first item should be n=3D1.

This isn't just more correct with this API. I think it also makes sense
not to leak the zero indexed C abstraction to human output. As in:

    I sat down at the table with my three apples (stages 1..2 above),
    and now I'm eating my first apple (stage 3), I'm not starting to eat
    my zeroeth apple. At some point I'm done eating all 3 apples (stage
    4).

I think this gets to the crux of the issue for you, per your upthread:

    [...]With your change you'd get 100% for a minute.  Both would be
    annoying, but the latter would have me raging.  "If you're done",
    I'd yell at the uncaring machine, "what are you still doing!?".

If we said we're done and we're not then yes, that would be a bug.

But that's not what we said. Distinguishing "I'm on 3/3" from "I'm done"
is exactly what the progress.c output does:

    $ perl -wE 'for (0..3) { say "update"; say "progress $_" }' |
      ./helper/test-tool progress --total=3D3 Apples 2>&1 |
      cat -v | perl -pe 's/\^M\K/\n/g'
    Apples:   0% (0/3)^M
    Apples:  33% (1/3)^M
    Apples:  66% (2/3)^M
    Apples: 100% (3/3)^M
    Apples: 100% (3/3), done.

It's not immediately obvious from that output, but the last line ending
in ", done" isn't added by any display_progress() call, but by calling
stop_progress(). That's when we're done.

Arguably this is too subtle and we should say ", but not done yet!" or
something on that penultimate line. But that's bikeshedding a display
issue; The API use in my patch is correct.

As I noted upthread that's a "matter of some philosophy". I guess you
might report your progress as being at 2/3 apples, even though you're
one bite away from finishing the third apple. Personally I'd say I'm on
the third apple, I'm just not done with it.

But the philosophizing of whether your "progress" is the zeroeth apple
of the day as you're chewing on it aside, I think it's clear that in the
context of the progress.c API using n=3D0 for the first apple would be a
bug.

You'll conflate "setup" with "work" per the above, and you'll say you're
on the second apple even if you're a bite away from finishing it. We
don't conflate that "100%" state with being "done", so I don't see why
we'd do that.

> I wonder (only in a semi-curious way, though) if we can detect
> off-by-one errors by adding an assertion to display_progress() that
> requires the first update to have the value 0, and in stop_progress()
> one that requires the previous display_progress() call to have a value
> equal to the total number of work items.  Not sure it'd be worth the
> hassle..

That's intentional. We started eating 3 apples, got to one, but now our
house is on fire and we're eating no more apples today, even if we
planned to eat 3 when we sat down.

The progress bar reflects this unexpected but recoverable state:
=20=20=20=20
    $ perl -wE 'for (0..1) { say "update"; say "progress $_" }' |
      ./helper/test-tool progress --total=3D3 Apples 2>&1 |
      cat -v | perl -pe 's/\^M\K/\n/g'
    Apples:   0% (0/3)^M
    Apples:  33% (1/3)^M
    Apples:  33% (1/3), done.

We're at 1/3, but we're done. No more apples.

This isn't just some hypothetical, e.g. consider neeing to unlink() or
remove files/directories one at a time in a directory and getting the
estimated number from st_nlink (yeah yeah, unportable, but it was the
first thing I thought of).

We might think we're processing 10 entries, but another other processes
might make our progress bar end at more or less than the 100% we
expected. That's OK, not something we should invoke BUG() about.

Similarly, the n=3D0 being distinguishable from the first
display_progress() is actually useful in practice. It's something I've
seen git.git emit (not recently, I patched the relevant code to emit
more granular progress).

It's useful to know that we're stalling on the setup code before the
for-loop, not on the first item.
