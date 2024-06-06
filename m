Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1283EA72
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662290; cv=none; b=BOqm/5P7jdaT15CY7STrTUrPlFqceM3KzzHNUpkg9TN1hS7CzblS1de6peN37JGjd00eiv+SjVFduuuuAje9Pts+k/nv5mg5/I9JyA7BN2eYmmiqXj3HakNQhpT9v2YN+lYTWQfpXSQtDgAuBCcXZjVtq7Oob6oBLmKow3BRG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662290; c=relaxed/simple;
	bh=Y4ojC7LIUhVxpUT0zf93VJ4CHwi55hJA1PgnGDuvbpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaK6QeZrBbq67gzCo3WwUA9WU/KQqekGRfuev6AvGtVjfkK1WI7NqDw83LsWNb9QXPqJKREMp/WRnXG0AH9+Ytwu7V13GLLWVMGE0oOSw+emeO1UylBwZHAVrF8mMlto7lySaoxKfW7SO5q38uK6qumAlDa1/wnu+as/QTh8hEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11235 invoked by uid 109); 6 Jun 2024 08:24:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:24:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6673 invoked by uid 111); 6 Jun 2024 08:24:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:24:45 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:24:47 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v4 5/6] test-terminal: introduce --no-stdin-pty
Message-ID: <20240606082447.GA1166753@coredump.intra.peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
 <600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>
 <20240604103305.GB1781455@coredump.intra.peff.net>
 <xmqqfrtrxusw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfrtrxusw.fsf@gitster.g>

On Wed, Jun 05, 2024 at 08:39:59AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > IMHO we should consider getting rid of it entirely. I think the only
> > thing that uses it is t4153 (AFAICT it is luckily not racy because it
> > does not actually read stdin, but only checks isatty).
> 
> Sounds like a better approach than piling another workaround on the
> test helper.  Reading the old discussion, we seem to have been in
> agreement that we generally do not have to insist reading from a tty
> and certainly the "add -p" codepath is not one of those "if your
> other payload must come from the standard input, your instructions
> to specify how to handle that data needs to come from elsewhere, and
> that is /dev/tty" cases.

I think we got rid of all of the "read interactive input over tty"
cases. The one that I still see is am's heuristic to use isatty() to
decide whether the user might send patches over stdin.

I just sent a separate patch series which I think improves the
situation. And then either Rubén could build on top of that (if we think
it will graduate quickly) or he could do his optional patch, and we
could rip it back out when the two are merged.

-Peff
