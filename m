Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355A225A5
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7921 invoked by uid 109); 5 Jan 2024 08:59:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Jan 2024 08:59:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3028 invoked by uid 111); 5 Jan 2024 08:59:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Jan 2024 03:59:31 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Jan 2024 03:59:28 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <20240105085928.GA3078702@coredump.intra.peff.net>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <20240103090152.GB1866508@coredump.intra.peff.net>
 <xmqq8r56bcew.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8r56bcew.fsf@gitster.g>

On Wed, Jan 03, 2024 at 08:37:59AM -0800, Junio C Hamano wrote:

> This is totally unrelated tangent, but the way "show-index" gets
> invoked in the above loop makes readers wonder how the caller found
> out which $idx file to read.
> 
> Of course, the above loop sits downstream of a pipe
> 
>     find .git/objects/pack -type f -name \*.idx
> 
> which means that any user of "git show-index" must be intimately
> familiar with how the object database is structured.  I wonder if we
> want an extra layer of abstraction, similar to how the reference
> database can have different backend implementation.

I assume you mean a test helper by "extra layer of abstraction".

That could make sense, though I think this is just the tip of the
iceberg. There are a bazillion tests that muck with .git/objects/
directly (especially ones finding and munging loose objects). So it
wouldn't do much good until we know what cases the abstract code would
have to handle. And I don't think we have any concrete alternative yet
to the current object-dir layout.

So I think we should just punt on it for now. Adding one case here is
not making a hypothetical abstraction layer significantly harder to add
later.

-Peff
