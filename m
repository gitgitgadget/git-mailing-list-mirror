Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A635EB64DA
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 00:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGMAVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 20:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGMAV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 20:21:26 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22371995
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 17:21:24 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 04AE15A336;
        Thu, 13 Jul 2023 00:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1689207684;
        bh=BuBUGDI15DnT8A/iIA6s+jZ5DeTQj7fuXSBOQhN/ewM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=arK0Rq6GsoH0Ap+xQd1KVlUpKo54uhs/L+pvz7OJujHED1GA12Wm948Wyu+Zqj2AT
         M6pq4U2OKY71Huk3Fw4Ro4KJRiIKQ/RxwzoPrTScgBKcmm8EtMBTAjmuBal2wIvbkM
         iEO10pAGXW0B4mD+uuRVGf/VLUKpX47BVqkjtFQYYvOGFz98B1Li2FAAI334bCFjL8
         N9Lzsz1mpzSnQzFSphD3/GOB67Qj6cuNybrOIDD1XJwr8huPN7SOThbayIz7hrExDd
         iA9AIqpvjnA28Jiaf1LcD3wdisjmN1V4V5p4Hh8qQgm9wHoRp7LKmSfa+yF+ofy60H
         P5Qtb9CTmuNAQkHJu55Azx/5nTX5DN4YzR3urrldjNNZAA5RbvB8DYjAK6JYXfY15H
         yJYM4M1wEhUS86+K4KzHsTZTe0RlHlK2ctIBVG+TmMq7s4P9utPpnLZoiSOSZ0v5A4
         CsRx0Aso6ZrrtOa+swCSVvNjtp+SVFv8vvu+k3hImMrl2fRtfWs
Date:   Thu, 13 Jul 2023 00:21:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Juan M Uys <opyate@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug report: cloning private repo to absolute path doesn't work
 if gitconfig has includeIf directives
Message-ID: <ZK9Dgqgy5qRDKhG0@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Juan M Uys <opyate@gmail.com>, git@vger.kernel.org
References: <CADfPAEbgfvnS6JTwa5Y1Zt7gQ31GRUyjjjpX9mmpcwxsaTLPGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37rU1pdgcxSFEW86"
Content-Disposition: inline
In-Reply-To: <CADfPAEbgfvnS6JTwa5Y1Zt7gQ31GRUyjjjpX9mmpcwxsaTLPGw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--37rU1pdgcxSFEW86
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-12 at 16:21:38, Juan M Uys wrote:
> What happened instead? (Actual behavior)
>=20
> ```
> % git clone --depth=3D1 'git@github.com:myorg/myprivaterepo.git' '/tmp/so=
me-new-folder'
> Cloning into '/tmp/some-new-folder'...
> ERROR: Repository not found.
> fatal: Could not read from remote repository.
>=20
> Please make sure you have the correct access rights
> and the repository exists.
> ```
>=20
> However, if I remove the last argument, it works, and clones to the curre=
nt directory:
>=20
> ```
> % git clone --depth=3D1 'git@github.com:myorg/myprivaterepo.git'
> Cloning into 'myprivaterepo'...
> remote: Enumerating objects: 99, done.
> remote: Counting objects: 100% (99/99), done.
> remote: Compressing objects: 100% (87/87), done.
> remote: Total 99 (delta 7), reused 77 (delta 7), pack-reused 0
> Receiving objects: 100% (99/99), 5.66 MiB | 4.71 MiB/s, done.
> Resolving deltas: 100% (7/7), done.
> ```

Is the directory you're cloning to the same as above?  Do you see the
same behaviour as above if you switch to /tmp and run this:

  $ git clone --depth=3D1 'git@github.com:myorg/myprivaterepo.git' some-new=
-folder

> I separate my git organisations with different SSH keys with the help of =
a global git config:
>=20
> ```
> init]
>         defaultBranch =3D main
> [user]
>         email =3D opyate@gmail.com
>         name =3D Juan Uys
> [core]
>         excludesfile =3D /home/opyate/.gitignore
>         editor =3D vim
>         pager =3D less -FRX
>=20
> [includeIf "gitdir:/home/opyate/Documents/code/org1/"]
>         path =3D /home/opyate/Documents/code/org1/gitconfig
> [includeIf "gitdir:/home/opyate/Documents/code/org2/"]
>         path =3D /home/opyate/Documents/code/org2/gitconfig
> [filter "lfs"]
>         clean =3D git-lfs clean -- %f
>         smudge =3D git-lfs smudge -- %f
>         process =3D git-lfs filter-process
>         required =3D true
> ```
>=20
> And then each org's gitconfig typically looks like:
>=20
> ```
> [user]
>         name =3D Juan Uys
>         email =3D juan.uys@org1.com
>=20
>=20
> [core]
>         sshCommand =3D "ssh -i ~/.ssh/org1/id_ed25519"
> ```

My guess is that this is related.  If you're cloning into one of the
directories specified with `includeIf` above, then you'd be using a
specific SSH key to do so.  In such a case, you'd have access to
different things than if you cloned in a different repository.

That would explain why public repositories work: as long as you have
an SSH key valid for _some_ account on GitHub, you can clone any public
repository.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--37rU1pdgcxSFEW86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZK9DgQAKCRB8DEliiIei
gY6+AP0W3Xw7XGmOV6kc6FJ0nUkHv1u7lxncErquOUmVr0XjsAEA1jeQFb9945dP
OWBRRWd8Jt2I8DTQHNCZTkskGnh7mQQ=
=Pesp
-----END PGP SIGNATURE-----

--37rU1pdgcxSFEW86--
