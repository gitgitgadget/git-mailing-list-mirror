Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FA371D1E
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255593; cv=none; b=txfrSGj3kuYYV/C/DUefetLd3fsR3iRb9as23G8j+YhcV+rY0TDyJnLcZJ+5qsp9WKjfLmemP8JJBXdNwiWB3ze+keLrYvRdNMKNPaheJlyDFfKf8d6cvMCEiEXdoklrldBwEaFSCuO45AQW0la0I1ilwiYAr6vkWfgAH0QeO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255593; c=relaxed/simple;
	bh=+EoeBa0gOW+2Oi5IRRLZt78yxyhj8I34nXCUNnj0xRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE/NufKQab8ny8C4C00VhggCk2VnY4cQrsuwZY4dWGDgPmo8nhrVHiofZGDaD0+D/bH7t/8jikjSa6XBsyE72l55L95E4tTpIMtK16uoiIBO8Pntzl1FloVjqGH6cRc+MFRYzubXpkFGrB2tjS+/X4pRNK9P7O9NnO/CseD75yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LeS9Nbp0; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LeS9Nbp0"
Received: (qmail 81897 invoked by uid 106); 28 Jul 2026 16:19:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+EoeBa0gOW+2Oi5IRRLZt78yxyhj8I34nXCUNnj0xRI=; b=LeS9Nbp00uzdo7XJ/pidYbprLIqM40YuRrI4c6aOjYQGFT1EgTReF7/cQdN/+QuJT5yBVZbficGDi5F8MLN1oSY35FOacMZSRKGbfLTrKOyWfQNH8uHp7dgW9lw/DIA/lH4dih++mLr6aX5NvHvv/uOp56bqlKY89WdD+uURXQtUFugMF18iSzLKV0giOa2siSadtZIS+p9H68ZIvcEpidgWzQF2hkjS1OWXhMR9xE6+h9rmCexbOr8aDtN7QqhFErJPRQesO2QwZH6lxqHNlYJ7kjhzb55pg3sOCawvPgnGPQ1v1nC+/FNf8SHKiX6AxAgEGlaOQfiow3NLUMeE8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 16:19:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 101163 invoked by uid 111); 28 Jul 2026 16:19:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 12:19:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 12:19:49 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t0014: generate deprecated command names dynamically
Message-ID: <20260728161949.GD639637@coredump.intra.peff.net>
References: <20260728143653.GB11894@coredump.intra.peff.net>
 <20260728143845.GB41686@coredump.intra.peff.net>
 <xmqqse53drwu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqse53drwu.fsf@gitster.g>

On Tue, Jul 28, 2026 at 09:01:53AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We have a few tests related to aliasing of deprecated commands. They use
> > whatchanged and pack-redundant because those are the only two deprecated
> > commands we have. Eventually those commands will be removed, at which
> > point these tests will be checking nothing useful (they'll just be
> > regular aliases, which we already cover in other tests).
> >
> > We could remove them at that point, but the code to handle deprecated
> > commands will still remain. We probably do want to keep the tests around
> > for the eventual day that we deprecate more commands. So let's ask Git
> > for its list of deprecated commands, and if we don't have any, skip
> > those tests.
> 
> Ah, now I understand.  So HAVE_DEPRECATED prerequisite guards tests
> that require at least two deprecated commands, so that we can test
> cases with aliases that involve two commands among deprecated ones
> referring to each other.  Obviously, with 0 or 1 deprecated commands,
> there is no point to perform such tests.

Yeah. Sorry, maybe splitting the two just made it more confusing (it was
really to make the diff a bit less heinous). I'm OK if you want to just
squash them together (using the commit message from the second).

I suspect we could _probably_ rewrite the "looping aliases" test to also
run when there's only 1 deprecated command (just looping on itself). But
since we have two now, and plan to have zero later, I don't know that
it's worth the effort of doing so.

-Peff
