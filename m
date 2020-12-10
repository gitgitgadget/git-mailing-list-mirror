Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A198C3527A
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8218723B85
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394138AbgLJWbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 17:31:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57195 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405150AbgLJW3p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 17:29:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4EA6F97CC;
        Thu, 10 Dec 2020 16:49:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A7KM8MMscdOE
        tMpsW3+xFsTSlIg=; b=qFzckk5HRpqH7bg/VsTgBG6RQXyPNz48XALK00Clz0FS
        Bzd+6gAkW7KYaCVnQrS9NfRMrXtCt7oCFLhgWAWcwq7rJ9UCVuE4MXbeVp3iwsYC
        nRfh7OyXUoSfs1YotkfP1/NO1Vcym0rC5nznnGNWKOvrdmpBU7JcqNzcy8EXKR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ONqGro
        6J6ltAXX0rfYhm9YIPSGeCKY33rk86fxe9f8ss5MIIxFF9dbbdxSoZuIdv0IsXjt
        vgP6gZP0g12eDHmINELf93SeneIq70wnQrI6doXaapbO9XSXr/ZpemFYODxS9Nnb
        bX/ppiptFElKrJntj+m/fb4WLHJUF/5C+AEQ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E510F97CB;
        Thu, 10 Dec 2020 16:49:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC300F97C8;
        Thu, 10 Dec 2020 16:49:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 3/3] config: store "git -c" variables using more robust
 format
References: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
        <X9D5SnXca2rGnJFl@coredump.intra.peff.net>
        <87pn3hwfd5.fsf@evledraar.gmail.com>
Date:   Thu, 10 Dec 2020 13:49:28 -0800
In-Reply-To: <87pn3hwfd5.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 10 Dec 2020 21:55:18 +0100")
Message-ID: <xmqqsg8dtjpz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94BDA07C-3B31-11EB-8BA2-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Dec 09 2020, Jeff King wrote:
> ...
>> +test_expect_success '--config-env handles keys with equals' '
>> +	echo value=3Dwith=3Dequals >expect &&
>> +	ENVVAR=3Dvalue=3Dwith=3Dequals git \
>> +		--config-env=3Dsection.subsection=3Dwith=3Dequals.key=3DENVVAR \
>> +		config section.subsection=3Dwith=3Dequals.key >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>
> Maybe worth adding a test for the strrchr() semantics here with:
>
>     perl -we '$ENV{"Y=3DZ"}=3D"why and zed"; system "Z=3Dzed git --conf=
ig-env=3DX=3DY=3DZ ..."'
>
> Which would show that we can't look up "Y=3DZ", but will always get "Z"=
.

Yes, that was explained in the cover letter of these three patches
in <X9D23LQv34A5Q5DC@coredump.intra.peff.net>. =20

We really should document that <envvar> can't contain an "=3D" sign,
but I do not see much point in casting that limitation in stone with
a test.  As long as we know things work correctly with environment
variables without '=3D' in their names, we should be happy.


