Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F82C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 04:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFCE613E1
	for <git@archiver.kernel.org>; Mon, 10 May 2021 04:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhEJEum (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 00:50:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51721 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJEul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 00:50:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4526FB2B4D;
        Mon, 10 May 2021 00:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=45OGR2MCf+HjRWUHObfU+AMyrWalv8ZheX7WPw
        s7XpY=; b=ttJBl7YdTQL8TQB3cwTgZZc4AaRzrJvqJp1oooJiZyal2vQGMgUQ9r
        PFbWDVNvZbbEIlTagG4+9d0u6RWHgFAzJjF0pKUmqAYYvgqzYiKdL2XJE2OBNxLa
        imLfQk+vZfbbTG4Bx6uXx19YaXp6mBhxAfBUemaGe5xapW0sMwJeo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 393FFB2B4C;
        Mon, 10 May 2021 00:49:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9408B2B4B;
        Mon, 10 May 2021 00:49:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 1/8] [RFC] dir: convert trace calls to trace2
 equivalents
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <9f1c0d78d739cc1da8517eea92e81a7bd162578f.1620503945.git.gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 13:49:35 +0900
In-Reply-To: <9f1c0d78d739cc1da8517eea92e81a7bd162578f.1620503945.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 08 May 2021
        19:58:57 +0000")
Message-ID: <xmqqk0o7ry5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F16587E-B14B-11EB-ADBF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void trace2_read_directory_statistics(struct dir_struct *dir,
> +					     struct repository *repo)
> +{
> +	if (!dir->untracked)
> +		return;
> +	trace2_data_intmax("read_directory", repo,
> +			   "node-creation", dir->untracked->dir_created);
> +	trace2_data_intmax("read_directory", repo,
> +			   "gitignore-invalidation",
> +			   dir->untracked->gitignore_invalidated);
> +	trace2_data_intmax("read_directory", repo,
> +			   "directory-invalidation",
> +			   dir->untracked->dir_invalidated);
> +	trace2_data_intmax("read_directory", repo,
> +			   "opendir", dir->untracked->dir_opened);
> +}
> +

This obviously looks like an equivalent to what happens in the
original inside the "if (dir->untracked)" block.

And we have a performance_{enter,leave} pair replaced with
a region_[enter,leave} pair. 

> -	trace_performance_enter();
> +	trace2_region_enter("dir", "read_directory", istate->repo);
>   ...
> -	trace_performance_leave("read directory %.*s", len, path);
> +	trace2_region_leave("dir", "read_directory", istate->repo);

>  	if (dir->untracked) {
>  		static int force_untracked_cache = -1;
> -		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
>  
>  		if (force_untracked_cache < 0)
>  			force_untracked_cache =
>  				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", 0);
> -		trace_printf_key(&trace_untracked_stats,
> -				 "node creation: %u\n"
> -				 "gitignore invalidation: %u\n"
> -				 "directory invalidation: %u\n"
> -				 "opendir: %u\n",
> -				 dir->untracked->dir_created,
> -				 dir->untracked->gitignore_invalidated,
> -				 dir->untracked->dir_invalidated,
> -				 dir->untracked->dir_opened);
>  		if (force_untracked_cache &&
>  			dir->untracked == istate->untracked &&
>  		    (dir->untracked->dir_opened ||

Removal of the trace_printf() in the middle made the body of this
if() statement much less distracting, which is good.

> @@ -2811,6 +2818,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>  			FREE_AND_NULL(dir->untracked);
>  		}
>  	}
> +
> +	if (trace2_is_enabled())
> +		trace2_read_directory_statistics(dir, istate->repo);

This slightly changes the semantics in that the original did an
equivalent emitting from inside the "if (dir->untracked)" block, but
this call is hoisted outside, and the new helper knows how to be
silent when untracked thing is not in effect, so the net effect at
this step is the same.  And if we ever add tracing statics that is
relevant when !dir->untracked is true, the new code organization is
easier to work with.

The only curious thing is the guard "if (trace2_is_enabled())";
correctness-wise, are there bad things going to happen if it is not
here, or is this a performance hack, or is it more for its
documentation value (meaning, it would be a bug if we later added
things that are irrelevant when trace is not enabled to the helper)?

> @@ -57,6 +57,19 @@ iuc () {
>  	return $ret
>  }
>  
> +get_relevant_traces() {

Style.  SP on both sides of "()".

> +	# From the GIT_TRACE2_PERF data of the form
> +	#    $TIME $FILE:$LINE | d0 | main | data | r1 | ? | ? | read_directo | $RELEVANT_STAT
> +	# extract the $RELEVANT_STAT fields.  We don't care about region_enter
> +	# or region_leave, or stats for things outside read_directory.
> +	INPUT_FILE=$1
> +	OUTPUT_FILE=$2
> +	grep data.*read_directo $INPUT_FILE \
> +	    | cut -d "|" -f 9 \
> +	    >$OUTPUT_FILE

Style.  Wrapping the line after pipe '|' will allow you to omit the
backslash.  Also quote the redirection target, i.e. >"$OUTPUT_FILE",
to help certain vintage of bash.

Those who are more familiar with the trace2 infrastructure may want
to further comment, but it looked obvious and straightforward to me.

Thanks.
