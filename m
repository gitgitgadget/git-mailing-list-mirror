Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD2C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7482081E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WdlTPTN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBOAfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:35:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35280 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgBOAfz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 19:35:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so4332424plt.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 16:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7xF2Ofcb2JduEZkTc0GHQlw9jxjsd+GyVqHUwdZjtT8=;
        b=WdlTPTN0o1EYFUYrhT8XnS+38WnX72BfzdBfSCcMhMoB4MItMDfuessL2soATBIeX7
         RKkGdMOXliusWSQJKWMULi6etmhwE82bY5syF6QHYaFWZXtRqH8BPLr23hVY/InKbm6P
         g35lUTUSt38/K6rKzRzw0nL1f+mQvtKFhgPx3byssSxIN5Q3jhS3q7gz9PBoT1WkJM53
         6paDELrQYRbJg964O3+vKC+gXDnLESD2OMJEtPDnTCFHyIwyUFdAT6qJ7GJnqAXdAutl
         nMMYvn7OWQahrOdANGGwjUbRgsRPFh6zxksj0wrEb8f3T8v7lhnOpPFiUOOsTvFGJDfP
         0EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xF2Ofcb2JduEZkTc0GHQlw9jxjsd+GyVqHUwdZjtT8=;
        b=NjTCUES8lyT+W297nV141FNB5E8MpsHBrJ9Z9/qK2KP56Vtz6cm5eE7F6yTUJKUf6S
         CPn1hvpk2RzGi2lQyiP83NphBq7wTL3uFBPOATkCc1W/1w7mqfV1/qGwORVdj7T/OGuo
         bbK546LF5tEPEfsfdG+QiEYluL4FiLN+KWpbgsyFpNStWSboM4l1bOMYvbqFKjGHKOPc
         PYveKzkkf0fns70+HV2Fii6phJY5UQst1+xIuS8ccNt4cQ2Circ+xdpSi76NPxArC2st
         Xx+VYB6m1aDkhv7qoi3iEkts7unaBIeGHD9kZF7hkS1NIbuGikJ3lzK+WdpAXRjLlxT6
         H6nw==
X-Gm-Message-State: APjAAAVibMsdAyxx4uK0VKfRbCGpYnEYe5ZCmuUuXtOtsY2T42Lo57A/
        f9HYveBoUvTw0TrkhpbPAMyPdg==
X-Google-Smtp-Source: APXvYqxR/ixwCWGyTpSytUjSOXGdbYX0jwvoYK0GCSjCCMfAnjy5B4ZRVJfCN67JA5PZVVspMNS52w==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr6739019pjp.114.1581726953106;
        Fri, 14 Feb 2020 16:35:53 -0800 (PST)
Received: from localhost ([2600:100f:b02c:92d4:11e2:3a54:273f:b5fe])
        by smtp.gmail.com with ESMTPSA id b12sm8530238pfr.26.2020.02.14.16.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:35:52 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:35:51 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/15] rev-list: factor out bitmap-optimized routines
Message-ID: <20200215003551.GA14791@syl.local>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182218.GE150965@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182218.GE150965@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 01:22:18PM -0500, Jeff King wrote:
> There are a few operations in rev-list that are optimized for bitmaps.
> Rather than having the code inline in cmd_rev_list(), let's move them
> into helpers. This not only makes the flow of the main function simpler,
> but it lets us replace the complex "can we do the optimization?"
> conditionals with a series of early returns from the functions. That
> also makes it easy to add comments explaining those conditions.

Makes sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/rev-list.c | 88 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 67 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 4cb5a52dee..38c5ca5603 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -364,6 +364,69 @@ static inline int parse_missing_action_value(const char *value)
>  	return 0;
>  }
>
> +static int try_bitmap_count(struct rev_info *revs)
> +{
> +	uint32_t commit_count;
> +	int max_count;
> +	struct bitmap_index *bitmap_git;
> +
> +	/* This function only handles counting, not general traversal. */
> +	if (!revs->count)
> +		return -1;
> +
> +	/*
> +	 * A bitmap result can't know left/right, etc, because we don't
> +	 * actually traverse.
> +	 */
> +	if (revs->left_right || revs->cherry_mark)
> +		return -1;
> +
> +	/*
> +	 * This must be saved before doing any walking, since the revision
> +	 * machinery will count it down to zero while traversing.
> +	 */
> +	max_count = revs->max_count;
> +
> +	bitmap_git = prepare_bitmap_walk(revs);
> +	if (!bitmap_git)
> +		return -1;
> +
> +	count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
> +	if (max_count >= 0 && max_count < commit_count)
> +		commit_count = max_count;
> +
> +	printf("%d\n", commit_count);
> +	free_bitmap_index(bitmap_git);
> +	return 0;
> +}
> +
> +static int try_bitmap_traversal(struct rev_info *revs)
> +{
> +	struct bitmap_index *bitmap_git;
> +
> +	/*
> +	 * We can't use a bitmap result with a traversal limit, since the set
> +	 * of commits we'd get would be essentially random.
> +	 */
> +	if (revs->max_count >= 0)
> +		return -1;
> +
> +	/*
> +	 * Our bitmap result will return all objects, and we're not
> +	 * yet prepared to show only particular types.
> +	 */
> +	if (!revs->tag_objects || !revs->tree_objects || !revs->blob_objects)
> +		return -1;
> +
> +	bitmap_git = prepare_bitmap_walk(revs);
> +	if (!bitmap_git)
> +		return -1;
> +
> +	traverse_bitmap_commit_list(bitmap_git, &show_object_fast);
> +	free_bitmap_index(bitmap_git);
> +	return 0;
> +}
> +
>  int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info revs;
> @@ -534,27 +597,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  		progress = start_delayed_progress(show_progress, 0);
>
>  	if (use_bitmap_index) {
> -		if (revs.count && !revs.left_right && !revs.cherry_mark) {
> -			uint32_t commit_count;
> -			int max_count = revs.max_count;
> -			struct bitmap_index *bitmap_git;
> -			if ((bitmap_git = prepare_bitmap_walk(&revs))) {
> -				count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
> -				if (max_count >= 0 && max_count < commit_count)
> -					commit_count = max_count;
> -				printf("%d\n", commit_count);
> -				free_bitmap_index(bitmap_git);
> -				return 0;
> -			}
> -		} else if (revs.max_count < 0 &&
> -			   revs.tag_objects && revs.tree_objects && revs.blob_objects) {
> -			struct bitmap_index *bitmap_git;
> -			if ((bitmap_git = prepare_bitmap_walk(&revs))) {
> -				traverse_bitmap_commit_list(bitmap_git, &show_object_fast);
> -				free_bitmap_index(bitmap_git);
> -				return 0;
> -			}
> -		}
> +		if (!try_bitmap_count(&revs))
> +			return 0;
> +		if (!try_bitmap_traversal(&revs))
> +			return 0;
>  	}
>
>  	if (prepare_revision_walk(&revs))
> --
> 2.25.0.796.gcc29325708

The refactoring here is straightforward, and looks correct to my
reading.

Thanks,
Taylor
