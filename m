Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B7E1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 18:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeG1UUW (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 16:20:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38754 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730476AbeG1UUW (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Jul 2018 16:20:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EBB596046C;
        Sat, 28 Jul 2018 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532803976;
        bh=Gh6u3cKlbvCuqv1TuDVHMmf1OCFhX0UUuu/bXl6TaCk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tqNVCkf0NjrlRGcldQRfw3AflH4jtC6qSDIcAS91EJfANTehZU4isHYeaIRnaB+/m
         QBGv//fOGBrtl+DWt+q/gBaXRMBt9dzmYowwauHpfnjq0XMGtxAcSkDn7AuEpk/tGX
         d1IVXhP4W30SAG7tYBFaSZtJuMN4laxvY5TdoyM7qAMTncsQxUM2k1VEoVKvuyMn7X
         sQEnbqSVGhX5yfw5Z9/Z/kMXAltyZdwGmFA1/3aP15kaREcTQWK8//c7bmWv7tJCi0
         e42r6oBuBSHWSYzDY4rONH8Fwf62WaeXgRoNM9YvlTyHiBHje8zJByDZ6QD+ipX1xp
         lF3Li511wP+h283vee9xlqG1a91b+Z2pob8mfb/AsRsm1qIlTs+T5JnNmVx2zrbN85
         aIVQVSMzbHk6XISPQrpsao65FSY9NmV9tYA5Jllea7Lz0PTXvolRQxngj/65Sl5ryz
         Qog/TFlH0aAltjiGaGsyz2gpnyrJ78g5yVmwxNFfX4xVPQWwmuu
Date:   Sat, 28 Jul 2018 18:52:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Proposed approaches to supporting HTTP remotes in "git archive"
Message-ID: <20180728185251.GB945730@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 02:47:00PM -0700, Josh Steadmon wrote:
> ## Use git-upload-archive
>=20
> This approach requires adding support for the git-upload-archive
> endpoint to the HTTP backend. Clients will connect to the remote
> server's git-upload-archive service and the server will generate the
> archive which is then delivered to the client.
>=20
> ### Benefits
>=20
> * Matches existing "git archive" behavior for other remotes.
>=20
> * Requires less bandwidth to send a compressed archive than a shallow
>   clone.
>=20
> * Resulting archive does not depend in any way on the client
>   implementation.
>=20
> ### Drawbacks
>=20
> * Implementation is more complicated; it will require changes to (at
>   least) builtin/archive.c, http-backend.c, and
>   builtin/upload-archive.c.
>=20
> * Generates more CPU load on the server when compressing archives. This
>   is potentially a DoS vector.
>=20
> * Does not allow archiving from servers that don't support the
>   git-upload-archive service.

I happen to like this option because it has the potential to be driven
by a non-git client (e.g. a curl invocation).  That would be enormously
valuable, especially in cases where authentication isn't desired or an
SSH key isn't a good form of authentication.

I'm not really worried about the DoS vector because an implementation is
almost certainly going to support both SSH and HTTPS or neither, and the
DoS potential is the same either way.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltcu4IACgkQv1NdgR9S
9otpuw/+PyGOUuHIwRDe716gglJJMeVnNBUbDeupXDGCwo674sNxqrd3bHfzuRFD
TUUO4j/9PmziDfXhRX8HuH1LPpbj/uuFlNr3HKaLI7Q50h5X5tIO6EJSHOpsVNad
0+MG8QU08mOMX1/1QB/rKcC60cMNGxkrivJ9dZvHRIX8v6RAB0CkO5JOqKYFEwsZ
ivlI+nefWu2uip0iPDosEHc41n2bY9D9gbxTzjOzd4VR/xZfvleA19HGNCCFJBJ7
Q1oauWLxFcH1LDWSdGuNqKKoTYA6T4vGwEDRpZll+8WI2CAHc4Oi6bkHxnAsHohC
vve5Ib6KHzOLgaPr3+Ps4OyvCDigCe2MUzZzSeOzsh1QFpjojzUkHWdBiX0XUo0f
+RwOsXEpUTuiEQ4BLra0z3xVe/KJUZdoxqksA6SJP9kLEDyhLLMlP8wc2e8geLqP
bo0CF3x0Piwp5YIoD9CkR9wahmz5nR77orKiqZjOrThPCsJy2W/aUkaTKqLn3cTE
gMygfJ6yvFyNhiqUXEKWiDgFz4NNZ24ctAQtsBsIkTLM8MkzZsVZPnu14Sgf44po
jtkkos52uJELlFf9n3zALFZiV98BClZYtD1QPBf1U51cD5yXHiwW964z8Ax1Q/wj
WsaODnFnlwQy908TGUd/olh+eS+qSzEZUF9Iz+vu48Xkdhs2Tmc=
=162H
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
