Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB6208995
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597048; cv=none; b=iUiRIkk7VQYtK8Zb52E2BZcbH7k+gnDJh3AWkwjGvvSv0+o7mvXsDTJaBlx8Gqi6lc1qgZbd7rqg4iNM3Q9VmlYVS2rZ1dKobvT2xcTzhVDUk9lNMc2g9PpFrAjbAKrIiUMucQf4WZAUzSH4htow6sXbXovPEB5HMgF+A3dOyI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597048; c=relaxed/simple;
	bh=Z73zDV9JChA5FOZsG+3feExdHNIp8Ex+9vw5SNTYEDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyrYTnL/bHCb/raFRoODRK+YNlfRliYqfnoj5P6PyJLBERzNL8KLHJrQqKmV1BZ34E2xv1SxbiWfNVYEz74TpjWBF2K2KaX7dUZzav3wWv+ARPA71WwP6rZrPQ7ZfG3A7TAD/uLttN2UonRaxtImisvH7Ge3JlshcCC2/n5Mpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JpMMGGbL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JpMMGGbL"
Received: (qmail 18376 invoked by uid 109); 3 Feb 2025 15:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Z73zDV9JChA5FOZsG+3feExdHNIp8Ex+9vw5SNTYEDc=; b=JpMMGGbLpopiZdUrLbpHlIPjXNXRGsNMgvBx7/OWydP48GibLbxECH5nV0tbojwPyofEcOHVqGciEhovI5/EEAn4glcRsb2lKsCQr8N+6038vVoVWwksIFlvsPftcSelijVkhDsdPDbB++ouQgHVK8zRVxwxRAK2zm16KdfhfajQshBil5idBw9aLKisHfzZT/vx/4IqOJ5A2maqJko/RhVwl3VA4kjnbpmW9+dyoZm4AeV/6I/LU+ZTLSUhcC+ND+gW4QlDf+oUNZ0sBsuQeTGuXvu7twKiVheUHCziSrjOq9avpauDHZSKHAPtCSAa/IBOWCZH5pQmEvXlk+1ZeQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Feb 2025 15:37:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21313 invoked by uid 111); 3 Feb 2025 15:37:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2025 10:37:25 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Feb 2025 10:37:24 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: undefined behavior in unit tests, was Re: [PATCH v3 3/3]
 reftable: prevent 'update_index' changes after adding records
Message-ID: <20250203153724.GB4165842@coredump.intra.peff.net>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
 <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
 <20250201022409.GA4082344@coredump.intra.peff.net>
 <425859d1-d42e-42ee-b59c-723a519f0ad8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <425859d1-d42e-42ee-b59c-723a519f0ad8@gmail.com>

On Sat, Feb 01, 2025 at 10:33:13AM +0000, Phillip Wood wrote:

> > In normal production code, we'd expect something like:
> > 
> >    if (err)
> > 	return -1;
> > 
> > to avoid running the rest of the function after the first error. But the
> > test harness check() function doesn't return. It just complains to
> > stdout and keeps running!
> 
> That is to allow the test to add more context with test_msg() or do things
> like check all the members of a struct before returning. It is a bug in the
> test if it does not return after finding a NULL pointer, the correct usage
> is
> 
> 	if (!check(ptr))
> 		return;
> 
> As we're in the process of switching to using clar which does exit the text
> function if a check fails (that means there may be leaks on failure but if
> the test is failing then I don't think we should be worrying about leaks) I
> don't know if it is worth fixing these or not. I guess it depends if there
> are the list of targets for Seyi's Outreachy project.

Ah, that's good to hear. I don't think there's any urgency here. These
have been popping up since people started adding more unit-tests/ last
summer. Waiting a few more months to switch to clar is probably not a
big deal.

I'm OK with ignoring a leak in a failing test. I do suspect that
Coverity might still complain about the leaks, because it is doing
static analysis to show that we _can_ leak (rather than the tests, which
are seeing if we leaked at runtime). But I'm not sure how much effort we
want to spend on making tests do cleanup on failure. Especially in a
language like C.

Anyway, I'll continue to ignore these Coverity results for now, then. ;)

-Peff
