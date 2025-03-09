Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7D211C
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741491551; cv=none; b=NkPixYrrFXZm88ua+Slqob0VWxBZzve95IZHzBOag0GycawFTVjwuYtMAO0dpL6LRcOz9iIWCQ/eKJFE22OvxrCvAtuIyWKQ5SITGv8MAUmloVUojf46+PmmJ7xSqgCUmdhXp0OPH2H0/ARmsVf9NIlTB2QJTd06j0zPBBtWA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741491551; c=relaxed/simple;
	bh=lafrWKmjByHL9QK5Il/HFDp2lE2N1XapzXC5TquiKhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuJBNiatWmb3eJyRGJtp7Ku+DywVp+q2WpxuXMtTq/luMjRMnRrnDh4PIb6oWR7yD5szWKYAtmuZCES/6kP8agyZONAhPdj6PNZJrxR2yGkTxNHz1vzoJpw5WpkOhgcVh0G2y2zNhF1903BxxDl9ysQg4E+BGT8QYET21SqhsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fAFrZWdJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fAFrZWdJ"
Received: (qmail 5085 invoked by uid 109); 9 Mar 2025 03:39:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lafrWKmjByHL9QK5Il/HFDp2lE2N1XapzXC5TquiKhQ=; b=fAFrZWdJcBXTBpgR0/mR0a8cM9N9AhDdAf1hk/Txopk/uBtAa+RqhFS+CZzysd4IWzFC7DxFdonFgNBOFXMB7wJWnTcOgd0F0/6P+AMclLKPD9VZGdmIvWtCc1bRnAYAmfIBz+KTG1fnbPa3Ix+/n8vmBD+d2JabMDSVhQEfdNWy1YctiF72l8vYSjxTwOOZ4myBNJG+SLCuzo2aXJEv0ISxV22tI0fsu+vM/v25PR8IyJlKKDaIIERiAvLCtLY+u5Hon8zcuksaNbgNRYrGXaz/To91AHYtthQUzvF6PNsBzdTj8C/1e8Y7lsHqm/I0iihyuh2SlLGxxqL07E1rDw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:39:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5278 invoked by uid 111); 9 Mar 2025 03:39:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:39:08 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:39:08 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Benjamin Woodruff via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Benjamin Woodruff <github@benjam.info>
Subject: Re: [PATCH 0/2] describe and diff: implement --no-optional-locks
Message-ID: <20250309033908.GA2361799@coredump.intra.peff.net>
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
 <xmqqo6yejg0y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6yejg0y.fsf@gitster.g>

On Thu, Mar 06, 2025 at 08:11:09AM -0800, Junio C Hamano wrote:

> "Benjamin Woodruff via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > git describe and git diff may update the index in the background for similar
> > performance reasons to git-status.
> 
> That is a wrong reasoning that is completely opposite, though.
> 
> The commands at the Porcelain level, like "status" and "diff",
> refresh the index for the CORRECTNESS purposes.

Right, but "status" supports --no-optional-locks already.

So I think these patches are wrong, but the goal is reasonable. What
git-status does with --no-optional-locks is to update the index
internally for its _own_ use (giving it the correct results), but not to
lock nor write out the resulting index (to avoid conflicting with other
running programs). So it's pessimal (losing the opportunity to share
what it learned) but prevents lock contention.

And I think other programs could do that. I even wrote back in
27344d6a6c (git: add --no-optional-locks option, 2017-09-27):

  I've punted here on finding more callers to convert, since "status" is
  the obvious one to call as a repeated background job. But "git diff"'s
  opportunistic refresh of the index may be a good candidate.

I must admit that I didn't imagine "describe" is something that somebody
would run a lot in the background, but there's not really any harm in
having it support optional locks if somebody cares about that case.

> The commands at the plumbing level, which are designed to be used in
> your own scripts, like "diff-files" and "diff-index", do not refresh
> the index for the performance purposes.  If your own script wants to
> produce correct result, your script IS responsible for refreshing
> the index after its last modification to working tree files before
> it starts to use the plumbing commands to inspect which ones are
> modified and which ones are not.  This is so that your script has
> more control over when the index is refreshed.  It does not have to
> pay cost to run refresh for each Git command it invokes, if it knows
> that it does not make any modification between the two invocations;
> it can instead refresh just once and then run these two plumbing
> commands.

Assuming --no-optional-locks is being used as intended, the idea is that
the script cannot touch the index at all, because it is running in the
background and does not want lock contention with things the user is
doing in the foreground. So it cannot naively do a single index refresh
followed by plumbing commands like diff-files. Either it must:

  - accept that diff-files might return stat-dirty results (yuck)

  - use its own index that is separate from the regular .git/index file.
    But that may be overly slow, since the index "update" would rewrite
    the whole thing from scratch. Of course all of our index writes are
    from scratch, but you'd pay the price even when there is nothing to
    update.

  - use a command which operates all in a single process, with an
    in-memory index that is updated but not written out (e.g., "git
    --no-optional-locks status").

-Peff
