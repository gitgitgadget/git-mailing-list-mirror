Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F065C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 21:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1927A60F9C
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJ1Vmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 17:42:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43366 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230476AbhJ1Vms (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Oct 2021 17:42:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF3246042C;
        Thu, 28 Oct 2021 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1635457220;
        bh=a+xxMvPKGa5caSgXvZrbrniT/zRaxhrh3d8S5LN+CEQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KLaYazML4Sp/1Afz9RqvhVeAolGKahiG+O4MxRVdHXAGNpy+dPuDf+ZYkv46bVF7K
         fHdWqHFwf8i+dQ/KGZQ+Yg7YstBDxF4EKTSMx2Z9TBjrMAistc325q2cDKUwEHJoM9
         SHW7B1QhPzhwUHNIORb4ZdqeNyWdKgXwYHkWf6cC2EM6NfMisnZNwd1tNY6/OxZEMR
         ziC6IuCEimrXgY5xS/ESiXk5H/+ik1zbascx4cHr8+Mu+W+GwSMVJvvlR8dXm7Q0+m
         scDcCK/57Y6xSoNh0INGSfyHT2xs/+6N3Ye06ku0mwG99QA4/uqukw8AdHtvJo4z+I
         +0xSYQaPMK3G/BXFqTzqwjOLd206CSDoMTxV/BdF5lmgHv6pCcDZ36Rx24TXFTIykQ
         4lJ5ou2O0ZpaQdNDK836rs+g0RNECZgzZpVO2VZbEQ2OjudC0ylxYTrwx/Q8p5dVsR
         pLDREJEqbLLsyvNTjfjZ6khVbNaKsmC1VR1nTb+BM0RNJV7Kure
Date:   Thu, 28 Oct 2021 21:40:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] allow disabling fsync everywhere
Message-ID: <YXsYvgPs7d/0E+sK@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
References: <20211028002102.19384-1-e@80x24.org>
 <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
 <20211028182824.GA1307@dcvr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K9ClioViETVO4szP"
Content-Disposition: inline
In-Reply-To: <20211028182824.GA1307@dcvr>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--K9ClioViETVO4szP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-28 at 18:28:24, Eric Wong wrote:
> Third-party tools and OSes which don't have a tmpfs mounted by
> default (I don't think most *BSDs have tmpfs enabled by
> default).
>=20
> I try to use libeatmydata everywhere I can; but that's not
> always installed.

I was going to suggest libeatmydata for this purpose.  I don't think we
should grow this option when there's a library that does all of this for
us without any mistakes and also is universally applicable.  Presumably
if you find Git too slow in this case, you'll also find dpkg and other
programs too slow, and want to use it there as well.

It's also potentially a footgun where people end up "making Git faster"
and then get corrupted data.  I'm imagining blog posts and Stack
Overflow suggestions that people do this, just like we see tons of
suggestions for people to set http.postBuffer without understanding what
it does.  I think "eat my data" is pretty clear about the consequences
so we don't have to be, and it comes with a giant warning that you're
almost certainly going to experience data loss.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--K9ClioViETVO4szP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXsYvAAKCRB8DEliiIei
gSSjAPkBI3riPxX5Ve/BgZxYkZkuMt/fFsKHa/jJm7wpfF02uAEAnRaHh8cKxFiX
M1xDWI/vIDpP47VHjOLZlDx+wF76HAY=
=uTZn
-----END PGP SIGNATURE-----

--K9ClioViETVO4szP--
