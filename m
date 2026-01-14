Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE91F4613
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358051; cv=none; b=YbqLfIhXvYocm5OUCpDM94CjIr6wyz9NhPO2QLKt/v0NlCfGPIWIxbYLxSUul2oss3Pkjv+481WN/LhwVUqUHZtej2QSFRclGqwz9Chumx5q9eACUpD0S+8yxzim6tfrdJNolcJFereVFBl3T5Ad71JSz8uTabFZKtrd6XwB70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358051; c=relaxed/simple;
	bh=p91XZW9KhWDZlPT7hz5eEEYgOBwAi3gtScbI5t/kJYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp3Q/LyoEZzpTd0NU3zLWxw2HNiwYXB1qSQEhGYyk7x/tnV4IjPutnYXTZykyrbDJjGrJiC03/eL+toUpe+5lXH8POfo9L3rBrXnxfFnQejNcul1imwCfF5KaW/SjQHPlSFBaVIbu4ef3P9w+Z+PazlHz+jqAxUNQ7ZtdiDmEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JiLAPoGD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JiLAPoGD"
Received: (qmail 35265 invoked by uid 109); 14 Jan 2026 02:34:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=p91XZW9KhWDZlPT7hz5eEEYgOBwAi3gtScbI5t/kJYc=; b=JiLAPoGDPiuHiBNF/C/aOynSVp+zcl7gJGdZQL+n8MIExaOg7lUh6MarVEwt0/NzOGZOnJhUHV29A5kf3xwyQ0xqNYSb4Mzd2qz0m4dxIBYunX8rHXDfAHfD7GO9yVaUS5UoBPlrBizj69fyam+7gPPdOAIvoDqcE9PQbYzpfOCRFwAFLdlTAR9cvaVSeONMECW566KmhHVnKNZD5UWtDZ4EpqZV/0iBCJpjccVGfHsb3pNq7uDIxa5a6t41/RA8UNcHmNTy3h9msWNZMvI9MkTpjFYoWYCOjZj6XvLHeXJRdUruyR28VCEXDJFuripGsRccPTtFL+HfUFjvE7x+ZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 02:34:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57350 invoked by uid 111); 14 Jan 2026 02:34:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jan 2026 21:34:11 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Jan 2026 21:34:08 -0500
From: Jeff King <peff@peff.net>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: Triangular workflow
Message-ID: <20260114023408.GA858378@coredump.intra.peff.net>
References: <20260113214059.GC288857@coredump.intra.peff.net>
 <20260113230107.16728-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113230107.16728-1-haraldnordgren@gmail.com>

On Wed, Jan 14, 2026 at 12:01:07AM +0100, Harald Nordgren wrote:

> I'm wondering if since you are scripting this anyway, if you really need a
> push branch at all? Can't you just as easily switch to doing this in the
> script:
> 
>     git config push.default upstream
>     git push github jk/some-topic

I could (and in fact the script names the remote directly already,
because you can't pass refspecs without specifying the remote). But I do
occasionally push a single branch with a bare "git push". Usually this
is the integration branch, when I am trying to trigger CI manually
(e.g., when piling hacks on top in order to debug a CI failure ;) ).

So even if I only do it infrequently, it feels weird that a bare "git
push" would try to push to the upstream remote (which I don't even have
write access to!).

> As a note, before I started working on this feature, I don't realize
> that there was such a thing as a push branch (i.e. something different from
> the tracking branch). So I had the habit of checking out and pushing like
> this:
> 
>     git branch --set-upstream-to upstream/master
>     git push origin $(git rev-parse --abbrev-ref HEAD)
> 
> I worked really well for me. The only issue was missing the status info
> from my own branch -- which is why I started writing this feature.

Yeah, though @{push} is usually not explicitly configured in the same
way @{upstream} is, but rather a consequence of how push.default and
remote.pushdefault interact. But it was added for exactly this kind of
triangular workflow. I sometimes will do stuff like:

  git range-diff origin @{push} HEAD

to compare two iterations of a branch if I know that I haven't pushed.
It is a bit of a cheat, because what I really mean is "do a range-diff
since the last thing I sent to the list". But if I have just been
working on a branch, and I haven't run an integration cycle since then,
then I know that the pushed version will match it.

There is also branch.*.pushRemote, but I have not found that useful (for
my triangular flow there is always a single repo to push to, not one per
branch).

-Peff
