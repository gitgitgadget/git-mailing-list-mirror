Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3140CC433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 20:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F418261155
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 20:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhDBUvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 16:51:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55851 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBUvt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 16:51:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 572EFBA379;
        Fri,  2 Apr 2021 16:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=POcdP1riLmmp
        rSnkgqGPrXjF4Sc=; b=P2Lowbp2N1VGZTtkDw0e6BNrtDyETnchYvvvS/aPQthL
        pEQDvynyQJ9Zuu2ZaYn+WYFIkhdczZkYtuiolTUZZPZ6GghD8QkEC5IFO5KfVxnZ
        senouMuf0HXOBr915zcAkU9VTGJii7nQ7sO9Xg9aFkctHc5dhwSQbqkLxkOudf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QQMqj4
        WFkB5gK9vMiQrN0LGbeEcPlCIw2lA/sGp1k7H1ePIcIDw0ujJY/WbNQNMNauRYtR
        32/3XDFyNkBmEJSNB+S/ZmT2SWjr5+QIvzQ1VckO58x7hqQT/ZmaV/WA/lV1pLBC
        PvcuczrGyEjYlEN9v9R9Rys1tofqoHsjd9zCs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D697BA378;
        Fri,  2 Apr 2021 16:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C58E9BA377;
        Fri,  2 Apr 2021 16:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 0/5] mktag tests & fix for-each-ref segfault
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net>
        <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
        <xmqqczvd3hkb.fsf@gitster.g> <87wntkkjcd.fsf@evledraar.gmail.com>
Date:   Fri, 02 Apr 2021 13:51:45 -0700
In-Reply-To: <87wntkkjcd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 02 Apr 2021 13:37:54 +0200")
Message-ID: <xmqqeefs4dge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D385CF8-93F5-11EB-A3CD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 01 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Here's a proposed v2. We test the same case, but I thought it made
>>> sense to test this more exhaustively.
>>
>> Let's first make a targetted fix that can be applied to maint and
>> below.  After that is merged to 'master', you are free to add more
>> tests on top,=20
>
> Makes sense. I based Jeff's patch on top of mine to demonstrate that
> those tests also catch the segfault.
>
>> but let's avoid to have more and more topics that go overboard.
>
> So "submit a new version on-top" or "maybe deal with your existing
> topics first as you're overflowing my inbox" ? :) I suspect the latter.=
.

What I meant is...

Comparing the five-patch series with Peff's small fix that is more
to the point, I have a feeling that the five-patch series, like many
other series from you, may be made unnecessarily large by not
resisting the temptation to including unessential "while at it"
changes.
