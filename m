Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E730AAA9
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192736; cv=none; b=fyWFzPIkCRiBnR4vkhOt4WZCuwKiv2YuD7khbEw4aKthD9B0W3uJf/HqxjoRnFzCQNeOoO2EgNiUGpgWa9IHd7nb50fNlJtE0NM9PGtQiT+1WWOBuOkgy8z6iiO3s5x3BvjXxeIAdAwzcnsy3EUyfXLivti1ktXztVpNcdZODb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192736; c=relaxed/simple;
	bh=GI/DeyMn5rHLw4X8cPRS/mAioFBWV00vhU/wVvlTmWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6j5vr4Lr+0mh8wUxWQpGINOKaOy9Zz8viuErkBZkdUAwuuq4QKAiCDNeGHWeCnjvVe8iwVsvJ/MXQmkI838LDO03gh44BKIlafogygJbBh1VDsIydB8x2itMriI8eMeLiZfl92Y/XnwWVtYYdD8/NO6By+4lDGs3jmIsIX1ChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OOwRmTiq; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OOwRmTiq"
Received: (qmail 42682 invoked by uid 106); 16 Jul 2026 09:05:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GI/DeyMn5rHLw4X8cPRS/mAioFBWV00vhU/wVvlTmWI=; b=OOwRmTiqIlV1b5MPSJSRGKaW3iCKE44tVQrrPOtz4tNCujniktDI7iJHT/V1RtiQhhxwYUFyn6g6SlOjP2ZPvaMRlWq9nDrtm2jDXbapIlqH0CPK3glrTLcEOXZ42xkEMRgNpL+6t/6DjrkFCRFOEfBrm+x5+jjHKYLFzeDJxCJYSA/OsLCKu6+Absizygpi4FPGSDUwkwGNzwV05LkoRVrlxM0o93BjzZt/TvSw5H7xsUXISlqo+Jk+M9Ee0kW+U8oGk8OAGboUUzCbgN8So+RB7WBDnvGBDhEPb9FpNxAMesDKKQKR55NKYu8VXo/9RZacXnG7TN4df/FzTyr8uQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2026 09:05:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 77524 invoked by uid 111); 16 Jul 2026 09:05:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2026 05:05:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jul 2026 05:05:25 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v4 1/3] commit-reach: reject cycles in contains walk
Message-ID: <20260716090525.GA1196203@coredump.intra.peff.net>
References: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
 <20260612-ref-filter-memoized-contains-v4-1-5ed39fd001dd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612-ref-filter-memoized-contains-v4-1-5ed39fd001dd@gmail.com>

On Fri, Jun 12, 2026 at 05:49:12PM -0400, Tamir Duberstein wrote:

> @@ -708,7 +708,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
>  
>  /*
>   * Test whether the candidate is contained in the list.
> - * Do not recurse to find out, though, but return -1 if inconclusive.
> + * Do not recurse to find out, though, but return CONTAINS_UNKNOWN if
> + * inconclusive.
>   */
>  static enum contains_result contains_test(struct commit *candidate,
>  					  const struct commit_list *want,

This hunk is a good cleanup, but unrelated to the patch at hand.

We used to return a bare -1, then that became CONTAINS_UNKNOWN in
a0262c51d0 (ref-filter: use contains_result enum consistently,
2017-03-09). And then that value changed to 0 in a91aca44bf (ref-filter:
use separate cache for contains_tag_algo, 2017-03-09) when we started
using a slab.

So the code is correct and the comment is wrong, and it is worth
updating. I was just surprised to find it here.

> @@ -765,6 +766,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  	if (result != CONTAINS_UNKNOWN)
>  		return result;
>  
> +	*contains_cache_at(cache, candidate) = CONTAINS_IN_PROGRESS;
>  	push_to_contains_stack(candidate, &contains_stack);
>  	while (contains_stack.nr) {
>  		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
> @@ -776,8 +778,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  			contains_stack.nr--;
>  		}
>  		/*
> -		 * If we just popped the stack, parents->item has been marked,
> -		 * therefore contains_test will return a meaningful yes/no.
> +		 * A parent may have just been popped and marked, or may still
> +		 * be active when replacement refs create a cycle.
>  		 */
>  		else switch (contains_test(parents->item, want, cache, cutoff)) {
>  		case CONTAINS_YES:
> @@ -787,7 +789,11 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  		case CONTAINS_NO:
>  			entry->parents = parents->next;
>  			break;
> +		case CONTAINS_IN_PROGRESS:
> +			die(_("commit ancestry contains a cycle"));
>  		case CONTAINS_UNKNOWN:
> +			*contains_cache_at(cache, parents->item) =
> +				CONTAINS_IN_PROGRESS;
>  			push_to_contains_stack(parents->item, &contains_stack);
>  			break;
>  		}

Nice, this looks cleanly done.

> +test_expect_success 'tag --contains rejects cyclic replacement histories' '
> +	first=$(git rev-parse HEAD~2) &&
> +	second=$(git rev-parse HEAD~) &&
> +	third=$(git rev-parse HEAD) &&
> +	test_when_finished "
> +		git replace -d $first &&
> +		git replace -d $third &&
> +		git tag -d cycle-a cycle-b
> +	" &&
> +	git tag cycle-a "$first" &&
> +	git tag cycle-b "$third" &&
> +	git replace --graft "$first" "$third" "$second" &&
> +	git replace --graft "$third" "$first" &&
> +	test_must_fail git tag --contains="$second" --list "cycle-*" \
> +		>/dev/null 2>err &&
> +	test_grep "fatal: commit ancestry contains a cycle" err
> +'

Likewise the test looks good.

-Peff
