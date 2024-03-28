Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C782870
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643368; cv=none; b=LbIJTb+KqaYI2gnr0IILgYBs8eIlhqEf40/C7uFJZh8yNunl0eSZRDsm96iNZi6MHqMojgJzs2/luahD1+G+efCkfaqquO4ip3EX0AlPrs1oWujaKHDUUU7tnm317M2c8Kqfs/pkFh01aLQeuvU6PJV9H4g2a314YxAwosUewAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643368; c=relaxed/simple;
	bh=iqUwoelWBniP1amrnoa/lfX23GdGj/od3UeNovq29Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzCwdQelU3/qBThNEXQDxD8ofEfkS7SezUUEw4AtpuBwNdUtb8KQELwFGfPpBqqZEPJMqCPT67U8W0mBqroSVuhAL0FdCiKQyMux5woA3KRZHYcniZzXNvW6+vlIwcEOMc+1QuQXQ5CE+47Mri2o7Y/jkjNj5ckiN0rJ6vKefpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7209 invoked by uid 109); 28 Mar 2024 16:29:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Mar 2024 16:29:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7459 invoked by uid 111); 28 Mar 2024 16:29:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Mar 2024 12:29:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Mar 2024 12:29:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
Message-ID: <20240328162923.GA1403492@coredump.intra.peff.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-6-sandals@crustytoothpaste.net>
 <20240328102053.GA890906@coredump.intra.peff.net>
 <xmqq7chmwczx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7chmwczx.fsf@gitster.g>

On Thu, Mar 28, 2024 at 09:13:38AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It doesn't show up elsewhere because only bash complains, but not dash.
> > Even running the test script with bash isn't enough, because
> > write_script uses $SHELL_PATH under the hood. But building with "make
> > SHELL_PATH=/bin/bash test" shows the problem on other platforms.
> 
> Can we sneak it in to the GitHub Actions CI, I wonder, so that we
> can catch tests that only fail with bash.  Would this be sufficient,
> or can we just export it without using $use_bash to place it on the
> command line of make?

I think the sneaking has already been done, because Windows CI uses bash
(which is after all how I noticed this). I'm not sure if using bash more
places would be helpful. On the one hand, there are enough _other_
differences in Windows that it is not always immediately obvious that
the shell is the culprit. On the other hand, I would probably forget
that linux-gcc is the special one with bash, and just end up reading the
test output anyway. So I dunno.

As to your question, yes, I think you could just export SHELL_PATH; our
Makefile uses "ifndef".

-Peff
