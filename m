Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAE9C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C276610A8
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhKIXZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:25:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61756 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhKIXZo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:25:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBB9F1567F2;
        Tue,  9 Nov 2021 18:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pne4+luR6HHr
        3fiToaJoSwAnsa09iLGiVPQUK2Zn5gg=; b=QCou5CXce4+BkizUD8mA+VLUQEAH
        PgoE2LNKNbDPfBXob9SnpURWHHtHIL/GyiDJ5hB4VaGrwrg1KCfp1G6A29URg47o
        EjhA0IZGUwyi8F0NoPhCCGtE+HeTIYAgpxS0MwkH+imwmMbQSu9MY7UsRmeRrCNT
        4+JHxQVbnEURap8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D429D1567F1;
        Tue,  9 Nov 2021 18:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32CE71567F0;
        Tue,  9 Nov 2021 18:22:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/16] Makefile: move Perl-only variable assignments
 under !NO_PERL
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
        <patch-04.16-5affe94b05f-20211106T205717Z-avarab@gmail.com>
Date:   Tue, 09 Nov 2021 15:22:54 -0800
In-Reply-To: <patch-04.16-5affe94b05f-20211106T205717Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 6 Nov
 2021 22:03:05
        +0100")
Message-ID: <xmqqo86szzg1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F7B26B48-41B3-11EC-AAE1-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -# Used for substitution in Perl modules. Disabled when using RUNTIME_P=
REFIX
> -# since the locale directory is injected.
> -perl_localedir_SQ =3D $(localedir_SQ)
> -

So, we used to unconditionally define this even if we had NO_PERL;
the patch is going to move it inside "ifndef NO_PERL", which makes
sense.

>  ifndef NO_PERL
> -PERL_HEADER_TEMPLATE =3D perl/header_templates/fixed_prefix.template.p=
l
>  PERL_DEFINES =3D
>  PERL_DEFINES +=3D $(PERL_PATH_SQ)
>  PERL_DEFINES +=3D $(PERLLIB_EXTRA_SQ)
> @@ -2305,16 +2300,15 @@ PERL_DEFINES +=3D $(RUNTIME_PREFIX)
>  PERL_DEFINES +=3D $(NO_PERL_CPAN_FALLBACKS)
>  PERL_DEFINES +=3D $(NO_GETTEXT)
> =20
> -# Support Perl runtime prefix. In this mode, a different header is ins=
talled
> -# into Perl scripts.
> +# Under RUNTIME_PREFIX we inject a header into the Perl scripts; If
> +# NO_GETTEXT is not defined we'll make use of the localedir.

 * The second sentence after ';' should not begin with capital. =20

 * "if X we do Y" wants a comma before the latter sentence.

 * "if NO_FOO is not defined" has too many negations.

Taking them together, I wonder if this would be more readable.

    ... into the Perl scripts; unless NO_GETTEXT is defined, we'll
    make use of ...

>  ifdef RUNTIME_PREFIX
> -
>  PERL_HEADER_TEMPLATE =3D perl/header_templates/runtime_prefix.template=
.pl
> -
> -# Don't export a fixed $(localedir) path; it will be resolved by the P=
erl header
> -# at runtime.
> -perl_localedir_SQ =3D

Is it a good idea to lose this?  We would get affected by a stray
environment variable of the same name without it, no?

> +ifndef NO_GETTEXT
> +perl_localedir_SQ =3D $(localedir_SQ)
> +endif


> +else

This "else" pairs with... ah, RUNTIME_PREFIX.  And of course we will
use the "fixed" variant only when RUNTIME_PREFIX is not in use.

> +PERL_HEADER_TEMPLATE =3D perl/header_templates/fixed_prefix.template.p=
l
>  endif

Nice. now we have one HEADER_TEMPLATE definition on each branch
between "using runtime-prefix" and "not using runtime-prefix", which
makes sense.

