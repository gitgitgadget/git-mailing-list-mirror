Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0D2E06ED
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764414972; cv=none; b=OKuVaKqLcPPFqZ/ALb0t804s9N2qgKzrxw5hrFoRBA9ISdRO8FoSxovcMra/6SiwLxgVbXh8OjKHiPcL9nrw9xgLxJcaIYTMcfwyLEou8Tth4f7Cizj/8X/RI3nDKlIyqap6AxTAyOm213/LVOmP7XefWerzmzlQ5MAfLiK1DkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764414972; c=relaxed/simple;
	bh=lMQNUjzvWaQJzTVPVv61OzKOlC6XUSMd7XyJr1AnWyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+PdGtRYeed7C4Z75taHGov5iyO+FwsS7pqLXZfwgwzPUBgqdh7lZGmd6ppHkgRqSuKEqUf8ATC3QWAN5cqRJYWcvKMweY+2R8lYUyth8MLpNH/xeGq5jk9LZOPwWOwEX79I0CB/+eQZyRFG7CQzfjUjfpO90QPbgo9cUfn9L5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BgnOkXOO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BgnOkXOO"
Received: (qmail 143538 invoked by uid 109); 29 Nov 2025 11:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lMQNUjzvWaQJzTVPVv61OzKOlC6XUSMd7XyJr1AnWyE=; b=BgnOkXOOeKOFB09VOccQk6Xh60qXrITE1XflXM0AdJtUtW6gpfkLxePGVevjUWv36S0MX7oY1h1huXwd2r+SWzhniYIGGZuaBBM8H+gINJH47E+O1Evr2Up5Mc7WPw54J6hnaiOYXQqtdBJFdWIfNeQSO6rexoyJQ2N4D+Lm+HF6tt2bxQLWDWK5bC1Y7pMlOoOGqg9HbBMm3RBDrXO8/pxtwWzzm42ZqEZWuZgZw2KkJHsrIaHzZyhINqKX+I7ce4iyWfuKpZpwuwIWWX2H08IpaW25vn7LYccDK2lexV26iwoCoU66qg5b0C1ae4ZZJyaDvMq2YLwUkojkLGjwjQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 29 Nov 2025 11:16:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 236347 invoked by uid 111); 29 Nov 2025 11:16:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Nov 2025 06:16:13 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 29 Nov 2025 06:16:07 -0500
From: Jeff King <peff@peff.net>
To: Justin Su <injustsu@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: SIGSEGV when running git fetch
Message-ID: <20251129111607.GA1778411@coredump.intra.peff.net>
References: <CAB=S_8JufSGCOBjCQJ6R1Lq-GumJXTPzWGv2JCZK2SPw_XuGPA@mail.gmail.com>
 <aSo2n2dhEoZd3nZW@fruit.crustytoothpaste.net>
 <CAB=S_8JFLYsGe7fs7UjCfFfTJGMqpikZavztU6ZiW4KS21A+MQ@mail.gmail.com>
 <CAB=S_8+omhdW9Mx3kr=McZvoC-GbftWmsBVLQuRH=0CmChq85Q@mail.gmail.com>
 <CAB=S_8++iZZtPXm_Fp9ZuBJ_zKN1c3SWy1qMghbx+qop4y7OCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB=S_8++iZZtPXm_Fp9ZuBJ_zKN1c3SWy1qMghbx+qop4y7OCQ@mail.gmail.com>

On Fri, Nov 28, 2025 at 07:49:26PM -0500, Justin Su wrote:

> After installing Git 2.52.0 from the Ubuntu PPA, I can no longer
> reproduce the crash.

Seems likely this was the bug fixed by d70f554cdf (commit-graph: retain
commit slab when closing NULL commit_graph, 2024-01-05).

-Peff
