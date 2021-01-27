Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95410C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F88207A0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbhA0NZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:25:26 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238367AbhA0NXR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jan 2021 08:23:17 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D48960794;
        Wed, 27 Jan 2021 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611753721;
        bh=yH3rQyY9fCFbzCwFF2BMrUgJ0szyERiMqGCLPN7dsTE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ked/LIXOizzidDLYMC4+V7JpcMFdIgho7y/1oX28TUtC+A79dXbwhwVOQTpL83kEw
         OpwvtgqjDTV0LzVM7H7vI5zF8t+J1NrMLfXEvjQQXxAHRlawbezKFqQbKjDLcZFru/
         IrKS9Wcd0Ba1J/AiWj8H5Qh12DbOGk6CWUWp365ErkfvID31purGRqwjOffvmCpEFS
         Rpur7+Epr3KAK8840VaRxZ3BcsuTZflT57oSVsy9HqyVy52wZ82fWLuk7Cg5alDDnA
         WPcLM9vv2PZuxUzF0Ojqfqawv8O43ZInP3+w63TY9tb7/J0atbMdjtQk/HnHuZnXOV
         EKc7RJzEtJS8LwUTf8nPl02OuT0TupgiCsBqu2DH+H8dglLV/nL3/ka1sAD4YVkdH+
         ZbymGkAS4B12eO02Hud2e7XfRQuIlfAsHUcLt4C2YZDXb4OKr4IN/te4YeiTSasRfC
         3sX8ltBmlSHm7blmZYusk0jIel5qGVTPeC6RRyl6SA3YI46woFo
Date:   Wed, 27 Jan 2021 13:21:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Daniel Lublin <daniel@lublin.se>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git stash push --patch offers skip-worktree hunks
Message-ID: <YBFo8xJu57fC1PO/@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Lublin <daniel@lublin.se>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <rur7en$16bk$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L8UDbpjrm1lnUOS5"
Content-Disposition: inline
In-Reply-To: <rur7en$16bk$1@ciao.gmane.io>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--L8UDbpjrm1lnUOS5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-27 at 08:15:19, Daniel Lublin wrote:
> Hi,
>=20
> I'm using this to hide some locally modified files from accidental commit:
>=20
>   git update-index --skip-worktree ...

This isn't the intended purpose of this functionality, and as you've
seen it doesn't work properly for that case.  From gitfaq(7):

How do I ignore changes to a tracked file?

  Git doesn't provide a way to do this.  The reason is that if Git needs
  to overwrite this file, such as during a checkout, it doesn't know
  whether the changes to the file are precious and should be kept, or
  whether they are irrelevant and can safely be destroyed.  Therefore,
  it has to take the safe route and always preserve them.

  It's tempting to try to use certain features of `git update-index`,
  namely the assume-unchanged and skip-worktree bits, but these don't
  work properly for this purpose and shouldn't be used this way.

  If your goal is to modify a configuration file, it can often be
  helpful to have a file checked into the repository which is a template
  or set of defaults which can then be copied alongside and modified as
  appropriate.  This second, modified file is usually ignored to prevent
  accidentally committing it.

There is a lot of misinformation on Stack Overflow, which is why I wrote
that FAQ entry.  Unfortunately, I can only downvote a wrong answer once.

The skip-worktree bit is designed to prevent the file from being checked
out as part of sparse checkout.

> Doing `git stash push` does not result in the above modifications being
> stashed. But, doing `git stash push --patch` asks me about hunks in the
> files which were flagged to skip-worktree. Instinctively, this feels wron=
g.
> The docs also say:
>=20
>   Interactively select hunks from the diff between HEAD and the working t=
ree
>   to be stashed.
>=20
> What do you think?

It looks like there is a test for the case without --push in t3903, and
it looks like Dscho (CC'd) last touched it, so maybe he's familiar with
what might be going on here.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--L8UDbpjrm1lnUOS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYBFo8wAKCRB8DEliiIei
gZH0AQCMcDhnllzecLvLGv3Egga9ZV6Tx+pCvMM393Vv55EFmQEAscJ9yV3oeOOH
lzDmGQq9LU275ikb3iGTltmyOwpAwA0=
=ICMD
-----END PGP SIGNATURE-----

--L8UDbpjrm1lnUOS5--
