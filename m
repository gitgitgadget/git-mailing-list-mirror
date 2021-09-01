Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384BC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A947461075
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 17:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbhIAR4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:56:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58740 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhIAR4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 13:56:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D126514F420;
        Wed,  1 Sep 2021 13:55:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JlFg6zrPaU4M
        nrL/SEOaDOK4EjpnxB+CXwGfqk8skAw=; b=m+JqqbU5P9sD93+PlYPdenlAydMx
        RtZGKOjypf/quEhus3S/O+ExXGDuIFp2R+viTHwApKIchdVou+OqfJCjU5GajuNV
        Yb9EQnBWe5I3GwiBppZFGIYeIf7I3ljZ1//m//9FAm11iFPAhJq0pdBmAlLcyhij
        JTGdUOtow27/2fU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CABFE14F41F;
        Wed,  1 Sep 2021 13:55:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2CF0214F41D;
        Wed,  1 Sep 2021 13:55:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
        <20210809013833.58110-1-carenas@gmail.com>
        <20210809013833.58110-4-carenas@gmail.com>
        <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
        <87zgszxirn.fsf@evledraar.gmail.com>
        <CAPUEspj43=z8nSdh8UAiqZ+UR8UAZkSsQr1WviGtasQ7d-fHTQ@mail.gmail.com>
        <87bl5dwcx0.fsf@evledraar.gmail.com>
        <CAPUEsphbUHgt09A2qdy-5U0L1y13pkeNjBEUbjkE6JOPeqDVMA@mail.gmail.com>
        <YS7c3169x5Wk4PlA@coredump.intra.peff.net>
Date:   Wed, 01 Sep 2021 10:55:41 -0700
In-Reply-To: <YS7c3169x5Wk4PlA@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 31 Aug 2021 21:52:31 -0400")
Message-ID: <xmqqbl5cqixu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3981C68-0B4D-11EC-875C-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 31, 2021 at 04:54:52PM -0700, Carlo Arenas wrote:
>
>> On Tue, Aug 31, 2021 at 1:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> >
>> > On the other hand maybe we should just remove
>> > USE_PARENS_AROUND_GETTEXT_N entirely, i.e. always use the parens.
>>=20
>> that would break pedantic in all versions of gcc since it is a GNU
>> extension and is not valid in any C standard.
>> (unlike the ones we are using with weather balloons and that are valid=
 C99)
>
> I think =C3=86var might have mis-spoke there. It would make sense to ge=
t rid
> of the feature and _never_ use parens, which is always valid C (and doe=
s
> not tickle pedantic, but also does not catch any accidental string
> concatenation).
>
> That actually seems quite reasonable to me.

That does sound sensible.

> Something like this, I guess?

Looks good.  We could give a warning when the now defunct knob is
used, but I don't think there is anything gained by doing so (over
just silently ignoring it).
