Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49B279346
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096463; cv=none; b=rCMav8uIzmxnfNaGC36wv+sGxjOrPen/ESE8OOaPWv+jLjjiZWdQ6HSUYB2IqZluGumVG6roMHhDAGC06RY4G6dG9hPuSOAGZ34bFHoi1aK3WbYEnruGo9y/IAcujOnJvby0dppn4liYA5vR85jkpUJWuF5U2eZ+XuRbl9Jqruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096463; c=relaxed/simple;
	bh=QL2kXTmXB1pxhvG8I8kR9/mnV5/OtE9sztRh44Xb9xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASrZ9GkO9gWivqfqyCpxenIdghwwHIX30yraN3lcd1dneq6gKAFAAdkiad1LJjlu/6g7r0lnrRB947zmWI8CSnwThkgNSEqyleqkdOLWochkJ6P80dSnydgI9aY78Xi3aYWI52Fqu1LceCYCsCYNZQWG6QoTPqfI4gGibCmbOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YLD8CMIz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YLD8CMIz"
Received: (qmail 52807 invoked by uid 106); 9 Mar 2026 22:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QL2kXTmXB1pxhvG8I8kR9/mnV5/OtE9sztRh44Xb9xU=; b=YLD8CMIzmO30tPSZRyr9qIPqYWo8TKswimNhlzDLkj6fsm97GBlYyFCE66CCfGjJHpkLHPbLmBelWIse/1Lv6r+4ujxmH3UH/ax9kf4828ubIEVNuGPMBjIl7wkVJy1d6ES4+7P0QO28/6RQQFCHZ4A/6iZxVEJMzc1Po0bfU/KU5+T/z7x4BujlAUcYy+8lsrkMFWWptLDYKPVY9cDFgOGKW5/s0PGBdsed/Xat3u6PHUpECllRL3Vz5IBwBTM0bqDdhZok9WI8045gkUFQPlaU3Rc6fqpaFF6wKxG0knn4KViQoPjKpEZEoUw6QsOldOxfYYqIY8g1K74fjjJVDw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Mar 2026 22:47:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 461249 invoked by uid 111); 9 Mar 2026 22:47:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Mar 2026 18:47:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Mar 2026 18:47:39 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: PRASHANT S BISHT <prashantjee2025@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t0004: replace test -e with test_path_exists
Message-ID: <20260309224739.GA5682@coredump.intra.peff.net>
References: <20260309173635.29683-1-prashantjee2025@gmail.com>
 <xmqq4imo4sf1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4imo4sf1.fsf@gitster.g>

On Mon, Mar 09, 2026 at 02:14:10PM -0700, Junio C Hamano wrote:

> PRASHANT S BISHT <prashantjee2025@gmail.com> writes:
> 
> > -test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
> > +test_lazy_prereq WRITE_TREE_OUT 'test_path_exists "$TRASH_DIRECTORY/out.write-tree"'
> 
> I suspect this is utterly wrong.  As you wrote in the proposed log
> message, test_path_exists is *NOT* about checking if the path
> exists.  It rather is about *expecting* for the path to exist, and
> fail *LOUDLY* if it does not.
> 
> You need to _think_ if we want a LOUD failure when somebody checks
> if a path exists and conditionally skip setting a test prerequisite
> when the path does not exist.  The original code is trying to be
> quiet, as the check is done not because existence of the checked
> path is good and lack of it is a test failure.  Lack of the path is
> expected on places where the prerequisite is not set, and that by
> itself is not a test failure that you want a LOUD report about.

I'm not sure I agree. Verbose prereq blocks can help with debugging.
Normally you would not see them at all, but if you are investigating why
a prereq did not trigger, you may want more output.

Without "-v" you would not see the output either way, like:

  ok 1 # skip some test (missing FOO)

But with it, it is the difference between:

  checking prerequisite: FOO
  
  mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-FOO" &&
  (
  	cd "$TRASH_DIRECTORY/prereq-test-dir-FOO" &&
  	test -e foo
  
  )
  prerequisite FOO not satisfied
  ok 1 # skip some test (missing FOO)

and:

  checking prerequisite: FOO
  
  mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-FOO" &&
  (
  	cd "$TRASH_DIRECTORY/prereq-test-dir-FOO" &&
  	test_path_exists foo
  
  )
  Path foo doesn't exist
  prerequisite FOO not satisfied
  ok 1 # skip some test (missing FOO)

Probably it's pretty obvious for a one-liner like this, but I think it
would help for a longer block.

-Peff
