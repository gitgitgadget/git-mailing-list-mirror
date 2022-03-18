Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F00C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 20:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiCRUQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 16:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbiCRUPm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 16:15:42 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D125CBB6
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 13:14:08 -0700 (PDT)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4526A5A0CA;
        Fri, 18 Mar 2022 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1647634447;
        bh=yQ9djN1RENCVoXqoQxKeCwhcZ0+9cbZYB2xmmHswyYM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Vtg+XF9kcnMWzbkhmWcWGVbT/m9dnFd3slA5OWY15MLC8RcSzoA1mol0KYGNrR5Rk
         LdydvOrvUrq2y9IGbVy1uPDDLjA+uM/9UloW7CD1JLTN5jJaBDAdXsgPof4qDIXRqd
         YPr9MFhybla1LyAXZsGZmbQ7UzhlurP1WEA0UGlK3fL3RXCOLdOiBMjON8ke2wnWeY
         W9jPdg3fvbHFgmszMLiZVxfpmx8n3eF00fmVIpQsgaZRSqXqZW4IwMSrz4cZSC2sOe
         HSwmJAgW7bceADOSIkTB8hfQhS/pFM0tsfdGxghmz1L8rCOMCKAbhMA2Z7dtR2BA5a
         NcD0wgcVKNqtuztVR8Nuagch5IgKZM9LDcHmLREm/DOHbyHwoMMp8fUFQMgPWc1h2s
         s4oYjRZTycDV0dyf0dXHXmj9UrfpzH7f/GbHdrYc0ZrXcduuaCO0Jq4dRyHSEwtkdx
         cHTzEQAwq7xTJd93uFcOA140wqTmshxzHbjSBCQjO0uwPGYtujX
Date:   Fri, 18 Mar 2022 20:14:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org
Subject: Re: how to automatically open conflicted files when "git rebase"
 encounter conflict
Message-ID: <YjToDb9Mz9Q9z4Bq@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
References: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TuUs7UWM0CBYeIsD"
Content-Disposition: inline
In-Reply-To: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TuUs7UWM0CBYeIsD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-18 at 02:00:52, wuzhouhui wrote:
> Hi
>=20
> When "git rebase" stopped due to conflict, I have to manually open
> conflicted
> file one by one and resolve conflict, and the typing file path is too
> boring.
> So, how to automatically open (e.g. use Vim) conflicted files?

I agree that in the typical project with a few levels of directories
this is a hassle.

Fortunately, there are lots of ways to do this.  The way I happen to do
it is with an alias:

  [alias]
    conflicted =3D "!f() { git status -s | grep -E '^(DD|AA|.U|U.)' | cut -=
b4-; };f"

and then I run this:

  git conflicted | xargs nvim-gtk

To preempt someone pointing this out, you would want to use "git status
--porcelain" for scripting instead of "git status -s", but I happen to
know what I'm doing in this particular case (and have reasons for it)
and can fix things if it breaks.  You should probably use --porcelain.

My approach also works less well if you have files with spaces or other
characters special to the shell.  That can be fixed with using
NUL-terminated strings if that's a problem for you (it isn't on the
projects I work on).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--TuUs7UWM0CBYeIsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYjToDAAKCRB8DEliiIei
gZsyAQCHBkaqCPlM2Kp6bsdvV+SbOLZ8AuKP5+erAp0IU9zx0wD/cDKu2Lt/Zlmg
SraX7t+wheDiAbpic3FZQZS6AR/Zswg=
=IRWT
-----END PGP SIGNATURE-----

--TuUs7UWM0CBYeIsD--
