Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E11FCD4F27
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 07:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjIVHjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 03:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjIVHjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 03:39:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB312CA
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 00:39:34 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3adf06730c4so1162740b6e.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695368374; x=1695973174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrSmzrXZdG3XJTwrQe/O2n6P/xlBN5A209T/TSJh/oc=;
        b=KXV2cZHHbhwRnKkqGhooJrepefQ5bzKBYCzcA+88tomKN4yO1oacSE8qfFQiwFMP0/
         TGkZTBPOIowBYevOXBxOp60ij3G/DuDhqemcneJ3d7gDx/e2e7UhmaxaKQDQ4X4eDe+Z
         2cx3KNjk+Q3qHJEQSrSs+/MLADxvVKJzvFbvsHdY7w/G466VyWs9Bq+RR1bJm19Jes/v
         cFPmZZNmP9Km71kViWa4HxV2rgrWZo/QaycTi5oAOG8AUw64vZPqIB1KCqJkWLLIzqXM
         Shs/J0C1BkjIm1RFka2fC7MdcW1NSOJsMwqGtyVs/iQ5O2Jng3LmG1q6USoBX65Q/czg
         uRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368374; x=1695973174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrSmzrXZdG3XJTwrQe/O2n6P/xlBN5A209T/TSJh/oc=;
        b=gCNkGWXTuHgG9WpaK6c33eBENh6nuqnfNtJSsA7BKbuoOsFAhMIKDzcBdJ+zJ0TN/L
         45WlDw+vv/fB2uaU7ysmhJfOCGqcOm95WbXOtO4e/QncpnL3mxRJd/I7unn4+othpcXs
         LjzKB7ge0sLRIz5JGA/4uZSFxQtPsZGvwzYZjoeg5dNrMwcVNCNl89agU6g2E4HlhTGE
         9f5oZP2Im7L0MxKEXOihLj5ZxI5iMYXbyKhVPS7Y3T6rT/UnamFmf8agwPvPLI3aZFTJ
         e/5KxjuzXmG8Rxdo61O8RXs+O6k7PIV1aS/r2f4WJkNfZ9kyLY2J0XoVeEJGAdJcgrfH
         nzxA==
X-Gm-Message-State: AOJu0YyoIPJ1eAd3vsnMcWFXh2vVSRY3kz71yrdkmSYgXRMBrtjm6a13
        0IxG0fqLGY8/GuZQfzgJXMU=
X-Google-Smtp-Source: AGHT+IGNDX0LL9cn+TnXdnoWcq/L89WUTWsvbjETFBoGc7LJwPmalcLWauIVkVICi43ghkRNuMh8Ww==
X-Received: by 2002:a05:6808:618f:b0:3a4:24aa:b556 with SMTP id dn15-20020a056808618f00b003a424aab556mr6970362oib.13.1695368373934;
        Fri, 22 Sep 2023 00:39:33 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b0068aca503b9fsm2579920pfi.114.2023.09.22.00.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:39:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A5DE881B96F5; Fri, 22 Sep 2023 14:39:29 +0700 (WIB)
Date:   Fri, 22 Sep 2023 14:39:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
Message-ID: <ZQ1EsX5ZwkAHgT4Z@debian.me>
References: <ZQhI5fMhDE82awpE@debian.me>
 <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com>
 <ZQknHjKdGZV3vJpV@debian.me>
 <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
 <118975ef-c07f-c397-5288-7698e60516a7@amd.com>
 <ZQrQsa5GJEVhBttT@debian.me>
 <xmqq7cokc0kj.fsf@gitster.g>
 <d6527c54-7dbc-46ee-b73d-49653edda0d9@gmail.com>
 <xmqq1qer5kc0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H7HNQWakScrq6WGI"
Content-Disposition: inline
In-Reply-To: <xmqq1qer5kc0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H7HNQWakScrq6WGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 01:42:55PM -0700, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> > I'll make one on the separate report.
>=20
> Alright.  The next task from your end may be to see if you can
> bisect to find which topic broke your expectation.
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--H7HNQWakScrq6WGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZQ1ErAAKCRB7tWyQc2rT
CF0XAP4x+z4Js7VUgBPpBu02SYGAsJH1XEqwFQkoi/8w7qLFdwEA4aNzblYMq6lZ
ZjSMDOFvr4nj7ync0dUNHJz/DibyGQQ=
=Jsi0
-----END PGP SIGNATURE-----

--H7HNQWakScrq6WGI--
