Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7881AC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 12:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbhLFMUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 07:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbhLFMUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 07:20:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2520CC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 04:16:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muCvA-0008Hg-GC; Mon, 06 Dec 2021 13:16:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1muCvA-0031t2-7J; Mon, 06 Dec 2021 13:16:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muCv9-00082T-4y; Mon, 06 Dec 2021 13:16:39 +0100
Date:   Mon, 6 Dec 2021 13:16:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?QmrDtnJuIEzDpHNzaWc=?= <b.laessig@pengutronix.de>
Subject: Regression in 8d92fb292706 ("dir: replace exponential algorithm with
 a linear one")
Message-ID: <20211206121639.o4a4tdzlijnhnjqz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k7ewdreuc7ohafmg"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k7ewdreuc7ohafmg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I admit this is somewhat of a corner case, still it happens in the
reality of our admin team ...=20
Initially this was noticed after upgrading the OS from Debian buster
(with git 2.20.1) to Debian bullseye (with git 2.30.2).

(wgit is just a wrapper for git to call it from my ~/src/git.)

This is the good ("old") case:

	uwe@taurus:~/tmp/8d92fb29270$ wgit version
	git version 2.25.2.7.g0bbd0e8b5233

	uwe@taurus:~/tmp/8d92fb292706$ wgit init
	Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/.git/

	uwe@taurus:~/tmp/8d92fb292706$ mkdir subdir
	uwe@taurus:~/tmp/8d92fb292706$ cd subdir/
	uwe@taurus:~/tmp/8d92fb292706/subdir$ wgit init
	Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/subdir/.git/
	uwe@taurus:~/tmp/8d92fb292706/subdir$ cd ..

	uwe@taurus:~/tmp/8d92fb292706$ echo content > subdir/somefile
	uwe@taurus:~/tmp/8d92fb292706$ wgit add subdir/somefile
	uwe@taurus:~/tmp/8d92fb292706$ wgit status
	On branch master

	No commits yet

	Changes to be committed:
	  (use "git rm --cached <file>..." to unstage)
		new file:   subdir/somefile


with 8d92fb292706, the following happens:

	uwe@taurus:~/tmp/8d92fb292706$ wgit version
	git version 2.25.2.8.g8d92fb292706
	uwe@taurus:~/tmp/8d92fb292706$ wgit init
	Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/.git/
	uwe@taurus:~/tmp/8d92fb292706$ mkdir subdir
	uwe@taurus:~/tmp/8d92fb292706$ cd subdir/
	uwe@taurus:~/tmp/8d92fb292706/subdir$ wgit init
	Initialized empty Git repository in /home/uwe/tmp/8d92fb292706/subdir/.git/
	uwe@taurus:~/tmp/8d92fb292706/subdir$ cd ..
	uwe@taurus:~/tmp/8d92fb292706$ echo content > subdir/somefile
	uwe@taurus:~/tmp/8d92fb292706$ wgit add subdir/somefile
	uwe@taurus:~/tmp/8d92fb292706$ wgit status
	On branch master

	No commits yet

	Untracked files:
	  (use "git add <file>..." to include in what will be committed)
		subdir/

	nothing added to commit but untracked files present (use "git add" to trac=
k)

So git after 8d92fb292706 doesn't add files from a subdirectory if
said subdirectory is tracked in git, too.

While I'm not sure which of the two behaviours is the bogus one, this is
a change in behaviour that I guess wasn't intended in 8d92fb292706.

Is this something that needs fixing?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k7ewdreuc7ohafmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGt/yMACgkQwfwUeK3K
7AmMsAf/bEBjfKzqfF9Q9STqhvvaXi2dEGzk/PtlzfxetXOreRDxVuMCvw+x7QaJ
viCg09BWRKtU24DA6ZYcDqtlnB0i0SzWztb+zFGWROTHEEdgH/bE8Uflh9UkC+5F
QU0ZT+sQ7izwTapmAi4CW/9tnz6hCYGNu4Kc+nrTIhLltIGGZ8ItW+KEWdinKWQq
gb1PtcvE0Clm9JtuoKPe+tXHZb7kgoc3E6RfgBT1U+QjPe8QZcsFjL9bZw/uZHJv
JUXkPIUSL2Ex8XHNMPXvZ0O40avJviGSw+plK+f/96+OoXGoXoEcugYJzGOfi+dT
R4leCGPrtElfYh3dT4uu9kWO5kz9oQ==
=cSgk
-----END PGP SIGNATURE-----

--k7ewdreuc7ohafmg--
