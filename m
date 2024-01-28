Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9288539A
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 04:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706416522; cv=none; b=bjoBv5+e5lEu51hhNFFwaMGnUXBnhuOyQdrY9GfxldE7lnCs+ngKdBuj5e0/TfYvfe0uNN1O0+NKMrFwpXD3vMsom1y3WJbS5qD+j90BjdGPnDcMDfZR8bQCPnugPfB5+jS7MZKnKg3OktXdyr373TLxPUsT0Izj7xS9jkXUaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706416522; c=relaxed/simple;
	bh=9SqMLOMQpJH3+8yNr1NGN5EyhZN/mnavzNmap1E05VA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLmahoZ/pR3YerFli+fWSI6kZ+5AKK57HdGS5Ba0nJvF/TsLZuBKYTndR8U6XXwBz+X7sf+ILRjA24C3ZvnIVS3Z/tUx+ojaflDV6I8I/AA0J8MLGUjSuiQ0XDhYHSjS6Aa13oy/31NHR0JNBnWocTl1lT+OCXB9bPkDwY/FLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bEpsq8PI; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bEpsq8PI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706416512; x=1706675712;
	bh=9SqMLOMQpJH3+8yNr1NGN5EyhZN/mnavzNmap1E05VA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bEpsq8PIHeGlAjIxqjUKx3JCpS5COpEOPjp5XNkN50Cz2y7R/b1J/3nniYDjKN/Oy
	 EbHUjhyU9p1ZZnNuqr+hOB61XqbCt/rzWWktrM0Xx7WjlIko34Cu3CSf6qkrJGwlXm
	 qBekqH3qADb38dDrpRVhh2erKLgYOpnV2VQ1hJ7/aEj91nIAVjD6R3TSxlMp6RBJv6
	 83Bh1OvfvMLSR8W8IvvCZBVYwuqfqEibgQ5+xw1FFeqhUMeQ7vcH4N0Yb6/ap/CFeu
	 vK5pcD+SXj4LHwoFLiWa+HvF/DK5pq+QB/5NO0MixF63LC4Y06dI9G0gZvjWMpBKGI
	 gBJl9gvYytDmg==
Date: Sun, 28 Jan 2024 04:35:02 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Mohit Marathe <mohitmarathe@proton.me>
Cc: Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Mohit Marathe <mohitmarathe23@gmail.com>
Subject: Re: [PATCH v4 2/2] patch-id: replace `atoi()` with `strtol_i_updated()`
Message-ID: <0d_yXUwMsJQsIySLnVJ5SlpFi2YdTgnvVN5cLCbwt_V4pVOUipzFEPlFY1xLicHfe4SGsWwF5D1q1idGBVyRXXr6tME-GR6hQG7usi5mypw=@proton.me>
In-Reply-To: <xmqqttn2bg2o.fsf@gitster.g>
References: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com> <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com> <17f2dda4907ec03b0783160c53c4896fd76cb053.1706079304.git.gitgitgadget@gmail.com> <xmqqttn2bg2o.fsf@gitster.g>
Feedback-ID: 95862732:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thursday, January 25th, 2024 at 2:32 AM, Junio C Hamano <gitster@pobox.c=
om> wrote:

> "Mohit Marathe via GitGitGadget" gitgitgadget@gmail.com writes:
>=20
> > q =3D p + 4;
> > n =3D strspn(q, digits);
> > if (q[n] =3D=3D ',') {
> > q +=3D n + 1;
>=20
>=20
> So, we saw "@@ -" and skipped over these four bytes, skipped the
> digits from there, and found a comma.
>=20
> For "@@ -29,14 +30,18 @@", for example, our q is now "14 +30,18 @@"
> as we have skipped over that comma after 29.
>=20
> > - *p_before =3D atoi(q);
> > + if (strtol_i_updated(q, 10, p_before, &endp) !=3D 0)
> > + return 0;
>=20
>=20
> We parse out 14 and store it to *p_before. endp points at " +30..."
> now.
>=20
> > n =3D strspn(q, digits);
> > + if (endp !=3D q + n)
> > + return 0;
>=20
>=20
> Is this necessary? By asking strtol_i_updated() where the number ended,
> we already know endp without skipping the digits in q with strspn().
> Shouldn't these three lines become more like
>=20
> n =3D endp - q;
>=20
> instead?
>=20
> After all, we are not trying to find a bug in strtol_i_updated(),
> which would be the only reason how this "return 0" would trigger.
>=20

I was confused about how an invalid hunk header of a corrupted would
look like. This was just an attempt of making a sanity check. But after
taking another look, I agree that its unnecessary.

> > } else {
> > *p_before =3D 1;
> > }
> > @@ -48,8 +53,11 @@ static int scan_hunk_header(const char *p, int *p_be=
fore, int *p_after)
> > n =3D strspn(r, digits);
> > if (r[n] =3D=3D ',') {
> > r +=3D n + 1;
> > - *p_after =3D atoi(r);
> > + if (strtol_i_updated(r, 10, p_after, &endp) !=3D 0)
> > + return 0;
> > n =3D strspn(r, digits);
> > + if (endp !=3D r + n)
> > + return 0;
>=20
>=20
> Likewise.
>=20
> > } else {
> > *p_after =3D 1;
> > }
