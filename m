Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D635F170
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055880; cv=none; b=XBno85HA5FP3/zhw6COgFshbjXM89q3SZr8agd6N1y6mdxNgbRwtqP5hEBkyBA0Zvkg7vsjP85aUTJYj4jMpkSlHUhvlIXS1bdlbkV9sFNPdCZ1j1fSyJhL9+yDfr//h+UMWq//BegvJJZ4hdo1yblAGRvPHFr2DPgkdKFV9fjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055880; c=relaxed/simple;
	bh=hCN1DuXuOULr7CksnHNnxMwpvRtNu2j4YtFIVvver48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbGN+mDFLIGGfc9aHxpdMjZQKJt8m4smgPKo9KEyJFOpjOwYuHC9EZzSxpK174H5x5+ZZ9StL1+IR0R6x4VFUOxFXuAugL7LLoSRKB56xrtgAi0dp1d4u95jofZB4CJNcGYnDjGfHpyy+J3Z9ciSFXEk5gPKQCwGuJed/ZOmt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=icq8c/RZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="icq8c/RZ"
Received: (qmail 57023 invoked by uid 106); 26 Jul 2026 08:51:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hCN1DuXuOULr7CksnHNnxMwpvRtNu2j4YtFIVvver48=; b=icq8c/RZOvhIs8TmeOIX920fufgVFII9E1IFodSrh2a5SgdwurzUS7Z/+JhkLoTPjhhm943pI5ut5lbw8tQGDbB+CWOeBSO/6eIRwApjFTUZFoGAQWkwGC71zECdyKQyvII92Qap+QwgKTqpBC3OzSwfHAw6Gx7kG4PI//Z/3SUJD5lcbj5zEcsHUjgvo/dubEEJtyboTCiGOSHBuBhXB4vFPYt7/Cvb5xlTHT1hPQ8+Jo/d/AbpjDssd3GEH5ZVh9ahLfxC0QQmhx4QptWK8MqUA9Oj6Q6qX5hasB1zHqjPStWvHAnT5sZEKEAYCCqIF5QihnYl6LMI43VRIeODlA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 08:51:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 58038 invoked by uid 111); 26 Jul 2026 08:51:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 04:51:22 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 04:51:17 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	git@vger.kernel.org, jltobler@gmail.com
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <20260726085117.GA3529599@coredump.intra.peff.net>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
 <xmqqtsps76f1.fsf@gitster.g>
 <amCuLpT6vYzo1GF8@pks.im>
 <xmqqh5lrrplt.fsf@gitster.g>
 <20260723104943.GC604358@coredump.intra.peff.net>
 <amLgMqkqxR8mKIbT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amLgMqkqxR8mKIbT@pks.im>

On Fri, Jul 24, 2026 at 05:46:58AM +0200, Patrick Steinhardt wrote:

> One other angle that Justin and I have been discussing (we were at an
> offsite together over the last couple days) was that we can do a small
> course correction: instead of handling alternates on the ODB level, we
> may be able to start treating alternates as an implementation detail of
> it. So both the handling of alternates, but also the handling of the
> GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES environment
> variables would be moved into the "files" backend itself.

That seems reasonable to me. In theory it could lose some flexibility if
some code really wanted to represent alternates as abstract sources, but
I can't think of why you'd want to do so. Traditionally we did not even
really have separate sources at all, and the point of adding them was
not so much to have arbitrary combinations of sources as to abstract the
details.

I guess somebody could want to use a local alternates object-dir along
with their sql database of objects or whatever. But even then, it seems
like the alternate could be added as its own files-backend odb source.

> This would solve a bunch of smaller issues that we're currently
> grappling with where some of the concepts in Git really want to operate
> across all of the alternates:
> [...]

Yeah, that all sounds like a positive direction. Thanks!

-Peff
