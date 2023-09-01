Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F3ACA0FE1
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 11:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjIALJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjIALJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 07:09:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D59F107
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 04:09:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a41035828so1443202b3a.1
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693566563; x=1694171363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0aEBhUcp9nlAFmSRt8rZNzhOPU4BcFBAm+j8SWyrCMg=;
        b=LVw2bbvADuThVRWJobo/mvP0DZ2vlNq/C6tvXJ1peLMVrTvuFV8mA5i63Jg9Ovfdmi
         d+a/FPonsxsQVEVsDnS0GVexCnydKN6SbHwb5hAiJhlT6P1+3ZA9bH9HK5H1JxrGXuB1
         eLAaKuT42c9ZjVBiBgMp51+BGUhDv6vQvrkVm3CSV9CYpfNyGrf7GOe3A0MVHn3nyz6w
         iz9Zt7R1eZE9VgS6AqTfg5fjXUFgRERzPx/EMsMzoQaNNjtJntYT91pO6pg63Z6xtNPX
         nnlOMcOOl02Txbl9o/roWLQ7fCVgM87LR4ifPAeLYY/eMaa6mkiQAjaS0zxtW4mScYLp
         8Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566563; x=1694171363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aEBhUcp9nlAFmSRt8rZNzhOPU4BcFBAm+j8SWyrCMg=;
        b=emB4ODS72/AvIy3Bikm0XqhmPXaO9lMlvO3GVcg/27AH2oF3mTgqJstiD3h5R8roc5
         7m8Ey2ArT/r5lhVdSQC3yhUT2/Z3SVWHsGSS3gYuHjdpHbcZ7I/h+/KFq6bNDcnOZgEq
         UxgVc79dWMNetwTaq4yXvdNXOWsvTU54XqGoltU/r12q593/qHIBeDrVTVVgpQSnWNNU
         ZxhgRc8lzNIJobgigRUYNpmThzCidZxxxli7BLjijCTwLo3jE/f7SmLSCJbZXWgiO2Ko
         +HMNhcQYqslh1RR0hiE4VNQQo1gNT368ckqe9qiWWffyf9946WNcR9NQo9azeOCpEKaE
         8wTg==
X-Gm-Message-State: AOJu0YzormrU8K0vSwOEC6PVhbuSWZPTY/Iukmb7cqRmJtPpjTLPX6f0
        aUgaSKvGSo2F7/Rp8bl7VaQ=
X-Google-Smtp-Source: AGHT+IEqjM1G+crxboH8kh9mTLWAq7dE91UX4o9AiQLguMknkw94wiSX5uBUo31o9Vg6PqgyFsEkIQ==
X-Received: by 2002:a17:90a:6096:b0:262:ceaa:1720 with SMTP id z22-20020a17090a609600b00262ceaa1720mr1863748pji.5.1693566562883;
        Fri, 01 Sep 2023 04:09:22 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b0026b6b17ca5dsm2996258pjg.54.2023.09.01.04.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:09:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E1EA3814B400; Fri,  1 Sep 2023 18:09:19 +0700 (WIB)
Date:   Fri, 1 Sep 2023 18:09:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [REGRESSION] Can't clone GitHub repos (fetch-pack error) due to
 avoiding deprecated OpenSSL SHA-1 routines
Message-ID: <ZPHGX4Dd0Mc1VVAQ@debian.me>
References: <ZPCL11k38PXTkFga@debian.me>
 <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HUaiYN9wtwBxJfqP"
Content-Disposition: inline
In-Reply-To: <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HUaiYN9wtwBxJfqP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 11:19:14PM +0000, brian m. carlson wrote:
> On 2023-08-31 at 12:47:19, Bagas Sanjaya wrote:
> > Hi,
> >=20
> > I built Git v2.42.0 on Debian testing, linked with OpenSSL (v3.0.10 from
> > distribution) with Makefile knob `OPENSSL_SHA1=3DYesPlease=20
> > OPENSSL_SHA256=3DYesPlease`. I tried to shallow clone git.git repositor=
y:
>=20
> I should point out that using OpenSSL's SHA-1 support is insecure
> because it doesn't check for collisions.  As a practical matter, no
> distro builds that way, and if you distributed that build, it would
> probably qualify for a CVE.
>=20
> However, OPENSSL_SHA256 being set is fine for a local build or a build
> where you're not distributing OpenSSL itself.

Thanks for the disclaimer. I did such build for myself since the distro
version always lagging.

--=20
An old man doll... just what I always wanted! - Clara

--HUaiYN9wtwBxJfqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZPHGXwAKCRB7tWyQc2rT
CH3pAQDIvbzDfQgKHqrCStrlD5qTfrovTu3s6Hqbzhj+rJHiUwD/ZSzrHOjb+7O5
KCuX+n++OATz6KKDBoomtP+RhaVW4wY=
=JOXg
-----END PGP SIGNATURE-----

--HUaiYN9wtwBxJfqP--
