Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2715B11D
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058765; cv=none; b=eOcSpF5Be97lxoe/rVJBVDoSVyeqvUvaoQ4M9qe9VfEiztiHZ+cGnTRAQLvwVZkLMX9WBQJEZRtgjkq2R6QHLaXTu5d9WIp/Cpa4cdM6JMtbg1tlXmBwbT9aOqzRpkOLubAZuQgqqVlsrqvn88+hIotOS5LenZwElxkhBJRXwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058765; c=relaxed/simple;
	bh=C2WW/54Qq7xx0k4NLrDevIHRdnlFtWFmxBnaw+aRAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBMuC2ey21VqoACwDNJx89DOGQdV9l8bvUIjqkgMlfPb5K2fLMywZr6qmjk0Y4UlH+KGfNkKG03OhS+N/RWzaVvaagOWpCJgXx15Od7ONuJp981LxsfwKIpwUjl9WAUs5UCmgBReCSHLATT1Nsh6YPcPaRb6JsPH6D0EAQCAl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8831 invoked by uid 109); 19 Aug 2024 09:12:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Aug 2024 09:12:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18178 invoked by uid 111); 19 Aug 2024 09:12:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Aug 2024 05:12:46 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Aug 2024 05:12:41 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t7900: fix flaky test due to leaking background job
Message-ID: <20240819091241.GA2958552@coredump.intra.peff.net>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <4805bb6f6c2c96a2c40d1d8359b63b8c7045e0b6.1724053639.git.ps@pks.im>
 <20240819084943.GB2955268@coredump.intra.peff.net>
 <ZsMIa_5jCFs4OWYx@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsMIa_5jCFs4OWYx@tanuki>

On Mon, Aug 19, 2024 at 10:55:07AM +0200, Patrick Steinhardt wrote:

> > This looks correct, but should we be doing it for all of the "git
> > maintenance" runs in that script? They're all going to kick off detached
> > gc jobs, I think.
> 
> Only those that use `--detach` run in the background.

I thought since the default for maintenance.autoDetach was true, all of
the "--auto" ones would need something similar. I notice a lot of those
use "--task", though, so maybe that doesn't count. I'm not clear on all
of the rules.

-Peff
