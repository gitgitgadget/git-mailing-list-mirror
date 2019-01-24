Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626E31F453
	for <e@80x24.org>; Thu, 24 Jan 2019 00:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfAXAjz (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 19:39:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32930 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfAXAjz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Jan 2019 19:39:55 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7891260129;
        Thu, 24 Jan 2019 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548290393;
        bh=lNrgd1PBbiZQoRogXH7kPzjShO1/+BxcoU6lefhvgVQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tsqzhhWMsOsX8u4JsHSbN8njwutpCtXTBKkE5JB0Vrp7274IAourspGxHhb84xZl7
         qJ19WODfQoaZMwDCuEzd70v8gcDDDTjq7kFcUAFftTHRtkspAa0AI/TNjTcx+3w7sR
         w5PGe250s4fqgAgucCeokVRjp5UlUCOngrErawwop6NVg7aUgXDQZ87rCavwyeQEUS
         NvfLj2Z5QnCsk8zio2uD4Fsf4rA6YjekaDet1DRKzOV3oiPp2wzsYBdTMPYxG8StdG
         M1dYOnoBc4N34cfpmLnaVKfGKGweperLsqRKRGmiIkRgUlEQFAS1DeBYUWzuwbJtLE
         Xk73v+ie8Gen/MvNeQJFUELbcLyzFVAgJ9tM7Td6wrYdhxiG3RxWNez0/olSG7GLqT
         fVfMcD7AL1xzHUaMIFg0Up6Xi6q9hOhOjWi2F+jhTuLKRZe8medHS+QQEoOQ9r8YdT
         OH5e5tx9i+VxIMhAyrGDG2wcd8k7bUmMzf44ASxjXBIto58MWTv
Date:   Thu, 24 Jan 2019 00:39:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Joey Hess <id@joeyh.name>
Cc:     git <git@vger.kernel.org>
Subject: Re: git status OOM on mmap of large file
Message-ID: <20190124003948.GS423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joey Hess <id@joeyh.name>, git <git@vger.kernel.org>
References: <20190122220714.GA6176@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iskw6J4cuOvZ6IVF"
Content-Disposition: inline
In-Reply-To: <20190122220714.GA6176@kitenet.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iskw6J4cuOvZ6IVF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 06:07:14PM -0400, Joey Hess wrote:
> joey@darkstar:~/tmp/t> ls -l big-file
> -rw-r--r-- 1 joey joey 11811160064 Jan 22 17:48 big-file
> joey@darkstar:~/tmp/t> git status
> fatal: Out of memory, realloc failed
>=20
> This file is checked into git, but using a smudge/clean filter, so the ac=
tual
> data checked into git is a hash. I did so using git-annex v7 mode, but I
> suppose git lfs would cause the same problem.
>=20
> [pid  6573] mmap(NULL, 11811164160, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP=
_ANONYMOUS, -1, 0) =3D -1 ENOMEM (Cannot allocate memory)
>=20
> Why status needs to mmap a large file that is not modified
> and that is configured to pass through smudge/clean, I don't know.

I believe that currently, Git stores the smudge/clean output in memory
until it writes it out. When using the persistent filter process, it's
possible for the process to choose to abort the operation, so we store
the data in memory until we get the status.

Theoretically, it should be possible for us to write this to a temporary
file, and if necessary, rename into place, although I'm not sure how
well that will work on Windows. File modes may also be tricky here.
Patches are of course welcome.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--iskw6J4cuOvZ6IVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxJCVQACgkQv1NdgR9S
9ots3Q/8D8zJ4bTYKHk5qHHoqtB+g3upv8rEwWTbK2jbuNVm1lAdQan1RsjdvG6l
Xm1ahycTAEIQr9gY+ZgagxvO1ISB0k9ELVly2Gieth6whbrS93f45Ydy6pPEsEhi
jBvbamGDCpfslw1Cdgdptb97w8qbZ09/ClHg8aQPoeaqRCFuYg3aYRCvi18ZjCI0
trZmXZzUyokAB9feyYaYW+a4oRDotPmcz0LBd2guoWPreEzirRiIP6wb9dPPfE+Z
evLquDVoVjDWej5UFGqlF4jkKehLyb3LZG1MAOKuNSXSpZJbM9BLldimjEdrZvhi
18ybCE8dyDGVUdJ+/0as2/5d7ehUGZuDRneeE+eMWpMxM0Mat6DjttmM81aBgPdg
K9S9JUcK2S6HcytVBP1KZOvhxXyvD/12r7s1Q5iMrSaIRLj+Eecx+Jvv3btbofAm
rCbFUklD7P4u2edrOliQeDmxtW/w6bigU3Kv+i6P7zYmtVRtmUQ9Flg7gsVGohKZ
q288+OEHA2feqJIW+FCSrpSHQcWOOxFWoRIF4qJCQ1G0aW1ZeqMiJLjRv7bTjre1
hke9UpJu0AeOsxQK/7MsnPI2V9aDF+1aYwcKPXRq3iiIIlt/JVMN9YWzLxhfK8e8
2pvRg6nCUe/XqfqgUTPTmMSVwgzNbMhZ62hjJeoZKb1mPLJJJ2M=
=jdeA
-----END PGP SIGNATURE-----

--iskw6J4cuOvZ6IVF--
