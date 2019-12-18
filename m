Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB53BC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77427218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G8c69km+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLRTSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:18:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59841 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfLRTSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:18:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3055D1CD85;
        Wed, 18 Dec 2019 14:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nxy53Wy59FkLxPKgTIm5lWkdFjw=; b=G8c69k
        m+qseRpB8I6a1euhtuEZ4LoWF3H09Y0YbgMo1izMtyoMEzfqEHZj3bXcVSQgKyBO
        k9w/xdU0Xbxt8EYDkTwlokz25SqWq3r4RB5jGIox/eeENTvuSayjaLk7PVqnaUgW
        pYorzpdCbNAi0bA4KVVkmgH9O2BQ0ImT04ci0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l6WP1aEzBAAkF/511tMLlEzyuPSsljbI
        fiJHDYP9Lz93HbZa93qq9z1C31QUFLfJ7ANftb2YoHxVsdPtD2W3GPTliONjXk7P
        M9/8OTht6frK5wEpwt/E20SQxM3KBbGB3xo0BhRwVAg7C/eFbzAiiRWBtXwETMVu
        Q4ao8rLBwEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26D321CD84;
        Wed, 18 Dec 2019 14:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 569561CD82;
        Wed, 18 Dec 2019 14:18:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 2/5] parse_branchname_arg(): introduce expect_commit_only
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
        <a84633a44474aa25bd1101a9ca2a5d9687900bf2.1574969538.git.gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 11:18:32 -0800
In-Reply-To: <a84633a44474aa25bd1101a9ca2a5d9687900bf2.1574969538.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Thu, 28 Nov 2019
        19:32:15 +0000")
Message-ID: <xmqqfthhe92v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EB2109A-21CB-11EA-9549-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> `has_dash_dash` unexpectedly takes `opts->accept_pathspec` into account.

You also touched the code that depends on opts->accept_pathspec in
the earlier step 1/5; these two steps seem harder to reason about
than necessary---I wonder if it is easier to explain and understand
if these two steps are merged into one and explained together?

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 655b389756..5c6131dbe6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1123,7 +1123,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>  	const char **new_branch = &opts->new_branch;
>  	const char *arg;
>  	int dash_dash_pos;
> -	int has_dash_dash = 0;
> +	int has_dash_dash = 0, expect_commit_only = 0;
>  	int i;
>  
>  	/*
> @@ -1194,7 +1194,10 @@ static int parse_branchname_arg(int argc, const char **argv,
>  		    die(_("only one reference expected, %d given."), dash_dash_pos);
>  	}
>  
> -	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
> +	if (has_dash_dash)
> +	    expect_commit_only = 1;

Non-standard indentation here.

> +	opts->count_checkout_paths = !opts->quiet && !expect_commit_only;

OK.  count_checkout_paths is relevant only when checking out paths
out of a tree-ish, so "expect-commit-only" would be false in such a
situation.  On the other hand, if we were checking out a branch (or
detaching), we must have a commit and a tree-ish is insufficient,
so expect_commit_only would be true in such a case.

Makes sense.  I am wondering if we still need has_dash_dash, and
also if expect_commit_only is the best name for the variable.

Thanks.

> @@ -1210,10 +1213,10 @@ static int parse_branchname_arg(int argc, const char **argv,
>  		 */
>  		int recover_with_dwim = dwim_new_local_branch_ok;
>  
> -		int could_be_checkout_paths = !has_dash_dash &&
> +		int could_be_checkout_paths = !expect_commit_only &&
>  			check_filename(opts->prefix, arg);
>  
> -		if (!has_dash_dash && !no_wildcard(arg))
> +		if (!expect_commit_only && !no_wildcard(arg))
>  			recover_with_dwim = 0;
>  
>  		/*
> @@ -1242,7 +1245,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>  		}
>  
>  		if (!recover_with_dwim) {
> -			if (has_dash_dash)
> +			if (expect_commit_only)
>  				die(_("invalid reference: %s"), arg);
>  			return 0;
>  		}
> @@ -1253,7 +1256,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>  	if (!opts->source_tree)                   /* case (1): want a tree */
>  		die(_("reference is not a tree: %s"), arg);
>  
> -	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
> +	if (!expect_commit_only) {	/* case (3).(d) -> (1) */
>  		/*
>  		 * Do not complain the most common case
>  		 *	git checkout branch
