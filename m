Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD78C43467
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 09:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFC92158C
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 09:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iYeCTLh8";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1kDlXWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406303AbgJPJQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 05:16:01 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44003 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406183AbgJPJPf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Oct 2020 05:15:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8139312A1;
        Fri, 16 Oct 2020 05:15:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 16 Oct 2020 05:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wEKMu8Y5miKna/yxRWzB2AuIHjO
        RPzOTL/N01idyKQs=; b=iYeCTLh8ly+UkSuNLgo1/NbE16VfMEvHwU86PebzNYl
        L+7/CwszEcJlaJZNQu6YkZR7KQz7qajExGLNGpCgFslyu7OpsFUuSpNK2drp3Rmb
        81O6WpIClW/mKdGsvPzWwBdmZ/zYH1S6pwQ9sY90ZIjl144ZUNMpXuh+tGaKTKqA
        3npwBoATUgBEmfFYTjfXcHhzeXVJavOicnijYwWi0bez126/vAeBrF8JY/f8BOsZ
        d6yIAYbzDeQnQC+dTH/EePtFC3a7xoLwCTMWRtaH5cjE7JM/G5SMnUeFUmJrhVcA
        wCz2CSKgDZjFsUeIxCaJbVqVvpi9PAHC/Fv04DzR+2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wEKMu8
        Y5miKna/yxRWzB2AuIHjORPzOTL/N01idyKQs=; b=E1kDlXWj1wphAOkv4UDwLW
        XM9fQyU6MM4chE/R3M9BdINyppgSkXT+KRs2xYZzjA2nTqCiinTsaMbPdjD/AvqW
        E/iHqNpvvRR+WVsI9zcsvB2hw3GhxakP/FZnYRq/AruzJMk1BL+9yzESXhdkFk9x
        yViZZoRWiDFnu+LS8b9AnBexJdMMBAQ0cW9Jf5HfRL+epKqSc+Z4AhEWXq3HhWEE
        eG705whXwxjCfCmroZ9vTJ1CBdvmJokz00PZ0eaXqdC0TspFN2hFsWPRiXDpUncz
        OaPsUbhyhbLP05b2ApWTyxaPK7QFYjno/rjOgY34jyPozfGB0y6V18z6l3ih7myw
        ==
X-ME-Sender: <xms:tGSJX-CEMRrK6jWYXN0MYYybMwR1v-DRSOYVAyZOaAng2xuYYDaHyA>
    <xme:tGSJX4jv7KpjOdIGxjtS4ZC_CsQ6QQguXlsrqEeAYrpaBQqJEPZH4w8XOK8NxPiSb
    X3QP-rBVhScWAmxrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieehgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejkedrheehrdeifedrvddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:tGSJXxmF1l4qWLSv4H2802iBrmRmAjlXsn_hl8ylaCffRX-6YJjeGg>
    <xmx:tGSJX8yN2sIcesnWSSWhnUpRfHiyTiUp16QyU2LpmBQalo6FDI5xTQ>
    <xmx:tGSJXzRsxy5bc2p4i8yeNgxXj9rGHtaj3oFPAcBdh_X3qKlNfEiLmQ>
    <xmx:tWSJX0JVQn2FZhWAmdgChPliOtMoTwO2dR2S7ogLqywqbsHkwV252g>
Received: from vm-mail.pks.im (dynamic-078-055-063-228.78.55.pool.telefonica.de [78.55.63.228])
        by mail.messagingengine.com (Postfix) with ESMTPA id 64DF93280064;
        Fri, 16 Oct 2020 05:15:31 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e4a15459 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 16 Oct 2020 09:15:28 +0000 (UTC)
Date:   Fri, 16 Oct 2020 11:15:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
Message-ID: <20201016091526.GA70821@tanuki>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
 <20201002041214.GE3252492@google.com>
 <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com>
 <20201012152505.GB3740546@google.com>
 <20201012170527.GA21606@xps>
 <nycvar.QRO.7.76.6.2010131405380.50@tvgsbejvaqbjf.bet>
 <xmqqo8l6ku0y.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2010151346060.56@tvgsbejvaqbjf.bet>
 <xmqqwnzrh30f.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <xmqqwnzrh30f.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 09:23:28AM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > Hi Junio,
> >
> > On Tue, 13 Oct 2020, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > Somewhat related: I was wondering whether it would make sense for gi=
t.git
> >> > to rename `strbuf` to `git_buf`? Would that make it easier to exchan=
ge
> >> > code between the two projects? Or would it just be unnecessary churn?
> >>
> >> To us, "git_buf" is just as descriptive as "buf" and does not say
> >> anything about the nature of 'buf' (other than apparently it was
> >> invented and widely used here).  "git_strbuf" I can understand, but
> >> why should we?
> >
> > If it makes code sharing between git.git and libgit2 easier, why should=
n't
> > we ;-)
>=20
> I see no reasonably explanation why libgit2 is not the one who uses
> "#define strbuf git_buf" to make "sharing easier", though.

It probably wouldn't help much anyway. We already have our own buffer
type which we can't easily replace with yours as it's part of the public
interface. If the need arises, providing a compatibility interface for
it shouldn't be too hard.

Patrick

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+JZK0ACgkQVbJhu7ck
PpQusA//YKikUt7r2vyxTjw45Mdwxegu6HyrijHfnWEnUpb+xvH3yWLdX5d8VjBI
XBJn0LoOzONvZNc5aH6lK8q/6Kn1ibILwsMf87/XqIyCUF6VFEJghlF0108klZCE
t3IuhG8dYhoSIayyskQ7gjvTDilG4sRcmzPv4cUH9epPTYaDKCgrFlge9H3NPc15
Yz2eywjvE2n7HcNrD1F61DWcwKQ2ypJaHHi1reso6Oqw7ukSWk83nO+fuLSsVt/3
aWdURz2z11XfUmZ5LGF6NB9KDkJQVL9w40gLfculdqIb2bpAaswA5TdZzelSWHOi
QQgoVupw22+b3K3dEW/eSb4dCeanhpeW0rM1tqblM8kUSMxEW0c/iHA63LL/lQWE
Mch7zG/Vzi5UqWeY+gU09BW57XvcoTJXly3WXdrix/ZsrUMVTffbWHGKsfWp/gqT
h9BDVKcnhd1jRKb7MzSJOm5hcWFJV0ZVa17CzmA8ax9JZiyoaexT5vWbsFq9/SR3
fJKbP1VU0qD/jbBwLZDcBQPEpHHzBdKRWyp1N5HXEMvFtlkNZuI5bIt3mfkM/b0Q
KJk+WVFPxc334hLLqCbIpalh8e7iWTDpMm8VBdjCUG/4vHpS0KgxnOAYeoqyJIE9
/4s/ZmPE/Lvjsfe9KpZOhzRUX/W2gmAn9+h8vrTrJ7XRjcQQZf0=
=gqVx
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
