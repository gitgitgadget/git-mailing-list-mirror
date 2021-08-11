Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C3BC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DEB6104F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 18:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhHKSA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:00:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51708 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhHKSA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 14:00:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E905D2B95;
        Wed, 11 Aug 2021 14:00:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4EFIxnVuvjDGWDRbOA/CLpCrOPK53qMJ6W85SQ
        F7PKo=; b=upP6J2701RxmYGGvZKX9KzektwZxwmJFaZGZOi6vY0xDqLgk/5syV3
        sf17d6VGscZONP/Xm3WLe4/yC8MMfnbTx/qYAvv1bQD7jvNqsy/xN8XW5cNptzZL
        z/X3VIkrNTgDRdlHCwkAYqSv+RB6Da/b8NvkTOAPpArbPRdRcB2U8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06715D2B8E;
        Wed, 11 Aug 2021 14:00:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F348FD2B83;
        Wed, 11 Aug 2021 14:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] list-objects.c: traverse_trees_and_blobs: rename
 and tree-wide
References: <cover.1628670288.git.dyroneteng@gmail.com>
        <b6f3b15253d44c9250f59b53aafe471edda9f4b7.1628670288.git.dyroneteng@gmail.com>
Date:   Wed, 11 Aug 2021 11:00:00 -0700
In-Reply-To: <b6f3b15253d44c9250f59b53aafe471edda9f4b7.1628670288.git.dyroneteng@gmail.com>
        (Teng Long's message of "Wed, 11 Aug 2021 17:07:14 +0800")
Message-ID: <xmqqsfzf980v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F32FB22E-FACD-11EB-AFF7-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Subject: Re: [PATCH v1 1/1] list-objects.c: traverse_trees_and_blobs: rename and tree-wide

Sorry but I do not quite get the " and tree-wide" part of the title.

> Function `traverse_trees_and_blobs` not only works on trees and blobs,
> but also on tags, the function name is somewhat misleading. This commit
> rename it to `traverse_trees_and_blobs_and_tags`.

This looks pretty much "Meh" to me.

The current name might mislead people that we are limited to only
two types, but I doubt the risk of misleading is worth reducing with
such an overly long name.  The original is long enough X-<.

When we introduced it at 91904f56 (list-objects.c: factor out
traverse_trees_and_blobs, 2017-11-02), we may have been better to
call it traverse_non_commits().  The idea of traverse_commit_list(),
which is its primary caller, is for its main loop to iterate over
commits and process them one by one in each iteration, and process
objects of other types discovered therein by calling this function
once per each commit [*1*].

s/trees_and_blobs/non_commits/ will result in a name that is much
shorter and to the point, I think.


[Footnote]

*1* The call to it at the end is meant to sweep anything
leftover---we will not discover any tag while in the main loop of
the caller that iterates over commits (as they cannot contain any
tag in there).



> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  list-objects.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/list-objects.c b/list-objects.c
> index 7f404677d5..37a37fc502 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -334,7 +334,7 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
>  	add_pending_object(revs, &tree->object, "");
>  }
>  
> -static void traverse_trees_and_blobs(struct traversal_context *ctx,
> +static void traverse_trees_and_blobs_and_tags(struct traversal_context *ctx,
>  				     struct strbuf *base)
>  {
>  	int i;
> @@ -407,9 +407,9 @@ static void do_traverse(struct traversal_context *ctx)
>  			 * needs a reallocation for each commit. Can we pass the
>  			 * tree directory without allocation churn?
>  			 */
> -			traverse_trees_and_blobs(ctx, &csp);
> +			traverse_trees_and_blobs_and_tags(ctx, &csp);
>  	}
> -	traverse_trees_and_blobs(ctx, &csp);
> +	traverse_trees_and_blobs_and_tags(ctx, &csp);
>  	strbuf_release(&csp);
>  }
