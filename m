Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717FE1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfA3Lkc (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:40:32 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33654 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbfA3Lkb (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 06:40:31 -0500
Received: from genre.crustytoothpaste.net (host-85-27-49-13.dynamic.voo.be [85.27.49.13])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CA5146072F;
        Wed, 30 Jan 2019 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548848428;
        bh=5/LgxZznW/+mKG521XICqJXUPOoiJUapZghxgNK1Pa8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QvRYWkUY8Jl/TepivJJ+s3iRdR5/Bv6v4DThBH2IVCEmGdgOxenfHnmxMldhdlH8z
         OPMFnT92xHeCFUWmZ/pszG/D7xvPNFbn6erFo7gNg7O4AcpI/p7xkIk8lusC/lOF4s
         E70brvrIC+4b+2r8bmkqyihZcaOLqxxbKeN6G/Gy6hRh2byzpKKoA0oJYtZ1f8WbLh
         +OlFKm1xNIkPhqbYsejMc8IpBHzRzF8Mif6/CT9sohu1HodqWCktikB+UrPW2D/nz0
         wwL6Of3arrdkoAsaT0+oWaMMyvTytNQIqiBiyEmsqPngD2bO61n/k1+VHhKmvEdlkT
         vzeJUCY+VqAiO27vvobF+aK83AMy4ICvp2dwKlXHh5eXwBvBtitw/aepwqHXHsg2xO
         sc7PzFly4W4EGDFkIXrQzXHv0h5n6A6e5I8gLL2Pl+7fXfp4ruPOXYR8HTwf3cVi4A
         AmyhGAgoeucjIThDm44uIgm3PxU1ttrC3jVZnlqLxIqXnGYnYTH
Date:   Wed, 30 Jan 2019 11:40:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: t5702 failing under ASan on master
Message-ID: <20190130114016.GD24387@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20190130085855.GA24387@genre.crustytoothpaste.net>
 <CACsJy8AVoETLkB5rLft27Rz7V9xPFN9fk=8g9-fCR61fVi4vjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <CACsJy8AVoETLkB5rLft27Rz7V9xPFN9fk=8g9-fCR61fVi4vjw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 05:07:20PM +0700, Duy Nguyen wrote:
> If I understand ASan report correctly alternate_shallow_file memory is
> already gone after the first fetch, when we update the shallow file.
> But we're doing two fetches in the same process (the tag backfill
> thingy), the second fetch reuses the dangling alternate_shallow_file
> pointer and ASan caught it. Resetting the variable seems like the
> right way to go.

Ah, I think I was missing the fact that we're doing a tag backfill. That
explains a lot.

> But should we reset it to an empty string? We would pass
> "--shallow-file=3D" to "git index-pack", which is treated as "no shallow
> file" (i.e. complete repo). This sounds wrong because this is still a
> shallow repository.
>=20
> I suppose setting alternate_shallow_file to NULL would be ok. "git
> index-pack" will just go back to reading $GIT_DIR/info/shallow, which
> has been updated and contains correct info.

Yeah, that sounds like a better choice. I'll send a complete patch which
does this.

> PS. No idea how ASan blames your series for this. Yeah maybe memory
> layout and stuff. But it does spot a real problem.

I don't doubt this is a problem. We'll definitely want to fix it before
the release, since if I see it in development, somebody will likely see
it in production.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxRjSAACgkQv1NdgR9S
9os39g/9Fz/Vga41CTtI1xT1ENPG3KMyDyep9W9RvGGriDdK9wky+BW5nImLClod
dAKe3nXRqYTV6gvxXq0x+joRI3Jmr/hVZV3H05WEOcvIHRV4tKNKMooxdAV0YK+9
+wJZALFgytBqY5k1xYsut/+gWSRTyTCmO13yKOykHI1VVMrwiXcUz3SO+V0P8Hrw
uFIXqfvAFpm52TeRJW8YpCECrykSDNa2RCXnaFx5v3RtVn7qtMV5osLExT0s19z5
z0YKYrfftpWVtQqk9FHuoKCsIRC10FbHjMnpxs4G6WEvHO2rOvJGilE8p3dGB/no
zkYFNPn7i7mnyrGbR461/KZk6kOlIYAU9G34iwwCP9weApFa1IQuBj2vDRVfK9JO
UhFliY1Fuh4pJVKN4TDFQViElywpI9w4Jz61JEoOOL98rV9YgZs/I+e79nDU4sX1
EjDSnGAHmq78dZvblzeb/gkADEjM6HKAJfiJS/vMVCxHwnhinoXLkf/C7elj8/OF
SDVn4nWKPKeavFFP4kDDew5R5i4cm7XcpnLMjrylsKgtkXOlBKCMpY8CeEfOAyMm
wVg97aFalgd3TQ8S57acQJ3wjfQahEr0LPAXVtdlAJU6ROUUnwvi9egLiHqD+Gzz
Y1xUpkXJQMLvVfPh6KLTB919y7/paAqvzp1dvBbBpivD4Sn9TsE=
=OwyP
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
