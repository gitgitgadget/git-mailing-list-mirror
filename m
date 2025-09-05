Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F6145A1F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037652; cv=none; b=ioHPu1aj3RVRk2DsbBnAPb2AoMRB6mpOiVjUrALEU1SGj200iQ3Y7krt4DYt7boTJZhvnutv138/S+HE/qMx6vMUjkLaFcDGoPVEk2OKJpAKF++IphTiPI1+nOM2UPK1w3wi2CimhFKfzAYYaZPh5YqR7dNAW8cFFhXTVbCINjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037652; c=relaxed/simple;
	bh=+gdehOYf8FxZGFehblA25bTuefQGaRbUtCJUaAtvlVQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DYM0Sso1R8TdjIA3PVGDx5e2YXASBT70680vsvzrrgjKMsIpo1CAlGG+IpLpm7un9DGbUo0EIJq6CQutPfLlrOy/k0zzSRqK7wJyBwvn5mKraNww+XuuqPqlyn7tTeqw4ce2ZJD+zT3aAUWa8ti/WTM3yLoLqsA4C/EuXlRkk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:cf90::12ac] (unknown [IPv6:2603:6011:3f0:cf90::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 497A533BF36;
	Fri, 05 Sep 2025 02:00:48 +0000 (UTC)
Message-ID: <85b9def3-ae1c-4535-9d56-be6f08eaa8d7@gentoo.org>
Date: Thu, 4 Sep 2025 22:00:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
To: Ezekiel Newren <ezekielnewren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
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
Content-Language: en-US
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <CAH=ZcbANoa8Qjbz4OmdZatBi5b+RQVnatF+7pmffA4SQh=EFCw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7cYQ6d3ivDg1L50NcBpO0FEj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7cYQ6d3ivDg1L50NcBpO0FEj
Content-Type: multipart/mixed; boundary="------------K0aJxM3hqb00FKN9Xlypvm00";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Ezekiel Newren <ezekielnewren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Elijah Newren <newren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Message-ID: <85b9def3-ae1c-4535-9d56-be6f08eaa8d7@gentoo.org>
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
 <CAH=ZcbANoa8Qjbz4OmdZatBi5b+RQVnatF+7pmffA4SQh=EFCw@mail.gmail.com>
In-Reply-To: <CAH=ZcbANoa8Qjbz4OmdZatBi5b+RQVnatF+7pmffA4SQh=EFCw@mail.gmail.com>

--------------K0aJxM3hqb00FKN9Xlypvm00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/4/25 7:39 PM, Ezekiel Newren wrote:
> On Thu, Sep 4, 2025 at 8:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
>> Implement a trivial test balloon for our Rust build infrastructure by
>> reimplementing the "varint.c" subsystem in Rust. This subsystem is
>> chosen because it is trivial to convert and because it doesn't have an=
y
>> dependencies to other components of Git.
>=20
> Huh, I thought Meson couldn't run Rust tests. It's refreshing to see
> someone else try a different approach on bringing Rust to Git.
>=20
> There are a few reasons why I picked Cargo instead of Meson to build Ru=
st:
>   1. Needs to work with make.


If the rust code is defined as a crate, meson can auto-import that crate
via parsing Cargo.toml, so perhaps this can simply be done by creating a

[lib]
crate-type =3D 'cdylib'

and... importing it as a meson subproject. You'd be able to build it
with cargo build, if you really want to (and the Makefile may have to)
but Meson would not be limited to this.


>   2. I've heard that using crates in Meson is quite painful.


This is specific to build.rs, and it is "difficult" in the sense that
meson cannot compile build.rs into an executable depending on other crate=
s.

Compiling it into an executable depending on other crates is a
prerequisite for running it and parsing its stdout into a list of
defines (rust calls them --cfg) to pass as command line flags for the
real build target.

Meson has official guidance for doing that work in-process by writing a
"plugin" meson.build:

https://mesonbuild.com/Wrap-dependency-system-manual.html#cargo-wraps

build.rs is not something which any crate likes to have anyway. Most
crates therefore don't. And don't have any problem being used by meson.


>   3. My understanding is that someday in the distant future Rust will
> supplant C in Git.


And you will want a build system that understands both compiling rust,
and installing files in general (cargo cannot do this) and installing a
quite wide variety of data files (implicitly the previous point means
cargo cannot do this either).

Who knows? Maybe in the "distant" future, Meson will have even more
additional support for Rust. I think I may have heard a rumor that Meson
is open source, so contributors will probably be welcome. I also heard
another rumor that QEMU has been contributing a lot to this, and Gnome
and Mesa as well.

If it's all part of the distant future anyway, we can *certainly* try to
help shape the future to fit our needs, and experiment with different
ways to achieve that.

=2E..

BTW: running tests with cargo is a genuine nightmare hellscape. As a
linux distro packager, I don't know what is wrong with cargo but I sure
as heck know that if I run `cargo build` followed by `cargo test`, the
resulting binary, if installed, will have incorrect behavior.

https://gitweb.gentoo.org/repo/gentoo.git/commit/dev-util/ruff?id=3Df10d6=
4828e9c33b2a1951c9a0e1fa84e4a736875

Meson has sane behavior here, because two completely different build
targets (a program and a unittest) don't create the *same* file.

I am very nervous about trusting cargo for predictable behavior.


>   3. The IDE RustRover only understands Cargo.

Since Meson 0.64 we generate the rust-analyzer official format for
integration:

https://mesonbuild.com/Rust.html#use-with-rustanalyzer

We're very much open to ideas about how to improve this but my
understanding was that rust itself expects you to use this special file
-- why doesn't RustRover use it?

Is RustRover (a very specific thirdparty IDE) a dealbreaker, one way or
another?


> As I mentioned in another thread: The reason why I made Rust a hard
> dependency is because it's easier to develop and talk about that way.
> I'm open to suggestions on how to make Rust optional.


--=20
Eli Schwartz

--------------K0aJxM3hqb00FKN9Xlypvm00--

--------------7cYQ6d3ivDg1L50NcBpO0FEj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaLpETQUDAAAAAAAKCRCEp9ErcA0vV4Xh
APkBXxVooFIgYoSh26mdL34JAfnfSRhj5XS/eRanEb2RUQD/W+GQ8MU08YV2ltepqtJ0u5CdsV1L
q1rC3T139fMFcAg=
=Uck5
-----END PGP SIGNATURE-----

--------------7cYQ6d3ivDg1L50NcBpO0FEj--
