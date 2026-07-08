Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AABB42F6EA
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509346; cv=none; b=i9BxYMH+VcmITKapvQQrAsLUe4dQ0UUWbmS/RjN4IfvOnXt7HXjgr0lVweYzKlXppQkOMmAj/thoJoNL81Tz8qyxY/UZ+Q/fwJPdS4E7WO3Zn/0Vup3uSybR5PHuOyz29G3EB+G9EcMDWQQQzvbCXvcIHMfFbWrPosB3ma1QaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509346; c=relaxed/simple;
	bh=Es/y5/nDni9Zc8F/+Wv/K/OMqVuVRW6SB5PLgtdaRZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iggz202Qx+d1KRI391UCPYtzvkjPt9y2T/v0hlXB36+sN9NiSNQmLXnSr8I7Lj2lpWeM4GD4uqf0qL99hfwl84o+AOo4El2MuJgP6fkkhZLOERO8i9qg0/RWKmSX1PHhLaEtPyc02IxhFcwcx8vb90nLxrZkMUZmbm8oLm2pWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jOPSZXRC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jOPSZXRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783509343;
	bh=Es/y5/nDni9Zc8F/+Wv/K/OMqVuVRW6SB5PLgtdaRZo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jOPSZXRCiwj3eXGU+opbaE8g4wLJo7dcphCbpP9t2yKi3m89wvQOz1tZYMl97jazi
	 RIAPl0llv7V1dAX5MFxASIoERGSPHASz8fpEXJOSCAzBqMGh4y4RnCQZZsL60+nzkj
	 oeaVJcG/j9Btf5ovSiwcrmbLY6kO/TDu8Gr784iXtchRfWE7ROEb2rcDCnbyX5VvvX
	 AvqMtRvP3fs14xdMtr/UB9ExMONdTJkdRjkGH2c+HYHlofwOcQJT6Ku8tzLXieGM+t
	 gz6QkTK7RLYPRj9dmSJNxu5EVhNFCwo5Q4G5RfiXDdU8d/AAV+v9taCOnsqRT1HoGR
	 K1gNfLfavvmVd+P2B2DvqTaboWibK5/AygyBZLA16xKWlVGmLSo0L31G3C92Krth5U
	 593UP0RFQN/aFM9RdYwk/t8Fl7+05tvXYqBRIz2uhW3b4VnNNbY86LB4i1ksGtS+aG
	 WxKjy4314DhDzHlBDnMZmekcOYLAmBRPkTUpf1vewwHoNVbvSZ7
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9470:51ef:86dd:bc22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2FF51200BD;
	Wed,  8 Jul 2026 11:15:43 +0000 (UTC)
Date: Wed, 8 Jul 2026 11:15:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 0/2] reftable: fix quadratic behavior when re-creating
 deleted refs
Message-ID: <ak4xXTHJwhNzfDLF@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybQD+4w8kOWIwEtx"
Content-Disposition: inline
In-Reply-To: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

--ybQD+4w8kOWIwEtx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-06 at 13:35:54, Kristofer Karlsson via GitGitGadget wrote:
> This series fixes quadratic behavior in update-ref when many refs are
> deleted (tombstoned) and then new refs are created with the reftable
> backend.

[=E2=80=A6]

> The first patch adds tests for tombstone scenarios: a perf test (p1401)
> exercising two patterns with 8000 refs, and a correctness test (t0610)
> verifying that deleted-then-recreated refs are visible.
>=20
> The second patch is the pure optimization. Both p1401 tests go from ~14s =
to
> ~0.2s with the fix.
>=20
> Note that auto-compaction typically merges tombstones before they accumul=
ate
> to this degree, so the quadratic behavior may not show up in every workfl=
ow.
> But the fix ensures correct time complexity regardless of compaction stat=
e,
> and the change is fairly contained.

I had hit this before when doing some benchmarks for using reftable at
$DAYJOB.  We had discussed it on the list and decided that it was
synthetic at the time, but I'm glad to see that this is being fixed now.

I don't have comments on the patches themselves because I haven't spent
enough time in the reftable code to be familiar with it, but I do
definitely appreciate the performance improvement.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ybQD+4w8kOWIwEtx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpOMV0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9z+oWfGq8NV1lFpeVK7EgVo641X9J1wrj1ytcaBd7a0
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAB5MAQD32BnRk4fh1J0qgEZOCSat2wEN
tNC/MiL8FCjRvtTJZQD+OtGk0tW4OIwMzNE5KSCEU6tbQt+jPCaC597EdAkywAM=
=PL3J
-----END PGP SIGNATURE-----

--ybQD+4w8kOWIwEtx--
