Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34FC81F462
	for <e@80x24.org>; Fri, 26 Jul 2019 18:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbfGZSnG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 14:43:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63120 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbfGZSnF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 14:43:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EAD2D7845B;
        Fri, 26 Jul 2019 14:43:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SFPJFIxssMzgv5PTnpGX6gjvnJY=; b=EOq8f5
        hu4tK6OMwSFAT9xCqNd4PdtwYpHGAxluFZLiMxraIXsApkoZzCzGfRInkzns0V2m
        BuakaqLQG6f2rS+k9jAY/fxkftgxcDD5agkW7A9M5cH16VpmIqDz21qI3QAe8gBP
        YoWAFh2bejy/e0uzlvMBtN2lq2UKHl5eOH8es=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qqkchRQNo9OnJKmQJpVN/Akj3Qb3Nki8
        nsVjaMAM4MVkhEOR1tNvGd/QgD3x3UmIT1JC6iBx0BvcQQfT7eMxya8lVZ1+OqgZ
        FNLjydYGaf3kQ/UlWzB2yFPvZwCkcFHRSKL9kBNTQk46TyIdqD0kZP/AnXdUrxhX
        gKH/r1tofeo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2F9F7845A;
        Fri, 26 Jul 2019 14:43:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 135C378458;
        Fri, 26 Jul 2019 14:43:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 02/20] merge-recursive: remove another implicit dependency on the_repository
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-3-newren@gmail.com>
Date:   Fri, 26 Jul 2019 11:42:58 -0700
In-Reply-To: <20190726155258.28561-3-newren@gmail.com> (Elijah Newren's
        message of "Fri, 26 Jul 2019 08:52:40 -0700")
Message-ID: <xmqqk1c4ocwd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31DCAA4A-AFD5-11E9-9EB1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Commit d7cf3a96e9a0 ("merge-recursive.c: remove implicit dependency on
> the_repository", 2019-01-12) and follow-ups like commit 34e7771bc644
> ("Use the right 'struct repository' instead of the_repository",
> 2019-06-27), removed most implicit uses of the_repository.  Convert
> calls to get_commit_tree() to instead use repo_get_commit_tree() to get
> rid of another.

You are getting rid of three more!!!

Nice ;-)

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1163508811..37bb94fb4d 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3571,8 +3571,11 @@ int merge_recursive(struct merge_options *opt,
>  		repo_read_index(opt->repo);
>  
>  	opt->ancestor = "merged common ancestors";
> -	clean = merge_trees(opt, get_commit_tree(h1), get_commit_tree(h2),
> -			    get_commit_tree(merged_common_ancestors),
> +	clean = merge_trees(opt,
> +			    repo_get_commit_tree(opt->repo, h1),
> +			    repo_get_commit_tree(opt->repo, h2),
> +			    repo_get_commit_tree(opt->repo,
> +						 merged_common_ancestors),
>  			    &mrtree);
>  	if (clean < 0) {
>  		flush_output(opt);
