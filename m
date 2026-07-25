Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B54908CD
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970555; cv=none; b=dSw3FIyB6gveAwwaYjFyVhN6Rc1jbJhzsDllaZ2Vp+6yVaUxmMZZxzpVm8ScXKy81Q2QsWzK/8/54zaKYzwTHdkeAX+rM7/JYjErp7EhUcfjoxfZVd9cgcClaWTE6E2vM4om1Pi9VUa6FR4UsJ33f48SLIOVwkmBRfYMhlcclbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970555; c=relaxed/simple;
	bh=0FnQhceJ9GCGetNzbA07fYZAXV4XpA/dVg14RasB62c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Neww7OvuYyBTS1zvkQvwmJV616uNa/1pWR1QKbtCXmWXIUmdNdo2SWXvZPkMecGLBjcK4x8jk13K77udbfyhfwvAWhRywlXdSkqfPFtkjBOsBNtgT2E27YpnLc4cMURQdflr0kKpGAWL40ug6FWer+JDoCyK4ViYnYof2VpApQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aWbGCBMI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aWbGCBMI"
Received: (qmail 45531 invoked by uid 106); 25 Jul 2026 09:09:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0FnQhceJ9GCGetNzbA07fYZAXV4XpA/dVg14RasB62c=; b=aWbGCBMIR5OZMDtOdzpk84WU8bGFuhpCGwmu7JXtVPbAVtmagoCCvsUsBxNljrbTMYehRbIGF48XcYfAJa3nLa+WrI2v99ejMLME0H+MsGSetBFYSmli5nAiVJjD3yTlfGFx4pKqa+wGhmfWRyu2CpbFYnxFeSBpYV9AsEmn5DUXMfvhIZO5IrpEmKUJWDNd/YXBXc6e2OexHs5hdOJjvgSmgvN1oXlOPdvEz/bNZmTZyMc4yI95Thxmhe/u26PEjogpHySZ5v+IAa9NwLMo39lrlReD0YodGVhSUcPQBwJ/kpuvMhsOFHf/cakLqZbTc6yX3VFxSaFK+GLNG8XZSA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Jul 2026 09:09:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 45011 invoked by uid 111); 25 Jul 2026 09:09:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jul 2026 05:09:16 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Jul 2026 05:09:10 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	me@ttaylorr.com, ps@pks.im, karthik.188@gmail.com,
	sandals@crustytoothpaste.net, avarab@gmail.com
Subject: Re: [PATCH v3 0/3] packfile URIs: support concurrent downloads
Message-ID: <20260725090910.GA1438796@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <cover.1784676106.git.tnyman@openai.com>
 <xmqqldb19evx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldb19evx.fsf@gitster.g>

On Thu, Jul 23, 2026 at 09:43:14PM -0700, Junio C Hamano wrote:

> When merged into 'seen', this topic seems to cause t5550 to hang
> fairly consistently.  It is not surprising, considering that the
> topic adds roughly 240 lines to the test script in question.  It is
> entirely possible that we are seeing an existing breakage from
> another topic in 'seen' that is exposed by the additional tests.

I didn't get any hang locally, but running t5550 with --stress causes
around half of the runs to fail immediately. That continues to be true
with v4. So there is presumably some race condition still present.

The failing test is the big one (34) and the failing command is the
"test -s $tmpfile" call. It looks like the pack has already been indexed
(at least by the time I look at the on-disk state of a failed example).

I don't immediately see the issue, though. I could believe that extra
load fakes out any sleep-based timing tricks, but it looks like the test
tries to use FIFOs to do everything deterministically.

Diffing the overlap-first.trace file between a working case and a
failing one, I see (skipping past uninteresting port differences) this
hunk at the end:

  @@ -17,4 +17,5 @@
   <= Recv header: Connection: close
   <= Recv header, 0000000002 bytes (0x00000002)
   <= Recv header:
  -== Info: shutting down connection #0
  +== Info: end of response with 1048917 bytes missing
  +== Info: closing connection #0

So curl sees a hangup on the first connection (even though the second
one hasn't even started yet!). I'm not sure why, though. There's nothing
useful in the server.log file. I tried stracing the server process but
it didn't show much of interest. Both cases write "ready" to
first-ready, and then the success case immediately sees an accept() for
the second connection. The failing case waits in accept() and then
eventually calls SIGALRM (which is way after the failure happens; the
test has already bailed and so the second connection never comes in).

So from the perspective of the server process, everything is fine, but
curl complains that it didn't get all of the bytes. Weird. The strace
shows both writing the first 1MB as expected. It's like the connection
gets hung up for some reason, but I can't tell why or by whom.

-Peff
