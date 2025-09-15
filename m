Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F709320F
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964706; cv=none; b=Ht0cpW/GRAPuKL/I4F9nNKb/17UIuAZlmO7B6zsGxilucwQJDgrR9lmj/JYeeD4qLPGTUUpqLDhqDHLgnwgo3N9uq/jKcwLepTS2yTlUoOkyY98Z6/KnkBVJSCGHzQTRuNRqoQDoQWQIp+5HVks2DO+zt76ISzR02aH/F5gZBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964706; c=relaxed/simple;
	bh=ve5duh4u+i0F0P6EdyjGtmAXkgKwyHrCoXyx0VUE23c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVs5vzrh/tx6eMLcddUBI8EIEQTCjnBMTjQQy9HPGFg/MkV63RD/rzSiH6tqp7vHdUp0C8vdqfoTKwbInxNckHG5MZviJo9BC5yrTfEf1nteo8l08MzWBMPiKTM16R+cDrVEVQQX1A0CEVudBDTsFg8XdnlOuSu6YYJIuFf+HJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WI39D/9W; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WI39D/9W"
Received: (qmail 90301 invoked by uid 109); 15 Sep 2025 19:31:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ve5duh4u+i0F0P6EdyjGtmAXkgKwyHrCoXyx0VUE23c=; b=WI39D/9WTPrHNIoG6nCN+OjN0HjLj1XljqY+WQdJX5Hcpjm5jFWL0gCwLaxFCG2zzAbehHVsMHYzfTjltbmLK6T7+BrQ5snzw4w1hA91LzqBjUJfa0hxvG0UlcLNuu2VlEA82K3r7KCZu5ZTBjJ7p7zWeL9rVD7oKykiwl0XOHcABeJglu1ufGbJJcOMndprH5o0ToYCAIRDceA3hdfyfGnA2may8HZpO0SbgS5WRX1WLbQkhOsvI+jBxML1lqU4qpmPB+cZNIfJrm4x+g8ZXQpyE+EG3FX5/iiX9MSH8xMNiPWasIsj/8DfdBDPVaDuBmPF3rGkT6bt3BvU3e4d3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Sep 2025 19:31:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 151486 invoked by uid 111); 15 Sep 2025 19:31:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Sep 2025 15:31:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Sep 2025 15:31:42 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] git: run alias subprocess according to the API
Message-ID: <20250915193142.GA651907@coredump.intra.peff.net>
References: <ad7066022efe5344eb1972d1c489372d97b2d18a.1757842206.git.code@khaugsbakk.name>
 <xmqqms6wi08y.fsf@gitster.g>
 <20250915180842.GA642496@coredump.intra.peff.net>
 <xmqq7bxzh6sl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bxzh6sl.fsf@gitster.g>

On Mon, Sep 15, 2025 at 12:09:14PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure there _is_ any reason to use a raw "git" instead of
> > ".git_cmd". The case in upload-pack is _not_ running a git command
> > directly. It is passing the name of a git command to the hook. So you
> > end up running:
> >
> >   /path/to/my/hook git pack-objects ...args...
> >
> > So I don't think there is any X or Y, and the rule can just be "you
> > should use .git_cmd".
> > ...
> > That said, I do not think it is particularly important to use .git_cmd;
> > it really is just prepending "git" to argv. It does also override
> > .use_shell, but it is nonsense to set both flags in the first place
> > (which is something we could perhaps flag with a BUG() if we cared to).
> > But I have no problem with preferring .git_cmd to "git" as a style
> > preference.
> 
> Ah, OK.  I just was confused by the explanation in the middle that
> appeared to be saying that they are not truly equivalent.  If not,
> then I am perfectly fine.

Yeah, I think Kristoffer's explanation was just confusing.

> I would actually prefer to get rid of the .git_cmd member altogether
> to make it simpler to code.  The run_command() function should be
> able to internally decide to short-circuit and invoke "git" directly
> without the shell by looking at the first element of the argv[]
> array,  One less thing for human programmers to worry about.

I don't have any problem with that direction. In theory we might do
something special for a .git_cmd (maybe run a builtin directly?), but in
20 years of run-command we have not bothered to do anything besides
prepend "git".

I think we already should skip the shell in that case, as the caller
would not generally be setting .use_shell. And if they are, they are
perhaps trying to do something clever and we should not override it. So
I think you could literally just drop .git_cmd, replace all the callers
with pushing "git" at the start, and be done.

-Peff
