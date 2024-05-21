Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEA12F392
	for <git@vger.kernel.org>; Tue, 21 May 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301744; cv=none; b=ozc2EOleymXwYR3eo6L5uxZTbh3IWK8PXPJG2Ske50F3xUGe0O4zO4ZUWqpU3/Z6vK282Tqk2KXgU+AWRYSFIxM9hGnVbIsDp2RZzPuJd8esZf4Ihgp3uQ/DdToxjkGnzzf+yzBkOQAKZ/5KMjoJbYP4kiorbEwqzqFXX6eurLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301744; c=relaxed/simple;
	bh=XXgEIvZHnn39u3HftsPVubD5xfjfOFlqrzPSYOJR03U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3+eGTx/x3kVtkneuylsnOJ10iryIq0EyfVAh1ESSHlPAXYTxz8jN7e0gsBeCDBWS0zN/tXJzWvp+4jB/BU6YhPtkNn5HGNTUyupK7rH8To1wp18CtFBUdtpEGf4OU+bjFJOS+CUjcp5xF9pAkeegAGLo+DkcB77Vi4kOJKbCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=LbHolcHw; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="LbHolcHw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cBzrbS/IA0jzo90Z2ntdyDhRLIJhXkAjuXVFFwsm4X4=; t=1716301740; x=1716906540; 
	b=LbHolcHwth2fHsgx3gQZlU3Wirz9PAVFLsGrqTjtDN3Xpj9eKJonfILZs/ieHZ2eNvHaadaexcc
	PXHBLGrB+AMlsetQ3VjSTSP9WdM5nuLC3idMxSNUt9l+WKhSAcqy2T6ZagJFO1jTatNMkSI24IzE5
	goAzK6w2YYtNO4pJZk6tW++5keKrUDozR8t9davEuaMFYQD++5vdlPW9HsD4OUa1VCG24Pw4lON0T
	v2crXna5Xli1KLSNfKgMncPvAd/VHYLobHFiSsa5ybvP8Yjecu3mBW1NpYD4Jf0y3Dn0ZiXiACYqk
	40tI6BHUXnE1C0vj9DGZZgb/2vIxF6V7L5/Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s9QTz-00000003hjm-0Hcl; Tue, 21 May 2024 16:28:51 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s9QTy-000000012ww-3ait; Tue, 21 May 2024 16:28:51 +0200
Message-ID: <6861baa7663cc6cb78bb2e0be664c07530d179ab.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] improve chainlint.pl CPU count computation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, Junio C
 Hamano <gitster@pobox.com>, Michael Cree <mcree@orcon.net.nz>, Matt Turner
 <mattst88@gmail.com>
Date: Tue, 21 May 2024 16:28:50 +0200
In-Reply-To: <b3bef1539c4f81780b5f705e55b12898cb084254.camel@physik.fu-berlin.de>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
	 <20240520190131.94904-1-ericsunshine@charter.net>
	 <277726443f533446be4391cf2aa3d487974a7a18.camel@physik.fu-berlin.de>
	 <CAPig+cQYJL+6J9PJX-vrNRXJ4TUCJCQRDQstUnPf4OOwOVCUnw@mail.gmail.com>
	 <b3bef1539c4f81780b5f705e55b12898cb084254.camel@physik.fu-berlin.de>
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

Hi Eric,

On Mon, 2024-05-20 at 21:23 +0200, John Paul Adrian Glaubitz wrote:
> On Mon, 2024-05-20 at 15:19 -0400, Eric Sunshine wrote:
> > Thanks for testing. Were you able to check whether it fixes CPU count
> > detection on Alpha, as well?
>=20
> I can test on Alpha, but that will take a little longer as I don't have
> my setup ready. Will try to report back by tomorrow.

I have tested it now on single-core Alpha and it works as expected, so I
think it's safe to land the patches.

I currently cannot test on SMP as I need to build a custom kernel for
that first which disables a problematic kernel option.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
