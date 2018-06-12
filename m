Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BAC41F403
	for <e@80x24.org>; Tue, 12 Jun 2018 02:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935083AbeFLC2X (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 22:28:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37696 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933545AbeFLC2W (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jun 2018 22:28:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C724D60129;
        Tue, 12 Jun 2018 02:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528770501;
        bh=WYq+FeQlw5CQ4Zstu66Bgra3e1pCHQb6fG4hY5Gub5Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QOri99F47qbndCI4XOQzWsT5av6Bnr7cLW9sNTIPkh2f2L2OcHjs/H83QbP97iD8U
         y3TZLPDn8As4xmDMHKrRputXmKH6f1I3vf9jIPcEDy2f/gYMoeTzBq3UQEfMMoMw/n
         ovx8EIwqJtvutzUGOW0sGvADR0BLhuGo0CC+I11U/iPHnoOPcJGeIf/7CDbbdtTyVr
         gHht6GvDBB0z48gk6eQTNhA88EOZT93oNU0QAoB09IiUp0wZYCPpk72bdgL9LV9zeq
         sp+6uchbNbKUly1mlqbhTgDfsKVqIX+5SkwNMIMN60P2o7D5kYVFGdgSz2uyov0Xx9
         7kv6k7EY2+sdA8wipZpfhTm6+/HOIRWIOCy7R3ndoRxieHcO/nvL12761p2Xat9U7A
         xHsC73KH4uZY2lEeloI4K8raD9xALf0Z/h9B3ZJbFjfjcnRxPZIyQ8KwV9hxLGKBx7
         3xsQT8tgAmmV1MSo2g8brU+kBWXnDxzN8q7690JARXMOMeddy7W
Date:   Tue, 12 Jun 2018 02:28:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: State of NewHash work, future directions, and discussion
Message-ID: <20180612022815.GL38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180611190103.GB20665@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UeXZ3FjlYZvuln/G"
Content-Disposition: inline
In-Reply-To: <20180611190103.GB20665@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UeXZ3FjlYZvuln/G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 12:01:03PM -0700, Jonathan Nieder wrote:
> Hi,
>=20
> brian m. carlson wrote:
> > I plan on introducing an array of hash algorithms into struct repository
> > (and wrapper macros) which stores, in order, the output hash, and if
> > used, the additional input hash.
>=20
> Interesting.  In principle the four following are separate things:
>=20
>  1. Hash to be used for command output to the terminal
>  2. Hash used in pack files
>  3. Additional hashes (beyond (2)) that we can look up using the
>     translation table
>  4. Additional hashes (beyond (1)) accepted in input from the command
>     line and stdin
>=20
> In principle, (1) and (4) would be globals, and (2) and (3) would be
> tied to the repository.  I think this is always what Duy was hinting
> at.
>=20
> All that said, as long as there is some notion of (1) and (4), I'm
> excited. :)  Details of how they are laid out in memory are less
> important.

I'm happy to hear suggestions on how this should or shouldn't work.  I'm
seeing these things in my head, but it can be helpful to have feedback
about what people expect out of the code before I spend a bunch of time
writing it.

> [...]
> > The transition plan anticipates a stage 1 where accept only SHA-1 on
> > input and produce only SHA-1 on output, but store in NewHash.  As I've
> > worked with our tests, I've realized such an implementation is not
> > entirely possible.  We have various tools that expect to accept invalid
> > object IDs, and obviously there's no way to have those continue to work.
>=20
> Can you give an example?  Do you mean commands like "git mktree"?

I mean situations like git update-index.  We allow the user to insert
any old invalid value (and in fact check that the user can do this).
t0000 does this, for example.

> You can always use something like e.g. "doubled SHA-1" as a proof of
> concept, but I agree that it's nice to be able to avoid some churn by
> using an actual hash function that we're likely to switch to.

I have a hash that I've been using, but redoing the work would be less
enjoyable.  I'd rather write the tests only once if I can help it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--UeXZ3FjlYZvuln/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsfL78ACgkQv1NdgR9S
9otU1RAAo71BvBfPTSXGGUNTy9xAS/toynF9bAcS71nswCgJg/jqG/A7S0m53NXk
SXjeWdKjL5TW+R8zW6YN7CXvvFHB+sV+5QeHI2AZGluQoKbRIxFXUweY/RcacIo2
kM7LWwLuAK8x7J5LgbJU5YZTWrxz9Hztwj3CnTeoH69GYcjw+79hntm1f1+NOmzw
BAOm+Ig3Gas5+BkmCF5HZhGjIZE496W3A1xip5qCPZb1QAxc7DYtowO3hWC0L6Ug
HJ/1SzQHBVM7RUAbBAWcoGV0Dg87PlUOEo35q/WmqsO4zhCEkl8y/3dH9rET7IU/
FqaG5FIDydaU3jJc3Kw+dYUsqgxCUBczlPqgZv2OM1xo7nn68dGmo3acJyC6M7Ga
HBVDrM+vPiZhyt/h/8M+7qGOTXwrucA4EHL+mudGhhln0hhrpmGKiRPF5jfsXy0M
7AG0h0hCWaGg4GxHPTpWGIV8NZ71eOsIJvoJtRMO1ExR/K0GHikVsMswsCduGcAv
bFxUMdDwre1EJpDqsK0Ra9Ze8LurL6MTPahpuRQgi3BKJJ56qJ+B4CjfM0i8Rz92
KvfcxrB7tIkzcsmnibfDufr+0HvwmYMO1iUn572fif8Hy5bUcVP8H0h516LdXFpi
uHk0nbmr0FWznKC3kgDEUdFvkddCuA8az5/v2JW1DfdAYHOEZrg=
=27MN
-----END PGP SIGNATURE-----

--UeXZ3FjlYZvuln/G--
