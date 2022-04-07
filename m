Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22097C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 21:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiDGV0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 17:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiDGV0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 17:26:09 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD868194566
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:24:05 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6C5215A0EC;
        Thu,  7 Apr 2022 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649366644;
        bh=RdaVTcCprVNIcdqzNfmKJjylSx6wTTZY/v4RsR/pUo4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fU3Kvuj7Tp3uNtKYkkwR9i3qZlIXvkkRGM3FaPlhv926LpGFBT3i9URmCSph2k4Kl
         04N+jKcyyTGfyTGeC+DrEKJYX8+La3Tr2cpBqMiOWtwCvhZrzWpQ0a5FXGT8/H0OQi
         r6l9sK6rm+otpEGlFzd8x2J4/VeNArhy61qrjcufe0Zkw2mgsoObbFib6mwybzv3DM
         TKtJ8qPpJeNWyQQpOK5gFN/Xn/28AB3kfyKLFbEo8B1bm6EPQrCTPBydhl9kRbDIWo
         X3SXQQzQVLmHd3y3axMIpwaT+6YBElUJ+7N6PzNEb1FYFQhHPnAsFf+QqmElUZCV5D
         4tYz+5WhqVDpNVvCl8oqgxO/eAY7cMYOwxkd8jZTcDIznExaLGg98ZC5TH+dwa6Yz2
         mHQ/fsJLgtY8Xg7g0Ca5E3OcTyBCVooe8AavJ1JV9BNVrYEGLdGIURPUw4NPtoopC8
         wP/96lzXoE8exzCsrOo22oD7aKkn0JhbzD2Xwoio34KYK/E1MeU
Date:   Thu, 7 Apr 2022 21:24:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>, justin@justinsteven.com,
        Taylor Blau <me@ttaylorr.com>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bpa05EigPvl9XRt1"
Content-Disposition: inline
In-Reply-To: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bpa05EigPvl9XRt1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-06 at 22:43:08, Glen Choo wrote:
> An attack might look like this:
>=20
> * Attacker creates a repository where subdirectory "Documentation/" is a =
bare
>   repository i.e. it contains "HEAD", "refs/" and "objects/" [4]. Attacker
>   also adds "config" with a malicious setting for core.fsmonitor.
> * Attacker convinces User to read their project's documentation by `git
>   clone`-ing their repository and inspecting the "Documentation/" directo=
ry.
> * User cd-s into "Documentation/" and their shell prompt runs `git status=
`,
>   executing the core.fsmonitor command defined by Attacker.

As mentioned elsewhere, git status doesn't work without a working tree.

> =3D Next steps
>=20
> I propose that we prevent repositories from containing bare repositories =
by
> doing the following (in order):
>=20
> * Implement (2) by adding a new fsck message "embeddedBareRepo".
>   * When this is done, hosting sites can hopefully use this capability to
>     prevent transmission, and help us understand the prevalence of such a=
ttacks.
> * Implement (1b) by teaching unpack_trees.c to check whether the tree con=
tains
>   an entire bare repo, and die() if so. This will be guarded by a
>   defaults-to-true config value.
>   * This would only block a bare repo from being written in a single oper=
ation.
>     It wouldn=E2=80=99t stop a user from writing a bare repo entry-by-ent=
ry using "git
>     checkout <path>", but the amount of social engineering required proba=
bly
>     renders this attack infeasible.
>   * As I noted earlier, I foresee some difficulty actually implementing t=
his
>     because I don=E2=80=99t think we have facilities for checking multipl=
e tree entries
>     at once.

I'm aware of repositories that happen to break in this case.  It's not
uncommon to embed bare repositories when working with tools that involve
Git, and this will definitely break them.  git fast-import isn't always
a valid option because the test data may involve specific structures or
tooling that can't be replicated that way, or it involves things like
commit signatures which aren't round-tripped.

Instead, I'd rather see us avoid executing any program from the config
or any hooks in a bare repository without a working tree (except for
pushes).  I think that would avoid breaking things while still improving
security.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bpa05EigPvl9XRt1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYk9WcAAKCRB8DEliiIei
gaEtAP4muyynkzCzxVWOSKBoqsUt6o3KNOSd/zEFypbgGVjSyQEApUTqyA9oslZN
/L6UfEXQGnof3fhOZG/Onp96vIqzgwo=
=5OcZ
-----END PGP SIGNATURE-----

--bpa05EigPvl9XRt1--
