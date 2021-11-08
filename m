Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2BC433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08701619BB
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhKHUEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:04:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51187 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhKHUEp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:04:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 806EC168ED9;
        Mon,  8 Nov 2021 15:02:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RJ9rkZpUjyrM
        gwqVohi9r8gfCZK6oHRS5s0hSEVWKzI=; b=ckuZs0bj+zgwWg+4pSeQGozjC0JD
        rIDyNc94+Xc5asvrh/ohIIvrLIKWMwk8go10spSTMymsNstvmVmPH6bJlss+JqA1
        RX2MmhCuBdZlz4gP9l0Kk92OfXe3yRAzOsXlFTsi8SBMG76BfTSJfFqmNgQ3xkyR
        vnEA1xNxqFb2JKU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75931168ED8;
        Mon,  8 Nov 2021 15:02:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9C68168ED7;
        Mon,  8 Nov 2021 15:01:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Maksym Sobolyev <sobomax@gmail.com>, git@vger.kernel.org,
        Maksym Sobolyev <sobomax@sippysoft.com>
Subject: Re: ms/customizable-ident-expansion
References: <xmqqr1c3e57a.fsf@gitster.g>
        <211101.86fssf3bn3.gmgdl@evledraar.gmail.com>
        <xmqqr1bzbp69.fsf@gitster.g>
        <CABFYoQA82u8Um6L439_bU4a+WpkdXOcbU8foPjqnVw+4MnNU0A@mail.gmail.com>
        <211108.864k8mfocg.gmgdl@evledraar.gmail.com>
Date:   Mon, 08 Nov 2021 12:01:56 -0800
In-Reply-To: <211108.864k8mfocg.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 08 Nov 2021 20:14:23 +0100")
Message-ID: <xmqqwnlito0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BA71E848-40CE-11EC-B1F7-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Nov 07 2021, Maksym Sobolyev wrote:
>
>> Junio, well it works and passes Occam Razor test. I even added a
>> reasonable number of test cases. As I tried to explain at least once,
>> having it per-directory might be advantageous, if the project pulls
>> sources from all different places where you might "mute" ID
>> replacement for certain parts of the tree or use a different one. Most
>> of that would have to be thrown away if the feature is to be reworked
>> to your liking.
>
> Yes, isn't there also a practical use for this in the source trees of
> the various *BSDs who import each other's sources (but I don't know if
> it's useful for that).

What are the users trying to record with that, though?  If FreeBSD
source tree wants to keep the sign that some things originated from
OpenBSD, wouldn't they want to keep the OpenBSD marking intact?  At
that point, storing $OpenBSD$ and expanding to $OpenBSD: <blob>$ is
not what they want, as the object name will keep changing.

Also, these users need to be aware which path uses what identifier
by looking at .gitattributes and what the ident attribute says.  If
you add $Id$ to a new file, but the .gitattribute entry that covers
it says $FreeBSD$ will be the one expanded for that file, nothing
will happen until you realize your mistake.  I am hesitant to adopt
that proposal because dealing with that kind of confusion is not
something worth spending time of developers (I mean those who have
to figure out and decide between $Id$ and $FreeBSD$, not the
developer cycle of Git project).

So...

