Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264BC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiCDWe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCDWeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:34:25 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6995D5D6
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:33:37 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B8BF112CF1;
        Fri,  4 Mar 2022 17:33:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c++xvQ/tG5b4SpPwOrwRVZpvflCs1Oi8XI6L5R
        tjhxM=; b=TGxez8MF/jfFh0wINzMdQFq0OaDgMFRN77+GWUhu+qZ0seA7I6XbSO
        txhkw+ioFhbcr8btaV8TseKFN7RVDlV0LfPz0XDzKvSpalItKRLTIcRHf1Ohuwdm
        4lP1lL+v2DKo3WIzqDxeLXw8wj7VjzudgK01IAa3grTFumvajHXX0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63988112CF0;
        Fri,  4 Mar 2022 17:33:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBC74112CEF;
        Fri,  4 Mar 2022 17:33:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 06/11] MyFirstObjectWalk: update recommended usage
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <355c503157ad02e6106179c2dc7228bdf63a6228.1645638911.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 14:33:34 -0800
In-Reply-To: <355c503157ad02e6106179c2dc7228bdf63a6228.1645638911.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 23 Feb 2022
        17:55:06 +0000")
Message-ID: <xmqqtucdxs8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 213DE224-9C0B-11EC-8FAD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The previous change consolidated traverse_commit_list() and
> traverse_commit_list_filtered(). This allows us to simplify the
> recommended usage in MyFirstObjectWalk.txt to use this new set of
> values.
>
> While here, add some clarification on the difference between the two
> methods.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/MyFirstObjectWalk.txt | 44 +++++++++++------------------
>  1 file changed, 16 insertions(+), 28 deletions(-)

Nice simplification.

>
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index ca267941f3e..8ec83185b8a 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -522,24 +522,25 @@ function shows that the all-object walk is being performed by
>  `traverse_commit_list()` or `traverse_commit_list_filtered()`. Those two
>  functions reside in `list-objects.c`; examining the source shows that, despite
>  the name, these functions traverse all kinds of objects. Let's have a look at
> -the arguments to `traverse_commit_list_filtered()`, which are a superset of the
> -arguments to the unfiltered version.
> +the arguments to `traverse_commit_list()`.
>  
> -- `struct list_objects_filter_options *filter_options`: This is a struct which
> -  stores a filter-spec as outlined in `Documentation/rev-list-options.txt`.
> -- `struct rev_info *revs`: This is the `rev_info` used for the walk.
> +- `struct rev_info *revs`: This is the `rev_info` used for the walk. It
> +  includes a `filter` member which contains information for how to filter
> +  the object list.

Perhaps,

    "When its `filter` member is not NULL, it contains ..."

implying that it is valid for `filter` member to be NULL and none of
the following things will happen in such a case.

>  For now, we are not going to track the omitted objects, so we'll replace those
>  parameters with `NULL`. For the sake of simplicity, we'll add a simple
> -build-time branch to use our filter or not. Replace the line calling
> +build-time branch to use our filter or not. Preface the line calling

Good eyes.

>  `traverse_commit_list()` with the following, which will remind us which kind of
>  walk we've just performed:
>  
> @@ -733,19 +723,17 @@ walk we've just performed:
>  	if (0) {
>  		/* Unfiltered: */
>  		trace_printf(_("Unfiltered object walk.\n"));
> -		traverse_commit_list(rev, walken_show_commit,
> -				walken_show_object, NULL);
>  	} else {
>  		trace_printf(
>  			_("Filtered object walk with filterspec 'tree:1'.\n"));
> -		parse_list_objects_filter(&filter_options, "tree:1");
> -
> -		traverse_commit_list_filtered(&filter_options, rev,
> -			walken_show_commit, walken_show_object, NULL, NULL);
> +		CALLOC_ARRAY(rev->filter, 1);
> +		parse_list_objects_filter(rev->filter, "tree:1");
>  	}
> +	traverse_commit_list(rev, walken_show_commit,
> +			     walken_show_object, NULL);
>  ----
>  
> -`struct list_objects_filter_options` is usually built directly from a command
> +The `rev->filter` member is usually built directly from a command
>  line argument, so the module provides an easy way to build one from a string.
>  Even though we aren't taking user input right now, we can still build one with
>  a hardcoded string using `parse_list_objects_filter()`.
> @@ -784,7 +772,7 @@ object:
>  ----
>  	...
>  
> -		traverse_commit_list_filtered(&filter_options, rev,
> +		traverse_commit_list_filtered(rev,
>  			walken_show_commit, walken_show_object, NULL, &omitted);
>  
>  	...
