Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5146D515
	for <git@vger.kernel.org>; Tue, 28 May 2024 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716863132; cv=none; b=M5I0hTSDKFTqkSqKZwRHzcb2OhSlo1+8KG7NQ4RfLjAK659kUiGqUOPrtLdIZqXKcMbX05QCe2VCvfjgKssKOBV7JL8gQoyFgRdX1a9nks0KRvbn0BSsOQocWhn3TCbGAW/rJaI/xJoZen3FvQ4NpRUK9w7AlRBAptmOr3x8fx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716863132; c=relaxed/simple;
	bh=laY53IDktKl89S+BO0xb9+WXIWniljWf0Qsab1+VQUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad7MQg3BX4HJ8xYXdr1u5S0CA5MEyyY0EG6ZQkdnevml0hF8Aw2TEB1JfQFGr9DykreOZLwbsx4aOXNGNSaGuDSde08vywgu7MCxs6BS60o24+N4ZQZEslE2gqDP0Zr0WQAs1n537NZRwYcTK7tLjbF4TPVX8d7zmicMAZL36FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=TkrPYIj8; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="TkrPYIj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1716863126; bh=laY53IDktKl89S+BO0xb9+WXIWniljWf0Qsab1+VQUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkrPYIj8sIWjL90ysaBhxVn9XqaeorIrO3fGBdKwy1FAVvYf7jsR0G96oNTibVYiY
	 gZgtRbQgyHKaNLun3gIifR78XI+sMmrNBR/2FPiWDeobTvfbU64odxvdHM1G7/3SBu
	 R73JcbbCtRi25vDZSXEqdtmlyugqO26h0B4vgTgU=
X-Question: 42
Date: Mon, 27 May 2024 22:25:26 -0400
From: Joey Hess <id@joeyh.name>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
Message-ID: <ZlVAlr8GjN1-YRCK@kitenet.net>
References: <20240521195659.870714-1-gitster@pobox.com>
 <Zk3ChIHr5amGh8Mt@kitenet.net>
 <xmqqv835xekc.fsf@gitster.g>
 <Zk9vafYPijqyWpXv@kitenet.net>
 <99225123-70f0-3546-a6fa-b6d1f981b41d@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L77IqjNnIBBGBbj+"
Content-Disposition: inline
In-Reply-To: <99225123-70f0-3546-a6fa-b6d1f981b41d@gmx.de>


--L77IqjNnIBBGBbj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> And there is a good reason _not_ to write stuff inside the `.git/`
> directory unless you happen to be, well, Git itself: Git makes no
> guarantees whatsoever that you can write into that directory whatever you
> want. A future Git version might even write a file `.git/annex`, breaking
> `git-annex`' assumptions, and that'd be totally within the guarantees Git
> makes.

Well git-annex is hardly the only program to decide to carve out
part of .git/ for its own use. For example, git-lfs uses .git/lfs/
rather similarly.

Anyway, I hope I can ask nicely and not have tne git developers choose
to use .git/annex/ for something. Since it would cause a large amount of
pain to a large number of users, who would all have to rebase histories
of (often massive) git repos to update symlinks pointing there.

> No, the vulnerability that triggered this defense-in-depth was not
> CVE-2024-32021, but instead CVE-2024-32002, a critical security issue.

Ahh, thanks, I understand the concerns a little bit better now.

--=20
see shy jo

--L77IqjNnIBBGBbj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmZVQJQACgkQ2xLbD/Bf
jzgqxA//a/x9ymNMywF+Brmw9UWRs6TT45HVxc+LatCmLjdsXro9ICIzJBpG0rx6
kaTneWe2Vi3eObH17axzhXSpVJT42p+PZjD1iVc1+4xAHe0DPfRD/NPvBHjA+9sD
VW8oj6WbhTNSJjBjrejqndNek7jCIH0minaVcP3rN++iKHOH7LzefLoLm4zJonaQ
KSRnupgVGcjMalbpHzc4fsB0ZI8uR2D8G2b1nGSX2Gxyl3ql6MqARo12ytnP7eDQ
KTD+ZcsckuP+jzr/5wQsUNWrU7Kdjh03LLrC8l7o5OQuf9h2YZW4oCpWrp2TDOHO
XgQHK51aty7uDpIQRzmb1mT6F9OOsrq7txLerZAvvyT9FPb5kruSXTFLhVkZ/+qM
g1wr5HpvAV19+j5CJhNKdixlneABACRQKfJAX4t/L/BqUx7NN4a/7e+YVBii6inT
RkuKMwFZ828jv9lQjscoLoxA05wDHgHs29kKOEdiJ4K0xhGwEesF7lNfQnK0eyV+
MD2kB+sa8DWFDFdvaB8FP7lBEvOFzfj9obGRL4M3t7FjOv1IjZQg89cQotL3KDSf
wVjxBUPPWcp4F/UV55PM+xyqH2unNAsYkBsdUWxLbUUI79gjcmCW0Y2zvxPimyzK
Zoh8BMmvvLseZYkXNHtOT2yzuKO2k4nwKUS/GZwDpdK+Mgg2OUw=
=pSx7
-----END PGP SIGNATURE-----

--L77IqjNnIBBGBbj+--
