Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F6C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B29764DDE
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 13:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhA1NOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhA1NNf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 08:13:35 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB9C061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 05:12:55 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id r20so418652qtm.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 05:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DAA4V4aiYdzEuSl+nS/sCgoGIuMgJLS4nK/jWtamyl8=;
        b=K//RNHNpYbfYEmUdeGsCpemLWloBpfwXgeWws9S1gh/PpfjmWDugqEA3r835T297Wd
         YyvUo+nNCgR/OFguvCWNoBroKjOvj+CHA4SeVgjw/dOQzftDCprcAXAvcmYXD0gBEP53
         2gAs+oAF/IZ2rIvHGAUN6gz42b/w18zBXwuyfN9AKKJcGKmame8IrRZ3IriZ3234fUlb
         JdOYoEsrfVgeIFsz7YfMNH0Ga2gLy1ZzefqSaT1ENn5EVOlr8bUDDqx8uBd65fehVEps
         O6IexGbnQXYZ7N3Jq7ywrzyhh1EAlpo/Me/5RMPfI1PgRG+Qd18KwXSw54F0vw1XuoZL
         zvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DAA4V4aiYdzEuSl+nS/sCgoGIuMgJLS4nK/jWtamyl8=;
        b=rARMaJRvhsdToOaF85tBpjoYHV77KN9TQ+CR0DN1Obi3o6+XBOlxJK9Y07EV/DShql
         e8jYSxWmXbi5cQ/vcQXhO9XIGO1kPfjQrsag8zsHd+32/L5MQQVQS/7sITYje5OylJQz
         o5PRTQGy74N7GKe24rsR1YzuBbMjo2bREfJbLACPPMdCXZvpwZ1K+A6Gq405Q/pEpdsb
         9nMnRtb230ZO6wgdW0IccSBBSNVFeqpCwiEQvTXhXE5kxQSQ0ZSUY6barep5z31PkPuC
         aH5ebs1bZ83PMvErbzC6mNXAH+kkolql8xJ5johKz1KV2AsKrcevao16tKn939OTrY/v
         FFPQ==
X-Gm-Message-State: AOAM530kxiENEGIJHXa9s9dCIzEFdIsBeWJUCdEj6DGYhnrXy609eHib
        ofDWOspnaEKu7edG1GF50CfceaOdXJ3IYXsB
X-Google-Smtp-Source: ABdhPJzoFbJXAQfXHSdCefnebgwA2GyJCgztouZ2x9R/33B/b3IBqAVd/f8bwsEKdIOHeFVHcneHWA==
X-Received: by 2002:a05:622a:201:: with SMTP id b1mr13758164qtx.237.1611839574017;
        Thu, 28 Jan 2021 05:12:54 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:916c:60df:445f:4f0a? ([2600:1700:e72:80a0:916c:60df:445f:4f0a])
        by smtp.gmail.com with UTF8SMTPSA id s15sm3262465qtn.35.2021.01.28.05.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 05:12:52 -0800 (PST)
Subject: Re: [PATCH 08/27] sparse-checkout: hold pattern list in index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <80aac5b8b71da96d6287f19e30f4ee8f786ca07b.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BEA5B3TzA-w-aBC1ZvFEYzvZfB-hkc=rXqgSVjrBNTLcA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <87467655-aafb-d509-5158-5688543e5868@gmail.com>
Date:   Thu, 28 Jan 2021 08:12:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEA5B3TzA-w-aBC1ZvFEYzvZfB-hkc=rXqgSVjrBNTLcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2021 12:00 PM, Elijah Newren wrote:
> On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> As we modify the sparse-checkout definition, we perform index operations
>> on a pattern_list that only exists in-memory. This allows easy backing
>> out in case the index update fails.
>>
>> However, if the index write itself cares about the sparse-checkout
>> pattern set, we need access to that in-memory copy. Place a pointer to
>> a 'struct pattern_list' in the index so we can access this on-demand.
>> This will be used in the next change which uses the sparse-checkout
>> definition to filter out directories that are outsie the sparse cone.
> 
> s/outsie/outside/

Thanks! 

> Isn't this the same patch you put in your index cleanup series, or am
> I getting confused?  It looks very familiar.
 
I removed it from v2 of that series because it didn't do anything of
value until we start using the sparse_checkout_patterns member in the
next patch of _this_ series.

Thanks,
-Stolee
