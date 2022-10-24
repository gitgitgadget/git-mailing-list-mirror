Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE9C433FE
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 00:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJXA2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 20:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJXA2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 20:28:53 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA16CF77
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 17:28:51 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CB8CC5A1FB;
        Mon, 24 Oct 2022 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1666571330;
        bh=Q6G8R2lB67zHYWhUTR5iBWnkdHcr18M97mi1e2//ZYc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oAfDjOuZfIb+zlz84uoRT6AKdAjh+EenWHBKvXBMhsvzfKvfNQ4VR4mIPVp0Gfnwi
         Gqbd4k/x1dssj9DpdQLTTpRufsTJ46nxWzZ8dnn1xr0BgGPUCXCHm3Pbl4JP6FnNub
         L59Urkwq4YAmEtT+WDLlwFGGIfNznDCE/rCfi1lOVOrXPv5p9TdVqWNOFrBvYLVDsZ
         RA65WGKi4KgoVPk7HJmKAuijo3ze2lvNX/fzctpPW97YOlom9ZQxdHKvkK6i2x3G0+
         +7UGMGBSOnjdZMgf5J8JwFBfoj14CBbfo+AVSKE938XrbJk1kK8ntkQE8XaDozF8kh
         wcJ8OJaYHlnQrorK9cimnClW84LXPJWRHQ4Ixp2EY7l6aX8OoEukZcGJVqpk85O7/d
         5xJCTDudQ1trsQYIyCTLtjmk7/Ah7FMGwLGsIRcZdf2dkYkdewZIfJ1ILh8kl130RH
         IarvMzWcBL10iIz62qqtYBXc+OVYEGndN+DvYKusKrXZIXmTFmp
Date:   Mon, 24 Oct 2022 00:28:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     shubham sharma <shubhamsharma4060@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: waitpid errors with shell aliases
Message-ID: <Y1XcQctK/SkDZCbt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        shubham sharma <shubhamsharma4060@gmail.com>, git@vger.kernel.org
References: <CADUYy5vwfOJOFBQ+zUmkrsxGO=E9N5vUbsVRgjBn_MMY2X6H=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bOagsImuIBlamrMX"
Content-Disposition: inline
In-Reply-To: <CADUYy5vwfOJOFBQ+zUmkrsxGO=E9N5vUbsVRgjBn_MMY2X6H=A@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bOagsImuIBlamrMX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-21 at 09:26:11, shubham sharma wrote:
> Hi,
>=20
> I am using git shell aliases in config and was facing some weird
> error. The error is not reproducible in all runs and occurs randomly
> between runs...consider the minimal config(alias section) below for
> usage idea:
>=20
> [alias]
>     A =3D "!f(){ \
>         ( \
>               // implementation
>               git \"$1\"; \
>         ) 250<dir/tmp; \
>     }; f"
>     B =3D "!f(){ \
>         ssh <server> <command>; \
>     }; f"
>     C=3D "!f(){ \
>         git A B; \
>     }; f"
>=20
> when firing "git C" from shell,in some cases(not deterministically reprod=
ucible)
> i observed weird waitpid errors of the type :
>=20
> error: waitpid for f(){         ssh <server> <command>;    }; f
> failed: No child processes
> fatal: while expanding alias 'B': 'f(){       ssh <server> <command>;
>      }; f': No child processes
> error: waitpid for f(){     (//implementation; git "$1"; )250<dir/tmp;
>    }; f failed: No child processes
> fatal: while expanding alias 'A': 'f(){        (//implementation; git
> "$1"; )250<dir/tmp;      }; f': No child processes
> error: waitpid for f(){    git A B;    }; f failed: No child processes
> fatal: while expanding alias 'C': 'f(){       git A B;      }; f': No
> child processes
>=20
> can anyone please help as to what could possibly be the reason for this?

Could you tell us what OS and version of Git you're running, and what
shell /bin/sh is?  I could imagine that there might be some weirdness on
Windows with the shell, but I would find an ECHILD to be surprising on
Unix.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bOagsImuIBlamrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY1XcQQAKCRB8DEliiIei
gX0XAQDJvUm6uiwzvuZSoaj2fft7jauLaGA0miISmzl8o4qKBwEA/cvwfMhMdkdq
0FwsT21YsTGvwD48ZnXu7MOu/KuVCwQ=
=7W60
-----END PGP SIGNATURE-----

--bOagsImuIBlamrMX--
