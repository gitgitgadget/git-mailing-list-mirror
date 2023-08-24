Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540A6C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 15:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjHXPMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbjHXPL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 11:11:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1331711
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 08:11:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF57F19E168;
        Thu, 24 Aug 2023 11:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a3tKiR7OHiWQus0pDOmB/tN7nK2dA4xzKxDRnj
        BHH58=; b=ghA3s6zcHZe7OSEDWWbiAMCKRJURmKozf1gF0/ldvIT6U49OwFgeaZ
        osalgFgkxXMc9yrqq9+x0D6ZoQ/45fwLBRw354DvH39LOXxbGE23+iWGK/tLvjCW
        6Ixp4GsuzTfdnPFyy18Wj4sqSEHRCnjpcpBnHijQ2MSrUgD3z48Qw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D640B19E166;
        Thu, 24 Aug 2023 11:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E27D19E164;
        Thu, 24 Aug 2023 11:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kevin Backhouse <kevinbackhouse@github.com>
Subject: Re: [PATCH v2 1/2] Regression test for
 https://github.com/gitgitgadget/git/pull/1577
References: <pull.1577.git.1692389061490.gitgitgadget@gmail.com>
        <pull.1577.v2.git.1692886365.gitgitgadget@gmail.com>
        <f940104a7814bd0b1e45f1230b2cb4b0be305699.1692886365.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Aug 2023 08:11:54 -0700
In-Reply-To: <f940104a7814bd0b1e45f1230b2cb4b0be305699.1692886365.git.gitgitgadget@gmail.com>
        (Kevin Backhouse via GitGitGadget's message of "Thu, 24 Aug 2023
        14:12:44 +0000")
Message-ID: <xmqqh6oocw5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FF08B0E-4290-11EE-9C25-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2 1/2] Regression test for https://github.com/gitgitgadget/git/pull/1577

We try to come up with titles that are helpful to readers when seen
in "git shortlog --since=6.months --no-merges", and the above does
not exactly it.

> From: Kevin Backhouse <kevinbackhouse@github.com>
>
> Signed-off-by: Kevin Backhouse <kevinbackhouse@github.com>
> ---
>  t/t9904-merge-leak.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100755 t/t9904-merge-leak.sh
>
> diff --git a/t/t9904-merge-leak.sh b/t/t9904-merge-leak.sh
> new file mode 100755
> index 00000000000..09a4474fd73
> --- /dev/null
> +++ b/t/t9904-merge-leak.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +#
> +
> +test_description='regression test for memory leak in git merge'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./lib-bash.sh
> +
> +# test-lib.sh disables LeakSanitizer by default, but we want it enabled
> +# for this test
> +ASAN_OPTIONS=
> +export ASAN_OPTIONS

You do not want to do this.

We have CI jobs that run everybody under asan, ubsan etc., so it is
sufficient and much more preferrable to just add a reproduction
recipe to an _existing_ test that is about "git merge" (or if we
have "ort" specific one, "git merge -s ort").  Of course they would
not fail in jobs that do not enable asan, and that is expected and
perfectly OK.

Also, please check Documentation/CodingGuidelines for shell style
issues.

> +. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"

Is this about testing prompts, or does the bug/leak appear only when
the prompt support is in use?  Could you explain why this is needed?

> +test_expect_success 'Merge fails due to local changes' '
> +	git init &&
> +	echo x > x.txt &&
> +	git add . &&
> +	git commit -m "WIP" &&
> +	git checkout -b dev &&
> +	echo y > x.txt &&
> +	git add . &&
> +	git commit -m "WIP" &&
> +	git checkout main &&
> +	echo z > x.txt &&
> +	git add . &&
> +	git commit -m "WIP" &&
> +	echo a > x.txt &&
> +	git add . &&
> +	echo "error: ''Your local changes to the following files would be overwritten by merge:''" >expected &&
> +	echo "  x.txt" >>expected &&
> +	echo "Merge with strategy ort failed." >>expected &&
> +	test_must_fail git merge -s ort dev 2>actual &&
> +	test_cmp expected actual
> +'

If this 1/2 adds a new test that is expected to fail without leak
fix, which has to wait until 2/2, it breaks the bisection.  In this
case, since it will be a simple addition to an existing test script,
having both tests and code changes in a single patch is the most
appropriate.

Thank you for working on this.


> +
> +test_done
