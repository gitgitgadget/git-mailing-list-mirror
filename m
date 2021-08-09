Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE75C432BE
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8329860F35
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhHIPSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhHIPSD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 11:18:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F92C061798
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 08:17:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h13so21949166wrp.1
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XuDqBZichrt/uJtX0BGxSvwPZK1w/cH2/2eyTgX7J+g=;
        b=oeRMY51GqskNVXdyNaF4/AAx958281vxzy2A8vJI/TdEwu9WqAlyqKvAXnsafCnSP8
         dm3E8/JBcrgs9ofoyEnXDhvRAr1rSsWCBG0iUangAyPzgg3vooLQEypKoeuVEPdrwW/M
         3CouzxgEvsgb+kIo27wBW6iOnxhfFr1C1M+RHZ7gm9KnQVirDx5vbq9xi+MI5vHwYxrV
         F7D6q4ED17dtvU2mrLCl3qUGOy5+HtsVoVezhwInjI0WtOLcgc9fEKxJunCZkX7tkGWd
         hZLXD1wMgXdYV3BWfaG92Uy+zl0V/A0HU19x0UBSQcjD51S/lzbAcQSoPY3PAP04H29b
         wMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XuDqBZichrt/uJtX0BGxSvwPZK1w/cH2/2eyTgX7J+g=;
        b=TRUyVjZx4wrkSCjVU1BjOMVchy4uUFhEyGLCYkn0JcXOrHGA+c51A02D5ihPIabXQj
         5ZKpO5+RXy+aNJ68HzJchmys1PIC8iIDg41K+CeLjd0Gu43hz4h2pUaCgQVM5WaeDDze
         JSEhHQSGxCcjbW0epGbn0Faym8HYtsH6CCzB55GQDNgVO4EpVxZVHoAIYNOoTBYDEyuq
         epd1oVjzY2R2HgDAvFNxsDftqYpy+7aKDeI8QBnyebqdUhzUwhmDRKUteJvh5L5GXsXd
         nLX89iqdE1Pt51nkpB2n5mmc3deZtVOVoimGYG83T65V4fyvjJnPnDZaeQjxG5C1op8X
         NRKg==
X-Gm-Message-State: AOAM5324OiUF156x6U3te7OsnfT51psE6YinFUVtn+KysVnUiVc6vY5O
        mqfMD/7MWCz5yd6eaei0mOYmL7bd/Ig=
X-Google-Smtp-Source: ABdhPJx275k/zh40RzgHqNRXqsivrdCWJng5cs2P44JlnlcmXNHcc6QVjqNhAEAsy2FRa6FqLZvAPA==
X-Received: by 2002:adf:a3c6:: with SMTP id m6mr4149184wrb.32.1628522261166;
        Mon, 09 Aug 2021 08:17:41 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.232])
        by smtp.gmail.com with ESMTPSA id i5sm20322316wrs.85.2021.08.09.08.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 08:17:40 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: drop unused options parameter from
 cmp_in_block_with_wsd()
To:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <YQxOevw7Q+NYX2YF@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ecb2961f-090e-aa84-4180-65ab43c8920d@gmail.com>
Date:   Mon, 9 Aug 2021 16:17:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQxOevw7Q+NYX2YF@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/08/2021 21:47, Jeff King wrote:
> When 8e809cbb2f (diff --color-moved-ws=allow-indentation-change:
> simplify and optimize, 2021-07-20) stopped looking at o->emitted_symbols
> and instead took the symbol as a parameter, we no longer need to look at
> the diff_options struct at all.
> 
> Dropping the unused parameter makes it clear that the function is
> independent of the diff options.

Thanks Peff

Best Wishes

Phillip

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just a small cleanup on top of pw/diff-color-moved-fix, which is now in
> 'next'. I noticed due to my -Wunused-parameters patches (which one day
> I'll finally clean up enough to send to the list).
> 
>   diff.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 2956c8f710..164af13b4f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -863,8 +863,7 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
>   	return a_width - b_width;
>   }
>   
> -static int cmp_in_block_with_wsd(const struct diff_options *o,
> -				 const struct moved_entry *cur,
> +static int cmp_in_block_with_wsd(const struct moved_entry *cur,
>   				 const struct emitted_diff_symbol *l,
>   				 struct moved_block *pmb)
>   {
> @@ -1016,7 +1015,7 @@ static void pmb_advance_or_null(struct diff_options *o,
>   		if (o->color_moved_ws_handling &
>   		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
>   			match = cur &&
> -				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
> +				!cmp_in_block_with_wsd(cur, l, &pmb[i]);
>   		else
>   			match = cur && cur->es->id == l->id;
>   
> 
