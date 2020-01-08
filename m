Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF01C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 12:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308672067D
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 12:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="d0TNcDBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgAHMo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:44:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33648 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbgAHMo5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Jan 2020 07:44:57 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C150B60787;
        Wed,  8 Jan 2020 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578487496;
        bh=cQ0+RyKaA+1Itfphey52p8nR5sCn8rxKwHjiRhvbNqc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=d0TNcDBUDrk1anJbyOXpKIhHLj1H9xwg9UeT8CINk9q2dz6ZuHHj9iRHrMa5GXYY0
         axo6Rji9cc21CZIS2So+SYIW8Z3vQIRtKiHIGcfP6qPR8ur7Zruft/mTQ/Gob3kh9Q
         d3Bma1Af5FJGZ7JsCtxhKKokoBJgzCxSQYSBNK5yCYCMdt5i8pdGoZ2pyQcUqNZFak
         XmofEpd0MKToeu5GPJWi2fw10DLseZRMQfsg5ZZdGzVcxFbdPoY4SpZtD/Ncm4TAFo
         K5yguBqUB1uB8mMmnxpEz+WN/TFB8VKi2s94jiy4vSyx5jszlQSmf55c6m4Cq3hEt/
         vKJKZ4Bx7noX1s06Z8Zx2Xwhi7jjn0zpdjkPJhlAZEkecnj29C8YI3M0qzT6c+S5lL
         0pl/v1o8EY6ONwUqkI/3WANlpzkWr2jE0RgMElID2yhlj/tHOVz6iTnGORtQZBlsOh
         yhLHpeqjzOo041Lw99wdtHFl3H4CN96L8BQgQGvPib8cKKpZugq
Date:   Wed, 8 Jan 2020 12:44:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] transport: don't flush when disconnecting stateless-rpc
 helper
Message-ID: <20200108124450.GO6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200108033451.GN6570@camp.crustytoothpaste.net>
 <20200108071009.GA1675456@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qSHHer9gQ0dtepKr"
Content-Disposition: inline
In-Reply-To: <20200108071009.GA1675456@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qSHHer9gQ0dtepKr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-08 at 07:10:09, Jeff King wrote:
> diff --git a/transport.c b/transport.c
> index 83379a037d..1fdc7dac1a 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -737,7 +737,7 @@ static int disconnect_git(struct transport *transport)
>  {
>  	struct git_transport_data *data =3D transport->data;
>  	if (data->conn) {
> -		if (data->got_remote_heads)
> +		if (data->got_remote_heads && !transport->stateless_rpc)
>  			packet_flush(data->fd[1]);
>  		close(data->fd[0]);
>  		close(data->fd[1]);

This is as simple and elegant as I'd hoped for, and as usual, it's well
explained.  Looks great.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qSHHer9gQ0dtepKr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4VzsIACgkQv1NdgR9S
9ovvaw/6A+pDyXkPBjO++CUvcLuLOeOT2ZPv12Iv/XIpccMVTcREhjM6ODs0FnSJ
BFZwAZ0Y/BvMyKwdpadN5o/baPaiOi52wx8Z5c8pBur55BLZeZ0Q0BSZFyhAiYQq
/oBJdUPIpDWD8OvKAGKQDGU1qQiAiedQPxRVqJ3IZq2WGPYQ4ltsT9Catg0tF+6l
6MDt7X6Qrbjsof63p07jnK87jYvXazoBPGuOqsEprd9AT31OgAHM42bt/V5XZU0Y
gJpVd/L/AkzhAaGdp/U657iLSpDKoVC1aLvSa4V9JkP6fIAKv0Oz7mkZter6cz/g
IaC3gnv2ZKgs9VeblsH1bzgqp55L3lGipKs+HKWlsEYs01eYIzzW4FXYJeDSzKY9
NMb2aPmAsvA4MCHueD3Kuv4qwQOUQgIHf04SxolIOYD7dpMgmOqUmpd9Csf0ny7y
oOQH4Uzrjg16W+PC36sxoUrTZfLS/kdf3EaaBk1BZb6GaUxTZrsbnbjkOmYdn5Vh
LUnizo8eNKt36hKUNR0UXgYjjeaCQ1x/U6l1NLZtC9vsLUtM8GsbNqr4yfsIwr7H
NKPw2ry23wXPrqEfBI1IlRIjcKyELLgu6yuiJQqXP39Lww/f+7SwSmWo09/qay4A
70brz/ki/2W/nyfdjIt4YXLkaOd1hEnKA4m4KK1a4c5TFhZmg40=
=R+hl
-----END PGP SIGNATURE-----

--qSHHer9gQ0dtepKr--
