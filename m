Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D001C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 10:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D7E61432
	for <git@archiver.kernel.org>; Wed, 26 May 2021 10:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhEZKLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 06:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbhEZKLH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 06:11:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BD7C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 03:09:36 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llqTk-0007Wp-Fo; Wed, 26 May 2021 12:09:32 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llqTk-0008JO-5s; Wed, 26 May 2021 12:09:32 +0200
Date:   Wed, 26 May 2021 12:09:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     entwicklung@pengutronix.de
Subject: time needed to rebase shortend by using --onto?
Message-ID: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gcopzwxg4sorhb6v"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gcopzwxg4sorhb6v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have a kernel topic branch containing 4 patches on top of Linux v5.4.
(I didn't speak to the affected customer, so I cannot easily share the
patch stack. If need be I can probably anonymize it or ask if I can
publish the patches.)

It rebases clean on v5.10:

	$ time git rebase v5.10
	Performing inexact rename detection: 100% (36806539/36806539), done.
	Performing inexact rename detection: 100% (36806539/36806539), done.
	Performing inexact rename detection: 100% (36806539/36806539), done.
	Performing inexact rename detection: 100% (36806539/36806539), done.
	Successfully rebased and updated detached HEAD.

	real	3m47.841s
	user	1m25.706s
	sys	0m11.181s

If I start with the same rev checked out and explicitly specify the
merge base, the rebase process is considerably faster:

	$ time git rebase --onto v5.10 v5.4
	Performing inexact rename detection: 100% (36806539/36806539), done.
	Performing inexact rename detection: 100% (36806539/36806539), done.
	Performing inexact rename detection: 100% (36806539/36806539), done.
	Performing inexact rename detection: 100% (36806539/36806539), done.
	Successfully rebased and updated detached HEAD.

	real	1m20.588s
	user	1m12.645s
	sys	0m6.733s

Is there some relevant complexity in the first invocation I'm not seeing
that explains it takes more than the double time? I would have expected
that

	git rebase v5.10

does the same as:

	git rebase --onto v5.10 $(git merge-base HEAD v5.10)

=2E (FTR:

	$ time git merge-base HEAD v5.10
	219d54332a09e8d8741c1e1982f5eae56099de85

	real	0m0.158s
	user	0m0.105s
	sys	0m0.052s

, 219d5433 is v5.4 as expected.

	$ git version
	git version 2.29.2

That's from the Debian package 1:2.29.2-1~bpo10+1 on a Debian 10 box.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gcopzwxg4sorhb6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCuHlkACgkQwfwUeK3K
7AnaJwgAjTNP28vJ8ApYTtwBlThkGTBySBG1vC8MOKjPybVeSMtlGiJrzSwtnMPw
+ra0kkozpBNuTLKtgPdU1+X8YV2lXAun2t+sF+H0b0EnDGBwzI1dVS3GMwKKK+En
TXB0gaP66FA/T+gvW6pp1nQx/SZEsyLxTNS/iJxFJDWYZeK7tvcm3j32q/ehpjDA
2m3rJ7Zr49n2Yaz09z9dVxIvHwj6epC/b+Ct7BfG7B7geW0AcesDftNXpfFldT16
6Xq8C90aNoJkXxYRUhDemEj4Ue00EkEFAG/rYghRfNrsXZ6sxxSgb3sxKhqokAWL
RxApmW5dQMkyZmKQ8pCnAilYhhfnyA==
=aseQ
-----END PGP SIGNATURE-----

--gcopzwxg4sorhb6v--
