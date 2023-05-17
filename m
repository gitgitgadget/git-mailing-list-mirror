Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7217BC7EE22
	for <git@archiver.kernel.org>; Wed, 17 May 2023 22:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEQW2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEQW2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 18:28:39 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA9F5BAC
        for <git@vger.kernel.org>; Wed, 17 May 2023 15:28:35 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 286F15AF40;
        Wed, 17 May 2023 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1684362515;
        bh=Ss/FiFOO7y8ZKZlDDfBBZuJEWTBu91tEY5TVjYPP0XM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Xf9H/Q7vCcR0TCPHCVNYa/l0jk6pttuHIlGbPccUCNBatPOU4UqROhnMUpVa8Gnxc
         WkSdl1ud8SzkTnLCh4uzBd4ttoc0yv7Dh5eIxMitWAz06u2yscUYrbnYFwjKLkh52I
         EzgnbuR9mmHPykwd07tgZE6R0yhxgcfqOU+aP1kUkfHzJIRqeuaJRXYr6/kBgyAZgQ
         lBUI/Mr/Cm6ZF5FYOTgHvUIdcNFzN97M4vqqH+Hm+sHhYXXeSPiaSRvrgM51scAHvs
         oWM+GCYC68SUkXFPg7pWDM3cLT6eo9igHnlAaWb8EVQgfglp7SW0YS05UUYkHHHpNm
         uJ25iORnzaPj1MqLC0tbbi/uchZGxPCS9922O5PGfvbng9B7wMS0CfidZWwLefbgvd
         EmLY1onYL3j7eMHDIQ5l+tMcHiI7ZlZ3NRNW1sa+yUG9sTL3733mcqA8fJGYthoHG0
         ZoPUv/lNOJ0apnm2h6OLYNgY6fGaJ/8IchaarE5teQpto2Raz+7
Date:   Wed, 17 May 2023 22:28:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH v3 0/1] Fix empty SHA-256 clones with v0 and v1
Message-ID: <ZGVVEafBY3Rs65uD@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230517192443.1149190-1-sandals@crustytoothpaste.net>
 <xmqqv8gqoci0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fEaPDr5lSuAXWFhF"
Content-Disposition: inline
In-Reply-To: <xmqqv8gqoci0.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fEaPDr5lSuAXWFhF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-05-17 at 21:48:39, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > We recently fixed empty clones with SHA-256 over protocol v2 by
> > honouring the hash algorithm specified even when no refs are present.
> > However, in doing so, we made it impossible to set up a v0 or v1
> > repository by cloning from an empty SHA-256 repository.  In doing so, we
> > also broke the Git LFS testsuite for SHA-256 repositories.
> >
> > This series introduces the dummy `capabilities^{}` entry for fetches and
> > clones from an empty repository for v0 and v1, just as we do for clones.
> > This is already supported by older versions of Git, as well as libgit2,
> > dulwich, and JGit.
> >
> > Changes since v2:
> > * Move advertisement of fake capabilities ref to a separate function to
> >   avoid an extra strcmp.
>=20
> We want this in -rc2 if not -rc1 for the upcoming release, right?
> I've read the patch again and it all looked sensible.

If it's possible, that would be great.  I understand you just put out
-rc0, and I apologize for the delay in getting back to you, but it would
be ideal to avoid having the problem we're fixing in the release.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--fEaPDr5lSuAXWFhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZGVVEQAKCRB8DEliiIei
gRckAP9Upfm9kV/QorZekyX0e3T+BcatgY5Dr2Q8R/OuPZAn/AD9HdsM9MYaTtFe
JjMCwDwFY6XWo7AyqX+6lnme3FLyLA0=
=MW+v
-----END PGP SIGNATURE-----

--fEaPDr5lSuAXWFhF--
