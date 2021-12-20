Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56828C4332F
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhLTVJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:09:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65477 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhLTVJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 16:09:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD3A210FD21;
        Mon, 20 Dec 2021 16:09:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zg0hMQMQbd2dkMniL29oy8zZpqZ8q79Piuy+Fa
        yI14M=; b=pdxMSN28zXJ+e2GvMow4PDQLAMdbSSs27Mmo7wOqizE5vNDnBC4Qxo
        jZeKqZ977pqpyFFgmyl+G0LxkVySeRqi6xrQsaEvcWJoTSqQ621LAgA8B2Z7+Y3N
        bi1dOcYdn00wNeX2yPVPGMuA67YGvEwH0n5SblWrJFeKU6gCMvSqs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4DF610FD20;
        Mon, 20 Dec 2021 16:09:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17C1A10FD1F;
        Mon, 20 Dec 2021 16:09:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] t3701: clean up hunk splitting tests
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
        <cc8639fc29db18da00ba2a95a1305efc3ea24205.1640010777.git.gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 13:09:53 -0800
In-Reply-To: <cc8639fc29db18da00ba2a95a1305efc3ea24205.1640010777.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 20 Dec 2021 14:32:56
        +0000")
Message-ID: <xmqqczlrugny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E1E4E8C-61D9-11EC-A3CF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Clean up some test constructs in preparation for extending the tests
> in the next commit. There are three small changes, I've grouped them
> together as they're so small it didn't seem worth creating three
> separate commits.
>  1 - "cat file | sed expression" is better written as
>      "sed expression file".
>  2 - Follow our usual practice of redirecting the output of git
>      commands to a file rather than piping it into another command.
>  3 - Use test_write_lines rather than 'printf "%s\n"'.

All good points.  Somehow people seem to forget "do not cat a single
file into a pipe".

> @@ -373,9 +373,9 @@ test_expect_success 'setup expected' '
>  test_expect_success 'add first line works' '
>  	git commit -am "clear local changes" &&
>  	git apply patch &&
> -	printf "%s\n" s y y | git add -p file 2>error |
> -		sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
> -		       -e "/^[-+@ \\\\]"/p  >output &&
> +	test_write_lines s y y | git add -p file 2>error >raw-output &&
> +	sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
> +	       -e "/^[-+@ \\\\]"/p raw-output >output &&

Looks good.  Thanks.
