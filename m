Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406C6C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 09:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiHQJtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 05:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiHQJtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 05:49:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F41C6170E
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 02:49:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOFfl-0002z2-F2; Wed, 17 Aug 2022 11:49:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOFfk-000HqK-PB; Wed, 17 Aug 2022 11:49:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOFfk-00CI4h-44; Wed, 17 Aug 2022 11:49:12 +0200
Date:   Wed, 17 Aug 2022 11:49:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     entwicklung@pengutronix.de
Subject: Bug in rebase --autosquash
Message-ID: <20220817094909.v2ev4rpsmxjnii4x@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ieuep4ylwadiy7s"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6ieuep4ylwadiy7s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

after:

	uwe@taurus:~/tmp/git$ git version
	git version 2.37.2
	uwe@taurus:~/tmp/git$ git init
	Initialized empty Git repository in /home/uwe/tmp/git/.git/
	uwe@taurus:~/tmp/git$ echo contnt > file
	uwe@taurus:~/tmp/git$ git add file
	uwe@taurus:~/tmp/git$ git commit -m 'file with content'
	...
	uwe@taurus:~/tmp/git$ echo 'content' > file
	uwe@taurus:~/tmp/git$ git commit --fixup=3D@ file
	[main ef8f0bd27a56] fixup! file with content
	uwe@taurus:~/tmp/git$ echo 'more content' >> file
	uwe@taurus:~/tmp/git$ git commit --fixup=3D@ file
	[main b40a214bf5fb] fixup! fixup! file with content
	 1 file changed, 1 insertion(+)

running

	git rebase -i --autosquash @~2

my editor presents me with:

	pick ef8f0bd27a56 fixup! file with content
	pick b40a214bf5fb fixup! fixup! file with content

However I would have expected

	pick ef8f0bd27a56 fixup! file with content
	fixup b40a214bf5fb fixup! fixup! file with content

instead.

Is this a feature I don't understand?

When the original commit is in the range (i.e. with

	git rebase -i --autosquash --root

) it does the right thing, i.e. my editor then has:

	pick 0c1d21698c38 file with content
	fixup ef8f0bd27a56 fixup! file with content
	fixup b40a214bf5fb fixup! fixup! file with content

=2E Unrelated to that, but annoying is, that

	git rebase --autosquash --root

doesn't do the right thing. It doesn't change the history at all, while
I expected it to only contain a single commit then.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6ieuep4ylwadiy7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL8uZIACgkQwfwUeK3K
7AnROggAnAcDC5Z8c9hnDZ7mW/C3DOUTvVgVL/+9k0L64M8NvOf0s8JqdnQQB8f8
apJX7/VGcoRyFysOzocxngnIBNEygVFugw3yatvAZ2T3Um8jqSHXyG2PW0NtWjUS
yXHyWdcEHGWlxeI8NRzaXaTJoNeKWzK21zlx2ynkOmuC/LCe3+ibxFBmB3j/uFmg
BcGnt1z80OiYFi4oli0saP/r6e6NaAfTnDxoIUgzG1QFILHSGtKEDTpSZXqS/iOG
cZm0vxl8uLf0LL7eamLlP53VdkTiekVj3wneFWwLaPk2GQfQbdOpQYK6AAORxlUC
DlCu6U5ERFdAA4ybfLhT/lHq4msElA==
=n+Z9
-----END PGP SIGNATURE-----

--6ieuep4ylwadiy7s--
