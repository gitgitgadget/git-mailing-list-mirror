Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CFC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46BB6108E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 15:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGQBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:01:25 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:43524 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGQBY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:01:24 -0400
Received: by mail-pg1-f171.google.com with SMTP id e22so14116119pgv.10
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FIn9xlHuqukbjkI+fRyCWzX8JO2/8iulESHPgZD54lE=;
        b=iLPoPyWhPOKCBXi7anQizQhgE2l2lt82qsCppXbhmpvGd42MClZEUbduBvEpVqQQG9
         D75ERDc5bEv92pGHSRxzput6rH8dTu9YVtT9RkdxmwEu+kzBCUcaHQxPAngYncgoXn8K
         K7gMBd8x2CuaMWQN0lEqsebKyJRh48/Cxl1YuFR9P6+wF3FBwqRRUAbQpxZ1OqPHJ7Lq
         5GnEyV780eru46MNcugoRBZn9gtkzwKMP+0qomxoxBGKnAwFv36wdkT95MVnvwq+xnt3
         PZCyfWeq56zG7yvG6CJlTvFB8kUBMRGLM0BSWf+RwrYeId7ie8oiEthbD5IDO+5D2hmz
         1Htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FIn9xlHuqukbjkI+fRyCWzX8JO2/8iulESHPgZD54lE=;
        b=SMMCJ57Q2+KianlfAwtveOen/fnDv4XSTiMZtKJlzx4yuc0qlRjQlYU1jf/Rct/GyQ
         oAaPy5qzbmJkwPdgZOuyfp1FMSOKl9ZrE9G89yl0XldY7ATJNWjjeDbBiB2MpnhBt06C
         9kb9QEV9Oxj0UtD9z8g4FJUqHkDYJuOmaDZ5/uNqvSscV2015KbbJlCBt2y2gnW8Y37v
         3CC/UKhdGW5cU/8FRWgsPpitWR4G5lHRyCdIzAgDRcK1YNSEgML1TU5uUf00JBXmcMvh
         uls8Ex3cryRH4/QAaNW43phBGNKPiuWn5Y7bdKRjeAjnbMEm8jhJD6pRVA+zNJv+Uy3k
         pRYA==
X-Gm-Message-State: AOAM532H063Dz+gfGJ2BVyh3C068aRBYY7rmCto+IJgekWSR5HHbEDjg
        ZDvcdwtHqcJUzt+Xan3f7Wo=
X-Google-Smtp-Source: ABdhPJy7vKdmdbvzXsxO/fk1tC8IEIHUkBWxJqZtDAMZSGAiRCC+sJ3AdGwo/mcWmY/JnztJbb9RuA==
X-Received: by 2002:a62:5e04:0:b029:2ea:a8dc:25d3 with SMTP id s4-20020a625e040000b02902eaa8dc25d3mr17627442pfb.6.1623081496073;
        Mon, 07 Jun 2021 08:58:16 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id u1sm9177064pgh.80.2021.06.07.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:58:15 -0700 (PDT)
Date:   Mon, 7 Jun 2021 22:58:12 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/3] SubmittingPatches: move discussion of
 Signed-off-by above "send"
Message-ID: <YL5CFLhmpP40ZTYJ@danh.dev>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
 <patch-1.3-9fa5437bb5-20210607T110044Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mdTPQTy1Ok3QUB1s"
Content-Disposition: inline
In-Reply-To: <patch-1.3-9fa5437bb5-20210607T110044Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mdTPQTy1Ok3QUB1s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-07 13:03:41+0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
> Move the section discussing the addition of a SOB trailer above the
> section that discusses generating the patch itself. This makes sense
> as we don't want someone to go through the process of "git
> format-patch", only to realize late that they should have used "git
> commit -s" or equivalent.
>=20
> This is a move-only change, no lines here are are being altered, only

Nitpick: s/are are/are/;

Otherwise, the move makes sense to me.

> moved around.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/SubmittingPatches | 160 ++++++++++++++++----------------
>  1 file changed, 80 insertions(+), 80 deletions(-)
>=20
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
> index 55287d72e0..2643062624 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -167,6 +167,86 @@ or, on an older version of Git without support for -=
-pretty=3Dreference:
>  	git show -s --date=3Dshort --pretty=3D'format:%h (%s, %ad)' <commit>
>  ....
> =20
> +[[sign-off]]
> +=3D=3D=3D Certify your work by adding your `Signed-off-by` trailer
> +
> +To improve tracking of who did what, we ask you to certify that you
> +wrote the patch or have the right to pass it on under the same license
> +as ours, by "signing off" your patch.  Without sign-off, we cannot
> +accept your patches.
> +
> +If (and only if) you certify the below D-C-O:
> +
> +[[dco]]
> +.Developer's Certificate of Origin 1.1
> +____
> +By making a contribution to this project, I certify that:
> +
> +a. The contribution was created in whole or in part by me and I
> +   have the right to submit it under the open source license
> +   indicated in the file; or
> +
> +b. The contribution is based upon previous work that, to the best
> +   of my knowledge, is covered under an appropriate open source
> +   license and I have the right under that license to submit that
> +   work with modifications, whether created in whole or in part
> +   by me, under the same open source license (unless I am
> +   permitted to submit under a different license), as indicated
> +   in the file; or
> +
> +c. The contribution was provided directly to me by some other
> +   person who certified (a), (b) or (c) and I have not modified
> +   it.
> +
> +d. I understand and agree that this project and the contribution
> +   are public and that a record of the contribution (including all
> +   personal information I submit with it, including my sign-off) is
> +   maintained indefinitely and may be redistributed consistent with
> +   this project or the open source license(s) involved.
> +____
> +
> +you add a "Signed-off-by" trailer to your commit, that looks like
> +this:
> +
> +....
> +	Signed-off-by: Random J Developer <random@developer.example.org>
> +....
> +
> +This line can be added by Git if you run the git-commit command with
> +the -s option.
> +
> +Notice that you can place your own `Signed-off-by` trailer when
> +forwarding somebody else's patch with the above rules for
> +D-C-O.  Indeed you are encouraged to do so.  Do not forget to
> +place an in-body "From: " line at the beginning to properly attribute
> +the change to its true author (see (2) above).
> +
> +This procedure originally came from the Linux kernel project, so our
> +rule is quite similar to theirs, but what exactly it means to sign-off
> +your patch differs from project to project, so it may be different
> +from that of the project you are accustomed to.
> +
> +[[real-name]]
> +Also notice that a real name is used in the `Signed-off-by` trailer. Ple=
ase
> +don't hide your real name.
> +
> +[[commit-trailers]]
> +If you like, you can put extra tags at the end:
> +
> +. `Reported-by:` is used to credit someone who found the bug that
> +  the patch attempts to fix.
> +. `Acked-by:` says that the person who is more familiar with the area
> +  the patch attempts to modify liked the patch.
> +. `Reviewed-by:`, unlike the other tags, can only be offered by the
> +  reviewer and means that she is completely satisfied that the patch
> +  is ready for application.  It is usually offered only after a
> +  detailed review.
> +. `Tested-by:` is used to indicate that the person applied the patch
> +  and found it to have the desired effect.
> +
> +You can also create your own tag or use one that's in common usage
> +such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
> +
>  [[git-tools]]
>  =3D=3D=3D Generate your patch using Git tools out of your commits.
> =20
> @@ -302,86 +382,6 @@ Do not forget to add trailers such as `Acked-by:`, `=
Reviewed-by:` and
>  `Tested-by:` lines as necessary to credit people who helped your
>  patch, and "cc:" them when sending such a final version for inclusion.
> =20
> -[[sign-off]]
> -=3D=3D=3D Certify your work by adding your `Signed-off-by` trailer
> -
> -To improve tracking of who did what, we ask you to certify that you
> -wrote the patch or have the right to pass it on under the same license
> -as ours, by "signing off" your patch.  Without sign-off, we cannot
> -accept your patches.
> -
> -If (and only if) you certify the below D-C-O:
> -
> -[[dco]]
> -.Developer's Certificate of Origin 1.1
> -____
> -By making a contribution to this project, I certify that:
> -
> -a. The contribution was created in whole or in part by me and I
> -   have the right to submit it under the open source license
> -   indicated in the file; or
> -
> -b. The contribution is based upon previous work that, to the best
> -   of my knowledge, is covered under an appropriate open source
> -   license and I have the right under that license to submit that
> -   work with modifications, whether created in whole or in part
> -   by me, under the same open source license (unless I am
> -   permitted to submit under a different license), as indicated
> -   in the file; or
> -
> -c. The contribution was provided directly to me by some other
> -   person who certified (a), (b) or (c) and I have not modified
> -   it.
> -
> -d. I understand and agree that this project and the contribution
> -   are public and that a record of the contribution (including all
> -   personal information I submit with it, including my sign-off) is
> -   maintained indefinitely and may be redistributed consistent with
> -   this project or the open source license(s) involved.
> -____
> -
> -you add a "Signed-off-by" trailer to your commit, that looks like
> -this:
> -
> -....
> -	Signed-off-by: Random J Developer <random@developer.example.org>
> -....
> -
> -This line can be added by Git if you run the git-commit command with
> -the -s option.
> -
> -Notice that you can place your own `Signed-off-by` trailer when
> -forwarding somebody else's patch with the above rules for
> -D-C-O.  Indeed you are encouraged to do so.  Do not forget to
> -place an in-body "From: " line at the beginning to properly attribute
> -the change to its true author (see (2) above).
> -
> -This procedure originally came from the Linux kernel project, so our
> -rule is quite similar to theirs, but what exactly it means to sign-off
> -your patch differs from project to project, so it may be different
> -from that of the project you are accustomed to.
> -
> -[[real-name]]
> -Also notice that a real name is used in the `Signed-off-by` trailer. Ple=
ase
> -don't hide your real name.
> -
> -[[commit-trailers]]
> -If you like, you can put extra tags at the end:
> -
> -. `Reported-by:` is used to credit someone who found the bug that
> -  the patch attempts to fix.
> -. `Acked-by:` says that the person who is more familiar with the area
> -  the patch attempts to modify liked the patch.
> -. `Reviewed-by:`, unlike the other tags, can only be offered by the
> -  reviewer and means that she is completely satisfied that the patch
> -  is ready for application.  It is usually offered only after a
> -  detailed review.
> -. `Tested-by:` is used to indicate that the person applied the patch
> -  and found it to have the desired effect.
> -
> -You can also create your own tag or use one that's in common usage
> -such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
> -
>  =3D=3D Subsystems with dedicated maintainers
> =20
>  Some parts of the system have dedicated maintainers with their own
> --=20
> 2.32.0.rc3.434.gd8aed1f08a7
>=20

--=20
Danh

--mdTPQTy1Ok3QUB1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQpKtdjjNYPYlBV4GKki1K/DqNHWgUCYL5CFAAKCRCki1K/DqNH
WjjIAPsG9elVIMlr4vbi5VhRJnqgUs/x+DxpKMX6lbbfeoW5LwEA22hChasUlz7q
aABHIdPQEnsRZyiB4KCWHmiorKRrrww=
=BuMe
-----END PGP SIGNATURE-----

--mdTPQTy1Ok3QUB1s--
