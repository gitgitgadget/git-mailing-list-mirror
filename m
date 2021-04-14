Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120ECC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 00:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47E361246
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 00:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhDNAGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 20:06:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60896 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232167AbhDNAGH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Apr 2021 20:06:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 397776041F;
        Wed, 14 Apr 2021 00:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618358716;
        bh=v+LcH3tnIiHYW7y7qMErF2uHiy4jaz+bCr13PXInGH8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fkdrcWmnzcTBu6lU3rxT/LS5VH4Iq9x8P9qOG5zLCvJlulKdVGCWLatoZvwwCObSL
         TJrF4A1B2r1tkNuYbiyXCixdbaEzEByRMTQBORGd1qzqQTb4VVRC6VVuMRAkEPQioB
         y8mif32BuMzbZiV+00ni5chf9vjavORvq3+/5T28ysd1Q40PQ333+IotokX+X6NfZl
         H/h4OtNKE0o0YDAw1KbYy5fdon1NavPGBA0g1mGPzfkFK9Zpb7f6K1M7HLrpHVb0z2
         N9vKujhpoQyg+twmSGKyQ/erpopvyzvoZHQFa0kHHZN4CsLAs0BqbpcqniQG/teBH3
         ZD1hKQn4LF8fqzYKnG6apcK4zTvlTu0CTQPgsD3wSRmIeomUVqrssV7Ob0O7ZDoluL
         VYViy3wKDcRjF14Xnd+y3X3iDI/DGFNy7s6boB9wmeH9GLtu57NFkW8C7SjR/eaegu
         +ZmGvXODo4OQcsphg5mUNdAfLg/nLrl+jvbMqA1TZC/nz+lfmXR
Date:   Wed, 14 Apr 2021 00:05:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Vitaly VS <strikervitaly@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git via MITM transparent proxy with HTTPS Interception
Message-ID: <YHYxtvKgKz+Uv2xO@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitaly VS <strikervitaly@gmail.com>, git@vger.kernel.org
References: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N5o1NmCiAAwra6Cx"
Content-Disposition: inline
In-Reply-To: <CAEaE=iyUGiPK-HX850mEgC=X6atEhbjJ0dCK0dci0nOCahPhgQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--N5o1NmCiAAwra6Cx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-13 at 12:07:58, Vitaly VS wrote:
> Hello! Can a Git client work properly through a MITM transparent proxy
> with HTTPS interception?

Yes, with some important caveats.  The proxy must be completely
transparent.  It must not modify or impede the data in any way, it must
speak both HTTP 1.1 and HTTP 2 correctly and fully, and the proxy must
speak TLS completely correctly, including terminating the connection in
accordance with the protocol.  It must be completely impossible to tell
that a proxy is being used.

I do want to point out that TLS interception is by definition a security
vulnerability and almost always significantly weakens security, often by
using weaker protocols, breaking or disabling certificate verification,
and impeding the upgrading and interoperability of the protocol[0].  You
should definitely read and understand the literature about TLS
intercepting proxies and have personally verified that your
implementation is free of vulnerabilities before deploying.  You
shouldn't rely on your implementer for this information, because they
usually aren't aware that their implementation has vulnerabilities.

Also, my experience is that many, many proxies of this nature are
completely broken and don't work correctly, so if you are not fully
aware of what's going on and haven't fully tested your implementation,
you shouldn't deploy this technology.  I frequently answer questions
=66rom users in scenarios such as this who are having problems due to a
broken proxy and often have to tell them to contact their network
administrator.  I therefore do not in any sense recommend deploying such
infrastructure.

Git really does need a properly functioning HTTP and TLS implementation
and things tend to break in a variety of ways when encountering broken
proxies.  I would say "exciting ways", but I recognize them all now and
they're not exciting anymore.

> Getting a bunch of errors when trying to "git clone https://SOME_REPO.git"
> On small REPOs (about 1-5 MB) there is a chance that the clone will be
> successful, but mostly I get these errors:

Your proxy is broken and doesn't speak the protocol correctly.  It isn't
a transparent proxy.  You should either remove it or contact your
network administrator to have it removed.

[0] https://www.ftc.gov/system/files/documents/public_comments/2016/09/0001=
9-129028.pdf
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--N5o1NmCiAAwra6Cx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHYxtgAKCRB8DEliiIei
gZAgAQCjZlsQ+XkSMdCbV7VclHu3YniyN9IMWBGHzVWGMBESoQD9FhNOWXo1xELg
XLfROj/4Umjp/yKIDPR/Z2suJ9/7MAU=
=Nzb4
-----END PGP SIGNATURE-----

--N5o1NmCiAAwra6Cx--
