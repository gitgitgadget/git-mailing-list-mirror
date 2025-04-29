Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CCA215764
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969599; cv=none; b=OJijoX104hiCfskRZ+fnkfVHaV2/9u9s62zHFWiRRbpoygySBhsOqHO+1mVbjFj4ta8A01BOhZ7qlXGph0uQll3pWDVB3SVzq1f7IuLJfdvHjSh8xIt/IZGggxUYJcb6FciH1ucgu+cIWBNgWsI2biigdj8B9czKF+RWY9Tr5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969599; c=relaxed/simple;
	bh=xdjkkSNYW5ipg7jlm58wW7L97BUGlZAjNNvkDyNbbjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxDlFJeOvoO9uyd0JtPlV61OhaAiVolPw4mb+zR9tXOP6V5btBxcq4s3WYz07wSf8n4tRtXWRdkQtObQpHTG5vdQfh3B2mI1bygIk6yArtbzqiTxx5LJxHMnrYDiyL6iaGkXYMDWhxQUs/7bMZS6zJJ+Btp1N0FQHHn5YKRqJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V3FG0Fkw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V3FG0Fkw"
Received: (qmail 8924 invoked by uid 109); 29 Apr 2025 23:33:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xdjkkSNYW5ipg7jlm58wW7L97BUGlZAjNNvkDyNbbjA=; b=V3FG0Fkwfa01UKMlo64Jb84sEYYBJZQ202KHLROjFgcflLsYUcGfA/gtwRodNgyWpcrmKN/I1sWPdZh9lmZRu3yVAM1eEMG74aDRG8vtzWjD5W868dMLb8yKl+e/hADdkmh6ZuDLdnDLOYrHdv4T7c4RM1vllg20zwRqpiTbxqFNrQAlny6Rov78/AtK8uYk3tWpnoS9SpZrYqmWV/8/4e6qZsjF0xGRdxcQK8H/ObaLURbmJBPMTamBFYw9wvlq5N/ACb/7EbovKM2fMtE9SMq6eaRzQOERXrmKvelp2ASZPcjj/OOhyh+Srb6RyzyCGCt8d6UIPIldXj0c92t+LQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Apr 2025 23:33:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14781 invoked by uid 111); 29 Apr 2025 23:33:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Apr 2025 19:33:18 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Apr 2025 19:33:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] diff: check range before dereferencing an array
 element
Message-ID: <20250429233314.GA594987@coredump.intra.peff.net>
References: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
 <pull.1887.v3.git.1745926679028.gitgitgadget@gmail.com>
 <20250429215847.GB36727@coredump.intra.peff.net>
 <xmqqldri4ms0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldri4ms0.fsf@gitster.g>

On Tue, Apr 29, 2025 at 03:37:35PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> @@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
> >>  
> >>  	/* skip any \v \f \r at start of indentation */
> >>  	while (s[off] == '\f' || s[off] == '\v' ||
> >> -	       (s[off] == '\r' && off < len - 1))
> >> +	       (off < len - 1 && s[off] == '\r'))
> >>  		off++;
> >
> > ...since the same pattern exists for the other s[off] checks, is it
> > worth future-proofing this like:
> >
> >   while (off < len - 1 &&
> >          (s[off] == '\f' || s[off] == '\v' || s[off] == '\r')
> >
> > ?
> 
> But doesn't it change the semantics?
> 
> s[off] == '\f', even if off is at the end of the string, i.e. (off
> == len - 1), must trigger the off++ increment.
> 
> On the other hand, CR that is the part of CRLF at the end of line is
> *not* treated like other funny whitespace control characters.  This
> "is off not at the end of line, if so check CR" comparison is about
> that.

Ah, you're right. I was reading the offset check as "are we past the end
of string" (guided by CodeQL's complaint), and if that were the case the
logic would apply equally to all values we are checking.

But that is not what is going on at all. The offset check is for "len -
1", and so is "do not do this one CR match for the final character of
the string". And thus applying it elsewhere is wrong.

And CodeQL's false positive is doubly wrong. We do not even need to say
"the string is NUL-terminated, so it is OK in this case to look past the
end-of-string". The check is not even a string bounds check at all.

-Peff
