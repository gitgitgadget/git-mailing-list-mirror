Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C3DC4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6087B246CD
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hv1V4vIf";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMgli8FZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgJ1Vuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:50:55 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34279 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728099AbgJ1Vuy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Oct 2020 17:50:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A2FF8DAA;
        Wed, 28 Oct 2020 14:22:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 28 Oct 2020 14:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=5Gb4qsQiO+hbmaNYNG071mZLYxA
        Oow3K4BgfbwNPDKw=; b=Hv1V4vIfha/uqYAS/Bz5/nAQaIMuFfpSSv6qVJR19BS
        vFSR/WNk+u1SVUnJvq6n97adeTnljQX2c0cXF5qQ7ef1VTPRGQi7M5f+BHjFFlIu
        1S/EYHTER+KyRZYuf9WUTSfiVXujOAidmGx1ZzgN33YaqhKKPpq7sY8sGcoC2HME
        FZhCN2Eo4tS2Q/W7mwOP76BzL3hPfJDCOCSYTP1Bpz7KQrpIne0WrEGbIINTsmMX
        csd015MIzvS1/+9W0DALG4AdaC4OMjwMwYe5AQnQusD9bF4VCizLzrCMpxYirGOI
        94xHJ9ShOo1c9VfOJbHr02zNq8+ylqZoPuzgxpjsOOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5Gb4qs
        QiO+hbmaNYNG071mZLYxAOow3K4BgfbwNPDKw=; b=HMgli8FZhaNlGfDHQxcm8q
        cvB+4cwIsz7VW2fGxaiy7K7f/gCskvqmMwnDgvJZ/jfBt+uYzZHlRgIUr00pWL6Q
        P0tFWMct9nrAJGzfDJ3wAEjXPgGU3fp7YMeCeOiPct1/frfgVDDGwa7ka6ScAkAx
        ffbUuLFBFO16/75zbWFXDJIPc73FQuSysmor3ljoASotPGZ+rlFXE+3+lC97PSLM
        2GOn8xie7/VCJsfsVgcDDRzQiaxPCiR2N1XBqtMLv32gxFBugrWjJoD4MiWKnFjP
        HwtriE4bmcg9dpaKMjiO5y5dbJhW1W1ELWxMdCwPeKvomMSDE6bLNFCC9LgFoFeA
        ==
X-ME-Sender: <xms:0LaZX6hix6zIs6hFDFQp2lndThqvitr-NxGMGQM5nL2m51ZyMinIIQ>
    <xme:0LaZX7ANXp421kFrZ-KqsEFYyGUHvwmLnDW8TIuiIwM9NA3blDLBt_kd8JL4IRZJl
    PVM66rwOZSgejEN1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrledugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedruddurddukedurdelleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:0LaZXyFM-CPU5J9-E4tsA_sOSicR81Hjn8Tec9NFAdM5OikayTnczQ>
    <xmx:0LaZXzR8bXZk5mT0jrgfunOjgVVMneUbplT3TYmZLsRDCAueuVV_dQ>
    <xmx:0LaZX3xeaJ71k9GW2Gbt1GU1b2NrcWY64hxgZ0Pt5Iro1YBcniXdDQ>
    <xmx:0baZXy8_2qZ5I4pipa5ySgDNbejYM33bTCYn8inladMKKAymNqb5uQ>
Received: from vm-mail.pks.im (dynamic-077-011-181-099.77.11.pool.telefonica.de [77.11.181.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F288306467E;
        Wed, 28 Oct 2020 14:22:08 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 36a38ade (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 28 Oct 2020 18:22:06 +0000 (UTC)
Date:   Wed, 28 Oct 2020 19:22:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4] refs: implement reference transaction hook
Message-ID: <20201028182216.GB807@tanuki>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
 <20201023010315.GA1542721@coredump.intra.peff.net>
 <xmqqpn59k2xw.fsf@gitster.c.googlers.com>
 <20201026074303.GA972@ncase>
 <X5dhN+dsLXlKfukF@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <X5dhN+dsLXlKfukF@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 07:52:23PM -0400, Taylor Blau wrote:
> On Mon, Oct 26, 2020 at 08:43:03AM +0100, Patrick Steinhardt wrote:
> > @Taylor, given that you've already dug into the code: do you already
> > have plans to post a patch for this?
>=20
> You are likely in a better position to do that than I am. I am
> unfamiliar enough with the refs.c code to feel confident that my change
> is correct, let alone working. The combination of REF_HAVE_OLD, the lock
> OID, the update OID, and so on is very puzzling.
>=20
> Ordinarily, I'd be happy to post a patch after familiarizing myself, but
> right now I don't have the time. So, I may come back to this in six
> months, but I certainly won't feel bad if you beat me to it ;-).
>=20
> In the meantime, I'd be fine to apply Peff's patch with some fix-ups,
> maybe something like what's below the scissors line.

Fair enough, let's do it like this and submit the test change first.
I'll try to squeeze in doing the hook change soonish, but I'm currently
lacking time myself. So no promise I'll get to it soonish,
unfortunately.

Patrick

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ZttcACgkQVbJhu7ck
PpQQOg/9HTXAtqNXjabkdHbR/kuWg+4KKDu/8JnFEMVZBj5F+i/nV0mhIPderUoT
Shi0tGpvbUXMfI/CuVj5K5+A2BsWUU3xWlya5yDObJoha2JcyfESiOZ2xkcTDze7
AUym9nOC9SOVl3MjiTVolm4c8ehmYwg+oAOvmmZJFq0V34IgYTigJM+k5D0WnsPx
Ab1lVDVweC4XsN7+DtNM672BB6uugn3E8BnAc068jQuQt3/u3qCAJ6Bz1MghkqY/
zm4i/LeLrTnrbxXSpRSQNsZojJ0Pg2E3mLwktoepiSi7Wj2x9zgVcEqpaa47bRFb
AoOYHN5xB6xdSzB/4fiV3iLRN6qnzd+dA/O4KDIwDQUdS34mE5T6zWqeXPAbXkx0
+CdfSHL3jtzQtRV/jN8GyuN8vlohhhpcIS8UBsUl6mR2sXwBsOx/G25dHxhKty8V
LE3SBYm4JKt+62m74qvjKhno9hYlhqYNYvVG4O5wtHUOirhbL4H+xlxRq9sKJGYE
wwUSPtP6d3PDmcZ/mEMjXdjgUxUwJxmrxEXT3grV1YOT8JaXGIqfRtKdKuOtaH5B
dfQObNV/M6uDKrr+Q8K2rVSyb7ixeMaAU7qOPuK966p862zRnioVBNjL+RWHTSFs
y7lgu0xEZM36O3gdgVL/9WwQuOwf443V+8UY+vZKIn0cqJ9bpMY=
=6FvF
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
