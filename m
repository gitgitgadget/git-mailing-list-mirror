Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E735966
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735272357; cv=none; b=oCbX6oprPDRFquqSaSzjxEIorRd297q0iCvmAt/471uz/k4Uf21I0oUPK7v2olQ5Tum7cFS2QJcbuIyLdTk6Cnw0vYKPIcCUNgIifsKEwD39svpvjytd3a5xFYIORfvz1mcyVbALkeU0873v7ZOOFhv3HYXNDOmp+ZHbryrk3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735272357; c=relaxed/simple;
	bh=zRz3qYEqNOzGX0Sa/eIx3JavOADu0DabqdvHeIbn1e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIAzlokhdVvkfiPmFdIAHBuMx1adSd+/AFOSJ9uqUBevsSZunUeVTYK/2IPj+JvQrtl6tjlBOjuG9gysJ5NtHFxALvV9FxYs11yzdS76e3+fb4HyaxG6gZaQMg9KRQVNpxTGsbDisIDQJ0MhMqjsT8jIB7TBhsvS9ubkmCryMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ddu0fyWT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ddu0fyWT"
Received: (qmail 966 invoked by uid 109); 27 Dec 2024 04:05:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zRz3qYEqNOzGX0Sa/eIx3JavOADu0DabqdvHeIbn1e0=; b=ddu0fyWTqOPkgyKNMWbwfuyBqqJ9b8rlSDvtuEwYBh9cSk2eMAcwMgy0kMPqcA9a/nPrWXnU8Nyx08QR7826IKMcIcMVIBhb+smFfq1k1If+GtFPgMtatXncCKZi5JDpd0niwYF5arO4MOz3tXwIR3gS3oLan5YuubVXXJzyavPkafFc3RWPmcGm6A8SlrjqkYzqwar6hl2i+bffUbcBeqge+VgUxbTQItsYA0ZLJ/vp0ULwrIirL58Pc131oK2GE7VgBNOlgEWkbR2i357Eq3z0nFekTeCoiOJzzQK7uw5u5+rsfeDfleuHi5MqOe0V3Sgwmii4PXETtSe8/DZKOw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Dec 2024 04:05:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8646 invoked by uid 111); 27 Dec 2024 04:05:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Dec 2024 23:05:52 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Dec 2024 23:05:51 -0500
From: Jeff King <peff@peff.net>
To: "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git fetch" fails for a --reference clone after an outer forced
 push
Message-ID: <20241227040551.GA86251@coredump.intra.peff.net>
References: <SJ0PR11MB581445B096273126D18F3724C60C2@SJ0PR11MB5814.namprd11.prod.outlook.com>
 <20241226155251.GA69868@coredump.intra.peff.net>
 <SJ0PR11MB58148000A9DCB33CCFD792A0C60D2@SJ0PR11MB5814.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB58148000A9DCB33CCFD792A0C60D2@SJ0PR11MB5814.namprd11.prod.outlook.com>

On Thu, Dec 26, 2024 at 05:36:34PM +0000, Mirochnik, Oleg V wrote:

> But one thing is still confusing and inconsistent IMO - why using
> local path for clone still works (even with the git-gc in both master
> and mirror which removes the obsoleted commit object) while it should
> not (based on your explanation and the "git help clone" snippet you
> provided)
> Could you please clarify?

When clone is given a regular path (and not a file:// url), the
"--local" mode optimizations are used by default. And in that mode, all
of the objects from the source repo are actually hard-linked into the
cloned repo. We still set up a pointer to the --reference repository,
but none of its objects will be used immediately (since we should have
everything we need by hard-linking the source repo).

So here:

> git clone --reference `pwd`/mirror `pwd`/master local1

...there will be hard-links from local1 to the packs in master. So even
if "mirror" gets rid of those objects, there will still be copies in
local1.

I think if you were to repack local1, it would drop those duplicate
objects (because it passes "-l" to "git-repack" under the hood). And
then you'd still be subject to the same problems if "mirror" also gets
rid of its copies.

-Peff
