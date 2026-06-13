Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EED13C9C4
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359233; cv=none; b=eGi2RMSVUmg4/VDJkH/QsNeo5x3fh8yf67IuGTKoxAgUUzjtUGe81Veq97/hxEUf//XYjlCaYEoDeUTt7WvLGusHeiRBYYY9rZyVVK7V940Km5h7TJYeL6ztIIPauVn9GL94DdjASXx7Kec3TuufSCQk91O3ODo1Xyj8WbAZ+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359233; c=relaxed/simple;
	bh=8MyOllNZZOZesrWPhjmumsmX9RiVSbEjPBRMmYgk5pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6GDTlnFtSfhYTIAxxKtvL1lj/vKEtlo5Z9c+NVX8KnlpaeXa+UxkdsK1rLA/2HhAa8O87RyXFTxYLpEYKnThBgIlct+snOYbaJupLQ7cXbWRo6oTkXpS57K59nwLK34JICpqZXFhHJQuS7897a4cMB4NityHS78neQwWtfilHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cLPXj8+2; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cLPXj8+2"
Received: (qmail 127467 invoked by uid 106); 13 Jun 2026 14:00:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8MyOllNZZOZesrWPhjmumsmX9RiVSbEjPBRMmYgk5pc=; b=cLPXj8+2+a8oNjkVSXG/1vv9+lF6kbHI9XB+VVPVrAbJdSHjMTxslhVPFrMNvrgNrhXf77+T82O9pP8soPxfJpEyj+HRYPr47XeAkdwA4EYkMJTON7aiYNUIDE6YeEhXtI00T5goo0Mnbyc8VY/NSWJ36z+zK+0GWMDPvstDuOT0/K1nXXBwY/Rv2qnnvU/kE+Nhp6aGXfXh5mEYn+PITpCF22ddJzRK3zVvza0eYrV1nV4qzmKe4BQb1rqJIh58i234fuihSOkPeMYfvGCDBrwd5l7tpYepo8w7RiS5igjPjeRYtMwYGKWjt6GUbXkKOA+OUGuImZo0IU9zwe8sqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 13 Jun 2026 14:00:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 356930 invoked by uid 111); 13 Jun 2026 14:00:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 13 Jun 2026 10:00:25 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 13 Jun 2026 10:00:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 0/9] refs: stop using `chdir_notify_reparent()`
Message-ID: <20260613140024.GA766297@coredump.intra.peff.net>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260611065346.GD2191159@coredump.intra.peff.net>
 <aiukqI0Nj_RRn-wZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiukqI0Nj_RRn-wZ@pks.im>

On Fri, Jun 12, 2026 at 08:18:16AM +0200, Patrick Steinhardt wrote:

> > If we move to a world of all absolute paths where chdir-notify is not
> > necessary, will we lose that optimization?
> 
> Probably. Unfortunately, the commit doesn't have any repeatable
> benchmarks in there, so it's hard to say whether we could still
> reproduce those issues or not.

Here's an easy-ish reproduction specific to the ref code:

  rm -rf a/
  dir=$(perl -e 'print "a/" x 1024')
  mkdir -p $dir &&
  cd $dir &&
  git init &&
  git commit --allow-empty -m foo &&
  seq -f 'create refs/heads/foo%05g HEAD' 10000 |
  git update-ref --stdin &&
  time git show-ref

Before your series, I get timings like this:

  real	0m0.078s
  user	0m0.020s
  sys	0m0.057s

After, I get:

  real	0m0.876s
  user	0m0.004s
  sys	0m0.872s

So it really is measurable (and I did not expect the effect to be nearly
so large). Unsurprisingly the extra CPU goes to system time.

But obviously that case is quite silly. It's an absurdly deep hierarchy,
and 10,000 loose refs is a lot. Just running "git pack-refs --all"
brings the before/after to roughly the same timings (around 40ms --
faster even than the before timing).

So it _can_ matter, but I think ultimately the better direction is
probably "make fewer syscalls". Which we do via packfiles, and via
packed-refs, and eventually via reftables, all of which put more data
into a single file.

I offer the script above more as food for thought, and not necessarily
an argument against your series.

> Ideally, we'd have the best of both worlds: absolute paths everywhere
> without the performance hit. A while back I had a discussion with
> Torvalds on the securiy mailing list around this issue, and ultimately
> the conclusion was that the best way forward would be to use openat(3p).
> 
> This wouldn't only allow us to optimize cases like this, but it also has
> the added benefit that we're much less prone to TOCTOU-style issues and
> we might even be able to use flags like O_BENEATH. So it would basically
> be win-win. The only problem is of course that Windows doesn't have
> openat(3p), so we'd have to emulate it, and that's where I always lost
> the desire to do this.
> 
> When waking up this morning though I had the thought that we shouldn't
> try to emulate openat(3p) directly, but instead create a higher-level
> interface.
> [...]

Yeah, I think given a decent interface it might not be so bad. It would
mean code thinking about filesystem syscalls in a different way, but if
done subsystem-by-subsystem it might be OK to do incrementally. Much of
the code that would want to switch to this is using repo_git_path() or
similar already (and getting rid of those remaining static-buffer
functions would be a nice bonus).

I do wonder if your series here to move to absolute paths makes the
TOCTOU situation a little worse. With a relative path, once we are
"inside" the repo then we are only susceptible to changes within it.
Whereas with an absolute path, if one of the intermediate paths changes
from under us, there may be confusion.

Without thinking on it too hard, though, I'd guess if any such case is a
security problem, it already was during the "open" part (because it
implies that the attacker controls paths below you in the hierarchy, and
you had to get to your cwd _somehow_, at which point they could have
attacked you then).

-Peff
