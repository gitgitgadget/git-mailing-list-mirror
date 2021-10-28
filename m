Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62AC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A941D610FC
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhJ1Wfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:35:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43406 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231298AbhJ1WfW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Oct 2021 18:35:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 417DF6042C;
        Thu, 28 Oct 2021 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1635460343;
        bh=31RLcqtTL0YDC+iab452GX7/ghk0h+qaCxVU1VyPyeY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KNurDj56wxZGPP9GLmy49zUhYPgQMpATdzeKtqgrihBni6uYUTYJA3Rbo5Z8kXafB
         ASXRYupQVzKkfjZKTaTI2Nap6ix0F34JYC62R3eu2VvYtnE7SRO04GY/+NhixMw5ek
         sP4Fh4IJRcE69L2Zydxbl+p2lhdppETBM5fFAhUi5HUusQW1tEOgU549p9fFXML9vc
         LmOdC9hqc8iiupttkti+iiFXiuXIO68YLtSgHDP/YFOFRMeFvEo7UPgvWDoI3XlV4Q
         Rzb3dT5nvZj6nje9P66Sps/EKUrNSYGqKJ5COdEGNBphp3ehKGizE/821A/o9mSsjz
         G8NSYbQxc8tU2wgZwG54ie3atUf7VXC4n6njuybUE+PGNFfqEMI3IRKGqw3zDr2nSX
         +E2x2ZFcMjvb5rgozchrkX7fk13xhmHeOxLKXTnRFnafhMKPyNqcuX9I28CSOoeflj
         Fkc1VwtZhsOPev90eJPNoaaBMRVIEZdsVFs5OGGiQ5OJ8Hwri2r
Date:   Thu, 28 Oct 2021 22:32:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/7] Allow clean/smudge filters to handle huge files
 in the LLP64 data model
Message-ID: <YXsk8XBwmErf2I3I@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
 <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4FSX5M00lL+DLVP"
Content-Disposition: inline
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--b4FSX5M00lL+DLVP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-28 at 20:50:30, Johannes Schindelin via GitGitGadget wrote:
> This patch series came in via the Git for Windows fork
> [https://github.com/git-for-windows/git/pull/3487], and I intend to merge=
 it
> before v2.34.0-rc0, therefore I appreciate every careful review you gentle
> people can spare.
>=20
> The x86_64 variant of Windows uses the LLP64 data model, where the long d=
ata
> type is 32-bit. This is very different from the LP64 data model used e.g.=
 by
> x86_64 Linux, where unsigned long is 64-bit.
>=20
> Most notably, this means that sizeof(unsigned long) !=3D sizeof(size_t) in
> general.
>=20
> However, since Git was born in the Linux ecosystem, where that inequality
> does not hold true, it is understandable that unsigned long is used in ma=
ny
> code locations where size_t should have been used. As a consequence, quit=
e a
> few things are broken e.g. on Windows, when it comes to 4GB file contents=
 or
> larger.
>=20
> Using Git LFS [https://git-lfs.github.io/] trying to work around such iss=
ues
> is one such a broken scenario. You cannot git checkout, say, 5GB files. H=
uge
> files will be truncated to whatever the file size is modulo 4GB (in the c=
ase
> of a 5GB file, it would be truncated to 1GB).
>=20
> This patch series primarily fixes the Git LFS scenario, by allowing clean
> filters to accept 5GB files, and by allowing smudge filters to produce 5GB
> files.
>=20
> The much larger project to teach Git to use size_t instead of unsigned lo=
ng
> in all the appropriate places is hardly scratched by this patch series.
>=20
> Side note: The fix for the clean filter included in this series does not
> actually affect Git LFS! The reason is that Git LFS marks its filter as
> required, and therefore Git streams the file contents to Git LFS via a fi=
le
> descriptor (which is unaffected by LLP64). A "clean" filter that is not
> marked as required, however, lets Git take the code path that is fixed by
> this patch series.

This series seems sane to me.  I'm delighted we can fix this issue with
so little code, since it's a been a very inconvenient problem for a lot
of Windows users.

I might suggest when we make the giant transition project in the future
that we use size_t for things that are going to be in memory and off_t
or, if necessary, intmax_t for general object sizes so it's clear which
one we want.  However, that has no effect on this series since this
intentionally has a limited scope.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--b4FSX5M00lL+DLVP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXsk8AAKCRB8DEliiIei
gf/NAPsEB9vjbAuxTT5/53BzG6KABdTmCEuC/VLW7fvAPEC8eAD+IX+L9KFCjRV3
w6R37cglzO50WZ2olb/eqt6qwDTz+gU=
=050C
-----END PGP SIGNATURE-----

--b4FSX5M00lL+DLVP--
