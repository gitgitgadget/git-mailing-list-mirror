Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C41A08AF
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213533; cv=none; b=UCpK/rySWhgfzlZmjxuigni1VMII7R8yu4sdKM5sqHpPfwJ4GcE7Libb79vexwpUUcjyRcCwZaY4eqzTmXe0mgBSiM+yZaoaAC3bzzG8V/t4I776VdoX8MaHBholUvhHAwwNRG1ycQWGCJRNGbN6kpVQOyWtpHT5bOCdE0qg/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213533; c=relaxed/simple;
	bh=fYnzmJ9PQM534QpVNH3VkxIw3eVtRPoniAHLVTJbcHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6pNV4me8RyhI2UIzULxzlDVUvJSsTTGDM+W82jFeN+oY6D+G/St+BqP1hMEa3zBGPuWvkK5cCyrOnMAqsnzY6yXPyWqSLTs9Lz6TEY2kSPdtOCq7Bm3+1Xzh/dk7L92w1waJyFd272uPyCYQmL0GO+WIch6lC1y92ubT+10xvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ebhF2DKB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ebhF2DKB"
Received: (qmail 1488 invoked by uid 109); 14 Aug 2025 23:18:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fYnzmJ9PQM534QpVNH3VkxIw3eVtRPoniAHLVTJbcHI=; b=ebhF2DKB9ehFSic69I7XQ/wt9uOE6c99KwbGJEpuOJdkC20F3LbkdlULC7Vic0ymjynD2oYSS7QH19lqMVWvnyX4sWfB4HeNAaFVeQAkhjfcfw663oXvG6Po0elbyk8o5EdVLPTlTb2K6w2bPLckn7it9WNBnDj8/KWL4u3P6tiMAuKQBEm+jgJX3j5lfn77TIueCgeUKefrv9RpGUkiLwJWdjVRZRitdAQ13uigIAzb2ULhk096X6nCy91S5ZVEu1NkqQ5yPBPrTOT/ASka5qU1aBg/g4d5lprnDa+n5nb7U4tR/MEDO5/ktJ+3Aa/NJPHrllzLIqXy7+pSGENOWg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Aug 2025 23:18:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9714 invoked by uid 111); 14 Aug 2025 23:18:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Aug 2025 19:18:53 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Aug 2025 19:18:49 -0400
From: Jeff King <peff@peff.net>
To: Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Greg Hurrell <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH v2] git-jump: make `diff` work with filenames containing
 spaces
Message-ID: <20250814231849.GB2937@coredump.intra.peff.net>
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
 <pull.1950.v2.git.1754913323810.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1950.v2.git.1754913323810.gitgitgadget@gmail.com>

On Mon, Aug 11, 2025 at 11:55:23AM +0000, Greg Hurrell via GitGitGadget wrote:

> This commit takes the simple approach of unconditionally stripping any
> trailing tab. Consider the following three examples:
> 
> 1. For file "foo", Git will emit "foo".
> 2. For file "foo bar", Git will emit "foo bar\t".
> 3. For file "foo\t", Git will emit "\"foo\t\"".
> 4. For file "foo bar\t", Git will emit "\"foo bar\t\"".
> 
> Before this commit, `git-jump` correctly handled only case "1".
> 
> After this commit, `git-jump` correctly handles cases "1" and "2". In
> reality, these are the only cases people are going to run into with any
> regularity, and the other two are rare edge cases, which probably aren't
> worth the effort to support unless somebody actually complains about
> them.

Thanks for laying out these cases. I think this list shows that we are
making things strictly better, but just stopping short of handling
unquoting. So it seems like a no-brainer to take this patch (though I
think even with the description in v1, in which we thought we might
regress "foo\t", I think it would still have been worth it).

And I think this is a good stopping point. Handling unquoting would be
tricky for a case that is unlikely to come up in practice. And I'm not
even sure we could make it foolproof, anyway. We're feeding this to the
editor's quickfix parser, so I'm not sure how we'd represent something
like a newline. We'd have to agree on the quoting scheme with the
editor, and from my (admittedly brief) research, there is not even a
mechanism in vim for that.

> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 3f696759617..8d1d5d79a69 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -44,7 +44,7 @@ open_editor() {
>  mode_diff() {
>  	git diff --no-prefix --relative "$@" |
>  	perl -ne '
> -	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
> +	if (m{^\+\+\+ (.*?)\t?$}) { $file = $1 eq "/dev/null" ? undef : $1; next }
>  	defined($file) or next;
>  	if (m/^@@ .*?\+(\d+)/) { $line = $1; next }
>  	defined($line) or next;

The patch itself looks good. Nice and simple, and should not incur any
extra cost or regress any other cases.

-Peff
