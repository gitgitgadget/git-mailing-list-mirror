Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FA17E8ED
	for <git@vger.kernel.org>; Mon, 27 May 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839395; cv=none; b=V5uBPqqV5xL+B90JjDGSNZ7dRMhibgbQdXgtdaQvb8MtTORc7VnV92Vh1DbHDE2J/sIc6ZnkuDZgnd6WvxsecBMweJUTW+lrVtTmSLejil9ArFCY51I11uYv8FUNIka5tMTxzZlc3ETv+DY3qtD4UcNHU+LwW2AItcF/AyQWybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839395; c=relaxed/simple;
	bh=2bQ8ncL5isPVxly6yXXI9HpabFIzKWiQo3QNUoULP4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8NM+DcvOw2qzCEPNf+OYSoIde5o7bblY4NCVl8vKgvvGdADp46n9znuPoD7zLhwnASGPNBXILIzFm2PSFtTSxSkyq32NA1djJc9V170rmdSZwXI8prGZdcEhW/pbuLSMihQQKAe0atJ+Tda2yhMVdr7TDkbyMY1QMtvB0J/EIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=pku/Hcre; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="pku/Hcre"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G1YkJPHTViy0CJkqY1a1bJbDVB3yj/E7dUQYJ2gK2fA=; t=1716839392; x=1717444192; 
	b=pku/Hcre71Cn/bOyamX1vGUb4xc/NulDi5ZG8YB1WcvCtdw8t8rGSIHD0sseQNYeDGrrbqSDdu9
	XRMxRbP1MXVb8Spdr+IP0z9A25kFDGNMfX8ZigFsKr8QUmoHMg7cm5gX2y+MnTg93Iwx02tqpxuy/
	z1os167xrnBT4j81b8TvwY3y3UL8tcknQvRW7O9iYLgf/4OlAQIXTixuJM2lFg7DXx2fIzaSLqlwL
	pP26zDLk2e3mtfEZqIQ8XaHD8h2bq9iw8eXi0HUd4VRdv28RhJZ+4BBIvuFERh2h+FVnRVlZS08T9
	di2W87nA2BElxZL98XMO9Rt9FevchVdk0U4w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sBgLm-00000002bAf-045s; Mon, 27 May 2024 21:49:42 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sBgLl-00000001tNw-3KCj; Mon, 27 May 2024 21:49:41 +0200
Message-ID: <518a5c2f34180ee2e6b674d8dc5a66b8a2d345f7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/3] chainlint.pl: fix incorrect CPU count on Linux SPARC
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano
 <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?ISO-8859-1?Q?Bel=F3n?= <carenas@gmail.com>, 
 Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Date: Mon, 27 May 2024 21:48:59 +0200
In-Reply-To: <CAPig+cTxMTAf85Gyi5eEYAM4pOTq2UTD1=oCVBy1q8aSF3cn6Q@mail.gmail.com>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
	 <20240520190131.94904-1-ericsunshine@charter.net>
	 <20240520190131.94904-3-ericsunshine@charter.net>
	 <m4xqop5u2a4okzr2svg7j57ey5x5fyfqrqitwwzhh4uansuu7v@uy4tznnci6dy>
	 <d655399efccfa6219cd982035c0408f9f084e344.camel@physik.fu-berlin.de>
	 <CAPig+cTfqk+tbTAVyPj8YP1uHx1D1swL84h-4p6OKBV=dDRX_Q@mail.gmail.com>
	 <xmqqh6ep4qoy.fsf@gitster.g>
	 <CAPig+cTxMTAf85Gyi5eEYAM4pOTq2UTD1=oCVBy1q8aSF3cn6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Wed, 2024-05-22 at 15:11 -0400, Eric Sunshine wrote:
> On Wed, May 22, 2024 at 3:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > > > > "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:".
> > > > >=20
> > > > > not sure if worth a reroll, but the "usual" syntax is "processor =
 : NN"
> > > ...
> > > Inclusion of the word "usual" is such a minor flaw in the commit
> > > message that I doubt it warrants a reroll and the associated cost on
> > > reviewers and on the maintainer (Junio), especially since it does not
> > > negatively impact the intent conveyed by the commit messages nor the
> > > correctness of the actual patch.
> > >=20
> > > As such, I'm not worried about it. Whether Junio reads this and wants
> > > to correct it in his tree is up to him, of course.
> >=20
> > I think "usual" is not what was pointed out. The order between the
> > colon and NN is.
>=20
> Yes, I understood that, but it is the word "usual" which makes the
> text "processor NN:" questionable since "processor NN:" is not
> typical. Without the word "usual", stating "processor NN:" is not
> especially problematic since the existing regex (which is being
> changed by this patch) _does_ match "processor NN:" (among others such
> as "processor:").
>=20
> If we want to be more accurate, better wording might be:
>=20
>     On SPARC systems running Linux, individual processors are denoted
>     with "CPUnn:" in /proc/cpuinfo, however, the regexp in ncores()
>     matches only "processor:" or "processor NN:". As a result, no
>     processors are found on SPARC. Address this shortcoming by
>     extending the regexp to also match lines with "CPUnn:".
>=20
> but I doubt it is worth a reroll.

So, could we get this series merged now or is there anything missing?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
