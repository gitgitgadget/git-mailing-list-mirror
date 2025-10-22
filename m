Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D0311972
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123954; cv=none; b=O35+1NcXufp8JBmV9MXFaVsPPyV6TmVQWehwe65XdTgBcgsM8AW7iG+dFvey2iUQOaxG+R8KYwmuUo73AgIAJyB1v75kQRROUQNIEFst0rseqKG0CrrWW0Jjg6jhRqxcJznvkLcKoImR79ACG7++ZaMFkGCDyyhn7ezoiz5D4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123954; c=relaxed/simple;
	bh=Uu9jDd1qzfcw/86LzJ4P2F1OzrtqjfM0f9DPLcjdeP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+2x4iiUo/M05TgcFUZCOEE9ZYt06biDj2fBaC/ST79o6wbkf+ClQ8ntnY3KHW/yBrykFRMYRgYZp3U4KozR0gOXJanYjaT3vjlsbmQPUzStft7Krqht5itiIbPc9omE5XFu+o7sD9tzm1uUaTWpmZ0k0h9aToa/jlCd57S6n2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=goRwb1KI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="goRwb1KI"
Received: (qmail 303028 invoked by uid 109); 22 Oct 2025 09:05:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Uu9jDd1qzfcw/86LzJ4P2F1OzrtqjfM0f9DPLcjdeP0=; b=goRwb1KId3pzS88stbiuJwVEKnessp2BSczWCMMiX7d4nc8QtcRpN1jjd2YVb7t4YWiXDd4dcZGMChe/Z9fg9xFCHeVSQvvzE8O5YzNK5Z5wksNrt32cjQI4wahUH5xvk8FMTT7hgGr+A8DOSJdreWODlzseRxZaKQIHJHNyQya4b2feu6mE0xeFE0SC5kk3tPdOHP8WZJ4u4NXQsve9aMo4rdAOFQZ11PESdZ7WEloeKCFVvlvurK+07FsZWtYDUYHkUWvpRGIG39wLR8F7F1F/7wbvoNt2iFd025Q2mzWfwmvjAjpUc4DMt5jSFTmJ6JxGdMzmoJbMhK9J70KpFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Oct 2025 09:05:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 472141 invoked by uid 111); 22 Oct 2025 09:05:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Oct 2025 05:05:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Oct 2025 05:05:39 -0400
From: Jeff King <peff@peff.net>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] macOS: queue for munmap operations
Message-ID: <20251022090539.GA853931@coredump.intra.peff.net>
References: <pull.1993.git.1760999702581.gitgitgadget@gmail.com>
 <20251021080625.GD259661@coredump.intra.peff.net>
 <CAOTNsDxoSFTBwaO0Eqr+r0NQOwdA2Fge3CN7JQtnAWEt2PnDew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTNsDxoSFTBwaO0Eqr+r0NQOwdA2Fge3CN7JQtnAWEt2PnDew@mail.gmail.com>

On Wed, Oct 22, 2025 at 10:21:32AM +0900, Koji Nakamaru wrote:

> > Ditto here. I'd be curious how well packed the repo is, and how it does
> > after a repack. If it has a very large packfile, you might also try:
> >
> >   git config core.packedGitWindowSize 4G
> >
> > or similar (though for just an ls-tree, we should only be looking at
> > tree objects, which in general I'd expect to be in a confined area of
> > the packfile; so the 1GB window is probably plenty).
> 
> Following your suggestion, I investigated the number of mmap calls in
> other environments and found much smaller counts. I tracked how
> xmmap_gently() was called in packfile.c and found
> settings->packed_git_window_size was different between environments. My
> ~/.gitconfig defined "packedGitLimit = 128m" and this caused many calls.

Ah, very interesting. Yes, I think that helps explain why there were so
many mmap calls. I don't think there's a good reason to lower that
number in general, assuming the OS is reasonably good at dropping mapped
pages from RAM when there's memory pressure.

> In my extreme cases, this batching makes them faster. Queue flushing has
> occurred several times for the private repository case and not occurred
> for the Linux kernel case. Though I haven't investigated in detail,
> memory pressure doesn't seem to be critical (and it could also be
> possible to adopt smarter thresholds).

OK, that's quite interesting that batching makes such a difference. I
guess somebody with more knowledge of macOS kernel internals could
probably explain it. Though it sounds like your problem was sufficiently
solved by dropping the extra config, it's a good fact for us to know
about in general.

-Peff
