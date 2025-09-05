Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BC224F3
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034970; cv=none; b=LaOUTU0YDPTnRaQa3xFdloF6v/AjRG//88DhRPn4m1umrCGlgUHwfN6ecO5ptd5z0E9pmQ902Rxr1Wb2c7e/wg/jw8fx3ZbisWUe3gTubc/N8UTnCX1g+k/mAYVnx6TXXOaaE7yRCnUSlQfIOffydN1oXivH2gg1RjxDYT7IRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034970; c=relaxed/simple;
	bh=WpcK6EN8JAcSnzGZvrq74Sc++8g4NzB8IZHdVyPc1ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V8L+T/Im+XNmvev4zbncvsq8HY0jqi9YWShrmTAWTJ26OzvBBa9IvSqWuiciqeKURGhnj/YvU3TOVePIal/QFNk8sfz6HKPzkD6+ClZxPOTlgoX4GDBqWz56wA9I0Td+cshl8EwA2uGq2Ks9iuOfKRDH7URWlAV0W2BYp7mk+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:cf90::12ac] (unknown [IPv6:2603:6011:3f0:cf90::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B2D9E340834;
	Fri, 05 Sep 2025 01:16:06 +0000 (UTC)
Message-ID: <013a3006-d220-424d-a28d-fb273c523c71@gentoo.org>
Date: Thu, 4 Sep 2025 21:16:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
 <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bOXjysI1tU5sua3a06Do9bOD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bOXjysI1tU5sua3a06Do9bOD
Content-Type: multipart/mixed; boundary="------------0App2WmEkSUi0aTBHvphlLcf";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Message-ID: <013a3006-d220-424d-a28d-fb273c523c71@gentoo.org>
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
 <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>
In-Reply-To: <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>

--------------0App2WmEkSUi0aTBHvphlLcf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/4/25 6:06 PM, brian m. carlson wrote:

>> +if meson.version().version_compare('>=3D1.9.0')
>=20
> I think we need a different approach.  Debian 13, which was just
> released, only supports meson 1.7.0, and you have to use testing or
> unstable to get 1.9.0.  There are no versions of Ubuntu, released or
> not, that support meson 1.9.0.
>=20
> If we require this version, practically nobody is going to actually tes=
t
> this case.
>=20
> Our platform support policy implies that we should be requiring nothing=

> greater than meson 0.56.2, which is available in Debian 11 and has LTS
> support until 2026-08-31.  Ubuntu 22.04 offers 0.61.2.


Hmm. Patrick -- do you mind documenting why you decided to use this
version guard at all? Off the top of my head I'm not sure why you'd need
this.

In src/meson.build,

+libgit_rs =3D static_library('git_rs',
+  sources: [
+    'lib.rs',
+  ],
+  rust_abi: 'c',
+)



rust_abi is new in meson 1.3.0, but it's just a rename for clarity of
rust_crate_type, available since meson 0.42.0, so please use the
backwards-compatible name...


--=20
Eli Schwartz

--------------0App2WmEkSUi0aTBHvphlLcf--

--------------bOXjysI1tU5sua3a06Do9bOD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaLo50wUDAAAAAAAKCRCEp9ErcA0vVxVX
AQDq5UcXCrOGVCm3ErOWNRr3n12t8xYkCePYDtLxKr0k1wD/XdbFDAmRxHMKOlcKWW7AfIsIS8Zp
QzysPWswdzG0GAU=
=x0gv
-----END PGP SIGNATURE-----

--------------bOXjysI1tU5sua3a06Do9bOD--
