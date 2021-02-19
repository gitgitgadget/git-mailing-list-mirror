Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04138C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 22:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF7E64E12
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 22:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBSW1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 17:27:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52046 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhBSW1S (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Feb 2021 17:27:18 -0500
Received: from camp.crustytoothpaste.net (unknown [97.105.19.220])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 300BA60DF4;
        Fri, 19 Feb 2021 22:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613773567;
        bh=QMNmo4fCtFApVhmq6OSF+BhBaZ3ssTsA3A6+iRAh+Q8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GPfUMZZy74V9ZFgCYWOzF64kKTVEdLGnZLtDSJ/cRLSYIm2Jc7hMw78RbB9epmIDP
         60W93dPPaR5I8MS20Sj1f+FDcSQftWppF1Bb7Uf90uqyG+EG72aG2RWRwzI9G+8XTu
         AKyjjcG+22HFHFiPpaq1BBRsJ+2aK2haeAzNec17oTLs8QFytFU92y4bIiF+RMidys
         0xB78ky+qgyW6eiDibvrJQtD6bql10JuxenS8dNm2yE3f4IkFwOsbcNDuP5FoXRN1j
         I+siX37QL2jys7F7A6wjadbzUTGSp/PPm0rqRT00uXXhcP75NxqUhgkJ2CHoVd3X1h
         ciKZ9RRzCD0P5ezx8wze3hTdqB/VFjflJg/Q6K51rC3hS+vMmiKPrVw57FJuzzZ1cJ
         UXWywq1Oa7SB8a9W11gGIbkFqdacR8VRGyTy4KYHRzNvAXo1yU5MXSi+lIQWVW9+QV
         ExzRAavVmDdUFNS9o8b8cV7JwrL2Pt+ijlApqp+aD0mGLKN2Rx4
Date:   Fri, 19 Feb 2021 22:26:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alireza <rezaxm@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: Considering merge --dry-run to foresee conflicts ahead of time
Message-ID: <YDA6+vm6GPQL3Jec@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza <rezaxm@gmail.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
References: <CAD9n_qiN+qXqR79z_4d+_8_mxa9eTFB42sTUT8CTF8=oQArQaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NwYR9fwuCJsduCkF"
Content-Disposition: inline
In-Reply-To: <CAD9n_qiN+qXqR79z_4d+_8_mxa9eTFB42sTUT8CTF8=oQArQaA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NwYR9fwuCJsduCkF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-17 at 17:21:45, Alireza wrote:
> I have a half baked alias for this and it proved to be extremely
> useful even in this state.
>=20
> ```
> check =3D "!f() { BRANCH=3D${1:-HEAD}; BASE=3D${2:-origin/master}; git
> merge-tree $(git merge-base $BRANCH $BASE) $BRANCH $BASE | sed -n
> \"/+<<<<<<< .our/,/+>>>>>>> .their/p\"; }; f"
> ```
>=20
> Of course with large conflicts it gets less useful. Getting only file
> names from the patch isn't straightforward either.
>=20
> So my question is what are the downsides to introducing a `merge
> --dry-run` option and what would it look like?

There aren't really any, but the current implementation of the merge
code makes it non-trivial, since it writes directly into the working
tree.  The new merge-ort code that Elijah Newren (CC'd) is working on
should at least support writing conflicts only into the index, and if
you didn't want to dirty the existing index, you could create a
temporary one with GIT_INDEX_FILE and write to that.  It may also
support a dry-run mode natively, but I'm not following it closely enough
to say.  Hopefully Elijah can say a little bit more about things.

In the mean time, since this is a frequently requested feature, I have a
Rust-based tool called git test-merge[0] that runs a test merge between
two arbitrary trees and determines whether it succeeds or fails.  It
uses libgit2 under the hood.

[0] https://github.com/bk2204/scutiger
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--NwYR9fwuCJsduCkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYDA6+QAKCRB8DEliiIei
gQm0AP96FD3sGhgVtsHOZsC/6KGWb5gSwfgzrG8ALhwyyH9cdAEAlLdLw/S5+Xuy
RjnI16TlO3wgJ/mC0mIBs2mCwB0o8gA=
=/Ljo
-----END PGP SIGNATURE-----

--NwYR9fwuCJsduCkF--
