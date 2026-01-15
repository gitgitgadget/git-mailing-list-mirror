Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD226D4C7
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511351; cv=none; b=h2GCDMCqLFtAfq14DuB/C7qIVJ5oLO3nbTlyU0xUI4dDc7KxHCCN/Xn6GFExHual8kEw5EyXIVf3+r2Z11U5o8mTJOtKZSJoJ3ny/7br4TcMlojq9Qh2tDT8vxdsDMIAuwwTFo1xzbr8z6C/IC6GKfK6R8D83TkQK4WFsKkw6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511351; c=relaxed/simple;
	bh=a/alDqQwcvsAxckdaqFfbK1AHqx1pA1P593VO8BrTIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjPBs+mPazpyR1TStJhA6ryOfJXq1bGdLwz3AecfoQLgu3LdN9WqSszaRn5eNIaMPs0oiQRIx0ieP7Hb5uihnaj02yuyj01vig5m8Atqi6wjv3KJdCWaddoxeC8W0rOAjliTzInDbtmh1n3Ch+dFhfSGqXODB6zEumjaMt3VnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZAf6IZCz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZAf6IZCz"
Received: (qmail 50654 invoked by uid 109); 15 Jan 2026 21:09:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=a/alDqQwcvsAxckdaqFfbK1AHqx1pA1P593VO8BrTIk=; b=ZAf6IZCz2kOoFiTNi4fO+nmd57cpZh0F9Cdg6sK0d61/xe+R0Pwnfa3FRku3kkL+19PMbz3esXtOLy5WkQzT1/hO1ZNQn/vrMXp+zeAerjSuD8lPw1HAtqr9qetGymhTrSWaXTgBZbdYiYKY7xkUBD1TRVjNA3lsp+Kz7zAcd25Qm0RTMJP5l3HhgLOzXkaro+1WYJo7FEv8ZK+xj0ld0ulzzKnQLg7QI+vSEA2Ep7KIH8qZsyLtE/mJm4/Wmmsv+NLyflfoZ46wl4iBzyJyTKQKwmf/BwYhtXcvGt9m/8bzkEy63Ptf4SCTCnSKuapwEMZXq9NMxfmiVnJZuOtiAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jan 2026 21:09:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 83025 invoked by uid 111); 15 Jan 2026 21:09:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jan 2026 16:09:10 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Jan 2026 16:09:08 -0500
From: Jeff King <peff@peff.net>
To: Martin Fick <mfick@nvidia.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <20260115210908.GE1053259@coredump.intra.peff.net>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aVyxbqk-2QQIgDXK@pks.im>
 <CH3PR12MB9026F1E4B99D32E138800EEBC287A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aV5GwOS_N2jyIFaz@pks.im>
 <CH3PR12MB9026C8C940270F02CEF83C4FC284A@CH3PR12MB9026.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH3PR12MB9026C8C940270F02CEF83C4FC284A@CH3PR12MB9026.namprd12.prod.outlook.com>

On Wed, Jan 07, 2026 at 10:58:36PM +0000, Martin Fick wrote:

> I ran perf, and got a flame graph, I am not sure what the best way to share that
> is, but I will try to summarize what looked important:
> 
> About one third of the time is in this section:
> 
> libc-2.17.so 32.5%
>  _memcmp_sse4_1 29.8%
>  page_fault 7.23%
>  ...
> 
> I am not really sure what that is doing?

Probably this is the call to strcmp(iter->ref.name, update->refname) in
packed-backend.c:write_with_updates().

We have to write out the new packed-refs file with our updates in sorted
order. So it's a big O(n) merge between the existing ones (from the
"iter" side) and the new ones (from the "update" side).

It could also be caused by sorting of the packed-refs entries. We
generally shouldn't need to do that, but I think I may have found
something useful. See below.

> unpack_object_header_buffer 30%
>  page_fault 26.9%
>  ...
>  nfs_read_page 10%
> 
> Which could very well be looking at the headers of objects to see if they are 
> tags needing to be peeled?

Yeah, that's what I'd expect here.

> And the remaining third was a bit all over the place with small sections,
> the largest two of those sections being:
> 
> packed_refs_store_create ~8.7%
>  unknown 4.4%
>  memchr 4.4%
>  page_fault 4.4%

Hmm, I don't think we have a function "packed_refs_store_create". Did
you typo while transferring the name over?

At any rate, we can assume this is poking through the packed-refs file
itself, looking for trailing newlines via memchr.

But why would we do that immediately when creating the packed-refs store
in memory? In modern versions of Git, we try to avoid reading the
packed-refs file as much as possible, binary-searching when we can. Of
course that means it has to be sorted, which was not something promised
by the original format. So we have a "sorted" tag that we write. E.g.,
this is from my clone of git, packed with git itself:

  $ head -n 1 .git/packed-refs
  # pack-refs with: peeled fully-peeled sorted

Now let's try something with jgit:

  git init
  git commit --allow-empty -m foo
  git branch foo
  git branch bar

  jgit pack-refs --all
  cat .git/packed-refs

That gives me this:

  # pack-refs with: peeled
  86054aaedc64c24aec8aaad988f6979a3cb82ee0 refs/heads/bar
  86054aaedc64c24aec8aaad988f6979a3cb82ee0 refs/heads/foo
  86054aaedc64c24aec8aaad988f6979a3cb82ee0 refs/heads/main

Aha! So jgit is not writing out the "sorted" tag. As a result, when git
reads the file, its logic is:

  1. Check for the sorted tag. It's not here, so...

  2. Check if the file is sorted by reading each entry linearly. If it's
     not, then...

  3. Read it all into memory and sort the result. We can then
     binary-search that (and iterate it in sorted order, which is
     important for pack-refs).

So when git reads the packed-refs file, we are ending up at least with
step 2, an extra pass through the whole file, and maybe to step 3
(depending on whether jgit actually sorts the file).

You mentioned that Gerrit writes the packed-refs file directly itself,
presumably using jgit. So it sounds like it is constantly undoing Git's
"sorted" marker, which causes git-pack-refs to spend extra effort
checking the sortedness, and rewrite the marker, which then gets hosed
again by jgit, and so on.

And that may explain why jgit is faster, if it is not doing the extra
sort check. If it is not even trying to maintain the sorted property
that it would be faster still (it takes one linear pass while writing
out the file, omitting entries that match our updates, and then appends
our updates at the end).

If jgit _is_ sorting the file but not writing out the sorted marker,
then it should start doing so. ;)

If it's not sorting the file, then probably it should start doing so
(and writing the marker). This will make subsequent reads much faster
(mmap + binary-search). It shouldn't even be slower to write (assuming
jgit's writes are doing the usual "rewrite the whole thing to a tempfile
and atomic-rename into place", and not taking some shortcut by appending
to the file).

Unrelated to your problem, but also jgit should support the fully-peeled
tag, another thing that makes readers faster. ;)

The jgit version I'm using is:

  $ jgit version
  jgit version 7.5.0.202512021534-r

One way you could test this theory is to sort and mark the file
yourself, before running "git pack-refs". One easy way to do that is to
convince git to rewrite it by removing an entry. I.e., find some ref
mentioned in the pack-refs file, and then "git update-ref -d $ref". And
check out the first line of .git/packed-refs before and after. If it
goes faster (and similarly fast to jgit) only when the "sorted" tag
appears, then that would be our culprit.

-Peff
