Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DF1C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C02920656
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410346AbgDOQRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:17:19 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:28264 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406901AbgDOQRR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 12:17:17 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id A33B970BEB;
        Wed, 15 Apr 2020 16:17:11 +0000 (UTC)
        (envelope-from vd@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 492SDR37l1z42vK;
        Wed, 15 Apr 2020 16:17:11 +0000 (UTC)
        (envelope-from vd@FreeBSD.org)
Received: from localhost (APN-123-246-8-gprs.simobil.net [46.123.246.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: vd)
        by smtp.freebsd.org (Postfix) with ESMTPSA id B2DE917C03;
        Wed, 15 Apr 2020 16:17:06 +0000 (UTC)
        (envelope-from vd@FreeBSD.org)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id f93339c7;
        Wed, 15 Apr 2020 18:16:47 +0200 (CEST)
Date:   Wed, 15 Apr 2020 18:16:47 +0200
From:   Vasil Dimov <vd@freebsd.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vasil Dimov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] range-diff: fix a crash in parsing git-log output
Message-ID: <20200415161647.GA39892@smle>
Reply-To: vd@freebsd.org
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
 <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
 <xmqqsgh47okk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <xmqqsgh47okk.fsf@gitster.c.googlers.com>
User-Agent: Mutt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 08:31:39 -0700, Junio C Hamano wrote:
> "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Vasil Dimov <vd@FreeBSD.org>
> >
> > `git range-diff` calls `git log` internally and tries to parse its
> > output. But `git log` output can be customized by the user in their
> > git config and for certain configurations either an error will be
> > returned by `git range-diff` or it will crash.
> >
> > To fix this explicitly set the output format of the internally
> > executed `git log` with `--pretty=3Dmedium`. Because that cancels
> > `--notes`, add explicitly `--notes` at the end.
>
> Good finding.
>
> Shouldn't we also disable customizations that come from the
> configuration variables like diff.external, diff.<driver>.command?

Hmm, I am not sure. I just read the doc about diff.<driver>.command. Is
it possible that the user has set up some custom diff tools to compare
e.g. .jpg files by only comparing their EXIF data instead of the entire
(binary) files?

Surely if the customizations wrt diff.external and
diff.<driver>.command produce result that is unparsable by
git range-diff, then they are not good. But maybe the opposite is the
case?

I don't feel confident enough to judge.

--=20
Vasil Dimov
gro.DSBeerF@dv
%
Sometimes I really think people ought to have to pass a proper exam
before they're allowed to be parents. Not just the practical, I mean.
    -- (Terry Pratchett, Thief of Time)

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQzBAEBCAAdFiEE5k2NRWFNsHVF2czBVN8G9ktVy78FAl6XM2sACgkQVN8G9ktV
y7+FiR/8DqgdQGRK0Edq3uli96spL1AA4eyx4s72y2lvTd/uWJrvAcM570Cv90xd
HiNz95lk1qTvUeeP5X4RBN7N/zbhb0WsYbinaguMrKHcuZTaOQFIPltaOWgIe/D7
wjYzIA3/dpyvm6wPWoWD13fizl9fC0KKiqZmFvSIvqCaxlFlP6LFOBNzqG1ylZID
iUN7xfW2GBEgZ50CkWI95qr+h/PR2qMXBg2gIqVnh/Gfg/aUkMebXAkDvr88dFA4
Wj56aLh/dQaIoo5DEIw4bBDhTz6QV8WotO83KXw4IcSWaT20ULVYf2wTFTMY4OKW
hZC4jSSqN3jsz8NYVkQTuZFkrP5kUpr7QrJOCVruwf3dhjnGKW/ndtd8pHvjbD7e
G57oz308X/U1y9rNKcGxXVB/ngR1WvXjvavi1qMoZHy1jxAfhJXGV1oV3oeD6YTq
4rmLWIYwJvfncoFj6ucK+kzRhOa7pEjPqbtdjc73C/kYf1CR08Vn8VZV8lZXD4SR
/DbRRgb4TFJrmOjRWOvrj/JGILnf9wFQxa9BpBsythkzOkkyQi3I1M/isyZakIYj
pRXQBmGFMIgHqHiGfZaEDiCEdSxsEPqCot5rCBfRmpvYq95vJzTk/Bj2PY353ecS
A0woosxgq59l1tMoPOAbs/N2Cbn+WHeG9Cl5AXpJg+mg20GdwN8j6YpvyUHURHTx
ku3GZP2Vok+4JtWnIQE4Rmy94GP6SaUVYX5AQxGdxB7RoNnqKVZQdvj6rWyC6wlK
cYmQx9CW1ho7stjdIBPgW+EhQdmGR9frEh9LKnGzG1qiwAyzJCky0q61LtmKcDNN
HA9rmx/EJO7drZQRyQLMFu3jAQsAN+FDDm94mwyt6Yj02brSz6GEnGdEkizzvxc4
0YiBS/fDBHYBDB7MkdqmNwYv7K1SJqeUx9h6qwLufi0ATpB0gN6jREn+ACSj7ZHh
4zA4vuZBc6Dy9f10EJY4UUxuOVAzmgMfvmCMGdztRLrYiL19aG4ZzSA84iNnyqlc
xWSkxnxDZsy60FupJrHcJOKsWDl9c+6ePD7LrS6MEaJmpjbC1t6TERXxWjQ+x4aN
jnYiOGJ5xhnRX/UDDssaczHd8DViM2MkmIIF29uSH5Fk1LgnVq88vFhLlfo7URAX
NvOZmSHNW2x0NX4V3vAkQBZX2uwjsFx4D3UBGRsuK/6bRruJATjaVh+AONFign3I
KGE8b/S7STho4PCD1MnajgyS5EoJq9GQT+95GD8i50qPn1bKcejEA3n8u/jdzFQH
LsIEeHNORSepBY0wpPpPrLJt/Xd3NwGonosPw1ZBJnSctmcag7rny4U421g4fxLl
W3W8BK2l0Wc+VySLEoZKIv4JZw7qdQ==
=9cQR
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
