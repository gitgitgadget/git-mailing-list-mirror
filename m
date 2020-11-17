Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F3C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957672072C
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hxy+IQGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKQGT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 01:19:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65143 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQGT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 01:19:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AE8A99CC4;
        Tue, 17 Nov 2020 01:19:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hle1Jc+T0fSawo6MyEhOV+FSI0E=; b=Hxy+IQ
        GpGPDq16WT/O9I76Yf7/IGqmG2j1mpdF9pez0D8lEHsQwXIC+FXQTw2MgiaiMmWg
        9CVJMhOOvFZyCaxn6Gpee3czCeO5LGfer84q6S8/aWJ7kFOge8gUg95zOLiUZQaa
        zlzMUwJXBEiVkWCZPKgjgrA7q0QkC4RwDH6m0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VT+G+sqn2/+aMRjAUXavdzTaOcshUaTL
        XHHx7injh7oED4jr7R/xkkpEy27ZYJQP1Avav9dfrN7fIGkaZkw+zgxrIW4eNatq
        veACCOcjfDkd065tf8kE2JuMrTq88/uiNR06bEhsAA1/BEmtGwuVbh+m+MP6Ns5Q
        5Tzxr8n6j8U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40B2499CC3;
        Tue, 17 Nov 2020 01:19:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFC1C99CC2;
        Tue, 17 Nov 2020 01:19:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid using the deprecated `set-env` construct
References: <pull.781.git.1604712106219.gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 22:19:21 -0800
In-Reply-To: <pull.781.git.1604712106219.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sat, 07 Nov 2020 01:21:45
        +0000")
Message-ID: <xmqq8sb07bfa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4F8ED60-289C-11EB-B015-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `set-env` construct was deprecated as of the announcement in
> https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/
> ...
> diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
> index 9d070b9cdf..c74b47de9e 100644
> --- a/.github/workflows/check-whitespace.yml
> +++ b/.github/workflows/check-whitespace.yml
> @@ -14,7 +14,7 @@ jobs:
>      steps:
>      - name: Set commit count
>        shell: bash
> -      run: echo "::set-env name=COMMIT_DEPTH::$((1+$COMMITS))"
> +      run: echo "COMMIT_DEPTH=$((1+$COMMITS))" >>$GITHUB_ENV
>        env:
>          COMMITS: ${{ github.event.pull_request.commits }}

Do we need something similar for ci/print-test-failures.sh to
prevent failures like https://github.com/git/git/runs/1409815807?

Perhaps like the following (which is copied-and-pasted without
understanding what is going on or without doing nothing more than
skimming [*1*])?


Reference

*1* https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-commands-for-github-actions#setting-an-environment-variable


 ci/print-test-failures.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/ci/print-test-failures.sh w/ci/print-test-failures.sh
index 92a983a265..c70d6cdbf2 100755
--- c/ci/print-test-failures.sh
+++ w/ci/print-test-failures.sh
@@ -48,7 +48,7 @@ do
 			;;
 		github-actions)
 			mkdir -p failed-test-artifacts
-			echo "::set-env name=FAILED_TEST_ARTIFACTS::t/failed-test-artifacts"
+			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 			continue

