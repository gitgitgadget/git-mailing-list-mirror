Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B715696E
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129367; cv=none; b=iqQYhSIg5mCccrxEDPhqw6tKrWAO3eQxROao7IFFk8U8X6AaRFRQWkjAotqAn1xHWBHjpMr6b3qW7TWF9uoX5g3YOjXPc84MN9EXUHDNVog7dAmQfOAzyM91J5L9bKtCUfBmHN3W5fZmek7WNXaCju4aA9283pzm8sDSbEcDKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129367; c=relaxed/simple;
	bh=ab/ZkQOcoPUiwDRHgbe488pOJWWiJyFEJpuk7ESwBio=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXbHVVc1tsyflJ6kIoJnqpQY1kBBU7mxjVppDBSdrijtVXtHhZQZOVE+ZqVR7w/e55StEqLFdMbIrt7cHNqsUii8k+aQHCsQb/Bh2f9L4gwAA3d+UptcAZJswkEoWoxvSuu/YcEd1upDSQVBIXjSCrOKdt/4CVgsVfEfboW8F/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mZu039gu; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mZu039gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1737129357; x=1737388557;
	bh=4C3y0JD3faQGr1cMShB3Ee78c489qNr8QUj0AV8/DD8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mZu039guwGLln0QWN9uzp+90MDBhvBGJB8lF8643NLvPIRmyRswG8F4F3xI+L0G5T
	 GDRvYiQwsflnr3F/OR0pSi0Zd4DgtOkoQi82Z0VHl/EXTpjogdYNW+noqHyTcvMRNk
	 WnsP8PKVUFvNZ8UESCJ+yAFA8uI3db8qMcICGu/EqKxE893SnEV3XM6WSK4GxtVtv1
	 3TtInJD58KkjUOpXelKoul2UkgY/fRnJtyo/wUY2SM1d8NdDGhHOxhZX3MvTX+Ng5r
	 U9IolSjg6OJwBuB8j5/lesLAFNzw+syP57H2fdgF+2unpVa78bv2zItr3XTHc5vwGd
	 7rpT9xaIUWQUQ==
Date: Fri, 17 Jan 2025 15:55:53 +0000
To: Jeff King <peff@peff.net>
From: Koakuma <koachan@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git crashes with a SIGBUS on sparc64 during pull
Message-ID: <nwg0r52UT4d_kBbQa7V7xCWKxE1xtHiwXKtBvzEwxtJa-3nKpXcWG2DRGUENDSJQ9QOkk4jrEaXYjAbiSAZds2ynH1TZPcX3x6T_t4zm8s4=@protonmail.com>
In-Reply-To: <20250117125207.GB2356599@coredump.intra.peff.net>
References: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com> <20250117121121.GA2356599@coredump.intra.peff.net> <20250117125207.GB2356599@coredump.intra.peff.net>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 942c6383f539d2c1e4f7cc3dd56909ef98c7cc6b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> wrote:
> Perhaps:
>=20
> git init repo
> cd repo
> git commit --allow-empty -m foo
> git repack -ad
> pack=3D$(ls .git/objects/pack/*.pack)
> dd if=3D$pack of=3Dno-header.pack bs=3D1 skip=3D12
> # don't bother parsing the first 12 bytes; we know it is
> # a version 2 pack with 2 objects
> git unpack-objects --pack_header=3D2,2 <no-header.pack
>=20
> would be a minimal reproduction?

Thank you! This reliably triggers it every time.

> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 2197d6d933..288cecf98f 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -645,18 +645,20 @@ int cmd_unpack_objects(int argc,
> continue;
> }
> if (starts_with(arg, "--pack_header=3D")) {
> - struct pack_header *hdr;
> + unsigned char *hdr =3D buffer;
> char *c;
>=20
> - hdr =3D (struct pack_header *)buffer;
> - hdr->hdr_signature =3D htonl(PACK_SIGNATURE);
>=20
> - hdr->hdr_version =3D htonl(strtoul(arg + 14, &c, 10));
>=20
> + put_be32(hdr, PACK_SIGNATURE);
> + hdr +=3D 4;
> + put_be32(hdr, strtoul(arg + 14, &c, 10));
> + hdr +=3D 4;
> if (*c !=3D ',')
> die("bad %s", arg);
> - hdr->hdr_entries =3D htonl(strtoul(c + 1, &c, 10));
>=20
> + put_be32(hdr, strtoul(c + 1, &c, 10));
> + hdr +=3D 4;
> if (*c)
> die("bad %s", arg);
> - len =3D sizeof(*hdr);
> + len =3D hdr - buffer;
> continue;
> }
> if (skip_prefix(arg, "--max-input-size=3D", &arg)) {

This diff does fix the issue in `cmd_unpack_objects`, however...

> I'm curious if it's enough. After we write to this unaligned buffer,
> naturally the next thing we'll do is read from it, and the reading
> routines will do the same cast (see unpack_all() in unpack-objects).

It crashes in `unpack_all`, just as you guessed:

#0  unpack_all () at builtin/unpack-objects.c:583
583=09=09nr_objects =3D ntohl(hdr->hdr_entries);

So I suppose the reading part needs to be adjusted as well?

> But maybe your platform allows unaligned reads but not writes? Probably
> I am being too optimistic. :)

As far as I understand, sparc64 traps on any unaligned accesses,
be it reads or writes.
