Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C901876
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735228376; cv=none; b=qIeMpAHydiR6SB+cvphSovgHJ7w33Ip0zs7lOqxvQfQp/CcbJFYQ3XwzhBAdH2fkotWfyutZ92+/jfY15N9/52WLUMrvhzGtILMz484CRhJy6Uh1POfk4T3z2pNV9xKdtHODJPan9C/t+BV+42pKMSv+yQ2SfsPoJAsCkfQpyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735228376; c=relaxed/simple;
	bh=Ci0bUFI2by7X3swL70YQPT+C/qgL8+R3AlAapJPCOGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBU50mDE1oUZQ3pjO9+Khz3Qzy45HPk5uN4OJFZ/7I5B4KUnrlLBzY02Zh8iRbhfDpzIX8aObPPV3Evl6XfIod3FL+M6wy1orGTBBgRwzAHrriTX90VoFWKdnbF3ufA6og+v6zyblkeuRPkeqR8L4T8NtKHjgdNvGYCDa5aKFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VuUfZwwk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VuUfZwwk"
Received: (qmail 26818 invoked by uid 109); 26 Dec 2024 15:52:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ci0bUFI2by7X3swL70YQPT+C/qgL8+R3AlAapJPCOGs=; b=VuUfZwwkYnTjISHKlkMWwFn83aCakh375lnS4Lns2/YKNSlTb3rR0axvqn+A2gMtuRGofiSvdAwZto1vPCq+/DC99pZBZJkW0CsM7Ouh7Py8/lmQtqz/dcQEf4D3KVx5IPbUz5qXfzK0mJpq/zQD6soGj0dJ8bRvqHGmtXWSnjjQwYE8bRmFMvfUKU8SsRJXcWf4Mo4nq1N5+dkSZY0qGwnPCcFIAc7g/BFnHcZn+RjHhSQ8e2D3o63UoCsc3qH/p+Pq1L3TqFEGZozvkECDZXrVZolxKqxU9sjh+yHigKxQtaFZ1cLsaz/akLy4kcxKJW4t1JV5Zqu91pqtVo4/1g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Dec 2024 15:52:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1976 invoked by uid 111); 26 Dec 2024 15:52:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Dec 2024 10:52:52 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Dec 2024 10:52:51 -0500
From: Jeff King <peff@peff.net>
To: "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git fetch" fails for a --reference clone after an outer forced
 push
Message-ID: <20241226155251.GA69868@coredump.intra.peff.net>
References: <SJ0PR11MB581445B096273126D18F3724C60C2@SJ0PR11MB5814.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB581445B096273126D18F3724C60C2@SJ0PR11MB5814.namprd11.prod.outlook.com>

On Wed, Dec 25, 2024 at 05:23:13PM +0000, Mirochnik, Oleg V wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> $ cat ./doit
> #!/bin/sh
> set -xe
> rm -rf tst
> mkdir tst
> cd tst
> mkdir master
> git -C master init --bare
> git clone master local
> touch local/foo
> git -C local add .
> git -C local commit -m init-commit
> git -C local push
> echo foo > local/foo
> git -C local commit -a -m dummy-commit
> git -C local push origin HEAD:refs/heads/dummy
> git clone --mirror file://`pwd`/master mirror
> git clone --reference `pwd`/mirror file://`pwd`/master local1
> git -C local1 log --oneline origin/dummy
> git -C local commit --amend -m new-dummy-commit
> git -C local push -f origin HEAD:dummy
> git -C mirror fetch
> git -C mirror gc --prune=now
> git -C local1 fetch
> git -C local1 log --oneline origin/dummy
>
> [...]
>
> What happened instead? (Actual behavior)
> 
> + git -C local1 fetch
> fatal: bad object refs/remotes/origin/dummy
> error: file:///tmp/tst/master did not send all necessary objects

This is the expected behavior, and what the warning in "git help clone"
is talking about:

  NOTE: this is a possibly dangerous operation; do not use it unless you
  understand what it does. If you clone your repository using this
  option and then delete branches (or use any other Git command that
  makes any existing commit unreferenced) in the source repository, some
  objects may become unreferenced (or dangling). These objects may be
  removed by normal Git operations (such as git commit) which
  automatically call git maintenance run --auto. (See
  git-maintenance(1).) If these objects are removed and were referenced
  by the cloned repository, then the cloned repository will become
  corrupt.

Your "mirror" repository has no idea that other repositories are
depending on it. To safely do a "git gc" there, it would need to know
all of the objects that are referenced by the dependent repositories, to
count them as reachable.

One way to do that is something like:

  1. Enable the "preciousObjects" flag in the mirror repo, to prevent
     accidental destruction (e.g., from auto-gc):

       git -C mirror config core.repositoryFormatVersion 1
       git -C mirror config extensions.preciousObjects true

  2. When you do want to run gc on the mirror repo, collect all of the
     references from child repos first:

       # collect references from all child repos; the destination
       # doesn't really matter here, and you could even delete
       # refs/child/* after the gc if you want
       for $repo in local*; do
         git -C mirror fetch --prune ../$repo refs/*:refs/child/$repo/*
       done

       # now gc, disabling preciousObjects temporarily
       git -c extensions.preciousObjects=false gc --prune=now

This is (roughly) what a site like GitHub is doing on the backend with
repository forks. But Git doesn't ship any scripts to help with it, and
I don't offhand know of any public ones. I assume GitLab does something
similar, and their system may be open source.

Some gotchas:

  - this is obviously racy with simultaneous updates to the local repos

  - you'd probably want to fetch HEAD as well, to cover detached HEADs

  - it won't cover blobs/trees referenced by the index of each child
    repo (but those are probably going to be local to those repos
    anyway).

  - it won't cover reflogs in the local repos either (but it's not the
    end of the world if a reflog entry goes stale)

Another, perhaps simpler approach, is to just never expire objects from
the mirror repo (with the obvious downside being that you might carry
objects forever that nobody cares about). You can set gc.pruneExpire to
something high, and then look into gc.cruftPacks to store the old
objects in a more efficient form.

Hope that helps.

-Peff
