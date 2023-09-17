Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E2CD37B4
	for <git@archiver.kernel.org>; Sun, 17 Sep 2023 13:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjIQNVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Sep 2023 09:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjIQNV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2023 09:21:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21412F
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 06:21:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c39a4f14bcso34394815ad.3
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694956883; x=1695561683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO3I9A2vOCdAiKhNR2/Xj55vbzv9rv11NF4hinSRE4E=;
        b=apCjwiLCjVPmF8otHoR9CivyAPtr6Eya4fMLUqd973h5FF4CIrPAVct7v4RXTd4tcN
         0kVsImQqXucqqX02HBk9t0KzCJTDUJ4zD8xp4XG6ILfGBX06RoHjU5CxAKzI8bCyP+nX
         m/bhVgH/3pofM0xjV62E1kWnOw0pR4MfmgzsgWMfMxT3P38PoSoKiLWL2YekrTQ9Xd00
         1DNjJDZBLLh9VYdUhFNEZhs/qKIgFugl/MiwFfphrsP4Uf8lDcy3hwkLVaO2BwaK/g2O
         5BzxPLJzX2UX3FUB1hP3+5wyzFsEeQ0WANeAWmbS7alkDyhK8k3xyaY2GPvBfBYcsMs4
         MdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694956883; x=1695561683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO3I9A2vOCdAiKhNR2/Xj55vbzv9rv11NF4hinSRE4E=;
        b=DdzMs729AyD144wuA3m0txZiRKttmM2PzY4P9+vuZZk1xbQgiBoEdbsIs/Thv+lqlo
         HsiTxLDJL3eVFMLholMA8izEElRuV1ExQGfMJ/O86Y19K7JvtUT3A0eu4Bc3sdYvFJdp
         e92BORzNbK740Q7DJjOcpU4uXTmyP0UZEDVvzKL/LNifKyWPMMDRAZ/s6GZ3Dspo+FjN
         0r8j4Q89Oa7e3JW0BvwaKvZlqLg9LyRl8MT4TMd2H8jUnZMnFTf7zm6z6f9bcTE+gmi+
         9x784ZVp7kRI6fU9KIux3PV/sdY4Kxl2c5PqJGnsfqFhoMUD3HQfQM6KqidD1NKHthRj
         saPQ==
X-Gm-Message-State: AOJu0YxXY+lJXMJrJw/ySAWwTjk3OcqKU30QpQeyk2Qy+Lj8ToKqEmBy
        wC8k+tKmEku6tLNkHvvDhmc=
X-Google-Smtp-Source: AGHT+IHSyTbRsmPt5iCWqnVYR4rwVO+29i9SzDSKqOtJ+LRW/4lzJD/5SuWmyoNdgqDaKhrkBRCIGA==
X-Received: by 2002:a17:903:22cc:b0:1c4:13f:9dd3 with SMTP id y12-20020a17090322cc00b001c4013f9dd3mr8812070plg.62.1694956883204;
        Sun, 17 Sep 2023 06:21:23 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902968600b001bdcde49bc3sm6580955plp.119.2023.09.17.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 06:21:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A1D8D8A3C179; Sun, 17 Sep 2023 20:21:18 +0700 (WIB)
Date:   Sun, 17 Sep 2023 20:21:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Javier Mora <cousteaulecommandant@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] `git push` sends unnecessary objects
Message-ID: <ZQb9Thxa5X-Fo5mj@debian.me>
References: <CAH1-q0iV+E73RrUDA8jcoFgNEfQDNwRnX5P5Z7r3Qj3GESV_7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GTo949nLYpNz+6Lh"
Content-Disposition: inline
In-Reply-To: <CAH1-q0iV+E73RrUDA8jcoFgNEfQDNwRnX5P5Z7r3Qj3GESV_7g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GTo949nLYpNz+6Lh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:59:35PM +0100, Javier Mora wrote:
> I came across this issue accidentally when trying to move a directory
> containing a very large file, and deleting another file in that
> directory while I was at it.
> It seems to be caused by `pack.useSparse=3Dtrue` being the default since
> v2.27 (which I found out after spending quite a while manually
> bisecting and compiling git since I noticed that this didn't happen in
> v2.25; commit de3a864 introduces this regression).
>=20
> * Expected:
>     Pushing a commit that moves a file without modifying it shouldn't
> require sending a blob object for that file, since the remote server
> already has that blob object.
> * Observed:
>     Pushing a commit that moves a directory containing a file and also
> adds/deletes other files in that directory will for some reason also
> send blobs for all the files in that directory, even the ones that
> were already in the remote.
> * Consequences:
>     This has a very big impact in push times for very small commits
> that just move around files, if those files are very big (I had this
> happen with a >100MB file over a problematic connection... yikes!)
> * Note:
>     The commit introducing the regression does warn about possible
> scenarios involving a special arrangement of exact copies across
> directories, but these are not "copies", I just moved a file, which
> seems like a rather common operation.
>=20
> Code snippet for reproduction:
> ```
> mkdir TEST_git
> cd TEST_git
>=20
> mkdir -p local remote/origin.git
> cd remote/origin.git
> git init --bare
> cd ../../local
> git init
> git remote add origin file://"${PWD%/*}"/remote/origin.git
>=20
> mkdir zig
> for i in a b c d e; do
>     dd if=3D/dev/urandom of=3Dzig/"$i" bs=3D1M count=3D1
> done
> git add .
> git commit -m 'Add big files'
> git push -u origin master
> #>> Writing objects: 100% (8/8), 5.00 MiB | 13.27 MiB/s, done.
> #^ makes sense: 1 commit + 2 trees (/ and /zig) + 5 files =3D 8;
> #  5 MiB in total for the 5x 1 MiB binary files
>=20
> git mv zig zag
> git commit -m 'Move zig'
> git push
> #>> Writing objects: 100% (2/2), 233 bytes | 233.00 KiB/s, done.
> #^ makes sense: 1 commit + 1 tree (/ renames /zig to /zag) =3D 2;
> #  a,b,c,d,e objects already in remote
>=20
> git mv zag zog
> touch zog/f
> git add zog/f
> git commit -m 'For great justice'
> git push
> #>> Writing objects: 100% (9/9), 5.00 MiB | 24.63 MiB/s, done.
> #^ It re-uploaded the 5x 1 MiB blobs
> #  even though remote already had them.
> ```
>=20
> Note that the latter doesn't happen if I use `git -c pack.useSparse=3Dfal=
se push`.

I can reproduce this regression on v2.42.0 (self-compiled) on my Debian
testing system.

Cc'ing Derrick and Junio.

Thanks for the report!

--=20
An old man doll... just what I always wanted! - Clara

--GTo949nLYpNz+6Lh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZQb9SQAKCRB7tWyQc2rT
CFX5AP991BfviEuy/ospufMDvNbWujI6Xwt8dHASymjrmx0t6QD9EJktFUXZdCCB
8/ulvPrIxvmIQgLXp+22yvTxKLiHlQ0=
=/dYm
-----END PGP SIGNATURE-----

--GTo949nLYpNz+6Lh--
