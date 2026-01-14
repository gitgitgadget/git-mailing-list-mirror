Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01519C540
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413361; cv=none; b=PZ4m+s3z/U8NV+ssUDgnFb9x1XasoIW1NlxNR33jiqVKmg6CiukATAOrQQs3Sxxr6w2gq851TuUb36qoGc39T7PKam2qZgaIi09iMsomIqLRo85gaJ4rLEZZ4PgeMElkUy7no1RPd8IcbYUKPmJB893V1pVRkhlWQgqYmnO0tAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413361; c=relaxed/simple;
	bh=E7XwgFx3WFitLbYstNhdquKxf3zaMT5blbpFgDzOG/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKDyK+G1O3Lr5piqwO/+69jwt2pjxJ6EXMYRHmKoAsf3x+PF6sdl6MlJPlQBUPVCslePaGLcKh+x5DYie4hPo/Yip6Br9RrvEezab+ECeVcTIvW5p5QjFewCDyOsz/6LFLXXgzQb8uKZF5hOmJ/cWIXZ6pa06vvmyVVNL7o4KPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e2RBGHt/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e2RBGHt/"
Received: (qmail 40821 invoked by uid 109); 14 Jan 2026 17:55:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=E7XwgFx3WFitLbYstNhdquKxf3zaMT5blbpFgDzOG/c=; b=e2RBGHt/6mzjUj1+KhpRht2KWQBmgHsj4phS4mPFnlh4Kj3wPVmNf+rZ27SSW7L4UhmSwf04zZBoYR/Yq59/iEHaskuWHSyPzGO3QFVtpxZjKMGaDp6Dfaq8yHa3n/ewfwHsd/jmcTtviTIW6zmDdUobmxdspgZf8/qYiFN1WaVM9U7zSlpK36BPTRHDMhYpOBQu0hEl0JFvhd13yVI+hXWCRGCzWFCdLEpT5EXLD1j/6j1ylbFRrFpoyTPXmQ5VjtpwOsBr/QEJtIjw9x61h2RtRNQ18Y+8XwhFn/qtPo+jNwbB3O5VU4+2b9jFanh6XyPrLzIL5dVvHIAwE1naZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 17:55:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67502 invoked by uid 111); 14 Jan 2026 17:55:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 12:55:59 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 12:55:58 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	newren@gmail.com
Subject: Re: [PATCH 4/6] update-ref: utilize rejected error details if
 available
Message-ID: <20260114175558.GG885771@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-4-f5f8b173c501@gmail.com>
 <xmqqpl7cf6kf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpl7cf6kf.fsf@gitster.g>

On Wed, Jan 14, 2026 at 09:27:28AM -0800, Junio C Hamano wrote:

> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > @@ -573,16 +573,18 @@ static void print_rejected_refs(const char *refname,
> >  				const char *old_target,
> >  				const char *new_target,
> >  				enum ref_transaction_error err,
> > -				const char *details UNUSED,
> > +				const char *details,
> >  				void *cb_data UNUSED)
> >  {
> >  	struct strbuf sb = STRBUF_INIT;
> > -	const char *reason = ref_transaction_error_msg(err);
> >  
> > -	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
> > -		    new_oid ? oid_to_hex(new_oid) : new_target,
> > -		    old_oid ? oid_to_hex(old_oid) : old_target,
> > -		    reason);
> > +	if (details)
> > +		strbuf_addf(&sb, "%s\n", details);
> > +	else
> > +		strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
> > +			    new_oid ? oid_to_hex(new_oid) : new_target,
> > +			    old_oid ? oid_to_hex(old_oid) : old_target,
> > +			    ref_transaction_error_msg(err));
> 
> Could "details" reported from the lower layer be less detailed than
> what we are formulating here, like updating the value of what ref
> from what old object to what new object, or what the err code tells
> the end-user?

I wondered that, too, but also: is this supposed to be machine-readable?
The "rejected ..." output looks like something that could be parsed,
and it seems to be documented in git-update-ref(1).

  Side note: if this is meant to be a stable format, surely there should
  be some coverage in the test suite? There doesn't seem to be.

So should we just be replacing the ref_transaction_error_msg() part? I
_think_ the low-level details will usually be more informative there,
but not necessarily. So possibly we'd even want to show both, though I
suspect just concatenating them would be messy.

Plus the "details" one has a lot of redundant information in it (it
mentions "refname", even though it is already on the "rejected" line).

In the short-term, I wonder if we just want:

  if (details && *details)
	error("%s", details);

That gets us back to the status quo, where the details are at least
available via stderr. And then we can consider how to combine them into
the machine-readable format separately.

-Peff
