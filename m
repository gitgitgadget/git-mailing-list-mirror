Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2C2F83A7
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411173; cv=none; b=iggHm9gGjuNQFillxZqxLNgqqJ2nZATsSMstoiJSVDQIxbIKZHNjEUeZ4J/j1kq5lXJcSVoJpHfqmWqe7fXmFXDbw2bpo7HJnslrA+ekPIZMcb4DIy9w8n2g5gRy3czV7YMaAKsfbG9bAf5nKb6DZu5Xb7Q1tCWsNK+z2e5RO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411173; c=relaxed/simple;
	bh=MxCBFQbN0zLGABcu7zbmfUd/edO/CS0UAHSJ8RrFtPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by01vqgu1NlqNVbsChSWBwRFmXMCCrBm8YKS6SVx10pSjtEGZzO0PSSkMjvxilaAnLjjfIZNRK4OHgY5VNR8fSF7IM7MfHSRZQn3f5pJP+2JWJETcgovxdrwQUX9IEGJXl37nUBPZZ1O9lY+dC0IsVRYMi/M6Gr3rN7+/c2F01I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dw+lTBT9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dw+lTBT9"
Received: (qmail 40533 invoked by uid 109); 14 Jan 2026 17:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MxCBFQbN0zLGABcu7zbmfUd/edO/CS0UAHSJ8RrFtPM=; b=Dw+lTBT9LiqbIaS93njgImUEqECRi84pOJ0H9Vjz76LxN2Hoke0BJLqRxGpq8/KELPhmRNydVZ4cnOe+6x7u3ANBnxYHRqh0v07uzp913cxHMfBW4Iu/9TvlDTk1u/4BZDYMUMmq+n0mgaUvPftVCGGCpV2/OiaQkf43Y/brqBqSpef4Ug7g77pfTV+duSUVrjHZC/5w/ZHC+KVuC+hiKmZWetYqQEpaPINvHXLm++ReIebZvkoXl6kx7x4MZ6Les2zN4NqpDJSNdG7FFWYxYxfSCCTyWD3ohbfYFpOLLoXMBf9rJvSt4f+uxGl2a03VlBNrvSO8bQpUTpFHFSCSpw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 17:19:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67021 invoked by uid 111); 14 Jan 2026 17:19:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 12:19:31 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 12:19:29 -0500
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Chris Darroch <chrisd@apache.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] hook: allow hooks to disable stdout_to_stderr
Message-ID: <20260114171929.GC885771@coredump.intra.peff.net>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260113234528.1749921-1-adrian.ratiu@collabora.com>
 <20260114031257.GA858646@coredump.intra.peff.net>
 <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>
 <20260114170849.GB885771@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114170849.GB885771@coredump.intra.peff.net>

On Wed, Jan 14, 2026 at 12:08:49PM -0500, Jeff King wrote:

> I looked at what feed_receive_hook_cb() is doing and...it's kind of
> horrifying. It arbitrarily sends 500 lines, and then yields to the
> caller to pump stderr (assuming ungroup=0). So:
> 
>   1. It is assuming that 500 lines of input won't fill up the pipe
>      buffer and block. Even if we compute the size of 500 lines we're
>      sending, we don't know if the caller has cleared anything from the
>      pipe in the last call. There might be zero bytes available!
> 
>   2. After 500 lines we'll go back to the caller, which will then
>      poll(). But if there's nothing to read on stderr, it will wait for
>      the 100ms timeout. So if you have, say, 501 lines to send, then
>      there will be a pointless 100ms pause in the middle.
> 
> So here's an example hook setup that will deadlock due to (1):

And just for fun, here's an example that shows problem (2):

-- >8 --
rm -rf repo
git init repo
cd repo
git commit --allow-empty -m foo
git init --bare dst.git

cat >dst.git/hooks/pre-receive <<\EOF
#!/bin/sh
# We don't even need to do anything interesting here! Git
# will send us 500 lines, then block waiting for stderr which
# we'll never send, and then send us another batch of 500.
cat >/dev/null
EOF
chmod +x dst.git/hooks/pre-receive

# Now do a moderate push of 500 branches.
seq --format='create refs/heads/small-%g HEAD' 500 |
git update-ref --stdin
time git push -q dst.git refs/heads/small-*

# And compare with one that sends just one more.
seq --format='create refs/heads/large-%g HEAD' 501 |
git update-ref --stdin
time git push -q dst.git refs/heads/large-*
-- >8 --

The second push always takes 100ms more! If we run the server side under
strace by replacing the final line with this:

  git push -q --receive-pack='strace -T git-receive-pack' dst.git refs/heads/large-*

we can see the stall here as we write to the hook:

  write(4, "00000000000000000000000000000000"..., 51393) = 51393 <0.000011>
  poll([{fd=5, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout) <0.100506>
  write(4, "00000000000000000000000000000000"..., 102) = 102 <0.000057>

That would likewise be solved by using ungroup=1 (in which case we do
not poll, but just call the feed function immediately again) or by using
a real poll() loop (which would see immediately that the hook is ready
for more input, rather than hitting the 100ms timeout).

-Peff
