Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169E3C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 23:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E649F60238
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 23:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhGEXt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 19:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhGEXt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 19:49:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ACFC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 16:46:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ga42so13904803ejc.6
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AM/c0y5TIH/9k6azlMshg9EVUuu49yD7wXrU+s9Nw7E=;
        b=gFziFhO04SBeznwXKwGLN7JBdC0Mvss07cgseHDUuP/OFVmipqSSBraG1bi+LLvsnW
         14C7BAL6Ioma/+j6ODSyHes22g8bdt5kzzOTESxscr7wLfYxN4pXaoVkZsTAgbyC5to5
         mYE33Z/C/O1CD/7354udhtpPBGFrU5be74rvxHBx6J1Mfj3IY8Y4ZHupzxFgtgltIPD3
         ZWyh/hTHDwr2lN98kSXOLtu0OobDN4f20QghFg1nrEYlm+HYyYppiE8AFDSUh/Adu6Nz
         OlNveHg4SEYX4cnXEx7BSEbiX/FZFvFlC9LJN08TN6KYikcOgS/DFQyBybCmIaUOY6VD
         NxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AM/c0y5TIH/9k6azlMshg9EVUuu49yD7wXrU+s9Nw7E=;
        b=tzbsel2zTbQvZJPQ+QIl3emYhFwM0Bs/hge/96TQfAU44nXr1RkyneeWEnRlySsQ2U
         tPAEqLuD2+U/UWnCZyFahrpSRY+bKaUFEhX5rQs6AjpBZdFKfwyOO/eari0Xx9LECDKK
         plC15NIqSKdlT06JLdli1kRBuCuTLIq5ZpunNqf+1eSqZXDQzA+3uLFuMJz6U/UFqG3E
         cdnRMx3tccwNCLlTKMuDjPoMzhz2qrFNTKyoYmAenzZe+DKb4FlFAIIjBrmdxiOhKnKs
         Cbf1azXXvFpsaMjR/s+LsPTEsSuLbP0bO2vjw9SA3ksNkZ5XNVB1rFlhWTBSnS1K6tGT
         j5Yw==
X-Gm-Message-State: AOAM5333MxLnQE2ODoXbT7Sbc2kmygHuCHnTzFIxXuD0pZfkGYEUmXKl
        sgaD2/USR05wThP7oQm4yAE=
X-Google-Smtp-Source: ABdhPJzZiI781nF881R8/Hn6hW5+YRohVe37nnMi7a5az9RnuSo0YAoxGUEnPOHw7Cnzac8GqSsz3Q==
X-Received: by 2002:a17:906:5d1:: with SMTP id t17mr16339182ejt.320.1625528806166;
        Mon, 05 Jul 2021 16:46:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f9sm4461390edw.88.2021.07.05.16.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 16:46:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
Date:   Tue, 06 Jul 2021 01:28:44 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
 <87a6nk41wy.fsf@evledraar.gmail.com>
 <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
 <87h7hr2cx0.fsf@evledraar.gmail.com>
 <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
 <87a6ncy9aq.fsf@evledraar.gmail.com>
 <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
 <874kdkxot4.fsf@evledraar.gmail.com>
 <ca3eba46-7c83-51fd-2d65-c55309ac7182@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <ca3eba46-7c83-51fd-2d65-c55309ac7182@web.de>
Message-ID: <87y2ak5noa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 04 2021, Ren=C3=A9 Scharfe wrote:

> Am 26.06.21 um 23:38 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sat, Jun 26 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 26.06.21 um 16:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> [...]
>>>> To reference my earlier E-Mail[1] are you eating the first apple or the
>>>> zeroeth apple? I don't think one is more or less right in the
>>>> mathematical sense, I just think for UX aimed at people counting "laps"
>>>> makes more sense than counting completed items.
>>>
>>> The difference between counting iterations and work items vanishes as
>>> their numbers increase.  The most pronounced difference is observed when
>>> there is only a single item of work.  The count-iterations model shows
>>> 1/1 from start to finish.  The count-work model shows 0/1 initially and
>>> 1/1 after the work is done.
>>>
>>> As a user I prefer the second one.  If presented with just a number and
>>> a percentage then I assume 100% means all work is done and would cancel
>>> the program if that status is shown for too long.  With Git I have
>>> learned that only the final ", done" really means done in some cases,
>>> but that's an unnecessary lesson and still surprising to me.
>>
>> What progress bar of ours goes slow enough that the difference matters
>> for you in either case?
>
> I don't have an example -- Git, network and SSD are quick enough for my
> small use cases.
>
> The advantage of the count-work method is that the question doesn't even
> come up.
>
>> The only one I know of is "Enumerating objects", which notably stalls at
>> the start, and which I'm proposing changing the output of in:
>> https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-ava=
rab@gmail.com/
>
> That's annoying, but the first number I see there has five or six digits,
> so it's not an example of the issue mentioned above for me.

Because it stalls and shows nothing, but with my patch it'll show
something while stalling, FWIW on linux.git from a cold cache it took
5-10s before showing anything.

> Your patch shows ", stalled." while pack-objects starts up.  I'm not sure
> this helps.  Perhaps there are cases when it gets stuck, but it's hard to
> determine by the clock alone.  When I run gc, it just needs a few seconds
> to prepare something and then starts visibly counting objects.  A more
> fine-grained report of the preparation steps would help, but seeing
> "stalled" would just scare me.

Fair enough, I have other patches to have it show a spinner. Again, API
v.s. UI. The idea is that we show something before we start the loop.

>>> The count-work model needs one more progress update than the
>>> count-iteration model.  We could do all updates in the loop header,
>>> which is evaluated just the right number of times.  But I think that we
>>> rather should choose between the models based on their results.
>>
>> I think we should be more biased towards API convenience here than
>> anything else, because for most of these they'll go so fast that users
>> won't see the difference. I just also happen to think that the easy way
>> to do it is also more correct.
>
> The convenience of having one less display_progress() call is only a
> slight advantage.
>
> Correctness is a matter of definitions.  Recently I learned that in Arabic
> a person's age is given using the count-iterations model.  I.e. on the day
> of your birth your age is one.  That causes trouble if you deal with
> state officials that use the count-work, err, count-completed-years model,
> where your age is one only after living through a full year.
>
> The solution around here is to avoid ambiguity by not using terms like
> "age" in laws, regulations and forms, but to state explicitly "full years
> since birth" or so.
>
> "2/3 (33%)" means something else to me than to you by default.  So a
> solution could be to state the model explicitly.  I.e. "2/3 (66%) done"
> or "working on 2/3 (66%)", but the percentage doesn't quite fit in the
> latter case.  Thoughts?

OK, UI again.

>> Also, because for these cases that you're focusing on where we count up
>> to exactly 100% and we therefore expect N calls to display_progress()
>> (igroning the rare but allowed duplicate calls with the same number,
>> which most callers don't use). We could just have a convenience API of:
>>
>>     start_progress()
>>     for i in (0..X-1):
>>         progress_update() /* passing "i" not needed, we increment intern=
ally */
>>         work()
>>     stop_progress()
>>
>> Then we could even make showing 0/N or 1/N the first time configuable,
>> but we could only do both if we use the API as I'm suggesting, not as
>> you want to use it.
>
> A function that increments the progress number relatively can be used
> with both models.  It's more useful for the count-iterations model,
> though, as in the count-work model you can piggy-back on the loop
> counter check:
>
> 	for (i =3D 0; display_progress(p, i), i < X; i++)
> 		work();

Aside from this whole progress API discussion I find sticking stuff like
that in the for-loop body to be less readable.

But no, that can't be used with both models, because it conflates the 0
of the 1st iteration with 0 of doing prep work. I.e.:

    p =3D start_progress();
    display_progress(p, 0);
    prep_work();
    for (i =3D 0; i < 100; i++)
        display_progress(p, i + 1);

Which is implicitly how that "stalled" patch views the world, i.e. our
count is -1 is at start_progress() (that's already the case in
progress.c).

If you set it to 0 you're not working on the 1st item yet, but
explicitly doing setup.=20

Then at n=3D1 you're starting work on the 1st item.

>> You also sort of can get me what I want with with what you're
>> suggesting, but you'd conflate "setup" work with the first item, which
>> matters e.g. for "Enumerating objects" and my "stalled" patch. It's also
>> more verbose at the code level, and complex (need to deal with "break",
>> "continue"), so why would you?
>
> It's not complicated, just slightly odd, because function calls are
> seldomly put into the loop counter check.

FWIW the "complicated" here was referring to dealing with break/continue.

Yes I'll grant you that there's cases where the uglyness/oddity of that
for-loop trick is going to be better than dealing with that, but there's
also while loops doing progress, callbacks etc.

Picking an API pattern that works with all of that makes sense, since
the UI can render the count one way or the other.

>>> If each work item finishes within a progress display update period
>>> (half a second) then there won't be any user-visible difference and
>>> both models would do.
>>
>> A trivial point, but don't you mean a second? AFAICT for "delayed" we
>> display after 2 seconds, then update every 1 seconds, it's only if we
>> have display_throughput() that we do every 0.5s.
>
> Right, I mixed those up.
>
>>>> The other is that if you count laps you can have your progress bar
>>>> optionally show progress on that item. E.g. we could if we stall show
>>>> seconds spend that we're hung on that item, or '3/3 ETA 40s". I have a
>>>> patch[3] that takes an initial step towards that, with some more queued
>>>> locally.
>>>
>>> A time estimate for the whole operation (until ", done") would be nice.
>>> It can help with the decision to go for a break or to keep staring at
>>> the screen.  I guess we just need to remember when start_progress() was
>>> called and can then estimate the remaining time once the first item is
>>> done.  Stalling items would push the estimate further into the future.
>>>
>>> A time estimate per item wouldn't help me much.  I'd have to subtract
>>> to get the number of unfinished items, catch the maximum estimated
>>> duration and multiply those values.  OK, by the time I manage that Git
>>> is probably done -- but I'd rather like to leave arithmetic tasks to
>>> the computer..
>>>
>>> Seconds spent for the current item can be shown with both models.  The
>>> progress value is not sufficient to identify the problem case in most
>>> cases.  An ID of some kind (e.g. a file name or hash) would have to be
>>> shown as well for that.  But how would I use that information?
>>
>> If we're spending enough time on one item to update progress for it N
>> times we probably want to show throughput/progress/ETA mainly for that
>> item, not the work as a whole.
>
> Throughput is shown for the last time period.  It is independent of the
> item or items being worked on during that period.  If one item takes
> multiple periods to finish then indeed only its current progress is
> shown automatically, as you want.
>
> Showing intra-item progress requires some kind of hierarchical API to
> keep track of both parent and child progress and show them in some
> readable way.  Perhaps appending another progress display would suffice?
> "Files 1/3 (33%) Bytes 17kB/9GB (0%)".  Not sure.

Yes, this is another thing I'm heading for with the patches I posted.

For now I just fixed bugs in the state machine of how many characters we
erase, now we always reset exactly as much as we need to, and pass
things like ", done" around, not ", done\n" or ", done\r" (i.e. the
output we're emitting isn't conflacted with whether we're clearing the
line, or creating a new line.

It's a relatively straightforward change from there to have N progress
structs that each track/emit their part of a larger progress bar,
e.g. something like the progress prove(1) shows you (test status for
each concurrent test you're running).

You just need a "parent" progress struct that has the "title" (or none),
and receives the signal, and to have N registered sub-progress structs.

> Calculating the ETA of a single item seems hard.  It does require intra-
> item progress to be reported by the work code.
>
>> If we do run into those cases and want to convert them to show some
>> intra-item progress we'd need to first migrate them over to suggested
>> way of using the API if we picked yours first, with my suggested use we
>> only need to add new API calls (display_throughput(), and similar future
>> calls/implicit display).
>
> I don't see why.  The intra-item progress numbers need to be reported in
> any case if they are to be shown somehow.  If the model is clear then we
> can show unambiguous output.

Because you want to show:

    Files 1/3 (33%) Bytes 17kB/9GB (0%)

Not:

    Files 0/3 (33%) Bytes 17kB/9GB (0%)

You're downloading the 1st file, not the 0th file, so the code is a
for-loop (or equivalent) with a display_progress(p, i + 1) for that
file, not display_progress(p, i).

This is the main reason I prefer the API and UI of reporting "what item
am I on?" v.s. "how many items are done?", because it's easy to add
intra-item state to the former.

>> Consider e.g. using the packfile-uri response to ask the user to
>> download N number of URLs, just because we grab one at 1MB/s that
>> probably won't do much to inform our estimate of the next one (which may
>> be on a different CDN etc.).
>
> Sure, if the speed of work items varies wildly then estimates will be
> unreliable.
>
> I can vaguely imagine that it would be kind of useful to know the
> throughput of different data sources, to allow e.g. use a different
> mirror next time.  The current API doesn't distinguish work items in a
> meaningful way, though.  They only have numbers.  I'd need a name (e.g.
> the URL) for intra-item progress numbers to mean something.

Sure, anyway, let's assume all those numbers are magically known and
constant. The point was that as noted above you're downloading the 1st
file, not the 0th file, and want to show throughput/ETA etc. for that
file.
