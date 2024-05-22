Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026880035
	for <git@vger.kernel.org>; Wed, 22 May 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373937; cv=none; b=Y3A5j3g3NrnObEb9tOZl2CycvCbgSEqHbdmJEg+okCXeCG4ZkEyttdpiaBok4DO0HiPAKb/CB0eHFadb0kIVrFi0B12wQMQO3fQBgfrWTyGkqI/fO4kl0k6tD1olfdTNM3tR6uIixxZQ60hB1lwYbqEcxEdgN8sHk9wLZopCPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373937; c=relaxed/simple;
	bh=zMhpcP5OMT/maeoayIHxP+gf6qo9get9ZyteNdpx0Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7uJVYFbbypSBdLeq3bdWTko/cla7U37rSetF/uWV3LQQgcJrv+Us8qxQE4KhnaWniAXVGNguwftRwylcAdbzues7Agd7IIq42Uv1zi581pRWqTAtcOcANecIwhGZ1y6NqZQPrv5EWIA0Q/Qm9nMtcqfNNZAzKN8Lwkm+xyXhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=EbJVbaaG; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="EbJVbaaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1716372100; bh=zMhpcP5OMT/maeoayIHxP+gf6qo9get9ZyteNdpx0Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbJVbaaG5s9GPDya/U+MRxkeKbJ+yyse1Ez+Y3uFwZHkc5lEqW4rvlEo8Q9iMzLsW
	 lTsFxI6Olk4eRfJRAjpwyb/guQnzfY45j/f13nHTkfzFIi2NmR8+bKfJl3BBDlIQpK
	 2N7NvClho0mG01rnaVdZlBblU4F3nwriOANI6omM=
X-Question: 42
Date: Wed, 22 May 2024 06:01:40 -0400
From: Joey Hess <id@joeyh.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
Message-ID: <Zk3ChIHr5amGh8Mt@kitenet.net>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5aN+OyWF3YpfpKSl"
Content-Disposition: inline
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>


--5aN+OyWF3YpfpKSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> As people have seen, the latest "security fix" release turned out to
> be a mixed bag of good vulnerability fixes with a bit over-eager
> "layered defence" that broke real uses cases like git-lfs.

"fsck: warn about symlink pointing inside a gitdir"
(a33fea0886cfa016d313d2bd66bdd08615bffbc9) also broke pushing git-annex
repositories to eg Gitlab and has several other problems including dodgy
PATH_MAX checks that cause new OS interoperability problems. (I posted
details to an earlier thread but have now found this current one, oops.)

Please also revert it, or at least the portions for=20
and symlinkPointsToGitDir and symlinkTargetLength. The
checks for symlinkTargetBlob and symlinkTargetMissing seem worth
keeping.

> Let's quickly get them in working order back first, with the vision that
> we will then rebuild layered defence more carefully in the open on
> top as necessary.

Exellent plan.

--=20
see shy jo

--5aN+OyWF3YpfpKSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmZNwoEACgkQ2xLbD/Bf
jzjEjQ//TXYRP/HzxcIpCqkxIVP8qe0QAn5Wn8rcBYIa+MJ6gjdNXqQPSn1H3iC9
1KPMtGgDKVnorC8nlEYh5uRwpLOh6G/FYq7evCaxOQegiZkfPxJJGlUbCCtCsL+l
hqdP+v/HLVlsj1X+Tngjcge1wgVpf18n6CTb5+Qk+kH7xdggQnU4oz1QiUAMUxqx
uBXr1TcUVq1DuKiYss8ibrNTLK0YN6LOTQBKcjtBo8/5iCn70Q2muxYhUf+TBeb9
qKYXEXwrzS/u9kKvipnYRhC1ih1QBojIOdxRMkujAdOuWnK9ZhdQPssXbLT/OelY
NAFZDIG9iZYl/BaH0LIrxxeUAaLmcL94DX9elE6uKcMnODKvtj945AW/R/iten5U
PgUwjp+WG80/CQyXVG3K2d5q+cEIiCueiOxS4sFOYYd85i2gH/srhkXF068o26Vb
gQgbJok7V0EtZlcpRgwJIWfSXa+gARQhALZWWOQ+n17FtSOQfWrr1o0whuZMoAch
Vq954tx4+IzTmty2dbtsIwS9sMSb5Mo6whP1iKuiM8deF4Eu6+xOqy9gFMVQamBT
BCmn55sUQNiTV9dJYWyGclv55AkpQXnFSWjFzH5/X42dSgZPniVmLXo1weG2jpn7
tO2UhByroEtXeo6uJxzEGcv1FCgYq1S+7w4V+4tSpySZ3ofuamg=
=wlNl
-----END PGP SIGNATURE-----

--5aN+OyWF3YpfpKSl--
