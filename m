Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58724C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C7561C30
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 14:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFZOr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZOr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 10:47:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429BFC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 07:45:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hz1so20124824ejc.1
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1HU4hRr+3gQA3yHE7rRMwjgKOmNQrOIaKXMjmOKiQcU=;
        b=F+k45P3qCheBgr8RlK88QH9NwLGTEIUWhUldcFPLCdhHdEGT6wt0DqOfkVBEDGUbf8
         dg46EHnEIkp8E1JfwZWtkGUgQODfSmDW8NxK1n7Nsfd3NqKlfVG2x1V3HqZ8ebvvXmmq
         8pWCGO0vVNtOT4LUZTtKkZiB3TALU5PNDXnGqypZy6XY4bC+GxDohhAElv/SBxhoJsTv
         ndeOKCNNDmp9VrfyEbRk0GpXhguv0qfF1IqY/Xa7d6/I0jFxDUTsmhDBVe/mk0rKs8Iy
         m7scRHnqccPqPUOYh0c9rgEoo+n398xNb7xe0goFsJdzOlAMCQiZN1TJCCz13fQz2YlW
         woMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1HU4hRr+3gQA3yHE7rRMwjgKOmNQrOIaKXMjmOKiQcU=;
        b=eojop/rtqWc7jgy7gjsq5miAJShoyTEfapjnCfWSc5JDg0Pxze2r58OzHX1PLZ1cjW
         qVUpVpvgTMaTrWSK+ngLK1lKgleTy2SMUfm1BRwUOrrfNEK3a6hz9sNnQerX8F/DF09u
         hNe0niKulgeDUqZPT1FctZFlNE3k6o+q2gdWgUF7NtAaHRk2p59D5mZtnLZfmEIqiQur
         q1RSRGW+RsAISYju3KfpLTEuPSGWY7iWivAme1gPGEX3oeeijIkG8dYDDd5jkm/Hcbeb
         2HWc8+L13fABudjzq8xTmOvABFlJuWSgaJZXHA8VB3jfaTZkKnZ2ldnM4jm+1PFFmkz3
         14Dg==
X-Gm-Message-State: AOAM530tYcC79y+81F4srkU/HGmQA2b8SbZ0UFD/bQJ+FPnjlLOgDzkN
        qkeEAIIaSVjiDG9OX1dkPhg=
X-Google-Smtp-Source: ABdhPJx76Jr4wqk0D3N1Op2bel92to656EuxrMjJyXbb2WIjcpAiP0pMlZ0hMQ8z4o0adg/dczw3Dg==
X-Received: by 2002:a17:906:89a3:: with SMTP id gg35mr16626898ejc.188.1624718702637;
        Sat, 26 Jun 2021 07:45:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x17sm6215500edl.58.2021.06.26.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 07:45:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
Date:   Sat, 26 Jun 2021 16:11:31 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
 <87a6nk41wy.fsf@evledraar.gmail.com>
 <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
 <87h7hr2cx0.fsf@evledraar.gmail.com>
 <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
Message-ID: <87a6ncy9aq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 26 2021, Ren=C3=A9 Scharfe wrote:

> Am 21.06.21 um 22:08 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Mon, Jun 21 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 21.06.21 um 00:13 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> On Sun, Jun 20 2021, SZEDER G=C3=A1bor wrote:
>>>>
>>>>> The final value of the counter of the "Scanning merged commits"
>>>>> progress line is always one less than its expected total, e.g.:
>>>>>
>>>>>   Scanning merged commits:  83% (5/6), done.
>>>>>
>>>>> This happens because while iterating over an array the loop variable
>>>>> is passed to display_progress() as-is, but while C arrays (and thus
>>>>> the loop variable) start at 0 and end at N-1, the progress counter
>>>>> must end at N.  This causes the failures of the tests
>>>>> 'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
>>>>> in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=3D1.
>>>>>
>>>>> Fix this by passing 'i + 1' to display_progress(), like most other
>>>>> callsites do.
>>>>>
>>>>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>>>> ---
>>>>>  commit-graph.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/commit-graph.c b/commit-graph.c
>>>>> index 2bcb4e0f89..3181906368 100644
>>>>> --- a/commit-graph.c
>>>>> +++ b/commit-graph.c
>>>>> @@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct=
 write_commit_graph_context *ctx)
>>>>>
>>>>>  	ctx->num_extra_edges =3D 0;
>>>>>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>>>>> -		display_progress(ctx->progress, i);
>>>>> +		display_progress(ctx->progress, i + 1);
>>>>>
>>>>>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>>>>>  			  &ctx->commits.list[i]->object.oid)) {
>>>>
>>>> I think this fix makes sense, but FWIW there's a large thread starting
>>>> at [1] where Ren=C3=A9 disagrees with me, and thinks the fix for this =
sort of
>>>> thing would be to display_progress(..., i + 1) at the end of that
>>>> for-loop, or just before the stop_progress().
>>>>
>>>> I don't agree, but just noting the disagreement, and that if that
>>>> argument wins then a patch like this would involve changing the other
>>>> 20-some calls to display_progress() in commit-graph.c to work
>>>> differently (and to be more complex, we'd need to deal with loop
>>>> break/continue etc.).
>>>>
>>>> 1. https://lore.kernel.org/git/patch-2.2-042f598826-20210607T144206Z-a=
varab@gmail.com/
>>>
>>> *sigh*  (And sorry, =C3=86var.)
>>>
>>> Before an item is done, it should be reported as not done.  After an
>>> item is done, it should be reported as done.  One loop iteration
>>> finishes one item.  Thus the number of items to report at the bottom of
>>> the loop is one higher than at the top.  i is the correct number to
>>> report at the top of a zero-based loop, i+1 at the bottom.
>
>> Anyone with more time than sense can go and read over our linked back &
>> forth thread where we're disagreeing on that point :). I think the patte=
rn
>> in commit-graph.c makes sense, you don't.
>
> Thanks for this comment, I think I got it now: Work doesn't count in the
> commit-graph.c model of measuring progress, literally.  I.e. progress is
> the same before and after one item of work.

The progress isn't the same, we update the count. Or do you mean in the
time it takes us to go from the end of the for-loop & jump to the start
of it and update the count?

> Instead it counts the number of loop iterations.  The model I describe
> above counts finished work items instead.  The results of the two
> models differ by at most one despite their inverted axiom regarding
> the value of work.
>
> Phew, that took me a while.

For what it's worth I had some extensive examples in our initial
thread[1][2] (search for "apple" and "throughput", respectively), that
you cut out when replying to the relevant E-Mails. I'd think we could
probably have gotten here earlier :)

I'm a bit confused about this "value of work" comment.

If you pick up a copy of say a video game like Mario Kart you'll find
that for a 3-lap race you start at 1/3, and still have an entire lap to
go when the count is at 3/3.

So it's just a question of whether you report progress on item N or work
finished on item N, not whether laps in a race have more or less
value.

To reference my earlier E-Mail[1] are you eating the first apple or the
zeroeth apple? I don't think one is more or less right in the
mathematical sense, I just think for UX aimed at people counting "laps"
makes more sense than counting completed items.

>> Anyway, aside from that. I think, and I really would be advocating this
>> too, even if our respective positions were reversed, that *in this case*
>> it makes sense to just take something like SZEDER's patch here
>> as-is. Because in that file there's some dozen occurrences of that exact
>> pattern.
>
> The code without the patch either forgets to report the last work item
> in the count-work-items model or is one short in the count-iterations
> model, so a fix is needed either way.

It won't be one short, for a loop of 2 items we'll go from:

     0/2
     1/2
     1/2, done

To:

     1/2
     2/2
     2/2, done

Just like the rest of the uses of the progress API in that file.

Which is one of the two reasons I prefer this pattern, i.e. this is less
verbose:

    start_progress()
    for i in (0..X-1):
        display_progress(i+1)
        work()
    stop_progress()

Than one of these, which AFAICT would be your recommendation:

    # Simplest, but stalls on work()
    start_progress()
    for i in (0..X-1):
        work()
        display_progress(i+1)
    stop_progress()

    # More verbose, but doesn't:
    start_progress()
    for i in (0..X-1):
        display_progress(i)
        work()
        display_progress(i+1)
    stop_progress()

    # Ditto:
    start_progress()
    display_progress(0)
    for i in (0..X-1):
        work()
        display_progress(i+1)
    stop_progress()

And of course if your loop continues or whatever you'll need a last
"display_progress(X)" before the "stop_progress()".

The other is that if you count laps you can have your progress bar
optionally show progress on that item. E.g. we could if we stall show
seconds spend that we're hung on that item, or '3/3 ETA 40s". I have a
patch[3] that takes an initial step towards that, with some more queued
locally.

> The number of the other occurrences wouldn't matter if they were
> buggy, but in this case they indicate that Stolee consistently used
> the count-iterations model.  Thus using it in the patch as well makes
> sense.

>> Let's just bring this one case in line with the rest, if we then want to
>> argue that one or the other use of the progress.c API is wrong as a
>> general thing, I think it makes more sense to discuss that as some
>> follow-up series that changes these various API uses en-masse than
>> holding back isolated fixes that leave the state of the progress bar it
>> !=3D 100%.
>
> Agreed.

Sorry to go on about this again :)

1. https://lore.kernel.org/git/87lf7k2bem.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87o8c8z105.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-ava=
rab@gmail.com/
