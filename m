Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AE245B05
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476399; cv=none; b=XFhMjsNtiRPBadVoXT6qge4E98tqYWwYugiytQMDYjpF1mnjciN8IbzKQWgNbKz0s27Ae5rk5gxeoJiskU1LkE47Wdg7bZvpUN/9BcSD6vxpniwTQpmGvBXcoPPYHxjo0cXp6liYTJxN19Gk9rL0soObhNqWJ3FSWA5P0+z+T0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476399; c=relaxed/simple;
	bh=3NkkSiLe2GvZkVPu9PRtBuAGp9goOxyQK/ndpc+H93A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLk5dQ2F/GE0uxlHcTnhMDECwHFdDwy3e+K/GXaYcuzDUh8aRk+3Bkz5zeic8ZGs+lKztk8oSxDKbX+DT/Sueau4ZYhAOVYBgMOdOrVqulc7gpW9alNeKxQ4HbYQzfNzzOGRgi7xtTvzfWMI1cDeJY7e+GaKRifrp4/A3EDSs3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MGk3eumS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MGk3eumS"
Received: (qmail 1451 invoked by uid 109); 13 Feb 2025 19:53:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3NkkSiLe2GvZkVPu9PRtBuAGp9goOxyQK/ndpc+H93A=; b=MGk3eumSpXuySqA2ryUkSQVu3k+Ta+O4VQ+a3J9m5Wu0nKytehkT1rwMtqlWyiJELJZdD5+bKt10Xzhwsnoll5OSS1DbjBbm0a/5jPNnivxkFRflvRH0kABUYRrxB3MDgalWuf7BF0Uttucz5wCZbWfgSkBJ2RHf9Bn3lxsSyxO+AXIdyEE4acu2EwGJeEznljgFqOo8LgLBOZzqTZHfmml1Wo6CEJ+81bufO05tf0fbibyT1WsYe7mLirw4J5WXhN4XMWlEFabyrE236GVdat8kHigH/s2JGdYeNOKxZH0I+RKTBrghemXtc9Xl5IhM//vEH9EKxUaMkvh8WlonRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Feb 2025 19:53:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 526 invoked by uid 111); 13 Feb 2025 19:53:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Feb 2025 14:53:16 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Feb 2025 14:53:16 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <20250213195316.GB934256@coredump.intra.peff.net>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im>
 <Z62booOOXODOl_sZ@pks.im>
 <20250213082221.GA916028@coredump.intra.peff.net>
 <Z63VY_wa7Z6lrUfY@pks.im>
 <Z64CU1sG4B1o52uA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z64CU1sG4B1o52uA@pks.im>

On Thu, Feb 13, 2025 at 03:31:47PM +0100, Patrick Steinhardt wrote:

> This turns out to be harder to implement than anticipated. While
> iterating through refnames and the ref iterator in tandem sounds nice,
> it would cause problems when the ref iterator yields millions of refs.
> You don't want to fully iterate through all of them.
> 
> What we really want to do is to reuse the iterator and have it skip
> entries: we'd basically create the iterator and re-seek it for every
> refname we want to check for collisions. This allows us to reuse some of
> the data structures, and in the best case the underlying backend knows
> to optimize.

Not having looked at the reftable code much, I'll take your word that it
isn't easy. ;)

I suspect the files backend isn't very good at this either. It knows to
take a starting point in ref_iterator_begin(), and should binary-search
the packed-refs file to the right point. But if you want to then ask it
"OK, now skip ahead until you see entry 'foo'", it would just walk
linearly to get there. I.e., there is no real seeking. So I guess the
best it could do is restart that same binary-search, and the order in
which we feed the refnames is not even really important.

And I don't know how seeking works with reftables, since "skip ahead"
requires merging all of the tables.

> But the bigger problem is that the generic reftable iterator does not
> yet have this capability. We first have to revamp their lifetime in the
> same way that I revamped the lifetime of reftable iterators. A generic
> iterator that has hit its end is currently getting free'd immediately,
> which I always found to be a bit awkward. But because of this it's
> impossible to reseek them, as they have lost all their state.

I do think if you feed the refnames in sorted order your seeks would
always be forward. So if you hit the end of iteration, there should be
nothing left to check.

> Oh, well, I guess that's what I'll be working on now then. But please,
> somebody stop me if I'm not seeing the forest for the trees.

No, I think it's actually a hard problem. :)

-Peff
