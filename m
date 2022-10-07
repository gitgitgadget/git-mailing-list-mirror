Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A898EC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJGJCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJGJCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:02:12 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757FAD57C3
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:02:11 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1D9E15A116;
        Fri,  7 Oct 2022 09:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665133330;
        bh=2C9h/WDwRtTnYDeyRHUBHYGIkgU5LaSt3K9L2ZucgpQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Qu1QILS5xv5PrstLUnVrdwjsbbsd6UhkJEKGRF6DervcwHgNCL0MOhXvDWoRV1lrk
         QtzyrQzGsbfDIZeWw42pI6p1/OF+xJ5qEvIwRcENsiPcXb1eN/65WfRTK4AED6zyI3
         6GbEYivf9EpklCPyPcsNW0EDzhm+/cDWCOQQgV5ApZvkNAudPLnc7Y5QdMLS+NMT2g
         AWj4DWDvcFEuCoNxy1Y5UtTnQcVJvK0vHYipnJTRB2ikxFWUfTXpOtINPlzHpbgB0c
         wqwi5kaWiM73LttA4sYEqD1VFtzdeJncPxYPANCnkhjX6teEP0nesLscj9/dQVNVzq
         x7TPNqV0xwsOzHlwWoYeX6NZ6Sue+jIPxPWnwoPu1fzviQAURid7btW3oH0XUxxpp4
         ySgy61U+7hZGM96ihXp8WiWHGoNLmp+QVC9N7QipHNHmMJDSIBoPlv8PQFmszPsXzm
         8VxtuQFmwiwqAdZFuPRIZxSysXAvhzRZMP1psdIkgqWTdP9kFqJ
Date:   Fri, 7 Oct 2022 09:02:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>, Andreas Krey <a.krey@gmx.de>
Subject: Re: Idea: Git Bundle V3 capability @HEAD=ref/heads/<name>
Message-ID: <Yz/rAHYi8JKylHqy@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>, Andreas Krey <a.krey@gmx.de>
References: <8d88ba68-4585-634b-1fe0-61c3465fa682@iee.email>
 <037901f1-1649-1485-a853-9783b9d43b31@iee.email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x/QZ91xNmHayZimz"
Content-Disposition: inline
In-Reply-To: <037901f1-1649-1485-a853-9783b9d43b31@iee.email>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x/QZ91xNmHayZimz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-06 at 15:55:49, Philip Oakley wrote:
> In brian's recent work on V3 bundles [1, et al] I spotted a potential
> idea for resolving the long standing problem that the bundle code may
> need to guess at which ref HEAD was pointed [2, et al] at when there
> were two branches that pointed at the same HEAD oid.
>=20
> The basic idea is to utilise the new 'capabilities' field to pass the
> particular ref that is HEAD using a 'HEAD' capability
> i.e. sending the capability =C2=A0=C2=A0 @HEAD=3Dref/heads/<name>
>=20
> It's inclusion in the header wouldn't change the pack in any way, and
> would resolve the guessing problem.
>=20
> It would be optional for those that don't want to explictly export the
> HEAD ref's name, and could be also protected by requiring that HEAD is
> listed in the pack, and maybe that the ref it points to is also
> included, and maybe further that there is an alternate ambigous ref liste=
d.
>=20
> The idea of the HEAD capability could also be extended to the transport
> layer, as well as this bundle sneaker-net layer.
>=20
> Are there reasons why it couldn't work before I put it on my list of idea=
s?

I think this is a great idea.  I might suggest
"symref=3DHEAD:refs/heads/<name>" simply because it allows us to specify
more than one symref if we feel like it in the future, but otherwise I
have no objections.

I'm glad someone's finding my v3 bundle work more generally useful.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--x/QZ91xNmHayZimz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYz/rDwAKCRB8DEliiIei
gZ/3AQCdDeqjlDW5rS7pKIiC41cKC6GcEq3OJ2FASmE03AFJTgD/SkBRTOLmjkDC
3tSex3QvhO8tE9W0LrTSVMysZCAQIgU=
=ElKY
-----END PGP SIGNATURE-----

--x/QZ91xNmHayZimz--
