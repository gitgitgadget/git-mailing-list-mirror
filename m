Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2D8C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 18:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbiHDSJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 14:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiHDSI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 14:08:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0F86BD77
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 11:08:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 814F41BE427;
        Thu,  4 Aug 2022 14:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=20Q3ZnFuOrHb5QA7suEQszTupveQ3xy8c/7tCR
        QWCz0=; b=cZ+acs93gVKB2JLpDr2XBBn1tbF2duRZ5J3mOpyUDnJfkfA4uQ+ZQH
        i3iicQd32G1nJvs0+JW+QTzui75Ae57I/Yl6DnQCz5ZfBrVNoa1jRujItLoFzdA9
        DQND6mAY8vMAvav+0fnK2tGTTdgfoASW1DrMtaHhxHeYYwe6HaQpE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A4AF1BE426;
        Thu,  4 Aug 2022 14:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DAC41BE425;
        Thu,  4 Aug 2022 14:08:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] tests: cache glibc version check
References: <pull.1311.git.1659620305757.gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 11:08:52 -0700
In-Reply-To: <pull.1311.git.1659620305757.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Thu, 04 Aug 2022 13:38:25 +0000")
Message-ID: <xmqq4jyr6fuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FB8E744-1420-11ED-AEE6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> 131b94a10a ("test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_
> on glibc >= 2.34", 2022-03-04) introduced a check for the version of
> glibc that is in use. This check is performed as part of
> setup_malloc_check() which is called at least once for each test. As
> the test involves forking `getconf` and `expr` cache the result and
> use that within setup_malloc_check() to avoid forking these extra
> processes for each test.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     tests: cache glibc version check
>     
>     A recent discussion on the list[1] reminded me that this patch was
>     waiting to be sent.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1311%2Fphillipwood%2Fwip%2Ftest-cache-glibc-tunables-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1311/phillipwood/wip/test-cache-glibc-tunables-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1311
>
>  t/test-lib.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7726d1da88a..ad81c78fce7 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -557,14 +557,19 @@ then
>  		: nothing
>  	}
>  else
> +	_USE_GLIBC_TUNABLES=
> +	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> +	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> +	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> +	then
> +		_USE_GLIBC_TUNABLES=YesPlease
> +	fi
>  	setup_malloc_check () {
>  		local g
>  		local t
>  		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
>  		export MALLOC_CHECK_ MALLOC_PERTURB_
> -		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> -		   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> -		   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> +		if test -n "$_USE_GLIBC_TUNABLES"
>  		then
>  			g=
>  			LD_PRELOAD="libc_malloc_debug.so.0"

Between USE_LIBC_MALLOC_DEBUG, which is the name Peff originally
gave this intermediate variable, and the one you use here, I am
undecided.  If the only thing the GLIBC_TUNABLES mechanism can do
were to tweak the malloc checking, then both names are good, but
that is not the case.  We are only seeing if we are going to use the
malloc check feature given by glibc here, so the original name feels
more to the point, and use of GLIBC_TUNABLE mechanism to trigger
that malloc check feature is a mere implementation detail.

But that is minor.  Let's queue the patch to help me not to forget
about it, and we'll amend it if necessary, as we'd probably need a
helped-by or signed-off-by from Peff anyway before this hits 'next'.

Thanks.
