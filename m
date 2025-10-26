Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A791DA60F
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761491924; cv=none; b=mNi5txdwIMU2uy0z9h8AXXik3gMUTv0BSibou4dwc8CX8s46C+Bn+M8RxYQhB9XLPF0EKAvi0R/K31ocuHFq/HVlNfpHUSppujXGetZ8S/TOBjCoO1znMCw5ISNboqLzjYY5ParJZFkwAf+iDQr86pjnl/TO98QEKs/EvLsV8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761491924; c=relaxed/simple;
	bh=O9OGvJaMdm0E/nGjNyL5/MR3ghv6L+VAyPPbGwfJy/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APYqdB143moHIlq6bWrzT3cpsKNACO4f438Mo7RvuoWJkddNPyYBrvS+xF28/aYzIiKnGTNMbyt5Leev1prmzmiJQEffCh9POkmnfScK04LSkOM6kZh97Hh0PTq+Z396RuIJiTtxEg0ntrqBqq4VtRf838Q6s2ojDP+mao7PZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O2eehq8l; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O2eehq8l"
Received: (qmail 346764 invoked by uid 109); 26 Oct 2025 15:18:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=O9OGvJaMdm0E/nGjNyL5/MR3ghv6L+VAyPPbGwfJy/E=; b=O2eehq8lu2eeZViVxERAiH216RRYyLjXMpmxsHILyu9p4aKrQB4EH9YY0p5QWruscExhsElXQmrUMOdSZF/YKG+w8iiWj91bMVItoyO+ZIKfMJRuoWd6xPoBxt+2OobGsUE+8Ow8N2kHcmpAGGyMHsvDP8/zYz4jjS+HzKx8K1pxMfrxVdUy/JvBk+Kw5Z9M4fP+O6WEAHK9Jjy6TN8KlWgOVDdKNQ7sL5Ln+9xJJ04Ht5K6GS4RPbR3xKXXaHpn9fM7lW768gpA0l8gArXGamu7unV6dcAp+32udCTo1kc7RshIGXLp81hWF2XWQ10roiPq9V3zxtIfvg7kddKYGw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Oct 2025 15:18:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 542292 invoked by uid 111); 26 Oct 2025 15:18:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Oct 2025 11:18:37 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Oct 2025 11:18:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
Message-ID: <20251026151836.GA2095501@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com>
 <20251014003404.GC1507@coredump.intra.peff.net>
 <xmqq7bwltlb8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7bwltlb8.fsf@gitster.g>

On Thu, Oct 23, 2025 at 01:28:11PM -0700, Junio C Hamano wrote:

> > I wonder how much this prefix-matching buys us in practice. There are
> > two cases that are helped:
> >
> >   1. When there is no wildcard in the pattern at all, we skip fnmatch
> >      entirely.
> >
> >   2. We do a raw match of the prefix chars, shrinking the size of what
> >      is passed to fnmatch.
> >
> > My suspicion is that most of the improvement comes from (1), and it
> > would be very easy to retain that case and get rid of (2). But I haven't
> > done any measuring.
> 
> The above matches my intuition as well.

I wanted some actual numbers, so here's more than anybody probably cares
to read on the subject. This is the test script I came up with:

-- >8 --
#!/bin/sh

pattern=$1; shift
path=$1; shift
versions=
for i in "$@"; do
	versions="${versions:+$versions,}$i"
done

rm -rf repo

git init repo
cd repo

echo "/$pattern" >.gitignore
for i in $(seq 1 1000000); do
	eval "echo \"$path\""
done >input

hyperfine -L git "$versions" -n "{git}" '../{git} check-ignore -q --no-index --stdin <input || true'
-- 8< --

The idea is to just match $path a million times against $path, with as
little other junk as possible. And we test it against a series of
builds, which are:

  - git.orig; the current tip of 'master'

  - git.none; ripping out the prefix-match entirely, leaving it to
    wildmatch to match those characters.

  - git.fullonly; leaving the early return when the prefix consumes the
    whole name, but not advancing name/pattern by the prefix amount
    before handing it to fnmatch

  - git.minusone; shrinking the prefix by one to give fnmatch one char
    of context (i.e., the patch under discussion)

Here are results for a long name that matches exactly:

  $ long='this is an extremely long pattern that has no globs in it'
  $ ./test "$long" "$long" git.*
  Benchmark 1: git.fullonly
    Time (mean ± σ):     311.0 ms ±   5.9 ms    [User: 302.5 ms, System: 8.4 ms]
    Range (min … max):   303.4 ms … 319.3 ms    10 runs
  
  Benchmark 2: git.minusone
    Time (mean ± σ):     316.4 ms ±   4.8 ms    [User: 303.5 ms, System: 12.9 ms]
    Range (min … max):   306.3 ms … 323.5 ms    10 runs
  
  Benchmark 3: git.none
    Time (mean ± σ):     455.3 ms ±  12.2 ms    [User: 444.4 ms, System: 10.8 ms]
    Range (min … max):   442.1 ms … 475.1 ms    10 runs
  
  Benchmark 4: git.orig
    Time (mean ± σ):     320.8 ms ±   6.8 ms    [User: 307.8 ms, System: 12.9 ms]
    Range (min … max):   311.7 ms … 331.0 ms    10 runs
  
  Summary
    git.fullonly ran
      1.02 ± 0.02 times faster than git.minusone
      1.03 ± 0.03 times faster than git.orig
      1.46 ± 0.05 times faster than git.none

So we can see that "git.none" performs way worse than the rest of them.
I.e., this optimization really is doing something. That wasn't
immediately obvious to me, since it's all O(n) in the end. But
presumably wildmatch's slow char-by-char walk is much less fast than
what amounts to a strcmp().

Interestingly fullonly is a little faster, even though we should never
be running the removed code in this case. I guess the function fits in
cache a little better? :)

Now let's try the same thing with paths that only prefix match:

  $ ./test "$long" "$long-\$i" git.*

  Benchmark 1: git.fullonly
    Time (mean ± σ):     472.1 ms ±   6.1 ms    [User: 458.0 ms, System: 14.0 ms]
    Range (min … max):   463.1 ms … 484.9 ms    10 runs
  
  Benchmark 2: git.minusone
    Time (mean ± σ):     334.4 ms ±   5.5 ms    [User: 324.3 ms, System: 10.0 ms]
    Range (min … max):   325.7 ms … 340.6 ms    10 runs
  
  Benchmark 3: git.none
    Time (mean ± σ):     461.7 ms ±   6.0 ms    [User: 448.8 ms, System: 12.8 ms]
    Range (min … max):   449.2 ms … 473.6 ms    10 runs
  
  Benchmark 4: git.orig
    Time (mean ± σ):     334.4 ms ±   3.4 ms    [User: 325.5 ms, System: 8.8 ms]
    Range (min … max):   326.0 ms … 338.1 ms    10 runs
  
  Summary
    git.minusone ran
      1.00 ± 0.02 times faster than git.orig
      1.38 ± 0.03 times faster than git.none
      1.41 ± 0.03 times faster than git.fullonly

This matches what I'd expect. git.fullonly performs even worse than
git.none now (because we're matching that long prefix only to hand the
entire thing off to wildmatch to do it again). There is a possible
optimization missing in the code for this case, where we know we've
eaten all of "patternlen" but not all "namelen" (so we know we cannot
match), but it's probably rare enough not to worry about (and certainly
fnmatch should be able to figure that out quickly).

The other interesting thing here is that git.minusone performs about the
same as git.orig. So adding one character back for fnmatch to process is
not a big deal. It's a small constant amount of extra work.

Note that neither pattern has a wildcard here! We could test that with:

  $ ./test "$long-*" "$long-\$i" git.*

but the timings are roughly the same as above. In either case, fnmatch
will accept or reject pretty quickly once it hits the part after
"$long". So all we are really measuring is how long fnmatch takes to
walk over that first prefix part without wildcards.


So the obvious takeaway is that yes, fnmatch is much slower than strmcp.
That doesn't tell us how _often_ these cases kick in. That is, the
intuition we were talking about above is that matching "foo" with "foo"
is a lot more common than "foo*" matching "foobar". And no amount of
playing with made-up inputs will tell us that. ;)

But my inclination is to leave the optimization in place, assuming we do
not find any more corner cases that foil the one-char-of-context hack.
It's not much code, and it definitely _can_ help.

-Peff
