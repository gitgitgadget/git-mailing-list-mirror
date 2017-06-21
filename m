Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23EE20401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdFUVk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:40:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60472 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751108AbdFUVk5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Jun 2017 17:40:57 -0400
Received: from genre.crustytoothpaste.net (unknown [208.73.141.66])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D74F1280AD;
        Wed, 21 Jun 2017 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1498081256;
        bh=AUumw23KhmWx3f83M5O49UnC2aGDMiKZf0op6sptMg8=;
        h=Date:From:To:Cc:Subject:From;
        b=Ocv1HntaERViP2FOUO2Q4fOtGgsyLdEdNUxoRRekF5cydJkpFz1NIl8ftS1wMyXEw
         7E4LIkv5a9Rk0vyNPQuxOTz3DVP+mBbtct14NPpNcEe2amH47/k/pSOEQxnuK7iMbr
         YrcEFTrGmPVHiL0o7/WeSvjuKN0s5W3sWVJM/aQw1BfANQZ7Nso1QcAuXKXpoiiYkm
         TQNZEehJg7/TkwHh8WcgC+PIOSy7AKNDzFXyTAob2bbALoPYDbvqLrJxnZpzch1wjl
         rSn5/1TXKJOc2wjQP1LfQvAe+O8advZqy+JiX9dssYIj8ifeYUYu3bmPzjW5ioXOqV
         i6MtYwt/dFYGn9/G6a1Mv3zcjxKl9zGqepLL79epJggpnJItEVdj1qeHTzaVwNqEhw
         OhA6zFJrKrif8oXZmZ2WTkk+YpkECXkRqi2Z3PSM3DwrXiXvMmHzh80o8j4HrkgAgB
         qRqvHDuH4Hq75/NNbv2Xj1a/DdprVU6OjVYSbj9g2p4AaKnZslC
Date:   Wed, 21 Jun 2017 21:40:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Sahil Dua <sahildua2305@gmail.com>, Kyle Meyer <kyle@kyleam.com>
Subject: Truncating HEAD reflog on branch move
Message-ID: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Kyle Meyer <kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gy2od5lpd2ru7ysh"
Content-Disposition: inline
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gy2od5lpd2ru7ysh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In Git 2.11.0, using git branch -m caused an empty entry to be logged to
the reflog, but it preserved the previous history of the default (HEAD)
reflog.  In Git 2.13.1 (and in next and pu), we write a valid entry into
the reflog, but truncate it.

So for the following commands:

  git clone https://git.crustytoothpaste.net/git/bmc/homedir.git
  cd homedir
  git checkout cPanel
  git checkout master
  git branch -m master new

I get the following on 2.11.0:

2cbfbd5 HEAD@{0}:
2cbfbd5 HEAD@{1}: checkout: moving from cPanel to master
eaf8db2 HEAD@{2}: checkout: moving from master to cPanel
2cbfbd5 HEAD@{3}: clone: from https://bmc@git.crustytoothpaste.net/git/bmc/=
homedir.git

and this on a recent next:

2cbfbd5 HEAD@{0}: Branch: renamed refs/heads/master to refs/heads/new

For this test, any repo will work; I just picked this one because it had
two branches I could use to generate dummy reflog entries.

A colleague reported this to me as a bug.  I don't see anything in the
release notes about this as a desired behavior change, and it does seem
undesirable to truncate the reflog this way.  If this isn't intentional,
I'm happy to work up a patch.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--gy2od5lpd2ru7ysh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllK5+IACgkQv1NdgR9S
9ouWuBAAtC8p9cfiLLgYXZEIjYvIoDziaCF+8sreTxjRhV0EZe2x4ikY3jIgTj0v
6Pm2q6T51VkgB7V3ogIaPQYtpzGjRWsb3i0IzUZ5sD7VJUn1ZosJnwhLKtNwfebf
mBqhaN9oc9l91hN5991SsWBObko9WqIyC6uC6dcWZvGpifj3frj3bNoYxg9vdGwT
inIY7ClrAH08cA9qVeGVeQtIUZ9mS9d22/dEOHD+Z0/oylcedBB9E42vB4uBv1X1
oPcxqPjWc+lIcgggv+wcFzeGrutjP+qUcGEaQJTc8RVXArtdqCKbpPGdMUh1DWoj
EmZtwjF2InjTg2sRbCbOjJat7hL+yACuKnW9iuNEqe3yXOwSLDM2zCVuYVa5fHU+
1Ux2caNMdgYrwnnLWEw3lfBDXTMFVHX/YHvxgWPcMVMfgZsJCzKq1GSy5WKQmj1g
u9IBV9TTiXvq+L+sktKmYxJ3wB25hHkuJi5yeJIUPByMXkzaTU6qjLprDv3/PkTs
WWAhGQBvpkSHzz1UYvjQyZDcCS722fn9Vj17oQsn616tgrMLFeKhH0q6e3AfF1GN
BLjolB1RPOPMAeEvomtIRE+TV9HfM6LfaLfCGL6eGokBSFQXBNRwytcRYM0WLVqt
UTpVWQB3rSjEVsTfZoSgsDYbpUkgb5ycSUIf36/a0DEMdA1TbEA=
=PK++
-----END PGP SIGNATURE-----

--gy2od5lpd2ru7ysh--
