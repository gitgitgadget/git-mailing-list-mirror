Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB1338F83
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362107; cv=none; b=rJKtTFGiDb7qbRUdmTGHt9DnSCztvKn3s+nFddVtRkGfpLUEWHUUzdV5J0Lq7cSVdPW2txmU4roJaeS5mXPOZorUS4g13UfUzT6ilZ9YAZoOZs8Jr9WU/rslDnV/WEd1MRmrtNbCWOeQeln/fQ/hNR1WSoMj8v8m85PmDfLf650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362107; c=relaxed/simple;
	bh=xqM8ypDO36VTY+LStEqK2e6ckQn0EQnOwFlqm3cfeso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDmgwWHZXihBvXqmcOVVhRCSwXaxNpgS98bzGZ3qGcayVNRB25TqbylnhQ/xVdxEZSvGO6X9/I5Q8SgsEMz7ZeUcnZW7T0l9DAeYv8MbhC7ehpSceXV7mn3gVOnpO3StZbQdCl/0FIHGtLJM9uBE72a+eqkoYk3IifxD8vSUlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=azVHa3LM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="azVHa3LM"
Received: (qmail 21839 invoked by uid 109); 11 Nov 2024 21:55:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xqM8ypDO36VTY+LStEqK2e6ckQn0EQnOwFlqm3cfeso=; b=azVHa3LMDbD72m2wYNGTAln87b+fPkixDFheemA6luUsc8NWwNwgJiD6SQHGqBvUsHQ4b+cpQNvbNgET9652iesxo0nsMiXQXPiJvhKE2qkZTRTIYcRuMUXWX4zf/Kq74ldOYfxqJNjZFqkYotXldL832Vgmwsp9OkK+ZFCTiSpKP8MXW93VNQYZA22xZyUaE8PTt6StbrZzQcxs7DOFGOx8aOyEdrbThqHvxgm3mRo9THNhE9cJcSz7BkmofVgHKpr3viYJHJhgkO+JubNTZFBRExSmwZHvDqE/rH8nDLXtMkfcZ13pSaQX9sPEqP54PLk3yGL4SBPgtMz6nFuD0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Nov 2024 21:55:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20486 invoked by uid 111); 11 Nov 2024 21:55:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 16:55:05 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 16:55:02 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, ps@pks.im,
	johncai86@gmail.com, newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
Message-ID: <20241111215502.GC5019@coredump.intra.peff.net>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <ZyUqr/wb5K4Og9j9@nand.local>
 <2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
 <20241104172533.GA2985568@coredump.intra.peff.net>
 <xmqq1pzqwnck.fsf@gitster.g>
 <f02ee8ac-01e4-42e3-b99a-d9616b9ff1bb@gmail.com>
 <xmqqo72miim6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo72miim6.fsf@gitster.g>

On Mon, Nov 11, 2024 at 11:56:01AM +0900, Junio C Hamano wrote:

> > Yes. This is the downside of the --full-name-hash compared to the
> > standard name hash. When repacking an entire repository, the effect
> > of these renames is typically not important in the long run as it's
> > basically a single break in the delta chain. The downside comes in
> > when doing a small fetch or push where the rename has more impact.
> 
> Yes.  Due to --depth limit, we need to break delta chains somewhere
> anyway, and a rename boundary is just as good place as any other in
> a sufficiently long chain.

We don't necessarily have to break the chains due to depth limits,
because they are not always linear. They can end up as bushy trees,
like:


  A <- B <- C
   \
    <- D <- E
     \
      <- F

We might get that way because it mirrors the shape of history (e.g., if
D and E happened on a side branch from B and C). But we can also get
there from a linear history by choosing a delta that balances size
versus depth. In the above example, the smallest sequence might be:

  A <- B <- C <- D <- E <- F

but if we have a limit of 3 and A-B-C already exists, then we might
reject the C-D delta and choose A-D instead (or I guess if it really is
linear, probably B-D is more likely). That may be a larger delta by
itself, but it is still better than storing a full copy of the object.
And we find it by having those candidates close together in the sorted
list, reject C-D based on depth, and then moving on to the next
candidate.


I'm not sure in practice how often we find these kinds of deltas. If you
look at, say, all the deltas for "Makefile" in git.git like this:

  git rev-list --objects --all --reflog --full-history -- Makefile |
  perl -lne 'print $1 if /(.*) Makefile/' |
  git cat-file --batch-check='%(objectsize:disk) %(objectname) %(deltabase)'

my repo has 33 full copies (you can see non-deltas by grepping for
"0{40}$" in the output) out of 4473 total. So it's not like we never
break chains. But we can use graphviz to visualize it by piping the
above through:

  perl -alne '
    BEGIN { print "digraph {" }
    print "node_$F[1] [label=$F[0]]";
    print "node_$F[1] -> node_$F[2]" if $F[2] !~ /^0+$/;
    END { print "}" }
  '

and then piping it through "dot" to make an svg, or using an interactive
viewer like "xdot" (the labels are the on-disk size of each object). I
see a lot of wide parts of the graph in the output.

Of course this may all depend on packing patterns, too. I did my
investigations after running "git repack -adf" to generate what should
be a pretty reasonable pack. You might see something different from
incremental repacking over time.


I'm not sure what any of this means for --path-walk, of course. ;)
Ultimately we care about resulting size and time to compute, so if it
can do better on those metrics then it doesn't matter what the graph
looks like. But maybe those tools can help us understand where things
might go better (or worse) with various approaches.

-Peff
