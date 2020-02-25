Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0054C35DEA
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 00:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E8C20838
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 00:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qJ9ITlBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgBYATa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:19:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40720 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgBYAT3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Feb 2020 19:19:29 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 309C36048E;
        Tue, 25 Feb 2020 00:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582589968;
        bh=YZyOEBb6hZI81bhNqyu/t0OGQ/jLnq2HSJ5G/Mjsvck=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qJ9ITlBBWl6mWdSQ+Ye1AXCQKT7HD9X8jI4k9pQy/ozg3VXQUO5Y6GWj2FYwWNgUs
         1Q9whcOra3qHw7H+ndsti2sA6MXaUF+szz3NOFkjV1oRwdPeQTKLdIEuaavOzMBFwR
         +HVdUcBj4eag7N6QkupUOUPCd0lDV/lUSXKYUtxyj7M4fKeJaU/d36v7K4ljSyZx2m
         fqBnJ6NrY++0sr5A9RIIZSsuKpSjBnTV6Z5OoKPMD80B415D4DfY/nD/zaImWeGPdt
         VP2JEED6EqBQjhhmQZWVv3WztjOBdEQwVK/KR8gSgoWC5ZdKSqe+0FdBvIZl+3K/OS
         1a5v2BhBr4m5BRwjtG8C7vIM8fLZLqfCt3Bq3hNkh29uWXIj3zOwyfx89623gjVYrK
         B1BfbJT2DVb1T2zd0n3ly4IS6Z2VtUEPBW73/VLOW30kqT3bxKxRIq2vqHlHtJaAcW
         ZowzWgzurBELy8TekZRBk7d29qbWqtt4Ai8PpIQUhnQ9no7hXZD
Date:   Tue, 25 Feb 2020 00:19:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/10] pack-objects: read delta base oid into object_id
 struct
Message-ID: <20200225001924.GJ6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200224042625.GA1015553@coredump.intra.peff.net>
 <20200224042944.GB1018190@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EMQjp+MvU6EBGjHc"
Content-Disposition: inline
In-Reply-To: <20200224042944.GB1018190@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EMQjp+MvU6EBGjHc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-24 at 04:29:44, Jeff King wrote:
> @@ -1707,9 +1702,13 @@ static void check_object(struct object_entry *entr=
y)
>  			unuse_pack(&w_curs);
>  			return;
>  		case OBJ_REF_DELTA:
> -			if (reuse_delta && !entry->preferred_base)
> -				base_ref =3D use_pack(p, &w_curs,
> -						entry->in_pack_offset + used, NULL);
> +			if (reuse_delta && !entry->preferred_base) {
> +				oidread(&base_ref,
> +					use_pack(p, &w_curs,
> +						 entry->in_pack_offset + used,
> +						 NULL));
> +				have_base =3D 1;
> +			}

Thanks for using oidread here.  That makes my nascent future series that
adds an algorithm member to struct object_id much easier.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--EMQjp+MvU6EBGjHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5UaAsACgkQv1NdgR9S
9osdnw/9Gnab494+tulyDSil6DkF9qYZfmNQ9oySmKpoTzwKoCwTGDa2mhmQpuKQ
zO1GoOcVKKNf9Ck6fagGylwu1WXlc0pEVPVnVeOXgt6OO+enUUewueWmLLVhDoxi
Pv+3yg332YOhF10SLxxhqcSp+GraiorZvEVXkqdSAYw/x5iry/tU5aHlsTNdejur
uRXFfeSo2Yjap33ECl80lGlIbvxgx417j5bj5sRKZUhWWp3ICZJR3kED++DT/pey
GPEVX1Sx0z/YkGUSqujOlS/ydUMakSNM5yxu7mpolMyzhSpM/gysw6OMWTvFzWje
oxqKY9crF0aciWkDesUNCRjtiPjB2fz1IVvyV6+p+k7UjAGUhUQbPfdGHq67Grwl
Z/pr3C3dCo3aq6S+oBsCnBlQZ5av5PpuhsWmUepfnfMTa3Ic125+Gt+chaTv/jCO
JVqW8yYyT2NSsGTFESTbSAHvvunOgai2kJiEiFoBD9UnLatZLxfcWxM0akvfZYLz
57xOOw7dZEQ2/vQqT3pvozLZhyxtgdC8AgiLLOMi74nPYQmymaNkvJ3Ovn0OjDJu
C9RPI+4YNDM44SnU96m0qFBT0lxfX7gjYl8GkYaKGrox0pyDDK0n0YnETBfFx7UV
1JvmVZKlEe4WZbRrhzdwVVVt3+UKbF2nYKuy/lbZG5T0eKw9UfU=
=Y9aO
-----END PGP SIGNATURE-----

--EMQjp+MvU6EBGjHc--
