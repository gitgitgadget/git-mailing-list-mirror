Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AF495E5
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783757014; cv=none; b=rlZi53fUBcaEdCHex45dUHkodoO8S3Y0Jjsz51EZrCrjuzN4fE3esTidPghjTEyCJ2GP6TCfJ0JMMelwHxgNE5KyKSIAyEkZPmlO3groRt8+ADggsxBtsQBVDO0eFloaWm3yn+KYHpYUHi01U+iw4WAO9P/m7vzfNnligH6OpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783757014; c=relaxed/simple;
	bh=ZfOCQNl6p6DOQaxY5E7qZ/wWWvHqO1LFLkPjiHVSVhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5Y42TC7xwM+mMTpWC0l7OQtObgYZjHjYMFaBW9bt7ww4VJvMlsbtC5ejaTVgFrCKvDiSN0vMkioTCZZCTonxSLf6yEEjD1QA3g98NLhtJcJIyR4OcxbQsvvaCgxgRhWYC1N/yruJWztRyp2RyMED9lV4NvNHXDtEG4Knv+07gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c79cY+M0; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c79cY+M0"
Received: (qmail 55818 invoked by uid 106); 11 Jul 2026 08:03:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZfOCQNl6p6DOQaxY5E7qZ/wWWvHqO1LFLkPjiHVSVhw=; b=c79cY+M0Dz/9W4G9UVKWNMiPvb0HOPE7EMORGS0wSwMErN4A+eK72SgXZIeIbQJvjkarz3vq9RibJaque8RzzdgE+nqUsoF/yxHtXvouoX8oKhoKikCxOnQFmXuRsqB5eH2UFkIX0rybBrqk7OJAtP9SHrCVSNHo/iqvpn6un2msdRkLlhfBM8A0jEFbXCQi21tLCoYPLOd4fj30bouXI1odG8oW1NKy7+iiIJRVXIBtLHM0Se6cRMlKW2XZwwM6RolsNWlNxn6RCayfDleq1k+802HcsrAsiU/bkaE833+FDfunFEHD5ciaJp1AcG99lqyKVEg8XmG77B/47Wx20Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Jul 2026 08:03:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 95529 invoked by uid 111); 11 Jul 2026 08:03:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Jul 2026 04:03:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Jul 2026 04:03:31 -0400
From: Jeff King <peff@peff.net>
To: Omri Sarig <omri.sarig13@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Understanding why Git defaults to show author date and not
 committer date
Message-ID: <20260711080331.GB1470749@coredump.intra.peff.net>
References: <CAP9es6tyaGwfTguz5zgBmE5xN7MLDN3-rxRfo_JJBf79RCNzgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP9es6tyaGwfTguz5zgBmE5xN7MLDN3-rxRfo_JJBf79RCNzgg@mail.gmail.com>

On Fri, Jul 10, 2026 at 05:08:11PM +0200, Omri Sarig wrote:

> I understand the distinction between the 2 formats, and I can see the utility of
> both. I'm curious about the decision to show the author date and not the
> committer date as default one in Git commands.
> Are there some workflows where the author date is more relevant, or is that
> mostly a legacy decision?
> 
> I'd be interested in hearing about workflows where the author date is the more
> useful one, as I use the committer date almost always.

In a workflow based on mailing patches, the committer date is usually
much less interesting. It is "when the maintainer happened to pick up
your patch", as opposed to when you wrote it. Likewise, we show the
author's name by default, not the committer's.

-Peff
