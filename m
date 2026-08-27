Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2141A8F
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808202; cv=none; b=lMDQvZdKZdy92AqwoTbzQy/2+UszG2rf+SpA6FhKDRZ3faGS3UAiUy62E0CBEbaPxRzXMuek7aWvV0a97/+IFBQ/VPYMoHAdyareX4Y6uCX2sKhVMqLCqIrP0MdZbVX8bLvc4dZD2ONP+nga0jL7O9uxh1aQC4MeAd7zaYaaISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808202; c=relaxed/simple;
	bh=+MAQR7OoQikIaCTD/NcNPbpm8xmd9AEZxKdhVtFAS/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o59dXQYkzMt217reuTaDLa43eeDVBDnRuJUunUhXSWNCnI3Bj3F77IkKsoHac60neR8Vsf4/cgyI49Mz1nokmH6AwRj1ybyNktQhoX6sQqCjDbbATcajzHU/nD0Uj47C/V5Jp/kcojecB0XPbozoY9yzbq/STYf/DRJTlQ9E74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TImIJHLk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TImIJHLk"
Received: (qmail 7129 invoked by uid 106); 27 Aug 2026 05:23:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+MAQR7OoQikIaCTD/NcNPbpm8xmd9AEZxKdhVtFAS/M=; b=TImIJHLkfEoWujLYvPs9ulPxibyKJeijczLBSleZa2y25kFvLuSFSyjtDxNCn9mE5MOXmHxK0ymkaFa5KrR5gYFEHeQ5Jnqc9lBNB16hxvLPXCcKhBOEVCMNPcuV3yKIYd3iF3QXYJsPqqcvt5PAat293OtrSH+BsqhdjUGnMnxo9hNQUhiAgkB9V69Z8gihQHZzFi9kHm7OW0GG0H664+2+M65CQqCr93lWxc3SAl4tZc5z0LXfoxw68moK6kO7PvWfYbEIjVgwNyID0XFFglKk6PkfOQYZMYmrlUr1IyquaEX9VvRJumc6/QbW+6xZoabNJ77U6znV1CeYQ8nrLA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2026 05:23:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 35758 invoked by uid 111); 27 Aug 2026 05:23:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2026 01:23:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Aug 2026 01:23:18 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Taylor Blau <ttaylorr@openai.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/7] trace2: stop allowing die()
Message-ID: <20260827052318.GC176544@coredump.intra.peff.net>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>

On Tue, Aug 25, 2026 at 06:56:14PM +0000, Derrick Stolee via GitGitGadget wrote:

> This starts with a new banned-die.h header file at the root of the repo and
> including it from all trace2 API *.c files. It starts empty, but the later
> patches will add one method at a time:
> 
>  * xsnprintf() : This is the original patch, but made more complete by
>    adding the method to banned-die.h.
>  * xstrdup()
>  * ALLOC_ARRAY()
>  * xstrfmt()
>  * ALLOC_GROW()
>  * xcalloc()

OK. This feels like the tip of the iceberg, though. All of strbuf would
have to be off-limits, too (both because it calls malloc directly, but
also because it will bail if snprintf() returns -1). I won't be
surprised if there are other indirect calls hiding in various places
(e.g., all of json-writer.c).

I think if you really want to avoid allocations in trace2 it would
probably need to be a ground-up no-dependency rewrite.

-Peff
