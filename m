Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F106C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 23:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCD6221F0
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 23:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgIKXUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 19:20:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57890 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbgIKXUM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Sep 2020 19:20:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6DB4760129;
        Fri, 11 Sep 2020 23:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599866410;
        bh=14ARDh7t6r+lG9A+3UwksbrRIClPmHcoA7WWo070Lmg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eDnuNO56Sc1JDSti5v9Fzw+P9iE7rVvozPT1TZa1SJ5nC2ujH8gJby2mqDZZKmnLE
         8cr+GWg64VDuM0bWAD8m+HHHXOQZcSKv5pqL1Phu5OolSsZU1WSJk2U+5H3XAL3tBD
         5C5TOMFi22g9SLgQNpVuvUc1j5pcNdEUSjzHIw0x/6XMrfBfZu0Gtdr0x2zXaKdVPx
         S0hImfy8M684qs2vUxeLzqX3QX4PC8JSCUSj3W2feS8fVJ1Oao67NXJ6/xkaE9VEc6
         JCBClwAMIEkCIhst06GcetNAAwAD0bSpAU/rLM8oMiPDyoQAPzMd2eSmIdP0wxGvyw
         NtUSnwyNpTiFCzNJnHomFSztYy64vFvrhIAHQb/IwkMImTjUl3NfTDDPUoV5vc24fe
         U9hdFkXQaObIxII6e8ytE05Il2F3hYFpz4o3r1t9c7BQi0NhPmmbqjMk4B2gb/BEVe
         UOHhEMsX+c85yUDyD4yEEYO+ecLP+jOhMFD0d9fdbBgwf3Km3X3
Date:   Fri, 11 Sep 2020 23:20:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: Posible bug with GIT_DEFAULT_HASH during clone
Message-ID: <20200911232005.GM241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        martin.agren@gmail.com
References: <20200911151717.43475-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iUV/lbBrmPtUT9dM"
Content-Disposition: inline
In-Reply-To: <20200911151717.43475-1-matheus.bernardino@usp.br>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iUV/lbBrmPtUT9dM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-11 at 15:17:17, Matheus Tavares wrote:
> Hi, everyone
>=20
> Documentation/git.txt mentions that GIT_DEFAULT_HASH is ignored during
> clone, but I think it may not be *totally* ignored, sometimes leaving
> the config file on the cloned repo in an inconsistent state.
>=20
> To reproduce this (tested with current `master` and `seen`):
>=20
> git init test
> echo F>test/F
> git -C test add F
> git -C test commit -m F
> export GIT_DEFAULT_HASH=3Dsha256
> git clone test test-clone
> git -C test-clone status
>=20
> Which outputs:
> fatal: repo version is 0, but v1-only extensions found:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 objectformat
>=20
> From what I could see under gdb, the steps leading to this are:
>=20
> - First, this call chain gets the GIT_DEFAULT_HASH value:
>   cmd_clone() > init_db() > validate_hash_algorithm().
>=20
> - Then, init_db() calls create_default_files(), which calls
>   initialize_repository_version() with GIT_HASH_SHA256, setting these
>   configs:
> =C2=A0 * extensions.objectFormat=3Dsha256
> =C2=A0 * core.repositoryFormatVersion=3D1
>=20
> - Finally, cmd_clone() later uses the return of
>   transport_get_hash_algo() to call initialize_repository_version()
>   again, but with GIT_HASH_SHA1, setting:
>   * core.repositoryFormatVersion=3D0
>=20
> So we end up with the repository format version as 0 but the
> objectFormat extension is present.

Thanks for the bug report and reproduction steps.  There are a couple
possibilities here:

* First, we just initialize the repository with SHA-1.  When I saw this,
  I tried that, but it breaks anytime we have an empty repository (and
  with partial clone, apparently).  So I don't think this is going to
  work.
* We take a reinitialize flag in initialize_repository_version and then
  set the algorithm to "sha1".  This is extremely easy, but it also
  poses some compatibility problems, because older versions of Git won't
  handle this configuration.
* We take a reinitialize flag and clear the value, which seems to be the
  best way forward.  I'll verify that this doesn't pose any unforeseen
  problems elsewhere in the testsuite and then send a patch.
--=20
brian m. carlson: Houston, Texas, US

--iUV/lbBrmPtUT9dM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1wGJAAKCRB8DEliiIei
geBVAP9AJZ/liIpyUtacezZhDLhX+XmnaKsmqK5fTpimUFPRHAEA1bIlPE/iGXxm
IR6vjS9DuiANkKRGH1YNjh0NfUY8IAs=
=yf0o
-----END PGP SIGNATURE-----

--iUV/lbBrmPtUT9dM--
