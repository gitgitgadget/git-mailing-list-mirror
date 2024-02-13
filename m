Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331217983
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811218; cv=none; b=PgaoVzn/4yieAk8HPiGg9l7RhAdn/mhI6bxK1M91aXFJ1BZL0bdG/r3++ZDGOzZAIw8HRrYoMQFCa/2ZlQ3n1cVP6qLY1uH1I55nXMeyr5sM0ORheYwaVvQK/oyW0daPfNkXza7InJ7+jSUdeucjv1paIIN1z3at6rpboVesW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811218; c=relaxed/simple;
	bh=uk2AqcjlVf+ivlM6pQvzfIVbwMmEl67/WUlRfBXjwM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV9+m358gA6PE6mYSFruDZYJF9WFKrtWbOhSua8iHc8XqusP0VcA/KmPPSaMHU7WTXnUMX3X4qAJL0t2OUn40s2usfSI546/XpGZXU9GVHyE+lawWUxv4/YslMPmI8/gYcZmnOvQ4T83dQ7B1+0j4rITMME6zEGyblKMQgsgnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14941 invoked by uid 109); 13 Feb 2024 08:00:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Feb 2024 08:00:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25203 invoked by uid 111); 13 Feb 2024 08:00:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Feb 2024 03:00:17 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Feb 2024 03:00:14 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Maarten Bosmans <mkbosmans@gmail.com>, git@vger.kernel.org,
	Teng Long <dyroneteng@gmail.com>,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
Message-ID: <20240213080014.GB2225494@coredump.intra.peff.net>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl>
 <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
 <xmqqy1bxiiop.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1bxiiop.fsf@gitster.g>

On Tue, Feb 06, 2024 at 09:52:38AM -0800, Junio C Hamano wrote:

> > That is also a cool idea. That would probably use the functionality of
> > the cat-file batch mode, right?
> 
> Not really.  I was hoping that "git show" that can take multiple
> objects from its command line would directly be used, or with a new
> option that gives a separator between these objects.

How about:

  cat some_commit_ids |
  git show --stdin -s -z --format='%H%n%N'

?

-Peff
