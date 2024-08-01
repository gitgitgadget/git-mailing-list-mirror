Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0F1A4885
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520219; cv=none; b=KQYxTXcaqPbnBDCIHsKp0pfiZLPZ61QfNXFrm/bhyMU2XLp2fy+thUaARs5Z5BXtBRBeGQ0es390CYurt8A4WirruINMOi5GGcox/uoFaaC0bYBRhKgakJ6MZ3k6a70A9VKokm/XWYgSG5DgE87GrlkfZZ71kkyJF8lvmyQ9yCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520219; c=relaxed/simple;
	bh=QrSf4yu4kjgQsObwueETt/T3HV1ZJJfQEE7ofeWoKXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVEow9wmpckeVI1Iq8K2jIlD3/j8LOZCppQd6wDBoLLZsUhiELm8IotkIymxNhiF/LaWfEE8XXRTSNdjjL7/8dNGZlrmFG2I+BYzXtuK58qaM1WK5ojoA2qfWJUfk2SuYZ4LF3Qe+J18s0qLXbI1G+OgMkiDlZ0J7GJH3O+ql6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NcRKNgHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elqE6pp6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NcRKNgHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elqE6pp6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id F2F0413856C5;
	Thu,  1 Aug 2024 09:50:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 09:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722520215; x=1722606615; bh=QrSf4yu4kj
	gQsObwueETt/T3HV1ZJJfQEE7ofeWoKXQ=; b=NcRKNgHpGRqZB0aokdUf6Ee38P
	DNWp4q/Q4t59+63xTRBJVZds/LDDJqa15HljCNAEOFQbylTojorShxFQY00hZXe2
	puoxdrjy32WlVMC3N/wqNaEeyzoSbDNZVdC8y8/foh0n2QJmXGJxekOnkM3LYuci
	0FC1MOA4OmqwJVx5n9Y0zhScvPLuJ9GljMUBhnjtq4c8GBwuTgTdRh4jpiwkk6pg
	KqkJalSo33IUVplArcARZxIT/QPXej1s9UiLiU6U0so0z2Kr0qbOqX0AcAbZispJ
	/h90yP4Cu0QFJwoTCM+ieeadIrDUdSl2D+FVGxzmcpFFMcJSGsSPvtu4CoMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722520215; x=1722606615; bh=QrSf4yu4kjgQsObwueETt/T3HV1Z
	JJfQEE7ofeWoKXQ=; b=elqE6pp6e6RxHfvrgQVnqZhCFoRByr+Qy6H5tULUqVFu
	+sT9cgcoaVIPCrGvxdsdPMcNthrwDjuyA64rCZwuU3DoK+wsyASxPsO4QNdrinlP
	JX5x7bJKlm3hZUZGqIhP5rkLLkPD5mXKsYVN4Ns8g00HraAca9x93mL4uF47Gy4Y
	aud6vvQMQWc6LLB9TWoaYQ9i+r0DbeUI2rjJlkOfnqSUhgwYCs3WodSCig07m5Or
	s4NzqxXZLrv1J5pYEEEWCkIa+wLUERsrGTVGfS61zOdd+eUkDkyZmS+1lkRSyc93
	BQXSo8DzG5sTYJp4hLZ5mZcL4xM6KJJR2CXeYWo/5Q==
X-ME-Sender: <xms:l5KrZj62si-X_WHdUj2t9Q58YQefdy_6zHFUFfpHfg0pJvz0bgFD4Q>
    <xme:l5KrZo5o8evFfxwFKUpHbR1iHCWpFa2JsmruAulYrgRllTpQ08GZJ1t-iC6wpDcT1
    Mf0RfYXhJ8vMe4LnA>
X-ME-Received: <xmr:l5KrZqdwAdjRtcgRW1SWEEDU2n3quPOa0wxtECOljNUn0_I_-j5A44SaMrsc6wsJMU971ctDAhBlAIaKgh95ZQGonid8KwcuakhGB9rSItJldcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:l5KrZkJtqjRJeWtdkQFec7IV9SQLskzzF608JZ0a5I6DsboGC6SFKw>
    <xmx:l5KrZnKV1bs3nRFAcuxTXK1Koz-HKA7Pr4q62SYxVmOJwQ4sOI3Nww>
    <xmx:l5KrZtypMwCOCuxAbwEU1Hm85phF6F-p1ZninoMzl8QQi4Bf8T1j5A>
    <xmx:l5KrZjKMCFIY8oZmu2hsTDBEFjEClUsL8meFmXTfMCSVOnPdxiRf9A>
    <xmx:l5KrZkoy3l2muaOIVAoufv3TO1Mi5QgOoIyTDNhg_4p6uilcNd3A5QKX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 09:50:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be6adad0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 13:48:40 +0000 (UTC)
Date: Thu, 1 Aug 2024 15:50:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Josh Steadmon' <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?J1JlbsOp?= Scharfe' <l.s.r@web.de>,
	'Junio C Hamano' <gitster@pobox.com>,
	'Kyle Lippincott' <spectral@google.com>,
	'Phillip Wood' <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework
Message-ID: <ZquSkkR_aw2IUdX2@ncase>
References: <cover.1722415748.git.ps@pks.im>
 <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im>
 <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
 <00a801dae384$de2780d0$9a768270$@nexbridge.com>
 <ZqtWDtqkXzjz2A8u@tanuki>
 <01c201dae40c$821ab5e0$865021a0$@nexbridge.com>
 <024601dae411$faab2cb0$f0018610$@nexbridge.com>
 <ZquPfiAWgYjIPGRB@tanuki>
 <025f01dae419$636bb790$2a4326b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="foCCkmv+IGY/SrXj"
Content-Disposition: inline
In-Reply-To: <025f01dae419$636bb790$2a4326b0$@nexbridge.com>


--foCCkmv+IGY/SrXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 09:47:38AM -0400, rsbecker@nexbridge.com wrote:
> On Thursday, August 1, 2024 9:37 AM, Patrick Steinhardt wrote:
> >As mentioned in another mail, we do not use its Makefile at all. Did you
> check
> >whether the version I have proposed here works when running `make test`?
>=20
> That is the commit I have been trying to use. make test in clar or git?=
=20

In Git itself. `make test` builds and runs our unit tests, and that now
also includes unit tests based on clar with this patch series. The clar
Makefile exists only because I did a 1:1 import of the upstream
dependency. We could just as well remove it altogether, including other
bits that we don't end up using.

Patrick

--foCCkmv+IGY/SrXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarkowACgkQVbJhu7ck
PpRXQRAApZ27wbYcTMlGfECNF5fRtS/KlNFXI7jeeYu4FGFoW12ugvObn14ZRzxR
DK39gBT4Dt0NQ+rdZxtWf4c6olXLZRSJ2RZ2HU/VvobUWwJaK9v2rusRzqVZ2KWy
MPOS5PGHJQbNqjciTwQN41elx4Y0CA189ro7Fdax/LOtH9gwpM6kiSjt+SC53rNp
KKuzPFCYKi8TkED/jM4M1t1cxakjOi5/pfr/AkqTwhGuo9KBcGQ8I9sZdJyapIue
eEWbPbgjsRtbEVrqirqAqUCIQmwrqmCN/A2GLoVJQ+xg27fNNYeLUNHwIVUwW56A
O95xFpsBoQgJ2eXxpJKLRktgTpnpujTKRBmF7bd54+aqxB+oWyApZNKjJn0/JkNQ
MW/k1/fs8LA/V+1Bs3mWVlCQaDKcdcSm3b4JbU6Pl21wELC5n7GGMvbToycbJkQ3
ASfuAKN+mmI8PHujwfCBG07czfvLbnP85I6j6x5os02MtQf9OKBAB6E0JpmUUrkI
fKsef/+vCg06bOt2rfWLAmu0/0zAMJPGv7Wnw5fU0vAXsLkEr6HXq0ZQFvs6KVKd
FGThP5DySgLWWHtdLk5POo2irKhptvZBKkwbpsz+QDStqIQDqI4QBxSFg2TIxgF6
rHItaXBC9K21sX+P7eYO2Xk3mC70306SKlGSdaeV2SvrTkUJtU4=
=axc3
-----END PGP SIGNATURE-----

--foCCkmv+IGY/SrXj--
