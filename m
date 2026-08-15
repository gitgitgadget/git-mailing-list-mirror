Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C12DB7BF
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786770737; cv=none; b=s5jgRwnF7vM47IZQ2+3SLoUp2f90dIGR0V82xfeQNuUh9VjmtqGIGP+1i7DZyqfnhjFtj41DqLm0uEU/pCby1zdJsDfmtiurKyslkSOowWdRvyu7Xk5q5Fj4J6UV6eoKTrzIFgjidzEji309bXHcqmF/fPIX3fTEGSfmVLxZasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786770737; c=relaxed/simple;
	bh=3XRiXhXkNyzpZ8nfRHvCHA0ysQHMdcrlw03/ahpjutg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyxSKLGZI4IrORqkTT+bGpRLQMgLjOglM85ulngkJahNdp1tffe3enDz6k5KhEoEW0TtaxijmuLAibNEd7o76WobJ2iUH26wHfVN9J4O/B33lph+PsNTaV1AwZagOU7l34YKkh9vOyxl6N31Xb9zGeo0r+JrToauXJ2iP54q0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fOvPnugt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fOvPnugt"
Received: (qmail 66346 invoked by uid 106); 15 Aug 2026 05:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3XRiXhXkNyzpZ8nfRHvCHA0ysQHMdcrlw03/ahpjutg=; b=fOvPnugtuxIEe0PgVoBqP5HMNgyhjJ/gQ21Ak2Ubw9lAY0ox3yMKZ9Q3lj2pud1mPybA1p60fe+Bqe3n5CuN01IPTWvWrfAQomVgWXBrVs2O5FSH4ergZc9W3QCum3ssrbgsYjDu67t0TA/xbIEBTaxk8deykFeE9/AILuNbZ380TWlmFiL+mW3LPLxyn/0RjGVJd5V7Wh9X7Eiuzi0+GEDoRV/LMUXay5Guu7PVkc2mq9wr4qN2WuSyznFd7CSt16+Vgr/QEfbDhHwtQvqH5c/DaNDbV4oVUh5mU62qfN24fAB1dYFWZMc7OmxudSwKTwawq2IPB4WyJqOP6Wz+Sw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Aug 2026 05:12:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5525 invoked by uid 111); 15 Aug 2026 05:12:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Aug 2026 01:12:13 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 15 Aug 2026 01:12:13 -0400
From: Jeff King <peff@peff.net>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] chdir-notify.h: Removed unused param 'name'
Message-ID: <20260815051213.GA26013@coredump.intra.peff.net>
References: <20260814193849.1538-1-colinlewishinton@gmail.com>
 <20260814214210.1625-1-colinlewishinton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814214210.1625-1-colinlewishinton@gmail.com>

On Fri, Aug 14, 2026 at 02:42:10PM -0700, Colin Hinton wrote:

> The `name` parameter in `chdir_notify_entry` was only ever used by
> chdir_notify_reparent() to produce trace output. That function was
> removed in 5bf546755c (chdir-notify: drop unused
> `chdir_notify_reparent()`, 2026-06-25), which left `name` with no
> remaining consumers.
> 
> Prior to that removal, most callers had already stopped passing a
> meaningful name, switching to NULL in 1f43ff2c7e (refs: unregister
> reference stores from "chdir_notify", 2026-06-25) and 0de2467e6c
> (odb/source-packed: start converting to a proper `struct odb_source`,
> 2026-06-17).
> 
> Since no caller has populated `name` with real data for some time,
> and its last consumer is gone, drop it from chdir_notify_register(),
> chdir_notify_unregister(), and the callback signature to simplify
> the API.

Thanks, this description summarizes the situation nicely.

-Peff
