Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0A4C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLURWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 12:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiLURWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 12:22:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54F12611A
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 09:21:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m21so12473476edc.3
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9USdps+GVZWPvOBnAzSkIn2JyBFUEZWA6vABz4DpcBE=;
        b=nvFKMpGocLC4Bkn60bAbXAT5SenjtWWm3YYxKAkAK77E/XsJPNxArmNGXIe9Rtgf5k
         S5V2D/1xt+PjbD0WVYN8fQlzNxhayHanIsCXrcB4ipQQvN1+KGOEFw7pJiW1bb/FZP/1
         wpV+zbe09xd03MuByytbAcu6bMghRnNDH2QcSKnS+/V4utdiiIWan/NeJWv+TIRMpMJ9
         SV78V4Zl9iGUuES7UiEOxjO36glxbOUCqamZOLyxtJuEF0+eiMXoS848X3sQRUxJr3Hj
         9v2mq04m4FhllgR/02ocad8xmvdAzLbYUuGTlu1eiWevM2F70aVpxqFJf6RZ0BK6gon/
         N6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9USdps+GVZWPvOBnAzSkIn2JyBFUEZWA6vABz4DpcBE=;
        b=OnCrzu3UpcnoKc9iPp6Vmr01kX9jK64T+spZ2oMeOrd4Fzjnk4wH8Coe24EIMkPffZ
         8GavFVXlnr5rEz/fMG8ZxkNfnH16Q7/NcwlSPyP7UVccNTeYxhunMzyCOZfJ8iNt7mOu
         guC4HNP8kUFZqVkDKchfQBc3s7E1fT1GfNJ23iB6Sjbxtu4V0S/joyP2ZfSs7uV7iRvU
         W08fCYr7qwhGJxJO3q1pm6d/TFfnrC46PzB+mCNY/sWD+Qe8iiCN486OlLspZ0Gty5TI
         YhZFj2eY7AGH6pwtVJnIyUJ6XS4hZEjXLNj1hfrF+mJQBPR0hifqWSKjf5vzWq8Atun3
         WDqg==
X-Gm-Message-State: AFqh2korDtQVY6ksSVhQXaAjoUOIP5GK1tD3XN79q36NX766Gexyu5/h
        pdNKcarS57Me4oVhnioEoAk=
X-Google-Smtp-Source: AMrXdXvCHhMKGd4+54J9D3A5w3PFqhsXsDxPGNRkf/hz6xjBvi++2GJ6oIDhJ7QTdpPYK9MTKc4d5Q==
X-Received: by 2002:a50:aa96:0:b0:46c:ecb8:e703 with SMTP id q22-20020a50aa96000000b0046cecb8e703mr2245438edc.22.1671643304187;
        Wed, 21 Dec 2022 09:21:44 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b004722d7e8c7csm7300169edv.14.2022.12.21.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:21:43 -0800 (PST)
Date:   Wed, 21 Dec 2022 18:21:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] am: Allow passing --no-verify flag
Message-ID: <Y6NApq8pFcqkvlFg@orome>
References: <20221130172833.2662751-1-thierry.reding@gmail.com>
 <xmqqr0xkt07x.fsf@gitster.g>
 <xmqqlenst021.fsf@gitster.g>
 <Y6LP+fCMmP33T6Cx@orome>
 <xmqqtu1prt2j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kGiN3VjAjogL2Wau"
Content-Disposition: inline
In-Reply-To: <xmqqtu1prt2j.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kGiN3VjAjogL2Wau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 06:42:44PM +0900, Junio C Hamano wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
>=20
> > On Thu, Dec 01, 2022 at 09:55:18AM +0900, Junio C Hamano wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>=20
> >> > ...
> >> > The same comment as the previous one applies to "test_cmp_rev second"
> >> > check.  I think removing them would make the tests better.
> >>=20
> >> I will queue this on top for now.  Thanks.
> >
> > Just to clarify: do you want me to send out another version with your
> > changes on top or should I consider this done?
>=20
> It is up to you.
>=20
>  * If you agree with the "fix-up" done with the extra commit (marked
>    as "SQUASH???") on top and there is no other changes you want to
>    make, you can tell me to squash it into your patch.
>=20
>  * If you don't and have better idea, you can send out an updated
>    version, and you have my permission to include any (or all) parts
>    of the changes I gave in the message you are responding to.
>=20
>  * Or if you make a very good argument and convince me why your
>    original without my fix-up is better, I may change my mind and
>    drop the changes, keeping your original alone.
>=20
> Of course, folks on the list may have other suggestions and review
> comments, which may change the picture again ;-)
>=20
> In any case, thanks for contributing!

Your changes look fine. I applied them to my local tree and everything
still works as expected, so feel free to squash those into the commit.

Thanks,
Thierry

--kGiN3VjAjogL2Wau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOjQKMACgkQ3SOs138+
s6Fqog/+OvuhxBhSstaV/NqyeF3TWWwdwIOx5r8NbXggU1ey30YLTqfXbHAQku4j
txBzI74R5X23zKOBDgz1aDEcBowc6khe8byfVpVZIHT2eTt23xSQ66Yg8W4uWPIW
7xA6fwmIuNRDeTHO6nvO4TnmuqTRyalz99QDbXXW+HyPNb4UR+gleA+DyKWNynhr
5nKkiwMwWzJs/JosSLFgce4m2qYZBJmU2WDV39LMFKUBmDenQm6rx4IhvJa1KMtD
GKSlajs83Au3+K1cTNmDyCZ2KsKawoPHyDjFAzMAxBBnvu8/FKaWH9hDTa5gTXaA
Y2iS2Higlc0T6QMb2vlsVdnYplRu1HgYlKCQkYIOdXFLXjtwbP2uZSKJzk17yGVx
HTZHJJQInXTDiUWyrzyik7DhSR0OYN3KdKiBLbNdkf7RTSqnW+t8T/xlt9eW5/Pj
56vd6saJHUYIjoBU0hSP5XlqaFPte5gFkRWbhiGHOCsUzaTSfvMAitCngvAJg3xa
6EwtS0XucvqqC2xcD1swb8xxIMtbvK6GkID12FK2k7itS4NDj9nV8rHw8pOgC28b
g01F7FPbf9SuUiRner3cdE6Yz9od0xeQ5tng/139AvH1YUDp0gVNT9saUQLHALt+
xWz2pShlt/4whNR/tEzEymj2D6CC8QUzHNNziwz7a08aJJB/NIY=
=10SO
-----END PGP SIGNATURE-----

--kGiN3VjAjogL2Wau--
