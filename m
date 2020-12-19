Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38F3C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CA62395C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgLSSGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 13:06:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65168 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgLSSGC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 13:06:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29686117B18;
        Sat, 19 Dec 2020 13:05:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aTL+5ahZ+cv9FZnyeqgTOoeZzBc=; b=YXTpzp
        jU69LzFrE4WNeOmI84DLo5R4oEShhc2NekW0CJvUU4/+HAcjgBGEAGMcENvz9+Wb
        LeJFET+GVXLxRn91SaWHX8FTZR3RA+oHTdfbwPGZuWTWlT9qifKAK0dwKyEYR7mE
        WBzrBU1zdgvnutpOdBgpyanCJ9+rnxXc3dsLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z93ciAfYFNUeVfoXXLWeILQrZdjXXiV4
        H6hEyZDlRqEQrIcmOATDI9qUIPs0iDdWXHKjd9H/YF3Gk3mG6IH6J5zEofHWhcZv
        6Y8euycgkEFZN0BEaBsYWYs7U/hHepzbPIC3vhvx1u8OTxusVgcvKZ1hgq9tIsht
        6xeb5AdG1pY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10BE1117B17;
        Sat, 19 Dec 2020 13:05:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 47936117B13;
        Sat, 19 Dec 2020 13:05:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH] negative-refspec: fix segfault on : refspec
References: <pull.820.git.1608398598893.gitgitgadget@gmail.com>
Date:   Sat, 19 Dec 2020 10:05:14 -0800
In-Reply-To: <pull.820.git.1608398598893.gitgitgadget@gmail.com> (Nipunn
        Koorapati via GitGitGadget's message of "Sat, 19 Dec 2020 17:23:18
        +0000")
Message-ID: <xmqqy2htoen9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF71E144-4224-11EB-BC01-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> Previously, if remote.origin.push was set to ":",
> git would segfault during a push operation, due to bad
> parsing logic in query_matches_negative_refspec. Per
> bisect, the bug was introduced in:
> c0192df630 (refspec: add support for negative refspecs, 2020-09-30)
>
> Added testing for this case in fetch-negative-refspec

Thanks.

Our local convention in this project is to write about the
status-quo without the patch under discussion in the present tense,
and describe the fix as if we are giving orders to the codebase to
become like so (or giving orders to the monkeys sitting in front of
the keyboard to update the code).  I'd explain the "problem
description" part of the above perhaps like so:

	The logic added to check for negative pathspec match by
	c0192df630 (refspec: add support for negative refspecs,
	2020-09-30) looks at refspec->src assuming it never is NULL,
	but when remote.origin.push is set to ":" (i.e. "matching"),
	refspec->src is NULL, causing a segfauilt.
	
But stepping back a bit, a "matching" push is saying "if we have
branch 'hello', and they also have branch 'hello', push ours to
theirs".  So if the query is asking about 'hello' (e.g. needle is
'hello'), shouldn't a refspec ":" have the same effect as a refspec
"hello:hello", instead of getting ignored like this patch does?

Original author of the feature (Jacob) cc'ed for insight.

 - Can we have refspec->src==NULL in cases other than where
   refspec->matching is true?  If not, then perhaps the patch should
   insert, before the problematic "else if" clause, something like

		if (match_name_with_pattern(...))
			string_list_append_nodup(...);
   +	} else if (refspec->matching) {
   +		... behaviour for the matching case ...
   +	} else if (refspec->src == NULL) {
   +		BUG("refspec->src cannot be null here");
	} else {
		if (!strcmp(needle, refspec->src))

 - We'd need to decide if ignoring is the right behaviour for the
   matching refspec.  I do not recall what we decided the logic of
   the function should be offhand.

>     We found this issue when rolling out git 2.29 at Dropbox - as several
>     folks had "push = :" in their configuration. I based my diff off the
>     master branch, but also confirmed that it patches cleanly onto maint -
>     if the maintainers would like to also fix the segfault on 2.29

Yes, it is very much appreciated you were considerate to base the
patch on the maintenance track.  We want the code to do with the
right thing with ":" matching refspec.

> diff --git a/remote.c b/remote.c
> index 9f2450cb51b..8ab8d25294c 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -751,9 +751,8 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
>  
>  			if (match_name_with_pattern(key, needle, value, &expn_name))
>  				string_list_append_nodup(&reversed, expn_name);
> -		} else {
> -			if (!strcmp(needle, refspec->src))
> -				string_list_append(&reversed, refspec->src);
> +		} else if (refspec->src != NULL && !strcmp(needle, refspec->src)) {
> +			string_list_append(&reversed, refspec->src);
>  		}
>  	}
>  
> diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> index 8c61e28fec8..4960378e0b7 100755
> --- a/t/t5582-fetch-negative-refspec.sh
> +++ b/t/t5582-fetch-negative-refspec.sh
> @@ -186,4 +186,14 @@ test_expect_success "fetch --prune with negative refspec" '
>  	)
>  '
>  
> +test_expect_success "push with empty refspec" '

s/empty/matching/ (see "git push --help" and look for "The special
refspec :").

> +	(
> +		cd two &&
> +		git config remote.one.push : &&
> +		# Fails w/ tip behind counterpart - but should not segfault
> +		test_must_fail git push one master &&
> +		git config --unset remote.one.push
> +	)
> +'
> +
>  test_done
>
> base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
