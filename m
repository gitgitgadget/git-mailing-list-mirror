Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CD4C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 16:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiCRQw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbiCRQwz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 12:52:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2BC70CC1
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:51:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 818C71047CD;
        Fri, 18 Mar 2022 12:51:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tdtn9NaSyR0r1cPy51cHNcwW/skXyKoAPjAdz2
        Yp5HQ=; b=yFnCJl1hMnYXnJtMonM+76MgDGzTKkK6qUeVWaQizKTHhfSHKL5Lpy
        6wUH/ddiF5i95OwgDmtWhWRk6uFP0Wpfz3U4+7JshwuAULPRvIKb3nsE1/J0HXNK
        MZ69w5oe+5clSP0bcxgmBzIxdTD5adFfcIunNKJEA4ijmMy8vzG+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7938F1047CC;
        Fri, 18 Mar 2022 12:51:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E14D01047CB;
        Fri, 18 Mar 2022 12:51:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael McClimon <michael@mcclimon.org>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v5 1/2] rebase: use test_commit helper in setup
References: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
        <pull.1226.v5.git.git.1647611643.gitgitgadget@gmail.com>
        <9dbd2ba430aa481bc7de69dd51bd89aeafd9e208.1647611643.git.gitgitgadget@gmail.com>
Date:   Fri, 18 Mar 2022 09:51:30 -0700
In-Reply-To: <9dbd2ba430aa481bc7de69dd51bd89aeafd9e208.1647611643.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Fri, 18 Mar 2022 13:54:02
        +0000")
Message-ID: <xmqq7d8rb3vx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9DAE16A-A6DB-11EC-80F0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> To prepare for the next commit that will test rebase with oids instead
> of branch names, update the rebase setup test to add a couple of tags we
> can use. This uses the test_commit helper so we can replace some lines
> that add a commit manually.
>
> Setting logAllRefUpdates is not necessary because it's on by default for
> repositories with a working tree.
>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t3400-rebase.sh | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Looks much simpler and obviously correct ;-)

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 71b1735e1dd..0643d015255 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=bogus@email@address
>  export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
>  
>  test_expect_success 'prepare repository with topic branches' '
> -	git config core.logAllRefUpdates true &&
> -	echo First >A &&
> -	git update-index --add A &&
> -	git commit -m "Add A." &&
> +	test_commit "Add A." A First First &&
>  	git checkout -b force-3way &&
>  	echo Dummy >Y &&
>  	git update-index --add Y &&
> @@ -32,9 +29,7 @@ test_expect_success 'prepare repository with topic branches' '
>  	git mv A D/A &&
>  	git commit -m "Move A." &&
>  	git checkout -b my-topic-branch main &&
> -	echo Second >B &&
> -	git update-index --add B &&
> -	git commit -m "Add B." &&
> +	test_commit "Add B." B Second Second &&
>  	git checkout -f main &&
>  	echo Third >>A &&
>  	git update-index A &&
