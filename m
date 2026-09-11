Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A083D9539
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165588; cv=none; b=rukvdvBiVqNPG9fe8d/hEVgCS4xB9AZj/ziujV+0+uPR76q/fQUJF1e4BZQxoOlH1zUk+ruS7Eq9ddc4IwjSSepAn5uebcTht4sZ/9ZNjJIf2cNnU+Oo58r88ljjwMfAhbQorig7Jst6FGPTBCMder8dTT5ysG1RM0y5uY181zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165588; c=relaxed/simple;
	bh=J3TLdpF0yYbZFCcqPhLW4syZGvlI/3aGBdbwx4aJFqY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHLPe8925MjC07134iCElRgta17LnPoT8FoSP+bi3/3/rewAm4r95r3N0l8a4xNLUEztCWz7sUWL4x9223xkC9AjBDcBXiWsh/Rwz6QupakgbuKpezr33BaI97/DXU/SDN5ttoygMvTG6vRRASee5IhGirn2NdXGU6+C2C3a6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from 9.b.6.b.3.b.7.f.e.a.d.1.1.c.9.9.c.6.e.0.c.6.2.0.0.b.8.0.1.0.0.2.ip6.arpa (9.b.6.b.3.b.7.f.e.a.d.1.1.c.9.9.c.6.e.0.c.6.2.0.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:26c:e6c:99c1:1dae:f7b3:b6b9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: chewi)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3E06E340D0A;
	Fri, 11 Sep 2026 22:26:17 +0000 (UTC)
Message-ID: <c29cd39efc7b472ff1aeaede367d7f39f3ca1eeb.camel@gentoo.org>
Subject: Re: [PATCH v2 1/2] rust: pick a GCC-compatible Cargo target under
 MSYS2/MinGW
From: James Le Cuirot <chewi@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>, Johannes Schindelin via GitGitGadget
	 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Johannes Schindelin
	 <johannes.schindelin@gmx.de>
Date: Fri, 11 Sep 2026 23:26:11 +0100
In-Reply-To: <xmqqa4pna411.fsf@gitster.g>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
		<pull.2213.v2.git.1789153730.gitgitgadget@gmail.com>
		<6567eceb32c1bdcff5927c6baf0cadc97af7485b.1789153730.git.gitgitgadget@gmail.com>
	 <xmqqa4pna411.fsf@gitster.g>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Gw2cP+8wjQq45k7UY6kj"
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Gw2cP+8wjQq45k7UY6kj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-11 at 14:09 -0700, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > @@ -993,6 +993,7 @@ endif
> >  ifndef DEBUG
> >  CARGO_ARGS +=3D --release
> >  endif
> > +CARGO_ARGS +=3D $(if $(CARGO_TARGET),--target $(CARGO_TARGET))
>=20
> Should this use CARGO_BUILD_TARGET (instead of CARGO_TARGET) to
> match what the officially supported Cargo environment variable is
> called?  It would also help us work better with the changes from the
> jc/rust-cargo-build-target topic.
>=20
> Thanks.

Yes, without explicitly setting --target at all. This is how Gentoo Linux
supports cross-compiling of its Rust packages. Just avoid setting
CARGO_BUILD_TARGET (or passing --target) when you're not cross-compiling. I=
t
will cause Cargo to behave differently, even if you give the native tuple. =
For
example, RUSTFLAGS is normally applied to both the build host binaries and =
the
target host binaries, but when an explicit target is set, RUSTFLAGS is only
applied to the target host binaries.

Regards,
Chewi

> Author: James Le Cuirot <chewi@gentoo.org>
> Date:   Thu Sep 10 11:20:14 2026 +0100
>=20
>     rust: respect CARGO_BUILD_TARGET when locating build output
>    =20
>     When cross-compiling, Cargo always writes to a target-tuple subdirect=
ory
>     determined by CARGO_BUILD_TARGET, even when it matches the native tup=
le.
>     The build looked in $BUILD_DIR/$BUILD_TYPE directly, so it failed to
>     locate the freshly built library.
>    =20
>     Respect CARGO_BUILD_TARGET in the output path so the correct artifact
>     is located.
>    =20
>     Signed-off-by: James Le Cuirot <chewi@gentoo.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> diff --git a/Makefile b/Makefile
> index d4b775953d..f0ca2e4f72 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -959,7 +959,7 @@ RUST_LIB_NAME =3D gitcore.lib
>  else
>  RUST_LIB_NAME =3D libgitcore.a
>  endif
> -RUST_LIB =3D target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
> +RUST_LIB =3D target/$(if $(CARGO_BUILD_TARGET),$(CARGO_BUILD_TARGET)/)$(=
RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
>  endif
> =20
>  GITLIBS =3D common-main.o $(LIB_FILE)
> diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
> index 75f3cd1265..83c7e7b79b 100755
> --- a/src/cargo-meson.sh
> +++ b/src/cargo-meson.sh
> @@ -38,7 +38,7 @@ then
>  	exit $RET
>  fi
> =20
> -if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/d=
ev/null 2>&1
> +if ! cmp "$BUILD_DIR/${CARGO_BUILD_TARGET:+$CARGO_BUILD_TARGET/}$BUILD_T=
YPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
>  then
> -	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
> +	cp "$BUILD_DIR/${CARGO_BUILD_TARGET:+$CARGO_BUILD_TARGET/}$BUILD_TYPE/$=
LIBNAME" "$BUILD_DIR/libgitcore.a"
>  fi

--=-Gw2cP+8wjQq45k7UY6kj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEDBAAWCgCrFiEE6qETVs4yu3Lfuc3XsNCJZ6jP87QFAmqkgAMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRFQUExMTM1NkNFMzJCQjcyREZCOUNE
RDdCMEQwODk2N0E4Q0ZGM0I0ERxjaGV3aUBnZW50b28ub3JnAAoJELDQiWeoz/O0
u1cBAMM3mPEnAQyQxCFNy8pXfl55f7jYXiUKgYyGKkvhk6AJAQD4lsTTg0+gsVDI
DTXuhDcXeGkoYrJNmBF0JmT7ZlJSDg==
=LTNO
-----END PGP SIGNATURE-----

--=-Gw2cP+8wjQq45k7UY6kj--
