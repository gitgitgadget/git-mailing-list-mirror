Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A436F2FD
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620402; cv=none; b=FYafQwV+iiCLZDlswP8KqN6yAZSAaeR3L88HMgkU/WyBYUqGnh90D2tYClcDH46Fumt6SUNXUau0Dp+xrpCIcVey5uIbF6OzbqDa5l4SQ1VVMnwBEUOvAV7cFqVNF9pEcLAmPUJjIrR0XQkZlZ6FH2abji8cu3fh0McmnbqAFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620402; c=relaxed/simple;
	bh=GJLKcnuGIXwkLMrS9r6BY3pQ2nLIFnFJFA3w66mqrug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZB2WeYZSfPH2u3fZrgPgMRGCCUrnU9QgoFK/72glrNR9oJpXp9u6getkvDFwR/waGhY2DT8TuCbygbmv0FkRwESObtS83j1fiXmFVP/JFJx6SdOnFprThJJz/SnwOyL8t1wOXxjS/1O+wzZVnVXRbQUZTSGW8sMFXkdNDwYkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11725 invoked by uid 109); 14 Aug 2024 07:26:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Aug 2024 07:26:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13527 invoked by uid 111); 14 Aug 2024 07:26:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2024 03:26:42 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Aug 2024 03:26:37 -0400
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	Jacob Keller <jacob.keller@gmail.com>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH] format-patch: add support for mailmap file
Message-ID: <20240814072637.GA2077794@coredump.intra.peff.net>
References: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>
 <2mvexuxcaow45ifnqmrvpn2yz2ecxzazsbo5ui7xaiwwpzt7hr@mvl6ehbrhrp6>
 <c0724297-1748-474c-998e-803e6a062a12@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0724297-1748-474c-998e-803e6a062a12@intel.com>

On Tue, Aug 13, 2024 at 05:20:41PM -0700, Jacob Keller wrote:

> I've had a few cases where I was formatting an old commit. The example
> in this case was a change made to an internal tree by one author quite
> some time ago. In the meantime, that person has left the company, and
> his company address is no longer valid. We still typically put the
> original author on such a patch in order to give them credit even if
> they're no longer on our team when sending the change, as patches are
> made by people, not companies :)
> 
> If we left the address alone, it would cause a bounce on the mailing
> list if it gets included in the cc. In some cases, the upstream project
> mailmap already includes a mapping from their old company address to
> their current public address.
> 
> The internal tree commits are already baked and can't be changed. We can
> of course fix the generated patches from these commits manually. It
> seemed convenient to get mailmap to do this for us.

I think that makes sense, especially if the caller is specifically
asking to enable address mapping. I do wonder if the new format.mailmap
might be surprising for some callers, though. For example, would a
rebase using the "apply" backend quietly rewrite commit authors using
the mailmap?

-Peff
