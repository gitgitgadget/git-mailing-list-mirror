Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2C25611
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585316; cv=none; b=DDBAqePAmTG23ZqCrW3dvkOPQcDxuvyAssmPiHbzG2tEslDinRbzQBGoxttcJRK29rcmpomJo6j5xrbZrJ1Ku+rUHtsMzIbq86er+1joXeef/SyZzPCsseHRLrOj6pIpzCgFjhwtt3NsbLMaqHG/POp/kMv+ibwSYMgccYopIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585316; c=relaxed/simple;
	bh=vPej4AZ5USo0T6dCPx5yUMtSDMQY2IEnG9sh6MLiwdA=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP5uw52s9DW8srpbSkuQ5Ydvg/K32C7MFLvjSD6d0f9IusSoqkD9MHU5ICwM8lUbrxjPnPCekTCijxUfrO34RgsFREcpZkUu1r32MEusJl4M5vC6t3kJuLQaLONhIh+LGosIB25hNP9ygqldMGSic29tKtVl3B+gvEnaT0xL6/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gGD05LeD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNJaj/Qk; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gGD05LeD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNJaj/Qk"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2ECCD3200B51
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 08:41:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Jan 2024 08:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705585313; x=1705671713; bh=LrHNTzQZid
	OJCJ3w2c8gA98Br1k5ijy4MEdDyS2icHQ=; b=gGD05LeDYRTdakshYNVRMbgqCi
	51z/J4EJ4Ad4d/R8TwhbrYc5Mu8bze23wh1KTJq+0dOr5F8kst2okbpfKEWXJKrv
	vorLGJ3IttH7uQ/1oJMeWGb5dK9ash2w7DZQPgwW9njG6NRh5VRKLMK6eAD4JK9Q
	ymx9CeFgHyFC1HVAhfbP2sK6bjon0qXBb8oZFEqERoeO/ped9DFRMi1A/29+8fdF
	uJ2mGJTf4bqUYakieEiozEh0AI3sWFcYfdG2fvZzdTRnzzTPVAcRpvKf2cCFw9Ij
	J1x/aONGA6YBXOPuJI8zeqIbPMswJ6xbDvBiUASqpYGMZLZhpdDn3/56NhZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705585313; x=1705671713; bh=LrHNTzQZidOJCJ3w2c8gA98Br1k5
	ijy4MEdDyS2icHQ=; b=gNJaj/Qkd+tx4XeusE8JTVCEZ5CDb1ztWYwcGCMXuqdp
	Q9OkP7TWl/uk5TOp2g+GAr8GQjffi/SM5biRz0LmRSaop003N4iOmIhbKFubPmWQ
	FazaKbWcIgnDzB8dVdyenNt+9RFTWCFNS8/3dY1KBTIBb8ptT7Evnq10sMuiivMf
	HxncTf1YBlI2gCwUiJkHzXfmNxFkzdWSUVITj4AQYT0RZav4DFeRwQhh6n3JYPob
	2tXejtLRoIwx6xCi5iV9XndGOJIT72Sm12Ug8t9PabZn5FwEpXzG+jaUF0DqVjyn
	l4WMG1bKgpafY5putkFbQZmOhJB0O335rSN/xGKj8A==
X-ME-Sender: <xms:oSqpZb0Qkf6Dyw7swN5NdBzUz9jbifQx2SJMMC9ig5S1eiq-hQmljA>
    <xme:oSqpZaEKAFWiW0zDhA8aUO-PX_Lrx6RWmydmmBmu6ie1uZqdp94F9bJK9lmnwY_U5
    tcD2gbBmT6kIlsvBQ>
X-ME-Received: <xmr:oSqpZb6EXZwIuSA2GcKb_P0h_eRWrzve-H4NjEvjeLdvtqzZWBFvEpwc9Lis-pxCoWAGFitGiaeIEnwT9N-C3F6XQFAMgG-2uTZ3dtz3t4DCnDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:oSqpZQ2lHwEuh7e_-cK4ykne4CnC1lxrKWvI8D6hdjiFUNCUAda_1Q>
    <xmx:oSqpZeG4ApNVFgIIvzHNH9vRfy3wBOeC9eeR-oWLag2_rY-68zDWHA>
    <xmx:oSqpZR96lRjZJE_5X3TDs7lTUk3ycHtOqATwNGq0HId0CYiFhKpnAg>
    <xmx:oSqpZZyQpPP5r7BKrjH_cYjVJuihOqb8Ax_XdvASCGGVyvTxK_RqvQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 18 Jan 2024 08:41:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a6aec30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 18 Jan 2024 13:38:57 +0000 (UTC)
Date: Thu, 18 Jan 2024 14:41:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/2] reftable/stack: unconditionally reload stack after commit
Message-ID: <568aa5b808013ca782fac45d03e01bbf9323bb38.1705585037.git.ps@pks.im>
References: <cover.1705585037.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ILy+iS3odFDK+G+/"
Content-Disposition: inline
In-Reply-To: <cover.1705585037.git.ps@pks.im>


--ILy+iS3odFDK+G+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After we have committed an addition to the reftable stack we call
`reftable_stack_reload()` to reload the stack and thus reflect the
changes that were just added. This function will only conditionally
reload the stack in case `stack_uptodate()` tells us that the stack
needs reloading. This check is wasteful though because we already know
that the stack needs reloading.

Call `reftable_stack_reload_maybe_reuse()` instead, which will
unconditionally reload the stack. This is merely a conceptual fix, the
code in question was not found to cause any problems in practice.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index c28d82299d..705cfb6caa 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -585,7 +585,7 @@ int reftable_addition_commit(struct reftable_addition *=
add)
 	add->new_tables =3D NULL;
 	add->new_tables_len =3D 0;
=20
-	err =3D reftable_stack_reload(add->stack);
+	err =3D reftable_stack_reload_maybe_reuse(add->stack, 1);
 	if (err)
 		goto done;
=20
--=20
2.43.GIT


--ILy+iS3odFDK+G+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWpKp4ACgkQVbJhu7ck
PpQEjA/7BGnoeqmF0HMITTSFEWWRvu2eG7vz8aTjQZT3eAR/QE3XlTTxvN1WdudE
P2OxaHGY9tiU/aNpEWgEIykNgXTKTVuSC98qDuJBwHtn9yJdZMKWp7KEsuWxkPCy
7jg1OE6CRXJAN0ZP7hoYLhNvsZe86WebLaJyKoQPtJCBb1Z/OVceaigW3jrD+kM2
9J3fK/cGCuXlGvdnygwddk2IdfKD6yBqGdKy8X4FzF5prA8W1UDw1gNsV0wU/624
fXLAAw0+n8KTpWh53GiSGHKrO4moz0wrefnU9htccKLmV5BuUipMh12hv5yEEjic
qFnl7DNZXs1WTUy9IaZs1GAoMlKfx7JviCs/83ItkmvFE3ywFfhzVAyTPO3fh3Nc
NH8uYeLt3Oee63Vndeirec/bztcK4efkR/j38cGxxl3gT7Boak7fJq2HcdajDu/Q
yKfBVrbxKQd3LZeWa7Ba7wE/a4VWhJw02E+BiFzXGyYfhmGk0Ugus223E/EfgbkW
AoLcfyrePFig5ElgtYhvQM15bRyZxc55Bt/B1hLR35cwStW6DOYdOTlk2tuJ4EQF
H/Gv4JMJdO56D5QRqC6YLVODC7ahDlffgbHNEGkB6pNV+C7VgL9hVVI3YueDMRC1
S8ripo5YRw9efDHUpwaPCI0V6wJcEaVteVOWbLIbmXGyc2eaiow=
=7uoR
-----END PGP SIGNATURE-----

--ILy+iS3odFDK+G+/--
