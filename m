Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F4C11F6A
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D21613FE
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 16:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhGBQHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 12:07:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50912 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBQHz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 12:07:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D42F514CE44;
        Fri,  2 Jul 2021 12:05:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x0uZR/g/dRX1
        xlQd7jsdBasqYpQWXuXt9pRuZ2TwoJk=; b=nyjz7E49650czlXBBKbBNA80nGt5
        I6GRNwz1RQJITBWPi39spJHBTmuz28qS2cox2Rj55Vn4sr+eLHKiHdCKKJLqSKLU
        WJs3duQS+WtYkz+bZsl2g2UXi9WrJiYCr0YURsdmm+LxYuUuWGvuN0mP6gSdb2I+
        SWwVWwyEF6TdJ6M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA0CE14CE43;
        Fri,  2 Jul 2021 12:05:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6CAF14CE41;
        Fri,  2 Jul 2021 12:05:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
References: <xmqq4kdft122.fsf@gitster.g> <87o8bmcd9a.fsf@evledraar.gmail.com>
        <xmqqczs2rrew.fsf@gitster.g> <87tulcand1.fsf@evledraar.gmail.com>
Date:   Fri, 02 Jul 2021 09:05:18 -0700
In-Reply-To: <87tulcand1.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 02 Jul 2021 14:18:40 +0200")
Message-ID: <xmqqim1spupt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4CA37E42-DB4F-11EB-88B8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yes, they can't be advanced separately, one depends on the other in
> turn. I'm suggesting that the parts that go earlier in the sequence
> could advance before the later parts.

Yes, as long as the bottom half is more stable and ready than the
top half.  When I queued these topics, however, I didn't get that
impression.  After all, if we have to replace the bottom half as
often as the top half, having to maintain two topic branches is a
needless chore.

>> I actually do agree with the objection that www-data is a contrived
>> thing to use in the examples, not because the user www-data is
>> distro specific, but because it involves one physical human user
>> acting on two accounts, instead of two human users interacting with
>> each other.
>
> The www-thing is arbitrary, and I can change that bit, but what do you
> think of what I mentioned at the end of [2], i.e.:
>
>    =20
>     [...] the purposes of the example in the guide replacing Alice & Bo=
b
>     with You & another version of you removes a lot of potential
>     confusion, we don't need to cover permissions, the other user doing
>     unexpected things like non-ff updates, pruning branches you may hav=
e
>     relied on through the --local clone etc.

www-data requiring more privilege than you do require permissions.

I still think two distinct human users coorporating towards the same
goal would make easier-to-follow sample sessions.  IOW, ...

>     It's implicit that both "users" are you, so we only have to discuss=
 the
>     point of the actual example, how to pull and push between two diffe=
rent
>     repos, the "different users" in this case was always a distraction.

... my view of the presence of two distinct human users in the
example is completely opposite from yours---to explain Git as a
platform for inter-developer coordination, it is a crucial part, not
a distraction, to have them as two separate human beings.  It is OK
to pretend, while practicing, that you who are typing to this window
ares playing the role of Tom and you in the other window are playing
the role of Mary, and that would be what learners would do, but the
scenario the learners learn from should resemble more what they
would do in the real world when they become fluent for the learning
experience to be more useful and lasting in their minds., I would
expect.

Thanks.

