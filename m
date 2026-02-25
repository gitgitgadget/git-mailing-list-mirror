Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE19338936
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027791; cv=none; b=EQjRwJcRXHqHVLomkIvE+cpM5qVZVCNdk4CjaeRoME0Aibu6B8ZZRRmFxss/imvK4Ff0xE+ybvUQ7irM4xCz82rQEBj1b4JYYf5PmXtL7W10dKWdu0n/uAJE+pJ1KZmbgIrv+CswvQfgdiIN/xA8n5wD4QmmjPjJwWDw6AGmulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027791; c=relaxed/simple;
	bh=85xHBHlumaHMWVts4jzV/Eq584+aulysvA6Xtx1gr38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3N1wdXGkoYN2Rtl+kFiga2+lWjUQYBL7SdM7EJRdlFl5tX6GzMDUbVHt/BkNZm+/bGd3s/wV4sPCkHKXGt22EH2YEJ9Wn2NCTqSuiGsYbFqAQG1NCLgTdod31lAK03CD41W0/0V6M1Kc59Fon3QIjx9TPXLNDX4TrzOwxKGSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KvutkC/R; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KvutkC/R"
Received: (qmail 67026 invoked by uid 109); 25 Feb 2026 13:56:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=85xHBHlumaHMWVts4jzV/Eq584+aulysvA6Xtx1gr38=; b=KvutkC/RtDvRzoaplAxQGU3vQ6dnek/XKH6FeOF6buZtCuuTXASs1hADo34ogQCn4yhR8FXYojvDkwAHy7Ljtf1UcU/G90tzu/DMTDTpZmCVyc8QhCyAfU8uvupuq/D+j9flEybWUlrrAPE8GXTUPVQgMEoiaMjLQ+ZSyGulhXs1bphvYYDLN4N1J8OMSUenHCnlTQyAwX9pow0O7Th3snPyruwfEMve8ruh75SiDYNsYVNn8AptnjPyjcpcd4u33tZ0erYqDcYJy2+ZhkQVRNZjz9W5l3XUILiAva1GYwLkVfpkFV0GJfUzdQhwInlfMj6hcLAQSiw+LEblSei4lw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Feb 2026 13:56:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 200288 invoked by uid 111); 25 Feb 2026 13:56:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Feb 2026 08:56:29 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Feb 2026 08:56:28 -0500
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] format-patch: add ability to use alt cover format
Message-ID: <20260225135628.GD2139176@coredump.intra.peff.net>
References: <20260224040400.751247-1-mroik@delayed.space>
 <cover.1771925291.git.mroik@delayed.space>
 <66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>

On Tue, Feb 24, 2026 at 10:29:01AM +0100, Mirko Faina wrote:

> +static void generate_commit_list_cover(FILE *cover_file,const char *format,
> +				       struct commit **list, int n)
> +{
> +	struct strbuf commit_line = STRBUF_INIT;
> +	struct pretty_print_context ctx = {0};
> +
> +	strbuf_init(&commit_line, 0);
> +	for (int i = n - 1; i >= 0; i--) {
> +		strbuf_addf(&commit_line, "[%0*d/%d] ", decimal_width(n), n - i, n);
> +		repo_format_commit_message(the_repository, list[i], format, &commit_line, &ctx);
> +		fprintf(cover_file, "%s\n", commit_line.buf);
> +		strbuf_reset(&commit_line);
> +	}

When this topic came up initially I imagined that the user would be able
to tweak the "[1/5]" part of the string, too. It would take a little
extra work, though:

  - introduce new placeholders like %(count) and %(total) or similar

  - introduce count/total fields to pretty_print_context

  - probably when total is unset, refuse to interpret %(count) and
    %(total) at all (so they do not have meaning for regular "git log
    --format" calls.

  - not sure how to handle the width field for the count. Would it have
    an option to default to the width of the total field?

But I'm not sure if it is worth all of that effort. It is more flexible,
but would people really want to customize how it is shown (after all, I
don't think we allow configuring it in the patch subjects themselves,
though we do allow suppressing the "[PATCH]" part completely).


I had a few other comments while reading the patch, but Junio already
made them for me. :) I do like the direction this is heading.

-Peff
