Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40229E0F8
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443374; cv=none; b=spulIEIE0u9MmB5KKsUgn3upMiUxjxQWUJ1+McrSII4svFxQjRJGDVBoYa9SAHzrnOkjWR6dkZogstxjXnzWSiv39tHV8toBKSSUoOcXTkqrfifP84u5XhbX6FGfCAsy1irJXCWI8hMFAEc2NN3JQPTXn9SCoylZ+tQyu/NhgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443374; c=relaxed/simple;
	bh=no7gd7VIxZFuE4YjNf35VXmBswrFUzw4LHgQGDyQdS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXE5zmXPdAhidL1A/Pc9A7f2YPD4ga6UkpW85RllQk/nJ/Nl9QU7lUqwU+rcdcgB+HjZMfsavOjwEH0Q/RJsYHOtXGu9e6sbGgIgBKD+VhkaHCsL1CMO57Pe/XdVd2W6Om/XckUbwIi6tbA0050mWqMF4rg+2PyRdBtk3CD9MW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W6ulk8Fh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W6ulk8Fh"
Received: (qmail 26297 invoked by uid 109); 25 Jul 2025 11:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=no7gd7VIxZFuE4YjNf35VXmBswrFUzw4LHgQGDyQdS0=; b=W6ulk8Fh0wJxnONHPo4nIWMDEynw4O9FvnB/RZtSOAVA65TL04xmPgsIbHOJIJMdmDyYlLDVWKkNDZakFWRYgmK1NOIm5PztOFjjSaINltjXMcGx16S84uIKoemitwDnAGd3T76KCcaTRVa5iKCHVckvekaFDWlhcJtNFfuXCEvZZJLENMRS/MKQd4kVRnk7eJx3BDRDI0VJJzbbJa3z8SMajxz5BT348w3MUpHqIiU+ZE+PgBTboUlafjM5uYVoUSvP+feJwZ0QtmRG4F2cGxZF2qXhrJ+6uHGPIiUD91UY4ViifBNlzJh4T4yhGrDKo7fYN8+bGHcgXKa9jrxRYA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Jul 2025 11:36:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21819 invoked by uid 111); 25 Jul 2025 11:36:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Jul 2025 07:36:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Jul 2025 07:36:10 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 7/8] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Message-ID: <20250725113610.GA3015361@coredump.intra.peff.net>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
 <20250725-pks-reflog-append-v2-7-e4e7cbe3f578@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725-pks-reflog-append-v2-7-e4e7cbe3f578@pks.im>

On Fri, Jul 25, 2025 at 08:58:29AM +0200, Patrick Steinhardt wrote:

> The `REF_HAVE_OLD` flag indicates whether a given ref update has its old
> object ID set. If so, the value of that field is used to verify whether
> the current state of the reference matches this expected state. It is
> thus an important part of mitigating races with a concurrent process
> that updates the same set of references.
> 
> When writing reflogs though we explicitly unset that flag. This is a
> sensible thing to do: the old state of reflog entry updates may not
> necessarily match the current on-disk state of its accompanying ref, but
> it's only intended to signal what old object ID we want to write into
> the new reflog entry. For example when migrating refs we end up writing
> many reflog entries for a single reference, and most likely those reflog
> entries will have many different old object IDs.
> 
> But unsetting this flag also removes a useful signal, namely that the
> caller _did_ provide an old object ID for a given reflog entry. This
> signal will become useful in a subsequent commit, where we add a new
> flag that tells the transaction to use the provided old and new object
> IDs to write a reflog entry. The `REF_HAVE_OLD` flag is then used as a
> signal to verify that the caller really did provide an old object ID.
> 
> Stop unsetting the flag so that we can use it as this described signal
> in a subsequent commit. Skip checking the old object ID for log-only
> updates so that we don't expect it to match the current on-disk state.

I like this direction, but I happened to be working in this area
yesterday[1] and noticed something interesting. You're effectively
replacing this removal of the HAVE_OLD flag when split a symref update:

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bf6f89b1d19..8b42fe18901 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2493,7 +2493,6 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
>  	 * done when new_update is processed.
>  	 */
>  	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
> -	update->flags &= ~REF_HAVE_OLD;
>  
>  	return 0;
>  }

and then later we get the same logic by checking for LOG_ONLY:

> @@ -2508,8 +2507,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
>  						struct object_id *oid,
>  						struct strbuf *err)
>  {
> -	if (!(update->flags & REF_HAVE_OLD) ||
> -		   oideq(oid, &update->old_oid))
> +	if (update->flags & REF_LOG_ONLY ||
> +	    !(update->flags & REF_HAVE_OLD) ||
> +	    oideq(oid, &update->old_oid))
>  		return 0;
>  
>  	if (is_null_oid(&update->old_oid)) {

Which make sense to me. But the weird thing I noticed is that when we do
something similar for split_head_update(), we don't strip REF_HAVE_OLD!

(For those not familiar with that function, it notices when we are
updating refs/heads/foo that is pointed-to by HEAD, and then adds an
extra HEAD reflog update to the transaction).

So as I understand it, right now we are doing an extra check_old_oid()
on that log-only HEAD update, and after your patch we would stop doing
so.

Which I _think_ is the right thing to do, but it made me wonder if the
transaction were ever non-atomic. That is, could we split off a log-only
update that succeeds, even though the old-oid check for the actual
ref fails?

Historically, I'd guess the answer is mostly "no", because the point of
ref transactions is to be all-or-nothing, and to do the locking and
old-oid checking before writing out any updates. But I also think I saw
some discussion of non-atomic transactions recently. I didn't really
follow it, but is this a potential problem?

-Peff

[1] If you are wondering what work: it is the fact that at least with
    the files backend, we will happily overwrite a dangling symref even
    when the caller asked us to make sure this is a creation event. That
    is easy to fix, but I was surprised that some HEAD updates failed
    after doing so. The problem is that the reflog update for HEAD did
    not clear the HAVE_OLD flag, and my solution was to do so (just like
    split_symref_update() does). But as your topic here shows, that will
    probably result in broken reflogs. And we should be checking for
    LOG_ONLY in check_old_oid, as you're doing here (which would also
    fix my problem).

    But that also makes me wonder: should ref_update_check_old_target()
    also be checking LOG_ONLY now in your patch? I guess not, as it does
    not use HAVE_OLD at all (that is just about the oid). We get the
    equivalent behavior in the split-off log-only transaction item
    because we just do not set "old_target" in the split-off item.
