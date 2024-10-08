Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E71E5019
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370495; cv=none; b=EuGvvJeMeeH+I9AI2kZSjeOOS2KJpSp+4WhwjDKDK1+4L6hgBp0VDFN/oZUEq+AC/2gWOuOyoSV5E7/xvsqtEJD74oeJn0YVu240mUoWAQjaistk5aYT0y+pNdBlg+lWuet26GnGfFnRI8rQvlTAjlO9uWeKMweExhWqr8K00mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370495; c=relaxed/simple;
	bh=6J2CAgI7NXut/vxEhd+RJZISoPNMKhJ8tnIFQQ3ugSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFRZBG/dzifFQNe+OUNQR9EQBzKMoi64HGeLoupKT1p5/74/BEfgJ+MrnFASeOgRoID/9OHKKv3jGi0lNEOkSllgJPfIWqOYK4cL8nzOIvTqRT3QeWHbOdw7Jk8codyCTwRCwPRq8SFYDulWvp1AYkJ+WXOc5UDC6NiO8LyS/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q9yCmwoY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q9yCmwoY"
Received: (qmail 8940 invoked by uid 109); 8 Oct 2024 06:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6J2CAgI7NXut/vxEhd+RJZISoPNMKhJ8tnIFQQ3ugSY=; b=Q9yCmwoY0PDvKESmsqjsNVk8TwdWQuYR3ajk8LaIbTLJg+RnsiXYVLJBeKksSU/qOSvbgJfbzXbY4US4s29aYywXU6jmV8zGQCyaRkUn56bCRR/FY8JxUMhCW+q/bJUCnU9yjtsRuYegUhE18CYwWFJb1nV39Ad9g2xEOOOMK5D2yubS7/IHpDGF1CrGp70eUZEPDXosmcbnZrsotxB+ZW2A5aXLNMQLrpdHM6MjcNqKj44xiGuLNtBpjsjKk+kn1Kz4MoJWvYeKt1y2r4+xowVfWUbwiFn5LdhPxtnW1OkhBiDyEzEvwKrEvt4yimEhOznlrDXOYSLfpFLEKXzQJQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Oct 2024 06:54:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15100 invoked by uid 111); 8 Oct 2024 06:54:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Oct 2024 02:54:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Oct 2024 02:54:51 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] object-name: don't allow @ as a branch name
Message-ID: <20241008065451.GB676291@coredump.intra.peff.net>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>
 <xmqqy12z7eti.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy12z7eti.fsf@gitster.g>

On Mon, Oct 07, 2024 at 03:01:29PM -0700, Junio C Hamano wrote:

> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
> 
> > `HEAD` is an invalid branch name.[1]  But the `@` synonym is allowed.
> > This is just as inconvenient since commands like `git checkout @` will,
> > quite sensibly, do `git checkout HEAD` instead of checking out that
> > branch; in turn there is no practical reason to use this as a branch
> > name since you cannot even check out the branch itself (only check out
> > the commit which `refs/heads/@` points to).
> 
> I am not sure this is sensible at all, after all these years.
> 
> I suspect that it is much more productive to deprecate and remove
> "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
> does not act as a synonym for "refs/remotes/origin/HEAD").  Having
> two ways to call the same thing merely adds to confusion in this
> case, unlike "HEAD" referring to 'master' (when 'master' is checked
> out), which is also to have two ways to call the same thing, but
> adds a true convenience.

I do not use "@" myself, but I feel like when removing it has been
brought up before, it had its defenders. So I do not personally object,
but I think you'd have to post a patch and see who screams. :)

> Those who really want to use @ can do something like
> 
> 	$ echo "ref: HEAD" >.git/@
> 
> or something, perhaps.

I'm not sure if we'll allow that long-term. It does not match the
root-ref syntax, so I'm not sure if it would pass check_ref_format().
(Sorry, I had a series a few months ago cleaning up some edges cases
there, but I haven't gotten back to it yet).

-Peff
