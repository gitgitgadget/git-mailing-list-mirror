Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382136728F
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609611; cv=none; b=GPRy2PJ4O9kWW+P8vOgdQrJgCAFnowy7zRSvgviYi7rltHFU+Mrs9+XbZRTHyWRprmp+qG5XONosxwjiUvU+fJNTj2lk4iaJR7U4eaiLbMo6Ect/mOH3FXyUg3mW4Jiw8hwSJJgoM3y1yrjrDJPE3b6zw7SHrY9GzIBAjXG50Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609611; c=relaxed/simple;
	bh=ojQC2J+nr0Y1oiJ29anaC4NsKhFv+1NQ9OxdijOAg4o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sbvVEtWyquEkApT63mUoxz82nSWWE3/cQRf+6UHZ+sjfPgF1TmwpCh6EIYxAxqrE0cELiVqubaSqfxoG3LwNoN8069924rRDCIw1Vj2Ja5KYacbmEXNlqMsufWj1diI86Sb9870Gzm2LnbN+59OdhAAWKh3BoBiOT4G9a53P2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=toHlk270; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="toHlk270"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786609602; x=1787214402;
	i=johannes.schindelin@gmx.de;
	bh=bIk/NsOvtvriYuR1JWERyimfS+Bsfk1n+v6EDB7gus4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=toHlk270MbbMgTolQMhrzGP2nKK+63WHUdxfVJrW00jCOUXVM/ufkkI3vDqtP934
	 WRlrZDw5tfT65OaA2p3BbOzmpm0HEGZC2sApZRRuq3+NNxVjdcavD8ZCD8nJkIJEa
	 YzO7QhGMEZSfwwigo5QgnWpknWMbafUNwn0EjvPi4ll2oroWqAAH/cimf3IhsbYjf
	 DuZl9qAxiBBNu2cNKOCc2mNjp1OqGah5ve/I8O0GD3UuV9MiLyjHsoAienYdniex/
	 0zs+P7+ZKiwwCYHdP3UwPZm0ohB/MVl48HvzwbOatUlIaR3b2+emJ1NlCft3eJj+i
	 x/PySHlB8SOS/cbkig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1wZzwd3DsU-00NVbc; Thu, 13
 Aug 2026 10:26:42 +0200
Date: Thu, 13 Aug 2026 10:26:40 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
In-Reply-To: <xmqqfr0jw20t.fsf@gitster.g>
Message-ID: <14489f51-fa34-a354-47a5-be64da968835@gmx.de>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com> <xmqqfr0jw20t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=8323329172337173817866096021863
X-Provags-ID: V03:K1:e1Ccq8cQN1axaK2UV7kW5ui4tEcumLkSDFXJs2zdc0GOlkZq9PA
 aP7vdS1Z0QFWYzFKvBahEPfsjgn9MIPqm22orVRStfT7qXPOEImsxyQqDv9CO3+0p82X54G
 u5uthUMXjdP0Dg/LwFeFK4/EB6/rt46XiSz33cQJqztg1Vus7XDC4RRj2Frih77xSYLat42
 8ue+p8rV1DrV+kKTGE0nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xpSR8kfWMes=;qtS6Fkcn3u7t+8qIEwUjrjSOBbY
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329172337173817866096021863
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 12 Aug 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > In one reported use case (https://github.com/microsoft/git/issues/970)=
,
> > N equals 37,815 and caused a slow-down of a simple `git rev-parse
> > --short HEAD` (which is regularly executed as part of `GIT_PS1`) from
> > 0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
> > increased from under 2 minutes to over half an hour.
>=20
> Face with Rolling Eyes (1f644) =F0=9F=99=84
>=20
> As we grow older, more and more extreme use cases that we initially
> thought were simply crazy become reality.

I have to take back the claim about the clone time, the hunt for that CI
regression is still ongoing, and this patch does _not_ fix it.

Ciao,
Johannes

>=20
> > Let's fix this by establishing a fast path for known-new packfiles.
>=20
> As long as the caller reliably knows that the pack it has is new and
> cannot be on the list, there is no reason to cycle through all the
> packs in the ring to attempt removing it in vain.
>=20
> Clever and clean.
>=20
> > diff --git a/packfile.c b/packfile.c
> > index 0eee45055f..f80f05a1fe 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -781,7 +781,7 @@ void packfile_store_add_pack(struct odb_source_pac=
ked *store,
> >  	if (pack->pack_fd !=3D -1)
> >  		pack_open_fds++;
> > =20
> > -	packfile_list_append(&store->packs, pack);
> > +	packfile_list_append(&store->packs, pack, 1);
> >  	strmap_put(&store->packs_by_path, pack->pack_name, pack);
> >  }
> > =20
> > diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
> > index af173a7b73..4221f9dd70 100755
> > --- a/t/perf/p5303-many-packs.sh
> > +++ b/t/perf/p5303-many-packs.sh
> > @@ -141,4 +141,8 @@ test_perf "load 10,000 packs" '
> >  	git rev-parse --verify "HEAD^{commit}"
> >  '
> > =20
> > +test_perf "abbreviate with 10,000 packs" '
> > +	git rev-parse --short HEAD
> > +'
> > +
> >  test_done
> >
> > base-commit: 11c6700f10234578d10523faf35656ca491425c9
>=20

--8323329172337173817866096021863--
