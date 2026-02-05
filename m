Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C833EAF8
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277311; cv=none; b=aEez0Q6WxUK+HwBU6SCRNDjQqDFMeg6FsVfVXRT95R2PUeIv7iZoaTwn/++h3IqlfmvIzMie2uSpClOpReuBdiqjWYKRpxZU082bew+KRp9WV8qCaoO/cgc3Rv7Vx8VJFatmzieIRd/LDJHKIxkNQb6p1eQs52YXkKrNsewDico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277311; c=relaxed/simple;
	bh=6njmBYfZIyg4bokTqmBy6HJgyf5ljAF/IgVSHOkR5hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qylY+FXPI/57PZczgEp2QnRtPqYmkJ/yDuINf7q9u6aijfGbSDz7MmbRzal8tdZ1eS5K8lLsOTEr7jU5B5Juq381tW1YHxKc6j3z8fm2wcxxQJ7VuNaizZk9hHeUqIVU+CmpIywGDrlI1QmV7djpR3C/ESocOyLU6OYHAtJjga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eP44Zz80; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eP44Zz80"
Received: (qmail 289881 invoked by uid 109); 5 Feb 2026 07:41:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6njmBYfZIyg4bokTqmBy6HJgyf5ljAF/IgVSHOkR5hQ=; b=eP44Zz80JRCefnarIM3viHBhDJP+m+LysaLVQ/dCkb0At0ZAlEH5FpB99u4LkPidYoN+5jvzds0oXK3dsM4VA31WVOdktb5W4R6UJQC+2uPHQIT/MwT56lOsLcMPMtNooZy5KOlF3Morkg9UGWW8aG6eMclTagKVVXKFYkugD+ETu3g4AcbBdgLwkCprmDUB7YoDEc5BUTOV3XoxGFq3hdDxHPcOD7f3JJlV6T+iSc7zfsXqnvskhFtCnB2ZtyAAEWG6w3xW/vRNA8fqDXpoeD4EhEhNpP4UMQfzoeRlnoXEH/okHltwrdkc4vg7Nd15qdemkcm7mS+nfXaTLjD4/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Feb 2026 07:41:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 572878 invoked by uid 111); 5 Feb 2026 07:41:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Feb 2026 02:41:44 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Feb 2026 02:41:39 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] global: constify some pointers that are not written to
Message-ID: <20260205074139.GA1019015@coredump.intra.peff.net>
References: <342b01acd42f1fcaa3abefa38dc589e12ccb1134.1770261829.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <342b01acd42f1fcaa3abefa38dc589e12ccb1134.1770261829.git.collin.funk1@gmail.com>

On Wed, Feb 04, 2026 at 07:24:19PM -0800, Collin Funk wrote:

> This patch fixes the more obvious ones by making them const when we do
> not write to the returned pointer.

Thanks, this looks like a good start. All of the changes look correct to
me (and can be confirmed with the compiler). I also cross-checked them
against my own earlier hacky pass. The only difference was in this hunk:

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 47222bf31b..87fb6605fb 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -398,7 +398,7 @@ static void parse_ssh_output(struct signature_check *sigc)
>  {
>  	const char *line, *principal, *search;
>  	char *to_free;
> -	char *key = NULL;
> +	const char *key;

You've dropped the NULL initialization here. That's OK to do, as the
NULL is never used (we assign "key" immediately before the first time we
look at it). But it probably makes sense for this patch to change only
one thing. So either leave the dead initialization, or remove it as a
separate patch.

-Peff
