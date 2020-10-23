Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF95C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA752072E
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="v+3lxZFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbgJWSMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbgJWSMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 14:12:35 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFE7C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 11:12:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z6so2018235qkz.4
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ZB3ervKqq0X6v+HIgbW1Mh7cPWf5+r9ynXlsgRGjLA=;
        b=v+3lxZFTBS54QTbgUxPjc+Z4/RVQKhBrhWLZwbkwjuh0UNpF7YCrjDITEG7sGx/cJ0
         ghkiEgK2QgSuJE+L33KCM41lCjdE51IyANUOZWNOybIaP3iD51L4FPfbpUx4J9VSBcgW
         mV+h5LeCIUgcz23H4WNuakYq+2IKiXx6WcFYC5+SlIGUT/66XSKOI8cyJj0+1VaoC5UM
         Q2Mw7t/qCsJl5TFqjvg+lHEv2RsM1gnHSU4LsY+WUjVjMuuQzLXdvzWV5auY4T6vjClI
         gcrDPFqjVtCMf3MwMtTtFziWKp/R9JArdvJIBubZbUnBqQ/FSS/Xb54YqwjyNKXAX3Pi
         HgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ZB3ervKqq0X6v+HIgbW1Mh7cPWf5+r9ynXlsgRGjLA=;
        b=OJuW33fmLxFH8h+7wzHoC5aQqVSAhNzSjt85ceX9hAMil1FP1djAJ+KaSZuCmdgw+H
         tpeRYj9wloxUfnX8vuDZ7XhlFpEP+mi0dvBxJYfCdMcPqiTAIyOTLZL/IJCPFedFsYtk
         s6TMBNZq9uoUNv9eRztqCl1d64PPM5yhD/dhqa9sC+jj3mSjFG8AbytJ3iz9eLX2TC/b
         D0si+WJ4qYExeWIT4SdjfkrOBsEyzt6VhAf8zqpOAtOD8HFcdLJqvkYFqYldtT+HH9hf
         LxOOSdANCTl7tkOsplaxDhmHzQSssB7AwJEArkGVLceWj8+4G5NAWOhzcH92RTYKVukt
         WSSw==
X-Gm-Message-State: AOAM531fxqh5NO1yroSn4PPfDM3d7WDuXGi6mK6wkkqvTmjJRCnXAOBV
        czeKivLoydu34RDzoOJHz/y/wA==
X-Google-Smtp-Source: ABdhPJwT6iQF3fKNGW94yoA7Yow1WD9qC8P/z+4dSLP+8f/z6M0AajPFbsp8SLTi0/K9XZYgn3BYBA==
X-Received: by 2002:a37:641:: with SMTP id 62mr3581433qkg.473.1603476754494;
        Fri, 23 Oct 2020 11:12:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:eda0:8d26:51d2:6e87])
        by smtp.gmail.com with ESMTPSA id c7sm1276767qkg.118.2020.10.23.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:12:33 -0700 (PDT)
Date:   Fri, 23 Oct 2020 14:12:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] merge-ort: barebones API of new merge strategy with
 empty implementation
Message-ID: <X5MdD5Ft/DNbCfQv@nand.local>
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
 <54ef18182cf3a4b5d02889c139e495fa68588652.1603286555.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54ef18182cf3a4b5d02889c139e495fa68588652.1603286555.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 01:22:32PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> This is the beginning of a new merge strategy.  While there are some API
> differences, and the implementation has some differences in behavior, it
> is essentially meant as an eventual drop-in replacement for
> merge-recursive.c.  However, it is being built to exist side-by-side
> with merge-recursive so that we have plenty of time to find out how
> those differences pan out in the real world while people can still fall
> back to merge-recursive.  (Also, I intend to avoid modifying
> merge-recursive during this process, to keep it stable.)
>
> The primary difference noticable here is that the updating of the
> working tree and index is not done simultaneously with the merge
> algorithm, but is a separate post-processing step.  The new API is
> designed so that one can do repeated merges (e.g. during a rebase or
> cherry-pick) and only update the index and working tree one time at the
> end instead of updating it with every intermediate result.  Also, one
> can perform a merge between two branches, neither of which match the
> index or the working tree, without clobbering the index or working tree.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Makefile    |  1 +
>  merge-ort.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  merge-ort.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 merge-ort.c
>  create mode 100644 merge-ort.h
>
> diff --git a/Makefile b/Makefile
> index 95571ee3fc..088770c2ae 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -921,6 +921,7 @@ LIB_OBJS += mailmap.o
>  LIB_OBJS += match-trees.o
>  LIB_OBJS += mem-pool.o
>  LIB_OBJS += merge-blobs.o
> +LIB_OBJS += merge-ort.o
>  LIB_OBJS += merge-recursive.o
>  LIB_OBJS += merge.o
>  LIB_OBJS += mergesort.o
> diff --git a/merge-ort.c b/merge-ort.c
> new file mode 100644
> index 0000000000..5230364a8d
> --- /dev/null
> +++ b/merge-ort.c
> @@ -0,0 +1,52 @@
> +/*
> + * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
> + * as a drop-in replacement for the "recursive" merge strategy, allowing one
> + * to replace
> + *
> + *   git merge [-s recursive]
> + *
> + * with
> + *
> + *   git merge -s ort
> + *
> + * Note: git's parser allows the space between '-s' and its argument to be
> + * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
> + * "cale", "peedy", or "ins" instead of "ort"?)
> + */

One thing that might be good here (and I realize that you sort of get to
it in your next patch) is some example usage. Maybe it's good enough to
say "see the $FILE_MODIFIED_BY_NEXT_PATCH for example usage", but it may
be good to be a little bit clearer here.

Perhaps it may even be appropriate to add a
Documentation/technical/api-merge-ort.txt or something (if you haven't
already in one of your other branches...).

> +
> +#include "cache.h"
> +#include "merge-ort.h"
> +
> +void merge_switch_to_result(struct merge_options *opt,
> +			    struct tree *head,
> +			    struct merge_result *result,
> +			    int update_worktree_and_index,
> +			    int display_update_msgs)
> +{
> +	die("Not yet implemented");
> +	merge_finalize(opt, result);
> +}
> +
> +void merge_finalize(struct merge_options *opt,
> +		    struct merge_result *result)
> +{
> +	die("Not yet implemented");
> +}
> +
> +void merge_inmemory_nonrecursive(struct merge_options *opt,
> +				 struct tree *merge_base,
> +				 struct tree *side1,
> +				 struct tree *side2,
> +				 struct merge_result *result)
> +{
> +	die("Not yet implemented");
> +}
> +
> +void merge_inmemory_recursive(struct merge_options *opt,
> +			      struct commit_list *merge_bases,
> +			      struct commit *side1,
> +			      struct commit *side2,
> +			      struct merge_result *result)
> +{
> +	die("Not yet implemented");
> +}
> diff --git a/merge-ort.h b/merge-ort.h
> new file mode 100644
> index 0000000000..9c655cd3ad
> --- /dev/null
> +++ b/merge-ort.h
> @@ -0,0 +1,49 @@
> +#ifndef MERGE_ORT_H
> +#define MERGE_ORT_H
> +
> +#include "merge-recursive.h"
> +
> +struct commit;
> +struct tree;
> +
> +struct merge_result {
> +	/* whether the merge is clean */
> +	int clean;
> +
> +	/* Result of merge.  If !clean, represents what would go in worktree */
> +	struct tree *tree;
> +
> +	/*
> +	 * Additional metadata used by merge_switch_to_result() or future calls
> +	 * to merge_inmemory_*().
> +	 */
> +	unsigned _;

I was a little surprised that '_' is allowed, since I can't think of any
other variable that is called that (and a search with "git grep ' _;' --
**/*.h" confirms that this is the only one. It does compile with
DEVELOPER=1, so...

Is this meant to be a flags-like? I believe you that it's necessary, but
I wonder if it could be named more clearly, even though it's private.

> +	void *priv;
> +};
> +
> +/* rename-detecting three-way merge, no recursion. */
> +void merge_inmemory_recursive(struct merge_options *opt,
> +			      struct commit_list *merge_bases,
> +			      struct commit *side1,
> +			      struct commit *side2,
> +			      struct merge_result *result);
> +
> +/* rename-detecting three-way merge with recursive ancestor consolidation. */
> +void merge_inmemory_nonrecursive(struct merge_options *opt,
> +				 struct tree *merge_base,
> +				 struct tree *side1,
> +				 struct tree *side2,
> +				 struct merge_result *result);

Good. This API looks sane to me, and contains nothing more nor less than
I'd expect. I appreciate that the _recursive declaration is separate
from the _nonrecursive one (and not hidden behind a flag that switches
between the two).

> +/* Update the working tree and index from head to result after inmemory merge */
> +void merge_switch_to_result(struct merge_options *opt,
> +			    struct tree *head,
> +			    struct merge_result *result,
> +			    int update_worktree_and_index,
> +			    int display_update_msgs);

Seems like these last two could probably be made into an enum and passed
as flags instead of adding more parameters on the end.

> +/* Do needed cleanup when not calling merge_switch_to_result() */
> +void merge_finalize(struct merge_options *opt,
> +		    struct merge_result *result);
> +
> +#endif
> --
> gitgitgadget
>
Thanks,
Taylor
