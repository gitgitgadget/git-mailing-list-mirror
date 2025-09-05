Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A8285CB2
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079552; cv=none; b=DEGpWRX/r2330Csas/pONqaMi3UrWV7TjY2s3Dw6Ufzb62tF7tMOLRIuoue2eEOlXoNWxlqv0tKAdWo9pAKUJy9TdR4zavEmshMr2vu/b33YUho28Y/Nz/ZdjEjpVri1VgVWhSira3YSLA778rjb/NUqzNIN55DAAQR2Rx6Hve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079552; c=relaxed/simple;
	bh=meZQ2IM3h6d0rNKRokblS0KRfJdrx/66muIJGWShxLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhxRttodwIjBUcsFDz1ey5YYsRRZS5jW8MwgBKkcSWaq/C5nhKWLx8CY+bd/rPapfAqMNnxBwLVyS4IjIMBw1dqU3oP3MMjmWQd6vtrEVcfSXY4TxXXzJXGrN5o5c16srl1uzYw1W/uX+whCxwfUVaN7Bj/CJcXygM+JjaHV+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:cf90::12ac] (unknown [IPv6:2603:6011:3f0:cf90::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 1704A335DEB;
	Fri, 05 Sep 2025 13:39:08 +0000 (UTC)
Message-ID: <033d35f5-6158-4402-b7f4-aaf525a3e64d@gentoo.org>
Date: Fri, 5 Sep 2025 09:39:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
 <CAH=ZcbANoa8Qjbz4OmdZatBi5b+RQVnatF+7pmffA4SQh=EFCw@mail.gmail.com>
 <85b9def3-ae1c-4535-9d56-be6f08eaa8d7@gentoo.org> <aLqXHYb2jZpCKzp7@pks.im>
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
In-Reply-To: <aLqXHYb2jZpCKzp7@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------z7hR46qu20qfJSEpER90sy98"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------z7hR46qu20qfJSEpER90sy98
Content-Type: multipart/mixed; boundary="------------g1HVV5kaMo3EYSswtZB9Gp2v";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Message-ID: <033d35f5-6158-4402-b7f4-aaf525a3e64d@gentoo.org>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
 <CAH=ZcbANoa8Qjbz4OmdZatBi5b+RQVnatF+7pmffA4SQh=EFCw@mail.gmail.com>
 <85b9def3-ae1c-4535-9d56-be6f08eaa8d7@gentoo.org> <aLqXHYb2jZpCKzp7@pks.im>
In-Reply-To: <aLqXHYb2jZpCKzp7@pks.im>

--------------g1HVV5kaMo3EYSswtZB9Gp2v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/5/25 3:54 AM, Patrick Steinhardt wrote:
> On Thu, Sep 04, 2025 at 10:00:45PM -0400, Eli Schwartz wrote:

>> If the rust code is defined as a crate, meson can auto-import that cra=
te
>> via parsing Cargo.toml, so perhaps this can simply be done by creating=
 a
>>
>> [lib]
>> crate-type =3D 'cdylib'
>>
>> and... importing it as a meson subproject. You'd be able to build it
>> with cargo build, if you really want to (and the Makefile may have to)=

>> but Meson would not be limited to this.
>=20
> That sounds like a sensible thing to do. Just to clarify, this doesn't
> need the experimental Cargo wraps, right? Is there any documentation fo=
r
> how to set this up?


Experimental cargo wraps are new since 1.3.0

https://mesonbuild.com/Release-notes-for-1-3-0.html#automatic-fallback-to=
-cmake-and-cargo-subproject
https://mesonbuild.com/Wrap-dependency-system-manual.html#cargo-wraps

It operates by synthesizing a virtual `meson.build` file for you via
translation of ordinary Cargo.toml. A copy of the synthesized file is
written out to ${build_dir}/subprojects/foobar-1-rs/ (or whatever the
subproject is named), so you can actually see what a manually written
meson.build would look like.

And e.g. tweak it a bit. (Since it's a virtual file, it always writes
`meson_version : '>=3D currentver'` to avoid ever triggering "feature new=
"
warnings, and also stubs out `rust_dependency_map : {}`, but you can
delete both.)


--=20
Eli Schwartz

--------------g1HVV5kaMo3EYSswtZB9Gp2v--

--------------z7hR46qu20qfJSEpER90sy98
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaLrn+QUDAAAAAAAKCRCEp9ErcA0vVxk+
AQDuirGPaKMZNsVLIXccYhVgabfiFiLF+67oX4zDMiLWfwEA0/V4x8HWdl8KXBewtH1g3/y5iotz
yHtlZmv5LGidgAA=
=D/sR
-----END PGP SIGNATURE-----

--------------z7hR46qu20qfJSEpER90sy98--
