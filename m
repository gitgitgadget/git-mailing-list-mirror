Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE43A1C9
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783297458; cv=none; b=tmtgmJm2EcWPjrqVbhxaD7/4c4BTSR00sqkbfKsHW9ZqKrs8/CRKXRZgvO69JsnD++ZDTKy4dwoGmspNM0TWUsn0cpLkrQAp+34Ish3N46EGhQRfZ8r1BXSOnF+LdUV3gWyfefEfcbE4RsNw4TlbR2zRcKE3o5YHMLLQkCXnrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783297458; c=relaxed/simple;
	bh=2n42RYilRwEcXGNtwof1PFRp3f3LCZlKAXbDzBp3Lw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N41YjPIEcPzc0DgOgNWSxIi7Dxq22vzm0HLR+Qi5DA1DVEBRx7KrgxBf9L/FgthBxTSzRHSYjVlFjUYoSHmufI31UOFYSNHOcq6xDhXMIAf2Gl8K92QC3BPDJoSqCpBfYN66WLfbeW5sKtmXVtsfFz9obXmoZr2+EwLCTwmLK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aWiRbkEB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aWiRbkEB"
Received: (qmail 2434 invoked by uid 106); 6 Jul 2026 00:24:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2n42RYilRwEcXGNtwof1PFRp3f3LCZlKAXbDzBp3Lw0=; b=aWiRbkEBTsJqceCEbfjC74M+m09v86Ga1YP4iHIDJFbdn8cg1exyj3QJmBRII4NAr88gYRe+UdZ+AH/fhv88fPyHbYZ7RrgYS5R6peVCkWXL1XXQCN3Pl+zAu9q48GlFH3MVERPxVeeOb7wy3wRUKACHJqmZUxU6+0Ow5hRyZfxwbzKp0za5eQkzy4jyR6UYfOr0R5NpMELAvBq7i9oNAvh5soRlYKMapWK8AAB79FR0r9bRVHpBMCJI26iHUSx4ERwUBpjsmZwH5ZGnaMFxQV4Gdim/V/pQav3UmORNu9RxMCODt0t2/O+Jmsbzlm79GmaCKhTZKkOD3Edxw0BzSg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Jul 2026 00:24:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3773 invoked by uid 111); 6 Jul 2026 00:24:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Jul 2026 20:24:15 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Jul 2026 20:24:15 -0400
From: Jeff King <peff@peff.net>
To: Trevor Gross <tg@trevorgross.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stefan Haller <lists@haller-berlin.de>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: introduce `pick -x` to add "cherry picked
 from commit ..."
Message-ID: <20260706002415.GC2301945@coredump.intra.peff.net>
References: <20260705140931.98262-2-tg@trevorgross.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705140931.98262-2-tg@trevorgross.com>

On Sun, Jul 05, 2026 at 02:09:06PM +0000, Trevor Gross wrote:

> It is sometimes useful to do cherry picks via rebases when there is a
> sequence of picks or other git operations to combine. However, there is
> no interactive rebase equivalent to the cherry-pick `-x` flag, which
> adds a line to the commit body indicating the original commit.
> 
> Using `exec git cherry-pick ... -x` does work, but is not as nice
> because it interrupts rebase flow; after resolving a conflict, both `git
> cherry-pick --continue` and `git rebase --continue` must be run.

To me this feels like you're approaching the problem backwards. Mostly
because rebase and cherry-pick are _kind of_ the same operation.

Usually a rebase is about rewriting the commits on a new base so that
you can throw away the old ones. And that's why git-rebase generally
rewrites the branch you're on, and replaces those old commits. So adding
a "cherry-picked from..." annotation doesn't make sense there; nobody
would have those old commits!

And so while cherry-pick is doing roughly the same thing under the hood,
it has different defaults: you specify a read-only source from which to
pick the commits (and "-x" may or may not make sense).

So I can see why you might use git-rebase to do what is essentially a
cherry-pick, porting options from cherry-pick to rebase feels weird. Why
can't we fix the problems in cherry-pick that make you want to use
rebase instead?

Once upon a time they had very different backends, but these days
they're both using the sequencer subsystem under the hood. And it sounds
like you just want to do interactive sequencer type things. If there was
an interactive cherry-pick option, would that be enough? I wonder how
far we are from that.

Let's do a little experiment that stops the cherry-pick in the middle,
like this:

  # start with a repo with any file
  git init
  echo base >file
  git add file
  git commit -m file

  # one branch makes a few commits
  git checkout -b branch-a main
  for i in a1 a2 a3; do
	echo $i >file
	git commit -am $i
  done

  # another one does the same
  git checkout -b branch-b main
  for i in b1 b2 b3; do
	echo $i >file
	git commit -am $i
  done

  # and now we try to cherry-pick all of branch-a, which will
  # fail with conflicts
  git cherry-pick main..branch-a

And now let's look in the sequencer directory:

  $ cat .git/sequencer/todo
  pick 206bede a1
  pick 638aff4 a2
  pick ec375c4 a3

So what I'm wondering specifically: have we done 99% of the work to have
interactive cherry-pick, and we just need to add a "-i" option to let
the user edit that todo file before we start executing it?

To be clear, I don't know the answer. It's been ages since I've looked
at sequencer code, so there might be more gotchas. That's just my gut
feeling from a high level after reading your message.

> To improve this, introduce `-x` to the pick, reword, and edit todo
> rebase commands.  This uses the same logic as cherry-pick to add a
> "(cherry picked from commit ...)" note to the commit body.

There is one thing that differs here from how cherry-pick works. Even
though cherry-pick is using the sequencer under the hood, it does not
allow individual "pick -x" commands, but instead records it as an option
for the whole operation. So if you add "-x" to the conflicting
cherry-pick above, you can see:

  $ cat .git/sequencer/opts
  [options]
	record-origin = true

That's less flexible, since you can't have per-pick "-x" behavior. If
that's important to you, I think it might be reasonable to support the
"-x" option for those sequencer commands, and have "cherry-pick -x" just
add it automatically to each line (rather than record the global
option).

> Of note is that rebase will fastforward wherever possible, meaning the
> check for TODO_RECORD_ORIGIN doesn't get hit and the message will not
> get amended. This differs from the cherry-pick logic, which will add
> "cherry picked from ..." even if a rewrite isn't otherwise necessary.

This sounds like another case where cherry-pick and rebase have subtly
different behaviors, even though the core functionality is still "pick
these commits". So being able to stick to the cherry-pick command for
cherry-picking may be preferable.

-Peff
