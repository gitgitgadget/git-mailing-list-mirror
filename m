Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D173B1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 18:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeDVSJT (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 14:09:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59712 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751683AbeDVSJS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Apr 2018 14:09:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5BC0660446;
        Sun, 22 Apr 2018 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524420557;
        bh=SX85oLOSIRhKxUCHSeO16EXJQ9hJnHW3rMqM0+txrMo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jmwKXFNhj4oUBoeSWOt3RplYeLw80MurkYLbFzMYg/17CzmJm048pijHYQj3tkIAR
         wKLL01vz/aBcoi8P78dJVYWN875WByo62X+CdUMUyR4sTU+i0P3X4JnRJVNHS1RyZv
         iCeJp+wvidVvv4LqcI5sdxTOPVXFXWJ5dM0yt6iYp+LVJ5+Ptqawujd06Wp1AqJLu8
         hBvBbUxhFTQBbxWlzJRkm+pZQavHoR4b6KsV0k+9MKBFJz3zPXVh9uPhswZDjPbyrF
         XqgJ43Q5qiaTqmLYmOfNA/hLTR4fDxebPc4ccGE/orvO+BFWUJQ2HZQtUmtwrvZmBI
         s+P+L7sv1dxsVHoOVdKOHlC40y2taAmqcjeE9X0AdbXbZzyJaIQzlbZwcnhWviVylh
         65jbDd/ssKcdUZJU6lFNs+9unNeDrioEj9yEp46e9VfHW5BCcCTipF4m7urQs90JEA
         ugjDl5gxq1bRbIo0j2f7pHuWNSfM2/ER2/vS7nRhIP+9JBAeQ7+
Date:   Sun, 22 Apr 2018 18:09:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andrew Wolfe <andrew@schemaczar.com>
Cc:     git@vger.kernel.org
Subject: Re: Git enhancement request - checkout (clone) set modified dates to
 commit date
Message-ID: <20180422180912.GK14631@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrew Wolfe <andrew@schemaczar.com>, git@vger.kernel.org
References: <585A3A2E-7DA6-4718-BF85-2D17AAAF3EF5@schemaczar.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UK1lfQXsnwKrySH9"
Content-Disposition: inline
In-Reply-To: <585A3A2E-7DA6-4718-BF85-2D17AAAF3EF5@schemaczar.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UK1lfQXsnwKrySH9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 22, 2018 at 01:18:10PM -0400, Andrew Wolfe wrote:
> I would like to propose that the checkout process set the create and modi=
fication times of a file to the timestamp at which a file was committed.

The reason Git doesn't do this is pretty simple: make and various other
tools do rebuilds depending on timestamps.

If I create a branch off master and make some commits, then switch back
to master, I will want the changed files to have their timestamps
updated to be newer so that a make on master will rebuild dependencies
based on those files.  If I set the files to the commit timestamp, those
files would be set to the timestamp of master, which is older than my
new branch, and make wouldn't work properly.

There are some cases where people want the behavior you requested, such
as for reproducible builds, and in such cases, you can use a
post-checkout hook to set timestamps with touch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--UK1lfQXsnwKrySH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrcz8gACgkQv1NdgR9S
9ouYOg//aNE9Ahc3HXtkJ2UmwTPqYEOE1mSaRNKDkKI/ydFVeUavHIAXPI6rUWbn
VQ3AtIx6vEXoOPXCNwUBq5wQKciYcU940dFZU+QAMylYrTaJEVsYIGWkpbbWPzts
UTtQtYgR85ADFB9nbay7M7wCOPj9XNOZ35pHvtou/foYLAmm1xA8aJ0XdVPAAlFv
zFo8n2hCbJZjE2vQ0b0ogF00qlP7/bJsgwxb1AwPdqjR3BGo+wx/UhdjGzZ8yLYR
HwT1GXK4xweLlScpg3TjjaWkm+CrW+fg/OEuIiwhbhlbPR57p5YY/EQqVnjZxM9p
8waRpCM2p9T366adv2uC5/04lbZNA6dNYGsbHe40/sM7BBRN8rVs9/5fXRVHQ/HJ
xzbQ+O27fpma1xuGxH+k4pGq8dyQG3bZrVpTSxosijUoxnqHkcMCySKVvHuuIXoT
0pYdgDh+frA3cV6nQQhrMXXHHoCPDbprr8epcbDnMUruAYL0mM6KCS7qXEEFNqJZ
nS8t8PF6MyiCKNSVYpHsDMV8Ptsm2EGh1q3QFqO+G+jdBR7FwYG2Cq+qMIkvc6Zx
e6HibxNd/x42WGporh9E4lw2kc52YgVjibxEds/IgIn+pUgHvS68qUWW3nTD2GEQ
0SnDTqi5AcJreDYPzNpx33dcfJpqp+sHOCYYwjYYVbXGhd/QpjU=
=1h84
-----END PGP SIGNATURE-----

--UK1lfQXsnwKrySH9--
