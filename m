Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B333E1
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070147; cv=none; b=nKodF7BOENNu3+eDZlOC1XzVh2IgORvA3P5tcTGII5vdeAIxcXiDDPAaWaDxP6mSuoPGQKHDcxVeXIT8U75bHnLvfdQkdLJdqG6elAUxoddMOi+kAUghcHP5bfziKtj9mK2Y+hb6r9XIZH6ZVTVw3we7I79oXc0LBvuT0SICLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070147; c=relaxed/simple;
	bh=2XEp/A02daPQwImkpuGhbwmUwGk2v91pUSh3GvUq1FE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ma3GdGEM57uTvPN/luAs4lIm8fIJLYYAy7o02DQHDhY0cKDEmDOP7PrOMvxPfISTgYNyu6FHzzqjENM37XJYieaFInzScr0Oacvx1RH8MWJVFwasH4cwPCJaKM5+NM1YrlBIbK11VG6BvspAp9AJCetpE1gVIitRpFDLmE3SCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gpu8mTjP; arc=none smtp.client-ip=185.70.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gpu8mTjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706070136; x=1706329336;
	bh=2XEp/A02daPQwImkpuGhbwmUwGk2v91pUSh3GvUq1FE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gpu8mTjPzVMRBuYDBae/GaflHWMs4o+mNH/aWwZ8Yf7+4wbe9TD9PDb3699AhAm2K
	 5FR5SpdwQo2PvTx0yMobxyWW0hzA2L6VeWfFYu+dvQydjYyX5lzOZWQcyx/O/c4HQn
	 Nzt0RplSdHqt8usRQff1+eyCu4cLCSVONqk8nk9TWXl5CbuYpzKBr/qHMhVMLXdOXG
	 W+dvCS09djz7eYEescSl4KljZNsBh65wmbSrQbXnWtWp9SbpM2VqKjfPvTDHDfxtec
	 6aPO0/Fb6Rkj4+E3iOdOTW7T+Z5T8V7+LmSwsX7dakMDEg6OjkhkBlDMt4B4ylWvNX
	 DLzPUSvkItkIg==
Date: Wed, 24 Jan 2024 04:22:04 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Mohit Marathe <mohitmarathe@proton.me>
Cc: Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Mohit Marathe <mohitmarathe23@gmail.com>
Subject: Re: [PATCH 2/2] patch-id: replace `atoi()` with `strtol_i2()`
Message-ID: <cwwH6NrWMc0fRUiirzvQmY-FoUS12K1SLSkBAbbu_QgAR7aDlvby6hgI_puXwtRSwX86zw6FQjUs1yHcPm8LcxuWhDnfG-4f0XRMjtTIVwU=@proton.me>
In-Reply-To: <xmqq8r4htb8r.fsf@gitster.g>
References: <pull.1646.git.1705913519.gitgitgadget@gmail.com> <1ece724b1ca7f71542bfef42795fce798563ecde.1705913519.git.gitgitgadget@gmail.com> <xmqq8r4htb8r.fsf@gitster.g>
Feedback-ID: 95862732:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tuesday, January 23rd, 2024 at 1:02 AM, Junio C Hamano <gitster@pobox.co=
m> wrote:

> "Mohit Marathe via GitGitGadget" gitgitgadget@gmail.com writes:
>=20
> > static const char digits[] =3D "0123456789";
> > const char *q, *r;
> > + char *endp;
> > int n;
> >=20
> > q =3D p + 4;
> > n =3D strspn(q, digits);
> > if (q[n] =3D=3D ',') {
> > q +=3D n + 1;
> > - *p_before =3D atoi(q);
> > + if (strtol_i2(q, 10, p_before, &endp) !=3D 0)
> > + return 0;
> > n =3D strspn(q, digits);
> > } else {
> > *p_before =3D 1;
> > }
>=20
>=20
> Looking at this code again, because we upfront run strspn() to make
> sure q[] begins with a run of digits and followed by a comma
> (which is not a digit), I think it is safe to use atoi() and assume
> it would slurp all the digits. So the lack of another check the use
> of new helper allows us to do, namely
>=20
> if (endp !=3D q + n)
> return 0;
>=20
> is probably OK, but that is one of the two reasons why you would
> favor the use of new helper over atoi(), so the upside of this
> change is not all that great as I originally hoped for X-<.
>=20
> Not your fault, of course. We would still catch when the digit
> string that starts q[] is too large to fit in an int, which is an
> upside.
>=20
> > - if (n =3D=3D 0 || q[n] !=3D ' ' || q[n+1] !=3D '+')
> > + if (q[n] !=3D ' ' || q[n+1] !=3D '+')
> > return 0;
>=20
>=20
> When we saw q[] that begins with ',' upon entry to this function, we
> used to say *p_before =3D 1 and then saw n=3D=3D0 and realized it is not =
a
> good input and returned 0 from the function.

Uh oh, I just looked at the `if` block and concluded that it was just=20
to check if it has numbers after the ',', which`strtol_i2()` already=20
does. But I totally missed this one.=20

> Now we instead peek q[0] and the check says q[0] is not SP so we
> will return 0 the same way so there is no behaviour change from the
> upper hunk? The conversion may be correct, but it wasn't explained
> in the proposed commit log message.
>=20
> How are the change to stop caring about n=3D=3D0 here ...
>=20
> > r =3D q + n + 2;
> > n =3D strspn(r, digits);
> > if (r[n] =3D=3D ',') {
> > r +=3D n + 1;
> > - *p_after =3D atoi(r);
> > - n =3D strspn(r, digits);
> > + if (strtol_i2(r, 10, p_after, &endp) !=3D 0)
> > + return 0;
> > } else {
> > *p_after =3D 1;
> > }
> > - if (n =3D=3D 0)
> > - return 0;
>=20
>=20
> ... and this change here, linked to the switch from atoi() to
> strtul_i2()[*]?
>=20
> It looks like an unrelated behaviour change that is left
> unexplained.
>=20
> > return 1;
> > }
>=20
>=20
> Thanks for working on this one.
>=20
>=20
> [Footnote]
>=20
> * by the way, what a horrible name for a public function. Yuck.

Yeah, I thought so too /:D How does `strtol_i_updated` sounds?

Thanks for you feedback! I will send v2 with the corrections soon.
