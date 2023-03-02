Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B53C7EE23
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 02:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCBCi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 21:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCBCi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 21:38:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FFC679
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 18:38:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y2so15400710pjg.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 18:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677724705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rupm1sQNx3vWRIvyABMO9EujYA6QHRqDWHWuaDIL5qw=;
        b=UTaCeW6TXAvmVpst+cxvvqfzbbNGERX9rEBRXL3kBOlYOtHlyhP9zxUbVzrVRGAJEK
         t/Tum5UPGQIMUHrVzR2Fvv4d9+sa8pyXJcUOcYIsQ629qamD4gQSyMtpK0p0pMXstUju
         19gAzAvqINIl/Yw8opfipj10pmIWxV34I6cQYSZ/jjrthp0rvlKmbvenhOMgy17xYx4a
         lPqUDnIKUb/bwlUb4lo2Uysj9uLqa+TKBwE7RJji4PFTzP8TVe3mP2fhj8pZLy7hErh7
         typpys0ZKWV/QdTjMK2NQmJ4K2gz0m8lEk8M/6pfh05ivXvstHVjyeu8PGzZneCwlrbC
         p+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677724705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rupm1sQNx3vWRIvyABMO9EujYA6QHRqDWHWuaDIL5qw=;
        b=6DGlmK1gd6iSAwn+S9Jq5yIMHeYmYX6UdFAh3EJsU4VCECjEFn3Vfj8f4VznQebQTi
         ZAk7hkIC5KW11CepvlRnWX1AxPvAZiWRJP65I1pmWmX0AHCQDFx3afo55m23dztM72U5
         IMqAMBW+ow3WFVl2aK1+hhpOXgp9D69bGTkmgZRmcBwIQRXzpIstdNVuldtqEDCYuDkx
         v7t/y5bQ85oEn+wcW0ckWOlAMmHjJYwGprigr4dWx0V6SC34Gq9rIusmpToA1RdAEhsf
         iSQwrt6X09qfIyY7Yl0ToWr8b/MKX2JzMq52gHg3Kp14/BKr3dvwy5p6+3PWKK608NJb
         qIag==
X-Gm-Message-State: AO0yUKUExsl4RHZODBrIOXj8R3Po0RN0QIwr3dOJmjN7OKCvBCsMLvEQ
        dwrXrgUFbzNO4t66JgUeTw6jbtGEEq8=
X-Google-Smtp-Source: AK7set+TcWtLLHvRqqi25At2YKQOonE4+/9675FgMpfN374ig3xJcDsenhagvuMXlXWNYkLjQcLk5w==
X-Received: by 2002:a17:902:d2c9:b0:19a:c4a0:5b1b with SMTP id n9-20020a170902d2c900b0019ac4a05b1bmr727121plc.1.1677724705572;
        Wed, 01 Mar 2023 18:38:25 -0800 (PST)
Received: from debian.me (subs32-116-206-28-6.three.co.id. [116.206.28.6])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902bd0b00b0019948184c33sm9037486pls.243.2023.03.01.18.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 18:38:24 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id A0466104006; Thu,  2 Mar 2023 09:38:21 +0700 (WIB)
Date:   Thu, 2 Mar 2023 09:38:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Aman Agarwal <agaraman0@gmail.com>, git@vger.kernel.org
Subject: Re: Contributing to Git Source code | Open Projects | Patch Fixes
Message-ID: <ZAAMHcEjJtdRv/25@debian.me>
References: <CAP9kvThRCjOnOFoCOXeHKT6H7kqYEWE+xK_9P1SMVRBFQSsjmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HABoZ3Eh4UxrBUQh"
Content-Disposition: inline
In-Reply-To: <CAP9kvThRCjOnOFoCOXeHKT6H7kqYEWE+xK_9P1SMVRBFQSsjmw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HABoZ3Eh4UxrBUQh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2023 at 09:24:58PM +0530, Aman Agarwal wrote:
> Hi
>=20
> I am trying to contribute and am looking for some patches and
> projects, or to start contributing to the git source code. I would be
> grateful if you could give me some helpful references to check for
> patches or already-planned projects in git.
>=20

Hi, sorry for long reply.

There is a plan to libify parts of Git as described in [1]. As always,
your coding and testing contributions help.

Thanks.

[1]: https://lore.kernel.org/git/CAJoAoZ=3DCig_kLocxKGax31sU7Xe4=3D=3DBGzC_=
_Bg2_pr7krNq6MA@mail.gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--HABoZ3Eh4UxrBUQh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZAAMFgAKCRB7tWyQc2rT
CMp8AP4swHf92PXjlSg2BNgXSUABX8AB82ZTAoWlbsCA2S02OwD8DVnlMrzmUXta
dFkaDaGkoEiCu2VIH9VQWluYSHugvQA=
=qsec
-----END PGP SIGNATURE-----

--HABoZ3Eh4UxrBUQh--
