Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B64C85
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969870; cv=none; b=Bi7LcJDD8nyF3B6+w+gTPsGQmF02VUbK/gOWGWCWO1X/K+FZe9rKdOIWz6G2RrIt5Wa8vzNcMWtw1Kx4vSO8QIYfR7K9efOcmkVvl5ZLWtnpe34LiVjw+MJNXtd+RbGqtDH5u+qL+6k7uSxZSEEWQ3AxKJyHLh9t3czSHVfuCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969870; c=relaxed/simple;
	bh=vwm4ewF+43+dBVKSnQM0adGG5PtF0jAdJTb8t94pxPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7qnD6+nbLrzRHNjhWu8+aEVOblqnsFP/EBfKuP4yH9mox9tABqBmuYlREnIyLjL1IxS63y8HQjLVejjzJ5BNJYR9Fl830nSKYIu7Ka6puNuShvQFzZ0v3OFejkBKyh0cCf7h+rFxTxN1z5PJXpdNvC7WbxST6GibEJGVqRQdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Vebr/GRo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Vebr/GRo"
Received: (qmail 3037 invoked by uid 109); 20 Jul 2025 00:04:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=vwm4ewF+43+dBVKSnQM0adGG5PtF0jAdJTb8t94pxPs=; b=Vebr/GRoE5r9AGUmXzqVDFhWcU55r1Fsq1ODXLAt4/CompO91XgOh0QHQGhowsd2nxItAmw1UhzUDmoB+RprrtBTiZPJYWBWIyaoOk7xhqTl3gdFA7FY2Cc3L8uQTWSyUN5MxtWLFWkcr7/OlUNTbouQuC5HQCSgVvVTSGZu1+7cs+Ms1MMoqMmVhPM+214wQXBnuKTjVVFnIZgEKrirm+m7v2Kn/zm8C/1q7CUvWYt7EwxN1aCk3kCbwHxELTUCYOvhz7IZ4MhfWJstpTfJQeEJO0H+9ZBL9ASp7dBDSEuvvAdtdOob7VvyAR+r2Vz9k1TyLM9heqWTAYXWXArP7Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 20 Jul 2025 00:04:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17052 invoked by uid 111); 20 Jul 2025 00:04:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 20:04:30 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 20:04:26 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rev-list: make "struct rev_list_info" static to the only
 user
Message-ID: <20250720000426.GB743449@coredump.intra.peff.net>
References: <xmqqa551127o.fsf@gitster.g>
 <20250719063551.GA705356@coredump.intra.peff.net>
 <fc4da804-37ed-4425-8dda-14cfcb607906@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc4da804-37ed-4425-8dda-14cfcb607906@web.de>

On Sat, Jul 19, 2025 at 02:36:04PM +0200, René Scharfe wrote:

> >> @@ -652,7 +660,7 @@ int cmd_rev_list(int argc,
> >>  	 */
> >>  	/*
> >>  	 * NEEDSWORK: These loops that attempt to find presence of
> >> -	 * options without understanding that the options they are
> >> +	 * options without understanding the options they are
> >>  	 * skipping are broken (e.g., it would not know "--grep
> >>  	 * --exclude-promisor-objects" is not triggering
> >>  	 * "--exclude-promisor-objects" option).  We really need
> > 
> > This tacked-on bit seems funny to me. Isn't the original more correct?
> > The loops do not understand that the options are broken.
> 
> No, the options are fine, but the loops are broken -- they cannot tell
> what they are looking at is an option or an argument of a preceding
> option, yet they ignore that latter possibility.  So the word "that"
> is best left out.  I also don't see a connection to the struct move,
> though.

Ah, yeah, that makes more sense. It is an awkward sentence either way. :)

-Peff
