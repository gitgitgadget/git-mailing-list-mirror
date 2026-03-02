Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2753112B2
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474256; cv=none; b=cFPa2iuXh/lN6uhVCDTMERalhmRz5ZLmpJXQoa5Dc30eUKEKHI4kFbgh9OIdXZAzW7CNf8zb1tBeYVjCGYv2maW2jYRw+7Mj8oggVmuU3rwbM0UbxIcpKCMmggwaPBJpDMZxmdKBivQVZPahCnU8gOGh6boYWkK9TkD6TUSCefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474256; c=relaxed/simple;
	bh=qQ//clPLRLAwmLBxizCPRu9WEmeP6L6ufUuKl+lLkjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdszpFrJgGstQM1FTFIBCtg7FRLZMWA1GWDMAj9+/cuEYkSEGEZ57fl+no4UG9KpVwIL3egdnKaXylereBGb9agbZSho12JN3wI5dgXOlQ7/g7rcamg4HsLOegDpgFh9HlZeyDSKuSovUTsZhz3Uy5CiIIwWCIShW4GGjosi8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XqI9xWff; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XqI9xWff"
Received: (qmail 28670 invoked by uid 106); 2 Mar 2026 17:50:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qQ//clPLRLAwmLBxizCPRu9WEmeP6L6ufUuKl+lLkjo=; b=XqI9xWffqWr/V7Ua0r43wJM9UI+nc4ED7yytMpxgbz+uAPuOlXu56YeqFMH0vaTbmGChgt0479pB+swAxFb9ftWbeL5g7KQZft6+fPwRDkGw6E8jIj3IdC/XCOQS3x+bWN604FdFOp5i1upbgqn/IqTrPbT93scpeCaDCyhzh1GTOjUB1UM9lEVtJBLF5vY4zyQC3A5wafNmAb7BLX42ZQR10ve6nXR0+5ONy0KV1Eb0FcQgy6tPJYNx4RL0mYhqD4MOCrjy5sNMOSyZh4AkVae8utyxGomnwBiN6Rm5fzY1tvQouJzv2b72ygU2AhXKN6HSSaBv4agjTxWdgrTZOQ==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 17:50:52 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 333696 invoked by uid 111); 2 Mar 2026 17:50:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 12:50:53 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 12:50:52 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Subject: Re: Performance regression in "update" hooks
Message-ID: <20260302175052.GA28275@coredump.intra.peff.net>
References: <aaU5lZwEuR4OrxCl@pks.im>
 <87bjh673o0.fsf@gentoo.mail-host-address-is-not-set>
 <874imy7220.fsf@collabora.com>
 <aaWeSu-d1FMz_sW8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaWeSu-d1FMz_sW8@pks.im>

On Mon, Mar 02, 2026 at 03:27:22PM +0100, Patrick Steinhardt wrote:

> > > I don't have the benchmark setup and it might be easier for you to
> > > confirm?
> 
> All you need is a normal development infra and hyperfine. The
> benchmarking scripts in the repo I linked should then "just work" with
> the above invocation.

Thanks, these were very cool and easy to use.

Looking at the patch, my guess was that the problem is that we are now
setting up and tearing down the sideband muxer for each hook invocation.
This is expensive for the "update" hook, since it fires once per ref.

After running the benchmark I tried tweaking the "stdin" file to replace
"side-band-64k" with "not-side-band" (which conveniently is the same
length and thus you don't need to update the pkt-line header). And it
does make the slowdown go away. (Sadly that input is generated on the
fly by the benchmark, so you have to time with your own invocation).

I think it wouldn't be _quite_ so bad if we actually had an update hook,
because then we'd be paying the cost to exec the hook for each ref. So
the extra work to setup the sideband would be less noticeable.

But it looks like the sideband setup happens even if we aren't going to
run anything, so you get a large relative increase in time.

Doing this:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index efc6e26fd4..a8d198ffd0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -987,6 +987,9 @@ static int run_update_hook(struct command *cmd)
 	int saved_stderr = -1;
 	int code;
 
+	if (!find_hook(the_repository, "update"))
+		return 0;
+
 	strvec_pushl(&opt.args,
 		     cmd->ref_name,
 		     oid_to_hex(&cmd->old_oid),

restores the benchmark, but there might be a cleaner way to integrate it
with the rest of the hook infrastructure. And probably the same thing
should be done for other hooks, too.

-Peff
