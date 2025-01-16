Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5022ACD0
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035550; cv=none; b=hI2kurZUJujCxvhyaYsJKS+/V3jOyKR4DL7GzItb3eR5Ule3u+PHVlncKp8yywzbSIJ8C2C3HHWrqkfOukYc3jchIjT9alOij2pPgKj58ldgwn5cqaFTD9qyAbqHRgQsxR0hVpkb0FKlhExBPM7NtG54rfiLztob+Lx8vICZh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035550; c=relaxed/simple;
	bh=kTKirs77mQo6i2qcWJKN/IYJO+r49XvaCI4wM25Teu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptMOpNyEz3vjfwcl7WVbhDJc+ci78fJ1R4UzZ9ITe54DAVr8rIcCrJ/1tkJOSvkzOWs2CqAKkBGmfuduTAXIQHCH3vBEoqp6dL9aEIALUMYPaGYLZOvpY2YaO71lPxJRmRO84S54dVPgO25TS4epT/h4LbNEbauy0KVKPT9K7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GvFtOH1E; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GvFtOH1E"
Received: (qmail 14231 invoked by uid 109); 16 Jan 2025 13:52:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kTKirs77mQo6i2qcWJKN/IYJO+r49XvaCI4wM25Teu4=; b=GvFtOH1EaRHvfMczITf+oxHP2YY3ywtZiDtlimexZpmzqp5feQroxEaX3rXLZv3U6kWBDqEFTtnPCmQ8lBz/sHBHxoIPn8yMJP7/ULReVu1sBxdTMfUTw6Hgi9ITaBy/833HZRGIREnxd+3pg6JvKIatKE/RPwCvXwRuBBYaZ7O/2mdy6+AGqr4iqTti2eiUe752VU17jx6kgQlhdpQkf9ydVZlZr6KR97IA+pC/9QrlN+UWTtiTSieaigw47SNaPP4NEnc3Z/BCjUBqwPG9ZvfEGWqSz7sIbZwa/L16gcrvhu/XQYaKGGL90bxD3VaMIOkhkiyCDEkhUn2QgnzZ/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 13:52:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26358 invoked by uid 111); 16 Jan 2025 13:52:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 08:52:27 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 08:52:27 -0500
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Askar Safin <safinaskar@zohomail.com>, git <git@vger.kernel.org>
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
Message-ID: <20250116135227.GA2323616@coredump.intra.peff.net>
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
 <CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>
 <20250116105246.GF773990@coredump.intra.peff.net>
 <20250116125313.GA2301268@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116125313.GA2301268@coredump.intra.peff.net>

On Thu, Jan 16, 2025 at 07:53:13AM -0500, Jeff King wrote:

> I suspect that the whole bisection count algorithm needs to be rewritten
> to all run in a single traversal. I guess if you iterate over the
> commits in reverse-topo order, you should be able to just compute each
> distance as "d(commit) = 1; d(commit) += d(p) for parents(commit)". But
> it's not a problem I've thought a lot about, so I'm probably missing
> some subtlety.

Oh nevermind, that won't work, as it double-counts commits that are
reachable from each parent. Still, it feels like there ought to be a way
to compute it with a single traversal.

I think this is similar to the reachability bitmap computation, which
computes a bitmap for each commit (and then the weight of each commit is
the number of set bits, but we've removed the duplicates). We do that in
a single traversal these days, but it's pretty complex and heavyweight.

So I think there's room for improvement here, but it sounds non-trivial.

-Peff
