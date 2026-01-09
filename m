Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE3238C16
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976252; cv=none; b=sWu5i4Irv/x7zB5EieHx3XjCAicGzuSKR1cwdIC/hglrP22bc79j7bscf96CD/NqYNMHWYou9/sdmADHiMwBTA5304Szyl7oPYl7e3JGKQblBRndJb4WmtGEqbojkvSd3w/C8Bxxee1BZPoDAFB4pWGzR4EjPxAbK1sA+fTlZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976252; c=relaxed/simple;
	bh=CtNFALuZcwcWlfFtpYo6mAHx1bGsDg8Prg1KhO43F6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RgjJxPqn6eNlUgF+DgKAAL2ye/AKIq8z5vk+Slu97+fZz+Gk+yAjAf8K7D2+u4bpQfEIKGCKTHg/vIa/cQl5or+NjACr44Hx3+HmXDrsqeb45zNDXeFKT8b/zBrI5srEIqRJS9yCdXoP2eaBeuQJDg8/UrK6gA42P00JrKcqFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=TuxufZt7; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="TuxufZt7"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4dnn9J29HBz9vPkP;
	Fri,  9 Jan 2026 17:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1767975732;
	bh=CtNFALuZcwcWlfFtpYo6mAHx1bGsDg8Prg1KhO43F6M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TuxufZt7EK0VdTDTWoMf1zco/JXW7uPHWR51SMYPMVitxADYIsILwmSkQm1NnUU8O
	 J/4yKqGZJNPcJ73+IEuskGvbkzkT+/xNGd7hrub5ntod4BQDD7PF3jdrE3SGQ47pzb
	 SAvqQvai8XEFAO0zH2r8nUMyj0h6WqS68F3QPFjo=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from [IPv6:2a00:1a20:223f:fac3:4f3f:95f4:6690:3b60] (unknown [IPv6:2a00:1a20:223f:fac3:4f3f:95f4:6690:3b60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4dnn984vknzMrVH0;
	Fri,  9 Jan 2026 17:22:04 +0100 (CET)
Message-ID: <eefa06bc46f8029b68efe993da67d14e268e1bf2.camel@t-2.net>
Subject: Re: [PATCH 1/2] shallow: free local object_array allocations
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: Patrick Steinhardt <ps@pks.im>, Samo =?UTF-8?Q?Poga=C4=8Dnik?= via
 GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Date: Fri, 09 Jan 2026 17:21:45 +0100
In-Reply-To: <aVy9ZveUOg3yum2X@pks.im>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
	 <277c8616a9fc365b76b2f4ab458cd927834f9e0e.1765303880.git.gitgitgadget@gmail.com>
	 <aVy9ZveUOg3yum2X@pks.im>
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
	protocol="application/pgp-signature"; boundary="=-ilWyXItQi4dkwnwOSTHu"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ilWyXItQi4dkwnwOSTHu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,
thanks a lot for the reply.

On Tue, 2026-01-06 at 08:44 +0100, Patrick Steinhardt wrote:
> On Tue, Dec 09, 2025 at 06:11:19PM +0000, Samo Poga=C4=8Dnik via GitGitGa=
dget
> wrote:
> > From: =3D?UTF-8?q?Samo=3D20Poga=3DC4=3D8Dnik?=3D <samo_pogacnik@t-2.net=
>
> >=20
> > The local object_array 'stack' in get_shallow_commits() function
> > does not free its dynamic elements before the function returns.
> > As a result elements remain allocated and their reference forgotten.
>=20
> I think the elements themselves are actually fine. We have the following
> loop:
>=20
> 	while (commit || i < heads->nr || stack.nr) {
>=20
> So while the stack still has entries, we'll keep on iteration.
> Furthermore, there is no `break` or early return in the loop, so we can
> sure that we actually pop every single element from the array.
>=20
> That being said, what we _don't_ do is to free the array itself. So I'm
> mostly splitting hairs with how the commit message is phrased, the
> change looks correct to me.
>=20
> What I'm wondering though is why we never hit this memory leak in our
> test suite. I guess the reason is simply that we ain't got enough test
> coverage around shallow clones. Have you seen this leak in the wild? And
> if so, can we add a test case that surfaces it?
>=20

Actually, the test I've added with the patch 2/2 does not pass without this
memory fix in linux-leaks and linux-reftable-leaks test runs.

best regards, Samo

--=-ilWyXItQi4dkwnwOSTHu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmlhKxkACgkQ8CRZRlo6
4wgCwg/8DyBHPEmVhKyetxq0SwVT7TmmptYj8BpJAzzEbIKE6aJdZ+GPyip/jizO
qbX1snvlg3XtZzF9oXfGAsiCjlD2KPGQEfK0CgLMVS+UYyUs3FURWJzr21guCFdn
/tzOt4YK/qoKjTQ20BA4t8DSVPqeiWtC1W37bOtw9260qes7UvhEly1vYjpSwR0D
pkmgcOTx2BQh7y3vSS6LLgXr7rsDh7M2Xb+8N1FxlEbrAQs5KFaHccycKeMDPsl6
td3Wxy4GNSm7jJErv70ib/az2fIXqHnX3tJ8CWdL+mf8e+ZXU7ZuCae9NjGOIFuQ
p6Ii+uIdc35SEjBrPaLfKlywRXPf7kN5a3Cxp/hcBQSTQ6v0WZNpzA9Zt7O5ANLf
Seq7d9kLzfNiiTqwuJDrCPpwp3WwAvs7TP07xYTG4tEkE/JgNG9/gRU53AUloOzn
OrFTN0PptDMp0Iq/TWpmMhoRHGsoW6zghizkx/tORer7/efswXKdJr1GsiN8Te2D
yBOHIEdhIeaZ2D0V8pshU2BHtToC5tHaFwt5RDEC5zi5viYT/V6wvQrHIM9b4Lz5
OZH6bWqvNkzRBNqshXHvlEebLHDPpCpn9qyojRaAeGBAY3Go8AZF+oTH3aEJLaSD
j88gh4UpxZliDQOw+CjndAk5iUHUZHcgX6how1rFsHTnq2jGRPU=
=3Lf7
-----END PGP SIGNATURE-----

--=-ilWyXItQi4dkwnwOSTHu--
