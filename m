Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44241C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 13:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjFBNfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjFBNfT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 09:35:19 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F9F1A7
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 06:35:17 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6af6f5fc42aso2012926a34.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685712916; x=1688304916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQXZcoMHywhqR8B8Wv31ayA0x4bof4NPsZ3Y9XHgBa8=;
        b=PeH6biXMg07McaPx2ip+I+ghl2wN/BlAjcBNvUgs9Wl8jKftEqvjh+hbIH/OdQaGVz
         /VXiLnAKwH8b3+0vqElV6HT7qMKmdebHbDVOyWV4kJxN21hshYbTtz7XGMOft7+GlcaW
         1TIrY7CaCPuwWEnNSv7GmhVK3hsRSpDuSOZj0rbyTD9rGAz3SjsAe+tUjwMZQHyOk/Us
         fqbp7N0WzAaFCFfVrCda9GlZFQObMdKlQ+jh7l4Ezr2bJ40FqPFGbIE9hrj1nWXU/C+i
         Y0NVcj+51aHZ/bMASByYKKgR3D3U2/ikHbFMNHGP1pwnf0aSkZOw5LdKO7IZ/vXFjOb2
         82vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685712916; x=1688304916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQXZcoMHywhqR8B8Wv31ayA0x4bof4NPsZ3Y9XHgBa8=;
        b=O0NuakoRdjlErLkNROar4413t6AmKGTTck79Cym6x+d4ZR93ORki70yfN69Flq1TGm
         eLrcZxL32xbReUANMrijzxGPCOn2VN7u1Fyp5UnTLExUdawl38uytHoSmK0BSY79LDzg
         3zy1xo0W5oau2o897K9YviTE1umAjN7K/C7gibXL39E3j5SfQVO3zUh1zOhLjHKQMYCp
         DPInpb6cxyCNvnHL+/BbHy1sBHeL16RQHxSmw9sYbrKHcuSW9O9ae3RPtVok6fNEgYDj
         InOdBps50kfVs3DPr025QQLPei3JDMwNbLNFHA3V7HhuOwYHNdiZIbemsbTh8HqhVsld
         ZgoA==
X-Gm-Message-State: AC+VfDwZbhB6XaFI9hqgL+qcXL2oQcl01fH20MUXE4bBRF+fBXl3ksdb
        LyoELSCK+J09tTR3KcqaQ6jqSvdGyyc=
X-Google-Smtp-Source: ACHHUZ5IEJmN5s+0hA7Xkut+jN9wAeP40p0c2LqCkfyPpwyKSqyrh2COTvWJTAw0hvtab57lYuVAbA==
X-Received: by 2002:a05:6358:7241:b0:123:3f86:fa66 with SMTP id i1-20020a056358724100b001233f86fa66mr12359119rwa.5.1685712916419;
        Fri, 02 Jun 2023 06:35:16 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id fa2-20020a17090af0c200b00256353eb8f2sm3188439pjb.5.2023.06.02.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:35:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 11A16106A6F; Fri,  2 Jun 2023 20:35:13 +0700 (WIB)
Date:   Fri, 2 Jun 2023 20:35:13 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Shahin Dohan <shahin.dohan@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: Git bash slow after update
Message-ID: <ZHnwEOa8dlUwDA8E@debian.me>
References: <CAHsf_F2CgyTWr82htsyg8aiA-WhrKa4zJQUc_wJwF0pfRYR7yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8us4ATEaCmTvEYsI"
Content-Disposition: inline
In-Reply-To: <CAHsf_F2CgyTWr82htsyg8aiA-WhrKa4zJQUc_wJwF0pfRYR7yQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8us4ATEaCmTvEYsI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 09:42:01AM +0300, Shahin Dohan wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> Updated Git to 2.41.0
>=20
> What did you expect to happen? (Expected behavior)
> Same performance in Git bash as before
>=20
> What happened instead? (Actual behavior)
> Every operation is significantly slower. CD is slower, git pull is a
> lot slower, etc...

Are there any other significant processes beside git that affect your
system performance?

--=20
An old man doll... just what I always wanted! - Clara

--8us4ATEaCmTvEYsI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZHnwCQAKCRB7tWyQc2rT
CJzaAPsEMXkaXVzsBm6Ocy+EWjTnf+bk5kzWma+q5U54yHjYZgD9FLkKGOMCu3L8
vZ7dPgJGvg582C0Wit7VMWKqenv+NgM=
=/Yzv
-----END PGP SIGNATURE-----

--8us4ATEaCmTvEYsI--
