Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E267A1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfGAVBI (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:01:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62859 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:01:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0C8F6FC60;
        Mon,  1 Jul 2019 17:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l4BTY+vhDZIWsrjYdz92PNBvGow=; b=dJMujt
        vzwTPzQw3y1mzIaIY9kzu8TYDgyLE/+KNoafWl4QwPEG90rwJR3APxXVQZGkX27c
        iPD/B+QP+yTYLV6hN9Vdm236qEdsZQnpajcdYwgA44yOTcIRSRPdvzBajh0LUuWK
        ahJF6giYpg8dXxdrh+p+Rg0YlGisZYwLM2wlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wVBYdR2iGL1cT3+V1nXHwEFi2dXYhbjj
        VNl0WN/xeMCOl5hruFE8/TD6EYoMeHp7nFqxzXYnMG8dW0gPEsF00hpgJ4cMptnq
        nBw+6uCBsmxXYZzMt6sFpFOG4rY4agMNKldGzerZu59pSiQfATz+Q3zHuhnoF05X
        D4/kjFVM/+I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98DF96FC5D;
        Mon,  1 Jul 2019 17:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF0F36FC5C;
        Mon,  1 Jul 2019 17:01:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/1] t3420: remove progress lines before comparing output
References: <pull.276.git.gitgitgadget@gmail.com>
        <52501623f6b47447ce5da283ec11e378413899b7.1561986710.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Jul 2019 14:01:01 -0700
In-Reply-To: <52501623f6b47447ce5da283ec11e378413899b7.1561986710.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 01 Jul 2019 06:11:52
        -0700 (PDT)")
Message-ID: <xmqqimsl5v1u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 565F19D4-9C43-11E9-8503-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> progress output before comparing it to the expected output. We do this
> by removing everything before the final "\r" on each line as we don't
> care about the progress indicator, but we do care about what is printed
> immediately after it.

As long as sed implementation used here does not do anything funny
to CR, I think the approach to strip everything before the last CR
on the line is sensible.  As I am not familiar with how Windows port
of sed wants to treat a CR byte in the pattern, I am not sure about
the precondition of the above statement, though.

I also have to wonder if we can/want to do this without an extra
printf process every time we sanitize the output, though I do not
think I care too deeply about it.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3420-rebase-autostash.sh | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index 9186e90127..0454018584 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -48,8 +48,8 @@ create_expected_success_interactive () {
>  	q_to_cr >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>  	HEAD is now at $(git rev-parse --short feature-branch) third commit
> -	Rebasing (1/2)QRebasing (2/2)QApplied autostash.
> -	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
> +	Applied autostash.
> +	Successfully rebased and updated refs/heads/rebased-feature-branch.
>  	EOF
>  }
>  
> @@ -67,13 +67,13 @@ create_expected_failure_am () {
>  }
>  
>  create_expected_failure_interactive () {
> -	q_to_cr >expected <<-EOF
> +	cat >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>  	HEAD is now at $(git rev-parse --short feature-branch) third commit
> -	Rebasing (1/2)QRebasing (2/2)QApplying autostash resulted in conflicts.
> +	Applying autostash resulted in conflicts.
>  	Your changes are safe in the stash.
>  	You can run "git stash pop" or "git stash drop" at any time.
> -	Q                                                                                QSuccessfully rebased and updated refs/heads/rebased-feature-branch.
> +	Successfully rebased and updated refs/heads/rebased-feature-branch.
>  	EOF
>  }
>  
> @@ -109,7 +109,8 @@ testrebase () {
>  			suffix=interactive
>  		fi &&
>  		create_expected_success_$suffix &&
> -		test_i18ncmp expected actual
> +		sed "$(printf "s/.*\\r//")" <actual >actual2 &&
> +		test_i18ncmp expected actual2
>  	'
>  
>  	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
> @@ -209,7 +210,8 @@ testrebase () {
>  			suffix=interactive
>  		fi &&
>  		create_expected_failure_$suffix &&
> -		test_i18ncmp expected actual
> +		sed "$(printf "s/.*\\r//")" <actual >actual2 &&
> +		test_i18ncmp expected actual2
>  	'
>  }
