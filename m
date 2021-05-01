Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CBFC433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 20:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B91613CA
	for <git@archiver.kernel.org>; Sat,  1 May 2021 20:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhEAUDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 16:03:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45842 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229912AbhEAUDQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 May 2021 16:03:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 22DD16044F;
        Sat,  1 May 2021 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619899345;
        bh=A03lDu4zSY/aFJa+xT5zjJO9G/KRul05coY1S4TUcOw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=q7svIVqR3DseGvouRIywvoeIOhX+1ItQ3dCoCZ+ZB8P/mFKZ+QrKX/UXJSPKYO8Dk
         m2XfkVPNQbwwQuNBXe10qMTTozu38OavGVo0eOPPxr+yi9f+i0ypuyPgMx7T0wmmdr
         erI/aBJdnfUrICsTiAz7ZTbqX6EY1PW6caed5juQsYCwJkSpG5sld4bh5IQUqUYQiX
         sPi+SoyK9n6EB+uX8jLhvihWongefsH8prSLg0uSYZZv6cXNWEUZp+qYZRdQCJLlN7
         BIQQijHZpUuFlEaYEbTO5BehqjeIy0kwjQ4OhD0LmGMBicxL/BaQ1ocGKOVG6BMhHc
         eM7e0NtQIWa3soNZMCYX7xwVD3ceWVfe/6dFdu69wbRb+p7yo+fzDbM7pjuIDFosbg
         X0AKgmUSuv8DZV/jAUmvjikEfV/g5c2htr6WLl4oOTTeRyahjdlGc506y55U5SArJJ
         4giqece4HU4ITEQYoUr5K1Iv6MEdTwv0N+MCgTwqKdyNUtO3rtI
Date:   Sat, 1 May 2021 20:02:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
Message-ID: <YI2zzKMJ1eDH3U/S@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+aPnQq+YoQwbWD9"
Content-Disposition: inline
In-Reply-To: <20210501145220.2082670-1-lenaic@lhuard.fr>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H+aPnQq+YoQwbWD9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-01 at 14:52:20, L=C3=A9na=C3=AFc Huard wrote:
> The existing mechanism for scheduling background maintenance is done
> through cron. On Linux systems managed by systemd, systemd provides an
> alternative to schedule recurring tasks: systemd timers.
>=20
> The main motivations to implement systemd timers in addition to cron
> are:
> * cron is optional and Linux systems running systemd might not have it
>   installed.
> * The execution of `crontab -l` can tell us if cron is installed but not
>   if the daemon is actually running.
> * With systemd, each service is run in its own cgroup and its logs are
>   tagged by the service inside journald. With cron, all scheduled tasks
>   are running in the cron daemon cgroup and all the logs of the
>   user-scheduled tasks are pretended to belong to the system cron
>   service.
>   Concretely, a user that doesn=E2=80=99t have access to the system logs =
won=E2=80=99t
>   have access to the log of its own tasks scheduled by cron whereas he
>   will have access to the log of its own tasks scheduled by systemd
>   timer.

I would prefer to see this as a configurable option.  I have systemd
installed (because it's not really optional to have a functional desktop
on Linux) but I want to restrict it to starting and stopping services,
not performing the tasks of cron.  cron is portable across a wide
variety of systems, including Linux variants (and WSL) that don't use
systemd, and I prefer to use more standard tooling when possible.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--H+aPnQq+YoQwbWD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYI2zzAAKCRB8DEliiIei
gUMOAP9MalnQwk2fgdnHIjr3Xys0G6aaid7NXb6gTaZQVNDFAQEAxZ7mJQAy8+cV
rLwhZgYhgchGN+R2LGKtf7AUV/9oQgs=
=0kgO
-----END PGP SIGNATURE-----

--H+aPnQq+YoQwbWD9--
