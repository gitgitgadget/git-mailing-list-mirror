Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B349CC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D52661400
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 22:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhDTWZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 18:25:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62090 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhDTWZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 18:25:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EEEF137A88;
        Tue, 20 Apr 2021 18:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ySoDU0o4UjpE
        tvKQAqugLPOSnXk=; b=sff+7cQEKXA8M9HsLHIUzPi4tTJ9QcU+//uLVa3vK22e
        ZclLY3/vrUnPeIOPpYOVc4sO/vtcExTPEIdfqRw3AvHaugclL2dZoB/sjwXUJ/ix
        fuROu0crIJe9eXR05V2tZw8CN/zd03+cDftWpLNKnwS1n41QHuMONxwK5HwaOSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Z2ZNAw
        h4F735eBeSzuqg8bAT/36ijrMXVqlJtpIZH5GP/sUD4+U5twZOEh+0FPElT0odur
        O+NCx5ASimMCjQoz+y1Lat7jB1DlYfwZZuIH4bRm1WGkRDenQb5OG9e20V/7xsgY
        DqMq4S5hh4rdLiZfYHdnikRmTGx+xLVB69zfg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27BA4137A87;
        Tue, 20 Apr 2021 18:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49D63137A86;
        Tue, 20 Apr 2021 18:25:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/12] check-non-portable-shell: check for "test
 <cond> -a/-o <cond>"
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
        <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
        <patch-01.12-a8b483bc77-20210420T121833Z-avarab@gmail.com>
Date:   Tue, 20 Apr 2021 15:25:05 -0700
In-Reply-To: <patch-01.12-a8b483bc77-20210420T121833Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:21:52 +0200")
Message-ID: <xmqqwnsw3872.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 42CE2DBA-A227-11EB-B0D4-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> These will only match the simplistic forms of `test -X blah` (where
> "-X" is some single letter option), but will miss expressions such as
> `test "$foo" =3D bar`. We stop at "&" or "|" to try not to overmatch
> things like:
>
>     test whatever && ls -a foo
>     test whatever && foo -o outfile

I still do not understand why you have to insist on dashed operator
as the first thing given to "test", like this:

> +	/\btest\s+-[a-z]\s+[^&|]+\s+-a\s+/ and err '"test A && test B" ...
> +	/\btest\s+-[a-z]\s+[^&|]+\s+-o\s+/ and err '"test A || test B" ...

IOW, what over-matching would we get if we simplified the condition
like so?

    /\btest\s+[^&|]+\s+-a\s/
    /\btest\s+[^&|]+\s+-o\s/

The one in the patch would miss things like

	test "$a" =3D "$b" -o "$a" -lt "$b"
	test "$n" -a "$n" -lt 4

but the only thing that we care about is that a command that started
with "test " has "-a" or "-o" before we see "&" or "|", no?
