Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8748BC388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392F4221F1
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 19:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kHwxIsz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgKUThx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 14:37:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53474 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgKUThw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 14:37:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B210CF848C;
        Sat, 21 Nov 2020 14:37:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7ceeqNsRSrDs
        Ey3cpJtn0hteJDo=; b=kHwxIsz6s/m4mjlTnckGkZSKxN4ysEHgADtv8JJJHtit
        SheiI7jz4ej2wMYsOoBXJQ7v7VT6Ja4Pyby/7lMb7+FevUPZLYWLhLio+KLSbcxy
        u+9xq7ZqApaS7ctJQY7jquSRwfV3wQm2sEp72xUS/uRLN/SuGN1OHRplC6lQhBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pH3Rhw
        Pb0H+N4Bv2K5jzeTENBWF9UPaBYrw1m7NuDaOQssZJGuokjMCcqIWwZKz9hx8zwm
        AvfIofg8pfpTwUKDyWdKsrTXReNDs+oHPb4Et5nSVcknaqGDcrJ+YF159EiJ2ZNW
        hji+/lQ5fEb7+R3uVsVxLx4gY85sj0uGHS3cs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA10DF848B;
        Sat, 21 Nov 2020 14:37:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE120F8488;
        Sat, 21 Nov 2020 14:37:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
References: <cover.1605123652.git.me@ttaylorr.com>
        <cover.1605649533.git.me@ttaylorr.com>
        <CAN0heSq59uX=4pqkhc904oLfeiwF5ctiEb_9cQXYY7T1t=Mt1g@mail.gmail.com>
Date:   Sat, 21 Nov 2020 11:37:45 -0800
In-Reply-To: <CAN0heSq59uX=4pqkhc904oLfeiwF5ctiEb_9cQXYY7T1t=Mt1g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 20 Nov 2020 07:34:35
 +0100")
Message-ID: <xmqqy2iusdpy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 08F03820-2C31-11EB-AB26-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Tue, 17 Nov 2020 at 22:46, Taylor Blau <me@ttaylorr.com> wrote:
>> Not very much has changed since last time, but a range-diff is below
>> nonetheless. The major changes are:
>>
>>   - Avoid an overflow when bounds checking in the second and third
>>     patches (thanks, Martin, for noticing).
>
> FWIW, the updates to patches 2 and 3 look exactly like what I was
> expecting after the discussion on v1. I have nothing to add.

Thanks, both.  Shall we move the topic down to 'next'?

