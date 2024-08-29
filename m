Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E8EAD5
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964105; cv=none; b=r0DF12znOTJr2tLxCKhFweumIcZZS07CCNT/ctK0s85NkmWCWlvU5mrmWNeyuCR4GUoZnN72OdXjL5+9KlmD7iU+H8TYaNKzLN5AIcjLbkz4GFGuxETfAtNHH2Q5lDzFI6H72K1pdG58dUSZGvdr4RykqMobK50izrcvPWdqC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964105; c=relaxed/simple;
	bh=A9ftYNZ2uBdiGx8NC8l+zKcyLbP1qJZJHuKAK33kL70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxCdu4k8mwyXhNNS3X/99OILzmowzitBl/YqpSHFUBtkBT21j8ZM1uySNXr2YlzjuloLEyYVxKUjevxX/hND0ucB77Uejx/XyYzosHiuc1JK/+0IifznKWpIR7rvZNERgeLo92XcBWQiyzsutWFnBye4tofeRmDS5g0qtyhovVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=ZBGxTw/Q; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="ZBGxTw/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1724963657; bh=A9ftYNZ2uBdiGx8NC8l+zKcyLbP1qJZJHuKAK33kL70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBGxTw/QpNkOwECdWfs/0vAhvMsLIJLQSFdMXCFJgsYPvDvxXTXJcNx0OlY01+Eex
	 ba2LiS/szQPeH61vAH4cdRh0OSZGJgmEl3VH3XuiyLN/gvuYzNtjmn7j14/03DFr30
	 13/IWGfO90UwREb2ptNjiA8JL/8U0AZX9QiCDC28=
X-Question: 42
Date: Thu, 29 Aug 2024 16:34:17 -0400
From: Joey Hess <id@joeyh.name>
To: phillip.wood@dunelm.org.uk
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"David C. Rankin" <drankinatty@gmail.com>, git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
Message-ID: <ZtDbSRU68lgkjPw7@kitenet.net>
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g>
 <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz>
 <xmqqr0cl6lxl.fsf@gitster.g>
 <20240625183411.GW19642@kitsune.suse.cz>
 <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BHPKoHutNcwzBOAa"
Content-Disposition: inline
In-Reply-To: <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>


--BHPKoHutNcwzBOAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Phillip Wood wrote:
> That is indeed unexpected. I set up git-daemon on my laptop this morning =
and
> in order to get it to work one has to add "."  as well as the repository
> paths one wants to serve to the list of safe directories. Clearly that is
> undesirable and does not really feel any safer that using
> "safe.directory=3D*".

Having also now run into this new landmine, I don't
see how safe.directory adds any security to git-daemon at all.

git-daemon is already told which directory contains the repositories
to export, and they have to have git-daemon-export-ok in them as well.
So the user has already specified what repositories it is safe for
git-daemon to use.

> What is happening is that git-daemon checks that the
> repository path is listed as safe and then changes into that directory and
> forks
>=20
> 	git upload-pack --strict .

git-daemon might as well run children with safe.directory=3D* itself.

--=20
see shy jo

--BHPKoHutNcwzBOAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmbQ20kACgkQ2xLbD/Bf
jzjoBw/9GfBvqDL1NtfeuyIPFXe0aiCTlU3DSUfdW/eneBBtdD2iMbIyQIHougss
1pAEIBz3YzCkCNH29+Fx102tpsbbWuMW/MFsOa76ZPdnwVKBzbBVsYaPrL3y8T7T
Idg989JubQ3+0hnvlKWhqrOM19XAGAOayXFEEq7qvyOtNclwt8XzuOKPrh9JEHdr
MW77MoSIorlsaviMx+7hCuppI9Up9FJz27E9IBsKk2wQz/m5Vvwtg7kJRRnDRWhV
CxqLUb2fFz9RKyp0lxQ/Cvubkp3nzNJqw7Shwneh2pA/eH+nKJK9M6iNwL1n/hv+
ymzR6S4q7+4lWIotXgZl9MumFZzTLC3RBnLlwSsCGWHxE/WaXHnyByd658RZ+UgH
c/PR7t9RoDOuUxxgYxy4aSSacxmAI/kcrnu1KEFsYE+oE6oDHp68At/r2QRg0EBE
2i9HNjYQYPX9ZuPuHITLlHdwBnlL+Q9fjrgOpTuZcOYqtgxKjdI9mIDkXn5Gptkz
Ma3ntHS96IShicRa7E5an2RUsurBCAwbZNXwotENtGoAh3w13lpGkF5aW4ij/+os
DHig7g84btHFF4dPx7m4p0ojDfz6Ln4pe+WL5HP6BgIg71jlEFMRmydU6qYx8sGa
J8t1aBC0RoI0R6qiBNhwK0EAxSgblpMbawgL2gD/KPMZQBpfmSg=
=GAJw
-----END PGP SIGNATURE-----

--BHPKoHutNcwzBOAa--
