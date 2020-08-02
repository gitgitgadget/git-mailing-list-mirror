Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D035CC433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A064F2072A
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 18:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gltrFoV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHBSRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 14:17:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64077 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgHBSRu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 14:17:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79C757BE77;
        Sun,  2 Aug 2020 14:17:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tiPSVGqUHFha+mCSn2egnVoDOwE=; b=gltrFo
        V0DvW9mx0Hk+srHfJykhO8l1ro/Ga5SxZ4DGCuVUpWkwWCAjosvUK+X6G+lZqC3/
        rsJpGd4XnSIIUZWGjqbFZz1LGMi5uaRe1858qfyBvIe6yMrV+qnx7wYfcZD+DWKf
        +o35BHovSo6bkxsdn/1ItexO6gjyBPV4m6O/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dNU5UoqDuwQqA9g3gdeBg8uOl6kWyJJF
        6hLM+xDryu3buXVCCEepWDOkq7nn86Z+p6RDMbIEXfTKj7NQinjweRGhOulAKPZV
        dOPL6LfSjzOkQ/aRVLJxZe3FaG0skL3ecoS7ermXqBa2FJrn6M4I6+NdwlPcqvOP
        8zae9fhOaoo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70F4D7BE76;
        Sun,  2 Aug 2020 14:17:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01E0A7BE74;
        Sun,  2 Aug 2020 14:17:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] t6038: make tests fail for the right reason
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
        <361911817559104672d273e199221e8367e8d595.1596349986.git.gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 11:17:48 -0700
In-Reply-To: <361911817559104672d273e199221e8367e8d595.1596349986.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 02 Aug 2020
        06:33:03 +0000")
Message-ID: <xmqqime0syib.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78AE1318-D4EC-11EA-A58B-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> t6038 had a pair of tests that were expected to fail, but weren't
> failing for the expected reason.  Both were meant to do a merge that
> could be done cleanly after renormalization, but were supposed to fail
> for lack of renormalization.  Unfortunately, both tests has staged
> changes, and checkout -m would abort due to the presence of those staged
> changes before even attempting a merge.
>
> Fix this first issue by utilizing git-restore instead of git-checkout,
> so that the index is left alone and just the working directory gets the
> changes we want.

Nicely analysed.

> However, there is a second issue with these tests.  Technically, they
> just wanted to verify that after renormalization, no conflicts would be
> present.  This could have been checked for by grepping for a lack of
> conflict markers, but the test instead tried to compare the working
> directory files to an expected result.  Unfortunately, the setting of
> "text=auto" without setting core.eol to any value meant that the content
> of the file (in particular, the line endings) would be
> platform-dependent and the tests could only pass on some platforms.

OK.

> Replace the existing comparison with a call to 'git diff --no-index
> --ignore-cr-at-eol' to verify that the contents, other than possible
> carriage returns in the file, match the expected results and in
> particular that the file has no conflicts from the checkout -m
> operation.

Makes sense.

Thanks.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6038-merge-text-auto.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
> index 5e8d5fa50c..27cea15533 100755
> --- a/t/t6038-merge-text-auto.sh
> +++ b/t/t6038-merge-text-auto.sh
> @@ -168,9 +168,9 @@ test_expect_failure 'checkout -m after setting text=auto' '
>  	git rm -fr . &&
>  	rm -f .gitattributes &&
>  	git reset --hard initial &&
> -	git checkout a -- . &&
> +	git restore --source=a -- . &&
>  	git checkout -m b &&
> -	compare_files expected file
> +	git diff --no-index --ignore-cr-at-eol expected file
>  '
>  
>  test_expect_failure 'checkout -m addition of text=auto' '
> @@ -183,9 +183,9 @@ test_expect_failure 'checkout -m addition of text=auto' '
>  	git rm -fr . &&
>  	rm -f .gitattributes file &&
>  	git reset --hard initial &&
> -	git checkout b -- . &&
> +	git restore --source=b -- . &&
>  	git checkout -m a &&
> -	compare_files expected file
> +	git diff --no-index --ignore-cr-at-eol expected file
>  '
>  
>  test_expect_failure 'cherry-pick patch from after text=auto was added' '
