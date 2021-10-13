Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0127C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997A861100
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbhJMRh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:37:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63283 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhJMRh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 13:37:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60AD814CF1D;
        Wed, 13 Oct 2021 13:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6pf3mbHUeBlqRMCqUWJhErCB1TcFVJYRogN68C
        9vrLY=; b=iFdjiIUJQ+VHqWvZMvXddb9VvYTSgo/+ervg/60GIQzss4DH0zumNv
        pNeW/XuoY0xU5B7PE54Y2fpxpAFmAzgW6+7lAKNHwTzrqsTGz6XIZKx0Rw7Se2N6
        dtOl3ZCqhSSMYoMw7jJlPKF/U/c1T4//c6ugVlJSXJXCRZek3vaBQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5926014CF1C;
        Wed, 13 Oct 2021 13:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD89D14CF1A;
        Wed, 13 Oct 2021 13:35:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(windows): ensure that we do not pick up random
 executables
References: <pull.1057.git.1634129748874.gitgitgadget@gmail.com>
Date:   Wed, 13 Oct 2021 10:35:50 -0700
In-Reply-To: <pull.1057.git.1634129748874.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 13 Oct 2021 12:55:48
        +0000")
Message-ID: <xmqqpms8hlop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02CEED80-2C4C-11EC-BC9B-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>     Note: I based this on the earliest topic where it would apply without
>     merge conflicts, js/ci-windows-update (which is unfortunately quite
>     recent, it is not reachable from any version older than v2.33.0).

So do you want this forked from v2.33.0 (and merged to 'maint' so
that v2.33.2, if we need to issue it, would have it)?

https://github.com/git/git/actions/runs/1334961399 is the CI/PR run
on v2.33.1 from yesterday.  Our PATH wasn't contaminated and we
didn't see the problem you fixed here by mere luck, and you were
unlucky when you ran the same for generating your release material?

Thanks.

> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1057/dscho/work-around-windows-ci-failures-with-gpg-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1057
>
>  .github/workflows/main.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 0f7516c9ef3..2a6d68718ae 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -88,7 +88,7 @@ jobs:
>        env:
>          HOME: ${{runner.workspace}}
>          NO_PERL: 1
> -      run: ci/make-test-artifacts.sh artifacts
> +      run: . /etc/profile && ci/make-test-artifacts.sh artifacts
>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts
> @@ -115,7 +115,7 @@ jobs:
>      - uses: git-for-windows/setup-git-for-windows-sdk@v1
>      - name: test
>        shell: bash
> -      run: ci/run-test-slice.sh ${{matrix.nr}} 10
> +      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
>      - name: ci/print-test-failures.sh
>        if: failure()
>        shell: bash
> @@ -199,7 +199,7 @@ jobs:
>        env:
>          NO_SVN_TESTS: 1
>          GIT_TEST_SKIP_REBASE_P: 1
> -      run: ci/run-test-slice.sh ${{matrix.nr}} 10
> +      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
>      - name: ci/print-test-failures.sh
>        if: failure()
>        shell: bash
>
> base-commit: d681d0dc3a77016caa7e26abfe734afbdab44de5
