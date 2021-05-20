Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DB9C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3441D610A2
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhETPmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhETPmv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:42:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34ACC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:41:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l1so26035757ejb.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EyquRDaKsCpEdqZTv+NYyyJLNWOgtWS16y6eODeI/Tw=;
        b=YEV7J4rIAaxxtUiOOSqq/KYVtFBpePoe1dN8+0p6xuKpaI8VQKLwGn9OiF96fzqcya
         4DvNVC4UU+i7IcBgNnFA2BeJzLK2TRFZUSWf6gx84I0znx7yMC1KCn2yGVMHiM377TZe
         +IHQrq78hZjvBiWWJG7dX/pOKuJzEqvjUmX5QJTbUKcxY8ywcf+nAK078ZYBtwrvBujg
         23hgAiaDGcZiPsp7LxNnTyjskhaGjz+K7dTGtnzcOZVeccCx60mPJctWKo/05GZNGl9u
         stApHXHzWyVlWdFM5tujf/xjuMMdfLdcFCznKfGdzqNeRk7MybQeSDpha5YiNQbImHUb
         z05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EyquRDaKsCpEdqZTv+NYyyJLNWOgtWS16y6eODeI/Tw=;
        b=bsqbwquJSAckrZu9MNIGK1vEy50N6COWg1xLi2bvb4ZQFW5Jy94FzTPf9MYAJjemqU
         kY18unyBTugmV8tMyFGssIpvbtoqDWBgi24m8yUksog/MlG60ASoe+46q7IJW20Yfoij
         hDt/cbQkm8Puchoh+8FxK5Gm8cqVhClwtR3ys+4j0LJmmvxn6/Yxq/KaV/GuBaQcB8s/
         k4BcFCLm+wkRpUHh1FCE6E9yxNJ+g5qPtmBiUopyb+P48DYv47gC4oOjwP8I7vZ7EEc5
         bK8kqXIYqGwfuK9/43WYB3X7pF6PS8iCbADUDQ4P8cLUYTtX6hFshfHT+TQGQ+cUmsMx
         +qCg==
X-Gm-Message-State: AOAM530JJqFxcljPy+OlJC94YUYFZsD+TW9esI5fvg9TQFPldsRp5lFl
        2WGNyP0xYGMz4oZZi0JrBtul6lqaorCPAQ==
X-Google-Smtp-Source: ABdhPJwrM2vBrx0wgXTC7DRlmLmEKz197k4v/bbGtZnCj7FwrsS4VnkmyuQ1oWmPK0PrpIy/iedMOg==
X-Received: by 2002:a17:906:161b:: with SMTP id m27mr5253833ejd.89.1621525288176;
        Thu, 20 May 2021 08:41:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i5sm1803056edt.11.2021.05.20.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:41:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 18/21] t7900: mark pack-refs tests as REFFILES
Date:   Thu, 20 May 2021 17:40:14 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <ff3b67c84c412dafaa506355e83427a731b47623.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <ff3b67c84c412dafaa506355e83427a731b47623.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87k0ntpg48.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Reftable automatically compacts tables on writes. The functionality of
> incremental compaction is unittested in reftable/stack_test.c
> (test_reftable_stack_auto_compaction)
>
> In addition, pack-refs triggers a full compaction of the entire stack. This is
> exercised in t0031-reftable.sh.
>
> Given that git-maintenance simply calls out git-pack-refs, it seems superfluous
> to test this further for reftable.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t7900-maintenance.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 2412d8c5c006..6f2f55a6c51d 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -343,7 +343,7 @@ test_expect_success 'maintenance.incremental-repack.auto' '
>  	test_subcommand git multi-pack-index write --no-progress <trace-B
>  '
>  
> -test_expect_success 'pack-refs task' '
> +test_expect_success REFFILES 'pack-refs task' '
>  	for n in $(test_seq 1 5)
>  	do
>  		git branch -f to-pack/$n HEAD || return 1

I don't think it's superfluous to test what "git maintenance" does
anyway, i.e. the test ends with:

    test_subcommand git pack-refs --all --prune

Shouldn't we test that we .. don't run that, abort, warn, whatever?
Anyway, as with another earlier comment of mine we're going to have
chicken & egg problems with amending these tests and then actually
introducing reftable support, so maybe "not yet", but I worry in general
about the loss of coverage...
