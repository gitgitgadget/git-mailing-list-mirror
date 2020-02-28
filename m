Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA61C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 00:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA409246A5
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 00:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+HrQMxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgB1AFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:05:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56184 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgB1AFH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 19:05:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id a18so478495pjs.5
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qeqQ6kFdj3kJlDC6FEPMvZdmo8exS5KXCnldV7T8w3A=;
        b=h+HrQMxIXIux1wkAqm46uk4iUCd3ZHqwizokpuu0kTFA3iko+uFpbn5T2iIs5189/h
         7eFdxJiVX+oMOhprCIz1YLXp3sZui3HmoTnGzmQK4HK4HVxlzcuM6MtoG9aqSf/r86x1
         zAyRdoZQjhdY56QiAtkfsPJzteXtkgxXrG+0DxLFyqK8d9boC7xxvKJsjSuHGqaiPq5l
         cCHIDwT6eGqTZW+BJOtUrVBifwWa0NX7IGm9qMqNqx7eQzIGYr4zIS7jA9gjyySXV7go
         KbRViqYKjpypLTbuOcAgRQ5lY1d0Y9FRzuAKdMIeCVDAxT3TNslm4fmLjdWmVxA+9wYa
         UncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qeqQ6kFdj3kJlDC6FEPMvZdmo8exS5KXCnldV7T8w3A=;
        b=c99ZWgB1ZXYFb04oblJsDhvgAawdtDFsSye+6ASWkbZW+o4aen4QIn54HLRxHtvCFV
         gOBMUCEKnIbe32BfpRfhJmwaXfpUe+UcjYLa0HwqoZH7wh5AZA/XJvxxfLp8TfvJQcVp
         k+OGyxZxX/jBgNRGfsR/hqUGRcyzuJP3VHvDlIgIcOpFz/p0v1FXDwuNhJdN06N/d92O
         SB5vMCn77z9QTNTw44bIRGJPJFzuXxTKSypz8lxJ4pCgURKO+d28uqAXXXHweUON+pPP
         fvQFgEnxkmwcjHJjsFxYoiyJy/gbRW1ZcYF4NKvvCtC1C7uPSk4nu8xhXA9v1KEh5qDk
         Woag==
X-Gm-Message-State: APjAAAVadnOxkg3VinjfnCz4PwUt9qUVjDpgilZ3tnzImqwc1l6W2NMU
        3biZIcGOeD+sXJohxNCi5/8ktQ==
X-Google-Smtp-Source: APXvYqyo+b21ee6ngqLun1zlVOqkZY0B2sVSUN7FPNrwNzjLiGie7DhfQoUZdY/mYUgyf1hMdNVrgw==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr1337283plb.129.1582848304583;
        Thu, 27 Feb 2020 16:05:04 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id t189sm8426288pfd.168.2020.02.27.16.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:05:03 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:04:59 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 7/7] index-pack: make quantum of work smaller
Message-ID: <20200228000459.GE12115@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com, peff@peff.net
References: <cover.1570663470.git.jonathantanmy@google.com>
 <cover.1571343096.git.jonathantanmy@google.com>
 <2f2e36d3efede79f55347ce9d80d453bb05a4e15.1571343096.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2e36d3efede79f55347ce9d80d453bb05a4e15.1571343096.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.17 13:17, Jonathan Tan wrote:
> Currently, when index-pack resolves deltas, it does not split up delta
> trees into threads: each delta base root (an object that is not a
> REF_DELTA or OFS_DELTA) can go into its own thread, but all deltas on
> that root (direct or indirect) are processed in the same thread.
> 
> This is a problem when a repository contains a large text file (thus,
> delta-able) that is modified many times - delta resolution time during
> fetching is dominated by processing the deltas corresponding to that
> text file.
> 
> This patch contains a solution to that. When cloning using
> 
>   git -c core.deltabasecachelimit=1g clone \
>     https://fuchsia.googlesource.com/third_party/vulkan-cts
> 
> on my laptop, clone time improved from 3m2s to 2m5s (using 3 threads,
> which is the default).
> 
> The solution is to have a global work stack. This stack contains delta
> bases (objects, whether appearing directly in the packfile or generated
> by delta resolution, that themselves have delta children) that need to
> be processed; whenever a thread needs work, it peeks at the top of the
> stack and processes its next unprocessed child. If a thread finds the
> stack empty, it will look for more delta base roots to push on the stack
> instead.
> 
> The main weakness of having a global work stack is that more time is
> spent in the mutex, but profiling has shown that most time is spent in
> the resolution of the deltas themselves, so this shouldn't be an issue
> in practice. In any case, experimentation (as described in the clone
> command above) shows that this patch is a net improvement.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c | 336 ++++++++++++++++++++++++-------------------
>  1 file changed, 190 insertions(+), 146 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 31607a77fc..072592a35d 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -38,15 +38,49 @@ struct base_data {
>  	struct object_entry *obj;
>  	int ref_first, ref_last;
>  	int ofs_first, ofs_last;
> +	/*
> +	 * Threads should increment retain_data if they are about to call
> +	 * patch_delta() using this struct's data as a base, and decrement this
> +	 * when they are done. While retain_data is nonzero, this struct's data
> +	 * will not be freed even if the delta base cache limit is exceeded.
> +	 */
> +	int retain_data;
> +	/*
> +	 * The number of direct children that have not been fully processed
> +	 * (entered work_head, entered done_head, left done_head). When this
> +	 * number reaches zero, this struct base_data can be freed.
> +	 */
> +	int children_remaining;
>  
>  	/* Not initialized by make_base(). */
> +	struct list_head list;
>  	void *data;
>  	unsigned long size;
>  };

As a newb, the addition of a field just called "list" struck me as
needing a more descriptive name. But this makes more sense now after
looking at list.h. And it seems that most uses in other parts of the
code are similarly just named "list".


> +/*
> + * Stack of struct base_data that have unprocessed children.
> + * threaded_second_pass() uses this as a source of work (the other being the
> + * objects array).
> + */
> +LIST_HEAD(work_head);
> +
> +/*
> + * Stack of struct base_data that have children, all of whom have been
> + * processed or are being processed, and at least one child is being processed.
> + * These struct base_data must be kept around until the last child is
> + * processed.
> + */
> +LIST_HEAD(done_head);
> +
> +/*
> + * All threads share one delta base cache.
> + */
> +size_t base_cache_used;
> +size_t base_cache_limit;
> +
>  struct thread_local {
>  	pthread_t thread;
> -	size_t base_cache_used;
>  	int pack_fd;
>  };

Seeing several new shared variables made me paranoid about whether or
not these were thread-safe. There are already five mutexes in this file,
but there are no clear descriptions (apart from hints in the lock names)
about which locks protect which variables. It would be nice to make this
a bit more explicit.

I wish we had something similar to Abseil's "GUARDED_BY" annotations [1]
so that we could ensure thread safety with static analysis, but that's
obviously out of scope for this series.

[1]: https://abseil.io/docs/cpp/guides/synchronization#thread-annotations


> @@ -920,6 +948,8 @@ static struct base_data *make_base(struct object_entry *obj,
>  				&base->ref_first, &base->ref_last);
>  	find_ofs_delta_children(obj->idx.offset,
>  				&base->ofs_first, &base->ofs_last);
> +	base->children_remaining = base->ref_last - base->ref_first +
> +		base->ofs_last - base->ofs_first + 2;
>  	return base;
>  }

The extra +2 here confused me for a bit, but it makes sense now. You're
subtracting indices to get the length, so you want +1 to make the math
work out, and you're doing it across two different lists. In the edge
case where a list is empty, "first" is 0 and "last" is -1, so the math
still works out.


> @@ -1065,33 +1011,128 @@ static int compare_ref_delta_entry(const void *a, const void *b)
[snip]
>  		work_unlock();
>  
> -		resolve_base(&objects[i]);
> +		if (parent) {
> +			child = resolve_delta(child_obj, parent);
> +			if (!child->children_remaining)
> +				FREE_AND_NULL(child->data);
> +		} else {
> +			child = make_base(child_obj, NULL);
> +			if (child->children_remaining) {
> +				/*
> +				 * Since this child has its own delta children,
> +				 * we will need this data in the future.
> +				 * Inflate now so that future iterations will
> +				 * have access to this object's data while
> +				 * outside the work mutex.
> +				 */
> +				child->data = get_data_from_pack(child_obj);
> +				child->size = child_obj->size;
> +			}
> +		}
> +
> +		work_lock();

This part made me uneasy at first, because it looks like we might be
doing work on shared data outside of the work lock. But just prior to
unlocking, we parent->retain_data, so we know it won't be freed. And the
only part we modify is child, which I don't believe is shared with any
other threads.
