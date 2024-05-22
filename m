Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F346522
	for <git@vger.kernel.org>; Wed, 22 May 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367663; cv=none; b=eFc4kAEpJySuoLFffxTiNnSH9I24DbVowOC1yh8Qr4xkGgAeTDBRTtijasyrZi5nye6Qr6upLlYnFF3pSiGJQmvNWsG702JAGPMV0z7rEtBOctT1jXBfS0U/58R3QnMKOUdV96Y0HhjbChYHVYFacmJMwhsYOj+LhXDZGcp7m7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367663; c=relaxed/simple;
	bh=SlHpDwzbVqKtDR0uw0cGIAhu6DW+FGXvVDPJD5WcsiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJg8J6Lnfh/8a4Ui/8RiNYImAybd5AL621x+merbMGND6B9dHdq402wvzLSa7Cl2lKftb3Yi8/5N1VoNtgmlGqKwI0zrenvmZrQy4irFpBd03K85qBCGEtlCkWhc3BnGwW23AQ8SXtaF7rK3UZrSSBQsSF1i/0Ezpz8Q3pQPCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KQ4uxBaP; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KQ4uxBaP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r4HYLbB1bNSKUMNrNICCYNkgsl2v3gV3QUAb4dcQtdI=; t=1716367660; x=1716972460; 
	b=KQ4uxBaPPxPk/So8QQjO/4LKsz2/FGyBk1zd6IPRUCd9tHNhJlICyQ0CZmpQvXY3b6vAHp6vxzk
	0dZQHVjm671s3Fa5jowBe9WtMWu31Am8gPQW20XoL6oaE2G2nyIUPSDlotexRZ7E/eYEgMtM7HUWN
	vutsWuOChbTGApwhetIabdcpbTornBJehTz3NxOF5btqPIiORAEk1c9CP2RxX5KbvNs7RfkhCwuzZ
	Azz85u8umQm616ZvSRuCpOSfmLaeUOrvKo4Sx4tOp0vxRRUeOhzwJVCIOpAW5IoOEerl1huLVgWT1
	u5xDPnjfIpP5Jqe2bybemwAyDwXmPZJUZEUg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s9hdH-00000003Xgb-2S2f; Wed, 22 May 2024 10:47:35 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s9hdH-00000003WsA-1aQC; Wed, 22 May 2024 10:47:35 +0200
Message-ID: <d655399efccfa6219cd982035c0408f9f084e344.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/3] chainlint.pl: fix incorrect CPU count on Linux SPARC
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Carlo Marcelo Arenas =?ISO-8859-1?Q?Bel=F3n?= <carenas@gmail.com>, 
 Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine
	 <sunshine@sunshineco.com>
Date: Wed, 22 May 2024 10:47:34 +0200
In-Reply-To: <m4xqop5u2a4okzr2svg7j57ey5x5fyfqrqitwwzhh4uansuu7v@uy4tznnci6dy>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
	 <20240520190131.94904-1-ericsunshine@charter.net>
	 <20240520190131.94904-3-ericsunshine@charter.net>
	 <m4xqop5u2a4okzr2svg7j57ey5x5fyfqrqitwwzhh4uansuu7v@uy4tznnci6dy>
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

Hi Carlo,

On Wed, 2024-05-22 at 01:32 -0700, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> On Mon, May 20, 2024 at 03:01:30PM UTC, Eric Sunshine wrote:
> > From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >=20
> > On SPARC systems running Linux, individual processors are denoted with
> > "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:".
>=20
> not sure if worth a reroll, but the "usual" syntax is "processor  : NN"
> the regexp used checks for numbers before the colon to account for the
> syntax used on s390x which is the only one with numbers before the colon.

Good catch. I think this can just be fixed by whoever commits the patches
or is that done automatically?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
