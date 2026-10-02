Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5C36B928
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983717; cv=none; b=D9QDOs0MG5/ZUA9Z6W/GmHw0OK7Uep8Ye/+asX6AunLlKVmDSPjWGiouhviTB1tFk4xJvod00BFqXqUYtrJJxI5by7KPxpKMoEX32o/O1sDvJzCFAOyXLRmgGAo05J36mYOvAcRv7OQVZ4WqodmNLQ3lHg4rjtOREtbHdeSKyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983717; c=relaxed/simple;
	bh=fkO4owjxI61NlSNEnDNn1A2OY5dh+YJgrfVrYbNEYak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKwxeiQjBagD/py1EiCaiOr47HZx2UxUtfp7goDQQjMKjRZ8Vck2CvWQdT4t4lINuuukHrpv+/O2ewXdq3B6mM9Dw6U6V4i25gphuo+pG9d7s8RuArP3a4o7wpK0IegkNIwikk/5bQjZYabv7A6CNrg4DtQDShSHIzrU5cSSLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z60tmSBj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z60tmSBj"
Received: (qmail 16856 invoked by uid 106); 2 Oct 2026 23:28:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fkO4owjxI61NlSNEnDNn1A2OY5dh+YJgrfVrYbNEYak=; b=Z60tmSBjAUgfIDDOzG7qwJc7IuxS5F6d1yD2yKL8oRJqnObq5CKAhU6ZG+BJUgp4vHIpzBWlgRAdp/xGRYXvPWpP6XPz6yjzEVmhsSFIB/SXa3R8FBs092heum+AwU21ZO6FWcX464Oa6OJ97QolOAR6wPWlxIZbaE5+AfAxc5P0C3pw66qSoQ1gJF+Ut1L++yUGJbIQ1Po6UtXaL9ywEPsXMOeUldbp0z+7VgP4p6/tkv/E/SnZ7XtWVeH9AIQB7xiE28yukX2t0LWbt8l32N7kIWC0RV8Fud5ZgAU7VMRq+j4ZZD2uPKKb0z+eCslJUZvMBfhgbWwsir/5MQVzrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 23:28:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 49329 invoked by uid 111); 2 Oct 2026 23:28:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 19:28:37 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 19:28:34 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 6/8] repack: track the preferred pack explicitly in
 MIDX write steps
Message-ID: <20261002232834.GE834759@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <a85dbcd04c7957756848e5f3102744d20b509fc4.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a85dbcd04c7957756848e5f3102744d20b509fc4.1790827875.git.me@ttaylorr.com>

On Wed, Sep 30, 2026 at 11:11:58PM -0500, Taylor Blau wrote:

> A MIDX write step marks preferred packs in its string-list entries and
> chooses the last marked entry when executing the step. That makes the
> choice depend on list order, preventing the list from being sorted for
> membership checks.
> 
> Record the last candidate directly in the step, borrowing its name from
> the write list. This preserves preferred-pack selection while allowing
> the list to be sorted without changing that choice.

This is certainly cleaner, though it looks like the existing code works
by marking item->util and then doing a linear search for it. So wouldn't
that work even after sorting?

> @@ -719,7 +713,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
>  
>  		item = string_list_append(&step.u.write, buf.buf);
>  		if (p->multi_pack_index || i == opts->geometry->pack_nr - 1)
> -			item->util = (void *)1; /* mark as preferred */
> +			step.preferred_pack = item->string;

I am certainly happy to see these gross casts go away, though.

-Peff
