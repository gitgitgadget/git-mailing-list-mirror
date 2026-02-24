Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AD3191BB
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971821; cv=none; b=bO4mGIn4HI7x/nGLbQojF/jqrX957VWZixreKWd+DhXMnjlbrtlsMtgn7GMISI0VZGRiN47+VJTb+aFYqWU+6pZMN/7CMlb3BC2p8xdTiAKLShjJnc5x0YucDmQaBEwhj4TyeP8nb8iF7bfzBPCRvmfbJB6VJnPT8Bg+aA5TfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971821; c=relaxed/simple;
	bh=zP58+XZJEHcpQd+j3z3ycjVdZci/hiod11heBYP7SbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqaJPaWvVXlxKvREXXWA5TRupYWhzbKfCJceS1dT7eeKAxwUYSQSIWgFEoFX7uYtR+6fGi5MBn8+YzIAGhyMyT2gs0gKmM3GmBS9HffHUlLJWpMEvfstrwhFvSMektXfWoILM7kHRvXKFyTn2WLI9XweR1WtHItUGySpTVGld8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ni7srU/I; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ni7srU/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1771971813;
	bh=zP58+XZJEHcpQd+j3z3ycjVdZci/hiod11heBYP7SbE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ni7srU/IhBXSoeAYE957H2DjUAKafVNh0iTeh7fuP8L02kgjU8DYIIpMlI1AWNco6
	 zhmB3A77WoEFapvWB8tJtf78t1Rg3BcJFTsOwFEsXwXA2kEmO93StOjHoS1AsIsr/Z
	 49UxwXl0vr1FZVklhbTS/3n6CYUGSzX6Z2b5a9bFRSUcM2Pz2SxtS6vSwedJlf8E+K
	 EAQSd3cWYnTkGqG+/4MZARSK92OzQ+3M4DfbrdHUm/vhEpRRl3p5/jF9oFHSF9tvLF
	 ID2c+aREtiSw6+xXF7wV2kpkiIniju6y2kKo8DWWlALp3BhPkeDwzjrQeruxFosfVt
	 /xoSIwRehVS/Dt5MKajW2ovjfzF+70FghjnfiRD3uzQwvAnZ39+a7tLHgJicPCEjX3
	 uolpMrH3mYqhCdLFo6ayKbJxFw+54gz8y6R68Vund9PkURimrl6C8/ZwZvLSQrQgh5
	 Ol+OowpGIwF5/3a0yGXlx0/Q+n+7YoASxtkTN1TUNHNefZhYu7X
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5975:bd7e:3325:4c49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5DE5B20106;
	Tue, 24 Feb 2026 22:23:33 +0000 (UTC)
Date: Tue, 24 Feb 2026 22:23:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <aZ4k5C_i_rK_yq68@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <aZwTPfmyrFp-QAPq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oPPJMCYyaNF7eF++"
Content-Disposition: inline
In-Reply-To: <aZwTPfmyrFp-QAPq@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--oPPJMCYyaNF7eF++
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-23 at 08:43:41, Patrick Steinhardt wrote:
> Typically, we don't execute `find_pack_entry()` at all when verifying
> packfiles as we iterate through objects in packfile order. We thus don't
> have to look up objects via their object ID, but instead we do so by
> using their packfile offset. And this mechanism will not end up in
> `find_pack_entry()`, and thus we wouldn't update the MRU.

If you're thinking about `nth_packed_object_id`, that is index (object
ID) order, not packfile order.  I actually made this mistake when
writing the interop code and having that function operate in pack order
breaks a surprising number of things in very subtle ways, notably
generating multi-pack indexes.

I will be sending a patch in the future documenting that requirement
clearly.

> I've got a couple patches in the making that'll fix this.

I'm happy to drop this patch in favour of yours.  Thanks for a quick
response.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--oPPJMCYyaNF7eF++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaZ4k4wAKCRB8DEliiIei
gTDKAP9D6hGlp5KIVQT+s9qAD1YpcSTHYp0FuVMYxGj4ESlf+QD9Fwt1BnZmjTo3
e1FMaWCdjMxL62wA1mXn+wFCjHQUDA8=
=GUrH
-----END PGP SIGNATURE-----

--oPPJMCYyaNF7eF++--
