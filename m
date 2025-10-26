Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72E204F99
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761492378; cv=none; b=S1xHhXZ1h4wWFHxqsPL7O58qxl7rGHPtuPIovU56ogu0lRsIlE/7chNBVly38Pz2TBemu236SKJ7T/60F2BjIihx6GQfuklR3vGxY51v0EwyVPbYnZaRVL1ZT0Vzk5VHOLFs1+sz1s+qXGDd5q9HQ1YAy/xOoOZNrPvaIyNVzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761492378; c=relaxed/simple;
	bh=mzAi+g7iL5XR4T2q+QKt15YvbSSTe7Jij9quDdhNGbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujejY+cc0EuAgB2gelUEaW/8HU0TalRdNoCAKYtLVI//iV5KzZ0vo08m0kjGpIV4D9hTnkNnO1eaK+6pQ+bmo2e7KKr4hB41svfJWciFdgmxqvm0O3cQOKxEWGEnHwCSXPEs0WzBNaQRQUmLFIi3j2kUQn8YeWJWJrth++o0UK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IJvwHWlj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IJvwHWlj"
Received: (qmail 346819 invoked by uid 109); 26 Oct 2025 15:26:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mzAi+g7iL5XR4T2q+QKt15YvbSSTe7Jij9quDdhNGbM=; b=IJvwHWljxrX3CFESSqA71r/Kw6zOWQiWo1W9C+vv/Ht/sE3QxFM4dFulzBqJzE+vUNwwetGgSW/y46KEAi9eZB4ScH5bANNTyyHdo9CjfvfeAeurL8VVBPFuzCO6QwSQtes5xRAOR3KM+h/T5v3A5MWwosh0OKmh6oUgInT4jB1XNP7v4JE7OKwjdapZDdwa5rPGB6jntRGDpE3EFiE5bxOwSHR7CW3cIyHtqsOreoamE/FlRDpIUNj1JoC5PobA9r8Vrz7JUo6vlQctHcdzKga09PcYSY5AXyV3pXSwRbUlx0VCXIcxufcZgydrqf+K7ECHSejYno3CyzK3iVRFRQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Oct 2025 15:26:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 542372 invoked by uid 111); 26 Oct 2025 15:26:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Oct 2025 11:26:15 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Oct 2025 11:26:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
Message-ID: <20251026152614.GB2095501@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net>
 <xmqq7bwltlb8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bwltlb8.fsf@gitster.g>

On Thu, Oct 23, 2025 at 01:28:11PM -0700, Junio C Hamano wrote:

> > Subject: match_pathname(): give fnmatch one char of prefix context
> >
> > In match_pathname(), which we use for matching .gitignore and
> > .gitattribute patterns, we are comparing paths with with fnmatch
> 
> "with with" -> "with".

Thanks, will fix.

> > My suspicion is that most of the improvement comes from (1), and it
> > would be very easy to retain that case and get rid of (2). But I haven't
> > done any measuring.
> 
> The above matches my intuition as well.

I poked at performance a bit more, but it was long so I put it into a
separate email. My findings are that yes, this optimization is very
measurable, and that my proposed patch does not hurt anything.

> > @@ -1360,6 +1360,13 @@ int match_pathname(const char *pathname, int pathlen,
> >  
> >  		if (fspathncmp(pattern, name, prefix))
> >  			return 0;
> > +
> > +		/*
> > +		 * Retain one character of the prefix to
> > +		 * pass to fnmatch, which lets it distinguish
> > +		 * the start of a directory component correctly.
> > +		 */
> > +		prefix--;
> >  		pattern += prefix;
> >  		patternlen -= prefix;
> >  		name    += prefix;
> 
> So, checking pattern "fo*o/bar" against "foo/bar", we'd use
> "o*o/bar" to match "oo/bar", which is not necessary but our
> conjecture is that feeding shorter fnmatch() is not buying
> us much, which justifies this change.

Yeah. It turns out it _does_ buy us something (at least in some corner
cases), but pushing one extra char onto fnmatch is not a big deal.

> If not, we could do a more targetted pessimization, perhaps like
> this, ...
> 
>         /* the non-wildcard prefix does not match? */ 
> 	if (fspathncmp(pattern, name, prefix))
> 		return 0;
> 
> 	/* the non-wildcard prefix is the whole thing? */
> 	if (namelen == prefix && patternlen == prefix)
> 		return 1;
> 
> 	/* avoid making foo**/bar match foobar */
> 	if (3 <= prefix && memcmp(pattern, "**/", 3)
> 		prefix--;
> 	pattern += prefix;
> 	patternlen -= prefix;
> 	name += prefix;
> 	namelen -= prefix;
> 
> ... but that is even more specific hack than yours.

Yeah, I think that would also work. Mostly I would worry that there are
other cases besides a raw "**/" which causes similar problems, but I
could not think of any. Passing in a single char of context seemed like
an easy but general fix.

I also wonder how expensive that memcmp() is. ;) Obviously not very, but
if the point is that we are trying to save fnmatch from looking at that
one extra character, we already pinching pennies in a mostly
un-measurable way.

> > @@ -1370,7 +1377,7 @@ int match_pathname(const char *pathname, int pathlen,
> >  		 * then our prefix match is all we need; we
> >  		 * do not need to call fnmatch at all.
> >  		 */
> > -		if (!patternlen && !namelen)
> > +		if (patternlen == 1 && namelen == 1)
> >  			return 1;
> >  	}
> 
> In any case, I do prefer doing this "our non-wildcard part matched
> the whole thing, so let's return true" before stripping matching
> prefix from the pattern and the name (like I showed earlier).

Me too. I wrote it a few different ways before ending up with the "==
1", just because it made the diff smaller. But let me do it as two
steps, which I think will make it all more clear.

-Peff
