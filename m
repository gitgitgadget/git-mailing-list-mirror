Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE13630B5
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981922; cv=none; b=jrI50GdL34sJjgNsFUPF4YEUZynij96q3aorT/mTc/VEInRqVI32YUrubEAs+NSY4XmVavzrWZ+mEQkbthxHYGR0hThEYvXjZmiliZlak87xwJfsHamVgq1VOdaZ+hd5Y/zmAVzkvgTIO491CkgmtSeIEqgDSR12kFlY5z14pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981922; c=relaxed/simple;
	bh=V7s36apUnM9FbRFDhYGblenMKeMJjR4R2gLOel2Z09c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maMg8j7XXc81bGsLDcE6aivDgQRp7NGVmcFQbtxFx1mhW+5ljxDLY0KXI/CjJVtRliWKgnjp6XS4m/DZiESua1ti7U58p0jb5lrXgkZgWXSasAORb9ny2RUxXOkM5Nw3nMgd8mpGgXzENI/OAuVieJ4X7rKb56Dy1hy/n+sOX7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EZ/tD19z; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EZ/tD19z"
Received: (qmail 85920 invoked by uid 106); 2 Jul 2026 08:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=V7s36apUnM9FbRFDhYGblenMKeMJjR4R2gLOel2Z09c=; b=EZ/tD19znMt4dOMSqX7WOz576bD6anCOzl6MrXXwRLr8KSVTxXcXtaw8UpOIuODKS0UvASWSqwF3/33xKGkAzV74dwE9cwiR4o18pMep+vE4o6mWkxD6uH/MWVwc/C/cQw/Dvi9L/0vf0omlIED4+6Ft84cgWh7IbIUk5VKJbVoBL2vJaAvQgp1rGwh1NM0M3xBeDLTIb2AVwmC8LSNXZTC6jP/n2U1/hOCgduskgXxgJ6h8SH2nUvKhsy43Xd+wB+gM8qZw34hAW7h+gYJHGeh6WBDv6Nfg8R0y1iOyQIGm26rQaszaswXQAYks5+o2jT/AIpJOaDnpusN4PUanlw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:45:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178685 invoked by uid 111); 2 Jul 2026 08:45:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:45:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:45:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] rev-parse: exit 0 on --help
Message-ID: <20260702084519.GB481298@coredump.intra.peff.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-1-sandals@crustytoothpaste.net>
 <xmqqcxx6mkjn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxx6mkjn.fsf@gitster.g>

On Wed, Jul 01, 2026 at 03:06:52PM -0700, Junio C Hamano wrote:

> > One of the patches is rather long because we have many cases in which
> > we've hard-coded exit code 129 into our tests.  However, the changes
> > there should not be complex, only somewhat tedious to review.
> 
> It is borderline for "yes, we all know it is obvious that things
> should have worked this way from day one, we regret that it is not
> the case, but it has been working differently and users' scripts all
> have been working with the current behaviour, and it is likely that
> they will all break".
> 
> Two big things that make it much less likely, saving grace, are that
> this is only about "--help" (which is unlikely to be a part of
> end-user script), and this makes the invocation succeed (if we were
> changing from exit 0 to exit 129, we would be breaking tons more).

My big concern is a script accidentally continuing when fed "--help" and
generating nonsense. But I think the eval magic explained in patch 3
makes that unlikely (any such caller was already kind-of broken).

The other issue I raised in the earlier round is that a script like:

  cat >git-foo <<\EOF
  #!/bin/sh
  git log --my-options "$@" >output || exit 1
  do_something <output
  EOF

when invoked as "git foo --help" will now call do_something with
nonsense input, rather than exiting from the "error" returned by
git-log. This only affects hacky little scripts like this that are not
otherwise parsing their own options, but sometimes those are the most
common. ;)

I'm not convinced there will be much fallout, but it is possible.

-Peff
