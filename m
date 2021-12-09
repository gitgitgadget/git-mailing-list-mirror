Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596CBC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhLITek (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:34:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58674 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLITej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:34:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BD38F43BA;
        Thu,  9 Dec 2021 14:31:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CTxmv4kFKnsXXZvADyey1/fQdn8W1AWtbb9Zx0
        Ny2Cs=; b=Hb1aSLx9IVZC7biaBnqSDE7aGHf2k0vkgxpQACddNGC5h5Zlm3EU2y
        LuY+UmyiAQcovT28yXLQ55d22bMzukhIfiOnUwmktHWfishbYowSmZPFhuM0khTq
        P1uHNDwLQp94ph4m5rY3p5jNlW0zKHgrdZ4h6zp+g2A1GZ9m9A/nI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B388F43B9;
        Thu,  9 Dec 2021 14:31:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D0ECF43B6;
        Thu,  9 Dec 2021 14:31:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 11/14] reset_head(): take struct rebase_head_opts
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <24b0566aba5d8800d209261a14aca4d872af8027.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 11:31:02 -0800
In-Reply-To: <24b0566aba5d8800d209261a14aca4d872af8027.1638975482.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 08 Dec 2021 14:57:58
        +0000")
Message-ID: <xmqq7dcdr2x5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C0BB7E8-5926-11EC-BCE7-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This function takes a confusingly large number of parameters which
> makes it difficult to remember which order to pass them in. The
> following commits will add a couple more parameters which makes the
> problem worse. To address this change the function to take a struct of
> options. Using a struct means that it is no longer necessary to
> remember which order to pass the parameters in and anyone reading the
> code can easily see which value is passed to each parameter.

OK.  The documentation for members in the structure will serve as
the user manual for the reset_head() function.  Good.

> +struct reset_head_opts {
> +	/*
> +	 * The commit to checkout/reset to. Defaults to HEAD.
> +	 */
> +	const struct object_id *oid;
> +	/*
> +	 * Optional branch to switch to.
> +	 */
> +	const char *branch;
> +	/*
> +	 * Flags defined above.
> +	 */
> +	unsigned flags;
> +	/*
> +	 * Optional reflog message for HEAD, if this omitted but oid or branch
> +	 * are given then default_reflog_action must be given.
> +	 */

If we can enforce such a requirement in reset_head() implementation
with "if (condition) BUG(...)", we should do so to catch mistakes.

Thanks.  Looking good.

