Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF515B0F7
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086562; cv=none; b=GWU4j7xxif3PK12Jvk43y6oTJfHrTicNJ6uPQXIcFXCk5/wlR3ueYGVXMI5eniC0JLW/lx0lqMEZD+bhupqaqDpUVKcJB0lHLYu8WQ85OfJF3DjcW9rd2aMEXtYXrNbD1WfOcJDlmBqg+dWCsE0G7CTDRnuvIlKlDVuZi25XstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086562; c=relaxed/simple;
	bh=cnW+knUlbcf6frH6ges/GQzrIqwI7PtjeWQAdGEL3+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuBccAkKIwCbe6WYa6plBXfC6FccAQ7u9039syRVS8IGcBau2OyYpqrXyKGcbDocEJ3wnzK64bES9Gh0IszYoRQ3GJMNXQylep75tLl+X3uG1QxXzn7vTPyujRRUAHRcb5ZONak4ZSFvlbx50ps+N825BqK/KXzTujE3I19go7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dUrLHKiD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dUrLHKiD"
Received: (qmail 13718 invoked by uid 109); 8 Nov 2024 17:22:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cnW+knUlbcf6frH6ges/GQzrIqwI7PtjeWQAdGEL3+Q=; b=dUrLHKiDrzzd/ynBRBsInT5raGK+acSmWWvcS/TejkKh+xB/8LYYD6NXBBbaInSI8g7nvvBOrjVNjuvNlz9OR0Hn5FSlb6NG0lqkrlvuSSYcEQfY8YzugsDfBdblCZgOGAfIkKtrFRCucwee7eN+rQChx2t1nhBxPuVw5XRDHQypLJINHVQGg9OOXc1mSHUIeG2KZtGi5y8v4pIqG4QXftprRwIsyVCq4XSoBNHAeBrmNdHW4H8mjaxaGduPfPLmQsgt7PZIl0JsUlC6GfC+T627euqk80rNcXpekEYx6D5m+ElBgBMdwaiJuHmnlsv6wR7qYj41MvIrK40ePvUGow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Nov 2024 17:22:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29982 invoked by uid 111); 8 Nov 2024 17:22:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2024 12:22:38 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 8 Nov 2024 12:22:38 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <20241108172238.GB548990@coredump.intra.peff.net>
References: <cover.1730833506.git.me@ttaylorr.com>
 <20241107014737.GB961214@coredump.intra.peff.net>
 <ZywgZt419SfPUVkQ@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZywgZt419SfPUVkQ@tapette.crustytoothpaste.net>

On Thu, Nov 07, 2024 at 02:05:26AM +0000, brian m. carlson wrote:

> >   1. Why do we have "test-tool sha256" at all? Nobody in the test suite
> >      calls it. It feels like the whole test-sha1/sha256/hash split is
> >      overly complicated. A single "test-tool hash" seems like it would
> >      be simpler, and it could take an "--algo" parameter (and an
> >      "--unsafe" one). I guess in the end we end up with the same options
> >      ,but the proliferation of top-level test-tool commands seems ugly
> >      to me (likewise "sha1_is_sha1dc").
> 
> I think we do in `pack_trailer` in `t/lib-pack.sh`, but not in a
> greppable way:
> 
>   # Compute and append pack trailer to "$1"
>   pack_trailer () {
>   	test-tool $(test_oid algo) -b <"$1" >trailer.tmp &&
>   	cat trailer.tmp >>"$1" &&
>   	rm -f trailer.tmp
>   }
> 
> When you posed the question above, I wasn't sure why I added this
> functionality: was it just to test my SHA-256 implementation adequately
> or did it have some actual utility in the testsuite?  However, I knew if
> it didn't appear straightforwardly in `git grep`, any uses would involve
> `test_oid`, and boom, I was right.

Ah, good catch. Or good recall, I suppose. ;)

It feels a tiny bit hacky that we have to specify the algo here. If
there were a plumbing tool to work with the trailing hash of a
csum-file, then naturally it would use the repo's algorithm instead of
having to specify it. And I have run into situations once or twice where
that might have been a useful debugging tool, rather than hacking
together shell tools like dd. But since we have already done that
hacking together in the test suite, and this is the only spot that has
needed it so far, it's probably worth letting sleeping dogs lie.

> I think a single helper with `--algo` and `--unsafe` parameters would
> also be fine and would probably be a little more tidy, as you mention.

Yup.

-Peff
