Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC3C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 21:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1DD2084D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hONGawWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDVV1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:27:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgDVV1K (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 17:27:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 325AB6088B;
        Wed, 22 Apr 2020 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587590799;
        bh=saPBVM/bRRMqh6F+dZbYIQQKLF4E1OaStAT6qK9IxNQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hONGawWa36u3NMkIpg1CKk1gnCWFI7xzM5r5aRvGcDGwwBfgvV25lXTGQ0hHFniRS
         ru22ikVEO/r09gBNLYjBfre/A0fkiGGLYIO8J95P0v8NUHg5Km0wkc+rQm51IuPCZu
         kyPhoaUehrBjzzvJKFKt3Ak7c4ZcimuciI4ymWX973Wyv1F9a/kHHFuoXqwTU4W076
         t8mG100t2CHHZ+t5Cozayg1goP3l4tsuacs7T107YXUcilb9fsAf0Qu5WE65Vh2OO2
         5htpPC15hvNSdQkf2YUtrNOIG/0Fvs8OT09z62c7QyK4n36sHeQZK8dMXpkmtqcKYa
         5ilfxNetsjJ2nXZAPN0AYP2piJXo6FGi41NYVWtMU2sSa8A58ehsuY+fYR/EgBObTl
         ZKVtMdPzZ5l+a2SU7cRpyA10MOxW902nMf8qaC7Ey/Hkcu/ccq7tLZaaj8ipjIcXcG
         HyWKIgAdjW3ZQYtpff/ZMe4Lp/TuKxQ8SRIflExu+HaTazzuMLC
Date:   Wed, 22 Apr 2020 21:26:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Yuri <yuri@rawbw.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG REPORT] --date argument doesn't validate dates
Message-ID: <20200422212633.GI6465@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Yuri <yuri@rawbw.com>, git@vger.kernel.org
References: <d633919a-99a4-0b90-f355-66a17000f83f@rawbw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline
In-Reply-To: <d633919a-99a4-0b90-f355-66a17000f83f@rawbw.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-22 at 20:40:48, Yuri wrote:
> For example, the following command accepts an invalid month "Dx" and an
> invalid year "20221" and sets the month to "Apr" and the year to "2020".

The --date argument accepts a wide variety of formats, including some
formally specified ones, as well generalized handling through the
"approxidate" approach.  So it's designed to operate on formats that are
not well understood and do the best it can with them.  This also allows
it do things like ignore the irrelevant word "ago" in "5 days ago" and
still do the right thing.

If you want to be sure that your date is uniformly understood, then the
best approach is to either use the Git internal format or RFC 3339
(which is a profile of ISO 8601).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqC2iQAKCRB8DEliiIei
gbjxAP0V8kCOXuXl8r7m94xBnhpy7Mti/Cjt0uHF0GkAyYeinQEA8kH/ge2W2uau
yQO6RY6rbZAoD3Eieln2Dp74XaWoFg4=
=U/D8
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--
