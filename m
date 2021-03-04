Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B322BC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7437F64F14
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383967AbhCDAYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56794 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392513AbhCDAOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:14:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E89910F1C0;
        Wed,  3 Mar 2021 19:14:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kKYFexkxC5lL
        W+JN/kBF4hba7pw=; b=plGGTmJavp8SJYrat5MecqXGOyl0myYvjkm8R81wqrEO
        rkR3pm5kIna2z7oVWuR4VObzOaVeycuU+Nb1mJybkmfRMeOHoTajfXuOprx0t8vx
        IkC08y60aRDKXRV5ntQdYrblErnze9h00ierzO9W9Y1VYmHacPKkOpOCn62y/h8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vCjPas
        QB1w9L5MJ0KXH6tC2/JVKVXeDxXBrLNIHPR1WN9+LtZOkBGTb6JT3MBA/6yhBHLk
        dc3Km4kRS6PPJPzmw3G0pr3nTYvcoBV2L4lDiI7Tjn3X8R+fwlXPmvgmoR6jtlsT
        Rfi1Ru7oz+uyG6DiY3VU1ofhvKlMxqIwBdfOU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65B6910F1BC;
        Wed,  3 Mar 2021 19:14:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD23210F1BB;
        Wed,  3 Mar 2021 19:14:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 06/10] grep/pcre2: use compile-time PCREv2 version test
References: <20210204210556.25242-1-avarab@gmail.com>
        <20210218000728.13995-7-avarab@gmail.com>
Date:   Wed, 03 Mar 2021 16:14:07 -0800
In-Reply-To: <20210218000728.13995-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 01:07:24 +0100")
Message-ID: <xmqqtuprhj1s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8A8E5C3E-7C7E-11EB-AC3A-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +#if (PCRE2_MAJOR >=3D 10 && PCRE2_MINOR >=3D 36) || PCRE2_MAJOR >=3D 1=
1
> +#define GIT_PCRE2_VERSION_10_36_OR_HIGHER
> +#endif

This is not wrong per-se but it does look misleading not to spell it
as

#if (PCRE2_MAJOR =3D=3D 10 && PCRE2_MINOR >=3D 36) || PCRE2_MAJOR >=3D 11

which would convey the intention much clearly.

Hint to notice the difference: imagine if it were "9.37 and later in
9.X series, 10.36 and later in 10.X series and anything after 11 are
OK".

In other words, the minor version is always tied to a particular
major version and "major >=3D X && minor >=3D Y" is often a bug, even
though in this case it happens to be OK only because 10 and 11 are
consecutive.

