Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5EE391E60
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258772; cv=none; b=a6BUTJ9Gsl7ZZFYdU8BoI0YtqeI6/mjNLLlcrH3NgFVPdyJ/7lY92sb6F6ZXcD+BmGvGQluxtigYlhU1mIBpliH0qm9OJ+wneAuagrSFcsOl+nfzyF+F0YSBWraR7l//UZyQwMfr9tSUNWR5Yj6iZo7zjY3EI14dmKY64K31DH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258772; c=relaxed/simple;
	bh=Sq0BAC0UIdkQEHUGi4wXJNBHxhxDOV/Knzh8mtC6va8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJxBYPcrI2Szbxy6YyI/vVl16Xmx1SDWtnOKABBXOgisMec9HLpkfA1spfi737wjG1BQ7J31SdFZZepxFof3VKQqkL9OTJz4QZVjL8QwEZ8lspo/feaQGsyFs+ZpWpmexnNj1bmddUSLT5JboUT+i/deR8WKhD39qWqNaZ+Dczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QJW0xcpR; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QJW0xcpR"
Received: (qmail 82990 invoked by uid 106); 28 Jul 2026 17:12:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Sq0BAC0UIdkQEHUGi4wXJNBHxhxDOV/Knzh8mtC6va8=; b=QJW0xcpRu/VESWzeXcBSPKftYHxQCVwGfYMlc4tu6xlYp4UhKj0rw4o/OhrE+OxqsHPbhMMzYp/OfmFYSnf1tsEF1krKT5zKTjjMvm8/+lvW7BacYkI4eN8Gh2FEb3FqH+mSTTfjwWmdqCxmAb8xo2vgqzhKUCgUypFz1q2BVus0P1PEqa2Tf0hS4hX+FqlmWxhFjXCCFU/VUM69HWIyL3jJk9KBFF/Ck3xr2o2RHf9CLREHa3sjKzA61BntQriGIKno3p4aC+nUu+yPRx+4mqRWUq55dLGT3e9CXYC4f+4RaUzPV4FoNAriqVCXqMxL4wC62tvOpqXivHdFXf01tQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 17:12:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 101840 invoked by uid 111); 28 Jul 2026 17:12:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 13:12:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 13:12:49 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff-lib: add idx/tree sanity check to oneway_diff
Message-ID: <20260728171249.GA643101@coredump.intra.peff.net>
References: <20260726084550.GC2366012@coredump.intra.peff.net>
 <20260726084705.GB3529698@coredump.intra.peff.net>
 <20260727093912.GA591426@coredump.intra.peff.net>
 <xmqq4ihkgd06.fsf@gitster.g>
 <20260728151458.GB41931@coredump.intra.peff.net>
 <xmqqo6frdqy5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6frdqy5.fsf@gitster.g>

On Tue, Jul 28, 2026 at 09:22:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> We could help humans that the BUG is not expected to fire and only
> >> to help static analysis by a crafted message, perhaps?
> >> 
> >>    if (!idx && !tree)
> >>  	BUG("Hey, Coverity, this does not happen");
> >
> > If we are helping humans we can probably afford to be a little more
> > eloquent. ;)
> 
> I do not mind eloquence but does the comment clearly say this is
> primarily for unconfusing static analyzers?  My first reaction to
> the message was "OK, you explained very well why this condition
> would never happen, but then why do you need to check and BUG() on
> it???"

I guess by the time I did all of the digging and thinking, my thought
was that it _wasn't_ primarily for static analyzers, but to capture the
output of that research. But then yeah, we don't really need the actual
BUG(), but without it, it feels strange to even have the comment at all.

I think that's why I waffled on sending the patch at all.

> But I guess the point is a future modification may invalidate this,
> in which case I agree with the comment.  If it is hard for static
> analysers to get it right, it probably is equally difficult to grok
> for AI agents many people seem to be using to draft their changes
> these days ;-).

Yeah, I guess it may help them, too. :)

-Peff
