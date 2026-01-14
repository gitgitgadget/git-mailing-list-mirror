Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64331299943
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412621; cv=none; b=iTy6KLOKrweTi8qGeJbSssajl3urCe6wwPWtkPz3YhvUgvMbxLgtpPtWNaPD1kcXD9sjccpU+b5Y43R/2xiuZGkRR6UXzFRvT9NuqPek5b4w9O50H48L3OfA26Yn4DVDOtC6rj0ozyXnKE22yZzu2BWs91Hga/vqkVsEDxGbxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412621; c=relaxed/simple;
	bh=o3dawfP85ZPvnx0ktHzUFrcS57f+sbOZtibvh3ZTFY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmi0S5KyXjW1mXxlx3gXJiViRUOsT8G+LMVtTRfXUUnJEW5PeQYkhdscdF7awnSENwK1l/i+sRXpqJ4GJNHEuRbvUj9JDMXkLPW3dJ+Z+h+5DskW9IYsJ+OvN1vgnF4v6A4fH41KCkHxeeMZyLSdxZs5ra5dU49vYwkODW4NQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KUkkOdp6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KUkkOdp6"
Received: (qmail 40724 invoked by uid 109); 14 Jan 2026 17:43:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=o3dawfP85ZPvnx0ktHzUFrcS57f+sbOZtibvh3ZTFY0=; b=KUkkOdp6QcnMohQyRl0WRnSJptO0hOOVWwPckX+RDnbIEztPjVKTIgUuIHGCPIYPmBVcPudFhjengK/kjRTrGEvwscDG4BsI3LtWzwTJwr279ZLEwlNVXS9OMqNPNwNYMLTyHdZqIr0JZPp5SN98qYIfS5QqhPm+oE7zVO4hEcGwU7k7KzgY7mnWHcz4C/P/ygsLSHjtbQ0C40k1v4t/z37xgg7+JbtduiVV8raWMd3n9MR8ZaTl9LNhKzf9DbP/cWbakwq1pMktBUTggEEj8B/jmuXe/o2Quq2YabqH9qzVMjM4OkhhYp0sba0fYco9ZqMTsS4xbrIPq0H4KqMm1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 17:43:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67308 invoked by uid 111); 14 Jan 2026 17:43:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 12:43:40 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 12:43:38 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 2/6] refs: attach rejection details to updates
Message-ID: <20260114174338.GE885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-2-f5f8b173c501@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-2-f5f8b173c501@gmail.com>

On Wed, Jan 14, 2026 at 04:40:43PM +0100, Karthik Nayak wrote:

> @@ -1262,6 +1264,8 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
>  			   transaction->updates[update_idx]->refname, 0);
>  
>  	transaction->updates[update_idx]->rejection_err = err;
> +	if (details)
> +		transaction->updates[update_idx]->rejection_details = xstrdup(details);

I guess this could use xstrdup_or_null(), but probably doesn't matter
much either way. I do wonder if anybody actually passes a NULL value. I
think in my hacky patch there were some spots that did, but here you're
always setting the "err" buf (which is good, as we'll always have
details then).

> @@ -2657,30 +2661,35 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  			if (!initial_transaction &&
>  			    (strset_contains(&conflicting_dirnames, dirname.buf) ||
>  			     !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
> -						       &type, &ignore_errno))) {
> +						&type, &ignore_errno))) {
> +
> +				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> +					    dirname.buf, refname);
> +
>  				if (transaction && ref_transaction_maybe_set_rejected(
>  					    transaction, *update_idx,
> -					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
> +					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
>  					strset_remove(&dirnames, dirname.buf);
>  					strset_add(&conflicting_dirnames, dirname.buf);
> -					continue;
> +					strbuf_reset(err);
> +					goto next;
>  				}
>  
> -				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> -					    dirname.buf, refname);
>  				goto cleanup;
>  			}

OK, so this is a case where we re-ordered the "err" handling so that
it's available for the non-atomic case. Makes sense. We end up
formatting into err, then copying it via xstrdup(), and then resetting
the buffer, which is an extra copy. I think you could probably get
around that by passing in the strbuf to set_rejected() and using
strbuf_detach() to pull the value out. It's probably not worth worrying
about optimizing out the copy for an error path like this, but I wonder
if it would be more ergonomic (the caller does not have to remember to
strbuf_reset() then).

I notice that you "goto next" now instead of "continue". So I was
curious what happens in "next" now, but...

> +next:;
>  	}

...the answer is nothing. ;) I guess maybe you were going to
strbuf_reset() down here at one point? If the 'next' label remains
empty, I think I'd prefer to keep these as 'continue'. But maybe you use
it later in the series. I'll read on.

> [...]

The rest of the conversions all looked sensible to me. And you fixed my
memory leak, which is good. ;)

-Peff
