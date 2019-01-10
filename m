Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991F71F803
	for <e@80x24.org>; Thu, 10 Jan 2019 03:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfAJDKI (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 22:10:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58338 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbfAJDKI (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2019 22:10:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A0FC460FE0;
        Thu, 10 Jan 2019 03:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547089804;
        bh=O1skXCn8LZ5p5QYtYLkspevAtlAK6ztmo88qHip4BB8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=T9Z8S67ffrG5g2DKmr0Ac9I4qNVurA1XwYbTrzUprcviUHxVdYkTMxs2zs17S1sS4
         71gM2jNTTLK1pM+0CC66ru5F+RKxGa6yivhW9Uw+KwPw4odpSC/c568YVp58a3r0l/
         +cAqOTKo3wRdmrlEPD7oLxeyVrloLuPiYv2yM2dy/xDmShhuYTgXvDXRGc1DmCH7PQ
         v/DsVfCaMBl5lk70VxP+cqTPk9cgOdga+GpvoxDYZEGmUOtBGLAVdq8d54YxR5Qc8v
         btBBeUzAkcKINdBJT59VpitcAfkCnYL+MmJ3s/q1M0PK9c6M3tjf0PLuoCqE7YBW2R
         yVRGvzsDoTD5JC/tTbP8dga9z5vY+YUfvfrD3+DiipxL55WlkUc+L99YjxSGXn6YXy
         Xz4+LED3Vp3SNBzI0iBgXtPbL0RdY+fqiPF8cQet+RvSAft+X1stLsxYRaOkWhjHsm
         NF/9JKFDztbKdKgfsScp2zh3HPCLCYUBr3/WS7YUE2r61ADDc5O
Date:   Thu, 10 Jan 2019 03:09:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Harald Dunkel <harald.dunkel@aixigo.de>
Cc:     git@vger.kernel.org
Subject: Re: git-lfs integration?
Message-ID: <20190110030959.GL423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Harald Dunkel <harald.dunkel@aixigo.de>, git@vger.kernel.org
References: <79fd2b4e-243c-a9f5-3485-2954fb0f50ef@aixigo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JlJsEFsx9RQyiX4C"
Content-Disposition: inline
In-Reply-To: <79fd2b4e-243c-a9f5-3485-2954fb0f50ef@aixigo.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JlJsEFsx9RQyiX4C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 04:16:41PM +0100, Harald Dunkel wrote:
> Hi folks,
>=20
> I wonder why git-lfs is needed to efficiently handle large files
> in git. Would it be reasonable to integrate this functionality
> into the native git?

Most of the problems Git has with handling large files aren't really
problems if you have unlimited resources, but they are practical
problems in some situations.

Git doesn't really handle files that exceed memory capacity very well.
In order to deltify files, we need to have them in memory, so the option
is either to not deltify large files and have a lot of storage used, or
deltify and spend a lot of CPU and memory compressing, decompressing,
and deltifying them.

This means that Git can require a lot of resources to store and repack
large files. This is not only a problem on your system, but on whatever
remote system you host your repos on (your own server, GitHub, GitLab,
etc.). Your host, while probably having more resources than your local
machine, also probably has more repos as well.

Git LFS makes the trade-off to store files uncompressed and only copy
the needed files from the server to your system. That means that you
don't need to bloat your local clone with files you may never check out,
but you have the downside that your clone isn't necessarily complete.

I'm a maintainer of Git LFS, and I'm perfectly happy with solutions that
help Git handle large files better. =C3=86var gave a great explanation of
some of the work that's going on in this regard, and I'm also happy to
hear about other improvements that may come up as well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JlJsEFsx9RQyiX4C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlw2t4cACgkQv1NdgR9S
9ov5oRAAp9040o187S2qeTgPfxw44zn/qU3idQPw3ziAbsqPP96FvMGPxSn/iPkv
RyZ1+eQwECcWssN8GdON1/ytvrBgOA9+Rv2+BNM8ri21AndAGV2FCPj1KsfkolnQ
vrdUgbVrX/+vYHO4L9Q4ZKMXVzJZgQhuvrq88U+6c1rR0iDFRV65L7OtuEmkhv5u
4kxfeM1em9VWs9s6uodj0o2VcGtHibXtx3NV1sr6UBLsiEKBdwt2qAUw012LqNPd
eegykNowNakvF8vMVI2jpdWnRu/znrvBozMm91mFa9lJydzJPmmEPw/YFyPXmh7a
6Rf7gFcgkGUMRxXjLZbRBhb6pLV4CPWOsQhs5NfOoUFmZSSqO7I+xUFpS/CVyb7y
toEqp4LYa9zgGYBnQfpPKSQEvTg2x6v7TmpICjw5rs5Yjj4j9X6ecGUmKARwnLPC
I10zSUv1fyeHDcmtlb8Dj5kwhZVOl05nWqvk3eb+hsCfaf1vTEg7AOJfHlh8VRfh
g41v60LmX2pw08f+3p40B1R42Ej6ASkKNNqSxVaawiloENu4DB1fKtk0J+lK7N4M
jAoLc4JRpQXaPEKTjeb+Pg/rFxClVyQZywyxp5pas3InakP4MfJ4mxNaKnko25PY
3wdRQ/WlSN5UAsBILl6Km/6nn8hMBnzSoKBcC/SHzvXUVhI8le4=
=zwrz
-----END PGP SIGNATURE-----

--JlJsEFsx9RQyiX4C--
