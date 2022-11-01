Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D93AFA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 02:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKAC1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 22:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKAC1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 22:27:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F65D1DB
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 19:27:43 -0700 (PDT)
Received: (qmail 3979 invoked by uid 109); 1 Nov 2022 02:27:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 02:27:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18151 invoked by uid 111); 1 Nov 2022 02:27:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Oct 2022 22:27:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Oct 2022 22:27:42 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Message-ID: <Y2CEHvo0WyttNfVk@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <98fa5270cb720f2f038c4bb9571c7d306ff5d759.1667245639.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98fa5270cb720f2f038c4bb9571c7d306ff5d759.1667245639.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:47:18PM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 0b386c74818..b72cdeb6243 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -78,19 +78,19 @@ test_expect_success LIBCURL 'clone warns or fails when using username:password'
>  
>  	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@224.0.0.1 attempt2 2>err &&
>  	grep "warning: $message" err >warnings &&
> -	test_line_count = 2 warnings &&
> +	test_line_count -ge 1 warnings &&
>  
>  	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@224.0.0.1 attempt3 2>err &&
>  	grep "fatal: $message" err >warnings &&
> -	test_line_count = 1 warnings &&
> +	test_line_count -ge 1 warnings &&
>  
>  	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:@224.0.0.1 attempt3 2>err &&
>  	grep "fatal: $message" err >warnings &&
> -	test_line_count = 1 warnings
> +	test_line_count -ge 1 warnings
>  '
>  
>  test_expect_success LIBCURL 'clone does not detect username:password when it is https://username@domain:port/' '
> -	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
> +	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username@224.0.0.1:8080 attempt3 2>err &&
>  	! grep "uses plaintext credentials" err
>  '

By the way, this last part of the hunk obviously belongs in the first
patch. I adjusted as appropriate in the patch I just sent.

-Peff
