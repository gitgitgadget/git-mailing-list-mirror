Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D054C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 20:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5968B61369
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 20:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhDSUjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhDSUjL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 16:39:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCDFC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 13:38:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so23359140wrm.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f86yotTPsryr2eXADOHl0cc4ueS4USS3P3htVOSnSnI=;
        b=aFivpV0hAy4ebanGPlPNZU7byQKnVq/qzBdftlEYVSUIHPaWgPOeg+kfgdpJ0yssA5
         IKV+HcypgA0R54Hje5Fua+XXvqrC5+0MYFQlSrUPCCIxbfvyySdNL4Q0lkUjki+3R/0W
         ux8gkz3zYZs2XegJ5lxrsOYGscbGUJFERam6nj+dq5ENmEmnlAAVYEsq+3llzB40gg6z
         rwfPCLxW2rqzKVAQF+myjMS8oiSHoBX1EsZXtBA/9Kw7cdlMdDRmfbVGcWrJpuXlH1dR
         eaGONIirBn11miYBZN3fxuQtLcqqNMS7fmNUxloaUYeDMu/5DpeimNAHeRYHHJ7w3ild
         79+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f86yotTPsryr2eXADOHl0cc4ueS4USS3P3htVOSnSnI=;
        b=sNX+aBNmK93h/1PNNcGml217KEB/NSyXI2vQqs4xkxSfLJPXLO12wsli5GeKxBNlRk
         i5m5yQQYgN1aN3q78AOtMFECJdtubJZf3qejMky7fznqqZYaaPj05Nih1agAwZGAEmhi
         7A6Ah7MC0pwTbuxWcmTojzsGaEO7CVuVLsUjNOf+X3GsA1kLaMhiCA00RMQ33jACaczJ
         OqL14jCLXo9mlh4zYIOKniTrOdc+6WeAfUucl5gzeNnIxj5Oq8uYZcagXv25Or/WoL+z
         yoFRt00dQwEAheriQUlgCvXw7PMRHq4VB5BEyHdKswZE1YnoFQkWASE9zAj6n+ZqEA/y
         4ROA==
X-Gm-Message-State: AOAM530+i7a5YYsiT9d0iLYrWqf7g8P8Q6K9akmq/MOb9cfd+KS2N0S5
        dQFKduoGN1E80PKiTEPDYuk=
X-Google-Smtp-Source: ABdhPJw2rk9/qFWbk5kc9laTs07SDr7nphyfdSL+1y7Ps/MCdgE555yxXp0Md2zgNRSNpOiOqIng/A==
X-Received: by 2002:adf:ed0a:: with SMTP id a10mr16484117wro.61.1618864717808;
        Mon, 19 Apr 2021 13:38:37 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id l5sm23636131wro.4.2021.04.19.13.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 13:38:37 -0700 (PDT)
Date:   Mon, 19 Apr 2021 22:38:35 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 04/18] t1401-symbolic-ref: avoid direct filesystem access
Message-ID: <20210419203835.GW2947267@szeder.dev>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53cf1069552b6cd6161ce6f69a31c44e59091096.1618829583.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 10:52:49AM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1401-symbolic-ref.sh | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index a4ebb0b65fec..fd5980d3fb40 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -7,18 +7,13 @@ test_description='basic symbolic-ref tests'
>  # the git repo, meaning that further tests will operate on
>  # the surrounding git repo instead of the trash directory.
>  reset_to_sane() {
> -	echo ref: refs/heads/foo >.git/HEAD
> +	git --git-dir .git symbolic-ref HEAD refs/heads/foo
>  }
>  
> -test_expect_success 'symbolic-ref writes HEAD' '
> -	git symbolic-ref HEAD refs/heads/foo &&
> -	echo ref: refs/heads/foo >expect &&
> -	test_cmp expect .git/HEAD
> -'
> -
> -test_expect_success 'symbolic-ref reads HEAD' '
> -	echo refs/heads/foo >expect &&
> -	git symbolic-ref HEAD >actual &&
> +test_expect_success 'symbolic-ref read/write roundtrip' '
> +	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
> +	echo refs/heads/read-write-roundtrip > expect &&
> +	git symbolic-ref HEAD > actual &&

Style nit: no space between redirection and filename, i.e. these
should be '>expect' and '>actual'.

>  	test_cmp expect actual
>  '
>  
> @@ -42,16 +37,16 @@ reset_to_sane
>  test_expect_success 'symbolic-ref can be deleted' '
>  	git symbolic-ref NOTHEAD refs/heads/foo &&
>  	git symbolic-ref -d NOTHEAD &&
> -	test_path_is_file .git/refs/heads/foo &&
> -	test_path_is_missing .git/NOTHEAD
> +	git rev-parse refs/heads/foo &&
> +	! git symbolic-ref NOTHEAD

Please use 'test_must_fail git ...', because otherwise a segfault
could go unnoticed.

>  '
>  reset_to_sane
>  
>  test_expect_success 'symbolic-ref can delete dangling symref' '
>  	git symbolic-ref NOTHEAD refs/heads/missing &&
>  	git symbolic-ref -d NOTHEAD &&
> -	test_path_is_missing .git/refs/heads/missing &&
> -	test_path_is_missing .git/NOTHEAD
> +	! git rev-parse refs/heads/missing &&
> +	! git symbolic-ref NOTHEAD
>  '
>  reset_to_sane
>  
> -- 
> gitgitgadget
> 
