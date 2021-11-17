Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B75BC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118AE60FBF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhKQBGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:06:10 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:43528 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKQBGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:06:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8AD485B482;
        Wed, 17 Nov 2021 01:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637110990;
        bh=a2dRU61RK1jwaDbhB4dSioHEIx2SEHwM8E4Dz4KK2U4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LcDLnVDD5v5GCNHW/SIgw181nfnxpVjNQAJqywCnNpY2zCULfKvt1n8vMnZJLGchd
         L6kIunVc5+p+iQVKLXonbHub1J4fEA+gGvkXmYiadv7MY2tu1Xh98sgE3fsFwmvS4d
         8OdgDXNuffdKWi7zhksminBQj6MKsvuRT9ZMiYCZwD95FQQDs6L4tVkfZQSnqYuG8s
         7ytIErvjEROkUzOptlJNYjuuIUNfyGxcZXKKgOYvatHM3nD7weOiT1wqLlmfriyilC
         hzuu19mtIeYWLILjtNWzdV/PJIgodikCj0HvvrXdkA09blkTYXY9/Yar6YbZM1r4xM
         fgEIqq1Fv25CFjIugGU8C7AmJwXTGaW/N1whrU1EmGTgxK0PwJRL4Q6kljTmfjrSkJ
         1RfuI259vLR/nReYWtWz9DErpBh6NdfdD39ESZ1b70ZrVhSaoaoKMh2JgkzeoNAQnq
         0sYE/GgqpkOC5o2rBwkrtlyRNQetwvEmEtG0r1EhxeSK6hin18Z
Date:   Wed, 17 Nov 2021 01:03:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     rsbecker@nexbridge.com
Cc:     'Jeff King' <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, 'Jeff King' <peff@peff.net>,
        git@vger.kernel.org
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net>
 <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
 <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net>
 <00e001d7db40$985c61a0$c91524e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oe7wboF4Ct+yRsRz"
Content-Disposition: inline
In-Reply-To: <00e001d7db40$985c61a0$c91524e0$@nexbridge.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Oe7wboF4Ct+yRsRz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-16 at 23:20:45, rsbecker@nexbridge.com wrote:
> We do link with libcurl and use OpenSSL as a DLL to handle TLS. The
> underlying random source for the nonstop-* configurations as of
> OpenSSL 3.0 are PNRG supplied by the vendor (HPE) on ia64 and the
> hardware rdrand* instructions on x86. I know that part of the OpenSSL
> code rather intimately.

Great, as long as you don't define NO_OPENSSL, I think I can make this
work with OpenSSL by calling RAND_bytes, which will use whatever OpenSSL
uses.  I'll work on that for a v2 to see if that will meet the needs for
your platform, and if not, I'll try something else.

That should also have the pleasant side effect of making this more
portable even for those people who do have less common platforms, since
OpenSSL will likely be an option there.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Oe7wboF4Ct+yRsRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZRUywAKCRB8DEliiIei
gUB7AP9Mp56tOx7c3F05vB9VgTbff1qAztnpMY1GoShHpXfWjAEApESUv7cqpVvQ
LDJg05NuBSL7DVJpjCfrEQTRs9W7LgI=
=ct+9
-----END PGP SIGNATURE-----

--Oe7wboF4Ct+yRsRz--
