Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC5C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 07:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDCA616EC
	for <git@archiver.kernel.org>; Tue, 11 May 2021 07:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhEKHHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 03:07:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59838 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhEKHG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 03:06:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF0B01382E5;
        Tue, 11 May 2021 03:05:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZxAHGQeZceWC
        o29LI977K18eUvhOlCY9ytdIeAvYqZU=; b=YtcD+2VrqZIBl0WKingxuhvCpCg3
        M4SNvxU2lFyKfeeKswUKkmEg2cAKRLKh3sjoADMPJ3mnSYSsnw9YwYq4sN+k/i+9
        onXl8nmq9e/h2d+owSD9tsa8Y22vdv7+4D6UTfok98tj8z6BtOo8NaJn4pHHqWyf
        W7N9nEnP53iApNI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A84521382E4;
        Tue, 11 May 2021 03:05:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DBFF21382E3;
        Tue, 11 May 2021 03:05:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Makefile/perl: correctly re-generate build/* +
 speed up under NO_GETTEXT=Y
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
        <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
        <xmqqzgx2pi5y.fsf@gitster.g> <87a6p1u5a6.fsf@evledraar.gmail.com>
Date:   Tue, 11 May 2021 16:05:49 +0900
In-Reply-To: <87a6p1u5a6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 11 May 2021 08:56:40 +0200")
Message-ID: <xmqqr1idn41e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51B4156E-B227-11EB-B5CD-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, May 11 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> The summary, from v1:
>>>
>>>     These patches are relatively trivial fixes for bugs noticed when =
I was
>>>     working on recent send-email patches. We don't re-build perl/buil=
d/*
>>>     assets when variables that affect them are changed, and needlessl=
y use
>>>     our non-mock gettext Perl i18n framework under NO_GETTEXT=3DY if =
the
>>>     system happens to have Locale::Messages installed.
>>>
>>> Changes since v1:
>>
>> Hmph, didn't reviewers declare that the previous round good enough?
>> I thought I merged it 'next' already.
>
> I sent this re-roll before I noticed that. Nevermind & sorry for the
> noise.

Mails cross all the time.  A single-liner follow-up incremental
would be good, perhaps?

Thanks.
