Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D73A7F5D
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958080; cv=none; b=rY7NI3l4lnnOdizXvVSM2YIwQUInMY8ImdZbaC7+0VIGjdZdZJHoAJ/F3YcjewIqWP9c3Y9k1DYoUciVjwZKi8sNNeQhJY1+A3Weh2Yfg/7h+ff602iSUX6z1XMCXHR1kvx6PWt9Cvg7/d6xd9vpH2G7vfA1uBocfOxfWaX6a2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958080; c=relaxed/simple;
	bh=TRuUjfguJZJTm2dJoUH/HfX+3Yffa2+QLsgHq84FkgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhL36b0tIK/JterDvw0hqAkiDFxdzRkQ7ku/A9AFALZCLwauAV2TaUMra31MY4jBOAo3KGV8Xf+e4B9kdhYjdXVYxmofiiNT7SCOmGGK+N3jXGnxcuOJbCSVQw6JoTAR8CXH7l8B6+80KZQdwX//JQW0fOiKYoFyq+Au1JeJJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QFcybVSf; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QFcybVSf"
Received: (qmail 83549 invoked by uid 106); 8 Jun 2026 22:34:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TRuUjfguJZJTm2dJoUH/HfX+3Yffa2+QLsgHq84FkgA=; b=QFcybVSfHs5pI3dliJeewRbgMcNiQAxzfNDvNm7eehVAUCkya0s2HBxzxjn37a/EaO/YdunSsRMdn0bKoEBiziohQ63KXhfgo119Amvkkby6pA+BCdVs3/Dxs/UWThxyAOWKB/6jbBHrzNcT3lk2jKqHWZa+DrmGCFeMeNwdDlIY0eukzFEUISItqhYlE3+cE0EMVh3IQ1JrUZpniyjT9f4MudNLX3ODdg0TuKds79YlMWd+0D0se2tm6DbULx60CLm0+dMmD/su1eckqNGDpk9kE7w7/g/7Z/xExE1M5wRzsDwvVqdXhLmui8VLuHfRWP/CQmMyFnj/12jClbe5Ow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jun 2026 22:34:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 243805 invoked by uid 111); 8 Jun 2026 22:34:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 18:34:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 18:34:30 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] ref-filter: reuse --contains traversal results
Message-ID: <20260608223430.GA340696@coredump.intra.peff.net>
References: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>

On Sun, Jun 07, 2026 at 08:33:29PM -0700, Tamir Duberstein wrote:

> git branch and git for-each-ref call repo_is_descendant_of() for each
> candidate selected by --contains or --no-contains. Each call starts a
> new graph walk, so refs with shared history repeatedly traverse the same
> commits.
> 
> ffc4b8012d (tag: speed up --contains calculation, 2011-06-11) introduced
> the tag traversal that caches positive and negative answers across
> candidates. ee2bd06b0f (ref-filter: implement '--contains' option,
> 2015-07-07) preserved the branch and tag implementations when ref-filter
> learned --contains. 008ed7df930 (tag.c: use the correct algorithm for
> the '--contains' option, 2015-10-18) noted that they should be unified.
> 
> Use the memoized traversal for every ref-filter contains check and
> remove the implementation selector. The cache records answers for one
> fixed target list, so document that callers must clear it before
> changing the list.

The subject line obfuscated the intent here (at least for me). I think a
more clear subject would just be: "ref-filter: always use
contains_tag_algo" or something.

But more importantly, I think the analysis above is missing a key point
about why we didn't make the tag algo the default in the first place: it
is depth first, and thus slower when the merge base can be found quickly
by the breadth-first traversal. For tags, you tend to have to look at
all of history anyway (because you have at least one old tag that
requires walking back that far), but that is often not true for
branches.

We are able to get the best of both worlds if we can cut off the
depth-first traversal early using generation numbers.

So I think a better rule here is to tweak the selection in
commit_contains() to select the depth-first algorithm when we have
generation numbers enabled. There's a patch in an old thread, which was
revived a week or two ago by Kristofer (cc'd):

  https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotify.com/

> The memoized depth-first walk assumes acyclic ancestry, but replacement
> refs can create cycles. Track commits while they are on the walk. If a
> cycle is found, discard partial cache entries and use
> repo_is_descendant_of() for that candidate.

I can believe that the depth-first code doesn't handle cycles well. But
if that's the case, then it's already a problem for "git tag
--contains". And we should fix it as a separate patch from enabling that
algorithm in more cases.

I'm not quite sure how ancestry should be defined in a cycle. How does
the algorithm behave now when it sees a cycle? If it loops infinitely,
we definitely would want to fix that. If not, then to some degree I
don't care too much what answer is provided, since the input is somewhat
nonsense in the first place. And if it is expensive to track, it might
not be worth inflicting that penalty on the sane cases. But it looks
like your solution is just setting an extra flag value in the slab,
which should be pretty cheap.

> The branch and for-each-ref path passed repo_is_descendant_of() through
> a Boolean interface. In configurations where it returned -1 for missing
> ancestry, ref-filter treated the error as "contains". The memoized path
> instead fails when ancestry cannot be parsed, as git tag already did.
> During review of the 2018 reachability series, making parse failures
> fatal was explicitly deferred because that series was intended to
> preserve behavior. Unifying the implementations now makes all callers
> fail consistently instead of preserving that accidental Boolean
> interpretation.

I think that's a good outcome.

> The added p1500 case uses up to 8,192 packed refs along one first-parent
> history. It improves from 0.68 to 0.03 seconds.
> 
> On a checkout with 62,174 remote-tracking refs, I ran:
> 
>     hyperfine --warmup 0 --runs 3 \
>         --command-name parent \
>         '"$parent" branch -r --contains c78ae85f3ce7e >/dev/null' \
>         --command-name this-commit \
>         '"$this" branch -r --contains c78ae85f3ce7e >/dev/null'
> 
> The results were:
> 
>              parent       this commit
>   elapsed    104.365 s     467.7 ms
>   user        93.702 s     220.2 ms
>   system       0.723 s     182.7 ms

I didn't time it, but the probable regression case is something like
this: a very deep history with a small number of branches diverging only
a few commits away. Without a commit-graph file (or one without
generation numbers), that probably makes "git branch --contains" slower.

-Peff
