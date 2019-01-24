Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10C101F453
	for <e@80x24.org>; Thu, 24 Jan 2019 00:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfAXAPA (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 19:15:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32924 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbfAXAO7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Jan 2019 19:14:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 093EF60129;
        Thu, 24 Jan 2019 00:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548288896;
        bh=45+yoPiNTKYsYSwIBRuEHTwsnsyFUgaOHlkFfD5S2lE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=S21KqaMF2d/kt/Y54WiGzA8ckTf9b6f3bXMK5ABpkZu2dfMeYZv01XDxEo4KXibbq
         2zBiXzuQBG6eWiUU7OOBk8TJ/Af+vbB2j5pEKIzGTz0xGkaioA6naYi6wce8LYruU1
         8f42TJ0EPdvXYsaHOiUmaSCX3tNSurdF3hfDaCVyAEtjjdSgkATOcqkWc2NA0xtCKO
         FGbptPy0MjJzV/ZNe74GUHQZb68kU073O24OcCx+DAuY7fQ9A8+ANPle129b4/PvQB
         2OtN/mv/dsgj0/rgyoWm9fAQVqlKm4EZoKVYBu2Q1MXRDvODejCT6VvKIqwnHpFN+x
         Pl3WAy9qWwksouw3BaDbzXl3rqF6VAjOnJMppGfIyAvpXaJ17HMDJ//5AEQILn6aEW
         3siItpD0H0JmI0GUFSJrDRwdLsvasfYu3rij/dpVXsf80kX9uiTsRw5xmN3lJx+H93
         gOD/dUt1P7ad06/KUYZTBdqnae21JV7eSSdohEzSrguaTZuSj4R
Date:   Thu, 24 Jan 2019 00:14:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] setup: fix memory leaks with `struct
 repository_format`
Message-ID: <20190124001450.GR423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
 <cover.1548186510.git.martin.agren@gmail.com>
 <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
 <20190123055704.GA19601@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JMCz+drDJ1SjddZX"
Content-Disposition: inline
In-Reply-To: <20190123055704.GA19601@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JMCz+drDJ1SjddZX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 12:57:05AM -0500, Jeff King wrote:
> This uses designated initializers, which is a C99-ism, but one we've
> used previously and feel confident in. But...
>=20
> > +void clear_repository_format(struct repository_format *format)
> > +{
> > +	string_list_clear(&format->unknown_extensions, 0);
> > +	free(format->work_tree);
> > +	free(format->partial_clone);
> > +	*format =3D (struct repository_format)REPOSITORY_FORMAT_INIT;
> > +}
>=20
> ...this uses that expression not as an initializer, but as a compound
> literal. That's also C99, but AFAIK it's the first usage in our code
> base. I don't know if it will cause problems or not.
>=20
> The "old" way to do it is:
>=20
>   struct repository_format foo =3D REPOSITORY_FORMAT_INIT;
>   memcpy(format, &foo, sizeof(foo));
>=20
> Given how simple it is to fix if it turns out to be a problem, I'm OK
> including it as a weather balloon.

It's my understanding that MSVC doesn't support this construct. If we
care about supporting MSVC, then we need to write it without the
compound literal. MSVC doesn't support any C99 feature that is not also
in C++, unfortunately.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--JMCz+drDJ1SjddZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxJA3oACgkQv1NdgR9S
9ovCZw/6AvAeNsNYq7Mz010z920HzKP4RN4PZkMMMwhELj3YmbYBKhFQ8c76gOgz
/Du4ZNND92sG81++fnU1EvYi37s0sjuKGrSR39zUlg0Uw5VtMtA8q3/Om0OATPMm
P66qlovnIz7e7W9a2mODUpmQwrn84/pnEIGwFrplI/EWCEGEwccEbUYzCe/VbHiy
yNL2EeN0DOgT5QZ91n5bKPzcfskIUsEMMA/Dmd0vnX+iTHsgqMpiBftFm+9Hj6zG
/LEkqP9QoSPAqwiv2/aYjAH7DLH5Z9TjmMCfAKl7YK1ifFLkAw6ogVWqirr1cm9T
VKS7SPgVDOss9HIFnFIO4KJxaIuZR2kPoaSkUEdWxp4+yF69u+PoxQ4LsnNDuavk
gdo1c45gOGSS5C6vfXf9G3ll8aatsoeokN/KSH1vcnNH96qMRscoL7IDbt14YWqf
9nj/md58y/WrQagiK+DJyon99BDqI7lRFjnZa1PPpjKHwFzED5juW6O4L1Ps9GSP
9mYmCrh/GXlVCLf0dPf7zDQzN4BpuEb+4gXKXpbLpmQSk6qJhvGfo7LazEegfQ97
3BmiQRVsLYWTwJnhize5gbyMRF8/WS0SNuUXIUOcmZuCaAyINXIbXtWBX5alSPW4
r7ncXWeYWG+F0bbuh22IDfLn8Xc/FMoHz727AKfcW8MLQ1Z8KSw=
=iod7
-----END PGP SIGNATURE-----

--JMCz+drDJ1SjddZX--
