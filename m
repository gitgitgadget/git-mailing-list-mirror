Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC85C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9698D6103B
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhKDRKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:10:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56096 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhKDRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 13:09:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98D6B1486B8;
        Thu,  4 Nov 2021 13:07:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=e+dlxvhvROAz
        0GLlINDmKIjCx/m7T7r9n09Ba20pOxw=; b=BsaWsW7Rnn5X8VJtwhJhOmUi+BJV
        pfFSLKpvaRNfMS0LcRaKyxX0ZiufGlB+HLD1z4E6HihBb5CicBF7n+nQgNwVmiMz
        aaBjtB1dwzOxodNu0XurxrT4uj3VgsvWiB+79jPQHKqhYB1f1ynUpFXiI6pcYB3N
        nd9+SHZdiujvKBw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90EC51486B7;
        Thu,  4 Nov 2021 13:07:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DE4A1486B6;
        Thu,  4 Nov 2021 13:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
        <YX5T+wt0hSkxkLHA@coredump.intra.peff.net>
        <211031.86a6ip47ib.gmgdl@evledraar.gmail.com>
        <YYJy4BuX6JI6p+aV@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2111040124430.56@tvgsbejvaqbjf.bet>
        <211104.86r1bwi6f7.gmgdl@evledraar.gmail.com>
Date:   Thu, 04 Nov 2021 10:07:16 -0700
In-Reply-To: <211104.86r1bwi6f7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 04 Nov 2021 10:46:28 +0100")
Message-ID: <xmqqtugr3l4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA850644-3D91-11EC-B656-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In this case I do think the change is justified. I've personally got a
> few local topics that I keep having to (even with rerere) solve
> conflicts for due to this list of files, and Junio deals with the same.
>
> Ditto for some of the changes I've made recently to make things
> non-.PHONY. That's resulted in major workflow improvements for me,

To me, I haven't noticed any workflow improvements for me, so I do
not see how my name got into the sentence.

> But in any case, the selling point of the original cmake integration wa=
s
> not something to the effect of:
>
>     "nobody should have to change this in anything but ever so this
>     re-implementation is a one-off"

I agree that this wasn't how it was sold, but ...

> But rather something like:
>
>     "This re-implementation is a one-off, but any updates to both shoul=
d
>     be trivial."

... I do not think this was how it was sold, either.  As far as I
recall, it was rather: this may double the maintenance burden, but
the reward to help casual Windows builders is large enough that
those who want to add the CMake support are willing to bear their
share of the burden.

> As someone who's had a couple of recent run-ins with cmake I can tell
> you it's really not trivial at all.

Surely.

> So given that the selling point of the original change didn't turn out
> as was expected I think it's fair to re-visit whether we'd like to take
> this path going forward, or to choose another trade-off.

OK.  The rest of the message I am responding to is your revisiting,
I guess.

>> The entire point of the CMake configuration is to allow developers on
>> Windows to use the tools they are used to, to build Git. And believe i=
t or
>> not, GNU make is not one of those tools! I know. Very hard to believe.=
 :-)
>
> I believe that, the question is why it isn't a better trade-off to just
> ask those users to install that software. Our Windows CI is doing it
> on-the-fly, so clearly it's not that hard to do it.
>
> Note that I'm not saying that whatever integration those users get in V=
S
> from the special-cause CMake integration should change. We're only
> talking about it invoking "make" under the hood in a way that'll be
> invisible to the user.
>
> POSIX "sh" isn't native to Windows either, and that CMake file invokes
> shellscripts we ship to e.g. build the generated headers, so this
> workflow is clearly something that's OK for an end-user once the one-of=
f
> hassle of installing a package is over with.
