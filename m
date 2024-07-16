Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E780139D00
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166039; cv=none; b=Pz27ZYQU9ik+uEaju6Xrukm2mVa6aklTguxhMJemaP4L9vLMvQ955xcUtedH920dZgLRHI7pTcg5mx4wPPUYr1gfM3I/E3aS/QnKReWOMwd959PtdKRIxyruR+DtmhtpfbklNIniLHE/0S6eNfMWfligjyhp9qvwuT1wiClTHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166039; c=relaxed/simple;
	bh=buApJPshbEtnCMgyStc/bofQVtXP/zPVY2/a2eU7bac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZaJtQGIvqUVrb48oGy4m0zw/BDv12hkPSL2OlMlm/3pLMMF0SyCRZhOh0fJlpKJT0md3cDAqMBYcL5x49Iv8evi54+PBNiEFePfkuYSwMCaQqAGjJoLry13aaJg7ty0oa7S+86T98FHKCvTblHWZvzsGzN6eMRg0I8swB/kavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=f4vQtoX+; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="f4vQtoX+"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <psmith@gnu.org>)
	id 1sTpuU-0002g0-Q9; Tue, 16 Jul 2024 17:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:To:From:
	Subject; bh=Bw4k1SdkpSVuQ2Gg3GPvv6qm+tjxTb1S14gYWpt7CXs=; b=f4vQtoX+yP9gQuMwm
	5stvjjPOqT3Dn3zvfcGEq5ImJC9rEhZmZ07cp6lejrBkiOqyENAeahaLgl1BNw+5Xo1EXxIIt3qwl
	7qrWJwsFyk6OiWXxyG2d5yC0LcmzBR+1ugHqj55xyrIXM34hHwxyTa5BPtgggJCGIVrVO12Vt9Bdj
	fYgifxoDMUsOTOH3bCjbFR7OFAYu56r4bBFjZafW1a6RoH/QovssN6ZWONrqGgjzWNTnaJb1wtVs4
	f0Zw349F3CJGHpX9UOF5+nbwwTFQHEk6KtW4JfPLn1GQImYypVkzaBbJL+t35jdMpvONUka67aR/r
	vkTnGsgMns2m3WAbw==;
Message-ID: <d98f82b8b6434c47fc2d9a4ecc870fef336a9e5a.camel@gnu.org>
Subject: Re: Can dependency on /bin/sh be removed?
From: Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To: Andreas Schwab <schwab@linux-m68k.org>, Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Scott Moser
 <scott.moser@chainguard.dev>,  git@vger.kernel.org
Date: Tue, 16 Jul 2024 17:40:33 -0400
In-Reply-To: <87jzhlf2i4.fsf@igel.home>
References: 
	<CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
	 <xmqq8qy21k9f.fsf@gitster.g>
	 <20240715235212.GA628996@coredump.intra.peff.net>
	 <20240716192307.GA12536@coredump.intra.peff.net> <87jzhlf2i4.fsf@igel.home>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-16 at 23:30 +0200, Andreas Schwab wrote:
> On Jul 16 2024, Jeff King wrote:
>=20
> > Again, it's possible that we could detect that no shell
> > metacharacters are in play and do the word-splitting ourselves. But
> > at that point I think it should go into run-command's
> > prepare_shell_cmd().
>=20
> This is what GNU make does (see construct_command_argv_internal), for
> performance reason.=C2=A0 But run_command is probably not performance
> critical.

Also I would definitely not recommend anyone look at this part of the
GNU Make code for inspiration.  It's an unholy mess.

The concept is very good though.
