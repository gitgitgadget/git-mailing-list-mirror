Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D58FC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE692173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ehL301VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgBRV1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:27:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65404 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRV1e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 16:27:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 537F240244;
        Tue, 18 Feb 2020 16:27:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hjXJscJRlJ5UgGwOOWqVZaxZUrk=; b=ehL301
        VKC77TWKfoWaWtaiP1kqq9A+iaG/LB8C8t7bLwjXSjFP03onCfcBiecLT8T2pHs5
        suopDFp0gbd6Qm+ZKbCghaegy/v47gXppKrw1CekFAojS2/oaLc3ZclIHwDk0INS
        SguJBynDi2NqR2Xa07bN4p2TWjhB3y3ZOIw2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QuXsDMUvoOmaHl2XPwOyPwWv7QBDwx4O
        k1HtUUU5zGxjf7ReKum9vIwVAYSX2hoCLqvNgybYQdtOMQK96mG1sqMCjrCRHzvw
        dWPR/TTJGfrmmQQxWH0Qzg9VGFcBve0ahOhdJ3W7kfw1lWr/SsdUZlHozUvqkvot
        Hy6dYevspwY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C0F740243;
        Tue, 18 Feb 2020 16:27:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA34940242;
        Tue, 18 Feb 2020 16:27:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] check-ignore: fix documentation and implementation to match
References: <pull.711.git.git.1581956106255.gitgitgadget@gmail.com>
        <pull.711.v2.git.git.1582058162095.gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 13:27:31 -0800
In-Reply-To: <pull.711.v2.git.git.1582058162095.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 18 Feb 2020
        20:36:01 +0000")
Message-ID: <xmqqlfozio1o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79507858-5295-11EA-A404-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Since the second mode exists to find out which pattern matches given
> paths, and showing the user a pattern that begins with a '!' is
> sufficient for them to figure out whether the pattern is excluded, the
> existing behavior is desirable -- we just need to update the
> documentation to match the implementation (i.e. it is about printing
> which pattern is matched by paths, not about showing which paths are
> excluded).
>
> For the first or default mode, users just want to know whether a pattern
> is excluded.  As such, the existing documentation is desirable; change
> the implementation to match the documented behavior.
>
> Finally, also adjust a few tests in t0008 that were caught up by this
> discrepancy in how negated paths were handled.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ...
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index 8b2d49c79e1..85ef46e2eff 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -30,9 +30,15 @@ OPTIONS
>  	valid with a single pathname.
>  
>  -v, --verbose::
> -	Also output details about the matching pattern (if any)
> -	for each given pathname. For precedence rules within and
> -	between exclude sources, see linkgit:gitignore[5].
> +	Instead of printing the paths that are excluded, for each path
> +	that matches an exclude pattern print the exclude pattern

s/pattern print/pattern, print/;

> +	together with the path.  (Matching an exclude pattern usually
> +	means the path is excluded, but if the pattern begins with '!'
> +	then it is a negated pattern and matching it means the path is
> +	NOT excluded.)

Nicely and clearly written.

> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> index 5a4f92395f3..ea5d0ae3a6a 100644
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -108,6 +108,9 @@ static int check_ignore(struct dir_struct *dir,
>  			int dtype = DT_UNKNOWN;
>  			pattern = last_matching_pattern(dir, &the_index,
>  							full_path, &dtype);
> +			if (!verbose && pattern &&
> +			    pattern->flags & PATTERN_FLAG_NEGATIVE)
> +				pattern = NULL;

OK.

Thanks.  Will queue.
