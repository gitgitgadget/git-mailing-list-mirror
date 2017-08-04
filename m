Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7A62047F
	for <e@80x24.org>; Fri,  4 Aug 2017 20:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdHDUGv (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 16:06:51 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46170 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751965AbdHDUGv (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Aug 2017 16:06:51 -0400
Received: from genre.crustytoothpaste.net (50-233-111-59-static.hfc.comcastbusiness.net [50.233.111.59])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 598A7280AD;
        Fri,  4 Aug 2017 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1501877209;
        bh=9juOTPHdlOz7CFRiyk9D94PlPeGgWj9G6+E88WYZ2Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZm44b46Zf0NB3Amg051OYK5Dx1OlbpgHYLg7ZmPFSPQwqGsrcpW4ic0M8PKVQ0Wz
         iUrx1Uml9FzZ77JUGlAb15L3oTNVuLFvJi+1h16fVcvaVdn8XNSZoG4+jVCeHvtUAH
         SYyB0aHJ7ff6WJ8YRMkHXZUhOw6vWve9Q8tQFoGbu3XZYsIG5J8gaKkeHBj1PNkiXb
         IdiCtm4OMyBu9zWoWMy1qeJdoxTW8ChXZSr3OTstPBgUsCwm4A3Ev2tgwPGOz6aroo
         3MoQPCifm/2YbapMh+cpWBKHFR3Y9vMOTnQFqZhv3WoeYbTHKgYs/IL7MjoOF8/rNS
         vefxIetjbVSk2JANOW0CJDslfXGk84HRN6apG+MI3zuKmGgEQV6qE1iV8DgFyu8m62
         69dQgLfSdtapNUHJEDljGSFxgLFsQ67ttSeY2lDeRLlHfs8Zal8eoed/Qx1MAVc5tv
         xRelioUVhDNTUqIvjq1FsuSxb5XzulDHx3h7LcUk9xeZmhiiT/3
Date:   Fri, 4 Aug 2017 20:06:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
Message-ID: <20170804200643.gq5pqeoeje3xii57@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwgjqnxg7pqgj7t5"
Content-Disposition: inline
In-Reply-To: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hwgjqnxg7pqgj7t5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 06:16:53PM +0200, Nicolas Morey-Chaisemartin wrote:
>  static struct imap_store *imap_open_store(struct imap_server_conf *srvc,=
 char *folder)
>  {
>  	struct credential cred =3D CREDENTIAL_INIT;
> @@ -1090,7 +1116,7 @@ static struct imap_store *imap_open_store(struct im=
ap_server_conf *srvc, char *f
>  			if (!srvc->user)
>  				srvc->user =3D xstrdup(cred.username);
>  			if (!srvc->pass)
> -				srvc->pass =3D xstrdup(cred.password);
> +				srvc->pass =3D imap_escape_password(cred.password);
>  		}
> =20
>  		if (srvc->auth_method) {

I'm not sure if this is correct.  It looks like this username and
password are used by whatever authentication method we use, whether
that's LOGIN or CRAM-MD5.  I don't think we'd want to encode the
password here before sending it through the CRAM-MD5 authenticator.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--hwgjqnxg7pqgj7t5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmE09IACgkQv1NdgR9S
9ovRKxAAhNoyh7/bnyH2BVaERKrRcjuqCiLI+34EwdmFeAH7KRw0eLTHYZkfPzUE
TlW6nKNV4xwRILKfMIutRKepJt3mdzW1kt0iudOZ65qUNFvAX2w0DZNJ4FJhWeJA
xDStV4sgPWrrjRqBbQ0vHKmNAMnuIVrXna2udC5kunoNahEw0nVOEPv71fc6IZ1e
NKC477uzYdSfUdUli4wXqMgL8HY+pOkIR+IcNlYEkM+IDoL4+l6kfQqSv84gGpjE
grfxr2QDWP6+8sl0xxzJSGBuADgXahHWMuy1dYbH7SXOYfyUVtSc/cSZDQBO4tma
L+sTEANL04gBUfo3Ho3wwmv2jHaWqJnYpQhAZG2kVwYQ/HJ+qG+eYfBaSfG9V5Ec
uioslWDVowas6pHh90gZOs/UwBI4o5DV4sPvumDKlV4af9PGnLKXmM73UdNTOLAa
ypQcSKAi9MMI0SAph8sLuzJcJjNavaBqGjhA9MzU5wWHkX5gh92bC8qNE793Li5x
4OnqS4kc21Ghu21JNCADUljlrE8F42MugOnZXF2w0M0rKmfh73t+LqlwcDesykyY
yG6PVcYhjS/FJO+81BXM69ta2twUuUl+NekDI4IV6OkUih0NjeJ92rf+bAxAFy4g
J4tshPj80a0KUGagdnIMd0Qa6msOvjuHT+UDnHF5S3qIFp1+3Tg=
=creL
-----END PGP SIGNATURE-----

--hwgjqnxg7pqgj7t5--
