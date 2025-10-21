Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADD269AEE
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033149; cv=none; b=twoxbIE3tUIpZzSfiTqQms1Znza4JJjO77tKHBwJS437ydMlyD8P9euehsQU6CGsiNVObo8M1OzcsBw3R0fnzmZp1yc43spMV9Phe56jecJq3D5cABRTLROw+z7uvKmwqqkP+NL9BEaVJq8mdvj3Ko6kMBktTO9Ug7qIQhgBqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033149; c=relaxed/simple;
	bh=LbGTY794bF0eXhPbgdQK3D1vwYdfRAJNJBXzpthPxmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M966L2VMuKEagsiyHfnha8HHH9ZhSmt2XFPDu9C3UaoFzb0/uxqcUmTEW1rNIZSyV1iUGvzE88jdvbVy9QE60Q2i0qMtmPvXZw3nUVjjuUsCyWXVWVhEjQBIADt6/t1ztnd5F/qJQeOuTGQv80osndJoEU1cZzt/c5TOVEBWG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HtTuADoN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HtTuADoN"
Received: (qmail 291883 invoked by uid 109); 21 Oct 2025 07:52:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LbGTY794bF0eXhPbgdQK3D1vwYdfRAJNJBXzpthPxmM=; b=HtTuADoN95ZvcKIxL0Eng9eT/Vev3HcVe9d02EPBKrfVG5U8zJd6PcJVWer2IXxLHrBkvkpYA0QH703PytRvEBWTBGdbuGRBwngUu3HrpyblQVSFKv5tj8jAMMPq2agD4lXR9TwNg/R9mVhDsU7Wn5luCtKTeLTnndw0sHCtbC2fWWZ8IBCNOKyn/92cUWp+B4qjJUA1yWZYQOpgnfaNn4kavlPb3aMt31uHD5PLw6wPKDAHrbES/scjScSHVsFVMhhPbYwYPmwtO3UVba1HuEM8y52Lmjida7H3QcxLPxXInUO/nJutsDhKW39S2XMCZn+Ni8ZdO5IE3j8P760e/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Oct 2025 07:52:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 454777 invoked by uid 111); 21 Oct 2025 07:52:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Oct 2025 03:52:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 21 Oct 2025 03:52:26 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jake Zimmerman <jake@zimmerman.io>, Lidong Yan <yldhome2d2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: restore redirection to /dev/null for
 diff_from_contents
Message-ID: <20251021075226.GC259661@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <20251017083641.GB4073661@coredump.intra.peff.net>
 <d5895f9c-5b3c-7a69-46e0-cf16cda5bf3a@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5895f9c-5b3c-7a69-46e0-cf16cda5bf3a@gmx.de>

On Sun, Oct 19, 2025 at 11:09:28PM +0200, Johannes Schindelin wrote:

> > @@ -6890,6 +6890,15 @@ void diff_flush(struct diff_options *options)
> >  	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
> >  	    options->flags.exit_with_status &&
> >  	    options->flags.diff_from_contents) {
> > +		/*
> > +		 * run diff_flush_patch for the exit status. setting
> > +		 * options->file to /dev/null should be safe, because we
> > +		 * aren't supposed to produce any output anyway.
> > +		 */
> > +		diff_free_file(options);
> > +		options->file = xfopen("/dev/null", "w");
> > +		options->close_file = 1;
> > +		options->color_moved = 0;
> 
> I do not see any discussion about the `color_moved` line in
> https://lore.kernel.org/git/20250808033019.78817-1-yldhome2d2@gmail.com/#r,
> nor here.
> 
> Since you re-add it, I consider at least a little bit of reasonsing in
> order, e.g. why this is necessary, and if it is necessary, why isn't
> `options->use_color` forced to 0 also?

My patch is a revert of the hunk from b55e6d36eb which caused the
"--quiet" regression, and hence includes that line. Perhaps I could have
made that more clear in the commit message.

I don't think use_color is related here. There's no clue in the commit
message which added that color_moved line (it was just the commit which
added the color_moved feature in the first place). But knowing the code,
I'd guess that it is not about trying to avoid producing color (which
is, after all, just going to go to /dev/null anyway) but rather avoiding
the computation to detect moved lines, since nobody will see them.

So probably (but I did not do any experimenting) the code produces the
correct output with or without color_moved. But it is also probably
wasting some extra CPU since b55e6d36eb. In a world with a dry_run flag,
it probably would make sense to skip the color_moved feature when
dry_run is set.

> Taking a step back to see the 100ft view, I can understand why you want
> that "extra level of protection" here. An even more important thing, that
> is missing, is a plan to avoid the need for this protection.

Sure. The goal of my patch was not to fix the dry-run feature. It was to
do the release engineering to undo the "--quiet" regression in the
simplest and least error-prone way possible. One way to do that is to
just revert b55e6d36eb entirely, add a new test covering the regression,
and then try again on top (perhaps on master this time). But I did the
more selective revert to reduce the back-and-forth noise of dropping the
dry_run code and then adding it back, which I thought gave the original
author a better base to work from.

Whether that /dev/null redirection survives once we are confident that
dry_run is hitting all of the code paths is up for debate.

I take it that you would prefer to try to fix dry_run in place on
'maint'. I think that can work, too. It's just not how I would do it
(not because I think this particular case is so hard, but because as a
general release engineering principle I prefer to fix regressions by
backing out changes rather than piling more changes on top). I am OK if
you want to go the other way, though.

> Given that you're still on GitHub's payroll if the hallway rumors are
> correct, I am quite a bit puzzled that you did not immediately reach for
> CodeQL (which is a GitHub-sponsored technology, after all) to get clarity
> on the code paths that would make this exra "layer of protection" still
> necessary, and thereby provide said plan.

There is no need to be puzzled. I have never actually used CodeQL at
all, beyond analyzing some of the false positives I've seen it report.
And the fact that GitHub sponsors my work on git.git is not really
relevant to how I go about that work.

> I started an AI-assisted brainstorm session and ended up with this query
> (which is neither as concise nor as comprehensible as I would have liked,
> but at least it does the job of finding the `run_diff_cmd()` code path
> that I also find, and no other code path, and in v4 of Lidong Yan's patch,
> it finds no remaining code path):

Neat, though it is very hard for me to quickly assess whether that
CodeQL block is doing the right thing. Your idea of manually tracing the
paths that touch opts->file seemed much simpler to me (and I think came
up with similar results).

-Peff
