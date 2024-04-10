Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20313D8A4
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738868; cv=none; b=mv1KFhoWm+VhSCLecr50DMi+2bDH6n0qp7gcV/LhYCdwKdyQFZfGix1GAuzU0r/LL0TF+rqyNH10fPBYx8R9WHvj8+hgpogupK1AmgQmwyHkrR/+ofr6Azk0Fpq/z+U//tsFgUp59lmHzoFC2SjJtTosihLzZbFnoxEXb1g88oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738868; c=relaxed/simple;
	bh=r3W73Pnm3ggVG7qbY5h4b7pttQECyTyZ0ze4KOx9v0M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbvzAA98uZMpV8cEqXrl012dJ4arKUSCSIG9k9CXyLHm1jv+NIF459r3VCn3GJgRy9Md5rK20BPye31m/3+nkbl0274isRkZ9xrjSK86wLzWMK1abUT4a5OuWduyNMaWxVkhhslzoVDejFycYXfiScY00xmwVePW0xIW4E7qN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=LF+cdy64; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="LF+cdy64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712738856; x=1712998056;
	bh=CpyKzTquVYVXP6NGheyPIGKMdF3fx6Uz5IDoKcrx/RM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LF+cdy64S0bl2co7vXryvVrIWc8svTMm65ivgVzwmbP1cbQ32/C3yh6k72EJfqNOW
	 Wfq2h8jHrfrLDOCPwc8SswYKjUwrxcig390xsr/HLuIp6iWDNuBUH7M6CVzEulpiRo
	 93EHcuGQhO1hJVIWyozuU71hGX5skyxLj1+wbGJZK+IdU5MNr2HVVwHzAJNde8HcIQ
	 T4xGtuQ5MoVrzC8ZqCRR7CG3ApzkrDMrpeJ97/IzOxMLnBRuBLhM/eqcQaB01Jtcnx
	 acB+KdUvj47io/g94Fx0u68rxnzR7D2kxJD/uKYt6op6XS8sY+WJRPny5FFCZLOfGV
	 zUyrwr/vWLFpQ==
Date: Wed, 10 Apr 2024 08:44:49 +0000
To: Chris Torek <chris.torek@gmail.com>
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/8] fast-import: tighten path unquoting
Message-ID: <784B5318-F155-4D93-8085-62ACA63432E5@archibald.dev>
In-Reply-To: <CAPx1GvfgC46n_5fk3dHxg7dn393UVMi0CtHKqQ_GAaqnV_ECCQ@mail.gmail.com>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev> <ZhYxNYR33ftEfcPk@tanuki> <CAPx1GvfgC46n_5fk3dHxg7dn393UVMi0CtHKqQ_GAaqnV_ECCQ@mail.gmail.com>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Apr 10, 2024, at 01:18, Chris Torek <chris.torek@gmail.com> wrote:
> On Tue, Apr 9, 2024 at 11:30=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
>>> +             if (include_spaces)
>>> +                     *endp =3D p + strlen(p);
>>> +             else
>>> +                     *endp =3D strchr(p, ' ');
>>> +             strbuf_add(sb, p, *endp - p);
>>=20
>> strchr(3P) may return a NULL pointer in case there is no space, which
>> would make us segfault here when dereferencing `*endp`. We should
>> probably add a testcase that would hit this edge case.
>=20
> Note that you can do:
>=20
>    *endp =3D p + strcspn(p, " ");
>=20
> (though `strcspn` is a fundamentally harder operation since it
> takes a string argument). Everything depends on whether you
> want to test for an explicit "there was no space at all" case of
> course; performance considerations are secondary.

I thought strchr returned a pointer to the terminating NUL byte if the need=
le
was not found. Turns out it does return NULL in that case, as you say. strc=
hrnul
does what I want here and I=E2=80=99ve replaced it with that.

I=E2=80=99ve added a test covering this case.

Thalia


