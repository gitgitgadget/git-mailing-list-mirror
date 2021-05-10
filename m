Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8996DC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54061613CA
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhEJS3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 14:29:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61376 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhEJS3H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 14:29:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08E2F13373F;
        Mon, 10 May 2021 14:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hKkcrclZyNxt
        1ebzW+sQL3vjUJS6yPutMrHRS00KAK4=; b=E8Oa+sOc51eMgNgOwhKDjvGO8fo6
        XE6hHOsDLYZcV/UHWbyHpD6Eop/d7Pho+AG7rD7LEi8ipBZ4RCpT0p8t8wGJtIBj
        UeRRYIElQHWzTkZKg/kdFLbwmLZBA6hw6BzRPjNbdKF1OlCyWehI2KZ7TjpbYNC5
        bzsim2+TbokKd/M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0154F13373E;
        Mon, 10 May 2021 14:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12C9913373C;
        Mon, 10 May 2021 14:27:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
        <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
        <877dkdwgfe.fsf@evledraar.gmail.com> <xmqq35v01ua3.fsf@gitster.g>
        <87pmy4uqhz.fsf@evledraar.gmail.com>
        <87zgx2u9pu.fsf@evledraar.gmail.com>
Date:   Tue, 11 May 2021 03:27:56 +0900
In-Reply-To: <87zgx2u9pu.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 10 May 2021 13:04:48 +0200")
Message-ID: <xmqqtunaphoz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 71C9D10A-B1BD-11EB-B25E-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> It would have been a stronger argument to favor --new if we had "git
>>> branch --new <branchname>", but that is not the case.
>>
>> The argument is that switch's experimental design squats on 2x other
>> options, so changing -c to -n so we can make -c and -m do the same thi=
ng
>> is better.
>
> Whatever the merit of the argument I'm putting forward here, it would b=
e
> useful to get some idea of whether you'd be categorically opposed to
> changing the interface of switch/restore in breaking ways even though
> they've been marked as "THIS COMMAND IS EXPERIMENTAL".
>
> Of course any series to implement what I suggested in
> <877dkdwgfe.fsf@evledraar.gmail.com> would need to stand on its own
> merits.
>
> I'm not planning on working on that since I expect the response will be
> at best "neat, but that ship has sailed", but if that's not the case...

cf. <xmqqzgx81x2q.fsf@gitster.g>

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>>Which leaves us with two hard choices regarding switch/restore, none of=
 them
>>really being comfortable:
>>
>>- we scrap switch/restore because their usability is not really all tha=
t
>>  improved relative to `git checkout`.
>
> Please do not do that. Switch/restore is much easier to understand
> for new users. The semantics are also more consistent with what
> others have done with git over the years anyway (EGit as an
> example). I have users who have transitioned because the commands
> make sense. They have not hit any missing bits in their workflows.
>
>>- we leave switch/restore as-are (because by now, changing the options =
or
>>  the design would be almost certainly disruptive to users who already
>>  tried to adopt the new commands, I being one of those users).
>
> I think we should work on the commands to cover between them
> (well... and reset) to functionally cover what checkout
> does. Leaving them as-is, I think is not a viable option. People
> do know these are experimental and not to use in scripts - we can
> hope anyway.

Yeah, I tend to agree with you that the third-choice to improve
switch/restore before we can confidently say they are no longer
"experimental" would be much nicer than giving up on them too early.
