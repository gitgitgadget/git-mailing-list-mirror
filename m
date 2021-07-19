Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AB8C6379C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05FF6115B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376597AbhGSWZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:25:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59992 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388360AbhGSUyh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 16:54:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1ADDC9696;
        Mon, 19 Jul 2021 17:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+55qNF1YuMT/1EvaCBRUkIF//qtoWLJsE+SJaZ
        3EJmo=; b=MFfNXlFNI/6CAvb/BRymNd0uBsKyVzNfVGnvOn5KYoAj1R6G7iWWqe
        w0vQP7jxgHyATt2Agkq0/A7ZRpFvlsYFvm0pcrQ77CPP9owsUFY/tyZMBb4yP2/k
        u+Chree2X8TvxPTg6AUjrGGStOihGEAbe/BSxsGq1yYOEC9aiWVeI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9914C9695;
        Mon, 19 Jul 2021 17:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3ECF1C9694;
        Mon, 19 Jul 2021 17:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 4/6] t7509: use git-update-ref rather than filesystem
 access
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <94d7e144f54c423c865dcd475b042469f07f4221.1626718050.git.gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 14:35:09 -0700
In-Reply-To: <94d7e144f54c423c865dcd475b042469f07f4221.1626718050.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Jul 2021
        18:07:28 +0000")
Message-ID: <xmqqv956j8c2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 319BC0FE-E8D9-11EB-88AF-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t7509-commit-authorship.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This seems identical to one of the commits in hn/refs-test-cleanup
that has already been merged to 'master', so I'll drop this copy.

Thanks.


> diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
> index ee6c47416ed..d568593382c 100755
> --- a/t/t7509-commit-authorship.sh
> +++ b/t/t7509-commit-authorship.sh
> @@ -147,7 +147,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
>  	test_tick &&
>  	git commit -am "cherry-pick 1" --author="Cherry <cherry@pick.er>" &&
>  	git tag cherry-pick-head &&
> -	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
> +	git update-ref CHERRY_PICK_HEAD $(git rev-parse cherry-pick-head) &&
>  	echo "This is a MERGE_MSG" >.git/MERGE_MSG &&
>  	echo "cherry-pick 1b" >>foo &&
>  	test_tick &&
> @@ -162,7 +162,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
>  '
>  
>  test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
> -	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
> +	git update-ref CHERRY_PICK_HEAD $(git rev-parse cherry-pick-head) &&
>  	echo "cherry-pick 2" >>foo &&
>  	test_tick &&
>  	git commit -am "cherry-pick 2" --reset-author &&
