Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1089EEAA71
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjINVhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINVhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 17:37:14 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C52705
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 14:37:10 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BB9EE5A225;
        Thu, 14 Sep 2023 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1694727429;
        bh=O0EubOP8s+P2L2G5vWJSixOQKyNcsf0nudhKIrHAFVg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=RThs7tC66RZqjmF5tWG0ekfLyPD232TNs20s0tDIUGOVG/naZzB8eTKylSoEqmD0D
         ixmbS/lJU7lCv39ztlAptHJPRIRYsEFv5aEimEELWAWBilHaDHPOQ7zeZDwSyIBszh
         J+LWkaeG9F5736JnNg7Mmngkt8ZFFGHNTxAXI5MnfDYPyihwgGzPg+JHoA+1qbIrBZ
         m0eHEELv4Hir1QRLYwfqIlMv87yD5H9+XLZn37Rwa0iKxDJulzJvFrDm8cLFKCPvra
         OPtexiJlbB9Qrr+1Z7o5SlzZ8SLcxzJTJ5kTHi+GSQ+prN7MZuPfU8JJ/bCvQtHV1R
         uKZ3/d7iNF7nwzoJTDFQ1BHVfpwR56zsUCMDPiSy3Hsv13V8uLmdRJDKRK3ThxPziL
         5Mp3Ax6OMPRYB0h34Q5YtjsViYP/j+ZC32BAPwWLmh4yWC8lk15dQFwrwhopJFuLJW
         UlzgOgT6+d1jGl4+torf62WAGaL4MLm7LPELqede6em8vwB/EnU
Date:   Thu, 14 Sep 2023 21:37:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Blake Campbell <bc@mpbell.io>
Cc:     git@vger.kernel.org
Subject: Re: skip-worktree autostash on pull
Message-ID: <ZQN9Azt/K28WLfqH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Blake Campbell <bc@mpbell.io>, git@vger.kernel.org
References: <AB6A85F5-3E76-4462-931E-AD76E0066C37@mpbell.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iUbctHyipH5f/Jop"
Content-Disposition: inline
In-Reply-To: <AB6A85F5-3E76-4462-931E-AD76E0066C37@mpbell.io>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iUbctHyipH5f/Jop
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-09-14 at 09:54:30, Blake Campbell wrote:
> Hi all - I use update-index --skip-worktree on some config files that
> I change locally and don=E2=80=99t want to commit, but every time I pull =
=66rom
> the remote I have to go through a process of no-skip-worktree, stash,
> pull, stash pop, then skip-worktree again, which is all a bit tedious!
> Ideally some switch like --autostash for git pull would be really
> useful. Does anyone know if something like that exists?=20

The Git FAQ[0] outlines that, as you've noticed, skip-worktree doesn't
work for ignoring changes to tracked files:

  Git doesn=E2=80=99t provide a way to do this. The reason is that if Git n=
eeds
  to overwrite this file, such as during a checkout, it doesn=E2=80=99t know
  whether the changes to the file are precious and should be kept, or
  whether they are irrelevant and can safely be destroyed. Therefore, it
  has to take the safe route and always preserve them.

  It=E2=80=99s tempting to try to use certain features of git update-index,
  namely the assume-unchanged and skip-worktree bits, but these don=E2=80=
=99t
  work properly for this purpose and shouldn=E2=80=99t be used this way.

If you take the advice in the FAQ, then the config files won't be
tracked and you won't have this problem:

  If your goal is to modify a configuration file, it can often be
  helpful to have a file checked into the repository which is a template
  or set of defaults which can then be copied alongside and modified as
  appropriate. This second, modified file is usually ignored to prevent
  accidentally committing it.

Your particular case is one of many reasons we suggest this approach.
There is in fact an --autostash argument in git pull, as well as git
rebase, both of which work as you might expect, but in general they
still won't work properly with --skip-worktree and given the FAQ entry
above, we wouldn't add support for that in the option.

[0] https://git-scm.com/docs/gitfaq#ignore-tracked-files
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--iUbctHyipH5f/Jop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZQN9AgAKCRB8DEliiIei
gYarAQDJQdn1VzZc8mfue1B8xKepD6GbxVYd2aSX9pbTL0ewpwD/fkfWmGLP84ss
iQr6fkRffl9zDMAAVJRf9R2O/D+gVQk=
=cRYT
-----END PGP SIGNATURE-----

--iUbctHyipH5f/Jop--
