Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D4C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D934D61926
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 08:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFZI3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 04:29:47 -0400
Received: from mout.web.de ([212.227.17.12]:34695 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZI3r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 04:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624696043;
        bh=Rr45RqrHuFWqx3foZRPhsVKDx+SqcKCdx+4fQUBxNo8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J50SQYcJ4pA2SS1o3yY8Eh2gfVB7Lg02vxscb/8NOO3ZPFGdzKoaGrO/jl14Kn9TK
         8NHso41/Qdqhgw1+m2mIhJ9x23gPUxXkle4HnEGqUhIXyZSTmNA2sx0PVqVI3S9ykD
         CzB25cd1ZQoTK497g+Ni2DHimT5IQh/r2HXS6EPs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Ltnmz-1lDzVm273V-0116lY; Sat, 26 Jun 2021 10:27:23 +0200
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
 <87a6nk41wy.fsf@evledraar.gmail.com>
 <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
 <87h7hr2cx0.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
Date:   Sat, 26 Jun 2021 10:27:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7hr2cx0.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:29YvVcDiyC1jbtBzboahvK1aTEVXRKsDY5id+pBg1ZVJhR7dFn9
 N4uDPnQN6oRGTGs5gGkoGr6s8CBgRgf1myOWvd24xzfuJWK3xWyu+v9HRnz0wQwB27sfpUA
 1mZdB5twk5gvB+RP2QMUqWye4thpcPOMMW3RVFzr3VZ92kkP0Ooa8hrRaykFspGhS5nT7UL
 hg5BwTO5dvbqL1jbil3jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a2fcLr67Dk4=:XR6MvgkDaGLhQXLta0wiKL
 t4MbzFYb2SBV51JEqAmrJnJ+kfK6CmXgoX6uHt6xfFRo9nu4MLqU9DnisLtWEqz42bloLdZHe
 aM6Hjts4v50kZ10jSMy427D4iBGxLn9VzIMEjtbLu2xB49Flng7L1KEkS+aVu23DD/K2JxjMI
 aU9zTXYd5aU5gzC3TMGp6fx7vEo80nOE+yDxe5Gsol2vZeS6rXp3FUx0aY6anH+66WmCh2FO/
 1ZwqcTiwJk9ElSLijE8bsYdLa9UdlBYEN6KmInnhYxPz/2X3/6crmVwpuc2dwvloOT0+lI7+P
 /qbka/tiezQlvsyYM1IUqqmwvmJUXrsZ19TlORFKN1LeOwtPiWxAZ/8DdRDgS/56GdbSKC0I5
 S6RBoLdDY+2F/O2FZ/py5YtaiIOsWAdCQDS2TdwK2LSxT+a/n0SQm4mcYNVgGEog3Bg10GNGP
 e5XhDkmzV4j7fK/we4qqnsOFUnOEoX9osylyI/KpsEpRBmJUvt+2cOz7tvn3aGJ1qc8tnoxWR
 O0mxOJ8PC/aeve71tlnT6fak9ZkGAw3JyO4Dnuk6nmYeRIgaBOquUw5/2yqLqN8fJ0e1kl0nT
 RZpf0hqNIVTla8GvJelxmEu0Ig9tDzJPFv8e0pr7MHYcYVwdghcH8JB9whnQ1OmeTfr5lAASw
 5nfppJfoYcbTwVzlaL0CRiFXKVQFey7PV/YLYbllT21QXm/RFUu1ad0ZW2bq993cQjG7sR1bT
 dSF014Zlm3XpSDvMU81YjlHczUNZZHLpvdexL444ojLAmfPZbHnqCxcbjm07udV8qXs9xzIbi
 tvkpfewnL6uIMcQTWDDq+ISgPUXoos8bu2oU8IaYD+mXe/DaojOll6XcLZwu/J+L0h5hIiZZ0
 l85nZtXLUSc8Cl7iiNToqOcAs8sk5q9qY/V6PNltdPwN/rnO6eUF6Fq3Rq/GdkbDOjAjwftkS
 35c1nfWQIX5PbzYNwU72wkctxUmI91BnQRaI8lQRBUMEw8oWhFZa2i0OGs3dfgY1O2hLbC53p
 0PoQrNriOETP3Tk7Gn5uTwQ7rTG8XufVzlGoMAZOJHqgKRJjfHbcRTzH0TEQ4m9GbeOsySicq
 sr80QKAVKVV9Zo4hxWFWvYIftKyxi2ViEdc
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.06.21 um 22:08 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Jun 21 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 21.06.21 um 00:13 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Sun, Jun 20 2021, SZEDER G=C3=A1bor wrote:
>>>
>>>> The final value of the counter of the "Scanning merged commits"
>>>> progress line is always one less than its expected total, e.g.:
>>>>
>>>>   Scanning merged commits:  83% (5/6), done.
>>>>
>>>> This happens because while iterating over an array the loop variable
>>>> is passed to display_progress() as-is, but while C arrays (and thus
>>>> the loop variable) start at 0 and end at N-1, the progress counter
>>>> must end at N.  This causes the failures of the tests
>>>> 'fetch.writeCommitGraph' and 'fetch.writeCommitGraph with submodules'
>>>> in 't5510-fetch.sh' when run with GIT_TEST_CHECK_PROGRESS=3D1.
>>>>
>>>> Fix this by passing 'i + 1' to display_progress(), like most other
>>>> callsites do.
>>>>
>>>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>>> ---
>>>>  commit-graph.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/commit-graph.c b/commit-graph.c
>>>> index 2bcb4e0f89..3181906368 100644
>>>> --- a/commit-graph.c
>>>> +++ b/commit-graph.c
>>>> @@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct=
 write_commit_graph_context *ctx)
>>>>
>>>>  	ctx->num_extra_edges =3D 0;
>>>>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>>>> -		display_progress(ctx->progress, i);
>>>> +		display_progress(ctx->progress, i + 1);
>>>>
>>>>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>>>>  			  &ctx->commits.list[i]->object.oid)) {
>>>
>>> I think this fix makes sense, but FWIW there's a large thread starting
>>> at [1] where Ren=C3=A9 disagrees with me, and thinks the fix for this =
sort of
>>> thing would be to display_progress(..., i + 1) at the end of that
>>> for-loop, or just before the stop_progress().
>>>
>>> I don't agree, but just noting the disagreement, and that if that
>>> argument wins then a patch like this would involve changing the other
>>> 20-some calls to display_progress() in commit-graph.c to work
>>> differently (and to be more complex, we'd need to deal with loop
>>> break/continue etc.).
>>>
>>> 1. https://lore.kernel.org/git/patch-2.2-042f598826-20210607T144206Z-a=
varab@gmail.com/
>>
>> *sigh*  (And sorry, =C3=86var.)
>>
>> Before an item is done, it should be reported as not done.  After an
>> item is done, it should be reported as done.  One loop iteration
>> finishes one item.  Thus the number of items to report at the bottom of
>> the loop is one higher than at the top.  i is the correct number to
>> report at the top of a zero-based loop, i+1 at the bottom.

> Anyone with more time than sense can go and read over our linked back &
> forth thread where we're disagreeing on that point :). I think the patte=
rn
> in commit-graph.c makes sense, you don't.

Thanks for this comment, I think I got it now: Work doesn't count in the
commit-graph.c model of measuring progress, literally.  I.e. progress is
the same before and after one item of work.  Instead it counts the
number of loop iterations.  The model I describe above counts finished
work items instead.  The results of the two models differ by at most one
despite their inverted axiom regarding the value of work.

Phew, that took me a while.

> Anyway, aside from that. I think, and I really would be advocating this
> too, even if our respective positions were reversed, that *in this case*
> it makes sense to just take something like SZEDER's patch here
> as-is. Because in that file there's some dozen occurrences of that exact
> pattern.

The code without the patch either forgets to report the last work item
in the count-work-items model or is one short in the count-iterations
model, so a fix is needed either way.

The number of the other occurrences wouldn't matter if they were
buggy, but in this case they indicate that Stolee consistently used
the count-iterations model.  Thus using it in the patch as well makes
sense.

> Let's just bring this one case in line with the rest, if we then want to
> argue that one or the other use of the progress.c API is wrong as a
> general thing, I think it makes more sense to discuss that as some
> follow-up series that changes these various API uses en-masse than
> holding back isolated fixes that leave the state of the progress bar it
> !=3D 100%.

Agreed.

Ren=C3=A9
