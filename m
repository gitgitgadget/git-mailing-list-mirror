Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D678AC5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 16:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B9D22314
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 16:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TL/GP4St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgKNQ1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 11:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKNQ1E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 11:27:04 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6AC0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 08:27:03 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d38so5207823qvc.3
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=iIw1Qj9CCKym4W1AKPp/rCkjkIRcAh5U94v5q3Gd4ZA=;
        b=TL/GP4StgFrR/oyWIyZGiDSJpjrwwgSZa0l+5oD2MvAhgroYmkkf9f7goJ2bLzQiN5
         9RTpRi2b+5jLDZxqjz95sUETI/dGbNtP/2mtj3L2XX+IZlbjL2oEo2cfLvbhnvIhzhrJ
         VVd7h8yLFDFwoHqYur1lmkXATpg98B+RzmNms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=iIw1Qj9CCKym4W1AKPp/rCkjkIRcAh5U94v5q3Gd4ZA=;
        b=EauH5luVY7vwRyr3Z1nmmmYbXBZo0SoSU6ChmrW6B4sHmccc1UMLb3nco6YAPqFwF3
         bcrQLCa+2wlrHQ8ChgoK6/z73Y3V/Q8CoXM79gZphoMmxbpuPQc1Cyj+IDx7/jG1YdrO
         gOdL4zJGFosU5D+N1E452j7n3+fL3WCyWKY3yn0+bPWGPSJ+2ivh4gKB8p5CakeJsTWR
         O7mxmShfItmCgNGWlhuBsnYm4s+wS/FY1HvuFt1Yzh1sL1UrCPWdfhUuFVz6wkHcZ6Yx
         +7h61VR7bPrDLeo1rsx6aR5Ln4Dz5O01WmiKsNjoSmQlaxJ3bzHyJsP6gAzMNFqP6ZtA
         Z6EQ==
X-Gm-Message-State: AOAM5307agh4U4uuOdOcdwcVCkZUXSYDmW+RXV/2KPLMyi7oAKa5Zmnx
        ovV3ETk0VvJxg+Scfr4fYyAkgw==
X-Google-Smtp-Source: ABdhPJx2cKaXIUp2wfwErezckHLCY4/HWTa/pzJ+sLCr1Ei5DAqY2VwIGGl878O5iO/2mqAkMbfJvA==
X-Received: by 2002:a0c:d414:: with SMTP id t20mr7990527qvh.34.1605371223051;
        Sat, 14 Nov 2020 08:27:03 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id t20sm9236035qtt.70.2020.11.14.08.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 08:27:02 -0800 (PST)
Date:   Sat, 14 Nov 2020 11:27:00 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza <rezaxm@gmail.com>, git@vger.kernel.org
Subject: Re: Why Git LFS is not a built-in feature
Message-ID: <20201114162700.cvmxzcs4sdhsxpak@chatter.i7.local>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alireza <rezaxm@gmail.com>, git@vger.kernel.org
References: <CAD9n_qjKyxNjtd1YrcHzshLg0-vbwXkHRwMveXHAWSOXMWLKAg@mail.gmail.com>
 <20201114002902.GN6252@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gjwdrmromawyoshr"
Content-Disposition: inline
In-Reply-To: <20201114002902.GN6252@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gjwdrmromawyoshr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2020 at 12:29:02AM +0000, brian m. carlson wrote:
> Additionally, in many cases, projects can avoid the need for storing
> large files at all by using repository best practices, like not storing
> build products or binary dependencies in the repository and instead
> using an artifact server or a standard packaging system.  If possible,
> that will almost always provide a better experience than any solution
> for storing large files in the repository.

Well, I would argue that if the goal is ongoing archival and easy=20
replication, then storing objects in a repository like git makes a lot=20
more sense than keeping them on a central server that may or may not be=20
there a few years down the line. Having large file support native in git=20
is a laudable goal and I quite often wish that it existed.

-K

--gjwdrmromawyoshr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCX7AFVAAKCRC2xBzjVmSZ
bFjCAP9oN743MuAmeVM+LD3MaSEL9GrVis5NR6g1BlwgcvO9vQD8CEp8Q6nVyy3g
1vbeKq7vyVtU5G4I44BQkHDPR+k4uQU=
=h8LJ
-----END PGP SIGNATURE-----

--gjwdrmromawyoshr--
