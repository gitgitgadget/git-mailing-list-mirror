Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1173AEC8748
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 08:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjIJIvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbjIJIvA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 04:51:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180ACD9
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 01:50:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5654051b27fso2588437a12.0
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694335854; x=1694940654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aONTaFkFo7y0idUf6HntyIQvKzGJjyCeRq0ovqCPJg=;
        b=GCp217EIFh1nL+uvMK1jmeJKapKJIiEq1IOvSPRdVD0HzIMcMNDttUMGC+uEhi8IUa
         Y4vYwgAJK2YqiyBGvAD/E1hkgn5ysybNyeyuIqX9aJPY44W0u6Wq8k2noNWnRu6d/ukB
         uH7zecOZ6lSp4VijSj6RrASWn0LUm13ZAEY5B65taylBSO7e7Q+p/mW0RpkbQ8I/nsWi
         YF9BWh37+fjj+QnoalOrMIiX0nGcFN/DQpVPMidyBZrz8pwYfYIgIULzlWNjV9h9ymXv
         sSbWrgyjncDecAL1cmmI+qushOr/w2giJZITml9yEhTzx/ZLuIiQMEVBCxDNDsJuGQw4
         0nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694335854; x=1694940654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aONTaFkFo7y0idUf6HntyIQvKzGJjyCeRq0ovqCPJg=;
        b=EGscZDHATZp8m0FHIFchw5/Hy1RsX002ZymAehgWG+KP6Trc1mE3JklsGoX9XpRxtw
         yPDKd0hXvR14KJc0/AuWxKN6jnmmdFH3eVzqWcQrbo6d7hzIxATXEyHzZmemq240NNeU
         VXrFS+tPkG/P9CKr1VZFGRW4dvWUZYknc62H9Mt6y4YDFsPiuM7v+WQ2xIHr7L/MUjpY
         hxs9gHKLM/u2nRrW1vTe/IcRcG8aU1Duqw/5JgWHeN/9YB8AJg6uO+nUHYK/znEfbym9
         lJ1CBXTarf8Vug3qYmo64Q3OTtvzquMWX1B5TWs2g3mi6NzoW7bHBhDkXryjzkwTjevo
         idtA==
X-Gm-Message-State: AOJu0YwbfGQMelJHt8/KJvcTcIHyCjdN5cBAA3pLcSHDKFVoAz2UEjS4
        7Y0B0+9jCJ9tmWTnr8DaLQ4=
X-Google-Smtp-Source: AGHT+IEyolbkt0IKXzgsuPEqMX8RgWuuVubw5AWHwGrKwHyO2FZ8IhQtfP2wCLtZpa4SOHBqcKVWkA==
X-Received: by 2002:a05:6a21:3984:b0:154:e887:f581 with SMTP id ad4-20020a056a21398400b00154e887f581mr3454959pzc.58.1694335854135;
        Sun, 10 Sep 2023 01:50:54 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id h8-20020a62b408000000b0068a0b5df6b2sm3654640pfn.196.2023.09.10.01.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 01:50:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E3CBA8B25F8E; Sun, 10 Sep 2023 15:50:49 +0700 (WIB)
Date:   Sun, 10 Sep 2023 15:50:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Max Amelchenko <maxamel2002@gmail.com>, git@vger.kernel.org
Cc:     Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git clone command leaves orphaned ssh process
Message-ID: <ZP2DaQMA_aFvjQiR@debian.me>
References: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oYV0AzH8/REcmM8V"
Content-Disposition: inline
In-Reply-To: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oYV0AzH8/REcmM8V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 10, 2023 at 09:38:54AM +0300, Max Amelchenko wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> Run the command:
> ps aux
> Observe no ssh processes running on system.
>=20
> Run git clone against a non-existent hostname:
> git clone -v --depth=3D1 -b 3.23.66
> ssh://*****@*****lab-prod.server.sim.cloud/terraform/modules/aws-eks
> /tmp/dest
> Observe the command fails with:
>=20
> Could not resolve hostname *****lab-prod.server.sim.cloud: Name or
> service not known
>=20
> Run:
> ps aux
>=20
> Observe a defunct ssh process is left behind.

On git current master on my system, I got sshd (server) processes instead:

```
root         835  0.0  0.0  15500  3584 ?        Ss   14:38   0:00 sshd: /u=
sr/sbin/sshd -D [listener] 0 of 10-100 startups
165536      3865  0.0  0.0   8488  1408 ?        Ss   14:39   0:00 sshd: /u=
sr/sbin/sshd -D -e [listener] 0 of 10-100 startups
165536      4039  0.0  0.0  11308  1920 ?        Ss   14:40   0:00 sshd: /u=
sr/bin/sshd -D [listener] 0 of 10-100 startups
165536      4374  0.0  0.0  15404  1920 ?        Ss   14:40   0:00 sshd: /u=
sr/sbin/sshd -D [listener] 0 of 10-100 startups
165536      4399  0.0  0.0  15404  1792 ?        Ss   14:40   0:00 sshd: /u=
sr/sbin/sshd -D [listener] 0 of 10-100 startups
165536      4732  0.0  0.0  15404  2048 ?        Ss   14:41   0:00 sshd: /u=
sr/sbin/sshd -D [listener] 0 of 10-100 startups
165536      4943  0.0  0.0  18004   848 ?        Ss   14:41   0:00 sshd: /u=
sr/sbin/sshd -D [listener] 0 of 10-100 startups
bagas       6841  0.0  0.0   7668  1092 ?        Ss   14:43   0:00 /usr/bin=
/ssh-agent /usr/bin/im-launch /usr/bin/gnome-session
bagas       6908  0.0  0.1 162780  5488 ?        Ssl  14:43   0:00 /usr/lib=
exec/gcr-ssh-agent /run/user/1000/gcr

```

What is your ps output then?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--oYV0AzH8/REcmM8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZP2DXgAKCRB7tWyQc2rT
CL4QAQDs+7EzlP65EVwEt6P4gRfwmh9ifysuVpIm23rPLm9X3QD7BZsmO9xPSFAj
k0VOy5k2php4UcB4KEaRaDz6MyJyLQg=
=XQmn
-----END PGP SIGNATURE-----

--oYV0AzH8/REcmM8V--
