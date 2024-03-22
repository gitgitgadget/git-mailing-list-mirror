Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2765D752
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126253; cv=none; b=d1SDtkpmAWEX8xNGHXU59B84QXvSKB7u19zYshItnMMHo4POlgaswbFtPHN0lYDGjrsS5wIcYAPvr7EBhY+xDo2C/8o0Ot/Pb4ZZlI9tEig7cVOCKh6av1L5OYzI2dqFz6PAdBCOPxJ4DDjCt5GkEpLRUzR8kvQHZVFZGwd8Pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126253; c=relaxed/simple;
	bh=LxfTboy9ezd4JauvQiuNxGwUGKfCM7gWtun/M3lyZGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aabw4FQdoFYjbdyatc8WKpxX46cNFfpAtbwqzUnHrgX9eTrYQLPitEPzIqCQ+sHznzUYtn/BTUwm0zzlTXj321k+05UeJBU9qbCk08HutJAxIcaA7SUGgmKXAKLgwqng54Kr3nzX/CdruAL0IGFpXxnGEA+SZ63SoVLaWSp6ZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g7BN6FL2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g7BN6FL2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 60C591F4EA2;
	Fri, 22 Mar 2024 12:50:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LxfTboy9ezd4JauvQiuNxGwUGKfCM7gWtun/M3
	lyZGk=; b=g7BN6FL2oe5mpSB7kat7DqEj3Up8zYTwg8TwLIs96nG0bL5HW6h7e/
	cZy6s8dHmKyfCF5yVl/o9N9lUmBD5s6dQB1h0E+gzn5txgw4qOR00aZ8JPZqkmEI
	nVSGzPE+5aMBsM4RHJ8Zy6TGpGc32ANdw1WTAC4MzfOBfCJwIzdF4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 59A091F4EA1;
	Fri, 22 Mar 2024 12:50:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B69D71F4EA0;
	Fri, 22 Mar 2024 12:50:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org
Subject: Re: [PATCH 7/6] format-patch: fix leak of empty header string
In-Reply-To: <20240322095951.GA529578@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 22 Mar 2024 05:59:51 -0400")
References: <cover.1709841147.git.code@khaugsbakk.name>
	<cover.1710873210.git.code@khaugsbakk.name>
	<9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
	<20240319212940.GE1159535@coredump.intra.peff.net>
	<20240320002555.GB903718@coredump.intra.peff.net>
	<20240322095951.GA529578@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 09:50:48 -0700
Message-ID: <xmqqr0g21a8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 565648B6-E86C-11EE-91D6-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, Mar 19, 2024 at 08:25:55PM -0400, Jeff King wrote:
>
>>   [1/6]: shortlog: stop setting pp.print_email_subject
>>   [2/6]: pretty: split oneline and email subject printing
>>   [3/6]: pretty: drop print_email_subject flag
>>   [4/6]: log: do not set up extra_headers for non-email formats
>>   [5/6]: format-patch: return an allocated string from log_write_email_headers()
>>   [6/6]: format-patch: simplify after-subject MIME header handling
>
> These patches introduce a small leak into format-patch. I didn't notice
> before because the "leaks" CI jobs were broken due to sanitizer problems
> in the base image (which now seem fixed?).
>
> Here's a fix that can go on top of jk/pretty-subject-cleanup. That topic
> is not in 'next' yet, so I could also re-roll. The issue was subtle
> enough that a separate commit is not such a bad thing, but I'm happy to
> squash it in if we'd prefer.

Indeed it is subtle and I like the corner case described separately
like this one does.  Very much appreciated.

Thanks.

> -- >8 --
> Subject: [PATCH] format-patch: fix leak of empty header string
>
> The log_write_email_headers() function recently learned to return the
> "extra_headers_p" variable to the caller as an allocated string. We
> start by copying rev_info.extra_headers into a strbuf, and then detach
> the strbuf at the end of the function. If there are no extra headers, we
> leave the strbuf empty. Likewise, if there are no headers to return, we
> pass back NULL.
>
> This misses a corner case which can cause a leak. The "do we have any
> headers to copy" check is done by looking for a NULL opt->extra_headers.
> But the "do we have a non-empty string to return" check is done by
> checking the length of the strbuf. That means if opt->extra_headers is
> the empty string, we'll "copy" it into the strbuf, triggering an
> allocation, but then leak the buffer when we return NULL from the
> function.
>
> We can solve this in one of two ways:
>
>   1. Rather than checking headers->len at the end, we could check
>      headers->alloc to see if we allocated anything. That retains the
>      original behavior before the recent change, where an empty
>      extra_headers string is "passed through" to the caller. In practice
>      this doesn't matter, though (the code which eventually looks at the
>      result treats NULL or the empty string the same).
>
>   2. Only bother copying a non-empty string into the strbuf. This has
>      the added bonus of avoiding a pointless allocation.
>
>      Arguably strbuf_addstr() could do this optimization itself, though
>      it may be slightly dangerous to do so (some existing callers may
>      not get a fresh allocation when they expect to). In theory callers
>      are all supposed to use strbuf_detach() in such a case, but there's
>      no guarantee that this is the case.
>
> This patch uses option 2. Without it, building with SANITIZE=leak shows
> many errors in t4021 and elsewhere.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  log-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index eb2e841046..59eeaef1f7 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -480,7 +480,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
>  
>  	*need_8bit_cte_p = 0; /* unknown */
>  
> -	if (opt->extra_headers)
> +	if (opt->extra_headers && *opt->extra_headers)
>  		strbuf_addstr(&headers, opt->extra_headers);
>  
>  	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
