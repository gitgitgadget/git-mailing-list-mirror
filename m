Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548B07DA66
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821007; cv=none; b=BFQbKR3bhD7XYGbpgXWPNXhr259VGM4qDm8KxobI6gNFMeUnnvGKCuZ79zQiFSggSxDiKQ+fSQ3zI5HHjepcHFOcNwd+oY2K5kg0BJk3eckn57nbSflgz2v5gHDSPyF2blE86yrWl5cjWQIULxNl/il9Y7B/5Y9p8wCm9hNad9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821007; c=relaxed/simple;
	bh=RSC9B9Oz5UaAq1JB4ro9ajXKyR1aAfxCvwOYJujWyqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKVL4hcVco//+CokT2b46LPLLiJFNgmb0gpcCO4eAFYXIUmHHP1hx1XVkP6/rFOmUp3nc1oPBCS4gAhw0kZCGguoOn+o02EVgoMTSPsyV2cTCvFawMJ4vtffMbgDMBHWf6Am48aeV8NWQozTkSftDqqXecboCbAsCPYPoVP0q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HvIrIWIJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HvIrIWIJ"
Received: (qmail 495646 invoked by uid 109); 27 Dec 2025 07:36:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RSC9B9Oz5UaAq1JB4ro9ajXKyR1aAfxCvwOYJujWyqg=; b=HvIrIWIJeDr0DCF7n8kIgQD2EpSpw9Y+PxPEVfLymerbo7R4EMvSqOzqgoVqd00nUTNPExfeIPr45TYwVE80aU2r/Z/+G6BzrWgX9OL7oXZggccI+NBoJh2sAtg3w4f9MD5fHIGVR41Mn9bUo7x+ru/y7sAUKbFCFX+HnPbNoUslKG5YGzHD5pxyfB5OaPW0fzAVDUNsb9tGPhKHemIeImlpGnQTcshSk3A9tRBQUfO5mjLFbtnQEN9hlPHjMx1f6B6JMWCEetL3CjJn4Gxj3N6SK6afgM1OdZ/ciwhWHqdqguLRSc57Q9nBdZRhx+yO4nPVsCbli0TfcBZI29ZIUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Dec 2025 07:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 642893 invoked by uid 111); 27 Dec 2025 07:36:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Dec 2025 02:36:39 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 27 Dec 2025 02:36:34 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Martin Fick <mfick@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <20251227073634.GA2071715@coredump.intra.peff.net>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <aU7Cs2pXiXInfBh4@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aU7Cs2pXiXInfBh4@fruit.crustytoothpaste.net>

On Fri, Dec 26, 2025 at 05:15:31PM +0000, brian m. carlson wrote:

> >   If we wanted to be really pedantic, anything in refs/heads/ should not
> >   point to a non-commit and thus should never need to be peeled. I'm not
> >   sure if we want to embed that assumption in this code path, though
> >   (nor would it necessarily help Martin's case if the refs are not in
> >   refs/heads anyway).
> 
> I don't think that would be a good idea.  I know that people definitely
> do updates of the loose refs by hand (although they should not) and so
> it's entirely possible for them to contain invalid values, such as
> having branches contain non-commit objects.

Yeah, that matches my inclination.

> I wonder if reftable would avoid the need for this kind of expensive
> check since it would already have the data peeled if need be and
> wouldn't need to recompute the values.

It does the same amount of peeling, but it's amortized across more
operations (i.e., whatever did those ref updates in the first place)
rather than during the pack operation. And of course there really is no
pack operation per se with reftables, but I believe it avoids re-peeling
when rewriting entries during compaction.

It might actually do fewer object accesses overall if the ref-writing
operations have already loaded the objects in question (and thus it
knows whether they're tags or not, and may even have parsed tags in
memory). It can also do more in some cases (e.g., two loose writes will
peel for each write, whereas the files backend only bothers to peel
during packing).

-Peff
