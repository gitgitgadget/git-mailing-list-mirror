Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A8C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 12:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4D3613E0
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 12:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhGDMSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 08:18:12 -0400
Received: from mout.web.de ([212.227.17.11]:59265 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhGDMSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 08:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625400935;
        bh=KLOGhsWJy+l3RKgOLoF/4irnl+DSscVT07JWV6sOkwA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=m0mOY8MP5RGMQT8cOV7DgRpfgqLdPdaHgTOccDv35gIWXcONnluhKZd9dzrPKYFvN
         FovsZwaWKx8kCihSoVg8JRhDP2Z0QU1yVh1i391DAzEFtnKH8TxKGUUPrvaDM3vb8q
         hh8QG55ZlOqSgic3jEC9GOLBXf3DC0AGfDRxWd6E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Mv3Yg-1l99Og3RlA-00r37d; Sun, 04 Jul 2021 14:15:34 +0200
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
 <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
 <87a6ncy9aq.fsf@evledraar.gmail.com>
 <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
 <874kdkxot4.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ca3eba46-7c83-51fd-2d65-c55309ac7182@web.de>
Date:   Sun, 4 Jul 2021 14:15:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <874kdkxot4.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R83EfQb3q2l99J6akIf3iHQJEPBR7E+5I4dmtleDUi9JlIDEwld
 t9W2f3bgEbqAFtNzWOcPQDPwYhh1QZi6axPXaZ1+YikuWV3uGSD5QcRAo3v5vVgdC6XQOWF
 4z/yziB5G2/LmmV+hrMEQDwhj2ylW7oI/qw4NrLW3C0CZLqdI08AqjJOMs5u9UDyNp0VXnP
 PfdkmXjBCoPEUJPyLIt6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xpCqgmrM31A=:r18yppG1pOX5zCAocrOhKV
 HoY6nsdZ/H5fXTS/y7Kz37CTO8Ibj3auovuM4mZECv6K092DvsBKxmzO+6gvG+UeTlv7i8ulR
 CLB6C+3PPE8dHK/+KpYWFKl0PtlWd06Ww57gWEgwtHGeVRIuO2nqnkJB76Au2H7XhaXODdmMP
 rBkRWCrAy3aLlazi7EUw99WSu1Gpg5U1APltj48qH6ZJK/UATCmVfTBblwniqpIzR67TLNNOv
 OG6NZR6c93bCTCdJjh8mDGaZ7f3dEeaTAiNctgA8ufDdXp3kowb6PcN2XuOqh46WbyKZcKNQW
 0wpYSrEL3KSbydh4wVJgE5D6P95WN+eaHi/UenKEws6RRBfrPYZDehLe1GNIg/eaLzAzO1aGv
 JAx1ei7plBpFYrmwyShV3F8BjfXs1517U6f9ETNcoOZ/8dcf/2yKNV36ToDojCRP2p9QRb4pf
 sWxXjKNsZSDsfaCY6IKYhiG/HYb1Rbd86ABnQK2EZQ1UkQ1S8GQp79s4WJHVqvDfk9sJKFUmm
 JCd1lsBCuzvnFgBouJwmKfb5UbnIpXKp+v7uXkJupwAekxJWGvDMqCRpLIb5hhMm9Oc7Ja8tA
 L7plbDUEZ0YVqiWAyssnQxEQpKR+xDWY45tiZMMW02hAzNOws3HbZBk7EIXj4KvTHpaZID5tE
 X4c2FzWTujmvgQxZJmHNaHbo4bD4ATAHbLvs74dacwslOPxDRKlIPkrIPGbvNRrA13hf3TV99
 VxTZKyaVgRh+phA4bci2q9Y59ToXj0pAQDK6xcpbFqlGoX6v6Pu3Opkm1WB9LnqvK/GzXd6+N
 zViK59U1Xm9twblaQJ71yZ5XxGLgRyGh7FVdErNeEU8EGJGfnDEI1/o2rc0mSTCWl5wTYhvQE
 yoTUxy+YMzLTDCsuiSW2tAAkSMsFBAeiJpf0spldzHU6IwcdyTwYW4X6Leq2p/gnxJS+YSanJ
 Xs1mSYXXsgCu1d9oikUN8JMf9v9vlPCnGVGib86+lsK2emxSzP8AA1M92QqElnsxf0olE1+vH
 Jk4IcAT9+a3OdoaGFcmb4EesXs1acFzpgPVvE7ghpyX4iQYseLmDyl4Am9CaeeZ35fdYpL7do
 M6KF9hwCqaaLgNFQqDIourNARKt/DCq6SIp
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.06.21 um 23:38 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Jun 26 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 26.06.21 um 16:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> [...]
>>> To reference my earlier E-Mail[1] are you eating the first apple or th=
e
>>> zeroeth apple? I don't think one is more or less right in the
>>> mathematical sense, I just think for UX aimed at people counting "laps=
"
>>> makes more sense than counting completed items.
>>
>> The difference between counting iterations and work items vanishes as
>> their numbers increase.  The most pronounced difference is observed whe=
n
>> there is only a single item of work.  The count-iterations model shows
>> 1/1 from start to finish.  The count-work model shows 0/1 initially and
>> 1/1 after the work is done.
>>
>> As a user I prefer the second one.  If presented with just a number and
>> a percentage then I assume 100% means all work is done and would cancel
>> the program if that status is shown for too long.  With Git I have
>> learned that only the final ", done" really means done in some cases,
>> but that's an unnecessary lesson and still surprising to me.
>
> What progress bar of ours goes slow enough that the difference matters
> for you in either case?

I don't have an example -- Git, network and SSD are quick enough for my
small use cases.

The advantage of the count-work method is that the question doesn't even
come up.

> The only one I know of is "Enumerating objects", which notably stalls at
> the start, and which I'm proposing changing the output of in:
> https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-ava=
rab@gmail.com/

That's annoying, but the first number I see there has five or six digits,
so it's not an example of the issue mentioned above for me.

Your patch shows ", stalled." while pack-objects starts up.  I'm not sure
this helps.  Perhaps there are cases when it gets stuck, but it's hard to
determine by the clock alone.  When I run gc, it just needs a few seconds
to prepare something and then starts visibly counting objects.  A more
fine-grained report of the preparation steps would help, but seeing
"stalled" would just scare me.

>> The count-work model needs one more progress update than the
>> count-iteration model.  We could do all updates in the loop header,
>> which is evaluated just the right number of times.  But I think that we
>> rather should choose between the models based on their results.
>
> I think we should be more biased towards API convenience here than
> anything else, because for most of these they'll go so fast that users
> won't see the difference. I just also happen to think that the easy way
> to do it is also more correct.

The convenience of having one less display_progress() call is only a
slight advantage.

Correctness is a matter of definitions.  Recently I learned that in Arabic
a person's age is given using the count-iterations model.  I.e. on the day
of your birth your age is one.  That causes trouble if you deal with
state officials that use the count-work, err, count-completed-years model,
where your age is one only after living through a full year.

The solution around here is to avoid ambiguity by not using terms like
"age" in laws, regulations and forms, but to state explicitly "full years
since birth" or so.

"2/3 (33%)" means something else to me than to you by default.  So a
solution could be to state the model explicitly.  I.e. "2/3 (66%) done"
or "working on 2/3 (66%)", but the percentage doesn't quite fit in the
latter case.  Thoughts?

> Also, because for these cases that you're focusing on where we count up
> to exactly 100% and we therefore expect N calls to display_progress()
> (igroning the rare but allowed duplicate calls with the same number,
> which most callers don't use). We could just have a convenience API of:
>
>     start_progress()
>     for i in (0..X-1):
>         progress_update() /* passing "i" not needed, we increment intern=
ally */
>         work()
>     stop_progress()
>
> Then we could even make showing 0/N or 1/N the first time configuable,
> but we could only do both if we use the API as I'm suggesting, not as
> you want to use it.

A function that increments the progress number relatively can be used
with both models.  It's more useful for the count-iterations model,
though, as in the count-work model you can piggy-back on the loop
counter check:

	for (i =3D 0; display_progress(p, i), i < X; i++)
		work();

> You also sort of can get me what I want with with what you're
> suggesting, but you'd conflate "setup" work with the first item, which
> matters e.g. for "Enumerating objects" and my "stalled" patch. It's also
> more verbose at the code level, and complex (need to deal with "break",
> "continue"), so why would you?

It's not complicated, just slightly odd, because function calls are
seldomly put into the loop counter check.

>> If each work item finishes within a progress display update period
>> (half a second) then there won't be any user-visible difference and
>> both models would do.
>
> A trivial point, but don't you mean a second? AFAICT for "delayed" we
> display after 2 seconds, then update every 1 seconds, it's only if we
> have display_throughput() that we do every 0.5s.

Right, I mixed those up.

>>> The other is that if you count laps you can have your progress bar
>>> optionally show progress on that item. E.g. we could if we stall show
>>> seconds spend that we're hung on that item, or '3/3 ETA 40s". I have a
>>> patch[3] that takes an initial step towards that, with some more queue=
d
>>> locally.
>>
>> A time estimate for the whole operation (until ", done") would be nice.
>> It can help with the decision to go for a break or to keep staring at
>> the screen.  I guess we just need to remember when start_progress() was
>> called and can then estimate the remaining time once the first item is
>> done.  Stalling items would push the estimate further into the future.
>>
>> A time estimate per item wouldn't help me much.  I'd have to subtract
>> to get the number of unfinished items, catch the maximum estimated
>> duration and multiply those values.  OK, by the time I manage that Git
>> is probably done -- but I'd rather like to leave arithmetic tasks to
>> the computer..
>>
>> Seconds spent for the current item can be shown with both models.  The
>> progress value is not sufficient to identify the problem case in most
>> cases.  An ID of some kind (e.g. a file name or hash) would have to be
>> shown as well for that.  But how would I use that information?
>
> If we're spending enough time on one item to update progress for it N
> times we probably want to show throughput/progress/ETA mainly for that
> item, not the work as a whole.

Throughput is shown for the last time period.  It is independent of the
item or items being worked on during that period.  If one item takes
multiple periods to finish then indeed only its current progress is
shown automatically, as you want.

Showing intra-item progress requires some kind of hierarchical API to
keep track of both parent and child progress and show them in some
readable way.  Perhaps appending another progress display would suffice?
"Files 1/3 (33%) Bytes 17kB/9GB (0%)".  Not sure.

Calculating the ETA of a single item seems hard.  It does require intra-
item progress to be reported by the work code.

> If we do run into those cases and want to convert them to show some
> intra-item progress we'd need to first migrate them over to suggested
> way of using the API if we picked yours first, with my suggested use we
> only need to add new API calls (display_throughput(), and similar future
> calls/implicit display).

I don't see why.  The intra-item progress numbers need to be reported in
any case if they are to be shown somehow.  If the model is clear then we
can show unambiguous output.

> Consider e.g. using the packfile-uri response to ask the user to
> download N number of URLs, just because we grab one at 1MB/s that
> probably won't do much to inform our estimate of the next one (which may
> be on a different CDN etc.).

Sure, if the speed of work items varies wildly then estimates will be
unreliable.

I can vaguely imagine that it would be kind of useful to know the
throughput of different data sources, to allow e.g. use a different
mirror next time.  The current API doesn't distinguish work items in a
meaningful way, though.  They only have numbers.  I'd need a name (e.g.
the URL) for intra-item progress numbers to mean something.

Ren=C3=A9
