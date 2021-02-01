Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE1C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DBE64EC1
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhBAX00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:26:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56329 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhBAX0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 18:26:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6455AB4E90;
        Mon,  1 Feb 2021 18:25:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WgJnAydtcyUxsAZtQKf8TRpk9h0=; b=Rob+C6
        pB5gJ7z2HwDgE0rbc8X28zlhLTfgm44EjmHDTMLhl+PBbRHyd8CcCSNuxsyGOyvS
        o91bvqwfNLxX+DPmqb59qmh1F73GRCHDBfgfCN/rkax++GAd7VOwGY0wIY4qZgiq
        S0/Cd1HRlkUDxuD4m0jBkCMbhXsv5YfchK9FE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=viNIL/0ARuOnosRkDnMrwS/LwgXGB7RQ
        t4+Ge11d/b6swl0OPoQvjYf3rVSZRa4+Uk8bR91/IkXFkMzINogCzXdIbkLlTQpO
        6nz4hA0ZN9nDC8DPwB1TtZWUbcTHTnLn9R++dQcDCfAVFUpvxXOzOZl4RzEDT/+e
        O3uRsTv2/pE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B8FCB4E8F;
        Mon,  1 Feb 2021 18:25:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAB45B4E8E;
        Mon,  1 Feb 2021 18:25:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 01/11] p7519: use xargs -0 rather than -d in test
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <cf252e24b8c4da19ee9f886a1ab9c9c391d89d66.1612216941.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 15:25:40 -0800
In-Reply-To: <cf252e24b8c4da19ee9f886a1ab9c9c391d89d66.1612216941.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Mon, 01 Feb 2021
        22:02:10 +0000")
Message-ID: <xmqqsg6fid57.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC60407A-64E4-11EB-B370-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> The Mac version of xargs does not support the "-d" option.  Convert the test
> setup to pipe the data set thru `lf_to_nul | xargs -0` instead.

"xargs -0" is not all that portable, either, and neither is "touch -h".

But since the t/perf stuff already depends on having GNU toolchain
anyway, I can be persuaded to believe that it is OK.

Do we know that this part runs much later than the staged files are
last touched, so that these uses of "touch" actually are effective
to make the paths stat-dirty?  Otherwise, we may be just "touch"ing
them with the timestamp they already have after all.

Thanks.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 9b43342806b..7bb37e9a6c1 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -165,7 +165,7 @@ test_fsmonitor_suite() {
>  	'
>  
>  	test_perf_w_drop_caches "status (dirty) ($DESC)" '
> -		git ls-files | head -100000 | xargs -d "\n" touch -h &&
> +		git ls-files | head -100000 | lf_to_nul | xargs -0 touch -h &&
>  		git status
>  	'
