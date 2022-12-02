Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73DCC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 20:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiLBUz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 15:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLBUzY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 15:55:24 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC9DB60E
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 12:55:23 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2464A5A1DF;
        Fri,  2 Dec 2022 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1670014523;
        bh=m+ihvcxu5aAXrAirr666pzoSrMxpUhIpk1wt2Gn6Y+Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nF4BDxIYTgsTZobF4NIHvMnGRv5Z6hb6qD8ZVMvrpCz6zRhl5PreEFdFP562KAGao
         lC+O13ymMYgxJuP8Srq0tttzhDxJBXamMX0iRr6hDWOFKM+O/547gp8vJNhvTc12q/
         t2mdBLZHvAM0A9FipH9Q2cB0Umdd4nD8DcwZ8cyd8/M9w2cRs+++SKgaOPeN6t7yV1
         clHdPxaj9yH+TX/1vKL2YBOJrPQSD7YkQGL433yBqIWeqgMnRurGVZOM0zp58E6sno
         Z2coyuILkMfKRnMD03Y5l5fZ0F1UuG5/U32nLQtlw3GKMxq8OqnCs+bZ2TKipOxbfq
         C7UiVYKtovlY5F9UwTwYrDiGsolUtwoJqBrnzoc1Zq/q+bNZwIYmlPMCtrbNsD23QF
         r7EYZsNi3jiWpK/J0tDt15BkHP/bKbEbALLeHdJmwzfv3yqVu9GlZETvrllOBczcms
         SpuwFOeygvbCFo4guqbe3a1h+8jRMnuuVDVh2Vr6KF4KilcXo06
Date:   Fri, 2 Dec 2022 20:55:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija <doremylover123@gmail.com>
Subject: Re: [PATCH] maintenance: compare output of pthread functions for
 inequality with 0
Message-ID: <Y4pl5BzQnw0Fm+5S@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Rose via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Seija <doremylover123@gmail.com>
References: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
 <221202.86k039fz7x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfeyw9qZJLQxVWjD"
Content-Disposition: inline
In-Reply-To: <221202.86k039fz7x.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mfeyw9qZJLQxVWjD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-02 at 18:10:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> But (and especially if you're interested) we really should follow-up
> here and fix the "error()" etc. part of this. After this we have cases
> in-tree where we on failure:
>=20
>  * Call die_errno() (good)
>  * Call die(), error() etc., but with a manual strerror() argument,
>    these should just use the *_errno() helper.
>  * Don't report on the errno at all, e.g. in this case shown here.
>=20
> It seems to me that all of these should be using die_errno(),
> error_errno() etc.

Actually, I don't think that's correct.

> Or maybe it's the other way around, and we should not rely on the global
> "errno", but always capture the return value, and give that to
> strerror() (or set "errno =3D ret", and call {die,error,warning}_errno()).

Yeah, I think we need to do this.  That's because unlike most other
functions, the pthread functions _don't_ set errno, and instead return
the error value.  That's why on a typical Unix system, we would have
never failed before this patch: because errno values are always
positive.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--mfeyw9qZJLQxVWjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY4pmOQAKCRB8DEliiIei
geY7AQCreksrjFOcCyjRKhHeRDrDpAUHGknX/Gi7mJ5K5RCmRgD+JfRCgzbJgG9Q
yVr8g4vVqGgvrbmq5oYhROnLs20oXwM=
=Kc+u
-----END PGP SIGNATURE-----

--mfeyw9qZJLQxVWjD--
