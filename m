Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D11170A
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897028; cv=none; b=AwUQsk5bAZ+gqCkH+ZH7fzKBhGLBWs7TaoeMda8Aw4F4BS4Tfgjk/8gX6tn7SMnJpgQPUKJ796gi+F1i5soR0J5k7w6BYlF7EM0yPAPCn4RdtNdK7tCRur357UhpWReD/KKLxZqyvKw+axk2WcIKQXOHJdyEOcEaYgaaaRsjWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897028; c=relaxed/simple;
	bh=gqaic3+h3+Efg1iI1rnh0HZSJdicNmJtG1nBVZxQbfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J/YQPUkBtk3Ko9oFgzn03dpcYmEQByfgw4C6tHWtW+otl3r8TKr5bxF/tP3qh6qA5w5F9EV1pyLzMrfND1uRbCGvMyIE3RProCigftTVbjt5IvWOeDODOZ0d9quQJOaxI5oRY91uK3t7LQu3wmUAGCWHorJ6Z/lFtLH0T7u3L2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nlzYDZ2t; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nlzYDZ2t"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D6671AAEB;
	Wed, 14 Feb 2024 02:47:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gqaic3+h3+Efg1iI1rnh0HZSJdicNmJtG1nBVZ
	xQbfk=; b=nlzYDZ2t1UMZE6M5HBJiDOKRjaZRU/X+u6tITvsNXjw2YPE9tIUNom
	Tb0YrlPPOdM41ZNesmoJLPo4M9IimiiI+QSm+WUh8t0An/1x9vYqJ/Zrt4/FukSx
	kY2hU5fIEloep+/jqMKQ3mNw5PeBowr4pWPzIh7wlAZZCrlMbo0Zg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 45EA21AAE8;
	Wed, 14 Feb 2024 02:47:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E79941AACF;
	Wed, 14 Feb 2024 02:47:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 06/12] fsmonitor: clarify handling of directory events
 in callback
In-Reply-To: <5b6f8bd1fe7b6c742b25a5a1ed95b528f352215e.1707857541.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Tue, 13 Feb 2024
	20:52:15 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<5b6f8bd1fe7b6c742b25a5a1ed95b528f352215e.1707857541.git.gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 23:47:07 -0800
Message-ID: <xmqqil2rzdvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 418A071E-CB0D-11EE-813A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 614270fa5e8..754fe20cfd0 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -219,24 +219,40 @@ static void fsmonitor_refresh_callback_unqualified(
>  	}
>  }
>  
> -static void fsmonitor_refresh_callback_slash(
> +/*
> + * The daemon can decorate directory events, such as a move or rename,
> + * by adding a trailing slash to the observed name.  Use this to
> + * explicitly invalidate the entire cone under that directory.
> + *
> + * The daemon can only reliably do that if the OS FSEvent contains
> + * sufficient information in the event.
> + *
> + * macOS FSEvents have enough information.
> + *
> + * Other platforms may or may not be able to do it (and it might
> + * depend on the type of event (for example, a daemon could lstat() an
> + * observed pathname after a rename, but not after a delete)).
> + *
> + * If we find an exact match in the index for a path with a trailing
> + * slash, it means that we matched a sparse-index directory in a
> + * cone-mode sparse-checkout (since that's the only time we have
> + * directories in the index).  We should never see this in practice
> + * (because sparse directories should not be present and therefore
> + * not generating FS events).  Either way, we can treat them in the
> + * same way and just invalidate the cache-entry and the untracked
> + * cache (and in this case, the forward cache-entry scan won't find
> + * anything and it doesn't hurt to let it run).
> + *
> + * Return the number of cache-entries that we invalidated.  We will
> + * use this later to determine if we need to attempt a second
> + * case-insensitive search.
> + */
> +static int fsmonitor_refresh_callback_slash(
>  	struct index_state *istate, const char *name, int len, int pos)
>  {

This was split out a few patches ago, and the caller of course
ignored the return value (void), but now it turns an integer, and
this change is without a corresponding update to the caller, which
leaves readers puzzled.

Perhaps a future patch either updates the existing caller or adds a
new caller that utilize the returned value, but then at least the
proposed commit message for this step should hint how it helps the
caller(s) we will see in the future steps if this function returns
the number of entries invalidated, iow, how the caller is expected
to use the returned value from here, no?

Alternatively, this step can limit itself to what the commit title
claims to do---to clarify what the helper does with enhanced in-code
comments.  Then a future step that updates the caller to care about
the return value can have both the changes to this callee as well as
the caller---which may make it easier to see how the returned info
helps the caller.  I dunno which is more reasonable.

Thanks.



>  	int i;
> +	int nr_in_cone = 0;
>  
> -	/*
> -	 * The daemon can decorate directory events, such as
> -	 * moves or renames, with a trailing slash if the OS
> -	 * FS Event contains sufficient information, such as
> -	 * MacOS.
> -	 *
> -	 * Use this to invalidate the entire cone under that
> -	 * directory.
> -	 *
> -	 * We do not expect an exact match because the index
> -	 * does not normally contain directory entries, so we
> -	 * start at the insertion point and scan.
> -	 */
>  	if (pos < 0)
>  		pos = -pos - 1;
>  
> @@ -245,7 +261,10 @@ static void fsmonitor_refresh_callback_slash(
>  		if (!starts_with(istate->cache[i]->name, name))
>  			break;
>  		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> +		nr_in_cone++;
>  	}
> +
> +	return nr_in_cone;
>  }
>  
>  static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
