Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9923C9
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731728180; cv=none; b=LtrdkJO4ji+zWeNzxVYGXQ/I+uVAnZV2XiEPGRypwZOr2MMsiL+7UxLhcsWqB1dJNh+h3qBEoXHtNX56WFTfGBA9bn80V0ZAtmOLVqd+JHfeXQtHpcSQKrsTWL0fBO+P+E+rFHyxFPY/dboAS9QQxundLHrZ59x643zG7xj7WVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731728180; c=relaxed/simple;
	bh=1bxG74GzAclpA+Qp9PG4rBZeEi+fp2bniqzCn5ya6Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrHoil52XkNV9pnok+6X9ISXQWKNU0ioSj1mFdMk6dVBr2TU9KA/UnSh3s7Yjgt0b5ueJUuruXc40PIUWTrG7JvPCaFXQNpC14rf4Ns/JbNwNszuPOfuAay9T3GVIuXMa2/7joOzYB8erN7BIbBOH7IlAqctFncRwD6yi1Iv7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WkfNCeGt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WkfNCeGt"
Received: (qmail 25000 invoked by uid 109); 16 Nov 2024 03:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1bxG74GzAclpA+Qp9PG4rBZeEi+fp2bniqzCn5ya6Os=; b=WkfNCeGtHPulFfA4fX/DnwkiKkvSJQJGsAeYBL3GY0WWYKLVYjsMdSGYzGxn9f9e3CJWGkoY3mR5800nudr3OSAuDil+8dYTxJi/fxDQRL/G3mTuJMLJdK6kW2fLp+e/aXg5p4S1/KXk8/W5gc7JfCzzp5kyUhWAzBzKNJIvj+UW/TmbHbmS2cRo2JGvJnHJRHmJL6jtpomixIJes7sZyLLVzdU83FgwANb0UN9zNHvEavsvXjuzxWCZxZ4TJaDsMnlNQmDuqw+EOm0r7lr1ok2jVTPwc2ufIOnhyTnWpUUZJulWJTIAt05ae2UgDStji6Oib6LQgB36WVE5LeuJ4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Nov 2024 03:36:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16425 invoked by uid 111); 16 Nov 2024 03:36:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2024 22:36:20 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Nov 2024 22:36:16 -0500
From: Jeff King <peff@peff.net>
To: Caleb Cushing <xenoterracide@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git remote set-head automatically
Message-ID: <20241116033616.GB1782794@coredump.intra.peff.net>
References: <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>

On Fri, Nov 15, 2024 at 09:34:28AM -0500, Caleb Cushing wrote:

> Context: recently I've been trying to develop a feature for my Gradle
> plugin that derives a semantic version from git describe.  In order to
> achieve my next level of feature I need the HEAD Branch. Now, I can
> get this branch using git remote show <remote> and parsing the output.
> I'm a firm believer that it should be possible for me to write code,
> long term even, without the internet; I did this once with my job when
> I needed to go home to my parents who were very rural and didn't have
> internet; I was able to keep working without access. I want that for
> anyone that uses this tool.

You should use the refs/remotes/<remote>/HEAD symref instead (or its
alias, just "<remote>"), which is more convenient and doesn't hit the
network. Which is exactly what...

> Problem: I don't want to have to do a network request every time I do
> a build, in fact I'd rather almost never have to do a network request.
> Gradle makes reducing the network request to less than once per build
> something ... unsupported. jgit doesn't expose support for fetching
> this information. Then I found out that you could do `git remote
> set-head <remote> <branch>` which appears to behave exactly how I'd
> want and expect. It doesn't easily solve my problem though because I
> want my solution to be generally applicable.

...set-head will set. So OK, but...

> Ideal Long-Term Solution: git remote set-head happens automatically on
> lone, and even fetch if it's not set. Explicit setting would override
> any automatic setting; and it might be a good idea to automatically
> unset if the HEAD branch disappears from the remote.

We already do the equivalent of set-head on clone. If you do:

  git clone https://github.com/git/git
  cd git
  git symbolic-ref refs/remotes/origin/HEAD

you should see it pointing to "refs/remotes/origin/master" (and like you
can refer to "origin/HEAD" or "origin" from git-log, etc). Are you not
seeing that?

We don't update it on fetch. That has been discussed, but there are some
questions about when it should overwrite what's available locally. E.g.
this thread:

  https://lore.kernel.org/git/D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com/

There have been some patches in that direction but I have not kept up
with the current state:

  https://lore.kernel.org/git/20241023153736.257733-2-bence@ferdinandy.com/

-Peff
