Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2A3054C8
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125234; cv=none; b=BvmEHbubA5qEom21vDxLqdkXpgNyj9mnQh0pRGG5AfuT7UGOr+OonV54jnQvfeu77421A2OY0+rCiLFvFd1hNe2QRBD2WBsISnUvHMTLX93Y8ETbH1XySbxiaLwhdjZFg1VKDJPh6DYwyttXmy8UYY0vQpW/N6LIG47w43/J7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125234; c=relaxed/simple;
	bh=IzxSCpIrZJ6SRa9KUER5tB1hMUNd+Y6chShiXmct+VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFhCS2QitE7QgbUL1uvEaW2nVQfyEyHiL+7YyIbz+zWtgtvAmvou6wBpiqyZniYedkofJygdSWhlP7tZZT5EnQ58n9wpEwBMW7sxGslaPfV6HRPIOTrlSGtXtNJxY5AeJ3T8XwhLNwVUvVJq1+/cCLYz10ikpRVRE7N82L9qraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gW/1MQNG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gW/1MQNG"
Received: (qmail 303183 invoked by uid 109); 22 Oct 2025 09:27:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IzxSCpIrZJ6SRa9KUER5tB1hMUNd+Y6chShiXmct+VM=; b=gW/1MQNGY7Il9/0ay9iOVfIBWbIjFDuKRQrTHAYoun9iawxvHlmqnFezdKstYhDS2VajkRG2tLIcHcd3ExNH1k0XVx3XkHrGIZfRS2CHK2wgtAnVrYNljWItVahuqv4pZkfRVSagvU/KCi5sr5iho2qN8xgYJJ57BpIkhsvF5twkviOkCek1tRuOpmj0wIIIbD+aW5/gW9OB2TdmltXkYjA1x9qiYb+e/xJZK1zXgeQGc7EIRAH387vc/61r9Ijam4i33y8hVsh0Ooj744ZhmdQSatkqwukL4nF+L5XsDg79JLTlup3zvKOu7Uq+gUx3irE2+7ZG6sQBo6UvnauipA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Oct 2025 09:27:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 472411 invoked by uid 111); 22 Oct 2025 09:27:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Oct 2025 05:27:09 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Oct 2025 05:27:08 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: "'D. Ben Knoble'" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] Strange git notes completion behaviour
Message-ID: <20251022092708.GE853931@coredump.intra.peff.net>
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com>
 <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com>
 <013201dc42d5$07a71550$16f53ff0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <013201dc42d5$07a71550$16f53ff0$@nexbridge.com>

On Tue, Oct 21, 2025 at 05:52:38PM -0400, rsbecker@nexbridge.com wrote:

> It is the exit code. When in gdb, the return from notes is -12 as above. By the time
> It gets back to bash, the lower bytes are dropped so I end up with a 0xFF, which
> bash thinks is a 0, so the exit code is hidden from view. I tried the !!fn construct
> in a standard alone test program with no wisdom gained.

I don't think the "!!fn()" line ever returns here. In the show()
function of builtin/notes.c (which is what "fn" is pointing to for "git
notes show"), we end up calling execv_git_cmd() to run "git show". So
you are really seeing the exit code of something like:

  git show $(git notes list HEAD)

That in turn is propagating the return from show_blob_object(). Which
I'd think would return "0" here, since it actually showed the blob,
though it does look like it could return -1 in a few cases.

Another possible point of confusion: that git-show invocation will run a
pager. It's been a long time since I've looked at that code, but IIRC we
try to preserve the exit code of the actual Git command (rather than the
pager). But you might try:

  git --no-pager notes show HEAD

to see if that behaves differently. I couldn't reproduce the issue at
all on my end.

-Peff
