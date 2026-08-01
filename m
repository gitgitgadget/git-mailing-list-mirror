Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD72D5A19
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785593657; cv=none; b=QIKSjaUC1/iD1nwM/DbXI3sfQQT2ysi55xRMh7/QDyb8+frJI8JnV6NMgkktGCSL8CWCj96xStbf6J8kajvYnf1YyJpHHAWdG3rHLM0Gl5mV7YvEahDPMqWfyOKe0+VPxaXthh+EaylDdSCVM6ltGtUjv4ubqmeWxyE5lEb+0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785593657; c=relaxed/simple;
	bh=6VZ08o/zn5+4g5FKaJkss3qi3vvG+6Sk/eeW/6nSRHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VphJmyKxRRNKYkrmEoUUqsljWEddbIv6F+NezilrgQ2JoWuOcEAjWf8GTCrmAh7iqB63qBR1+/HpoQMBeiAFjVQQDF10A6yORakeKbTcZeNb32RuvbkQYjEZ2oR3NSbXEUsbIMxbYj3zBmI+M2C//mm2ZmqXGnWHYd8uuVFBUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V+ulG97N; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V+ulG97N"
Received: (qmail 9720 invoked by uid 106); 1 Aug 2026 14:14:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6VZ08o/zn5+4g5FKaJkss3qi3vvG+6Sk/eeW/6nSRHI=; b=V+ulG97NQZ1Gppq5+2dbOOirpu3lbjxIVHeQ32Kh418ZRY1xtjDC4SVsvlBUUo9CC8KWTKDmtHI+XnBBNapKjRihmRPOUqDuSQy1wIctSCAeDv6yqnllQAyJGMxvkGjqwFfsc59fxK71CQHxfcM/jWP7rlfS1HFttm72uPMbUtELlTiAPaJyjGow18jgA0a5bxMTRUaj8KISpJCGFBdhlT8O2OwX3Wft0kObNWvsOLZBfIFCavRyuYd3Sj+TETeGlfcWxx6gMrEjAvdZmTs89wkUCKH6DaDXHDgnJ7d2gbzALVhO0Qv9o3/fDj4icCxI8rjXY5I/G+ADPkkljh76sg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2026 14:14:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17374 invoked by uid 111); 1 Aug 2026 14:14:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Aug 2026 10:14:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 1 Aug 2026 10:14:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] git add --resolved
Message-ID: <20260801141414.GD2041176@coredump.intra.peff.net>
References: <20260728215219.753678-1-gitster@pobox.com>
 <20260731125605.3638938-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731125605.3638938-1-gitster@pobox.com>

On Fri, Jul 31, 2026 at 05:56:01AM -0700, Junio C Hamano wrote:

> When you are the maintainer of a project and make many merges day
> in, day out, a lot of your time is spent resolving conflicts and
> adding the results to the index.  It is not unusual to have local
> changes in your working tree that are unrelated to any particular
> merge [*].  In such cases, 'git add -u', which adds all changes in
> the working tree to the index, does not help much.
> 
> Here is a new option for 'git add' that lets you add paths with
> resolved conflicts to the index, while keeping unrelated local
> changes out.

I think this is a reasonable thing to want, but just playing devil's
advocate for a moment: how big of a footgun might this be?

We have some changes in the working tree, we try a merge and get
conflicts, do some resolving work and now we want to stage the
resolution but nothing else. How close is --resolved to that? I can
think of two corner cases:

  1. There are non-merge changes in foo.c, which also had some
     conflicts. Because we stage the whole file, we accidentally stage
     those along with the merge resolution.

     But maybe this is impossible, because merge would have refused to
     operate when one of the changed files is dirty? I think this is
     dependent on the strategy, but it should be true for most
     strategies. The exception is "ours", but that does not create
     conflicts in the first place. ;)

  2. Your resolution required touching other files (e.g., updating the
     caller of a function), but we'll ignore them. Git has no idea that
     those changes are related to the merge and not just stray changes.
     You have to remember to stage them manually.

     This is a problem even without --resolved, but I think it's easy
     for --resolved to lure you into a false sense of security that it
     is staging all of the important bits.

That doesn't seem too bad to me. I was mostly worried about (1), but
after digging into it, I think I've convinced myself that it's a
non-issue.

-Peff
