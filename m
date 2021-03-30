Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293CFC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF84619AB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhC3Nxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhC3NxR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:53:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E6DC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:53:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l18so18317307edc.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IILrqEO9bxTMerXSAkjNOBoZdZPXlhseEmFl6QIyMHM=;
        b=ar9mfuxAQk61wxUkpnahpB1Bf1MPtCcdwa7ArfTIzoJiZZbEwlKOqXH9A6xznj9AK7
         7W5dIqElTS/9BGkHY+MiLCO3bpUvPAXBUb6Nv/7fGeGG1kDt+GYP7pmixsaUdgJ4JOVD
         Yj90Dbi8k7BIgpXKnD/pABAau9PulWpDTmliA4AMSnhctJkVg4qovv7Zf8SLvReZnAFU
         W/GeOW5jZq1mHk1pKcp6saJUkbS0agU+aDcZRydI2IQT8lH3TPJrxX7MuZaV+5zSCa/0
         La3A7wPCl4JckEQYNddMkoSn18T2kNqwGtsWbsUoMjINJ06hCXgf6En7baCi/11LA5gn
         B7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IILrqEO9bxTMerXSAkjNOBoZdZPXlhseEmFl6QIyMHM=;
        b=Aa9Df/aESffRNh9aK3FyiJ3AukYQxXb+DjgjDvLp5XkfAWqp2ww2FPmHPfJ/Ef9qP4
         LqzyHlY5m0KOmp5Qon4mYr6C+zXRVJ4kiHarGySWPwwtsEjEeWMt6dcHre/jUhB4Ua/R
         BffXmHZkXU5koehIY4nJnEP8XK9mHkXqlU/3FpoDEczbL2RTLO4nFa26jteWCXbBeAJv
         TXs+giDurYqNRT95AII9PPKcZg2gFH9KRL0ocWbE5ybiPf1uAETaqtVhIP80thxJtdqm
         EHl5w4sC52maHq/+ul3GkrbbuDKcoONwxuLXdOLUk1VAzNBD4xbSBApWHh+K+3dgKWFI
         lueA==
X-Gm-Message-State: AOAM5308+Ci6ML8skvmFj23SkLPE5sMXcXzdCIE/8KtTBGh4Kg2/sMhn
        IihXm+h1amm+QEDrLMqwGyM=
X-Google-Smtp-Source: ABdhPJyHgBQkF51+yG7BO59xcaB7G1LKPzX07PszfHt5uXVOX0alW47ohqg4q8mDQwYTwgXC5N9fSg==
X-Received: by 2002:aa7:d294:: with SMTP id w20mr34147266edq.68.1617112395787;
        Tue, 30 Mar 2021 06:53:15 -0700 (PDT)
Received: from [192.168.1.240] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.gmail.com with ESMTPSA id p27sm10009388eja.79.2021.03.30.06.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 06:53:15 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] rebase tests: use test_unconfig after test_config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com>
 <cover.1616411973.git.avarab@gmail.com>
 <330b33e7a8e87e528aec43c306753cdf573ed8af.1616411973.git.avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <53e9be89-db1e-b9ee-e93d-d8c8195480d4@gmail.com>
Date:   Tue, 30 Mar 2021 14:53:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <330b33e7a8e87e528aec43c306753cdf573ed8af.1616411973.git.avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 22/03/2021 11:48, Ævar Arnfjörð Bjarmason wrote:
> Fix a test added in 906b63942ac (rebase --am: ignore
> rebase.rescheduleFailedExec, 2019-07-01) to reset its config after it
> runs. This doesn't matter now since it's the last test in the file,
> but will in a subsequent commit where I'll add new tests after this
> one.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t3418-rebase-continue.sh | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index fe407e63cf1..ea14ef496cb 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -283,6 +283,7 @@ test_expect_success '--reschedule-failed-exec' '
>   '
>   
>   test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
> +	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&

I think test_config adds this test_when_finished line itself.  See 
test-lib-functions.sh:

# Set git config, automatically unsetting it after the test is over.
test_config () {
	config_dir=
	if test "$1" = -C
	then
		shift
		config_dir=$1
		shift
	fi
	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$1'" &&
	git ${config_dir:+-C "$config_dir"} config "$@"
}

Best Wishes

Phillip


Best Wishes

Phillip

>   	test_config rebase.rescheduleFailedExec true &&
>   	test_must_fail git rebase -x false HEAD^ &&
>   	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
> 
