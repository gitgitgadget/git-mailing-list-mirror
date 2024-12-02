Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55251DF24D
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172677; cv=none; b=SnDYnvQzD6l2tbjWd7sm4rz+xGjZBWZ77PC68rXLZCCBWH7h4sb+K/KJ2EXFlyHSYWp/sI1Vwyorjgx4jBJRdCars0wTWqZzZO3crmRk6+Zxgyd4bMZAuQKbyWS9zTE1+P8AUpFgzsujzQiRux2v56HIvoXHgy9jUF9sANx/CYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172677; c=relaxed/simple;
	bh=Uhyjstcq02GSppQZjR1ju4+17lh6Z1YSdkbn2hzUgjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKiuFIJZEUXdge99PSGHGV/2jyRlr998SIzkmAYe/PpAPZhX8jMqShQCO+x+OLO+1mUqiij24qlnPsP+q3i/SA1/IIYar8hTxxIDNJzvrLRc/oLNm+sb+sT8uxAtWk+j8JBgByTYig2r1tUCLck6oHPc2MmzsZZNcM6NJ9/HkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YcZsVgaD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YcZsVgaD"
Received: (qmail 16681 invoked by uid 109); 2 Dec 2024 20:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Uhyjstcq02GSppQZjR1ju4+17lh6Z1YSdkbn2hzUgjg=; b=YcZsVgaD0eEch5yzkSgjTsMKQow1jSlnE8F8PLTYWCgFpxMMcoDAvHcxj4ACvwxQERqwLbjl0OUTFeR534kbEDJSVkY3F00szClo8U8SsaBMNcjvwpELIUuXsB6/nh3nVKIjPBVnXhbmfr5+7LMbXTbh7sjTfabdt5OXCMgMHzxtoC3Qw33YbzbDu89EtoIy+o/ZBA7O42XF2dYwWV0ESn1gwr+UkL6jUhk/PQfQC+rJl8wZViI1JKC6nLzIMNs8d+tlTNU6XATcUOsp+0tUS5COh4VrQ+XVmc24i0jMRguqK5mk4YjMD3V6yGmxDbk4p0hTjebkpL4wmhnIIKb8GA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Dec 2024 20:51:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26309 invoked by uid 111); 2 Dec 2024 20:51:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2024 15:51:14 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Dec 2024 15:51:14 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git@jowil.de
Subject: Re: [PATCH 2/4] refs: drop strbuf_ prefix from helpers
Message-ID: <20241202205114.GC776185@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202070714.3028549-3-gitster@pobox.com>

On Mon, Dec 02, 2024 at 04:07:12PM +0900, Junio C Hamano wrote:

> The helper functions (strbuf_branchname, strbuf_check_branch_ref,
> and strbuf_check_tag_ref) are about handling branch and tag names,
> and it is a non-essential fact that these functions use strbuf to
> hold these names.  Rename them to make it clarify that these are
> more about "ref".

Sounds good. I wasn't quite sure about the name copy_branchname(), since
it actually expands/interprets the name. But the word "interpret" is
already used for another similar function, repo_interpret_branch_name().

In fact, this function is a very thin wrapper around it, which made me
wonder if it has any value. It looks like the main useful bit is that on
error it will copy the name verbatim.

So I guess it is really more like copy_or_expand_branchname(). I don't
know if that is really adding much, though. Probably just the name
copy_branchname(), coupled with the documentation above the declaration,
will be sufficient.

  As a side note, repo_interpret_branch_name() is in object-file.[ch],
  but probably should also be in refs.[ch], as in your first patch.
  Let's not worry about it for your series, though.

-Peff
