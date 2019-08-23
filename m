Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A321F461
	for <e@80x24.org>; Fri, 23 Aug 2019 02:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbfHWCSF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 22:18:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58180 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfHWCSF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Aug 2019 22:18:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 272A16047B;
        Fri, 23 Aug 2019 02:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566526683;
        bh=nRfCw/Z4PH03OaahDCgL9MC8QOLDCA+fofXm2LZ5ZCI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=D5/gYPA8/OPnsfRisGTJaj5p7TYqrj8Dx1Horx8eEohAKxVQzDRw7h7Cs3cGpuCCQ
         /E2zwkFwRDDeL/lefMiH1w1edVzxXLBFYa47LSjeiD5yRKjNqI+PMBONWOTKX56MXA
         ki7LqsSmjzboAC0YzxtE5XSyB0udBy9HM73RsVLgm4s0ahOoWsVASPO09nnqYulf43
         vIGsQQ+WqfeYfe5chQHrW/gKrtrXOSt+ZxXosiGH52cCpIWdHtkwnzSaEoLbP4ErIS
         DAj5HeUTt7BAXvVRPrKNbLfd5fGvhpDZMNKy/MscC0xDPoDbOd0m32w0dvJS7YaZ1r
         SHCFaCJDy9/aqy0PEGVp1W3XWqlbTfPpnE5YohI/1ixoNbcTL3i/NME9spDmunw2lE
         CVRVhkoIk3VHh2dPyWFFwVEI9IB1LirPNX37w91D3RueEseoSEc2Lb76Lq5vmBKlAL
         aG2KO5eqH7p0eP1wxau6eIy2HETBlCaY7KHhHYl5W3Ert8LnNS6
Date:   Fri, 23 Aug 2019 02:17:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 26/26] midx: switch to using the_hash_algo
Message-ID: <20190823021757.GL365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
 <20190818200427.870753-27-sandals@crustytoothpaste.net>
 <4f6b781b-68b8-5bc4-92a2-67caff32024f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Content-Disposition: inline
In-Reply-To: <4f6b781b-68b8-5bc4-92a2-67caff32024f@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-22 at 14:04:16, Derrick Stolee wrote:
> On 8/18/2019 4:04 PM, brian m. carlson wrote:
> > diff --git a/midx.c b/midx.c
> > index d649644420..f29afc0d2d 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -19,8 +19,7 @@
> >  #define MIDX_BYTE_NUM_PACKS 8
> >  #define MIDX_HASH_VERSION 1
>=20
> This hash version "1" is the same as we used in the commit-graph. It's
> a byte value from the file format, and we've already discussed how it
> would have been better to use the 4-byte identifier, but that ship has
> sailed. I'm just pointing this out to say that we are not done in this
> file yet, but we can get to that when we want to test the midx with
> multiple hash lengths.

My approach so far has been to assume everything in the .git directory
is in the same hash except for the translation functionality. Therefore,
it doesn't make sense to distinguish between hashes in the midx files,
because we'll never have files that differ in hash.  So essentially the
MIDX_HASH_VERSION being 1 is "whatever hash is being used in the .git
directory", not just SHA-1.

In addition, the current multi-pack index format isn't capable (from my
reading of the documentation, at least) of handling multiple hash
algorithms at once.  So we'd need a midx v2 format for folks who are
using SHA-256 with SHA-1 compatibility and we could then write separate
sets of object chunks with an appropriate format identifier, much like
the proposed pack index v3.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1fTNQACgkQv1NdgR9S
9ovGeRAAzoNZzBzRfQGeAgVy4tyesw25zKc82YqNV7gXMvmzbcZeu0E6wTBF3cIn
MJLvNfCqB1hdIa1h0lNgbvKKPothKuW+Llf3DdGdgahWTDoM8WxywLOY5GxxXP5w
70Gc+N8gdXta3NF1ekfGvpNuuRXLQalPOOUW9IM3B4Fg6Gt2CN6dFyfzhYuC3V8N
cdI2q8Kipi9Bcj6JNGOByhUm0kD65N15O73lL6HpNf0YqnpT7TlAaV/ek1yzqqSU
oKkg3daqXxj+s8kJMwZ3hEfixNyUHGJ+v88BcBzLAjvGNovo2gzCA8yPzRVfVgbT
/xWWpMJDx5x1MIXOvTy3GVDcEdqXIX/9H+5vgVHUNZxbaO/D+HLqVOOEugFfyQxL
6RjCC2oLTvPIEezJxy4R/8nwsxhUdg8h4z6gW6srebBs0n3n1KI2JYn53BJmNnSN
WafONOwQi742JqmCg/nywEiai/fH13BHJcfLf9Tfg7jhsP2EdlvDeYT+jVC8/LZ4
vrsPgasoa/Bqv1pu8MXiRNBLPZK7KxMGbzMa6QiUwi+dcM8jmiWIOnJwFGPfmyWb
N46gJlbq+maF0+5p+BbdCUV27cmDQYlsN7w68YU/LJSFSCs2D975RMVPO/iSE2lp
57g2PLplR2oxHcvb/ugUhr8KRtoP6kcj2jO2Vuduy2rQkni8dwU=
=4uhm
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--
