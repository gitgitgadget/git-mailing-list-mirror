Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108143E00A6
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275340; cv=none; b=pzKjdzljAWs1RVl5tk8YLf6SSc15shXpCJA4HKEe04ninI50NO3bHxcwAVBG/UyNyfYnB+ugYOPfCWTeOSqxJTZF+h+I9Y4jXWal2J4JjQnWXNGkOOyua9j+RWjZt3MvK6MpbLkEaOckiXwzKqvJjVD86u6VVzeaY5cSGtCdjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275340; c=relaxed/simple;
	bh=e+PWTb+nLExEDkF4MsGnEaxVEkiU1LidPQ5XbXUJ+1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNnY7WwGV7D/OEtlpZjZxJ04YqlKnJvVG/O91eOcJacRdA1Fp6DSZvyEBVY7LmYP3vaLCTOF/q9tZtqyVKTz1lY8Gd/OcVXJPQqOEWqLFLBuRipuZ+BMsjzgRoZd2kMzH0p6lw5JhPmEQsQ7CL1Bjx7Ph1KchlUYN1Wq4KGIzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YazIsr6O; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YazIsr6O"
Received: (qmail 51964 invoked by uid 106); 17 Jul 2026 08:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=e+PWTb+nLExEDkF4MsGnEaxVEkiU1LidPQ5XbXUJ+1g=; b=YazIsr6OJ1PSajoOqJ4qIqcifaO6zheh9LoI/4znW/qIzpqoZC2VuYYjoMpOl1usJ5lthkeKyFYJIx2FJU5uFQwtt4W2aI3QmjQd/vGeiM5KVijTXvq2bGeUrLshX4FOJJ2KSmp1Iqwofos8vV8cR6w+l4Bljkp51an1QDg9oieaB/AKfSKLdaD3XafvGgDUkZE8rflrMcJWr+upRdkH4S9vr1UuJCPjabqVlK0qDAR42qXRQ2TW1El67bpaDO5NnbTzXfW9lZk6H1Dw0P6D1zmjxaZrN6vrLapndAwzNPxX0D1CagyD/bQKUQYwG6BDqiZ681h5RT7VPJ+GLC4m7A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jul 2026 08:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 92290 invoked by uid 111); 17 Jul 2026 08:02:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jul 2026 04:02:21 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jul 2026 04:02:16 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Gusted <gusted@codeberg.org>, git@vger.kernel.org
Subject: Re: git-last-modified(1) slower than git-log(1)?
Message-ID: <20260717080216.GB1832790@coredump.intra.peff.net>
References: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
 <87v7afffpa.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7afffpa.fsf@emacs.iotcl.com>

On Thu, Jul 16, 2026 at 11:26:25AM +0200, Toon Claes wrote:

> The thing is, you're testing the difference on a single file. For us at
> GitLab, it wasn't very useful to optimize that use-case, because usually
> we want to see the last commit for a bunch of files at once.
> So the use-case for git-last-modified(1) for us has been to replace
> (pseudo code):

That was my assumption at first, too, but I think the log command there
really is returning results for the whole subtree. You just have to
post-process it to pick out the files from each commit.

> $ FILES=$(git ls-tree $COMMIT $PATH)
> $ foreach $FILE in $FILES; do git log -1 $COMMIT -- $FILE; end

Yeah, that is the most horrible way to do it. It's expensive in
processes, but also in walking over the same set of history repeatedly.

The log in Gusted's example does a single walk, but it is up to the
caller to then interpret the walk results. That would add extra time,
but I think it scales independently of the time difference he's
observing. In his hyperfine results, last-modified is scaling with the
total numbers of commits in the repo, but processing the output scales
to the number of commits which actually touched the subtree in question.

So I think it really could perform better than last-modified, even with
the post-processing step (which we didn't see nor time). But we should
be able to do better in last-modified using similar top-level commit
filtering.

-Peff
