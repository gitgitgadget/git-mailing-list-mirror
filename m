Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC8311968
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365349; cv=none; b=M9Lul+A3+15F3n73aBBBJLJNjiCGE9ZRG+nLwKBBkjuzG9bGDc5nlRPA58VkIPsYLbfZUuC/FkfGNEdyOuq1zJQtos3AT7i9sJlO5H72+MmCluvFTu8jGAA78Nw97xOs+5ri2VtWhnx6bINkIc/vBgfSkDdRnHCUnITBf2KwtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365349; c=relaxed/simple;
	bh=zFedr66zWKi2dnsze2q1z4zaH6LDccRzT9LVdQBfshg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB7AWskD4QDetIRV8N7Q6FWh+xfTLOUELChZQUrYmSjGZK5Ho35Fjg1CPjK6ve1QAB51p7HsxA+yZuy86kt8Kqf69fwSOX7EUYtrrWScHiBEs4K8FaZkb1mz635mgo/PQJdkiN9e3Y8WaNGDnwe/VEdskbUT3OIgILYYfJi2k3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LmzbbBwH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LmzbbBwH"
Received: (qmail 95185 invoked by uid 106); 13 Mar 2026 01:29:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zFedr66zWKi2dnsze2q1z4zaH6LDccRzT9LVdQBfshg=; b=LmzbbBwH5myGw7861SArbCJ4FnWXa9WUD1vEt+XvygSaTy/LqJfDO9cKJxOZa5aM+1gQ7CGSelLOPAY3bw2YTpQMnAz7dBLpFI3wxw/OASFaUVIqD+v96OTwvGkncTyhBAN0RRLytuBKMwvf6jY3quvNnaBlJ3m8f/GO/qIM7wFDQIl+gw8QfgyCo0bKxprwK/CML8y7r7yeQB5LzEBdJyJPSwnMbaCMWxpI78W2LxGQZRR72UJ7dIAXyqqmhLd76nynZSx3bX12NYWu9kA5Y+eHJs2wDXUxPo0/RYxDXMqIjz+IIc8CvIw/069Ni9AzXKkffR5Z1d58i9LH5eVMhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Mar 2026 01:29:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 518088 invoked by uid 111); 13 Mar 2026 01:29:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 21:29:09 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 21:29:05 -0400
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] apply.c: fix -p argument parsing
Message-ID: <20260313012905.GA3749719@coredump.intra.peff.net>
References: <20260310005408.2022216-1-mroik@delayed.space>
 <20260310050621.3849719-1-mroik@delayed.space>
 <20260313001629.GA3193660@coredump.intra.peff.net>
 <20260313011259.GA3204960@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313011259.GA3204960@coredump.intra.peff.net>

On Thu, Mar 12, 2026 at 09:12:59PM -0400, Jeff King wrote:

> Getting back to your patch: why is there a CRLF here in the first place?
> Because on Windows, we check out the whole repo with CRLF conversion,
> except for a few known file types listed in .gitattributes. And that
> includes your t/t4120/patch file.
> 
> Coincidentally the style suggestion I made earlier, to just inline it in
> the t4120 script itself, makes the problem go away. Because we check out
> those scripts with bare line feeds, per .gitattributes, the file we
> create will also have regular line feeds.
> 
> So I would suggest doing that as a workaround. It might be worth
> addressing the CRLF header parsing problem above, too, but I think that
> should be a separate topic.

In case we want to pursue the CRLF thing further, you can demonstrate it
on Linux easily with:

  {
    printf 'diff --git a/file b/file\r\n'
    printf 'old mode 100644'
    printf 'new mode 100755'
  } >patch
  git apply patch

I was surprised that we wouldn't hit this case _somewhere_ in the test
suite already, and indeed we do. Even with a separate patch file, like
you have! But the tests pass due to 614f4f0f35 (Fix the remaining tests
that failed with core.autocrlf=true, 2017-05-09), which explicitly adds
.gitattributes for "t/t4101/*", etc.

So that's another workaround for your patch: we could mark the directory
with .gitattributes in the same way. I still prefer inlining the patch
in the script for style reasons, though.

-Peff
