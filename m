Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84CD3F86F9
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937987; cv=none; b=WSonXdJtG4RZhjLQeGCz/pLoh+Ix8KlsxHIl0jgRlRtfDwKZ7kso0GsZLrYiE9aWamuozo+Em/EoGSMIZK1HFNF1tlo3Mqa5mL9xWDxDdgDia36Ea0ZSn7DTlIVkILE6YUg30549N8FYOQp13fEGP64W6XHCDZcLEQlLg44CTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937987; c=relaxed/simple;
	bh=es3gc5tjBDASS/Ke2AoNUQ159AGP+Fjh/tniTBb2fUA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ti2wfIGh413cjEQo1zwWb2Qbhfi/vCRPYOfITdVrdSkoCK+kh9Iy54kHN5+UQrfaG3elyud/WFd/iprvtIlBKnySzUBxi+rwgIv9Rj2P/GrcDo4lzsYXEzYksr5XYo+yHZJ1gOTPEvYIvk9lDWyXGkS2gw1XMFZwgP9mvE32Qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dyNx/VwD; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dyNx/VwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785937977; x=1786542777;
	i=johannes.schindelin@gmx.de;
	bh=IY9jjaI1NAf0RZ48lUaDrFdS3O5WpYWTW2drqDFMHQU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dyNx/VwDu4N55KirjmwUB4A1jycWMV3YNtAfAeDALX4NBLKpA2wiYKuvY0nYqOWy
	 aenYNSR29uUZfv318P1hxFoCD0VXAxTnJT8JmWuGqvmUbbrDUKxOqjnVBG+hNbcMD
	 PN71vzH07aqEE0Y9JnQWAz6O6FRPulTutAOVHHwAviXL/dvmW2woQL2X2u1z4B3cZ
	 fjXEBovqEBLZABF6DC4dA9zYhJGuTMr1rkkkoFxK042wrIAoI8is/kt8ZUeJ+z1+f
	 B4Gborn4aBZbFco0EVXeCaco56ApsAK01oD0XMlWHjFtUocRaXwXB9kG6DrvYYnGK
	 WFJfjvKuprao1h6dSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1xKOLh1Hh2-00ighs; Wed, 05
 Aug 2026 15:52:57 +0200
Date: Wed, 5 Aug 2026 15:52:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 03/12] pack-objects: widen delta-cache accounting to
 `size_t`
In-Reply-To: <anMA9t5w4386Rm3k@pks.im>
Message-ID: <413dc815-10c0-5708-f4de-5c99692e86ff@gmx.de>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com> <4ef28865498b33cebc954fccf18a3368f3d114b4.1783615780.git.gitgitgadget@gmail.com> <anMA9t5w4386Rm3k@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:7+tJaVErJjoLRccILKEUGB+/drmojaRYZoOevN7AP/OwdRO98VR
 AZOnOu/CU5iZ6gVb6PB6GykFamF+8QsulDe1wqBits4iVKEF4OCwg3kkFYAVYU/dL/pzKmz
 5mHX3lbS9S1lO2XKjRLlnFqRB10LAcYetjaTBSYYbFfEJtmiF/G0pYz9CrpOOrVEEZYivsj
 U8h9gosONztnhFesO+LLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OJ6MId9kNUc=;55K3gL4J8pnGJvBCu0qWLryODN+
 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
 wIAd92Y7oTEWP2sg==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 5 Aug 2026, Patrick Steinhardt wrote:

> On Thu, Jul 09, 2026 at 04:49:30PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index e3760b3492..f89628a760 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -260,8 +260,8 @@ static int exclude_promisor_objects_best_effort;
> > =20
> >  static int use_delta_islands;
> > =20
> > -static unsigned long delta_cache_size =3D 0;
> > -static unsigned long max_delta_cache_size =3D DEFAULT_DELTA_CACHE_SIZ=
E;
> > +static size_t delta_cache_size =3D 0;
> > +static size_t max_delta_cache_size =3D DEFAULT_DELTA_CACHE_SIZE;
>=20
> The only other site that assigns `max_delta_cache_size` does so via
> `git_config_int()`, so we happily accept negative values for
> "pack.deltacachesize". This will cause a change in behaviour here, even
> though arguably the behaviour both before and after this patch is broken
> in the same way.
>=20
> Ideally we'd have something like `git_config_size_t()`, or at least use
> `git_config_uint()` here.

Heh, I looked for `git_config_size_t()` and it does not exist, but
`git_config_ssize_t()` exists... Pretty inconsistent. Anyway, I added that
function and use it in the other assignment.

Ciao,
Johannes

> But that could potentially break the case where somebody mistakenly
> configured a negative value and took it as "infinite", which was mostly
> true before.
>=20
> In any case, our docs only mention positive values. So maybe this is
> something we could fix while at it.
>=20
> Patrick
>=20
