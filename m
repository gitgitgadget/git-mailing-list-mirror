Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF4FC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE0523A5A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yIgswtvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgI1XNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:13:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52572 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgI1XNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD238F0B59;
        Mon, 28 Sep 2020 17:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qZrvnH3xKOcF99MydXUpUgvLM5g=; b=yIgswt
        vE8P2t/n4v4afwddgknFRvJAcZtORp+mglp83lW5H12M1PQ39UXEaGMPMmf0XRSI
        LNuTvP7/k4Ukg3LA1Da5omIm89JWEv5oqjkUQ6vfQkrqSD41S80rtmYxAEpViPNE
        VHbA1aPCv6zUth9SpeN9NvfI3C5NU9VfX6jnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uYc8KNe65JrMeFZdy0M6DJTQx7o+cdE0
        S4xppWeARoHs/rV4cVsalRR7CgAuVIpW7iQDsQLlCfz8E6fc46ihBHfkVwclOdUT
        TsfrcsMWspcnRslUlv88GnLfhs0oF0Ijmk+Gr5hEMHZLBLDolS0nV2IPmtO5b0M2
        8UUCR6aPkj8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D58A1F0B58;
        Mon, 28 Sep 2020 17:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1617EF0B56;
        Mon, 28 Sep 2020 17:54:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] t2402: add test to locked linked worktree marker
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
        <20200928154953.30396-3-rafaeloliveira.cs@gmail.com>
Date:   Mon, 28 Sep 2020 14:54:24 -0700
In-Reply-To: <20200928154953.30396-3-rafaeloliveira.cs@gmail.com> (Rafael
        Silva's message of "Mon, 28 Sep 2020 15:49:53 +0000")
Message-ID: <xmqq3631lg8f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D169798-01D5-11EB-8B78-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> Test the output of the `worktree list` command to show when
> a linked worktree is locked and test to not mistakenly
> mark main or unlocked worktrees.
>
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
>  t/t2402-worktree-list.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

I think this should be part of [1/2], as the change necessary to
implement the new feature is small enough that there is no reason
to split the test part out.

> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> index 52585ec2aa..07bd9a3350 100755
> --- a/t/t2402-worktree-list.sh
> +++ b/t/t2402-worktree-list.sh
> @@ -61,6 +61,19 @@ test_expect_success '"list" all worktrees --porcelain' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'show locked worktree with (locked)' '
> +	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
> +	test_when_finished "rm -rf locked unlocked out actual expect && git worktree prune" &&
> +	git worktree add --detach locked master &&
> +	git worktree add --detach unlocked master &&
> +	git worktree lock locked &&
> +	echo "$(git -C locked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD) (locked)" >>expect &&
> +	echo "$(git -C unlocked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> +	git worktree list >out &&
> +	sed "s/  */ /g" <out >actual &&
> +	test_cmp expect actual
> +'

This seems to prescribe the output from the command too strictly
(you do avoid being overly too strict by removing the indentation
with 's/ */ /g' though).  

If the leading path to the $TRASH_DIRECTORY has two or more
consecutive SPs (and that is not something under our control), the
'expect' file would keep such a double-SP, but such a double-SP in
'out' would have been squashed out in the 'actual' file.

I wonder if

	grep '/locked  *[0-9a-f].* (locked)' out &&
	! grep '/unlocked  *[0-9a-f].* (locked)' out

might be a better way to test?  That is

 - we do not care what the leading directories are called
 - we do not care what branch is checked out or how they are presented
 - we care the one that ends with /locked is (locked)
 - we care the one that ends with /unlocked is not (locked)

After all, this new test piece is not about verifying that the
object name or branch name is correct.
