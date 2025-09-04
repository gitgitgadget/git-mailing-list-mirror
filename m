Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A52FDC54
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984979; cv=none; b=VZaZaxmp9tD/rbK/a1JQwcr/nuSPnA53XTD0EcvIuatxlfISBIhLFG4ZD1Kic4+0ZYELGWUUw/j/0ETFwiIfLcxgzs4Y5udasARYGVd+aHm1B7W0jdDnseScImtrJCS2Ky1m1Vsf9mbH2AwXyjmy0bgWpjBTohskciHFspwJ43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984979; c=relaxed/simple;
	bh=uh0untDJAQ2v6AbZ6QuaW5+i4yJ9sCHXDp5KWzMqoBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBfdLQFLGY9CJF0TEstXlPpmqynS23btiaLTC3jZ8x0Uv70aYebDrd8C8tGHzvaJCZ082AZIpqZOooBVoNmrdLv9cmQvjQCoaYz/MWs+9vp10Xb80UC5/W5AXzq8hS9NO8URfeBCMDYe0/IyeQ/qRw4Uzo6FeqXEYlMUXioa5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f4FZ/Edp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f4FZ/Edp"
Received: (qmail 202503 invoked by uid 109); 4 Sep 2025 11:22:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=uh0untDJAQ2v6AbZ6QuaW5+i4yJ9sCHXDp5KWzMqoBU=; b=f4FZ/Edp3yAK6DwWpeNWRzGTxjCEX8sTHy6m6NT9Z8+tI5IFGHWNAorjLjuZc0F0aTwA+j407A5ZfU/xVDjD0Z1gi/fjNv5YPXhPxJ9A9qnL6020+EpYa0furJg56cugc81VvAsWYoyxYh/oh33SMT6w1zCk6N1CYqP2EUeCBmFKXjDEBCWjgzWgU22LAu/PCdboiZrjAyLDfY5HBZ2CXhoDOhBv/JG5nKI3AA35LS2Sv4oI44R6Fvnj8i3fv0FPRGNOx0wi3O/7OzKxTdeApAWUeVxoNqBFh46SuxVEtT7FJR7+aP0QNy16gwlVpAG1wIY0wBz7TBjXrkwFQju80w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Sep 2025 11:22:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 356188 invoked by uid 111); 4 Sep 2025 11:22:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Sep 2025 07:22:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 4 Sep 2025 07:22:55 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250904112255.GB2474144@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <aeb6aa64-c2f8-4b28-a2cf-9662907b5feb@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeb6aa64-c2f8-4b28-a2cf-9662907b5feb@web.de>

On Wed, Sep 03, 2025 at 06:30:57PM +0200, René Scharfe wrote:

> On 8/25/25 9:34 AM, Jeff King wrote:
> > 
> > [oidset instead of khash]
> > But the bonus here is that we didn't need to define a new hash
> > type, nor do any tricks with the commit->index field.
> 
> It took me a while to notice what's tricky, or rather inconsistent,
> about the khash set of commit objects with commit index as hash: We
> could just as well go all in and use an uint32_t khash set of commit
> indexes.  That would reduce the memory footprint further.  No pointers
> needed here.  Didn't measure a meaningful performance difference
> though, so that's that..

Heh, yes, that's true. I didn't even think about that. Conceptually we
could replace "struct object" with just an index value, and then all
code could just allocate arrays and index them. And the commit-slab code
is essentially a slightly more dynamic version of that. And a hash of
ints is a good way of handling a sparsely populated set of data.

It's less crazy than it sounds because we allocate objects sequentially
and never free them anyway. But it would still be a pretty big change
(and each data access would involve a few extra instructions to compute
the address).

Anyway, I'm happy enough with the oidset solution you landed on.

-Peff
