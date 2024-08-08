Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541213C814
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094532; cv=none; b=ml4I9igp6NB3a7xIf0tt9C6D9ner/0cvf10fY+/XhlNBhsD5fcSDAAkPdpnTuK0b5l05ndn8tBgvmKpfgaFja203yVrX7e79pt5CyG6XKR9fXCCNLhZpOSzAI31CJQyQcDrehkC663LRFQztcy16xnT0IKI+d5W5iJCYwcH0nH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094532; c=relaxed/simple;
	bh=Go3/LBH0/fFVJYNp7BzcIO58n80hGn4Vxsf1hMR6dtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn+2qAKOWZAvrZqKFAo3Fux24ZUa8F7B7jU5ZhdM99Vc3PPoq58SYgarfmbpxyQQM3bUMIZkvl+CoB00N36OGcFz8k0um7af3f2LZMHmm+4mshA20r1jtZHmD/cAsoOll2CvGO/98CIQG2F9/dLuJMRvL7J1rhe/07qXFzzAOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CzqqGkG4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TG3RRMPd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CzqqGkG4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TG3RRMPd"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 81749138FDE4;
	Thu,  8 Aug 2024 01:22:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 08 Aug 2024 01:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723094529; x=1723180929; bh=Go3/LBH0/f
	FVJYNp7BzcIO58n80hGn4Vxsf1hMR6dtg=; b=CzqqGkG4tniBxP9XHCneVdO5MO
	mIcKPV7JxdFZDbLku6c3e7EC0ewrFRH32Q6ahWb27bWhWUc2hGRGK3lqFpcLXoGH
	AZ0xUUkX3RwlICj2lu1TZHRz5JEYI7kDAVH0IurFhG7Ozgk2xvjc9031CseTvw7Y
	RlHhpZqNgd7U3YhnF6dqs7BanbvZWdXBQie/5BTSppHJmQ473zDSJkU85MR2CXb2
	0NhQ3CU/MWSWyP29nrIT6PIWCyz1S3mNeUQaMkE/kApV+wtmuIRNMMIVuE4qPgP9
	FszyLr9vZx+3qui71oigG7HWqKEJSkM3/lb4+8LrBILuu9c2qsx+KRydZvGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723094529; x=1723180929; bh=Go3/LBH0/fFVJYNp7BzcIO58n80h
	Gn4Vxsf1hMR6dtg=; b=TG3RRMPdo5HWeR+vJSvO6f9bw48U5Liy7ysMUY/dy+3i
	mAXc9U7k2/CGMiMbFeJFE8qXLh0xB2bA0B+awO4fRt7TKQTsx4MSGeLV5AQqu1dk
	zMguKeSffTaMWAv79GlHQNTpdlYmxtoZVovn0GV5I1w9zOrPKZGP8xDTlEUrK2zC
	psmjz2fUVPWz3Sw58lyJtZf8BAexbFvWzN9GLTWBHiMfSBCnPLyX7dt4qLj9XuVP
	2bqjhzHJT2lAE4/sH76CqKpMvtGTM+qxYvVb6FK2r0Q21zkupY9oGFIS+6CPRWrb
	LHtA0/sDCiMguYnrUg2IT0gdr4ljq3t20jqG1D10EA==
X-ME-Sender: <xms:AVa0Ztwlx_-WQw5nDNiBILoy18gAicjUx_H9zII39Mpz3WfmCz3lbQ>
    <xme:AVa0ZtTilMrmmaetFKRKiN0I68ii5oZmZ9xKEqZ36V1oms18BSSWg72qSlaRv-OWF
    qIjhXBSCP7jGapQlw>
X-ME-Received: <xmr:AVa0ZnVk_-9cpsWBBtWWLyTu6VvjSq3plsQHgOyMx2Mte1s3XY2J6qNxHfJ7kCuzH2ouk0wLAKBk7ZvRfX3ZuBnCHPPvwLv3KRNy2OaytcBbuEYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffve
    eljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:AVa0ZvhPvvp5zriK0yUVW1orWeAT6VKH9pd8Sk20xLkuLAgWIP7xbA>
    <xmx:AVa0ZvCgxMP-x0tiF8-0F-SJ30MBde7qe2N3RlTVv7rgzXmk-9735Q>
    <xmx:AVa0ZoLCdgEQUhcJXSoExF2ASsRrx6MifveHNHXVFfqUeebGcqangA>
    <xmx:AVa0ZuAux9CVooq1CTQVGqBm86mMqym0J7QlCXWdFXNP1yzLO0Oa5g>
    <xmx:AVa0ZiPcyGvW9YJ2LgMMYldMLALc0T1VkxToqSSASDI4WUFWj79Mkf9k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:22:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 43ceab23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:22:00 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:22:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] transport: fix leak with transport helper URLs
Message-ID: <ZrRV_HrUArsvRgn8@tanuki>
References: <xmqq34nfn7ip.fsf@gitster.g>
 <ZrRPD0ggZapZym7E@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z6OvB9iCXR1Top00"
Content-Disposition: inline
In-Reply-To: <ZrRPD0ggZapZym7E@tanuki>


--Z6OvB9iCXR1Top00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 06:52:31AM +0200, Patrick Steinhardt wrote:
> On Wed, Aug 07, 2024 at 06:11:10PM -0700, Junio C Hamano wrote:
> > Transport URLs can be prefixed with "foo::", which would tell us that
> > the transport uses a remote helper called "foo". We extract the helper
> > name by `xstrndup()`ing the prefix before the double-colons, but never
> > free that string.
> >=20
> > Fix this leak by assigning the result to a separate local variable that
> > we can then free upon returning.
> >=20
> > Helped-by: Patrick Steinhardt <ps@pks.im>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> I saw that you've merged this to `next` already, but: this looks good to
> me, thanks!
>=20
> Patrick

I just noticed that this also makes a couple of test suites pass with
leak checking enabled. So below diff should likely be applied on top.

Patrick

diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespac=
es.sh
index 31553b48df..05090feaf9 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -4,6 +4,7 @@ test_description=3D'fetch/push involving ref namespaces'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh

 test_expect_success setup '
diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
index c6c2661878..dd3e6235cd 100755
--- a/t/t5802-connect-helper.sh
+++ b/t/t5802-connect-helper.sh
@@ -1,6 +1,8 @@
 #!/bin/sh

 test_description=3D'ext::cmd remote "connect" helper'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh

 test_expect_success setup '
diff --git a/t/t5814-proto-disable-ext.sh b/t/t5814-proto-disable-ext.sh
index 9d6f7dfa2c..6fe1a98b2a 100755
--- a/t/t5814-proto-disable-ext.sh
+++ b/t/t5814-proto-disable-ext.sh
@@ -1,6 +1,8 @@
 #!/bin/sh

 test_description=3D'test disabling of remote-helper paths in clone/fetch'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"

diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index 4d5956cc18..fe899ee82d 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -1,6 +1,8 @@
 #!/bin/sh

 test_description=3D'test protocol filtering with submodules'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-proto-disable.sh

--Z6OvB9iCXR1Top00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0VfsACgkQVbJhu7ck
PpSrIQ//U/ItD/KxSJnynU9UbDLYvx0Euyj3mR0AwF6skfnbCpciFMoeq41AyD/o
n517jIx3LDxIARhdhqjd6s0/4a8iJcB9fGWM2WGbjSWSIa40YOFxuOLw8NFbSMMU
fEv5G4WFwrFxX/vF+NWARKmgt/6DlV+Q5IbNxeKk1QfjvzwRPdoTUOPWUYSPenG/
F2FraR/fmIVapaIRUUoiSFcjzcQd/YB5BG/Su/tuN/+NtWQ2Xw1goDtf9tE54kRA
SrZd1DH6dGr9511mgE+wRG6+R77YIMI7uf7mvfuGtoumYXCuH3FYh++XvwP1zGCu
eeW2gwk4VeByNeMKuyKKDOe6rmyVzIFjmT/zJFU96f7nqOvNsTAT58G9/WZsSxMG
ttI6MXXRUowxRI8p/97kRZwI+9y+Tu8BM4lfupVkasFayY7d297Kj95zwXCDoXO8
xunK1BeycyYmKqa6cY7PIpjX+PwH7GrhEWtAqDORb3Nakd77iMo5KgRTxBKbrJ2S
k3dW3/1o9Ib5kN2Ui9lmLiRaaxpahnBIrLeE/IX78CqpnQTv2QbiDtfWJDCZmBZB
DgnGqyRtf+/9aQTMYG4AEc1JCBNGkYUzsid1p1pcSaVxFdEjsYrSMORe6giGSpOF
AuBDMrD4BtYCTmvWwTefIr+KBxDvSmLpE8RBkUEO/gOKbDmrnGQ=
=Do7y
-----END PGP SIGNATURE-----

--Z6OvB9iCXR1Top00--
