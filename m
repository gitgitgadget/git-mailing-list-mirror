Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42FA21847
	for <e@80x24.org>; Tue,  1 May 2018 23:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeEAX6r (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 19:58:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37550 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753312AbeEAX6q (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 19:58:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6E40260400;
        Tue,  1 May 2018 23:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525219124;
        bh=axFhLrxwtsCnt7RQcLHAxynUfAN7MJXablCQjmlypKE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EVAftaZEhSGZAmFwISuLgRu6kmk9vPX8kEg/Yn7jyWilWPeSg8hGHi1SQIB+9gZQa
         WArXs/H9PDgCQCGz8d5DZotrFWqShS5flizY1bTsYjloXG/TN16TQvccgADD4bnbL1
         NS4kyFcEK6n4L2MovST2zlpv6bnyP5rrdsAMjgoN9sNBEVxyuv/7S+Ny6Nebx/60sH
         jzyXsor8dDc5bnFkvvleJdlQMq2citPShOQjoTnw2xinPohTEIP3U9G+VkwD2X8hYt
         4WD9tgc7Hi6370BJ3VEbZ7DjlwOImLOLA8fIKukCHzhCiqoeOd34IuKsUnxOIG5kqH
         QkGFmxTsBP6iGbAjODmRTf/Qmh/R3XRfeh+M49dHFh0j9xnI+QB3/sY3nIxYIa43/1
         XS2/9HYnJyB1Us8uwhkfALR0eBTUfX/LKkVyQVv34OS+tNfRhKLeFbzrpMNq7ZU2Ct
         42z6jkiWb+frvI1zW06mL4nPDSbZNe5CVw2xPE2CT9TofaIlENg
Date:   Tue, 1 May 2018 23:58:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/41] cache: add a function to read an object ID from a
 buffer
Message-ID: <20180501235837.GG13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-2-sandals@crustytoothpaste.net>
 <20180501093603.GA15820@duynguyen.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <20180501093603.GA15820@duynguyen.home>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 11:36:03AM +0200, Duy Nguyen wrote:
> On Mon, Apr 23, 2018 at 11:39:11PM +0000, brian m. carlson wrote:
> > diff --git a/cache.h b/cache.h
> > index bbaf5c349a..4bca177cf3 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1008,6 +1008,11 @@ static inline void oidclr(struct object_id *oid)
> >  	memset(oid->hash, 0, GIT_MAX_RAWSZ);
> >  }
> > =20
> > +static inline void oidread(struct object_id *oid, const unsigned char =
*hash)
> > +{
> > +	memcpy(oid->hash, hash, the_hash_algo->rawsz);
>=20
> If performance is a concern, should we go with GIT_MAX_RAWSZ instead
> of the_hash_algo->rawsz which gives the compiler some more to bypass
> actual memcpy function and generate copy code directly?

I don't think we can do that.  If we have both NewHash and SHA-1
compiled in and are using SHA-1, GIT_MAX_RAWSZ will be 32, but we may
only have 20 bytes that are valid to read.

> If it is not a performance problem, should we avoid inline and move
> the implementation somewhere?

I would like to make it as fast as possible if we can, especially since
hashcpy is inline.  If you have concerns about performance, I can add a
patch in a future series that does some sort of macro if we're using gcc
that does something like the following:

  ({
    int rawsz =3D the_hash_algo->rawsz;
    if (rawsz !=3D GIT_SHA1_RAWSZ && rawsz !=3D GIT_MAX_RAWSZ)
      __builtin_trap(); /* never reached */
    rawsz;
   })

And then use that instead of the_hash_algo->rawsz in performance
sensitive paths.  That would mean the compiler would know that it was
only one of those two values and it could optimize better.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlro/y0ACgkQv1NdgR9S
9osG3g/9E7MkDNihftE0XmqSvzyg3fBvAl99vS9H5HO0E+N4gQ02DCwlSNAGcxJ9
GXrzyS3kXv4ucRkVBbjBJpJ+m0j0+5DBXvTG/LMNxP4mEq9h2xmEUqSLkZLeo9Ny
iTljFlN1QgCAe5d4UeUA1ICWXaItygJX+qgVjC7pDLugWb066k8+pS9k6dQPpcDz
66/m/Pn8WorBIWOY/cnvQA2eiAfkORmrwlKK+qwyPP07M4RM7ozwp34Rg6oDigJ8
RY5GugLcPYyC/LYPLR63msp9fAj/TZkVBqak5EWumyTYQlfBeQbL6e0fl2OAt5lv
/3HzCoach2Tud+vgL2FkwZa4itLgZW5H9JF9VOcBPb9KZ/QNqObRng6XCdPWYrAN
mDlaUGTf2kcPpPQ8ngHIhL1VsirvI/okXYwIcMOd9jRpzFRcUwyiKTkGZRUOzpAz
5BZilGDhIqSlVr1tON5MfaGC+7m+I7iLh1UjcTGMvQTV1E1CNVN32/Q41pPr+u/v
sSw9E9RjX+gNVB5v/zCKEKUYpxfkhfzCMKhnePDMMh9UFgFwSOPtmrIDk0N/FxKe
Uz5M9J8RKg4h48emMQray3v5huUsCjGNe/fzIXUzfq++OOo17wtjMWs6ADAcEFRU
brpwAF3Dnd9ZkKm3GRozN2E3Tuc2gAshcX3nDDQBdLdsIAOdFUM=
=d455
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
