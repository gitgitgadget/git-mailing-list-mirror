Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B3DC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BACC61584
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 15:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhFOPQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:16:18 -0400
Received: from mout.web.de ([212.227.15.4]:40083 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhFOPQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 11:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1623770048;
        bh=HwODwdrdjGKAGJ/E4QLk1Y7v3GSnLjLKZQRcYwPIQ5A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fdlMArTzZ/LJuQDUc4lX/A9894B7FeAe0gJghHl74rgxmh1loKjNRZoMEsZ8sUevP
         yy6iXKv33qlsalT4x8BUauZKlGIm6UqRoyOSGS0kz57E5M2Gdcj0CON2wstBhOTqI6
         1K4DtYJSVMPwEJhjcrd6SHOPWw8hLIWiYQukSuX8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M6Df8-1l4wV01ioM-00y5L4; Tue, 15 Jun 2021 17:14:08 +0200
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
 <4f251a35-8b5e-30f0-c742-960cb7c30b57@web.de>
 <87o8c8z105.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <34d5febf-508c-52b8-a04b-98298d75bd8d@web.de>
Date:   Tue, 15 Jun 2021 17:14:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87o8c8z105.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aOaTLCbwA5a8FE1ldScBrb60xhNXE758OZnCwUYSjolvQFrqy/h
 Zk51FLOCbwaDz5OUdAUw6Bmn1QOboz5unDrJByiNHAo8DxRp9O8fYGb1qQ0TjlA7jr2pqjF
 N5x0LpmeT9gtLdGoV3R/xsos76lsvOnz/RbJg01nThL8V2RiEtxYoEsS+5LQ8TIOLS4l2es
 eNHb30ihlOncr99MgwH0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:anEFVa6dCP0=:RI6gEiLwN0fGzcC+Q9Z8tS
 uuYeSz6Hh5ohECpqyR3rW8dyt6t6MHZfhD7hS4uGhSJNNMFkJwxOgFIyTizeVBg7J39yGha1w
 x57KMTSag/fMEUKmFtG9u+jFbGVboHDGTQMdNViuKcYD0BNWUxegqQ4t9tiidKoKipI+pPkWq
 I+g4ItqHow//ULd6HoVobLQT8mk250uWUysGqmPevbUUpeADn7s2xUd2wL3ewMacrOJmtr1ZX
 waxH9FdwQikSz8bxfbgwB6YrjWZKn7OK+eK5l6c8jCwm3Z4dsqUX6Mj291e7ZtN/75MFP5r9y
 hjC2IH9JLgMeTz2QkamK6z7OVjVEzV3utKtqmKIKYtMQQ8TrtEgPZ1uzEFhqeIDMz1d/wW22W
 FNkoUI8AzUoBdXfAiENlVRGWj1jya/r7QST1ArVyHCjUL8u/mnu/ht1kpV+Frd8r4VHyPg1Az
 yjiPX+BU7v0glVyKAz04pGSVvraaYYLdJ41DM1Mod8EGi6TeYgNRYPEVxawhrk8JoZsKvFnb7
 9ARJ4d22LrQjPa/NryatjNRJqN8dGBr/TP6ZE1GA0sgP9xxNuzCl5spNO+drysBneUUuUBYxb
 +IdrSlbiuOrjJMlU77A7d0Knq0Z+S2G1Yp2kiI9vz27GgIJmT0yLPzlkToDOi1Vmd41banyAu
 khm2XSzBsu/Sg2fo/23GFcXq9ENkixTyErzUdN+AGg5VgwAJ8UsJdS/GaiM4va/1Dok8cXsmt
 0pVNJbipL3sYVmuT4/36AUJRNeJYUc+ksVMJ4Iz4OzL0Fk+HhJkZoQ2bU+00ZBIPdevf2qYp6
 kj0kd2EehGpS1W+5G+Em8moGHoye1Y8DpAX4OqrxRUnq2MExjftJuJkv5g1Q6351/3W6dWRAM
 rnDbniAwgVPTpaEcuSRIkFOoE1SnqNqaKnOXP419D2ej+UNCkcnU7CfWBlA+QllP+/vTMdlRk
 gpV48TPLOcUdCJ+FHM/0XHaXR1zhiTLMxCrkLQHSF4Xy+yBF5zSrhjGmmW1VSEWcHHhIBBFll
 SL3UYGjyEIxPEM6NNG7TrTs5/sEk6I+v00QtuTwo/loOPwZ7zzHfMVXsIpnhST2gxcR4jrsmo
 AESQgXvxG1fzBi2w/6S+D6JpX81ll0vGoRu
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.21 um 21:08 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Jun 14 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 14.06.21 um 13:07 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Thu, Jun 10 2021, Ren=C3=A9 Scharfe wrote:
>>>
>>>> Am 09.06.21 um 00:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>>
>>>>> On Tue, Jun 08 2021, Ren=C3=A9 Scharfe wrote:
>>>>>
>>>>>> I wonder (only in a semi-curious way, though) if we can detect
>>>>>> off-by-one errors by adding an assertion to display_progress() that
>>>>>> requires the first update to have the value 0, and in stop_progress=
()
>>>>>> one that requires the previous display_progress() call to have a va=
lue
>>>>>> equal to the total number of work items.  Not sure it'd be worth th=
e
>>>>>> hassle..
>>>>>
>>>>> That's intentional. We started eating 3 apples, got to one, but now =
our
>>>>> house is on fire and we're eating no more apples today, even if we
>>>>> planned to eat 3 when we sat down.
>>>>>
>>>>> The progress bar reflects this unexpected but recoverable state:
>>>>>
>>>>>     $ perl -wE 'for (0..1) { say "update"; say "progress $_" }' |
>>>>>       ./helper/test-tool progress --total=3D3 Apples 2>&1 |
>>>>>       cat -v | perl -pe 's/\^M\K/\n/g'
>>>>>     Apples:   0% (0/3)^M
>>>>>     Apples:  33% (1/3)^M
>>>>>     Apples:  33% (1/3), done.
>>>>>
>>>>> We're at 1/3, but we're done. No more apples.
>>>>>
>>>>> This isn't just some hypothetical, e.g. consider neeing to unlink() =
or
>>>>> remove files/directories one at a time in a directory and getting th=
e
>>>>> estimated number from st_nlink (yeah yeah, unportable, but it was th=
e
>>>>> first thing I thought of).
>>>>>
>>>>> We might think we're processing 10 entries, but another other proces=
ses
>>>>> might make our progress bar end at more or less than the 100% we
>>>>> expected. That's OK, not something we should invoke BUG() about.
>>>>
>>>> It doesn't have to be a BUG; a warning would suffice.  And I hope not
>>>> finishing the expected number of items due to a catastrophic event is
>>>> rare enough that an additional warning wouldn't cause too much pain.
>>>
>>> It's not a catastrophic event, just a run of the mill race condition
>>> we'll expect if we're dealing with the real world.
>>>
>>> E.g. you asked to unlink 1000 files, we do so, we find 10 are unlinked
>>> already, or the command is asked to recursively unlink all files in a
>>> directory tree, and new ones have showed up.
>>>
>>> In those cases we should just just shrug and move on, no need for a
>>> warning. We just don't always have perfect information about future
>>> state at the start of the loop.
>>
>> If a planned work item is cancelled then it can still be counted as
>> done.  Or the total could be adjusted, but that might look awkward.
>>
>>>> Loops that *regularly* end early are not a good fit for progress
>>>> percentages, I think.
>>>
>>> Arguably yes, but in these fuzzy cases not providing a "total" means
>>> showing no progress at all, just a counter. Perhaps we should have som=
e
>>> other "provide total, and it may be fuzzy" flag. Not providing it migh=
t
>>> run into your proposed BUG(), my point was that the current API
>>> providing this flexibility is intentional.
>>
>> Your patch turns a loop that doesn't immediately report skipped items
>> into one with contiguous progress updates.  That's a good way to deal
>> with the imagined restrictions for error detection.  Another would be
>> to make the warnings optional.
>
> I don't see how there's anything wrong with the API use, how it needs a
> warning etc.

You pointed out that many callsites do:

	for (i =3D 0; i < large_number; i++) {
		display_progress(p, i + 1);
		/* work work work */
	}

This is an off-by-one error because a finished item is reported before
work on it starts.  Adding a warning can help find these cases reliably.

>>>>> Similarly, the n=3D0 being distinguishable from the first
>>>>> display_progress() is actually useful in practice. It's something I'=
ve
>>>>> seen git.git emit (not recently, I patched the relevant code to emit
>>>>> more granular progress).
>>>>>
>>>>> It's useful to know that we're stalling on the setup code before the
>>>>> for-loop, not on the first item.
>>>>
>>>> Hmm, preparations that take a noticeable time might deserve their own
>>>> progress line.
>>>
>>> Sure, and I've split some of those up in the past, but this seems like
>>> ducking/not addressing the point that the API use we disagree on has
>>> your preferred use conflating these conditions, but mine does not...
>>
>> Subtle.  If preparation takes a long time and each item less than that
>> then the progress display is likely to jump from "0/n" to "i/n", where
>> i > 1, and the meaning of "1/n" becomes moot.
>
> In practice we're making humongous jumps all over the place, we don't
> write to the terminal for every item processed, and if we did it would
> be too fast to be perceptable to the user.
>
> So I don't think this is an issue in the first place, as noted upthread
> in <8735tt4fhx.fsf@evledraar.gmail.com>. Regardless of what we think of
> the supposed off-by-one issue you seemed to think that it was enough of
> an issue to justify complexity at the API use level (needing to think
> about "continue" statements in loops, etc.), but now you think it's
> moot?

I don't understand your question.  Let me rephrase what I find moot:

You wrote that the first display_progress() call being made with n>0
would be useful to you to see long-running preparations.  If items are
processed quicker than one per second, then whatever number the first
display_progress() call writes to the screen will be overwritten within
a second.  So the value of the first update shouldn't actually matter
much for your use case -- unless items takes a long time to process.

Ren=C3=A9
