Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108E14A4CC
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318568; cv=none; b=aRtiKU7t3fUFDHtju+febZZHc0uJLWDpJRRNe7O88yc3brXlCn0iH70Pr+tgy+ZcyRMo0XyYCxcB1y8E5MWncxx+gAtFiMqjTLH5A3YrQ6I8fnUg72oX/91u1dgmNFwK19ILXlesrF3BpqmvC5LDPVxg7Om65lCs76968aBne78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318568; c=relaxed/simple;
	bh=j3F7jkUEqtNIs7s9KNb6seud1IW9yjRDJNHgrB2nStU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUVRGRTDqpdb67ORrWSVqKRUASGpu7pD094cRbw8UBzek+FJjhgBTVAbXbUAETgTJerX1NCi+OhDJtqSexITFS2UoDDuwwPIrYQ7LUske6OBECZUJtJOoZcOacJP9yc6ZJk+wYpsXlT63avc29VF75l9CCFmjtarY37Gblmc6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MLbFJUkj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MLbFJUkj"
Received: (qmail 365996 invoked by uid 106); 16 Apr 2026 05:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=j3F7jkUEqtNIs7s9KNb6seud1IW9yjRDJNHgrB2nStU=; b=MLbFJUkjW/7GJqcSRdN5bbU5z/MqOsa106Y+TzRKsAj4DHfE7R7mZJ548lFTEVp/xVuRzILXjswCUf3iQTVSX3r6OGhlSpk5nMVzG14MYWpleAeTFbm/CvGkhGzZ0GCpv4iEvyH6amyjyfyXzfNIDUMURguryrAcwPVWombsGwIMMorqXgixXamV40cBVN1UAOQKlsMFZYz3sYGLiA67WkHbfdP06rCVTio6eu1uztMPneWdP4V3khGOK5hAC0D52TUSBba1lCgOCLpp9puaHQK0Q8ze5cD9qdy53AGrb2/iBne1sn/Ebd7c1DS3xjZcgPOe399Gclru1ebkcSlZcQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 05:49:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 611172 invoked by uid 111); 16 Apr 2026 05:49:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 01:49:24 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 01:49:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <20260416054924.GB646814@coredump.intra.peff.net>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
 <ad3rgbgadjIZRgaz@pks.im>
 <20260414220347.GA3475127@coredump.intra.peff.net>
 <20260414225206.GA3486072@coredump.intra.peff.net>
 <20260414230810.GA3528448@coredump.intra.peff.net>
 <ad80r_oY-uAV2zVt@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad80r_oY-uAV2zVt@pks.im>

On Wed, Apr 15, 2026 at 08:48:15AM +0200, Patrick Steinhardt wrote:

> > Personally, I am still skeptical that all of this is worth it versus
> > just checking stderr.
> 
> Yeah, the more I dive into this topic the more sceptical I get, as well,
> as shells behave wildly different around `set -e`. So I'm starting to
> feel somewhat uncomfortable with the idea of blanket-enabling it for all
> shells, as that will for sure lead to lots of fallout on platforms that
> we're not testing.
> 
> Maybe we should really only do this for an allow-listed set of shells.
> Starting with Bash 5 and newer might be good enough, and given that we
> use Bash for some of our CI jobs we can assume that this would weed out
> failures anyway.

Yeah, an allow-list is probably much better than trying to come up with
a list of buggy shells. But that only helps with portability.

I'm still concerned that this approach is going to create extra friction
for test writers down the road. This series needed to clean up several
spots to avoid false positives, and some of the spots were non-trivial.

Now that was the accumulated cruft of 20 years of test-writing, so it's
not clear to me how often new test-writers will run into this. But when
they do, I worry that it may be hard to even figure out what is going
on.

But I've said as much in earlier rounds, and I'm not sure Junio agrees.
So we can note my dissent in the captain's log, and I can reserve the
right to told-you-so later if need be. ;)

-Peff
