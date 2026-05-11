Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275723BB40
	for <git@vger.kernel.org>; Mon, 11 May 2026 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529676; cv=none; b=dqKS9glstT74UE4HmggSb+XTK7L1KyfelTYuiGcQaAKOmfAcwi29C+dlXbTL/ua0biZRN6ROKUxD6PESY+F++QQDf0LDUUITrme04fdvTLATIlEHtciYjTi8ZfAxr79MJzxe9K84909LkOuXE/M9pXmBu0nseXJXdjAtgisojno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529676; c=relaxed/simple;
	bh=+TdXfFPnfRbUKq5JKI5is5w3MPZADtwuifyguSkUMLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS0RV2jX+Po7ALT1Jb3RXhwuW731DqjCBEr5t7T9JwiSlUNZLKQP5N7FkQZr64psoRKeqFJbMcXynr+Gru5vzRWw88o06HDdLxu5Y97g5xKPxcWZOskSjaNcvaq+EXQcS9BqCfPRrlTjlGlpnGtKPsV7+lHxj0Ryvi11nVRlDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PaF+MlrK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PaF+MlrK"
Received: (qmail 19296 invoked by uid 106); 11 May 2026 20:01:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+TdXfFPnfRbUKq5JKI5is5w3MPZADtwuifyguSkUMLI=; b=PaF+MlrK6F7ryTqCL42C5Q7DCHjeshW9mrwroo/x63y3DyGqbvubjuA7bJ6JDbnXTiMPG+U3Yy3icn0nF1Trr6wiTk0UAkHUDKVtUvaB5GMlDxY94e/HC+vXDt615MZ3OwNSk9R0j8IGZKI7UUC5VWVHjEwmypswBPkS7mWT3D0flg8+Nh1Jpvb3DKbMkwdWPapwg2rg2F8lCm2f7nQzhlvfW1KCujK3uS06UdzVV8pkC94zP2BuLM4qJnKowd8R2JcaQO5vNcmVexL2BvUnIGGuQSeUoA0KlffKWyVWkGdDlAs7jBtiDPnnl138LTwn86N1DAHS1xZ1QBt0lfxd0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 May 2026 20:01:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34186 invoked by uid 111); 11 May 2026 20:01:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2026 16:01:12 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 11 May 2026 16:01:12 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: jean-christophe manciot <actionmystique@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <20260511200112.GA22912@coredump.intra.peff.net>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
 <20260509175249.GA2336928@coredump.intra.peff.net>
 <af+snTGFeoUUyfPU@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af+snTGFeoUUyfPU@nand.local>

On Sat, May 09, 2026 at 05:52:29PM -0400, Taylor Blau wrote:

> Dropping and re-acquiring the lock is possible, but it's racy since
> there is a gap during the critical window while we fork(). I believe
> that the only airtight way to do this is to update the owner field of
> the tempfiles we want to pass down during daemonization.

It's racy in the sense that we might not get the lock back, but I don't
think that's _wrong_ exactly. We just care that some instance runs the
second half eventually.

It is technically vulnerable to starvation, if processes keep taking the
lock, doing the foreground jobs, and then losing the race to take it a
second time. But besides the fact that you'd eventually win by chance,
unless you have an infinite supply of processes coming along to run the
foreground half, the final invocation will run the background tasks.

I agree it feels pretty hacky. It is, however, how "git gc" seems to
work (notice that it does a manual delete_tempfile() on the lock right
before daemonizing).

> (As an aside, do we want to do that for all tempfiles? It might be nice
> to have a "->reassign_on_fork" flag or something on the tempfile struct
> in case there are instances where the parent wants to retain ownership
> of the tempfile after fork()-ing, but I can't think of any off the top
> of my head. If we do introduce such a field, it should probably default
> to "true" to avoid any foot-guns.)

I think the answer is yes, we want it for all tempfiles. Because it is
not a property of the individual tempfiles, but rather of the caller who
is forking. The point of that owner field is so that when we spawn
children, we don't end up with duplicate or unexpected cleanups.

But daemonize() is not about spawning a child or otherwise splitting the
process into two. There is still a single contiguous flow of execution,
and the fact that we switch pids and call exit() is an implementation
detail. So we would still want to remain the "owner" of any cleanup.

And that is true for any other atexit() handlers besides the tempfile
ones, too. If we called run_processes_parallel(), and then while that
child was running we called daemonize(), we'd not want to kill the child
then, but our atexit handler would do so! But we don't tend to leave
processes running while doing stuff like daemonize(), which is why we
never bothered to implement an owner field there in the first place.

> > Ultimately fixing the lock bug will solve that. Though if doing so is
> > too complicated for a quick maint release, I'm tempted to say we should
> > consider reverting 452b12c2e0 for a potential v2.54.1 (as there were a
> > few other regression fixes so far, I assume we'll have one soon-ish).
> 
> I think something like the following (untested) would do the trick:

Yeah, that's what I was envisioning. Note that there's a small race
here:

> +	switch ((pid = fork())) {
>  		case 0:
> +			reassign_tempfile_ownership(ppid, getpid());
>  			break;
>  		case -1:
>  			die_errno(_("fork failed"));
>  		default:
> +			reassign_tempfile_ownership(ppid, pid);
>  			exit(0);
>  	}

The parent is giving up ownership and the child is taking it. So there
may be a moment where both claim ownership, or a moment where the parent
has relinquished but the child has not yet taken. We're not going to
call exit() in the middle there, but a signal could kill us.

And then either:

  - If both claim ownership, it's mostly OK, because they'll both try to
    unlink() which is idempotent-ish. Though there is a bad sequence
    where we delete somebody _else's_ lock, like:

       1. Parent forks, but has not yet reassigned.

       2. Child calls reassign to take ownership. Now both have
	  ownership.

       3. Signal kills both parent and child, so they enter cleanup
	  code.

       4. One of them (let's say the parent) deletes the lockfile.

       5. Some other unrelated process (let's call it "git other") takes
	  the lock.

       6. The child deletes the lockfile.

    And at that point "git other" thinks it holds the lock, but it
    doesn't. It's quite an unlikely sequence in practice, though, I'd
    think.

  - If neither claims ownership and a signal kills both, then nobody
    cleans up the lock and it is left in place. This is annoying, but
    also something that can happen occasionally anyway (kill -9, etc).

I don't have an easy suggestion for making it more atomic, though. You
could choose one or the other direction using some synchronization
between the two (e.g., child reassigns only after parent signals over a
pipe that it has relinquished), but it's all kind of ugly.

So it may be reasonable to just shrug and assume it's unlikely enough
not to worry about.

-Peff
