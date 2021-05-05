Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AAFC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AD26101C
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhEEN4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhEEN4P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:56:15 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE002C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 06:55:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a18so1168604qtj.10
        for <git@vger.kernel.org>; Wed, 05 May 2021 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yF1tD0bKMz6DHJRyQ1S8gnJFpMPS640lJ4+PleP1P/s=;
        b=uufiBPaiCWkY+tYvQ4wkYnfJLfDHDzCUIP9S1Y/Q1hFA6lbUXda/mQuxm4JEsdxB0X
         t13DJbzPoKHINlKsqzkdgLIS9feAbhfoLCUpEerUdjlfW4YN4i2WsrD4U3s8c2ASgxS4
         JVJWDN0r0xXIkvIFIv1z1o+6XHOs9juUZ38gf4ufwZOpfW+byLB+jvwzHW9I5Gi6ecgb
         Ro0pbjubfN+Q+rDAJ5jtoFwTCzQyZn/X2NjUNApFs3VH3FV/p0QrkDSHVsAkXr+3t8dm
         /9c6dSlhkpHpZaHHZY903Gi4ZjFk52EZBV5agp3vyRSIFk4bhyI+JS7m0Z8u06vhys0F
         Qa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yF1tD0bKMz6DHJRyQ1S8gnJFpMPS640lJ4+PleP1P/s=;
        b=QcJtNneod1q2h69I8ndffTOU23a6LR3nNVQSj93iP6x9gKS8eKpmO5LpCo/BcNBYt/
         GND3c6duMTU29OYB0xOT5iP7VyYkn1MsPIGON8Bzj0bnfxAPvyPZ7RCq0SvXwCXeJmKj
         VQXuNzXAbER2ueHo+yc4l6yMGb1YAzFOive7vCTzPgJ4YEcdH+NfzvA5/MzlXnabvvcM
         GERzo4BvNErZybil18PhcAF78W9Plj3XlTn4lHKhVhs44apV3inFhW7Ip3ELiK2dFOZr
         0nsMqcGJ33bEEdE7PgTScjUHSsyMx+B9RSMR73NGaujo7sZ68pw0S75BpJ75x6YoQmkk
         AEUw==
X-Gm-Message-State: AOAM533ZqapIrx73GxlzCfppY4gvxtBn0/MlxUDpdJmO69jaEU2qspKc
        G3tEC/3vm0NYD98h1wSbyMY=
X-Google-Smtp-Source: ABdhPJzqFaKHp61sD/N7tfvwmidGTanNm7TKwD1qNFjFO3Mp6e627oZ4qQk2Szl9KFshsFvGKg7glg==
X-Received: by 2002:ac8:578d:: with SMTP id v13mr28225229qta.174.1620222918091;
        Wed, 05 May 2021 06:55:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d2a:f5d6:d0e8:8a60? ([2600:1700:e72:80a0:d2a:f5d6:d0e8:8a60])
        by smtp.gmail.com with ESMTPSA id i15sm4741194qtq.83.2021.05.05.06.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:55:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] builtin/checkout.c: complete parallel checkout
 support
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, tboegi@web.de
References: <cover.1620145501.git.matheus.bernardino@usp.br>
 <e8988897876b932b7b0b812addbe3683ad52221f.1620145501.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <67880d76-c1ed-eadd-d33e-25fba0a8473f@gmail.com>
Date:   Wed, 5 May 2021 09:55:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <e8988897876b932b7b0b812addbe3683ad52221f.1620145501.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2021 12:27 PM, Matheus Tavares wrote:> @@ -359,16 +360,22 @@ static int checkout_worktree(const struct checkout_opts *opts,
>  	int nr_checkouts = 0, nr_unmerged = 0;
>  	int errs = 0;
>  	int pos;
> +	int pc_workers, pc_threshold;
> +	struct mem_pool ce_mem_pool;
>  
>  	state.force = 1;
>  	state.refresh_cache = 1;
>  	state.istate = &the_index;
>  
> +	mem_pool_init(&ce_mem_pool, 0);
> +	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
>  	init_checkout_metadata(&state.meta, info->refname,
>  			       info->commit ? &info->commit->object.oid : &info->oid,
>  			       NULL);
>  
>  	enable_delayed_checkout(&state);
> +	if (pc_workers > 1)
> +		init_parallel_checkout();
>  
>  	/* TODO: audit for interaction with sparse-index. */
>  	ensure_full_index(&the_index);

Since this context piece is new as of your rebase, I did a quick check on
all of the calls you inserted above and found them to be safe with the
sparse-index. They do not care about the number of cache entries, for
example.

Thanks,
-Stolee
