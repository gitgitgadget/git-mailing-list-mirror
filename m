Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE1DC433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 22:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiAUWJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 17:09:09 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:36604 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiAUWJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 17:09:09 -0500
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DDC585B227;
        Fri, 21 Jan 2022 22:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642802947;
        bh=NASK+ELLcKLDs50jdPU9Mb8Aoc0WO1oeC/2/d450i0Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uxV+1JVp520oRQwQPE09o3RdUi+QW39Zp71x4VvIlZTXq1XAWLk0NzxmRLCvsgH9N
         +ZmwWyrCm89llQ99RA2c0h04f0yBPorwFx3Ei/8EQi1bqbTK1mHN+5r0bZMbFIAH5C
         pqh20RQQnJiCpJXPe/RsCft5LUlRgWmzN02pNypD7peTJNAfeiLJB6cYvVNDOnlxBN
         7X1G+4hiHoLfdbXHtdp5atLIYfbCISjYS2hsTUBDEsXqndjPVJHwr/MP5d5LdiTR9O
         stapM1wVcG96RXxJZU1NO5t8BsGNhEXPToNpGj4/t3sGIaktsTr4hDiCRYa8ScPSKg
         5XWCMNAPoSdGv/eYwWsSCn0obPpxROYkhP83MURvRmK9CnIC8S9r+J/IEdl9ETvmVz
         ypnSzUcGSDy/7VAp2DXp/7FbJeT6FKEQodMj0r2xTbN3xw8yhrgLfIPLIu9ELjNo63
         SqyNlEqh4/bbCaq5r+KuCqUmy49SD7FaL6izMkSaGJSt1LX9/JN
Date:   Fri, 21 Jan 2022 22:09:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lauri Rooden <lauri@rooden.ee>
Cc:     git@vger.kernel.org
Subject: Re: Strange checkout with GIT_WORK_TREE
Message-ID: <YesvAkBnxq3xrHTV@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lauri Rooden <lauri@rooden.ee>, git@vger.kernel.org
References: <CAHqym3xs_M7BvvFDq2pHM-+DgK_nJcBakVEBL-GiNwnCRzMwWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0Uhfa0BpGVmfY2y8"
Content-Disposition: inline
In-Reply-To: <CAHqym3xs_M7BvvFDq2pHM-+DgK_nJcBakVEBL-GiNwnCRzMwWA@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0Uhfa0BpGVmfY2y8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-21 at 16:37:58, Lauri Rooden wrote:
> Does the GIT_WORK_TREE get lost on the middle of process
> or I am misunderstand the git checkout?
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> - I wrote a shell script to reproduce
>=20
> ```git-test.sh
> GIT_ROOT=3D$(mktemp -d)
> GIT_COPY=3D$(mktemp -d)
>=20
> echo "Create git repo with two commits: $GIT_ROOT"
> cd $GIT_ROOT
> git init
> echo 1 > a.txt
> echo 1 > b.txt
> git add *.txt
> git commit -m "Initial commit"
> echo 2 > b.txt
> git add b.txt
> git commit -m "Second commit"
>=20
> echo "Checkout to other work-tree: $GIT_COPY"
> GIT_WORK_TREE=3D$GIT_COPY git checkout HEAD~1
> git status
>=20
> echo "ORIGIN $GIT_ROOT"
> ls -la $GIT_ROOT
> echo "COPY $GIT_COPY"
> ls -la $GIT_COPY
> ```
>=20
> What did you expect to happen? (Expected behavior)
> - a.txt and b.txt checkouted to $GIT_COPY both with content `1`
> - current folder unchanged
>=20
> What happened instead? (Actual behavior)
> - only b.txt checkouted to $GIT_COPY
> - HEAD~1 checkouted in current folder but folder content remains HEAD

Here's what I believe is happening here.  When you run "git checkout
HEAD~1", Git notices that the only file that's stale in the index
compared to what's already present is b.txt; a.txt is up to date.  As
such, it only writes one file into the working tree, since only one file
needs to be updated.  This is an optimization, since for large working
trees, writing out every file every time would be extremely expensive.

I don't know what our official position is on switching working trees
like this. I would generally recommend you pick one and stick to it, but
if you want to do this, you'll need to update the index for the working
tree first.  You can do that by something like this in place of your
checkout:

  GIT_WORK_TREE=3D$GIT_COPY git update-index --refresh
  GIT_WORK_TREE=3D$GIT_COPY git checkout -f HEAD~1

That will inform Git that your working copy is stale and then the -f
flag to checkout will force Git to overwrite the missing files.

If your goal is to have multiple worktrees for one repository, you can
do that with "git worktree", which will keep separate indices for your
separate directories, provided they're on separate branches.  If you
just want to create a detached copy of the files for a repository from a
commit, you can do this:

  git archive HEAD~1 | tar -C "$GIT_COPY" -xf -

Hopefully that explains what's going on.  If you tell us a little bit
more about what you wanted to accomplish, we may be able to help you
find a way to do it that provides results that are at least less
surprising and more predictable.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0Uhfa0BpGVmfY2y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYesvAgAKCRB8DEliiIei
gRLrAP9Sa/k+uIHeNOlik8qt0Sox7bkTi46jRx8kJmNO2SQ8BAD+J/onLgiYC1vU
VZTx6Cs+exJNp5OAMgWB0i/9cmxbCww=
=gGHv
-----END PGP SIGNATURE-----

--0Uhfa0BpGVmfY2y8--
