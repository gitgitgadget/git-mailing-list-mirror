Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E23359A6C
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547566; cv=none; b=c+XFSTCSA3jMx/umczu8uzft5DhV6bilRBkRXJZFp8EF96u2cuAFmCo1RrradaBIQqo1429JbQnk9Al9WRSZtcr2V0+/7LnzmdyOeSJczAJ4MZxW1vlVXIMEbOttlwDo78JKu1a+cQh8IGDunIhJIRoP3goXhMtGaCV0s0+yUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547566; c=relaxed/simple;
	bh=6QcWavKg7nyvY7BQ4+WNOu+wyET9JCrWQKGVpKeUDSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7vPzM7dOIsO482BOJaOOL1/ihpUsRawWmJ+XC1r42/zyJ1dmcoZgj5rDV1X3DctgO8JolDiq/+Y275Lyfv4oXClT6cnhsISE5W69b16DOZJTPFyQYIixmkpp4qsp+oiJvYeaf70iqLL5Z5pBxsjNG5EHTFm0fmTZXuhpR5aueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=T2mmurs9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="T2mmurs9"
Received: (qmail 104189 invoked by uid 106); 24 Aug 2026 04:59:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6QcWavKg7nyvY7BQ4+WNOu+wyET9JCrWQKGVpKeUDSc=; b=T2mmurs9nOr+lJOTta4eaDPcwfIF4fZxrHVhNJqlld9VqvGI25VXXoUYHHq/A8+rGsYXqjjtksoJ3MFRWA55XtFgQxvX9P+9P4mXGrgbM4a5YiE/rx9fpWqIX4eFU2ei1qb2CnjALYaHiK+OBf+A+Kbkv1U426f25MkB43RKYSxFfzJ+4RvxhnFTjadUdcKIwOMMJGYLjU9TRPKnNmwskYQShraghcp9PwSSkOdub9U3DcHyMTptctpU1m2CaGh2sqgDPvTZf9GRgF7biJJ6uKFiQcG/4Ef4jmDnmsjCel95a47m2x7eXAgWKonfc0NnElf8CoLXZfffhE7e4B0PPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2026 04:59:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 127512 invoked by uid 111); 24 Aug 2026 04:59:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2026 00:59:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Aug 2026 00:59:22 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] reftable/stack: avoid reloading the stack when
 already locked
Message-ID: <20260824045922.GC142844@coredump.intra.peff.net>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-3-6bf5305d4e43@gmail.com>
 <20260820075342.GA2761530@coredump.intra.peff.net>
 <CAOLa=ZQpeCKzQ3EVXQEhfxL1khUH0YD6_Kc1qDQhxoN926rsBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQpeCKzQ3EVXQEhfxL1khUH0YD6_Kc1qDQhxoN926rsBw@mail.gmail.com>

On Sun, Aug 23, 2026 at 01:39:48PM -0400, Karthik Nayak wrote:

> I can reproduce your results locally too. I was a bit stumbled why,
> I was using a modified version of our benchmarks repository [1], which
> was using a fixed static target.
> 
> The difference was I was updating 'refs/heads/*' and your script does
> 'refs/tags/*'. The difference is in `should_write_log()`, where for
> LOG_REFS_NORMAL and 'refs/heads/*' we shortcut to creating the logs.
> While for tags, we do a check to see reflog already exists. This causes
> a stack reload (before my patches). This shows the significant
> difference in our benchmarks.

Ah, yeah. The refs/heads/ case should already have been fast, at least
for the default config. Makes sense.

-Peff
