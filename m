Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652ECC001B0
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 00:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGPAYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 20:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGPAYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 20:24:21 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3622701
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 17:24:20 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BA5595A336;
        Sun, 16 Jul 2023 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1689467059;
        bh=rOgOCug0OhQuHZbkJN5/uwlUs9EV8gZZ0rYXRSTXDyw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=shKkE0J6h817HGd9BS1Xtx6vroRQj9Xvw50XI3D/7cwey87lzWr+GJ9EXzJ5echJi
         waxS4cNPONf536vWW6CpvLt33BlW7SvhZBuUc8mLGlnkq7dHJe41lOdY1Ka5fIDIYp
         j6MwIwBFQUoVw3faHXRTielKfh03ni5JP+Ik9wU7aUwym9us/+LBP8MzqAmqniypkG
         gFZg7ap9aX4O8GU+5VfQtVcUnct02veD24mTpADW04Zb1ulurBO4F5WOluhRHjnvOX
         M7Hzt2rtp/fP+N3bNR5CFrcpkytfs4VqyVHH+tfouPzK9pgzeXo4Dcyp/BJUxSf4mL
         ITlnTB4P6rpTOT4molTT8Uj+NM+N9Ix5V1z0VwKbJL/RYDnhL+esrAy+lUAnqVKoyj
         tUtQbvzaMDo2imfb/RZcalnCj4biEoVRVBWbo/9pjiphwYhpJuDDIu3UBBk3Qv0Xnn
         yzamry3CG+2c19cdnnEMKLI3xeVRIP0+Y4geDUyFKmNgGcz9Uor
Date:   Sun, 16 Jul 2023 00:24:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Pressing Ctrl-C during 'git checkout <branch-name>' messes up
 the repository
Message-ID: <ZLM4sTUjBQt4QMfG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
References: <fe3c68d5-124e-5a87-881a-21ad8e492f76@tsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6POIxJXk3n/ZYOR"
Content-Disposition: inline
In-Reply-To: <fe3c68d5-124e-5a87-881a-21ad8e492f76@tsoft.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d6POIxJXk3n/ZYOR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-15 at 04:26:46, Yuri wrote:
> It stops in some intermediate state, and git still says that it is on the
> main branch, but 'git checkout' deletes files that were added only in the
> main branch,
>=20
> 'git reset --hard HEAD' fixes the main branch, bit now it is impossible to
> switch to the other branch because it says that "some files would be
> overwritten", which shouldn't be the case.
>=20
>=20
> All operations should be atomic.

This is impossible, since POSIX doesn't provide the functionality for us
to perform operations atomically.  There are various reasons, including
permissions and files differing in case on a case-insensitive system,
why an operation might not succeed part way through.

> When the user presses Ctrl-C, the correct action would be to cleanly retu=
rn
> to the initial branch.

I would disagree here.  When the user has hit Ctrl-C, they want to
interrupt the operation.  That's literally why a SIGINT (interrupt)
signal is sent.  A checkout can take a long time, and the user will not
want Git to perform an operation which will take even longer than the
original one (because the original checkout was aborted).

Even if we did that, the user could just hit Ctrl-C again and really
interrupt the process, and then they'd be stuck again.

If you don't want to interrupt the operation, then don't hit Ctrl-C.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--d6POIxJXk3n/ZYOR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZLM4sQAKCRB8DEliiIei
gYh0AP9fzVutjqG4/Hyb7UhpY55fVSpuW7Uf3rzstSL1FrN7ywD8CovgCuewsWWd
ETKXrgxXTJIgsn2GYG5vFaVgESFoNgM=
=wewT
-----END PGP SIGNATURE-----

--d6POIxJXk3n/ZYOR--
