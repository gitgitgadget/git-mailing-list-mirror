Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477C221FDA
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520358; cv=none; b=tKhU1I+zf5nop/rm89cJJJ4KZ62v6jOU1BsO4mGcXLy6ZIvxVtNkIXNZ+FB3UstM8VLFlzHkAp/2UffMRe1vWVABfqorL2QLkqx9Je8d7aYh4ajBi3D5nLFzPEBSJawSNfb2eEsponZ9Ic1b+uVZLTZiBH5UzZMrHVnLHRFLlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520358; c=relaxed/simple;
	bh=KMDS+AV2YG4fQ8fx/ga/qsx4ynIm3kcCXDWoUZS8R38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDjP61bvkxiZcsJ1HjI5u2A25WUu/gaqIt1QTzEKplRGfl93CmNfc1lgwC6vsmMP2MsaNacU4s7YIT+elURqzbt1mT1Zo83SBjx+jl9FvSJYUfPfHCfNtlvwJ1EdqLL0KH1mtGMQV1wLKdzAhR0dAXKsTcBZy/hh6gbjL7CbUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CtqxCv7J; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CtqxCv7J"
Received: (qmail 154768 invoked by uid 109); 30 Aug 2025 02:19:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=KMDS+AV2YG4fQ8fx/ga/qsx4ynIm3kcCXDWoUZS8R38=; b=CtqxCv7JOmuTTKhM2nnV+ceOMekpyCj/ZWPL2ie4FnqIxzQrGOyawKTIIdjmHWUp+yrOnw/jfUOUew6yjj5k1kqeilZb3iR4Btgf2fPq2clYlZ4prOwxKeEQLVl6Hwa14F2ygwRMiFd1HIeGUDYOKQboXW3F9WKtArOJBytAQKGIn8YZ5keSvKPjJEC/NUdYZVOhAK5BzIpv/H5uJcHfdtmuXydeSUGGUo+L0KVFjgaoGli8eZyn7SOyKZifXtZDYvfc/8RHAoRpSGIuGxBzwxHGuRISKtNjcTfNpcivr+YadGg8MyUwayO0+3T6k04SpVibTR5cyVuUmzVVkVJbeA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Aug 2025 02:19:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 275141 invoked by uid 111); 30 Aug 2025 02:19:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Aug 2025 22:19:06 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 Aug 2025 22:19:06 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] curl: add support for curl_global_trace() components
Message-ID: <20250830021906.GA567900@coredump.intra.peff.net>
References: <20250827080702.GA3572995@coredump.intra.peff.net>
 <57a79b29-0e65-482c-b0a8-1e73744ad5f6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57a79b29-0e65-482c-b0a8-1e73744ad5f6@app.fastmail.com>

On Wed, Aug 27, 2025 at 11:21:18AM +0200, Kristoffer Haugsbakk wrote:

> >   The config string is a list of comma-separated component names. Names
> >   are case-insensitive and unknown names are ignored. The special name
> >   "all" applies to all components. Names may be prefixed with '+' or '-'
> >   to enable or disable detailed logging for a component.
> >
> >   The list of component names is not part of curl's public API. Names may
> >   be added or disappear in future ver‐ sions of libcurl. Since unknown
> 
> s/ver‐ sions/versions/

Ugh, troff. I cut and pasted from the man page, which hyphenates, but
had to re-wrap in my editor for a sane width (plus removing extra spaces
due to full justification). I guess I should start using:

  man --no-justification --no-hyphenation

for this.

-Peff
