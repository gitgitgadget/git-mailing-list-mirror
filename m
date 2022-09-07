Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D3C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIGSMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIGSMD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:12:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EAC04CE
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:12:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b144so10643387pfb.7
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date;
        bh=pnzSm9wGcyEa/37haldYAS0t8mUfFyZ/scg5v/O38mM=;
        b=fAoEFH43ypuSu/3v2dYzqYp4nja530pOGumtb7GaVyqD2cGPp73d8sHyCdY5m3E5Kd
         EVo3kx1b4u1z8Hunq7kNnCO0qYeqSdKipm2MTgEeHn7O6mUrew6YcMK1/T75Jthc6/qv
         o9m/DfqW1yAamobpQh8kfmxGgAIcoZnUj49Pt/X+XS9/aWREdikvbU2z5Zj3Op4F7K+C
         RuPq16d2UPiRntLqX+jBiSwKHNaf41v984jJemHCuAch3thtDIaWSH+H3qt8dT4oheel
         vMlqHBCYqNzgOidq3aKcwVslfoSeX1VD+HwHvupOpLviP3CfBtG38NF+F4wBkHj6LrkP
         /lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=pnzSm9wGcyEa/37haldYAS0t8mUfFyZ/scg5v/O38mM=;
        b=PaNBERAiEhdogqlVN7jJuPvKkdXQ9pkr9t4oEsyHI8Bf9h8C0X2o7U71J+Btf2aqsg
         eiX0tWOhsqRNUWI4gvVMMBdZvCn0DuuPifhK9Fsf3N6Uy12Oe7zjKVxVxe4T1JQPZsNv
         yyVrDqWOXJPWzXdK5UAO5aiZ95OktXZI+zjJ7INXdq1/JQZ+5349ykb/2282LJef75XT
         kB2WVp568YdA9M/LxqFAfNQ9DK5FtNJX7I6EWFbKCbMTmdGvYYR5C+fc12Un/HGNj09r
         UM5yiJPGZRu1mhjsYEZ2ROxjppvfXRhWzL/9u2XCmIzjRKkMBFx54IM918HQIzKUSAjR
         wNvA==
X-Gm-Message-State: ACgBeo1+lY9zKBKgm10KT9g2BnfRdOTkNjmmnntCzfmEMj3X9hZVhVOk
        GXVEvsJZy/1cquSKRBDObW8=
X-Google-Smtp-Source: AA6agR4qumuIOZWlihISLq40Qq//d6v3/E+XVRKWUUV47wGTY5bztDncEnszsV6F9b6mOCXvyub1LA==
X-Received: by 2002:a05:6a00:a19:b0:535:49ee:da43 with SMTP id p25-20020a056a000a1900b0053549eeda43mr5110989pfh.53.1662574322412;
        Wed, 07 Sep 2022 11:12:02 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 184-20020a6215c1000000b0053e4baed9aesm3543625pfv.167.2022.09.07.11.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:12:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/7] t3416: tighten two tests
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <12fb0ac6d5d932f9a8685d803ed017c357182768.1662561470.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 11:12:01 -0700
Message-ID: <xmqqbkrrvytq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add a check for the correct error message to the tests that check we
> require a single merge base so we can be sure the rebase failed for
> the correct reason. Also rename the tests to reflect what they are
> testing.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

It is very sensible to ensure that a test that is expected to fail
does fail for the right reason, not by accident.  Looks good.

>  t/t3416-rebase-onto-threedots.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
> index 3e04802cb00..dc67d2308f3 100755
> --- a/t/t3416-rebase-onto-threedots.sh
> +++ b/t/t3416-rebase-onto-threedots.sh
> @@ -97,13 +97,14 @@ test_expect_success 'rebase -i --onto main...' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'rebase -i --onto main...side' '
> +test_expect_success 'rebase --onto main...side requires a single merge-base' '
>  	git reset --hard &&
>  	git checkout side &&
>  	git reset --hard K &&
>  
>  	set_fake_editor &&
> -	test_must_fail git rebase -i --onto main...side J
> +	test_must_fail git rebase -i --onto main...side J 2>err &&
> +	grep "need exactly one merge base" err
>  '
>  
>  test_expect_success 'rebase --keep-base --onto incompatible' '
> @@ -182,13 +183,14 @@ test_expect_success 'rebase -i --keep-base main topic from main' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'rebase -i --keep-base main from side' '
> +test_expect_success 'rebase --keep-base requires a single merge base' '
>  	git reset --hard &&
>  	git checkout side &&
>  	git reset --hard K &&
>  
>  	set_fake_editor &&
> -	test_must_fail git rebase -i --keep-base main
> +	test_must_fail git rebase -i --keep-base main 2>err &&
> +	grep "need exactly one merge base with branch" err
>  '
>  
>  test_done
