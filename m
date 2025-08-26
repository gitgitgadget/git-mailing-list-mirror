Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B95224AE6
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 04:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756182372; cv=none; b=C9rVmztaBFnSpxxHH+DWgh8U6dABv4+U6V5OvOhwKU6o2+fs5W4J6N0bS0gp4p1tL0e5RSZdlRu7g7zkrn5U3743HaCIX01FMy9poDVmDmijpJ4s4h9vWG1gtqZ4wrYBHL60mYRAaW/a2mhsg+zcydIjshFYMby4GVSBfHvAjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756182372; c=relaxed/simple;
	bh=1IajHtUCI8MUyTTbqN7OHvGXywZ+eLp80j3cvojGybo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKP6fGOIWwXKBc6pxtBzAPECBamwsQCJw1/Ps+q7+ul2SuMaALtphiY/4v4dNLYgQhLHFieWnHXVQRwYXSeeNG3kk2u+jC8LmQC7XSyX7TvE6ege8lRjS1aWOovakWPOfjLajlXMQ26Q/Fl2ZQYsehPUFRTE4bth2OXVWp2wyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JOD9ap15; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JOD9ap15"
Received: (qmail 114332 invoked by uid 109); 26 Aug 2025 04:26:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=1IajHtUCI8MUyTTbqN7OHvGXywZ+eLp80j3cvojGybo=; b=JOD9ap15S/6uwbhVmWnLhIFTtfK0XpvCIi1pw3X2yvLca38N6/yTYIwYBMMvHmXKMWYOKP7cye/AuAhgvFcsmWWLwO7B9qCLw6rN73+LRwdO30/N1RewIu5lkFx6Kxl5pKqdiOyJuToi6pgeZ1KWBYluOGYysZSYlbT2q1KNgNiYDD11GTNfyAapHigYQs6PSdPiO1yjEkfKuvYOSx5MEfvDhWd+y7xbBjd+xhJJY0R6fV+s3oIMgUTkShBSpskkmC8i2I1fuvsGaYJpmudfRjytpt2CkbY7nLHhiYHkINqDGUaxDc3SgvK5PwaKxv1iNk5XJWx8eG7bFzrAblQqhg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Aug 2025 04:26:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166693 invoked by uid 111); 26 Aug 2025 04:26:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Aug 2025 00:26:08 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 26 Aug 2025 00:26:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250826042607.GA995491@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <20250825081345.GA352784@coredump.intra.peff.net>
 <xmqqcy8jqlue.fsf@gitster.g>
 <20250826033920.GA388997@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826033920.GA388997@coredump.intra.peff.net>

On Mon, Aug 25, 2025 at 11:39:20PM -0400, Jeff King wrote:

> > But the hash function being oidhash(), I am a bit surprised.  It
> > shouldn't be so much more expensive to peek at the first 4 bytes and
> > then do the usual hashtable thing than looking at the in-object
> > commit->index.  Is it a sign that the range of oidhash() is a bit
> > too small for a real workload?
> > 
> > Nah, 4 byte unsigned integer should be sufficient for the number of
> > objects in the kernel.
> 
> I was surprised, too. I expected it be maybe 20% slower or something.
> Which really makes me think I've managed to screw up the patch, but if
> so, I don't see it. I tried profiling the result, expecting to see a
> bunch of extra time spent in obj_timestamp_put() or obj_timestamp_get().
> But I don't. They account together for only a few percent of the
> run-time, according to perf.
> 
> So I dunno. I am confused by the results, but I am not sure if I am
> holding it wrong.

OK, maybe I am just holding it wrong. I think I may have mistakenly been
using the wrong timing for my baseline (maybe --date-order instead of
--author-date-order; the latter is _way_ more expensive because we have
to open the commits to parse the author date).

Here's a more apples-to-apples comparison using hyperfine. On git.git:

  Benchmark 1: ./git.slab rev-list --author-date-order HEAD
    Time (mean ± σ):     547.3 ms ±  12.2 ms    [User: 535.8 ms, System: 11.3 ms]
    Range (min … max):   536.1 ms … 566.4 ms    10 runs
  
  Benchmark 2: ./git.hash rev-list --author-date-order HEAD
    Time (mean ± σ):     558.6 ms ±  11.2 ms    [User: 542.4 ms, System: 16.0 ms]
    Range (min … max):   544.4 ms … 572.6 ms    10 runs
  
  Summary
    ./git.slab rev-list --author-date-order HEAD ran
      1.02 ± 0.03 times faster than ./git.hash rev-list --author-date-order HEAD

So a little slowdown, but within the run-to-run noise. And on linux.git:

  Benchmark 1: ~/compile/git/git.slab rev-list --author-date-order HEAD
    Time (mean ± σ):     11.020 s ±  0.131 s    [User: 10.764 s, System: 0.254 s]
    Range (min … max):   10.886 s … 11.262 s    10 runs
  
  Benchmark 2: ~/compile/git/git.hash rev-list --author-date-order HEAD
    Time (mean ± σ):     11.682 s ±  0.204 s    [User: 11.398 s, System: 0.282 s]
    Range (min … max):   11.424 s … 12.139 s    10 runs
  
  Summary
    ~/compile/git/git.slab rev-list --author-date-order HEAD ran
      1.06 ± 0.02 times faster than ~/compile/git/git.hash rev-list --author-date-order HEAD


A little more measurable there. Those numbers are more in line with what
I was expecting. I'm not sure what it all means, though. 6% is enough
that it is probably worth keeping a custom data type like slab around.
Though it would be nice to have a data type that worked on all object
types and didn't necessarily use a ton of memory.

This particular case may not be representative, either. I picked it
because it was easy to convert. But I wonder how bad it would be to put
the object flags for a traversal into a hash. Right now those are in the
original struct, not even in a commit-slab. So I'd guess it's an even
bigger slowdown.

-Peff
