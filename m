Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E0134CC
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232667; cv=none; b=EAF+E8iN6b+iPt1wiOnThZSiQcuw+MmtpZ5nGunTpFvgXkLp6LN/E/LI1BArRaoMq5Zhjf73PEU0mwgelfZgtXR4a8VexkJXRT883yNZ/ykgvmN856stBrtNl4wod8JuGpPuc1N8IVqUtSZEYHxlUxahiBix3IqYjIisIiotbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232667; c=relaxed/simple;
	bh=qMcnfPZAZAFDKYosNuxHnAcK7xps3oH43lApugvn6gY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCHPHMPIWOHpIelw07YUoI1s3lMsms/iy14vb3h5yIPxNbvqziynznoMz4AvWBya1jI7+ql4SsUwW0v7izR//BB4qtaW37LcbfNQUJMgNo4Wz05Q3PPlpgE2jaDdFC1Qy+CIbGa2Aa9o1CjmrWAMhLpv56dh6bgniLPsFgCANv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IKIq5LjY; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IKIq5LjY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tblqc4J0DrEB/5XA/5Z+pljiQY2s1pLxd1MrCLFlQAM=; t=1716232665; x=1716837465; 
	b=IKIq5LjYlZBTKC6t+DtOd0cBU2/M/e/14JqVODEnMK4Cj5yk5EBf3NXABMI/eQJ+OLrehH5TDfZ
	eqWQ/4RCLdxCtFRIGIVelutSf+jExx53ZfZnWyHeSwFRrJNePYrt4QNRO9u4MOivZuP1v1NiVIt65
	gSAT4joF++gFqtW0aS0aG/MwxM3Q4rFQp8xmIaQRizeLQ/EOMF8X3ifC3M3oe/KwGBg4IzZ8nMMVJ
	DV0opym5fmqJugd+NpPFOsNHnmj7//ACh1HGqlI0ibU7vq0fnKwQD8fKxql8Fsq4gujlDAalKNQeD
	S27Xj6Cz1QDLsXK3j5wp+pKgxfYNQls8MBSg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s98Vy-00000001lno-1pK5; Mon, 20 May 2024 21:17:42 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s98Vy-00000002ScJ-0xh2; Mon, 20 May 2024 21:17:42 +0200
Message-ID: <277726443f533446be4391cf2aa3d487974a7a18.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] improve chainlint.pl CPU count computation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine
 <sunshine@sunshineco.com>
Date: Mon, 20 May 2024 21:17:41 +0200
In-Reply-To: <20240520190131.94904-1-ericsunshine@charter.net>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
	 <20240520190131.94904-1-ericsunshine@charter.net>
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

On Mon, 2024-05-20 at 15:01 -0400, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>=20
> This series replaces a patch[1] sent by John Paul Adrian Glaubitz to fix
> chainlint.pl CPU count computation on Linux SPARC.
>=20
> Unlike its predecessor, this series also fixes an underlying problem in
> which ncores() could return 0 which would result in chainlint.pl not
> processing any of its input test scripts. Patch [3/3] also fixes CPU
> count detection on Alpha[2].
>=20
> Patch [2/3] of this series is more or less Adrian's original patch[1] so
> it retains his authorship, though I simplified the regular-expression
> and tweaked the commit message.
>=20
> [1]: https://lore.kernel.org/git/20240520111109.99882-1-glaubitz@physik.f=
u-berlin.de/
> [2]: https://lore.kernel.org/git/503a99f3511559722a3eeef15d31027dfe617fa1=
.camel@physik.fu-berlin.de/
>=20
> Eric Sunshine (2):
>   chainlint.pl: make CPU count computation more robust
>   chainlint.pl: latch CPU count directly reported by /proc/cpuinfo
>=20
> John Paul Adrian Glaubitz (1):
>   chainlint.pl: fix incorrect CPU count on Linux SPARC
>=20
>  t/chainlint.pl | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20

Works as expected on my Linux SPARC machine running Debian unstable.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
