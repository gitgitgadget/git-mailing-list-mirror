Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BB0C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B661207FD
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i12Kb009"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgBTWqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:46:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50493 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBTWqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:46:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A02D7AA96F;
        Thu, 20 Feb 2020 17:46:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Go8MTukiiCEwVmzk8aIlO2EX3tM=; b=i12Kb0
        09qJ0UiQglexeqOPDnyMvwVJTGMNmfHmGfHlqYmWZ5a0jf6cc2ItD7MBV4gPirux
        /AdnmzwsXgE2xjellWTEHn9eQaFy+/qa0uCnF/AJ8yA3FSuFgJjah54cZxhvOVCp
        mfECcjbBsgyv3iquw14jVthgVrmlNrmVC6SeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B8vqhgFu+/tCheaEbSr5KbWYeWcGwdhO
        2qCpHckWpAO+U6+1Sf41senDUZZaVUC4p0v/Q3ge7NRjAPA7bl3IJIIblE2psNun
        1ZkJ0XmOJaFJX0e8lTNraqb0wcGBFDt4VFYAQNDTCh7VHmWIHuYznh70CV6cuI+K
        F4vdBngvgv8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97CF6AA96E;
        Thu, 20 Feb 2020 17:46:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EABAFAA96D;
        Thu, 20 Feb 2020 17:46:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] sparse-checkout: allow one-character directories in cone mode
References: <pull.558.git.1582229226637.gitgitgadget@gmail.com>
Date:   Thu, 20 Feb 2020 14:46:00 -0800
In-Reply-To: <pull.558.git.1582229226637.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 20 Feb 2020 20:07:06
        +0000")
Message-ID: <xmqqk14g98t3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5ACEE36-5432-11EA-B55B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> In 9e6d3e64 (sparse-checkout: detect short patterns, 2020-01-24), a
> condition on the minimum length of a cone-mode pattern was introduced.
> However, this condition was off-by-one.
>
> If we have a directory with a single character, say "b", then the
> command
>
> 	git sparse-checkout set b
>
> will correctly add the pattern "/b/" to the sparse-checkout file. When
> this is interpeted in dir.c, the pattern is "/b" with the
> PATTERN_FLAG_MUSTBEDIR flag. This string has length two, which satisfies
> our inclusive inequality (<= 2).
>
> The reason for this inequality is that we will start to read the pattern
> string character-by-character using three char pointers: prev, cur,
> next. In particular, next is set to the current pattern plus two. The
> mistake was that next will still be a valid pointer when the pattern
> length is two, since the string is null-terminated.
>
> Make this inequality strict so these patterns work.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     sparse-checkout: allow one-character directories in cone mode
>     
>     This is based on ds/sparse-add.
>     
>     I discovered this while taking v2.25.1 and ds/sparse-add into our fork
>     of Git and testing it with Scalar.
>     
>     Off-by-one errors are tricky, sometimes.

Indeed, and thanks for a quick fix.

>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-558%2Fderrickstolee%2Fsparse-short-pattern-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-558/derrickstolee/sparse-short-pattern-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/558
>
>  dir.c                              |  2 +-
>  t/t1091-sparse-checkout-builtin.sh | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 7ac0920b713..a87900d43a2 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -682,7 +682,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
>  		return;
>  	}
>  
> -	if (given->patternlen <= 2 ||
> +	if (given->patternlen < 2 ||
>  	    *given->pattern == '*' ||
>  	    strstr(given->pattern, "**")) {
>  		/* Not a cone pattern. */
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index c35cbdef454..b4c9c32a037 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -417,10 +417,20 @@ test_expect_success 'pattern-checks: too short' '
>  	cat >repo/.git/info/sparse-checkout <<-\EOF &&
>  	/*
>  	!/*/
> -	/a
> +	/
>  	EOF
>  	check_read_tree_errors repo "a" "disabling cone pattern matching"
>  '
> +test_expect_success 'pattern-checks: not too short' '
> +	cat >repo/.git/info/sparse-checkout <<-\EOF &&
> +	/*
> +	!/*/
> +	/b/
> +	EOF
> +	git -C repo read-tree -mu HEAD 2>err &&
> +	test_must_be_empty err &&
> +	check_files repo a
> +'
>  
>  test_expect_success 'pattern-checks: trailing "*"' '
>  	cat >repo/.git/info/sparse-checkout <<-\EOF &&
>
> base-commit: ef07659926f64d70e8cb41025c3d7456eecb962e
