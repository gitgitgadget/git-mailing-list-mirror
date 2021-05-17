Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E42EC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3B61185
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbhEQQzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhEQQzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:55:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC3EC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:54:23 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id f8so5333628qth.6
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hvhu4GAWEzhd/NRhAz73L5g5z06TDV2NRGQUlDChMs8=;
        b=FgwoSwOuaeUv8CsNDulIX9sKzEMgrfle9hGrBfDzZghcNDZOF46pxdoU2wFC027B3K
         PmbPxLluUKWjBtii+8A9e2rBnGSuTmLHW9gRMPSBky6sLZX77Qm8zupltHiCAaXir3Om
         fsSo65+MLp34Nmh2+5CgpnqPd5JFANUBwnLrkCAtn1dQ6+beEC6Bqt0kN5ktBYQFOShp
         qQOO2d1OrSy24k3sDNcLrxK1q7wwgLV7uMa2CVURYrVC7sAB80XMms8JappNNjOYpy00
         VQhKm2GHXIAx8WPnLSfFGKz0A05bzMqwz219IxEEcTcCGKDmipo6aMkYQnmI1bvyuAwY
         bMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hvhu4GAWEzhd/NRhAz73L5g5z06TDV2NRGQUlDChMs8=;
        b=D7xmo2PravaFBukqLdtqlB26G/v0hJaxuD9m9n5MtK6nf0QyzMgMDEzJEDMPQ98yr9
         vP18qtUH1xqElYiTtZU4LfmJ1Pbd8r072IP8yr3nq58J1UlsMwCDvRWk1HlibLsD8Mm6
         L6B5gpJRIy1xD5v3ohJMEZyprJflZ8pQoksgRj1rN96Q+UpgvkVJFKdGtUUQNi9hpbZC
         nhsbBYddHuU9XMcuqYNGpKWhaSDBOAuqzZnWUsyxmwuj3FH7ZL13sxoU/sLMnuixqYlw
         cR9S5RrDMalvTHp9PaK1qQA5uPhKfAKMezpuen9S1ZRL5sBH3/f05gY8lv6oE13T+EYc
         sOdw==
X-Gm-Message-State: AOAM532C9ETXtTgIN9CVV2jNFfCDwIwzf8K7eNGxklpH5VbbxtHxAr0T
        xCDBDZF1wnCM8ORVXMkOvvDijyv4wPPwXg==
X-Google-Smtp-Source: ABdhPJzNXj5CAXrgdenwyuNXkE3iQys6iG0+OQR5+LUjl48RgvWbbILUpCSSbaIDaqSrerQQh0Rqww==
X-Received: by 2002:ac8:5c8d:: with SMTP id r13mr426017qta.69.1621270462442;
        Mon, 17 May 2021 09:54:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id u6sm10614966qkj.117.2021.05.17.09.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 09:54:21 -0700 (PDT)
Subject: Re: [RFC PATCH] parallel-checkout: send the new object_id algo field
 to the workers
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        git@vger.kernel.org
References: <a4225bc79d963c5a411105e2b75f9ca4b80de835.1621000916.git.matheus.bernardino@usp.br>
 <YJ7VI5kHAAk126YJ@camp.crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7182880b-0f1e-7b3e-dc6e-b72c8ddd14b3@gmail.com>
Date:   Mon, 17 May 2021 12:54:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ7VI5kHAAk126YJ@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/14/2021 3:53 PM, brian m. carlson wrote:
> On 2021-05-14 at 14:36:00, Matheus Tavares wrote:>>
>> I've read the hash transition plan, but I'm not confident to say that I
>> fully understand it yet, so maybe this patch is not exactly what we need
>> here. Mainly, I'm not sure I understand in which cases we will have an
>> object_id.algo that is not the_hash_algo. Is it for the early transition
>> phases, where we have a SHA-256 repo that accepts user input as SHA-1? 
> 
> Yes, that's correct, as well as for interoperability with remotes using
> a different hash algorithm.
> 
>> Also, the object_id's copied here at send_one_item() always come from a
>> `struct cache_entry`. In this case, can they still have different
>> `algo`s or do we expect them to be the_hash_algo?
> 
> No, things in the index should always use the same algorithm..
> 
> The patch looks fine to me.

Chiming in to say I agree that this is a good patch.

Thanks,
-Stolee
