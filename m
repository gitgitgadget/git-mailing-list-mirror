Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08549C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBBA32083E
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 21:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbhAYV0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbhAYV0K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 16:26:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2ADC061573
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 13:25:30 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l49MW-0008Qz-P6; Mon, 25 Jan 2021 22:25:28 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l49MU-0006jb-20; Mon, 25 Jan 2021 22:25:26 +0100
Date:   Mon, 25 Jan 2021 22:25:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] range-diff/format-patch: refactor check for
 commit range
Message-ID: <20210125212525.dpnsj7ejngvpkd5y@pengutronix.de>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
 <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
 <3f21e10f919eead049dc2440a29bb2bed6c99d0d.1611339373.git.gitgitgadget@gmail.com>
 <xmqqzh107m5d.fsf@gitster.c.googlers.com>
 <20210125073508.l7ksohyfhcogch4x@pengutronix.de>
 <xmqqpn1syg3s.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oxlh2ygc52upvp5w"
Content-Disposition: inline
In-Reply-To: <xmqqpn1syg3s.fsf@gitster.c.googlers.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oxlh2ygc52upvp5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Junio,

On Mon, Jan 25, 2021 at 11:24:39AM -0800, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> >> > In preparation for allowing more sophisticated ways to specify commit
> >> > ranges, let's refactor the check into its own function.
> >>=20
> >> I think the sharing between the two makes sense, but the helper
> >> function should make it clear in its name that this is "the kind of
> >> commit range range-diff wants to take".  Among the commit range "git
> >> log" and friends can take, range-diff can take only a subset of it,
> >> and only a subset of it is meaningful to range-diff (e.g. HEAD^@ is
> >> still a commit range you can give to "git log", but it would not
> >> make much sense to give it to range-diff).
> >
> > Does it make so little sense to forbid passing HEAD^@ as a range to
> > range-diff? I can imagine situations where is would make sense, e.g. I
> > often create customer patch stacks from a set of topic branches using
> > octopus merge. To compare two of these ^@ might be handy.
>=20
> You can discuss for each individual syntax of a single-token range
> and decide which ones are and are not suitable for range-diff, but I
> suspect the reason behind this business started with dot-dot is to
> perform a superficial "sanity check" at the command line parser
> level before passing them to the revision machinery, and having to
> deal with potential errors and/or having to compare unreasonably
> large segments of history that the user did not intend.
>=20
> Also I first thought that the command changes the behaviour, given
> two tokens, depending on the shape of these two tokens (i.e. when
> they satisfy the "is-range?" we are discussing, they are taken as
> two ranges to be compared, and otherwise does something else), but
> after revisiting the code and "git help range-diff", it always does
> one thing when given=20
>=20
>  (1) one arg: gives a symmetric range and what is to be compared
>      is its left and right half,
>=20
>  (2) two args: each is meant to name a set of commits and these two
>      are to be compared) or
>=20
>  (3) three args: each is meant to name a commit, and the arg1..arg2
>      and arg1..arg3 are the ranges to be compared.
>=20
> so ...
>=20
> > My POV is that if it's easy to use the same function (and so the same
> > set of range descriptors) for git log and git range-diff then do so.
> > This yields a consistent behaviour which is IMHO better than preventing
> > people to do things that are considered strange today.
>=20
> ... I am OK with that point of view.  It certainly is simpler to
> explain to end users.

It seems you understood my argument :-)

> Having said that, it would make it much harder to implement
> efficiently, though.  For example, when your user says
>=20
> 	git range-diff A B
>=20
> to compare "git log A" (all the way down to the root) and "git log
> B" (likewise), you'd certainly optimize the older common part of the
> history out, essentially turning it into
>=20
> 	git range-diff A..B B..A
>=20
> or its moral equivalent
>=20
> 	git range-diff A...B
>=20
> But you cannot apply such an optimization blindly.  When the user
> gives A..B and B..A as two args, you somehow need to notice that=20
> you shouldn't rewrite it to "A..B...B..A", and for that, you'd still
> need some "parsing" of these args.

I agree that for a long history

	git range-diff A B

is an expensive request and I wouldn't invest too many cycles optimizing
it. (And if I'd optimize it, it wouldn't be done using textual
combination of the two strings but by checking if the two ranges
intersect. This way something like

	git range-diff v4.0..v4.6-rc1 v4.0..v4.5.6

and maybe even

	git range-diff v4.0..v4.6-rc1 v4.0-rc1..v4.5.6

would benefit, too. But note I'm not (anymore) familiar with the git
source code, so I don't know if this is easy/sensible to do and I'm just
looking at the problem from an architectural and theoretical POV.)

> So, I dunno.  Limiting the second form to only forms that the
> implementation does not have to do such optimization would certainly
> make it simpler for Dscho to implement ;-)

I don't want to make it more complicated for Dscho, I'm happy if I can
in the near future use range-diff with $rev1^! $ref2^! . So feel free to
ignore me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oxlh2ygc52upvp5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAPN0IACgkQwfwUeK3K
7AkT2Qf/U0hjauGpubVi6j2+BMClfZDlVRMYx+9TV+KWKoSTvqbNC1BngzO/fBmS
eBIIpS8u4jCMKKfxRRW1vl5OW+b/tYRAME3RYO2shUroXVeUWrY4KaIwwBxgcHOR
4Rw0e2Pi7vkK8Zrd6FWZCYVTzs9YOXfgBRJJf9OBzSGsjV66qkonVKY1SCwfIur1
Za8+Abw8VTg4syBWwcuKvnbeyYyJuvCKE4vi17I6gqEppNfxZ9CJEe0Vo3QM7zKy
mEnznudTd2fF2NyIuz5EdwUlStket/1PsT9m8dMPyfqnpTQUjTJ6x+/k4R0t3Sgk
U5+1znHBEsUP1/dfAcA+reDHHyfPgw==
=urxk
-----END PGP SIGNATURE-----

--oxlh2ygc52upvp5w--
