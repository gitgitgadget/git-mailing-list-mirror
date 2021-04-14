Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438F0C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E01D61220
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 07:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhDNHyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 03:54:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53780 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhDNHx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 03:53:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26157127D80;
        Wed, 14 Apr 2021 03:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CYPh2MCKF6NG
        YrHQ4auOatwJbx8=; b=WiFmVYyrduRcopXeY2eq8AZmJLzaKM1u6rJq+LZWND/q
        63rXOSlOeq5pUNPY56XRe73wpNShaNWKfDAg3ZQno4bRTmlIWCGo9GB3G+X6L9mQ
        ZYP/+uejqZVs0MoE9P8xdpP1wa6C2mq6pVWL4uixYEqh2W3GiZWy7f48vXL+coY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=e0J/rX
        M661geyz//ziZrO/juk5S1SEi7P1EegpqW0qhMEaYVkECYIr76myYPb0VDFiUACA
        WWlKoX29IhjP7o5YhfBC3oi0fqYmXKrWbWl++aVloDonZIUwXRD+aPbAI9XKTivl
        9F4yeHN5F/4MYRwzzd/ItL9z1xklZo8zaO0dQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EEDE127D7F;
        Wed, 14 Apr 2021 03:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 169DE127D7D;
        Wed, 14 Apr 2021 03:53:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
        <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
        <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
        <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
        <87fszu2elw.fsf@evledraar.gmail.com>
        <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
        <874kg92xn0.fsf@evledraar.gmail.com> <xmqqim4pz83e.fsf@gitster.g>
        <871rbd2u47.fsf@evledraar.gmail.com>
Date:   Wed, 14 Apr 2021 00:53:30 -0700
In-Reply-To: <871rbd2u47.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 14 Apr 2021 09:38:48 +0200")
Message-ID: <xmqqblahz4hx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81F43182-9CF6-11EB-8A4F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> Thus if we do:
>>>
>>>     git something >expected &&
>>>     test_cmp expected actual &&
>>>     rm expected actual
>>
>> Isn't it a poor example to use to argue for your particular change,
>> where $actual in the original is designed to be unique among tests,
>> in order to ensure that $actual files left after test pieces fail
>> would not interfere with the tests that come later?  IOW, there is
>> not a reason to remove $actual until the end of the test sequence,
>> is there?
>
> Not really, because you needed to read the rest of the test file to com=
e
> to that conclusion.
>
> The point of using a helper that guarantees cleanup such as
> test_when_finished or test_config over manual "git config" or "git rm"
> isn't that we can prove that we need it because a later test needs the
> cleanup, but that anyone can add new tests or functionality without
> having to worry about cleaning up the existing trash directory.
>
> So yes, it's not needed here, but that's only because we know the rest
> of the tests don't have e.g. a test that does a:

In this particular case, $actual files are designed to be left
behind for failed test pieces, so that the tester can come back and
inspect them.  I probably should have said it a bit more strongly
than "there is not a reason to remove".  You SHOULD NOT remove and
that is why we had "check and then remove only upon success" there,
instead of test_when_finished.  We want them left for and only for
failing test pieces.

Please do not advocate for and encourage newbies who would be
reading the discussion from sidelines to use test_when_finished out
of dogmatic principle without thinking.  Even though there are valid
cases where test_when_finished is the perfect fit, in this
particular case, use of it is a clear regression.

Thanks.
