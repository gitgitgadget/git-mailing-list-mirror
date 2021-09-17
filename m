Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F16C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 08:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DFC6113A
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 08:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbhIQI5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 04:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhIQI5u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 04:57:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1890DC061764
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 01:56:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR9fU-000753-HN; Fri, 17 Sep 2021 10:56:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR9fT-0006ib-Vy; Fri, 17 Sep 2021 10:56:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR9fT-0005A9-Uo; Fri, 17 Sep 2021 10:56:23 +0200
Date:   Fri, 17 Sep 2021 10:56:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        =?utf-8?B?QmrDtnJuIEzDpHNzaWc=?= <b.laessig@pengutronix.de>
Subject: git repack -A -d doesn't remove objects found in alternates?
Message-ID: <20210917085623.rjpmqqhb5xap26jd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqohkf2k44fvrl5p"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sqohkf2k44fvrl5p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I wonder if I do something wrong, or if I just don't understand
something:

	ukl@dude04:~/work$ git version
	git version 2.30.2

	ukl@dude04:~/work$ git clone https://git.kernel.org/pub/scm/linux/kernel/g=
it/torvalds/linux.git
	...
	ukl@dude04:~/work$ cd linux/
	ukl@dude04:~/work/linux$ du -sh .git/objects
	2.6G    .git/objects
	ukl@dude04:~/work/linux$ echo "/ptx/work/user/git/linux.git/objects" > .gi=
t/objects/info/alternates

	ukl@dude04:~/work/linux$ git repack -A -d
	...
	ukl@dude04:~/work/linux$ du -sh .git/objects/
	2.6G	.git/objects/

I would have expected a drastic size decrease from git repack after the
alternate is added. Compare with:

	ukl@dude04:~/work$ time git clone --reference /ptx/work/user/git/linux.git=
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-w=
ith-reference
	Cloning into 'linux-with-reference'...
	Updating files: 100% (73605/73605), done.

	ukl@dude04:~/work$ du -sh linux-with-reference/.git/objects/
	4.0K	linux-with-reference/.git/objects/

Can you spot the bug (or the wrong expectation)?

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sqohkf2k44fvrl5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFEWDUACgkQwfwUeK3K
7AkRIwf/R69mOphDEJLYCaV79v/0SiSin6JtNwWWfQkeMP0m/wRd6E6noKQLKqfF
7LcMZ4Iru1ExUhfnltEIXiXe6Z3RTdG5/VKAC9G5PikyuL0Al81FFTHzmPBu79lj
FCoSgCFZFfX7BVhiHudtwfMQ9s/WyHZdJKRxdbN8eekZGzzpIjikIXCdwSPMeodB
krvs+lhHt7TS4kKAfEFWS2v/KIT0itT8fNDSx/5+yHneCrDM56syXhjKezR22VOU
FzuxCJD6Hrlq+r7EVkReUJlreHvH5T/w9wuFI6WOK1GdiffcF6Q7yZXPITE/bfos
yl+A+irv7Sf3O+5WMJiu5bA0w5uK+g==
=gKCe
-----END PGP SIGNATURE-----

--sqohkf2k44fvrl5p--
