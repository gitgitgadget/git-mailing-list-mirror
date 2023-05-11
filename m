Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B058C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 03:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjEKDj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 23:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjEKDjx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 23:39:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3539C30F0
        for <git@vger.kernel.org>; Wed, 10 May 2023 20:39:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64115e652eeso54945414b3a.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 20:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683776391; x=1686368391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUSdEQ9EDT2QeQ0bhaY8ZFcGtopL4Uiia+0gvSSaJmg=;
        b=JTTWKvE/AqwNE425z06eNDEZlBSbdeMSLpKSXVJFpnhDTW31iG5Bbff9xIPTvaYDXC
         e5wTTgA4/MewjtihDYt1hitThIdnpbJLLx/gthenSf+e7QmnYf0LNHEsuxm9Jhd5ExXQ
         yZlVVERNks566Bvf+pEc8CnY2w7W5VpzhVb8PI3GAcEz57kIwjxEw0oMI08X0O4RbvTu
         KKg1ZR8b26YohPiPoby+4rKG0WnctwzTU1ke3My1yRj/Rdd0qHCSm0Xij5HWBkeDRq2x
         RCrGYVlFu/dYBttiEk4fAYfy4sgF0Jh358MGenFjXxWPvgHbhTUhOAMmZW6hVtJeM6tv
         JWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683776391; x=1686368391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUSdEQ9EDT2QeQ0bhaY8ZFcGtopL4Uiia+0gvSSaJmg=;
        b=d21RYQBf/2KtO9kWboCF1RV7CCE3X/BQXl6/VjxKZ8YLBwr+5BJpGye9C7gUTqyZ1y
         3xnNZwAQi35DildI9K9HxGLeAotu4wvMww9/aCKlZtUbaiiwxq/sojYd4YDLy86M6+Zc
         FAe/Tq+9s6tWqz8bKNslPXe4pziG94s4V9zMCEYAhEummQd1rOdWY/KXsxGWwzuJvXx/
         jXJgXFr/SFkHSmsd8nYpfPRrZ8kUdu3mvGsqUtoidzYk5B7S8ux/UwXrVQS2EP63KEcD
         XpLgOeIIJ/kKGpxwzHTwG7vgE6pJoWGgAHcHwIciRdZkRTboxE+AORQ/Hh7d4KrBXoBZ
         L0hA==
X-Gm-Message-State: AC+VfDzMjvyCVfHyFYJKOMyS9z00JpffJHCNCJPNzEtXrr1L+1FO+2qZ
        vWSriS2Z90kKOyD6vjSY80ieff3HdVw=
X-Google-Smtp-Source: ACHHUZ7H9mLq5b1oxuDG8eqCN3DHggqxRw5tqfG4oLhQlEPSYMsIP64nzaVHtMHAL5DI16m2TPcxYQ==
X-Received: by 2002:a05:6a00:e8f:b0:643:a6d1:b27 with SMTP id bo15-20020a056a000e8f00b00643a6d10b27mr17005635pfb.15.1683776391305;
        Wed, 10 May 2023 20:39:51 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-26.three.co.id. [180.214.232.26])
        by smtp.gmail.com with ESMTPSA id fe25-20020a056a002f1900b0062dfe944c61sm4182205pfb.218.2023.05.10.20.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 20:39:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A20FE106772; Thu, 11 May 2023 10:39:46 +0700 (WIB)
Date:   Thu, 11 May 2023 10:39:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     PEEX Gamer <czupux@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: Unable to cross compile git. http.c generating errors.
Message-ID: <ZFxjglvEHz9ESyRE@debian.me>
References: <CALpgS-OQzoopjKd2a3NBkaefHoqR_wLop5x3Y7U8e0eVUO7XJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kimQ4tUtaVPnnrJI"
Content-Disposition: inline
In-Reply-To: <CALpgS-OQzoopjKd2a3NBkaefHoqR_wLop5x3Y7U8e0eVUO7XJQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kimQ4tUtaVPnnrJI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 08:38:40PM +0200, PEEX Gamer wrote:
> I was trying to compile git for x86_64 FreeBSD 13.2 on x86_64 linux
> without any success.
> I was using clang toolchain that worked for native Freebsd 13.2 compilati=
on.
> The errors i had:
> First thing was that config.mak.uname was trying to include sysinfo
> because of host machine being linux which was weird. I ommited this
> error by replacing linux section with freebsd and everythink was
> smooth until http.c which generates output attached in email. Why
> would somethink like this happen when same code was compiled with
> success on FreeBSD machine but for some reason it can't cross compile.
> stdio.h come from official FreeBSD 13.2 base. I checked also when was
> http.c modified but this part is like that for last 5 years. Looks
> like i might have done somethink wrong with my toolchain but the same
> toolchain generated working tests (i ran them on FreeBSD machine,
> worth noting that this tests were using stdio.h) and also built
> working curl from source.

I don't see the error message unless I open this email on Thunderbird
(you attach it as image instead of copy-paste from terminal). Please
show us the error.

Anyway, the culprit line is introduced by e6cf87b12d (http: enable
keep_error for HTTP requests, 2019-01-10), so I Cc: the commit author.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--kimQ4tUtaVPnnrJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZFxjewAKCRB7tWyQc2rT
CE9AAP9xy4Z43YJ7z5sSUtvJ/CBmV3Z0qQNUFGIJTmF+OTL17QEAwVGgkZyNDduv
HK2zVvb073uDJGj/x2fMvbFNufHDXgc=
=3HcR
-----END PGP SIGNATURE-----

--kimQ4tUtaVPnnrJI--
