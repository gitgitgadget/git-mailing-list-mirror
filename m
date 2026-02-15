Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C2283FCD
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771154394; cv=none; b=oji5R+6Ne7MLwDrkOzwlUMtTdPG+31g7b1Lb8VBBl+VgK6LXGLQc8Jz3zGg6BXs+AFtiE+qcCgTHLmTtB4/rVtM4WoIagMZcjy05akfs4YCpvPduXya6DODTyQkG746eDU47Q5warrgMaPNUxXzONBV58FUpcH+vhUXpFLTXlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771154394; c=relaxed/simple;
	bh=IdE9nKNFv1MXqU3Lp4eir5DlYs+EMIOTND1gBkqGV/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R46CiO/SGsoYH4koDjAq3ciwxqCTMn2eHQmdyiLdTbv8Lr5FHPzCs+7Y76+pKQx5dr6T9PSwvZFEM7jCYlUQxjFXWsWifftaeZ09jZ9fdQb2eXAdcuU+4PUrb4TFvdSJH4ASXZ7nHqpB239MO8cgbe77kg76tW8ocjd3BWWPZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=hR+uiMYF; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="hR+uiMYF"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4fDNj756Xpz9vDSB;
	Sun, 15 Feb 2026 12:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1771154379;
	bh=IdE9nKNFv1MXqU3Lp4eir5DlYs+EMIOTND1gBkqGV/o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hR+uiMYFb7fzsQjgBnAhT4CcvF3yscINlNtAU5RQPUmY9jbM9xQ8eRW608TxYM0gY
	 5UFwTtsilO4hdsRFDwYTk8sUzPi28HycLLBBZDdyE31zk+pNO6jIrxUg3lu3sSHGRL
	 ux9Ghqs1c0olKD6lry1PrAN5MM/LUaRTkmUxsuJY=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from [IPv6:2a00:1a20:227f:fde1:7540:c985:993b:ae3a] (unknown [IPv6:2a00:1a20:227f:fde1:7540:c985:993b:ae3a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4fDNhw161kzMrVJw;
	Sun, 15 Feb 2026 12:19:27 +0100 (CET)
Message-ID: <52d93e12de058d3ccaaebcf8c49a48d85e455171.camel@t-2.net>
Subject: Re: [PATCH v4 2/2] shallow: handling fetch relative-deepen
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: Patrick Steinhardt <ps@pks.im>, Samo =?UTF-8?Q?Poga=C4=8Dnik?= via
 GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Date: Sun, 15 Feb 2026 12:19:17 +0100
In-Reply-To: <c55447544d68c3f98532b1d32183465c8f175ff8.camel@t-2.net>
References: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
	 <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
	 <e9b20ae06fd2c7f2c6b73c9f093a23c812227b7e.1768602661.git.gitgitgadget@gmail.com>
	 <aYyGTmS6fEb2QfBU@pks.im>
	 <c55447544d68c3f98532b1d32183465c8f175ff8.camel@t-2.net>
Autocrypt: addr=samo_pogacnik@t-2.net; prefer-encrypt=mutual;
 keydata=mQINBFwCXogBEAC4B5dfY/m82d0d5VBtFeVAjtUrOOdrLgbYJZFUXsX9pya5x0QdYeTP4
 afUZ73e7zMe0ozH8UMz6iv1niPfPkMorUzNcALDcotZ8Vvf3bMdndV7lHk8jScAMoW2L7VHGn1N+H
 8yJ5WufqF/yNBLqmVqaLqNjHejZN+Ld+/4AaJ/gQzWVqYH6EaJZd/LSqppJWGOHGGURFakFSDp3Bi
 6n8SOQmarOt6mGX5wsiHNwa8NtNX1cEJPT8YCQUR7o5fTHb3AEemLRFJoGjeH2RjzPloyTlwSjLXd
 Egph2uUGqiBKD1dREfIuIWtFAJF+iMRHhIEJSF4hvUYrYAV+7ZTlIo3NnDLIeNn40Qmn++9Uh8FbL
 YdFb14dyBkw8MBBQPQNCCpBflK7aaSFWpHv6nk/Z7fGrkwrD51CHsDut8PGQMtmSYMoSCWRI1wChn
 peoZn4Cq3yG1rj90IVv/rxmvL3oMQfE2oSMAhpyRPi0vK68cG4ILpO65Aulr0wr4JFdZBNmpf8BCF
 4jqpN1HsQJCYUYBMeMeOMkH9Gz3DBWuszvjjs7wmesMkEz5C92UlK6FWGUz6Ioi2bfRGOzx0+AjpZ
 rUaSIQ+5MCPxjWkxl3EQQFL2U3ItxxpaDO46AoRFj4oKKeHoteiwpziY8whIFmDXWfy7nDfp76RiS
 riLtyZiFEuzLwARAQABtCZTYW1vIFBvZ2HEjW5payA8c2Ftb19wb2dhY25pa0B0LTIubmV0PokCTg
 QTAQoAOBYhBNCCwgeDpWpcp2HPBvAkWUZaOuMIBQJcAl6IAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4
 BAheAAAoJEPAkWUZaOuMIKE8QAJ04bxv8nXpY3Tp5nWOIOsBmEHWvVEIdD2kxjC9YCQeKx4gJLADa
 RcuXhFbwi0NQtuSRf1G11ZGqxBM/YHvSd4Rtqbag4P9UY/ZdvMAe1zW4HTO9c2mtoWN3WYxS/gkX+
 wBLVIy+eqrsG5peJmRlq3fTbCxLprgqp6B2IUcTEBa8Iynv7B/1qsG2rd0y8pY+ZHIUtz2ZJHoYz2
 Lx091uYwy9aozibWRot+vZNx4QipOmsoZOm+e5FvTf4yvmFYJ3iR8fUfq9gpCokRNtPG5NvqNLApk
 EwEAlaXH7flAUwF/uRBUASZeyEeKGRtXOUYeGXFyOgykbmIs9IXDms8OLj/TZlSzECeoSX25I0P8M
 QrMb7GChMME4W9i9+ZZc8VWPyYW8W6dyNfBb05lu0XMB62oiYim7cOXiDV49EBYtiXIwUnbfQYVSA
 U8MTvZKS4ek2KGc9OJNLnm8dP2u31jvMUts7AEoU3vxwv8tUBEm4Zpzv8+HvzpAGAnbGc/kiLClaH
 j8E5d/3XIyq0TXlZf7B5Fq+lwa3gXMiLWko7m3PfOFtvbsSWPxplka6r2T2GMt9e51sctckfd7V/F
 unQvSwML0gpE6YicA/OcoFFOwoipilJ4D0YcqLgO8FNQdXukJciq0xeeBWY4t8Oo5M88J4YzAKMr9
 PU/BhjCBDTyCb2b1
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gjZS2XIbnxIbi1dsYKvw"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-gjZS2XIbnxIbi1dsYKvw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-02-14 at 10:40 +0100, Samo Poga=C4=8Dnik wrote:
> On Wed, 2026-02-11 at 14:38 +0100, Patrick Steinhardt wrote:
> > On Fri, Jan 16, 2026 at 10:31:01PM +0000, Samo Poga=C4=8Dnik via GitGit=
Gadget
> > wrote:
> > > 	object_array_clear(&reachable_shallows);
> > > =C2=A0	} else {
> > > =C2=A0		struct commit_list *result;
> > > =C2=A0
> > > -		result =3D get_shallow_commits(&data->want_obj, depth,
> > > +		if (data->deepen_relative)
> > > +			get_shallows_depth(data);
> >=20
> > Okay, so here we now essentially call `get_shallow_commits()` twice. Th=
e
> > first time we compute `data->deepen_relative`, only to then pass it bac=
k
> > to `get_shallow_commits()` a second time. That feels quite strange to
> > me. Can't we have `get_shallow_commits()` handle this for us directly i=
n
> > a single call?
> >=20
> > > +		result =3D get_shallow_commits(&data->want_obj, NULL, NULL,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 data->deepen_relative +
> > > depth,
> > > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 SHALLOW, NOT_SHALLOW);
> > > =C2=A0		send_shallow(data, result);
> > > =C2=A0		free_commit_list(result);
> >=20
>=20
> I have additional dilemma regarding handling this in a single call.
> Wouldn't it be generally good/useful to have a separate function in shall=
ow.c
> just for measuring current absolute depth instead of blending the measure=
ment
> into get_shallow_commits()?
>=20

I prepared another version which i am going to post shortly. It does make a
single call to 'get_shallow_commits()' in upload_pack.c, however in shallow=
.c
there is again a common internal function, which is called once for measuri=
ng
current depth and then again to get a list shallow commits. I do not know h=
ow to
perform current depth measurement and shallows list retrieval with new dept=
h
extended by the same measurement simultaneously. However i find it importan=
t to
keep common algorithm in a single function for easier maintenance. I hope t=
his
is ok.

Best regards, Samo

--=-gjZS2XIbnxIbi1dsYKvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmmRq7UACgkQ8CRZRlo6
4wgVyA//TOvr9vHRPBaADbDv510ZdgFqYsczdUd2RcF3nz07deIBhmzeDW1+PCMF
ByyKm68pSFgdJBRLsKLpzVbGFxGDPrGrdZWnLxCRvxMhr3Zj0RsNQyp3+Xan2lwp
OMEI6xgl4jGZmwhQnzl24tQVNqd4WZchRYm6h8CB9WgLY5H+o5Ux/Pa8X6E0S632
LVVSTfnkl3Dy/H3+hEi/aoqjq0GBoR26psu6bWCKCi4lYmcDfNCytNufGcVf28ja
C13PmECxdRHU0LxshNT3yUiq4jI6ZS9N+KLdjLGeoHcIj7abWhUOy5LrWVGypsNg
yGK91mPCFEGMGSI7ERfitT0EMq9QBLUZ+2jgp41KM+pnB8UZtiucCXtmjYfadWMZ
MW25TWMFQM5lZRb9r5CN3bRYEwsr8HmEW5ZqY9VVwgJ1KsWW7eK6efYunUM27lAr
H5lpw7gZftIKnJIwWDQCdZN9rHCXN6NVwmba0V1PlPlvINRDS6i/ICJY0GvCZ2xE
zrlpMoygl6QnA7rPzjnDwn7VOuYOWV32yVin3JCWGr4nU2tmwpw5g6vtIGTV47Tl
Vdfpi2r06LOImOZihQX+AXZDiiCiIHQfRl0Hxyabe+IF7yXknuYTJBA2M3FLKuTb
PvRwxCv1V2EMb/51LNiqid8HySGvVCnRlTWrHXC0pa1zrNkcKrg=
=Kkl2
-----END PGP SIGNATURE-----

--=-gjZS2XIbnxIbi1dsYKvw--
