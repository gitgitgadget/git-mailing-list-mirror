Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DE8C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 00:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbiAGAbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 19:31:50 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:60156 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbiAGAbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 19:31:50 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8D84C5B252;
        Fri,  7 Jan 2022 00:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641515509;
        bh=pJr00xeWG4ayHAhwr8D4jRdrzaH1dmPfrP2Pmde+7gg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=E0fh3diCAvEdSaT49yU6jzhacz9MQpHIoTltWt/c4XKRZ6sSYN4zz2H7lsVimZPtM
         qCJg9x7shRH9JIfo2bT/rX1/TS6zUXZYL6H8Hk1jYej5eINFvmRM2TDJ65BpSAnAk7
         7lnr/ljWwRXtBNYGbS921OOB8+wNifgBS6CE8hyJUrlfqjH23m2JDYrq8IHnvLGEwR
         4McRIxQPNIdG8YPkLedqv+aQ73A2x9cUw7QDrRZlB5diPazK9cSKSjAx3ELQGqIRQD
         rIv6QeQV+pfGd7rYuThjiORFg4X8ENNdC031qN10s7SthiVr6FNNH1urf1UagpucdX
         VA9jmmySz7AiRbHYRS2Vof0u5Glk7XvZzbkHfVoGPiuhoptKKWv7O80j8lo/4B4Szn
         wlUrhj4yHhnnwL0LEyD2/okDnw8PauhHzDobzQaclBSFTIULNYqET9dzdJO4IS8xKm
         vH329Vu5jGkIywkoGYawkZsew2dilHnvFmyLCysEU9DJpN1iIHS
Date:   Fri, 7 Jan 2022 00:31:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Message-ID: <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jessica Clarke <jrtc27@jrtc27.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local>
 <xmqqh7agbiuq.fsf@gitster.g>
 <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
 <xmqqfsq09ziq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sYw33V7puzrXetd1"
Content-Disposition: inline
In-Reply-To: <xmqqfsq09ziq.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sYw33V7puzrXetd1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-07 at 00:10:21, Junio C Hamano wrote:
> Jessica Clarke <jrtc27@jrtc27.com> writes:
>=20
> > This is also true of uint128_t, it doesn=E2=80=99t fit in a uintmax_t e=
ither.

I don't have this type from either GCC or Clang on my Debian amd64/sid
system.  I know those compilers support 128-bit values because Rust uses
them, but they are not exposed in standard C and therefore those
compilers appear to be compliant when run in standards mode.

> uintmax_t is supposed to be an unsigned integer type capable of
> representing any value of any unsigned integer type, so if you have
> 128-bit unsigned integer, your uintmax_t should be at last that
> wide, or your uintmax_t is not uintmax_t as far as C standard is
> concerned, no?
>=20
> uintptr_t is an unsigned integer type that any valid pointer to void
> can be converted to this type, then converted back to pointer to
> void, and the result will compare equal to the original pointer.  So
> the value of uintptr_t cannot be represented by uintmax_t, there is
> something wrong.

Yes, this is the case.  The C standard mandates this behavior.

Now, as far as I'm aware, the standard does not mandate that that
uintmax_t have the strictest alignment requirements of any integral
type.  It could be that other types have stricter requirements, for
example, on some systems.  But it is required that conversion from void *
to uintptr_t to uintmax_t to uintptr_t to void * preserve the
functionality of the pointer.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--sYw33V7puzrXetd1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYdeJ8QAKCRB8DEliiIei
gZrBAP46NzkpU7KbvvRnh87NyyBYvX3duwCbxPb+yzX4db74CgD+NZmjJ/qDE/TI
mgGqsP4duBfG1R2is0rcjXaX3fATBA8=
=567z
-----END PGP SIGNATURE-----

--sYw33V7puzrXetd1--
