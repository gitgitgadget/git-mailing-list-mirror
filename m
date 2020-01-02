Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7526C3276C
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6323220863
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hWhR2Vkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgABVuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:50:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58837 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABVuC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 16:50:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFAB42BC8D;
        Thu,  2 Jan 2020 16:49:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BqTgniyr6I5ymrqHWdRa+lJ4BHw=; b=hWhR2V
        knDTrJ16L5Knao5/UoGLmSXCPwphPoJ9qfNx9QuBs7vbj4Mo8pM/w4vJbJBAVsD3
        5sk8fv5NPWHQ0MI1ZcE7RyTa4PiSm8qUahhDHWLBDjrrECXi3r1q3lJCKi1bj5Ww
        ULHGqoFHMipQfWT8LGq7QIDg5qW0+lzTgHsGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TaaJKXvg3bowr7zLFzKGyks87WW2T9X9
        4VASlVOSFOhcAQf3CtjLgThrHV0z23H6HvqvPQKsQ9of9qMnCHbqpwiV3wN9q++J
        rPJpC7zG5U8ZAr+Ft5ezgMt7piRdU8Ke7CtC2icRymeOB0gwYcXg/fSyOIoERpTk
        69SnXhi9p68=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5D9F2BC8C;
        Thu,  2 Jan 2020 16:49:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FBC42BC8A;
        Thu,  2 Jan 2020 16:49:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: set size_multiple in split_commit_graph_opts
References: <pull.509.git.1577981654.gitgitgadget@gmail.com>
        <91d89356a20625d04af74d458c28b32445e760c1.1577981654.git.gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 13:49:58 -0800
In-Reply-To: <91d89356a20625d04af74d458c28b32445e760c1.1577981654.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 02 Jan 2020
        16:14:14 +0000")
Message-ID: <xmqq7e29edfd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D26FA73A-2DA9-11EA-A43C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This problem is due to two failures:
>
>  1. It is unclear that we can add the flag COMMIT_GRAPH_WRITE_SPLIT
>     with a NULL split_opts.
>  2. If we have a non-NULL split_opts, then we override the default
>     values even if a zero value is given.
>
> Correct both of these issues. First, do not override size_mult when
> the options provide a zero value. Second, stop creating a split_opts
> in the fetch builtin.

OK, so there is the hardcoded default 2 in the code, and split_opts
structure *can* override it, but 0 in the field of the structure is
meant to signal "no, I do not have any value to override the
default", not "I do want to set the multiple to 0"?

Makes sense.  Will queue.

Thanks.


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/fetch.c | 4 +---
>  commit-graph.c  | 4 +++-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f8765b385b..b4c6d921d0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1866,15 +1866,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	    (fetch_write_commit_graph < 0 &&
>  	     the_repository->settings.fetch_write_commit_graph)) {
>  		int commit_graph_flags = COMMIT_GRAPH_WRITE_SPLIT;
> -		struct split_commit_graph_opts split_opts;
> -		memset(&split_opts, 0, sizeof(struct split_commit_graph_opts));
>  
>  		if (progress)
>  			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
>  
>  		write_commit_graph_reachable(get_object_directory(),
>  					     commit_graph_flags,
> -					     &split_opts);
> +					     NULL);
>  	}
>  
>  	close_object_store(the_repository->objects);
> diff --git a/commit-graph.c b/commit-graph.c
> index e771394aff..b205e65ed1 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1542,7 +1542,9 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
>  
>  	if (ctx->split_opts) {
>  		max_commits = ctx->split_opts->max_commits;
> -		size_mult = ctx->split_opts->size_multiple;
> +
> +		if (ctx->split_opts->size_multiple)
> +			size_mult = ctx->split_opts->size_multiple;
>  	}
>  
>  	g = ctx->r->objects->commit_graph;
