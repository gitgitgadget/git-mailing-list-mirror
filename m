Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E3C433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 12:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358009AbiBEMaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 07:30:06 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:15317 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbiBEMaF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 07:30:05 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:636f:39d5:1d6e:7381])
        (Authenticated sender: jn.avila@free.fr)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 4512D13F880;
        Sat,  5 Feb 2022 13:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1644064204;
        bh=NPN6tJvFpObvNS1wJPWu8CRI6LYYdbvJIUxZlO8s8gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBJrejvuHi04pao1+6jMG0yitzkJc1Ea9wn1WFP5wiJuAFNSMOp6Py/GKpmK3ZI2s
         S4iGiL5e8QcPO/d2kQf2Ak7iutCHiteGq8VRyvLqpqlvBW9I5GDqda4hbd03dHnSBS
         LAoej410cmqv/rlLvS1HT2wxKvAz56louBN/JCRDz2cX/MvbqQTb47FERTcIsa2DFs
         UrtRqpQPLIUms7nvvWqSC6jGgK4VwnMfoQn+Q0l/nsBUY+5x5QObZtPHHmJy93Vm7s
         lExHBksteZaSm9pv0aqvTpU4HODX8t2uMxDUMTynz8YIEmffmyXGe00hR2dCpKXXAT
         ziHJ05vgUks4g==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org, Robert Coup <robert@coup.net.nz>
Cc:     Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH] fetch: fix negotiate-only error message
Date:   Sat, 05 Feb 2022 13:29:59 +0100
Message-ID: <3251849.E01RNdcrvH@cayenne>
In-Reply-To: <20220128143602.31842-1-robert@coup.net.nz>
References: <20220128143602.31842-1-robert@coup.net.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le vendredi 28 janvier 2022, 15:36:02 CET Robert Coup a =E9crit :
> The error message when invoking a negotiate-only fetch without providing
> any tips incorrectly refers to a --negotiate-tip=3D* argument. Fix this to
> use the actual argument, --negotiation-tip=3D*.
>=20
> Signed-off-by: Robert Coup <robert@coup.net.nz>
> ---
>  builtin/fetch.c        | 2 +-
>  t/t5702-protocol-v2.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 5f06b21f8e..af689a72a8 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2029,7 +2029,7 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
>  	}
> =20
>  	if (negotiate_only && !negotiation_tip.nr)
> -		die(_("--negotiate-only needs one or more --negotiate-tip=3D*"));
> +		die(_("--negotiate-only needs one or more --negotiation-tip=3D*"));
> =20

Couldn't this message be changed to

die(_("the option '%s' requires '%s'"), "--negotiate-only", "--negotiate-ti=
p")



>  	if (deepen_relative) {
>  		if (deepen_relative < 0)
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 710f33e2aa..59a49cede7 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -619,7 +619,7 @@ test_expect_success 'usage: --negotiate-only without =
=2D-negotiation-tip' '
>  	setup_negotiate_only "$SERVER" "$URI" &&
> =20
>  	cat >err.expect <<-\EOF &&
> -	fatal: --negotiate-only needs one or more --negotiate-tip=3D*
> +	fatal: --negotiate-only needs one or more --negotiation-tip=3D*
>  	EOF
> =20
>  	test_must_fail git -c protocol.version=3D2 -C client fetch \
>=20




