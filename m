Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899884FA6
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712092; cv=none; b=uIYyRPN2xvFY7JVqYp3necIr6HsT1UcfmF89DDlLJ51dAed4NoWqk2l/C4MriPRG+fdwekAjSuhjYH2EsWvMojgX+P9QF43GSexKccP49JTL0JbKSvAhT5AUCE+szOvzk+KpIPPnUo0b4ICUU7BySDJ8MOdx9i3VfKwZ+nljITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712092; c=relaxed/simple;
	bh=gIezocfGnHO5abFS7t72zx3l0s06nDeVF6dMMxxv7sg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qONjADWxRGOGXGe14F7lvY/328iP18dc2IgAIKRDX3ENBkRpIzshppNGNpC7E6+j2A2I+T/3r95Jfq2fnGgTNlI5cqSvLRWHct+U74VRtYTetI8GW+TREAc97A6vhpRXOoFYtuCagdW5vASvD2N28ItGTSoPyGCXY45mFpdnI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G4xV3bEt; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G4xV3bEt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B23321E0139;
	Fri, 23 Feb 2024 13:14:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gIezocfGnHO5abFS7t72zx3l0s06nDeVF6dMMx
	xv7sg=; b=G4xV3bEtgfy5mJCfNM5mdef/sQQ7dd035eXk/mTMhch5gUt8xT8nLM
	q4dgwe3Iqi/g02TXOpc/sgEI4ehf8nyIC/zB+9BHVJfo0MyQQxN4+/1ssYqLcyDs
	Q4JDaH/rCrDGZpULRhcTS/2UEPK2n93hmF8bl4SPRS9sEFtkM/1c4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AA8341E0138;
	Fri, 23 Feb 2024 13:14:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D3EC1E0137;
	Fri, 23 Feb 2024 13:14:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 14/16] fsmonitor: support case-insensitive events
In-Reply-To: <288f3f4e54e98a68d72e97125b1520605c138c3c.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:18 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<288f3f4e54e98a68d72e97125b1520605c138c3c.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 10:14:48 -0800
Message-ID: <xmqqjzmvt5d3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6E77D442-D277-11EE-8E0F-25B3960A682E-77302942!pb-smtp2.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * Use the name-hash to do a case-insensitive cache-entry lookup with
> + * the pathname and invalidate the cache-entry.
> + *
> + * Returns the number of cache-entries that we invalidated.
> + */
> +static size_t handle_using_name_hash_icase(
> +	struct index_state *istate, const char *name)
> +{
> +	struct cache_entry *ce = NULL;
> +
> +	ce = index_file_exists(istate, name, strlen(name), 1);
> +	if (!ce)
> +		return 0;
> +
> +	/*
> +	 * A case-insensitive search in the name-hash using the
> +	 * observed pathname found a cache-entry, so the observed path
> +	 * is case-incorrect.  Invalidate the cache-entry and use the
> +	 * correct spelling from the cache-entry to invalidate the
> +	 * untracked-cache.  Since we now have sparse-directories in
> +	 * the index, the observed pathname may represent a regular
> +	 * file or a sparse-index directory.
> +	 *
> +	 * Note that we should not have seen FSEvents for a
> +	 * sparse-index directory, but we handle it just in case.
> +	 *
> +	 * Either way, we know that there are not any cache-entries for
> +	 * children inside the cone of the directory, so we don't need to
> +	 * do the usual scan.
> +	 */
> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
> +			 name, ce->name);
> +
> +	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
> +	ce->ce_flags &= ~CE_FSMONITOR_VALID;
> +	return 1;
> +}

You first ask the name-hash to turn the incoming "name" into the
case variant that we know about, i.e. ce->name, and use that to
access the untracked cache.  Clever and makes sense.  But if we have
ce->name, doesn't it mean the name is tracked?  Do we find anything
useful to do in the untracked cache invalidation codepath in that
case?

An FSmonitor event with case-incorrect pathname for a directory may
not be this trivial, I presume, and I expect that is what the
remainder of this patch is about.

> +
> +/*
> + * Use the dir-name-hash to find the correct-case spelling of the
> + * directory.  Use the canonical spelling to invalidate all of the
> + * cache-entries within the matching cone.
> + *
> + * Returns the number of cache-entries that we invalidated.
> + */
> +static size_t handle_using_dir_name_hash_icase(
> +	struct index_state *istate, const char *name)

It is a bit unfortunate that here on the name-hash side we contrast
the two helper function variants as "dir-name" vs "name", while the
original handle_path side use "without_slash" vs "with_slash".

If I understand correctly, it is not like there are two distinct
hashes, "name-hash" vs "dir-name-hash".  Both of these helpers use
the same "name-hash" mechanism, and this function differs from the
previous one in that it is about a directory, which is why it has
"dir" in its name.  I wonder if we renamed the other one with
"nondir" in its name, and the other without_slash and with_slash
pair to match, e.g., handle_nondir_path() vs handle_dir_path(), or
something like that, the resulting names for these four functions
become easier to contrast and understand?

> +{
> +	struct strbuf canonical_path = STRBUF_INIT;
> +	int pos;
> +	size_t len = strlen(name);
> +	size_t nr_in_cone;
> +
> +	if (name[len - 1] == '/')
> +		len--;
> +
> +	if (!index_dir_find(istate, name, len, &canonical_path))
> +		return 0; /* name is untracked */
> +
> +	if (!memcmp(name, canonical_path.buf, canonical_path.len)) {
> +		strbuf_release(&canonical_path);
> +		/*
> +		 * NEEDSWORK: Our caller already tried an exact match
> +		 * and failed to find one.  They called us to do an
> +		 * ICASE match, so we should never get an exact match,
> +		 * so we could promote this to a BUG() here if we
> +		 * wanted to.  It doesn't hurt anything to just return
> +		 * 0 and go on becaus we should never get here.  Or we
> +		 * could just get rid of the memcmp() and this "if"
> +		 * clause completely.
> +		 */
> +		return 0; /* should not happen */
> +	}

"becaus" -> "because".

If we should never get here, having BUG("we should never get here")
would not hurt anything, either.  On the other hand, silently
returning 0 will hide the bug under the carpet, and I am not sure it
is fair to call it "doesn't hurt anything".

> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
> +			 name, canonical_path.buf);
> +
> +	/*
> +	 * The dir-name-hash only tells us the corrected spelling of
> +	 * the prefix.  We have to use this canonical path to do a
> +	 * lookup in the cache-entry array so that we repeat the
> +	 * original search using the case-corrected spelling.
> +	 */
> +	strbuf_addch(&canonical_path, '/');
> +	pos = index_name_pos(istate, canonical_path.buf,
> +			     canonical_path.len);
> +	nr_in_cone = handle_path_with_trailing_slash(
> +		istate, canonical_path.buf, pos);
> +	strbuf_release(&canonical_path);
> +	return nr_in_cone;
> +}

Nice.  Do we need to give this corrected name to help untracked
cache invalidation from the caller that called us?

> @@ -319,6 +416,19 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>  	else
>  		nr_in_cone = handle_path_without_trailing_slash(istate, name, pos);
>  
> +	/*
> +	 * If we did not find an exact match for this pathname or any
> +	 * cache-entries with this directory prefix and we're on a
> +	 * case-insensitive file system, try again using the name-hash
> +	 * and dir-name-hash.
> +	 */
> +	if (!nr_in_cone && ignore_case) {
> +		nr_in_cone = handle_using_name_hash_icase(istate, name);
> +		if (!nr_in_cone)
> +			nr_in_cone = handle_using_dir_name_hash_icase(
> +				istate, name);
> +	}

It might be interesting to learn how often we go through these
"fallback" code paths by tracing.  Maybe it will become too noisy?
I dunno.

>  	if (nr_in_cone)
>  		trace_printf_key(&trace_fsmonitor,
>  				 "fsmonitor_refresh_callback CNT: %d",
