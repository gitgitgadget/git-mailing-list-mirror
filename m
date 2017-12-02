Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD3B20C11
	for <e@80x24.org>; Sat,  2 Dec 2017 10:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdLBKvw (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 05:51:52 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.238]:34375 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdLBKvv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 05:51:51 -0500
X-Greylist: delayed 651 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Dec 2017 05:51:51 EST
X-Interia-R: Interia
X-Interia-R-IP: 89.64.32.79
X-Interia-R-Helo: <localhost>
Received: from localhost (89-64-32-79.dynamic.chello.pl [89.64.32.79])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sat,  2 Dec 2017 11:40:53 +0100 (CET)
X-Hashcash: 1:24:171202:johannes.schindelin@gmx.de::9BnBRALIKpNiS5Jx:0DuX4
X-Hashcash: 1:24:171202:git@vger.kernel.org::CWZ2Bl54h/ZMf/Vo:0VER4
X-Hashcash: 1:24:171202:sbeller@google.com::P+XR9VrIC+jxXlz8:00cys
X-Hashcash: 1:24:171202:patthoyts@users.sourceforge.net::maJ9gWbbAil/ME+z:5ADB
X-Hashcash: 1:24:171202:l.stelmach@samsung.com::uuUBBXUznxBbIR1Z:Lnu+
From:   =?utf-8?Q?=C5=81ukasz?= Stelmach <stlman@poczta.fm>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Subject: Re: [PATCH] git-gui: Prevent double UTF-8 conversion
In-Reply-To: <alpine.DEB.2.21.1.1711281524390.6482@virtualbox> 
References: <20171128102126.20864-1-l.stelmach@samsung.com>
    <alpine.DEB.2.21.1.1711281524390.6482@virtualbox>
Date:   Sat, 02 Dec 2017 11:33:43 +0100
Message-ID: <87k1y5mnaw.fsf%stlman@poczta.fm>
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1512211254;
        bh=bs5ETtewXeT2I+x7O0U0Sq1qxcuWK0Qu+FAgoQUAfXA=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:X-Hashcash:X-Hashcash:
         X-Hashcash:X-Hashcash:X-Hashcash:From:To:Cc:Subject:In-Reply-To:
         References:Date:Message-ID:User-Agent:MIME-Version:Content-Type:
         X-Interia-Antivirus;
        b=vClUccu4q4H/D7sNi7YTurR5Zo6ifS+PDHgsFyxT19oQTeo7PV/MjzYZO0O0VPgTr
         DZ97SsuNK6IITWWXlzwhnp34zFdrh6pQLYvmtJGI8JvNKOXf1yEqGuWfVGSOxdbH8X
         0SFTnzT15I4Xf8bmsfLlbbeF/jiSmy7av6pvt7/4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Nov 2017 15:35:21 +0100, Johannes Schindelin wrote:
> On Tue, 28 Nov 2017, =C5=81ukasz Stelmach wrote:

> > With encoding on the file descriptor set to "binary" Tcl (8.6 in my
> > case) does double conversion which breaks e.g. author name in amended
> > commits.
>
> Is the problem in question occurring when a commit message contains
> non-ASCII characters encoded in UTF-8 and you click the "Amend Last
> Commit" radio button on the right side above the "Commit Message" text
> box?

No, only with the author data. That means there is a difference in how
Tcl handles input in with "read" (the message) and "gets" (headers
including the author header).

Indeed! A few lines below the message is converted from utf-8 and author
is not. So the right thing to do is to convert author too and not change
the file descriptor settings.

I am going back to the drawing board. Thanks.=20

=2D-=20
By=C5=82o mi bardzo mi=C5=82o.                                  --- Rurku. =
--- ...
>=C5=81ukasz<                                --- To dobrze, =C5=BCe mnie s=
=C5=82uchasz.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEkPlMeih05HaDBMFPALaXbGOR03EFAloigyZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDkw
Rjk0QzdBMjg3NEU0NzY4MzA0QzE0RjAwQjY5NzZDNjM5MUQzNzEACgkQALaXbGOR
03H2eQf+IwGqu+BF8usyzMwk9Ou66gqNDeC41LVoGzDfYb01Kdp7/PIb4TwB3gC7
S3c/AdXZ5tv+t/tGhLqWmJnUOQCrXxFk3gYTT9PbGC6MOvNSPiW07qWLA1zG95hO
gPikbp9eDEQWI32BjP3dcQynFTqMuG4QfFBdP5Tu8Ik5MvGKdWKho/0voR5Crshb
H6iE87grhZDIbx0+RTXbThwZFwXVV2fFCoBGUr7Ori8BS3bZRrRK10LZeLzwu6FC
VVjHvdThLcN1REOh52LZOl2NNcy1Om9HNa3GrLo37niZXTR/srUxPkvxsdPvXxe4
HtvyefmCSAEVVmaf4jsIgwX/0i6wnQ==
=FSQA
-----END PGP SIGNATURE-----
--=-=-=--
