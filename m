Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9F6C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiHSVeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiHSVeE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:34:04 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD4108F93
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:34:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3000413B586;
        Fri, 19 Aug 2022 17:34:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nXXVTzDbOVF98P+mOcXWP9nCtChxSLgq1Tiq0I
        sbqgs=; b=tYQRMCJvdiARH+hSuBQCuln+DEVXGrnPdq76FzKyBA/nbVU25iqnKt
        wxKdaV9PSPAV1PfKxKjDTQd/Jx93GpjoquyZGwX5pTy58ocRv0xF2EkesnMueENC
        Qh4aLrkYTgk5JJuBhXjMasoSMIjRgACcby11kYdByJ589cIGy/nGM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4E2C13B585;
        Fri, 19 Aug 2022 17:34:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D89E213B584;
        Fri, 19 Aug 2022 17:33:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/2] p0004: fix prereq declaration
References: <pull.1330.git.1660942149.gitgitgadget@gmail.com>
        <0e71792a718512089b94c0d5985db7fd8093c6a5.1660942149.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 14:33:58 -0700
In-Reply-To: <0e71792a718512089b94c0d5985db7fd8093c6a5.1660942149.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Fri, 19 Aug 2022 20:49:08
        +0000")
Message-ID: <xmqqfshrkjeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A33E5752-2006-11ED-9BDE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Fix multi-threaded 'p0004' test's use of the 'REPO_BIG_ENOUGH_FOR_MULTI'
> prerequisite. Unlike normal 't/' tests, 't/perf/' tests need to have their
> prerequisites declared with the '--prereq' flag.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/perf/p0004-lazy-init-name-hash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  It is unfortunate that we need to live with this seemingly
unnecessary deviation.

> diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
> index 1afc08fe7f1..85be14e4ddb 100755
> --- a/t/perf/p0004-lazy-init-name-hash.sh
> +++ b/t/perf/p0004-lazy-init-name-hash.sh
> @@ -49,7 +49,7 @@ test_perf "single-threaded, $desc" "
>  	test-tool lazy-init-name-hash --single --count=$count
>  "
>  
> -test_perf REPO_BIG_ENOUGH_FOR_MULTI "multi-threaded, $desc" "
> +test_perf "multi-threaded, $desc" --prereq REPO_BIG_ENOUGH_FOR_MULTI "
>  	test-tool lazy-init-name-hash --multi --count=$count
>  "
