Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC02CC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C459D611AE
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhEFBQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 21:16:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61351 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFBQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 21:16:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D02CEBDECB;
        Wed,  5 May 2021 21:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e2GY3OjzsNiNkNG2pv99y6Z40h6jyQ0013j1P3
        f7QGw=; b=wv/CmblTWRlrPq/Ev2oL4ongzpMpKj2XNaDp7XjnFmVxrWgVvROgad
        tmjlaWChS2PVyqa8CBqBRCn/AwYdSnYh5MrUlJRknrmioYjTUZw0CdOrCSor9xMG
        QzvKAJvR4X/AERYSzbb4lwn+XBKX81OjM7Z5D5yHs2bt8hAeeyGF0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7DB9BDEC9;
        Wed,  5 May 2021 21:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51985BDEC8;
        Wed,  5 May 2021 21:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Elijah Newren'" <newren@gmail.com>,
        =?utf-8?Q?'G=C3=A1bor_Farkas'?= <gabor.farkas@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
        <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2105051554250.50@tvgsbejvaqbjf.bet>
        <00af01d741ba$b916a330$2b43e990$@nexbridge.com>
Date:   Thu, 06 May 2021 10:15:57 +0900
In-Reply-To: <00af01d741ba$b916a330$2b43e990$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 5 May 2021 10:26:59 -0400")
Message-ID: <xmqqzgx81x2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D1815E6-AE08-11EB-AD59-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>>Which leaves us with two hard choices regarding switch/restore, none of them
>>really being comfortable:
>>
>>- we scrap switch/restore because their usability is not really all that
>>  improved relative to `git checkout`.
>
> Please do not do that. Switch/restore is much easier to understand
> for new users. The semantics are also more consistent with what
> others have done with git over the years anyway (EGit as an
> example). I have users who have transitioned because the commands
> make sense. They have not hit any missing bits in their workflows.
>
>>- we leave switch/restore as-are (because by now, changing the options or
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
