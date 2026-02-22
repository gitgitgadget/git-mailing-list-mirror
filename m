Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7F1624C5
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771801665; cv=none; b=TN3H5LhBGZHFgtDCpncpKIhQb8UjU1d7ICOobaXSC5yECrIaSj3I6kCAMI3oJOZnweNq6YaB9zCheWaIqiM0kc+rUrhmCoNYPZTnl7taJLmKYGVrDkoVUDqiG//UI39Tzorsqu4hIHjyGm+h7+K4Bafa23shC2kEyPdPW2LnpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771801665; c=relaxed/simple;
	bh=5AzYzZKqbwOC82KQWjgsnEFDMoG1H8B8XeFB4gP2e5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AENQ1WfKADrI5KGlC0gjH9eDyPhNa1S6RZRzZkohu3egrcrix320XCj9ck7tE3qcQglYcoD5HATfHb5/ByXkjm0BWNinmUAQkVwsNpEgdTYidcYtxWQN+Lm1pj9wxM2WCV57ivo7XZ/uzNL091aJF6vjyjBELXM/+8j4nUuckIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GBBxUUrH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GBBxUUrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1771801662;
	bh=5AzYzZKqbwOC82KQWjgsnEFDMoG1H8B8XeFB4gP2e5o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GBBxUUrHMLIxGWG4JKd5WQ9NpakLYuJTyMwE80WCLhzfw+39fLg5E5HBinYZ7QWbU
	 5SBYXKyniiUpaKJ+fo5PExBSrUkI7QUTQxz83qgS4YyvtJnHAic7rjXWZQNQ0YAtlp
	 BDGFZPXYhCp9GQxTrnWgPupOM8t6QcI9ELFAcHnvSBP0kesHd5xK0tC382qS6VFmD/
	 Z6zFn7UTpVdlTwooPywvAmKxW1pnECn5qaxvqrIm7AQDMEPR0OXEr6vyVzKqjore9f
	 y0P9wC6lXK21J2BCOkszQzwMPcDxpafdQmpicELnfQe9IqGJDOFmam5ou21Z9h1W4K
	 pAjsTP7+6WqJSnNfJwBYPB/BH2/CdSlABJOeAXiVG+qxyhCITbf8J0ljGoOgRKToyz
	 fo8eWDziAUT9XeS05gkWTYx+pSBB8+Gxej6MNq12XX6U4lv6oZ1NVnjHDWcwQpJ9qN
	 3bF6CZ+qNIUf/FpoCZdQj7gD5b5rXPPO95Pctsxzyk7LNpEBFQq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:68b7:8d88:6116:675d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 753DB20083;
	Sun, 22 Feb 2026 23:07:42 +0000 (UTC)
Date: Sun, 22 Feb 2026 23:07:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <aZuMPcMYwFi4Sch5@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <xmqqv7fopflu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zm8pqrdtbgdbzM0r"
Content-Disposition: inline
In-Reply-To: <xmqqv7fopflu.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Zm8pqrdtbgdbzM0r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-22 at 22:39:57, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> > index 5be273611a..75e75e627c 100755
> > --- a/t/t1050-large.sh
> > +++ b/t/t1050-large.sh
> > @@ -160,6 +160,10 @@ test_expect_success 'hash-object' '
> >  	git hash-object large1
> >  '
> > =20
> > +test_expect_success 'fsck does not loop forever' '
> > +	git fsck
> > +'
> > +
> >  test_expect_success 'cat-file a large file' '
> >  	git cat-file blob :large1 >/dev/null
> >  '
>=20
> Wow, this is a fun test ;-).
>=20
> Thanks.  Will queue.

I noticed that the code here seems to have come in with the 2.53 cycle,
so we may want to cherry-pick it to `maint` at some point if it seems
like the problem occurs often.  From what I can tell, it only occurs
when one explicitly invokes `git fsck`[0] and not on transfer, so it
shouldn't cause a DoS against server implementations.

Of course, we should wait for Patrick, who authored this code, to chime
in and lend his expertise here.  I must admit I'm not very familiar with
this area, although I had recently seen the MRU code when working on
pack index v3 (and then I thought, "is this actually the problem?").

[0] The code I saw is the `if (check_full)` branch in `cmd_fsck`, which
is obviously only invoked by the `fsck` command itself.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Zm8pqrdtbgdbzM0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaZuMPAAKCRB8DEliiIei
gcH5AQC4FYy1B8BhLSEhfwBIyeXEwWkMU17dTrQofM+gs6SqYAD/XMlqiPDfsWVY
8oGJTZFpj6wfnPSvyOLBSWHQ5r8cwg4=
=K0p9
-----END PGP SIGNATURE-----

--Zm8pqrdtbgdbzM0r--
