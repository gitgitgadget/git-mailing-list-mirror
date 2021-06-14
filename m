Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EBAC49EA3
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB8861241
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhFNRUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:20:17 -0400
Received: from mout.web.de ([212.227.17.12]:58261 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhFNRUP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623691086;
        bh=UdOPr9akPaqSgxJTwaKXUnKepPQB0V0erqYg0mse714=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Em+ivdj64/uatObi4alN58w1H1ZLqZIQDFpk3+gNRDxt6SafUZLXF4wAZxEmgzZna
         nxaHpxCnoscQiAVkaXDmrpWf48+LSU/0kRukkOsPIKDX8WbX8kzsxSE7iI4tuHkqSp
         L6nktePu4L8+zin2Kvv0+oCJHlr+vff5bBU6R6VE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M9qd5-1lvsUq3rUL-005pno; Mon, 14 Jun 2021 19:18:05 +0200
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
 <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
 <87wnr4394y.fsf@evledraar.gmail.com>
 <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
 <87lf7k2bem.fsf@evledraar.gmail.com>
 <f5e181fc-af94-bccf-051f-a58a04fe1ffc@web.de>
 <87zgvszo8i.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4f251a35-8b5e-30f0-c742-960cb7c30b57@web.de>
Date:   Mon, 14 Jun 2021 19:18:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87zgvszo8i.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9HcKqrH1N6ZnTj5QRc0Od0XKWjLzC++vNGuXgM5/Ii/3J3Fyean
 chigeMa0RSSF37axQad3gFRHU3WedgtWoI2MPgiDT8ffcJ8WxRmgl/PhQtI1dLlshPRW0oo
 yoL/YTpW7S1u1+P6HdakNfsSpqU6Sg2lilVYneNRzJfiiFnXjqYCJI5nFNohTM4fJPdSUK3
 fnmJZwZ5x/4pC7nb3GvoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xt2UQ0UAj+Q=:3TB4xcc/N9T9+w/2GMptXJ
 6pD7fsZuD49ei5+V9Zv3M5BYmAtMP3F8r58ML1Ou+cE22ydNkz5soSWSS1LlAGnlufK2WwAM+
 azGzDOZ3Nkh2OW2DNvtvLPkmsq5/I13j46DGdcSdP5JvpvvejgLOtJFiuUwUU9S/Nsl/HlAzd
 djcdeuZ0U6RKN1i43Qpbcjg0dhyptqMNRnSXZlne2eAe5t9f4sssKDxIDLcHJEMPHEdz2ERLO
 +qhwAGsdF2E7jKqWVj1s3rzKC1jM3QhqOuYpMw8cmg7yt2ZqWzSoK/m6oR+S11Pq3s2WJutM6
 6OvKyMuflwVgj+j9yfrFiQ+2OAdmiqpBa7ePQSZucqa2DlQhi4b2v8doK+YtQ5s52jVthSCpW
 4woowhqANMK3pIFH9WrKwI7TjZKmcSM8yIkqb5ayfcf9HxZDCksmbpNwftHzZfM4BKA2UtciV
 m53B2HUQO145OuMMb5UNVTL+aSfAg54dtMG3NmjhJrIp38MVjbs538OyGZrJBuMr2a+EE0fhI
 7H85m35FdRyu54tIvV2FMnp+nkX4TBjz/kWB4vPXGkHffmXg1KCg2PNZHwJDc32cvWOtYBsyv
 tGkhFh9UbDOK+9okRFpfUxMq/7SZ9b4caQez4z6YcCTSpZ+nW5yUR6IBEKdWN51YLHCLkfSE/
 wAMvWCxKWM0xT7/3qLxwf9mm9ckj20Ng65oycGKKOkLjN+XlRascJcyplhvsIxEuC9mW8q2jW
 2sqxfqvgL72G5OXmppT2YgsM5WUVBlijN7vgjE3hITyAb2CQuN1PnM6/H5ZIHe0jDRbmibyTf
 0xf6frfLFeT/ERQLiu2YOcI5cPzc2tKbgYnYOaxJyrAubgRNB024apNIc0HQcbjgm45geGPIZ
 G3nsuqhQ+7fnjSQkJtsPTV6w0DUo9pCDj1memgKCgW4cfdKou6v3+pFYdeEIDdWQUIDFS0zld
 Q3zrOtJE7DliOkeit3w2FArG+wUTlNYYJL7oaaQwJldxc9aZqxD1aOakQa0g58o+G1clljGVy
 4JzuZHrmQKO6D5femln8H/a3NBC/sSp+fa2bG12VRc7sHFJIliPyRoEmk+MIwM57ND1/q8qFO
 XdvbhlME5BCe/mEkPiqKVU5bDObAdqbSrv/
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.21 um 13:07 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Jun 10 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 09.06.21 um 00:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Tue, Jun 08 2021, Ren=C3=A9 Scharfe wrote:
>>>
>>>> I wonder (only in a semi-curious way, though) if we can detect
>>>> off-by-one errors by adding an assertion to display_progress() that
>>>> requires the first update to have the value 0, and in stop_progress()
>>>> one that requires the previous display_progress() call to have a valu=
e
>>>> equal to the total number of work items.  Not sure it'd be worth the
>>>> hassle..
>>>
>>> That's intentional. We started eating 3 apples, got to one, but now ou=
r
>>> house is on fire and we're eating no more apples today, even if we
>>> planned to eat 3 when we sat down.
>>>
>>> The progress bar reflects this unexpected but recoverable state:
>>>
>>>     $ perl -wE 'for (0..1) { say "update"; say "progress $_" }' |
>>>       ./helper/test-tool progress --total=3D3 Apples 2>&1 |
>>>       cat -v | perl -pe 's/\^M\K/\n/g'
>>>     Apples:   0% (0/3)^M
>>>     Apples:  33% (1/3)^M
>>>     Apples:  33% (1/3), done.
>>>
>>> We're at 1/3, but we're done. No more apples.
>>>
>>> This isn't just some hypothetical, e.g. consider neeing to unlink() or
>>> remove files/directories one at a time in a directory and getting the
>>> estimated number from st_nlink (yeah yeah, unportable, but it was the
>>> first thing I thought of).
>>>
>>> We might think we're processing 10 entries, but another other processe=
s
>>> might make our progress bar end at more or less than the 100% we
>>> expected. That's OK, not something we should invoke BUG() about.
>>
>> It doesn't have to be a BUG; a warning would suffice.  And I hope not
>> finishing the expected number of items due to a catastrophic event is
>> rare enough that an additional warning wouldn't cause too much pain.
>
> It's not a catastrophic event, just a run of the mill race condition
> we'll expect if we're dealing with the real world.
>
> E.g. you asked to unlink 1000 files, we do so, we find 10 are unlinked
> already, or the command is asked to recursively unlink all files in a
> directory tree, and new ones have showed up.
>
> In those cases we should just just shrug and move on, no need for a
> warning. We just don't always have perfect information about future
> state at the start of the loop.

If a planned work item is cancelled then it can still be counted as
done.  Or the total could be adjusted, but that might look awkward.

>> Loops that *regularly* end early are not a good fit for progress
>> percentages, I think.
>
> Arguably yes, but in these fuzzy cases not providing a "total" means
> showing no progress at all, just a counter. Perhaps we should have some
> other "provide total, and it may be fuzzy" flag. Not providing it might
> run into your proposed BUG(), my point was that the current API
> providing this flexibility is intentional.

Your patch turns a loop that doesn't immediately report skipped items
into one with contiguous progress updates.  That's a good way to deal
with the imagined restrictions for error detection.  Another would be
to make the warnings optional.

>>> Similarly, the n=3D0 being distinguishable from the first
>>> display_progress() is actually useful in practice. It's something I've
>>> seen git.git emit (not recently, I patched the relevant code to emit
>>> more granular progress).
>>>
>>> It's useful to know that we're stalling on the setup code before the
>>> for-loop, not on the first item.
>>
>> Hmm, preparations that take a noticeable time might deserve their own
>> progress line.
>
> Sure, and I've split some of those up in the past, but this seems like
> ducking/not addressing the point that the API use we disagree on has
> your preferred use conflating these conditions, but mine does not...

Subtle.  If preparation takes a long time and each item less than that
then the progress display is likely to jump from "0/n" to "i/n", where
i > 1, and the meaning of "1/n" becomes moot.

The progress display could show just the title before the first
display_progress() call to make the distinction clear.  Would it really
be useful, though?  Perhaps a trace2 region started by the first
display_progress() call and ended by the last one (n =3D=3D total) would
be better.

>> Anyway, if no guard rails can be built then we have to rely on our math
>> skills alone.  Off-by-one errors may look silly, but are no joke -- the=
y
>> are surprisingly easy to make.
>
> ...which, regardless of whether one views a progress of "1/5 items" has
> "finished 1/5" or "working on 1/5", which I think *in general* is an
> arbitrary choice, I think the progress.c API we have in git.git clearly
> fits the usage I'm describing better.

How so?  start_progress() specifies a title and the total number of
items, display_progress() reports some other number that is shown in
relation to the total, and stop_progress() finishes the progress line.
This API is not documented and thus its meaning is (strictly speaking)
left unspecified.

It can be used to show a classic "percent-done progress indicator", as
https://dl.acm.org/doi/10.1145/1165385.317459 calls it.  That's how I
read a growing percentage shown by a program, and "done" I understand
as "has been done" (completed), not as "is being done".

Wikipedia sent me to
https://chrisharrison.net/projects/progressbars/ProgBarHarrison.pdf,
which has some fun ideas on how to warp the perception of time for
users staring at a progress bar, but also states typical ones grow
with the amount of completed work.

Ren=C3=A9
