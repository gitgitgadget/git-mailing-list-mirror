Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EA25A655
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770411209; cv=none; b=mKqryQXKb20pXWfZ3FXLoiIipj2rkHNAwf1MpSYFN3qkHLHEBT545JjUzR6hfOHDqZl+1dndhobxsR9YgZGDSnwk3kBvzaIHJ7Tx69wyqewgwA4KWrnAsqMIUS3VbpRqEnSUgq6v8tYng5frf37sVkYTWAiJ3gYdzGKSuWouTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770411209; c=relaxed/simple;
	bh=3fkNqAC1InWaTJhVK3ekrnr0VVwWxYdNtlDaz93qDII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMEi2VGUyEnavuubuPsuQD7TDGlZcaxdNBmkvrVZ0SuTDvcHVqFqlsW9dfm8lOhHoxjNoZMsuou1wrv76oip2tdhO2RDwradiFMnhHFqLZzg/V2mISUh60wbr0BZeAPd/dCTdMtLRnkld2FuLbtiYtJMSaqLJgvNsFfL1Ac6M1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OS17xLUQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OS17xLUQ"
Received: (qmail 304884 invoked by uid 109); 6 Feb 2026 20:53:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3fkNqAC1InWaTJhVK3ekrnr0VVwWxYdNtlDaz93qDII=; b=OS17xLUQpa7RWPmNcehnGBxZcmInPC7V3tOQkLcbcIjhnC6ad9nLu6lpwXxNB5rz1qe8MMov1O8YrtXq1VxVwciusDtCuz/YQ/mOYChr89sYtAWljteJgmCQRWou5wOuqFAoXkM88vSPqgepy7n+6wCRUCY4NxWNSB8Pdwqdkf3vqAd1zFkcoWAQPa/365JE/jhl6KNcXQAaBqJ4mL0Di7cIjv59fEitUBw7F2AgglsUo2Wvn32/zdp6F0HB14Q821nNcDRfoaD1YD6i+FX97CskmDaK6C09YjhdIpdDkTWMeku2ncdXDabZgIlS1BsgiCva+/ivgnvzs1lJnZ7AAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Feb 2026 20:53:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 608896 invoked by uid 111); 6 Feb 2026 20:53:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Feb 2026 15:53:30 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Feb 2026 15:53:27 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ashlesh Gawande <git@ashlesh.me>, git@vger.kernel.org,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] t5550: add netrc tests for http 401/403
Message-ID: <20260206205327.GB2787536@coredump.intra.peff.net>
References: <20260106114029.763351-1-git@ashlesh.me>
 <20260107074724.13165-1-git@ashlesh.me>
 <xmqqms1mihqo.fsf@gitster.g>
 <20260206093840.GC2761602@coredump.intra.peff.net>
 <xmqqtsvtg49h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtsvtg49h.fsf@gitster.g>

On Fri, Feb 06, 2026 at 09:39:54AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think it is fine to check the 403 handling, but note that this _isn't_
> > how GitHub would respond. If you try to fetch from a repository you
> > don't have access to, it will return a 401 first (so you try to log in)
> > and then a 404. The idea being to avoid revealing the existence of the
> > repository to unauthorized users.
> 
> That is a sensible thing to do on the server side.  Presumably when
> we talk with such a server we would report 404, right?  It is not
> like we behave all that differently with either type of errors---as
> long as we just give up and do not fall into an infinite loop of
> asking "oops, that password did not work, try again", it would be
> OK.

Right, we'd report the 404. We never loop on trying to authenticate, but
do a maximum of two tries (and then only if we get a 401 on the first
request and did not already provide a credential ourselves to curl).
Curl might make multiple requests under the hood for each "try", but we
won't even know about them.

And all of that is independent of which HTTP error code was returned
(except for 401, obviously). We do eventually produce a different
message for 404 vs a 403, but that's at the top-level of remote-curl.c.

The interesting bits are in http_request_reauth(), though some of the
logic is in handle_curl_result().

> > The netrc support here should not involve credential helpers at all. It
> > is all being done internally by curl.
> 
> Yeah, I phrased my question in a wrong way.  As the code paths
> involving credential helpers are separate, I wondered if we have
> similar test coverage there as well.

The workings are hopefully covered by the explanation above. As far as
test coverage, I think t5550 covers this already. When we provide the
wrong password, we bail rather than asking repeatedly (e.g., in "cloning
password-protected repository can fail").

-Peff
