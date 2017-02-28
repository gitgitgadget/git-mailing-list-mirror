Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0D4201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbdB1Uew (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:34:52 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41702 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbdB1Ueh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 15:34:37 -0500
Received: from genre.crustytoothpaste.net (wsip-98-185-58-71.no.no.cox.net [98.185.58.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8D8EC280AF;
        Tue, 28 Feb 2017 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488313997;
        bh=o858AKbcULyENPggSk8Etdw1wtYoqtHcwLmfmcEGSWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyuKTtGOuSp6RilhBgNrN5Yh5ajHVOsbbv//cBO6uSZ6Z+zngBWYghPrYjKgHfHPy
         ZuhlAPuOe89OT1VOUvrREMCXjJ/UkJPLnHCcMz7/PIqR034+5kK6bb8bIDwQCshuly
         jMbqtXdJBcqGMo1b7IQ12oB64pJOEX1RidbBmO9QIZ4XqUem6WtemGR/85dlAmJOzZ
         xUV+0MxEzM0A5rrL0nyNIkwMvGUh+fxmsnybD2Taq5isdHsrHnGXDImifqFJ0vRI5v
         /OvC+iW0fNVBewq4fbfD6ZfpxEI0PcFJfdnZxK+J9sd0djxeBBQosGWabk8GBOReEG
         U0qJEXoYP5DznmqMZhN4kB7gJ7x9N7Q44BxpxcicEkQ83SniNNLjr4XTw6R2d4yDNn
         bhjALhbDsyS9Am9XcisE/ngZRIl9pIoTcPv4XQAE12rrjmTJ+6pRoraQP7eOe4K4n9
         3osiwujs/J/sDyPyh1cDuLXhPncDH9fICDJ9/j9nFQDxOJhmuhu
Date:   Tue, 28 Feb 2017 20:33:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Typesafer git hash patch
Message-ID: <20170228203312.jc7gia7f44goqjmj@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
 <20170228202633.3pxbrnrhot7syiae@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7sr7vtyv76ymj6sk"
Content-Disposition: inline
In-Reply-To: <20170228202633.3pxbrnrhot7syiae@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7sr7vtyv76ymj6sk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 03:26:34PM -0500, Jeff King wrote:
> Yeah, a lot of brian's patches have been focused around the fixing the
> related size assumptions. We've got GIT_SHA1_HEXSZ which doesn't solve
> the problem, but at least makes it easy to find. And a big improvement
> in the most recent series is a parse_oid() function that lets you parse
> object-ids left-to-right without knowing the size up front. So things
> like:
>=20
>   if (len > 82 &&
>       !get_sha1_hex(buf, sha1_a) &&
>       get_sha1_hex(buf + 41, sha1_b))
>=20
> becomes more like:
>=20
>   if (parse_oid(p, oid_a, &p) && *p++ =3D=3D ' ' &&
>       parse_oid(p, oid_b, &p) && *p++ =3D=3D '\n')

What I could do instead of using GIT_SHA1_HEXSZ is use GIT_MAX_HEXSZ for
things that are about allocating enough memory and create a global (or
function) for things that only care about what the current hash size is.
That might be a desirable approach.  If other people agree, I can make a
patch to do that.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--7sr7vtyv76ymj6sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli13ogACgkQv1NdgR9S
9otmNA/9GRX5tdINukFZBbJMZzRknT1uUu0XnEOGNrBPy4UTOl2kTCBP0Sfx7Llw
R3NugHfGanvFxaakAL6kOtmyzhrgvmvmBHV2AVXvKyMbHyMQIcHRv+Zc7A/ZfkQN
quqS1PnxoDLiCONJ95sR9oSutfhzternZwKG3lVtNDwSuwbxRiXdrqhcF6dUtc0h
O16goU4QQuMm/JBVgUv+Za98AHy7No8l7el5fsb7nS6E/IHvptuBkNFizHfQq/Fk
JRDx2sTkbU3gfW5WhcrTOgaLVOR7Q3lu5xe7Jt7Edneo5Zi9YZY4IBUooO8q8E1F
U5/a+KKGYcjG5kyiqadFJYAH+8yKKjM6IAniqd+XIPpG4Tx+tG8EeHaEsFYbY+uB
shHhwS80RHiJqPWZkvHG7GisEDrjLxAnxZsv2uOLsth6BF72XxGEVutP0SqLfdFL
u0gFRMwPMNv1K4Az2gwPcu6td+/bXn3RTslNePoNg6VqQV9dr6MLq+Qz9BBkojW5
oNabOoikDVIHeSd5KDdky3+EDEEsURHCO/PIcKf2+GKWj2sd+4wrE8y/xr/L9cyF
GPlNyO4Ad6ihoJwwYuCMXLghnpy+UMiD6UpTGqegDbRCpo1mcMayDKixHCYGvuNt
Ndwu8pyYHiSeM0yi5trochruNhSwxn5JEgHfbmjK8rnhGlNSOA4=
=dpTl
-----END PGP SIGNATURE-----

--7sr7vtyv76ymj6sk--
