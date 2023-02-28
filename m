Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B58C64ED6
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 00:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjB1AMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 19:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjB1AL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 19:11:58 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322762A6F0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 16:11:35 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9F3F65A1A8;
        Tue, 28 Feb 2023 00:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1677543093;
        bh=+aOGKFhN8WpM6KLk6I4haSBa3wvZQdJ0xNXMB44lb9I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=luc8jiK7vzz9uq6YP31t5AJNRlGb5FmMuLNWNqkUJSf50x8lCzlR24lBDAf+yN1yD
         eYC6Mm346Kxi+eeRaQbREaLve/7bJa7E4/VEOEgctpPp4c2Qf56JCoSS6MBauNJRyC
         NN4DywMV511x/HCervACsvaZSKBqXjDbkaNDw3FtJOYAJyToicKif89z0iXg2KV5ZZ
         rm5kEmt58nEipa06rC/5eoXjkQ9k08UE3qehaJMF/lQ2EA8GQ5EZo6ndJ4wnd10UKy
         Pz5ORcSMNF7eXU97Vn9KlOxYKHwzQS4RoFS1LuHUuyL40dFY4T0z0w9ndn7sJesTI+
         NMyJyMqDhk8IiycQEwnqdA2nUUfzVTL0mOjx+TjsEehRuD7j/yS3Emm6V3enX2k1N4
         Siosg9J1vrMAvV1yts6nimJ3lc9m3PSWupWepysFAfqR5DesYmIm9o4XgzYzhw76qS
         ECeDm08Xk/36AiuNCO4vCTaFwlxOFbNoCalWjcCjvG1vDppZU5C
Date:   Tue, 28 Feb 2023 00:11:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Git List' <git@vger.kernel.org>
Subject: Re: Problems with CSPRNG in wrapper.c
Message-ID: <Y/1GpjnMHLAqFV5x@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        'Git List' <git@vger.kernel.org>
References: <003d01d94b00$16abc7a0$440356e0$@nexbridge.com>
 <xmqqv8jmr98f.fsf@gitster.g>
 <003e01d94b02$877c2c20$96748460$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BMfop8QBbDKt04fl"
Content-Disposition: inline
In-Reply-To: <003e01d94b02$877c2c20$96748460$@nexbridge.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BMfop8QBbDKt04fl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-27 at 23:23:36, rsbecker@nexbridge.com wrote:
> I have already been down that path, but not successfully. /dev/urandom is
> not available on the platform - never has, never will to my knowledge. Th=
is
> does appear to work if PRNGD is correctly running, but I can't seem to get
> that to work on this site. The config.mak.uname for NonStop does specify:
>=20
> CSPRNG_METHOD =3D openssl
>=20
> which should use OPENSSL_random(), shouldn't it? OpenSSL 3.0 uses the
> _rdrand() builtin so should ever go to PRNGD, but it seems like this is
> anyway. Debugging isn't possible as this is not on my own systems - and
> things work here. Is there any kind of tracing I can do?

It actually uses RAND_bytes.  I've confirmed on my Debian sid/amd64
system that compiling with "make -j8 CSPRNG_METHOD=3Dopenssl" results in
the binary having a dependency on RAND_bytes.  (I used "nm -D".)

Does your system have an nm binary that you could use to verify the
linkage?  (OpenBSD says it has existed since Version 1 Unix, but that
doesn't mean it exists everywhere.)  Once you can verify the linkage,
you'll know whether the problem is OpenSSL not producing CSPRNG data or
whether the CSPRNG_METHOD is incorrect.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--BMfop8QBbDKt04fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY/1GtAAKCRB8DEliiIei
gbm9AP4+9oCCGNiqdVB0Y7Bh0iBAYV4Yrid4mXRboAKlNkerOQD/ThYxtgBR962a
HDSuvSJVXEMgFO42Xy16kn+9uBMvKgI=
=B9iT
-----END PGP SIGNATURE-----

--BMfop8QBbDKt04fl--
