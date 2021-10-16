Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD81FC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20F861053
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhJPSzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:55:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbhJPSzB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Oct 2021 14:55:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9534260426;
        Sat, 16 Oct 2021 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634410372;
        bh=ZguXQXtCNPavINBecTqiddmcqRRPK8GExVzTglPXTzU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yamdDsYvROIQxxk4Jfb/cBV27Tf8EUFsSX/HPOmkSHthWKEnHbvt+6SiTcSfpPcKD
         WR+4ciesHBHkSiWkVJijE80a79rw5VfAPbciExN0n0j+t5aQIukK5EpATjSGH3Hzgq
         /jIVQKtzdVaMOAogZE8cf9GhiGl/jp0R0+SwQd7fiJRwogfVeOEmrvbpFEpUh0pC2Z
         y8e7LBjMhaRS0rX26HJpb0NPd/wlE8N1Jg5U4t9uRK3ur2oLl72BEUKBGh3e8wdmGW
         6W5fiMykk8IzGJfKpOCNuQ1Zf093N0u8pZTIe8FKP0exL7DPrt0LmkXqynd4OsC8k1
         dt60z4BM9F/5JbDzClEdhWUmk8VFX893E0Set04ztTK5es6Zlv7tPAlQ+m5LAls7nP
         O9prCa7CmSJJKF4naZqeXdW5z5lAMIKjZbDTx9bGc5Roudq1Ji0a60+pUsLS7yGkjg
         v3A/zQWKPyLSFwN+0O4SSVYL1RKD0N6oSLmizmDN6XAfHqQ1BfW
Date:   Sat, 16 Oct 2021 18:52:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Adam Hutchings <adam.abahot@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible bug with checkout and submodules
Message-ID: <YWsffmtRQKQGxkiR@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Hutchings <adam.abahot@gmail.com>, git@vger.kernel.org
References: <CADTYju0PpHHG1=S3N4MDWk5yZqb5t_KUhiDvZ_2i-vXFUT_LDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="khHYpK0psSOtE0mx"
Content-Disposition: inline
In-Reply-To: <CADTYju0PpHHG1=S3N4MDWk5yZqb5t_KUhiDvZ_2i-vXFUT_LDw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--khHYpK0psSOtE0mx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-16 at 18:44:04, Adam Hutchings wrote:
> Hi,
>=20
> I may have found a bug in Git but I'm not sure if it's intentional or not=
=2E I
>=20
> checked out to a new branch to test a PR on my repo, and the PR added a
>=20
> submodule. I init'ed and updated the submodule, and when I was done testi=
ng, I
>=20
> went back to my main branch. However, it did not remove the submodule, and
>=20
> produced this message:
>=20
>=20
> ```
>=20
> $ git checkout main
>=20
> warning: unable to rmdir 'glfw': Directory not empty
>=20
> Switched to branch 'main'
>=20
> $
>=20
> ```
>=20
>=20
> A friend of mine has managed to reproduce this behavior. We believe the e=
xpected
>=20
> outcome is to remove the submodule folder, but this does not seem to happ=
en. Is
>=20
> this intentional?

This is intentional.  It may be that the submodule has data that's
ignored, it could have local changes, or it could have additional
unpushed history, any of which would probably be data users might not
want to lose.  As a result, we don't remove the directory unless the
user has run "git submodule deinit".
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--khHYpK0psSOtE0mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYWsffQAKCRB8DEliiIei
gWu4AQCgKN3Wk4njObnRKWiitlEGXpNiDz4EW0dDm/wZYlU2AAD8C8zp3PzHnjf4
QuewM+sgnvNhmZgUjuokSEYMEuGXOgg=
=o/+2
-----END PGP SIGNATURE-----

--khHYpK0psSOtE0mx--
