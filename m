Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3171C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 20:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiF1Uok (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiF1Uog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 16:44:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0A24BF5
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 13:44:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 253021981C6;
        Tue, 28 Jun 2022 16:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=82a0OzFLXRbN0Ds/26tMQ60RrgRax+ShG28hfy
        GTBng=; b=rtnJKv5kulLSfbezNjXUlgSOXfmpQ8eagnK388fPub2wq2tQw8TlgE
        ESM2JNXQhH6QQtDKqcZHwB5t4jOozdkLVGXDMTzcPzRSdOl8cecJKphrHESkPA7z
        iOnvS0k0gl5n67sCoZGDiJ8VqnDqUgtepSllh3pBIoCkK0FFSX5pw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1CEF41981C5;
        Tue, 28 Jun 2022 16:44:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9853C1981C1;
        Tue, 28 Jun 2022 16:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 1/8] t2407: test branches currently using apply backend
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <fbaedc7f1f02efec251cb4df665fd3cb71f1d3b3.1656422759.git.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:44:29 -0700
In-Reply-To: <fbaedc7f1f02efec251cb4df665fd3cb71f1d3b3.1656422759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 28 Jun 2022
        13:25:52 +0000")
Message-ID: <xmqqtu84iklu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BF25BE2-F723-11EC-9159-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The tests in t2407 that verify the branch_checked_out() helper in the
> case of bisects and rebases were added by 9347303db89 (branch: check for
> bisects and rebases, 2022-06-08). However, that commit failed to check
> for rebases that are using the 'apply' backend.
>
> Add a test that checks the apply backend. The implementation was already
> correct here, but it is good to have regression tests before modifying
> the implementation further.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/t2407-worktree-heads.sh | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> index b6be42f74a2..4f59bc21303 100755
> --- a/t/t2407-worktree-heads.sh
> +++ b/t/t2407-worktree-heads.sh
> @@ -54,7 +54,18 @@ test_expect_success 'refuse to overwrite: worktree in bisect' '
>  	grep "cannot force update the branch '\''fake-2'\'' checked out at.*wt-4" err
>  '
>  
> -test_expect_success 'refuse to overwrite: worktree in rebase' '
> +test_expect_success 'refuse to overwrite: worktree in rebase (apply)' '
> +	test_when_finished rm -rf .git/worktrees/wt-*/rebase-apply &&
> +
> +	mkdir -p .git/worktrees/wt-3/rebase-apply &&
> +	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-apply/head-name &&
> +	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-apply/onto &&
> +
> +	test_must_fail git branch -f fake-1 HEAD 2>err &&
> +	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
> +'
> +
> +test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
>  	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
>  
>  	mkdir -p .git/worktrees/wt-3/rebase-merge &&

This is not the first offender, since the other existing one is
doing the same, but it is a bit sad that this makes it worse to
expose and depend on the details of the way the rebase happens to be
currently implemented.

Perhaps a more kosher way to do this is to find an commit that
surely would not allow fake-1 branch to be cleanly rebased onto and
actually start (and cause it to stop) a rebase.

I notice that the original offence was committed fairly recently, by
d2ba271a (branch: check for bisects and rebases, 2022-06-14) that we
can easily eject out of the 'next' branch when we rewind and rebuild
it, if we wanted to.

Anyway, let's read on.

Thanks.
