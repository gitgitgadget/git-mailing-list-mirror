Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1AFC4708E
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 08:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLGIqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 03:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLGIo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 03:44:56 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE953B9FF
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 00:44:37 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 4so16439338pli.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3MZPcppe++naXWuPlkrUREowf9vGq1RCBVZkc6DZuo=;
        b=e/FFOmooOfWfEAvSqc3TyLGWZO25rW7KSwyCD70v+sKiK86G6rhwQOWHuXkW4dd6iH
         XwG26IO5jl5b5/Yk9CVBfEa7d8Rn6aEIT/AmUxDpoXmPLWsUg43eXe1RkQZZgLH4YfPF
         AAeu/I9sp2wuT9sR0ECMxPAe6gSuXozfHx986j6QEFnZUXxCghdNOLCaJ0Rn5KgOUY+R
         4lj7MqsdCI5EAtbqXxHNRO6V29ELy3jJvxbBRoiXAzol8L74kwaBZSp6Tv89Xx/2UQ7f
         UWekzJH+uG6QXL5D32NXHhm9nteDKNa+Shzfcg8ulfGlYUkufFQXQxvEwvrY7vqhZ7w5
         +4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3MZPcppe++naXWuPlkrUREowf9vGq1RCBVZkc6DZuo=;
        b=6NVijIj1DW3BATpQ/j9+SioHhTIKPHv7VWYReIzZMpjXc6luCR5ZD/jPyW91QmdaSN
         xD9DZzrJnQUboQbs7nrdGmHGjixvtdRIIaSii3AQTe3ZDJgAZL+7uAx7lvjvCL/WKdcM
         q9X+Cd/qRdMUtNn7u20OfGJLdCXOu4CGflr6azYdklaM9L+SnJ8+QJVqJM6ulVJLLHMq
         3foiI6nDy5Tazf5BJxU4rdqvbJ6zzXdVd0JQNiNqV+gUWSAYiooJ9YbXZfZ2wWmcbKfo
         NxW+O+mmY6TWuBJOqRY6htac1lvuINCROYIO+/Hpl2hDk8VWwUJVp80jIJ1k7Gx2zM4x
         OkqA==
X-Gm-Message-State: ANoB5pmSdOPGXWScJ1Z2RoyjfgCp/bm1JcXju+Owi9Od/U7R53yDDH0o
        ir0xWkMlU6kCOmAb2+gTVBc=
X-Google-Smtp-Source: AA0mqf4yy1vkh2znVEh6FxBnpiipnbHoSsE4n5vqIpXDtDMYmpH3vldhr/ZaZlsZnCQhYi9PffTpKA==
X-Received: by 2002:a17:90a:2901:b0:219:8b1b:c667 with SMTP id g1-20020a17090a290100b002198b1bc667mr25843648pjd.132.1670402676526;
        Wed, 07 Dec 2022 00:44:36 -0800 (PST)
Received: from debian.me (subs03-180-214-233-90.three.co.id. [180.214.233.90])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7979a000000b00576f9773c80sm4961500pfp.206.2022.12.07.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 00:44:35 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 4134110444C; Wed,  7 Dec 2022 15:44:33 +0700 (WIB)
Date:   Wed, 7 Dec 2022 15:44:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
Subject: Re: [PATCH v6] revision: use calloc instead of malloc where possible
Message-ID: <Y5BScRmR1fY/SQCq@debian.me>
References: <pull.1390.v5.git.git.1670348301601.gitgitgadget@gmail.com>
 <pull.1390.v6.git.git.1670356394394.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jtN6Kv3YiU+xbToq"
Content-Disposition: inline
In-Reply-To: <pull.1390.v6.git.git.1670356394394.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jtN6Kv3YiU+xbToq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2022 at 07:53:14PM +0000, Rose via GitGitGadget wrote:
> From: Seija <doremylover123@gmail.com>
>=20
> We can avoid having to call memset by calling calloc

Who are "we"?

Please avoid using first-person pronouns (I and we), since these are
ambiguous in context of many entities (individuals/companies)
participating in development. Instead, write in imperative mood and
passive voice, e.g. "Avoid the need to call memset by allocating with
calloc() instead of malloc().".

Even then, what are justifications of malloc() -> calloc() conversion
other than the described above?

>=20
> Signed-off-by: Seija doremylover123@gmail.com

The SoB doesn't look OK. It should have been
"Signed-off-by: Your Real Name <yourname@what.domain>".

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--jtN6Kv3YiU+xbToq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCY5BSYgAKCRB7tWyQc2rT
CCubAQDJUwX0Q7dTx+ImJAF5kgYPByWt8dF8XzqckF8B1rAsnwD7BsBGXf11LxkW
SaKaIpyRL0OpvRxxYKaTPN16bIZv8A0=
=pQA9
-----END PGP SIGNATURE-----

--jtN6Kv3YiU+xbToq--
