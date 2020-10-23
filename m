Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E7C55179
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D54A241A3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C0mrrZUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465775AbgJWQsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:48:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62498 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460892AbgJWQsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:48:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA2098ADD4;
        Fri, 23 Oct 2020 12:48:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OXA3tjyfG32Trx4Ti2FQXv4rxjs=; b=C0mrrZ
        Ua/WXaH9f1tvyKE9jS3RHlz/0fl4qfSHk9XKpTJCVYUmMpG41gCPeZT6U5aD2lxK
        dAU2L8Nl3QQ+e7w8g9vodVa4c7yVH43rfh/lMsYJkp/ZZ1jIkHMiSVcEZsqpsD0b
        ejBby7eyhxn6qmTNW7gEcyfZnBSwQzR+TCmLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L3LdWcrpv4jcml688IuK3F8Tk/72/Bqd
        JxwcP3oZr7+ntlwHth03H4c7t7zsOh8DPY0Q7WuopTzcu+nT26Qg3Q9cBp5l13VT
        J+c5ivulGEfvXUFgn4O0NHKjRb6pbA8rTYC3X07Sv05sBmasOGzab0gVQG9GQfZf
        NPh3dg9eIOA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C07A38ADD2;
        Fri, 23 Oct 2020 12:48:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 375348ADD1;
        Fri, 23 Oct 2020 12:48:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/9] t/: new helper for tests that pass with ort but
 fail with recursive
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 09:48:11 -0700
In-Reply-To: <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 23 Oct 2020
        16:01:16 +0000")
Message-ID: <xmqqr1pohos4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89BDE176-154F-11EB-A711-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> There are a number of tests that the "recursive" backend does not handle
> correctly but which the redesign in "ort" will.  Add a new helper in
> lib-merge.sh for selecting a different test expectation based on the
> setting of GIT_TEST_MERGE_ALGORITHM, and use it in various testcases to
> document which ones we expect to fail under recursive but pass under
> ort.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/lib-merge.sh                         | 15 +++++++++++++++
>  t/t6416-recursive-corner-cases.sh      | 11 ++++++-----
>  t/t6422-merge-rename-corner-cases.sh   |  7 ++++---
>  t/t6423-merge-rename-directories.sh    | 13 +++++++------
>  t/t6426-merge-skip-unneeded-updates.sh |  3 ++-
>  t/t6430-merge-recursive.sh             |  3 ++-
>  6 files changed, 36 insertions(+), 16 deletions(-)
>  create mode 100644 t/lib-merge.sh
>
> diff --git a/t/lib-merge.sh b/t/lib-merge.sh
> new file mode 100644
> index 0000000000..fac2bc5919
> --- /dev/null
> +++ b/t/lib-merge.sh
> @@ -0,0 +1,15 @@
> +# Helper functions used by merge tests.
> +
> +test_expect_merge_algorithm () {
> +	status_for_recursive=$1
> +	shift
> +	status_for_ort=$1
> +	shift

Smaller than minor, but I'd find

	status_for_recursive=$1 status_for_ort=$2
	shift 2

easier to see that which one is for which by matching the order in
which the calling sites, e.g.

	test_expect_merge_algorithm success failure \
		here comes the commands being tested

lists them.

> +	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> +	then
> +		test_expect_${status_for_ort} "$@"
> +	else
> +		test_expect_${status_for_recursive} "$@"
> +	fi

I expect this to be purely transitory, so it is fine.  If not,
something along the lines of ...

	eval test_expect='$'status_for_"$GIT_TEST_MERGE_ALGORITHM"
	$test_expect "$@"

... might be what I would suggest, though ;-).

And the users are just too pleasant to see, with full of "failure
sucess", which is the second best outcome we want to see ;-)

> +test_expect_merge_algorithm failure success 'check symlink mo...
> +test_expect_merge_algorithm failure success 'check symlink ad...
> +test_expect_merge_algorithm failure success 'check submodule ...
> +test_expect_merge_algorithm failure success 'check submodule ...
> +test_expect_merge_algorithm failure success 'check conflictin...
> +test_expect_merge_algorithm failure success 'rad-check: renam...
> +test_expect_merge_algorithm failure success 'rrdd-check: rena...
> +test_expect_merge_algorithm failure success 'mod6-check: chai...
> +test_expect_merge_algorithm failure success '6b1: Same rename...
> +test_expect_merge_algorithm failure success '6b2: Same rename...
> +test_expect_merge_algorithm failure success '10e: Does git co...
> +test_expect_merge_algorithm failure success '12b1: Moving two...
> +test_expect_merge_algorithm failure success '12c1: Moving one...
> +test_expect_merge_algorithm failure success '12f: Trivial dir...
> +test_expect_merge_algorithm failure success '4a: Change on A,...
> +test_expect_merge_algorithm failure success 'merge-recursive ...
