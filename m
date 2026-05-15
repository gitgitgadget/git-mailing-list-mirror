Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32629380FE9
	for <git@vger.kernel.org>; Fri, 15 May 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864497; cv=none; b=M6wzT0hVzKXzKTw2zHa6tT4EMv8Fp/+bYlBv17Fp4uFsuJGitewbqV2vMB2qCKTUEIVQsCBLb8SpK0kPQmw0ahRoFHJdg39WvzNZBQKb00Jlptr7s4nsFr1/hV30bOKq6Umft0UJw7fkHid/hdThn2YoKjS803keeA1b5om8C+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864497; c=relaxed/simple;
	bh=AXWtUUmpsAq3K2DQN6rJT1PKxdimUE0gOBbZBtymPgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No0P3LIHncoY+7nJVIr1SQ0cRl6GPOByuSQuAVpy/O4H/aHJkUOG8t9MmrwGuVstVvYMnNOP1x7ZbBRvgyRqgAZzixWfxpY5ikjugM8mkwUNhOXPUSrw4SejBqfHT7M5DTwcio4lq5dV1JmlgnoiC9zTg0HFKK6ehPJQML5DBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AutvLU7c; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AutvLU7c"
Received: (qmail 56009 invoked by uid 106); 15 May 2026 17:01:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AXWtUUmpsAq3K2DQN6rJT1PKxdimUE0gOBbZBtymPgQ=; b=AutvLU7ckZi4TDW3P6c6qY6lgeGxLVk6vQy0yQvdN1bu5q0Z1SCC97WgNrA5oDEMOVkZXFbwbLAaQ9+foogpuqwLnZQeTVUkqobN0LDlNwWmnIv46w7yjiyXRt/nk779zuV8oXjDgaCYwOE+DgsWcEuaQKDbBJjWYyYTfHjVFKRzydNpiwMuQRE+n6sAc1fcFW4GEdpqfBSFAPteYKBXOAT1lls/JBTCLSdYQXW8reobDQfKNzZm9v8icz0tHYXl/WsHnZWu3u7+hbXmzlYuFM8/3GKlBl5yCCp9vASMoLEW5XvHL5yhfhBK/gjGJY2+bXg6DUVekE6ClIvnbz/nFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 17:01:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 104047 invoked by uid 111); 15 May 2026 17:01:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 13:01:34 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 13:01:34 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	slonkazoid <slonkazoid@slonk.ing>
Subject: Re: [PATCH] http: handle absolute-path alternates from server root
Message-ID: <20260515170134.GC88375@coredump.intra.peff.net>
References: <20260512162619.GA69813@coredump.intra.peff.net>
 <xmqqo6ikjeqp.fsf@gitster.g>
 <20260513185825.GB147423@coredump.intra.peff.net>
 <agbOEsZ8NmE8SyfV@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agbOEsZ8NmE8SyfV@pks.im>

On Fri, May 15, 2026 at 09:41:06AM +0200, Patrick Steinhardt wrote:

> > We talked about dropping it a few years ago, but Eric countered that
> > dumb clones are easier on the server in some cases (like gigantic
> > public-inbox repos that are packed to keep most of the old history in
> > one big pack that is never updated). The verbatim pack-reuse feature
> > tries to get smart clones closer to that, but it's hard to beat serving
> > a static file from the server's perspective. I haven't measured anything
> > in that area in a while, though.
> 
> In theory we can get much closer with packfile URIs, too, can't we? If
> the packfiles are directly accessible anyway the server could just
> announce these directly and have the client fetch them. That should
> significantly reduce the load on the server even further.

Packfile URIs help with the actual pack generation (even if we're
blitting out bits from the disk with verbatim packfile reuse, we still
have to handle gaps and compute the checksum over the output pack).

But it doesn't help with the server computing the set of objects the
client needs in the first place. IIRC, packfile URIs work by the server
saying "oh, I was going to send you object XYZ, but you can get it from
this stable pack instead". So the server still has to compute the set of
objects (and send any that are not mentioned in URI packs). Bitmaps
help, but there's still non-trivial computation and storage on the
server.

Contrast that with a client that instead pulls a packfile over dumb
storage on its own, and then comes to the server for a top-off fetch.
The server still has to do some computation, but it's usually quite
small, because both sides agree quickly that there's no need to dig down
further than the tips in that dumb packfile.

> Of course, the big downside is that "fetch.uriProtocols" is empty by
> default, so Git will not use them. Makes me wonder whether this is
> something we want to eventually change, but I guess the current default
> behaviour is somewhat insecure as it would allow the server to redirect
> clients to arbitrary locations. It would be great if we had a mechanism
> that only allowed packfile URIs that use the same host, which would make
> this a lot more reasonable to enable by default.

It's been a while since I've looked at it, but I seem to recall that the
server-side tools for specifying which packfile URIs to use were not
that mature. Maybe that has changed, though (I'm probably 5 years out of
date since the last time I really thought about these things).

-Peff
