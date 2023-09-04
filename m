Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38530C71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 13:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353110AbjIDNhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353114AbjIDNhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 09:37:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B40CFB
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 06:37:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a41031768so706759b3a.3
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693834621; x=1694439421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7Dqn+dyjc2Y73prSwwMIRz5bqcLSKWaILC9Pp2pRUQ=;
        b=cXVlBFrwoQVztRR1rH930v0wLR4i5LmlHrrHOwH2ts/Sar/3pvJ3O5W8Fsju7mQ3+z
         DLSiuZLqTnuPc3Vo7XDc7sTCL9eKZfSaZe+nJ0QtdNh51rEf1cKDdu9Yjzs3yfMKQlzV
         FBaAZrRd/EIUZ59GmDQ1RYqUYG2HPnBWjQGJ58lT5TFH+spHsJB+pgqDCGmLOKEvjATg
         1cvHKN2yH+cJ37XEfHosXMtuArRO9kfbyGKktQS/dxoT2JYT37Y+6Wgi28JaObMsqdsA
         4D58zfV6genB23Qz8zP9ew2egd62Hayn95jrDVS5w7eZ5D//sy2WPfldgpLu2f9h6mhw
         iaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834621; x=1694439421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7Dqn+dyjc2Y73prSwwMIRz5bqcLSKWaILC9Pp2pRUQ=;
        b=OH8knqoWAdXfSa/H2VbpcF2B2btNobWSuJh79hyrOuSh1DBH/+iEZJ4YLhowmUTJsC
         GpQ2+t5QB5+i+/6tEwl1xYvhiqaUnJFgC9nhyh3Vxowuo1qNUGa4/fO90wzOYmKX5E7g
         8iYbexmy0e7hI/W294TsmcwnL018jZL3uoVOna8nPf7S+qvCxvIMDUKuV5t8RHHrDPMP
         Z0q3ePKWYcWkpGmD4KglVAXFK2JSXYrUM9mASr6aOZ2yT4zwJHVviL3RTunfPwM9jBbR
         AKMQkYDJiMSb1bHwev3TSWkzmaiYEA2gUN6kx0zLe1ZoMeTfnivF9jYrfJl/XLseTSBw
         NWKw==
X-Gm-Message-State: AOJu0YzvxfEcGaHXf2Oe+eFmPrZCHXCUX/E8juy7Q0mTnkCbikZxyClp
        CXXaAz4N3JIkOiKheUCdgU8=
X-Google-Smtp-Source: AGHT+IGcoSVcY5PoshlszWy92e2iFrp2mfKSHmzSGUTHmA30I+oJM1/sYX7H8b4rFKrJxXjFZIdmDg==
X-Received: by 2002:a05:6a00:1741:b0:68a:6173:295b with SMTP id j1-20020a056a00174100b0068a6173295bmr10083850pfc.2.1693834620648;
        Mon, 04 Sep 2023 06:37:00 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c5-20020aa781c5000000b0068a3dd6c1dasm7596569pfn.142.2023.09.04.06.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:37:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id AFED581E9BFD; Mon,  4 Sep 2023 20:36:57 +0700 (WIB)
Date:   Mon, 4 Sep 2023 20:36:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Radovan =?utf-8?Q?Halu=C5=A1ka?= <radovan.haluska1@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Potential bug in `git checkout --quiet`
Message-ID: <ZPXdeRnLu6oKoVt2@debian.me>
References: <9419E14B-5933-4773-B1BA-899A7DA75D96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kcNYvcEtn7wXT+dw"
Content-Disposition: inline
In-Reply-To: <9419E14B-5933-4773-B1BA-899A7DA75D96@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kcNYvcEtn7wXT+dw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 02:56:37PM +0200, Radovan Halu=C5=A1ka wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> ```
> git clone --quiet --branch master --depth 1 --no-checkout --filter blob:n=
one \
>     git@github.com:acatai/Strategy-Card-Game-AI-Competition.git locm-agen=
ts
> cd locm-agents
> git sparse-checkout set --no-cone
> git sparse-checkout add 'contest-2022-08-COG/ByteRL'
> git checkout --quiet
> ```
>=20
> What did you expect to happen? (Expected behavior)
>=20
> I expected to receive no output from any of the commands above.
>=20
> What happened instead? (Actual behavior)
>=20
> I received an output from the last command even though the `--quiet` swit=
ch was specified
>=20
> What's different between what you expected and what actually happened?
>=20
> This shouldn't have been printed on the screen:
>=20
> '''
> remote: Enumerating objects: 28, done.
> remote: Counting objects: 100% (28/28), done.
> remote: Compressing objects: 100% (27/27), done.
> remote: Total 28 (delta 0), reused 25 (delta 0), pack-reused 0
> Receiving objects: 100% (28/28), 31.40 MiB | 4.94 MiB/s, done.
> '''
>=20

I can reproduce this bug on v2.40.0 using your reproducer above. Yet,
`git checkout --quiet` on normal repos (not partial ones) works as
expected. Cc'ing people working on sparse-checkout recently.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--kcNYvcEtn7wXT+dw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZPXdcgAKCRB7tWyQc2rT
CL0RAP4tzEUU8t16Y8CZwOHkeh2CVCtdGojRWcI/mjnOupdTcwEAl5uwvQc4g2o3
r9LWAmGHQB+bfbuZMev5N6uGrbtFfgg=
=SDuM
-----END PGP SIGNATURE-----

--kcNYvcEtn7wXT+dw--
