Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621B191F84
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078427; cv=none; b=JLFvhLVom2grUM5bDKQUcEFpp9l/17N0DEEb6jZ9hJKrAMip0xjUHTN+c4aHjydneQS163Q6lczhWlf0IwIXSve4u8kfsWQJ4G6rw/T5vVeEgmG+yTVusqUXDXC4/cxHl5UuhvXocQIcnazhUejEaqyf6ZGFBUt0NIOzeJIEzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078427; c=relaxed/simple;
	bh=/Y3ualz4JEYc5WBeQ/t60gju1KfBog8cEz029YTn76U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gudkgEjP+HU+aVp5kDpEcmYQRi1QVdf4GMPkTg8rWo35fDFkiJE6wntZ6Gk14faK+TotNlUi7k+mcLb7yw/Sl6juCwRe9xXTWqxB/8e17lSVjMQx42hs3lWILWAoTH/zV63BeN8eww06zWqz6ym4+ddS827Oc7bUPa1WjyAucco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:cf90::12ac] (unknown [IPv6:2603:6011:3f0:cf90::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E947E33BF39;
	Fri, 05 Sep 2025 13:20:23 +0000 (UTC)
Message-ID: <7040d009-2a1f-4962-abcc-80b82b89f1e6@gentoo.org>
Date: Fri, 5 Sep 2025 09:20:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
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
 <013a3006-d220-424d-a28d-fb273c523c71@gentoo.org> <aLqWKYkj98QUDxRi@pks.im>
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
In-Reply-To: <aLqWKYkj98QUDxRi@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4O4QGVY9p6whXruta0I8A0pj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4O4QGVY9p6whXruta0I8A0pj
Content-Type: multipart/mixed; boundary="------------ubdAxcF0Wrbf0gXI0ZmWsy7l";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Message-ID: <7040d009-2a1f-4962-abcc-80b82b89f1e6@gentoo.org>
Subject: Re: [PATCH RFC 1/3] meson: add infrastructure to build internal Rust
 library
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-1-3af1d25e0be9@pks.im>
 <aLoNc5S6PVW8jLu5@fruit.crustytoothpaste.net>
 <013a3006-d220-424d-a28d-fb273c523c71@gentoo.org> <aLqWKYkj98QUDxRi@pks.im>
In-Reply-To: <aLqWKYkj98QUDxRi@pks.im>

--------------ubdAxcF0Wrbf0gXI0ZmWsy7l
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/5/25 3:50 AM, Patrick Steinhardt wrote:
> On Thu, Sep 04, 2025 at 09:16:03PM -0400, Eli Schwartz wrote:
>> Hmm. Patrick -- do you mind documenting why you decided to use this
>> version guard at all? Off the top of my head I'm not sure why you'd ne=
ed
>> this.
>>
>> In src/meson.build,
>>
>> +libgit_rs =3D static_library('git_rs',
>> +  sources: [
>> +    'lib.rs',
>> +  ],
>> +  rust_abi: 'c',
>> +)
>>
>>
>>
>> rust_abi is new in meson 1.3.0, but it's just a rename for clarity of
>> rust_crate_type, available since meson 0.42.0, so please use the
>> backwards-compatible name...
>=20
> Oh. I think I misunderstood the following sentence [1]:
>=20
>     (Since 1.9.0) Rust supports mixed targets, but only supports using
>     rustc as the linker for such targets. If you need to use a non-Rust=

>     linker, or support Meson < 1.9.0, see below.
>=20
> I thought that only with Meson 1.9 you could link Rust libraries with C=

> libraries. But I guess this rather means that you can now have a single=

> target that has both '.c' and '.rs' sources?
>=20
> In any way, thanks for the hint, will drop.
>=20
> Patrick
>=20
> [1]: https://mesonbuild.com/Rust.html#mixing-rust-and-nonrust-sources


Yes -- a single target is something like a libXXXX.so or a libXXXX.a
file, and there are significant nuances in how a build system backend
needs to run rustc in order to emit the final C interface (or merge into
an executable). Once it is exported to C, though, it is "normal" C code
and anything may link to it freely, even for much older versions of Meson=
=2E

The previous (<1.9.0) gold standard for Rust / C interop in Meson, was
the far more well-trodden path of "use libraries, not *.o files" (which
is also more straightforward in cargo, of course ;)).


--=20
Eli Schwartz

--------------ubdAxcF0Wrbf0gXI0ZmWsy7l--

--------------4O4QGVY9p6whXruta0I8A0pj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaLrjlQUDAAAAAAAKCRCEp9ErcA0vV1QO
AP41PUIbtnNExTJVWOcAYo8pPDNWTjc/IMfU8lnoxivpMAD/dQsAofzk/ul4uhy0ny5cMXcSduyr
R1LBoqIQYmCJJQI=
=r8I7
-----END PGP SIGNATURE-----

--------------4O4QGVY9p6whXruta0I8A0pj--
