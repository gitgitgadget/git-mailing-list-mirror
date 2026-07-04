Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5603A2E36
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783155538; cv=none; b=b1i8Ydm0CxNUQz5aZWImcbrKgVke69bYV23kZRMdvrA/4CKT8Xj69WcAlojE2wER5CZ0w9WmyFLN80RQNJh1zy4dME+zxAghU0iHfR8pkxezq+OPtvVWazbL9HMqmyE08QExFLyC81xflVRmBkCzKry8W7FEoNYRUF4wBwTZ+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783155538; c=relaxed/simple;
	bh=tu8b2lXbXKv1pu8Ab5sT6M8wqWXFureEGyphT+2GjiM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YeqWfIS1+xk6ouHFO05GtwStOYVwDdlToXWNQg3k1hSGPirUg1cyBzPhwZbHcvk2uszLuQ7T3mjTPO0+HksKx7+Q33i0hcH/gRDC6Xjnc4moS98PZs2L7T00MtbGl6tK0PGUOZZb6UE1BwSka98btSYvro3X9w3+BUd3qs5JcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Y5O4I1Od; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Y5O4I1Od"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783155535; x=1783760335;
	i=johannes.schindelin@gmx.de;
	bh=Mgqbfb2n/K8EB20Uomu6nSqnHnvRg38pqZHtFhby33I=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y5O4I1Od/9Kd3OCAJQQfCS8BId1ZqOtlRZzE5SuBbvtpnXJlSOaVV1VLWBGnF2Fo
	 e73WVOAGePStJwAGdfTE/CExGC1h2YvhE9dAiJUGYqiUj42BKtdEYZUrOelQDm6/l
	 GzNjUZsm1Wc6H6u340Va13W1T/sEpk/su5+lmYIoH3xElZIe4VYr/teDzGGkxM0jF
	 HcV1deCHOOhrEwcXA5pbqmLVwsI29E8hLgsK5ygqrtja8IsbM9SDZIGjCAAkmliUI
	 fH4iDsrjCAWPs9ZBU/xEK4PtcGbZZjsXqt7xCIFOaFbfmU/87H0ipqcI+PUe/QbTO
	 e//fSjS2YZSxp+76yQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1x2IO43Mlm-0187BW; Sat, 04
 Jul 2026 10:58:54 +0200
Date: Sat, 4 Jul 2026 10:58:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 07/13] dir: free allocations on parse-error paths in
 read_one_dir()
In-Reply-To: <akTIOeXFhNjJ7V3i@pks.im>
Message-ID: <0278c01a-5a7d-e6a4-bee3-4df6df7e5276@gmx.de>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com> <62ce03454aa1928edd8fa538e0600155629939cd.1782889472.git.gitgitgadget@gmail.com> <akTIOeXFhNjJ7V3i@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:fFt2boaMfJ9FbvSybKKu67DMII6tqTFB8SR6ilOAhXstewz6Tb3
 XATWsw/1QEYqZN9nzyeUIncKqrjCOTDRSE6rw7AnijNB9+iUT7Ri4pneqF3uh9hbkgyP0BV
 6jbNTHYrN9kF5w4kUO/6s1WU+0ERECh4H91n6bqae3QuQ6ff1PxBbRtV63Y4aKGR6BSKxY3
 ekqTlU680pKF4CuFIouug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oTGNkMZUtRU=;vK8plpWP8WiMyLjPBPiFfS5MX5X
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 1 Jul 2026, Patrick Steinhardt wrote:

> On Wed, Jul 01, 2026 at 07:04:25AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/dir.c b/dir.c
> > index 32430090dc..23335b9f7a 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -3792,13 +3792,18 @@ static int read_one_dir(struct untracked_cache=
_dir **untracked_,
> >  		ALLOC_ARRAY(ud.untracked, ud.untracked_nr);
> > =20
> >  	ud.dirs_alloc =3D ud.dirs_nr =3D decode_varint(&data);
> > -	if (data > end)
> > +	if (data > end) {
> > +		free(ud.untracked);
> >  		return -1;
> > +	}
> >  	ALLOC_ARRAY(ud.dirs, ud.dirs_nr);
> > =20
> >  	eos =3D memchr(data, '\0', end - data);
> > -	if (!eos || eos =3D=3D end)
> > +	if (!eos || eos =3D=3D end) {
> > +		free(ud.untracked);
> > +		free(ud.dirs);
> >  		return -1;
> > +	}
> > =20
> >  	*untracked_ =3D untracked =3D xmalloc(st_add3(sizeof(*untracked), eo=
s - data, 1));
> >  	memcpy(untracked, &ud, sizeof(ud));
>=20
> Hm. Here we assign ownership to the caller, but this still feels quite
> off to me as we also have two more early returns after this point that
> seem to leak memory. Do the callers make sure to always free the data?

Ownership transfers to the caller on the `xmalloc`/`memcpy` line: the
`memcpy` copies the `ud.untracked` and `ud.dirs` pointers into the freshly
xmalloc'd struct that becomes `*untracked_`. From there, any subsequent
failure in the caller reaches `free_untracked_cache()` and then
`free_untracked()`, which releases both arrays. So the two further early
returns are correct as-are.

I will fold that reasoning into the v2 commit message so a future
reader does not have to re-derive it.

Incidentally, and orthogonal to Coverity's leak report: on those same
failure paths, individual slots of `->dirs` and `->untracked` remain
uninitialised, so `free_untracked()` walks garbage pointers before it
ever reaches the two `free()` calls above. That is a separate
crash-on-cleanup bug and I would prefer to address it in a follow-up
rather than widen the scope of this series.

Ciao,
Johannes
