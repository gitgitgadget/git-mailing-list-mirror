Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE02BC433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 21:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A806124F
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 21:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhJBVFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 17:05:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53004 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234044AbhJBVEl (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Oct 2021 17:04:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A234860457;
        Sat,  2 Oct 2021 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1633208544;
        bh=cVdOAE/2CEFOxj8fRdM/1I/39/8dkKcPj9a69yHE/14=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TV3DDYMPdSF/qbDTHHWowDC9e5pB+KJH7nMQw6mPL9fxSDajvTPuOTweT2D9dmubG
         sWRPh27XC6IMt9bfgCnDMvka3ylM3umhkpvZd9McYFbARQadkSnp1PPAual+yhFEwz
         hPvOsjzzOR/jKiwsUGr4ejOmzt/e+y5/ZkcjbENvcdHWhHGxSmdo715tmJERrYkmkj
         FVcfVWqFnwH8ZaGB+OYj60wKOqNSBXuRGaXAsRD7uC+IWZk/6mRfkRNlN6Oo2zTRi9
         jQrEsSMvdooLznUeQ+30QiLlvDCuVRxPsMZosGbjE7OOBwnCyHYJPtoR87HbYYA87l
         jKv4wgWSLBn1Yqv2akzup6jAxeMHGJ2808XLT/AIRP7oMsuOL3wdH864W2lENDCh3O
         h1QN2IIErX440p3M+HrZT3f4khsQmOZVv5gLhl2QEVCnyGehVLUtIErcRWluWyuKp4
         2HDDM2bpP9oX5MOksJK/SmJRpWJqSpmNI4+Pwf0uE4FaAh2m26F
Date:   Sat, 2 Oct 2021 21:02:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perf: fix test_export with SHELL=zsh
Message-ID: <YVjI3AgD7SK4zxy+@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <8b70d04f-0ad1-6e68-f5a2-2d8ec3bb98ea@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JD3GwHGu4PujEafA"
Content-Disposition: inline
In-Reply-To: <8b70d04f-0ad1-6e68-f5a2-2d8ec3bb98ea@web.de>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JD3GwHGu4PujEafA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-02 at 09:40:02, Ren=C3=A9 Scharfe wrote:
> Unlike other shells, zsh doesn't do word-splitting on variables.  This
> is documented in https://zsh.sourceforge.io/FAQ/zshfaq03.html#31.  That
> breaks the perf function test_export because it uses a space-separated
> variable as a poor man's array, and as a consequence p0000 fails with
> "not ok 3 - test_export works".  Pass the value through an unquoted
> command substitution to force word-splitting even in zsh.

There are a variety of places in our testsuite where zsh is broken in
zsh mode.  I recently sent a patch to make it do the right thing for
subshells in sh mode which has not yet been released, and as far as I'm
aware, with that patch, our testsuite is fully functional with zsh when
it's run in sh mode.

Note that in sh mode, zsh enables the SH_WORD_SPLIT option, and this
should work just fine.  The easiest way to do that is to create a
symlink to zsh called "sh" and invoke that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--JD3GwHGu4PujEafA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYVjI2wAKCRB8DEliiIei
gcOcAP0Reubzk1afMSIJ7Ek1UnPaqYIWyMG6ocpJ58I0rP6EkQEAhsYHSJCxCOZr
rIDjc/l5hkarzutqYml4UMO4orfC9Qg=
=iV/+
-----END PGP SIGNATURE-----

--JD3GwHGu4PujEafA--
