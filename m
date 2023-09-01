Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0708DCA0FE1
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 11:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbjIALPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 07:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjIALPM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 07:15:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841AE8
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 04:15:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-56963f2e48eso1368845a12.1
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693566909; x=1694171709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FTri29mlsgkKDOuX86gDH9K6s7uFnsHjKE4SHET1lcg=;
        b=sySPrdEnzMGObIlUcDt34PeHam6Wt/SprLiPNMt6NzGIxMTKTiG5BZY5AiWEZ4V7Tc
         5q/1uOHuN/j9F6bjQGz/0HPhsaYnoUGgvd6ilZpwpBH1+xZU4tdCy3iajPbE/YbGHBkT
         q0Vqx5DCsbPkuwNJSLxrhSepADhvlNK2p/W4TF/TIvwasitYESB9BNj4TuJ5wPPYA+ty
         VGI0aQXsA1U73ifGWzAvQKxFuN1GwfuvemMHy+JhWiXfLIryfJe5Vgk5DTJCieAPR3/y
         2nuDa/4lwW3A9RiLZOy1sxeDCqTPVdcIlxb0pJlCIhZmv5ih+gAdy2f8+pzkiGs5OkfY
         e+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566909; x=1694171709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTri29mlsgkKDOuX86gDH9K6s7uFnsHjKE4SHET1lcg=;
        b=GV7TXaWplwK3BluA61ux0juyYDo3Fv3500EZbM3B15jhFB5Jldys6hb2bQribJueiM
         00NBbubc2knCfz0PBLbcqiD6A3SJccOur0l86AIsglYR5MAz+vKYkPQuTadapNxI6+CN
         PDzkxxngYVJdrOd/kknlr7TVM3qVXR0FsUX5T5maCI9pdhZ3tE4AGObr92IppNczesnJ
         xw+NqYLOeAhGUY1zPTi0t4G0pgomCjjz12IGF+XzexaTXEr2E+m1NBml6uzGEqX8OqBm
         hspPRn087XjhkQEofHq4LVNDW0Mt2mMCkkI4UwUmIZ3yrCkSdZ+dqvAHHzkCGpIJuI9x
         sqlA==
X-Gm-Message-State: AOJu0YwVVmpzD+Yd4P+5SxeHpLxloRcrkMMDV2Ia5/pT6w70uy9dR5mS
        Ad2jIhO/naLToQlHq5v0HXw=
X-Google-Smtp-Source: AGHT+IGiJ1BBU9IxSGfgWtzuRo+Ds1oUyPqt3EBHMI65d+0wDS2CNsCla5bLlGkpsWjW0V8lWIUWtA==
X-Received: by 2002:a17:90a:c90c:b0:269:2356:19fb with SMTP id v12-20020a17090ac90c00b00269235619fbmr1907046pjt.15.1693566908788;
        Fri, 01 Sep 2023 04:15:08 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090a8b8b00b00267fbd521dbsm4455656pjn.5.2023.09.01.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:15:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5B2E4814B404; Fri,  1 Sep 2023 18:15:06 +0700 (WIB)
Date:   Fri, 1 Sep 2023 18:15:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     mingli zhang <zmlfoolishfish@gmail.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [bug]fatal: fetch-pack: invalid index-pack output
Message-ID: <ZPHHuiFn3v06hhVe@debian.me>
References: <50B3E989-0405-4B05-9940-D3943C62260A@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g9858mN2VP3Be0xv"
Content-Disposition: inline
In-Reply-To: <50B3E989-0405-4B05-9940-D3943C62260A@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--g9858mN2VP3Be0xv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 14, 2022 at 05:09:13AM +0800, mingli zhang wrote:
> HI,
>=20
> At some point, I exec git pull/fetch/clone will got a fatal message:
>=20
> ```
>=20
> fatal: fetch-pack: invalid index-pack output
>=20
> ```
>=20
> I use git 2.36.1 on MacOS Monterey 12.3.1
>=20
> ```
> git --version
> 04:51:36.776640 git.c:459 trace: built-in: git version
> git version 2.36.1
>=20
> ```
>=20
> Example:
>=20
> ```
>=20
> zml@localhashdata postgres % git pull -r
> 04:53:33.553655 git.c:459 trace: built-in: git pull -r
> 04:53:33.640927 run-command.c:654 trace: run_command: git merge-base --fo=
rk-point refs/remotes/origin/REL_14_STABLE REL_14_STABLE
> 04:53:33.651808 run-command.c:654 trace: run_command: git fetch --update-=
head-ok
> 04:53:33.658822 git.c:459 trace: built-in: git fetch --update-head-ok
> 04:53:33.683642 run-command.c:654 trace: run_command: unset GIT_PREFIX; G=
IT_PROTOCOL=3Dversion=3D2 ssh -o SendEnv=3DGIT_PROTOCOL git@github.com 'git=
-upload-pack '\''postgres/postgres.git'\'''
> remote: Enumerating objects: 16843, done.
> remote: Counting objects: 100% (16231/16231), done.
> remote: Compressing objects: 100% (4164/4164), done.
> 04:53:40.822310 run-command.c:654 trace: run_command: git index-pack --st=
din -v --fix-thin '--keep=3Dfetch-pack 70208 on localhashdata' --pack_heade=
r=3D2,10035
> 04:53:40.828465 git.c:459 trace: built-in: git index-pack --stdin -v --fi=
x-thin '--keep=3Dfetch-pack 70208 on localhashdata' --pack_header=3D2,10035
> remote: Total 10035 (delta 8554), reused 7150 (delta 5805), pack-reused 0
> Receiving objects: 100% (10035/10035), 6.93 MiB | 2.42 MiB/s, done.
> fatal: fetch-pack: invalid index-pack output
>=20
> ```
>=20
> I try to config memory or use git pull -r --depth 1, but didn=E2=80=99t h=
elp.
>=20
> My git config is
>=20
> ```
> [core]
> packedGitLimit =3D 512m
> packedGitWindowSize =3D 512m
> compression =3D 0
>=20
> [pack]
> deltaCacheSize =3D 2047m
> packSizeLimit =3D 2047m
> windowMemory =3D 2047m
> ```
>=20
> And the code dir permission is
>=20
> ```
> drwxrwxrwx
>=20
> ```
>=20
> Any suggestions ?

Related discussion is in [1] with the fix for OpenSSL users is in [2].
Please test.

[1]: https://lore.kernel.org/git/ZPCL11k38PXTkFga@debian.me/
[2]: https://lore.kernel.org/git/20230901020928.M610756@dcvr/

--=20
An old man doll... just what I always wanted! - Clara

--g9858mN2VP3Be0xv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZPHHugAKCRB7tWyQc2rT
CMtTAQDZoGjZiIQ/7iimm28Kngomfww/mlk0CqV6SJLAZWgHWgEA/4Q/651TOt4s
sAmfS47B8XNbFAIDdyMnV/ylut8uGgQ=
=aF95
-----END PGP SIGNATURE-----

--g9858mN2VP3Be0xv--
