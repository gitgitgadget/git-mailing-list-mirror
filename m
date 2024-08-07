Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6525622
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008234; cv=none; b=KaFzf94qyQnP6MlvH800MU3MmXUnxnCdCimuKTjXtNcdq7jDU25Hh5GnS33umLL0WXtaF5i3VUn4zudQGwWQj4WYlFN8fMG4+dHFOmUCZnSPDPP5chKfyTQ3s0Sv8rzGTmnGtym8/ikMQPC/b/ISO7N/LeEn105LkpvNsbmp1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008234; c=relaxed/simple;
	bh=q1cZeGJKqrqrbcr1R8wUc+xbInssrV6QCgnixqOfTfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVy0GyqRwWFZgwO83icHByvLqcsOARGvREKUMRkrHN3tzVIqCdqYNt/3MZ45rO9A17QW1NDNo/dLtJ7kZv3r/O8iKTwvo8Ma4/bQfRz5ZdGzx3hNbAebpduzndyEFndDVTG1fLTy4YYbktYcoCn96RdKZRLZZEQReS3e5SKJ+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QwiJHbD7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0GNBFmS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QwiJHbD7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0GNBFmS"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 56ABD138FCF1;
	Wed,  7 Aug 2024 01:23:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 01:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723008229; x=1723094629; bh=sUuVqTIEd9
	ZORTxwsQCw55UHD4xvyo9VCFQBCtOXWLs=; b=QwiJHbD7wlrIFJdPt4nFvHM/sg
	Ml+S0Z+QhloHbReohH4wn5PISG5aOn9p9gCLUuHTES8HiunEYu5H6B1GiDCsU6c2
	+CMzrbKWzcnO2f9BfYzZbDPYCx3/LUZch2kT7BuQBQIGMatLUvWxsM+GXib/Ji9L
	49Z/uFriNzQPeayrbn2168r+8gDZZSUbkoH8mJdxCtMdINnNDBLMI1//jU171eI7
	Yi+2obdzNkJHXY//dG1s7jn8N6RmTKdfst84iqGxwZbtobR23lFfviXgOpTG5+cS
	BSqdMk468VPI3OLF0js7p3/0NhA6lUIbyh1dW4hvpwfuYlw/4lZxi1OOYbfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723008229; x=1723094629; bh=sUuVqTIEd9ZORTxwsQCw55UHD4xv
	yo9VCFQBCtOXWLs=; b=T0GNBFmSyLRAS6QaGKaDdhEEflFMye2dJcIAmA5IPajm
	x5snNAtwl/ubFE00cw+8+YZ9fBrNaEtfzNjtV8sq2rZfK6+BXGeSKi/R3yq82Ojc
	BMJfFC25anB1rvCMiJ4THbsu+GBWgQXpWEItrqO7g5i9h1YaRwHAkJ9/j32B2AcT
	5znjgKXU/XoxUpmr2yjunbvmpSiOF8g2hzK1pmlj/Qk5CAXvxQjGyBDFON3UmE4O
	1MvgxiQnoWmipt5qV9y5HK1T9tgOIxiyWSL4G830uMo9dK9YI4O0NlmoRGC6XPbA
	GQk1zfuogm/v7/Sc1B7LLi5tk8J8gICTt7RZh02WBg==
X-ME-Sender: <xms:5QSzZv3vGmWydk-akifQ-uzb-sSgz51fNyh4nPNzdHtO9qn3pmMiMQ>
    <xme:5QSzZuGYRytmJW4GR8AdG6Zq8yGoKp6S5nHVf1_Mmiaj-NgC4kU-btpHV3txgRlbp
    G14ZfiRWnARfi-XCw>
X-ME-Received: <xmr:5QSzZv6VosXJBslnyrFPMwz7V3YpXxZs5zxbzMJcEzqmiDjliBUhNGYb2mpQ8Py-JmevS9zMWf-j4IaDYv52W6vBja1IseSS2MAVz_YglvNLZ7iC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:5QSzZk19BwhYROMEVDsXBoGD9kPmoA7AoVYhPqa4CgZAv8cQSNpPzw>
    <xmx:5QSzZiFMA6vcCL0XyfPBdd7QMD-b9CFW6AkhirhgPqipehbR1_ujew>
    <xmx:5QSzZl-sHxSMDxyd_e56_CHiesjAd8FubFgHiPqBQQUFfFpaTRT1dQ>
    <xmx:5QSzZvlPi8KHyy9jeIeEtMf-Q4DFqeqt24fRJoXBwEPLTyE8FBZLTw>
    <xmx:5QSzZuCehxRcMA-eQc4WD4rMUXG7HOIqlwzxECj7mZdy17Td4HvYe1n1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:23:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b7c3deb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:23:44 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:23:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/6] t: harmonize t-reftable-stack.c with coding
 guidelines
Message-ID: <ZrME4jcdSmK3rUTh@tanuki>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240806142020.4615-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OX8sFi+9Kftk3DRJ"
Content-Disposition: inline
In-Reply-To: <20240806142020.4615-3-chandrapratap3519@gmail.com>


--OX8sFi+9Kftk3DRJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 07:43:38PM +0530, Chandra Pratap wrote:
> @@ -433,18 +431,18 @@ static void t_reftable_stack_add(void)
>  	};
>  	struct reftable_stack *st = NULL;
>  	char *dir = get_tmp_dir(__LINE__);
> -	struct reftable_ref_record refs[2] = { { NULL } };
> -	struct reftable_log_record logs[2] = { { NULL } };
> +	struct reftable_ref_record refs[2] = { { 0 } };
> +	struct reftable_log_record logs[2] = { { 0 } };

These should simply be `{ 0 }`, here and in a few other places further
down.

Patrick

--OX8sFi+9Kftk3DRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazBOEACgkQVbJhu7ck
PpS/4RAApT3SjSRnNfTEpUrLPMuWnI81UhzgeFsF9ONqi6DN83Jlh9SMTCuuIleU
puFtVplvZrnFGbGcS+Dd99jhZTMb1Ywfy8lgblvkYMhXxO0Tp5xHk+XkIQK9tL+1
HqSBUvVe1o8ImLYCrasPIuiCGBK5M/lNG+CBnu6Czsv1kg8gZQLLkKAKTmiOOHFl
r3+Fs/ltEpGY6Wzt/88L7s0MU1cO4nP+ZoB8gKu47QOFtVrq7JxHOnJogRGlhMpx
FT+BGPRO+ZbCOdvSRg5G763g5NdqRWsu7Qwtwf7dtgdkmH0XsMAcwEE4bhpdsZNm
J5NPBTKNqA2fk4caZktKwgsJO9XAqZs4IPNS1TVRlkVwIBmmesvu2UpEM1XA0i4L
yfGW6j3piY2g8myNEccuTauIgzPvPv8CKMOMrEfHRd1C9l2dkQ0UMWC1RYCIRbKy
mv/JFVb96QjQ5MAoA8WUteBj4sTP3KyIknfTKQ76BLw3obONDUMcGTWXYG1wptQ8
0yH9DBqONJIraGquMtrUumAAlG/TCsbMIRfpRGo3XaNboRa7x56jUF5Gh+/8HoNw
xmntXPdkEqN5sHKjQY43htGEW9QCaVZNaBiyCOV05hE6L9tAehn4cpX4jqXTccqH
MxPqsYrq4Bil+pBIuH94A/J3Zo0wMZ9zPzc0Re6P2ZOnZqzxhgk=
=ky5B
-----END PGP SIGNATURE-----

--OX8sFi+9Kftk3DRJ--
