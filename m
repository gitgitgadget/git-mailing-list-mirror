Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57963C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D73D64F8F
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhBDTAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:00:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53784 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbhBDS7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:59:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 129E5A86E7;
        Thu,  4 Feb 2021 13:58:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MWVMDA8DNw8MVZGbEGfuT80xotU=; b=kRT8jR
        vqXhKAH9LB/Dh3U1UPMN1sFfOucp5IT88bOf62PPbw8RIJ6WHPs9LyY56of+Yg2v
        g3qzXfK5My+So73ZTivjOq71Fo1dXt/oHeAEZBdchjj/NO8KO1dFyxiTVqWLaXSH
        8LttGv9zQ5HeqcMjjbeSOGoakYSkdYKZJL3JY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ijMiTQ6IjdZGhqNeCVT/7Oa7RLEyqaI/
        93231SyuaB5T7P1m+4ZwlEXKRp+CUy2BlSt1aOkpF+WTWXRgo5aAhXYptFNf+1WX
        ePah4FT5Ir0wVInGWU4DB73RlIAGs6+GO6U10RhLWYEmH0Y2DQBbbEmmQepU2N4n
        gQPlS3KIM1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AFB0A86E6;
        Thu,  4 Feb 2021 13:58:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7FF10A86E5;
        Thu,  4 Feb 2021 13:58:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
        <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
        <448e6a64fa157990fcc973ce2fe4a9fc2ba1ab32.1612431093.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 10:58:29 -0800
In-Reply-To: <448e6a64fa157990fcc973ce2fe4a9fc2ba1ab32.1612431093.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 04 Feb 2021
        09:31:31 +0000")
Message-ID: <xmqqtuqr64oa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8C52940-671A-11EB-A0BF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +test_expect_success 'A^! and A^-<n> (unmodified)' '
> +	git range-diff --no-color topic^! unmodified^-1 >actual &&
> +	cat >expect <<-EOF &&
> +	1:  $(test_oid t4) = 1:  $(test_oid u4) s/12/B/
> +	EOF
> +	test_cmp expect actual
> +'

Now we actually parse the single-token range, instead of relying on
"does it have dot-dot" heuristics, we can make sure that we reject

    "HEAD^{/^string with .. in it}"

as "not a range with negative and positive ends".

