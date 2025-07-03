Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202422B5A3
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556975; cv=none; b=HAu+FkxccRmrLx811f1gio5PtbcsP7PWrkr1sDE1GQVHx6AL2YfKPN4qR1FnrG8PAezERoWWDByyTOz5ToRyN63RUmK1DrIn1nt6N+2ezqg1hltmCORC2VtgIYl3pnTtuCy2qBCrNXkCBdSXzURr4leKH7Xp2FP7/AduglLNbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556975; c=relaxed/simple;
	bh=JXo9BwfQgSRYWwjZA2vqTpUNzVdyttoEhAXcR2MXOrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCZ/2UR8W8kOZVFcngwetNi96XiceU+4r/HbB9Q0oBMZEV516j9E+mrVYbxPQ4r1NsfQCVZOMxO9/lTcfJj/8vKDWzuCBObppfOyajR+I9asqccC0//Ci460C2qSczxGrKQetV78QeS/daKjS1wpzCZa5mc3SGBqdCQU+5OBHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ChqFL5lb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ChqFL5lb"
Received: (qmail 5608 invoked by uid 109); 3 Jul 2025 15:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JXo9BwfQgSRYWwjZA2vqTpUNzVdyttoEhAXcR2MXOrw=; b=ChqFL5lbriqwpw4mPgqbC+KWgv+Xe/VqvBzJBu9uqcPSIM5wrhk2Lmd/x4eSoSIEVXVx2kwIY/7suO/QuVuvUd+X/QabjxcRHS9OGhZXl/uHoJhjJ9tESMNknFvl96zma9hVAUM/LFvfElh1AY/mG4n3qUpKQZif2Pcs/4WMJf0A2PYcYj2/pkZhk9mFB+FsHJjUS8tE45TQLoMTuQIosRTD3h0GYEQ9Ry5j2KlPxZOcNsQXlkU3qOsYR0TYCGr9dbuJ2szHH2VD7eH0FMOsbr1+OSjVLmTYl/t/tmWP5GhLyDcKZOx0KBizylSfW+K2Kx+e+TLO3MYaHtINtCz2lQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jul 2025 15:36:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 889 invoked by uid 111); 3 Jul 2025 15:36:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jul 2025 11:36:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Jul 2025 11:36:11 -0400
From: Jeff King <peff@peff.net>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: ericsalem@gmail.com, git@vger.kernel.org
Subject: Re: Re Behavior of git log --diff-filter=d
Message-ID: <20250703153611.GB1309870@coredump.intra.peff.net>
References: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
 <20250703134220.31638-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703134220.31638-1-jayatheerthkulkarni2005@gmail.com>

On Thu, Jul 03, 2025 at 07:12:20PM +0530, K Jayatheerth wrote:

> Yes, this is expected behavior
> You're seeing a difference because
> 
> --diff-filter=d tells Git to exclude commits that have deleted files in their diffs.
> However, this filter only applies if there is a diff to filter.

I don't think that is true. Even if we are not showing a diff, we'll
select which commits to show based on diff options (and show only those
that still touch something). That's why "--diff-filter=D" shows only the
commit with the deletion. With the "d" filter we should omit deletions,
leaving the second commit with no changes (and thus not shown).

-Peff
