Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF90C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A0161D8B
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhF2EpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 00:45:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53350 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhF2EpF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 00:45:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3A54D49AD;
        Tue, 29 Jun 2021 00:42:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=PrWOdxHspe8K8qOHRz6EWDsOWO/YtHMeyYxf9uiMyT0=; b=SiB8
        yMll65QUAK/hUGdRVJ4WaKQLmL78aLA5OhhotY2i8zIfkpGcULejR7P3MqcrrfVq
        JaXVMjZ5bmJqn73fBzuvYin2+dj6cuGO3TMnIOOkO40htUyOxpgt8oofP0rKSKxr
        /WdktWMh3wVHvXqCViYz6XlUdsgIdpZWWBNXNWw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC997D49AB;
        Tue, 29 Jun 2021 00:42:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67576D49AA;
        Tue, 29 Jun 2021 00:42:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH 3/3] Write index when populating empty untracked cache
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
        <627f1952fd8d4864b6b87f5539a9d9b802c5796b.1624559402.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Jun 2021 21:42:37 -0700
Message-ID: <xmqq35t11dtu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E6E8192-D894-11EB-AA0B-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 3/3] Write index when populating empty untracked cache

Common to all three patches.  

Look at "git shortlog --no-merges -200 master" and observe the
pattern, i.e. our commit title are <area> prefix, a colon and then a
summary.  Try to make your commits blend in.

> From: Tao Klerks <tao@klerks.biz>
>
> It is expected that an empty/unpopulated untracked
> cache structure can be written to the index - by update-
> index, or by a "git status" call that sees the untracked cache
> should be enabled, but is running with options that make
> it non-applicable in that run.

Would an example be helpful?  What requests the untracked cache to
be created, and what options (or perhaps the lack of what options)
prevent the untracked cache to be "non-applicable"?

> Currently, if that happens, then subsequent "git status"
> calls end up populating the untracked cache, but not
> writing the index (not saving their work) - so the
> performance outcome is almost identical to the cache
> being altogether disabled.
>
> This continues until the index gets written with the cache
> populated, for some *other* reason.

Here (and only here), the word "cache" is used instead of "untracked
cache"---but I suspect that "the cache" here is the same "untracked
cache".  If that is the case, being consistent and spelling it out
would reduce the risk of confusing readers.

> In this change, we detect the "existing cache is empty
> and it looks like we are using it" condition, and queues
> an index write when this happens.

"we detect ... and queues" sounds like a grammo.

In this project, we describe the change being proposed as if we are
giving an order to the codebase to "become like so".  So, perhaps

    Detect the condition where an empty untracked cache exists in
    the index and we collect the list of untracked paths, and queue
    an index write under that condition, so that the collected
    untracked paths can be written out to the untracked cache
    extension in the index.

or something along the line.

> This change depends on previous fixes to t7519 for the
> "ignore .git changes when invalidating UNTR" test case to
> pass - before this fix, the test never actually did anything
> as it was not set up correctly.
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>  dir.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index ebe5ec046e0..a326e40e1c1 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2703,7 +2703,8 @@ void remove_untracked_cache(struct index_state *istate)
>  
>  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
>  						      int base_len,
> -						      const struct pathspec *pathspec)
> +						      const struct pathspec *pathspec,
> +						      struct index_state *istate)
>  {
>  	struct untracked_cache_dir *root;
>  	static int untracked_cache_disabled = -1;
> @@ -2767,8 +2768,15 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>  		return NULL;
>  	}
>  
> -	if (!dir->untracked->root)
> +	if (!dir->untracked->root) {
>  		FLEX_ALLOC_STR(dir->untracked->root, name, "");
> +		/*
> +		 * If we've had to initialize the root, then what we had was an
> +		 * empty uninitialized untracked cache structure. We will be
> +		 * populating it now, so we should trigger an index write.
> +		 */
> +		istate->cache_changed |= UNTRACKED_CHANGED;
> +	}

The logic sounds fairly straight-forward.  The fact that we came
this far in the helper function means that we know we want to use
(i.e. untracked cache is not disabled, and various other "we
shouldn't be contaminating the cache with the one-shot information"
cases did not return from the helper) untracked cache, and root
being NULL originally means the untracked cache wasn't populated.

>  	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
>  	root = dir->untracked->root;
> @@ -2838,7 +2846,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>  		return dir->nr;
>  	}
>  
> -	untracked = validate_untracked_cache(dir, len, pathspec);
> +	untracked = validate_untracked_cache(dir, len, pathspec, istate);
>  	if (!untracked)
>  		/*
>  		 * make sure untracked cache code path is disabled,
