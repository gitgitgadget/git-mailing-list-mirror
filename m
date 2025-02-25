Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1466E567
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447150; cv=none; b=HgCb9A0yPqUPMB14/1aKz9IyUTh4XHbWX1BbWlphkooccdh2tXeHA9iNStkrbjpaioCgHV9+OEb7vOPTZ+ukE1rQpCHc5g65EUBRUTYNBnH4hILJZmScQ0GZkYmMuJQYklb5y3qO0ELyA45Unf70xgCIES//B/c4PXxQ7WHQ/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447150; c=relaxed/simple;
	bh=QaQuCeTqqgj8kqkngBGmLtnL2K4pFrI7Vm8fU2RqWbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8TwfFiqSkbPY4xUvADxklwwJHXGNrsQNw4qMnU00dIGXyd/kWcXpWHhVz6RwD4YzQdqMDMJ3aMl90VVtOkqBrDlkWXe6R0bX4KojfDNsDdXrEa0F1D1BDcEZT5w+zOTn/Z/mXFuC7hnddB76QyC6j5qCKyenQNVEXvq/L46wNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y+Uh+/pS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y+Uh+/pS"
Received: (qmail 22129 invoked by uid 109); 25 Feb 2025 01:32:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QaQuCeTqqgj8kqkngBGmLtnL2K4pFrI7Vm8fU2RqWbA=; b=Y+Uh+/pSc0KHRoG8FGql7yex2tfWl/T3umxTFyTNvuqVHsFZ8Z8Dl3e+i9Y8jH9Nz0xSSpXSn5fgaWUqyMa1652xngn+h/keuv0TH/hfbnI4XYZ+E2I41Ldh4wd6cRPM/F+llXOzA5mASaf0G96Oso2AW0uhgU6aPN3k0BSM4b9w+ZGHB3NxPM1HQXmiCf8SIF9qn2yMTf8/wtBthU3Eu3/9dKEjsSzzUIQgix18JFC9uC8LV0fUAH404m5I15buUUG2mPyQ2AcXXYt5IH6t9ArWL3tICWjrszqGGinPM4+WQFJNQCOKM8NtX2zdEUbDyqkv6VdvM/9il6nIxP6FUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 01:32:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31893 invoked by uid 111); 25 Feb 2025 01:32:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Feb 2025 20:32:27 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Feb 2025 20:32:27 -0500
From: Jeff King <peff@peff.net>
To: John Giorshev <john.giorshev1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git client erroneously downloads files when --filter=blob:none
 and filtering unsupported
Message-ID: <20250225013227.GB752084@coredump.intra.peff.net>
References: <CADJmAEiE=9Ar8CJFRWeN9f0i7TVDOF7VcV+4f-UaPw0m6Frh6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADJmAEiE=9Ar8CJFRWeN9f0i7TVDOF7VcV+4f-UaPw0m6Frh6w@mail.gmail.com>

On Sat, Feb 22, 2025 at 10:01:22AM -0500, John Giorshev wrote:

> The git client, in my opinion, erroneously downloads files when
> --filter=blob:none is specified and the server does not support
> filtering. I created a related question on this before coming here:
> 
> https://stackoverflow.com/q/79413099/15534181
> 
> Instead of giving a warning, it should instead error and exit. From a
> user perspective, when I request "don't pull down the file contents"
> and it does it anyway under some circumstances, this is unexpected. In
> my case it caused performance degradations on a repo scanner.
> 
> I propose something like this:
> 
> https://github.com/jagprog5/git/commit/c4bd8c9640c1491dc6e23acf31fa0230485b68b1
> 
> This is not backwards compatible. My question is, how best should this
> be handled?  Is this breaking change ok? Or should there instead be a
> new CLI arg or config which enabled this new behaviour. Looking for
> advice, thanks.

I could see arguments going either way:

  - you asked for no blobs, but it's just an optimization, so we can
    complete the operation for a bit more expense. It should be a
    warning. That makes it safe just sprinkle "--filter=blob:none"
    wherever you like, and sometimes things get faster and sometimes
    not.

  - downloading the blobs is so expensive that it's better to fail than
    spend resources on something that will probably fail eventually
    anyway.

Which implies to me it should perhaps be configurable. And then that
gives you a backwards-compatibility solution, too. Step 1 is to add the
config. Step 2 may eventually be to flip the default, and there the
config option gives people an escape hatch if they like the old
behavior.

All that said, I wondered if there was another similar case: when the
server supports filters but your particular filter is not allowed.

E.g., if the server has config like this:

  [uploadpackfilter "blob:none"]
  allow = false

But then interestingly, we already consider that a fatal error!

  $ git clone --filter=blob:none --no-local /path/to/repo
  fatal: filter 'blob:none' not supported
  fatal: remote error: filter 'blob:none' not supported

So I dunno. Maybe nobody actually cares about continuing with a warning
for this case. OTOH, I doubt anybody would forbid _just_ blob:none; it's
the cheapest filter to support. So it's likely that nobody has run into
it. But the behavior would be the same with something like sparse:oid,
which is likely to be forbidden because it's expensive. So:

  $ git clone --filter=sparse:oid=foo https://github.com/git/git
  Cloning into 'git'...
  fatal: remote error: filter 'sparse:oid' not supported

Which maybe implies that worrying about config or backwards
compatibility is not worth it.

-Peff
