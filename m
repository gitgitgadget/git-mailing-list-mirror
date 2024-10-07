Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01C320F
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333446; cv=none; b=Z/yVfVOvudSZF+xUucn+ncCaVdEB4gZAcu2OxUxiYMy73U4wQD10ObdXPuChUlzs9Mv4Idfoue6tSsNVWDAB1O5xjV2NRHVkVMT1Jl3jxc2RIc+gTBBuWMsArjQmPw+DaJMfSiMNxU7P9832jwk9B9zIM0vspLUecR9XC/35EhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333446; c=relaxed/simple;
	bh=VIoW5OuddDKZPjujQOTAXMuMVI0TjSuhU53hd4p7zpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCJwmy3lo8LiDQHxo0OQZB3XR9TEEK/Qt0ApXobLSGJP4je//+7n3UB1u64NaLp2PzsjrwpwV9p8Uy6pRn+3nUm5QR4aMoW/mMaqyyjiLJLHTqzOBr6AmXvC1iEdTPYz0F8x7xqjITC7lV2jDVBAzC4a4rmLm66RBZWjQndoYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SeziQki2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SeziQki2"
Received: (qmail 4998 invoked by uid 109); 7 Oct 2024 20:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VIoW5OuddDKZPjujQOTAXMuMVI0TjSuhU53hd4p7zpo=; b=SeziQki2iOW5rsyiQpL9krwReV6H5VIk89BAXfIu3ar/cvUf1jhfghoYJCZzrsJsv3nlEuauVv4OznN+tVAPcPR954GEvoe7mHk19FIQJ5dferztR3v1BQuN4s44Hk+7461WCB1d4ZGXqWiepC8fJoWb/NKgg7wkGGkUa63ODGIxJ4EzlG8gPRP6SKtQpNxnQ5M0rj5RnmDtIQocDGJsKhaORJWswhKINN+pJQACir4V2IIN9KoWQDHXHO3tt1R9jEivyf3Ma2cU+Lve33H8+bNZYk/tYPrOznZvT981dMffNQIXLgEJ1XuX7PLblnkN+sJZbMGGkmRA5ue7WlfNIA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Oct 2024 20:37:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9353 invoked by uid 111); 7 Oct 2024 20:37:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Oct 2024 16:37:20 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Oct 2024 16:37:20 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] object-name: don't allow @ as a branch name
Message-ID: <20241007203720.GA603285@coredump.intra.peff.net>
References: <cover.1728331771.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728331771.git.code@khaugsbakk.name>

On Mon, Oct 07, 2024 at 10:15:16PM +0200, Kristoffer Haugsbakk wrote:

> This has come up before.  There even is a test which guards the current
> behavior (allow `@` as a branch name) with the comment:[1]
> 
> ```
> # The thing we are testing here is that "@" is the real branch refs/heads/@,
> # and not refs/heads/HEAD. These tests should not imply that refs/heads/@ is a
> # sane thing, but it _is_ technically allowed for now. If we disallow it, these
> # can be switched to test_must_fail.
> ```
> 
> There was no reply to this change in neither the first[2] nor second
> version.
> 
> That series points back to a bug report thread[3] which is about
> expanding `@` to a branch named `HEAD`.

Yeah. The series you found was about not expanding "@" in the wrong
contexts. So the test made sure we did not do so, but of course it was
then left asserting the weird behavior that was left over. So this:

> So that was tangential to the bug fix (`HEAD` as a branch name was not
> disallowed in the patch series that resulted from this bug).

is accurate. Those tests are no reason we should not consider
disallowing "@" as a branch name.

  As an aside, I have a couple times left these sort of "do not take
  this test as an endorsement of the behavior" comments when working in
  crufty corners of the code base. I am happy that one is finally paying
  off! ;)

So I think the aim of your series is quite reasonable. The
implementation mostly looks good, but I have a few comments which I'll
leave on the individual patches.

-Peff
