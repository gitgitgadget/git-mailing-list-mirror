Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8ABC4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C3C22227
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bd7dQMr0";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWNL9iMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgKDO5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:57:22 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:39985 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730701AbgKDO5V (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Nov 2020 09:57:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9CBB6A52;
        Wed,  4 Nov 2020 09:57:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 04 Nov 2020 09:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm2;
         bh=FOqbtNrDjOT2hLNM7o581L8RJpXs0/Zvxr19U4ZAYjo=; b=Bd7dQMr0CSON
        VzsrnOwh/VuzmjMo5yU3UkEqxWXXb581tKpfasvtTebq4QDnZxhj9Xn/5AIS04UV
        eKrUI/VCvUEjZoC6OeEDNagXB3MqwT1Tmg7O7UVkvmAu+5byWwZqV2gZghLrLt7S
        3zmC7tjRgu39/Vc6drmej6Ct0M0Ew9RDpvIkFdjDImyXbwHXChj44hH/mTYSFFVs
        pfEIkBZe+SqCdSrCPhwe+cGxtlWed//GtgFvpi4W9oL0qm2X2wn7WDF09o4IbJf0
        Mcdef6VZy1LPo4GJJbdn50e007ObflzXb+E95vJTf1d48kzYiC6PAm4bYGb5owWn
        67SEKRJ37w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=FOqbtNrDjOT2hLNM7o581L8RJpXs0
        /Zvxr19U4ZAYjo=; b=MWNL9iMowsqS9MtYWX8OkzCVq9ACGIyuR20rhHEylHUY7
        qmk+jm7FQgwwCeDPUkkDCjXUEbfrX9xQheAMsgBRO32MUyXfFluFTI7mHm5CWMxz
        HcPmLAKMrAN4xSxceqKmJ9nO5JWgo/CFSwuwXd2rMVL9iSdq/U6rDzd/qqnKzwE4
        bUUVE8mZyBQG8cMokDpTrjLPXjN7kmy8gFUFZdSmNo3iisTmXxAChM3+Q0Sxy1Ba
        ABpa1n6nrkMFdIRarm5Hia3MUoSfg47tqJryc6xIdLFmUHg5OyvGEtgqkb/vxPdf
        cWXOcj0Q2eHOJM4Ot2HpVn+YaFtxFl6N6g3yV9jBA==
X-ME-Sender: <xms:TsGiX9ReDEZChqZ5kJCjG6CByAW4GBv-va8gr1A2TIaWAEtiRZ7ZLg>
    <xme:TsGiX2z03HumlYypDFBb4d90qpobV7lQg_kUzyvy7pbB_yFebSbxlVS_97WTybFc1
    kr6AANHLgWEg9qdWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecukfhppeejjedrudeluddrheegrdehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TsGiXy1ynTPlKhBuOeK3wJlAL2l6WOf9ekT9LW_3bgcJPprdL3jXiw>
    <xmx:TsGiX1B3_fp8WdJZuc5o_rUgHNpZyoG5e3Rsxqh5s15H60d-LJOIlw>
    <xmx:TsGiX2hxITFircPqP1u2Y1TmyGEbsJRSy0SzeMF8l77NNuJ6qqJw0A>
    <xmx:T8GiX8fIqgrUCfQSPqa7gF-jf4XO40Aphd3Nd9IU0JkUV-KuPDHjBA>
Received: from vm-mail.pks.im (x4dbf3605.dyn.telefonica.de [77.191.54.5])
        by mail.messagingengine.com (Postfix) with ESMTPA id 056993280387;
        Wed,  4 Nov 2020 09:57:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e8813921 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Nov 2020 14:57:13 +0000 (UTC)
Date:   Wed, 4 Nov 2020 15:57:12 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 0/2] update-ref: Allow creation of multiple transactions
Message-ID: <cover.1604501265.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

A few months back, I've implemented a more interactive protocol for
`git-update-ref --stdin`, which converted it to read commands linewise
and allow for more control via a set of new controlling commands. One
thing that was noticeably missing was the ability to create multiple
transactions in a single git-update-ref invocation.

As Peff rightly pointed out a few months back, we're actually almost
there to have that. So I took a look today and finally decided to
implement it while I was busy implementing another series. And in fact,
it really didn't require a lof of changes.

So with this small series, it's now possible to start new transaction
after the current transaction has either been committed or aborted. E.g.
sessions like the following are now possible:

    > start
    start: ok
    > create refs/heads/test $A
    > commit
    commit: ok
    > start
    start: ok
    > update refs/heads/test $B $A
    > commit
    commit: ok
    > start
    start: ok
    > update refs/heads/test $A $B
    > abort
    abort: ok
    > start
    start: ok
    > delete refs/heads/test $B
    > commit
    commit: ok

I've also updated the performance test in p1400 to use this new
mechanism, which is a much more direct way to test what we want to test
in there compared to using not-atomic pushes.

Patrick

Patrick Steinhardt (2):
  update-ref: Allow creation of multiple transactions
  p1400: Use `git-update-ref --stdin` to test multiple transactions

 Documentation/git-update-ref.txt |  3 +-
 builtin/update-ref.c             | 13 ++++++++-
 t/perf/p1400-update-ref.sh       | 20 +++++--------
 t/t1400-update-ref.sh            | 50 ++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 15 deletions(-)

--=20
2.29.2


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+iwUcACgkQVbJhu7ck
PpRv0A//RyY7UU//PUC7zKj4sdWN1JL7snkfFg2vLiOMOmCXFJ06B7AqWj8AXmWi
s27JKRSg0tKVpbeje4jzDXf64VYdm9pRbI3qAqKUBu+JiuyFsv0cH3V3p61ng/ps
jX0dmoSzNTtvaJCVGeVPmAhiAjwfAwrpnUn2SLIuk+eMIQ1dT65z76LtrRoKQNVh
cRFR7sNLkKc5epnnpWOJE5cZgyUnbpQWDalCGJ6TD3G7huDQZAh0nWDyBl3GsHis
E3YgUH6rtECJjmGJhAVXPAnJB8nLB6tENPItKw40YmcxNabnUdfrugSu2A9rypPJ
homXFsbO2aIi+WJ4CKh4VKo35n2gbemL5IVhYiJuobF1iYcFX2P/lplyayNpkkHw
lwqlu0u1rVxBYgImzAFsdt9sZkmish8Zy28nyFYxSRuY53g4qgro25YnugH7gTBR
4ixwS5dREQEtnoaOQD9x37jL/KtWVDQ9QiLdHbBeqlmSvIWj0AxQIATM5IFstquw
SboW4ZdtJfKtnBe5ugBUwzFN/Mc+AalbMw8G5fEmsXR4A3GhG/k9jEiusVnojM2U
FU+DrX4tNk9ZtR2BVYd0q5G4jQMvyKXdXpSzJVEStYd5RY2+O1olLnJPJ8t0oXcs
2ncDo+tllw5LiLpijL/zfTG2tfgzhhdASoPAF2iFqsjoTu5MZf8=
=F21q
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
