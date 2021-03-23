Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA50DC433E9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E1F619CA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhCWNRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhCWNQP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:16:15 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55171C0613E0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:15:53 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i3so16930046oik.7
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MroGJHRz0dLyNr+/3ucRaFrJMS4XIJM8P9jMbqZU3WE=;
        b=CUULNCm67jsDXjQpiSiKpkmv4Z/fDRivhDVx9uthjKgP2G51OF8Uct0HtbtZ0MUOFS
         2AsEk4oEom44KM4iMSffes4bXMT4Tve6rDqNOrU/OXrku5hlkILa5GM1CAgYfoFg8rXm
         4ova8KJxexh33fHhbbrAJn+Thv2Ll3GabLzXSzr7M/qBePsT6QByQTyFy20bw7OFaM/D
         jCQFkjpwNXCAWJVF1Etn7aoHKBl7uf2BndWWvlTl7PNSpDDNVw4Rsmym8J4612uHPD8A
         8iMvC10/PhOq09mVle7ogyIQM/2T4Q9EQyuyR7vUY6X1xcZYzpMTU1O6JZ7uQkbRthKL
         vzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MroGJHRz0dLyNr+/3ucRaFrJMS4XIJM8P9jMbqZU3WE=;
        b=MJ7fGl1S3uC3vh5Ghsx33U2pLOfAb4QUYJ/CqMRSutXUielmbF+a377usu/yde1qPs
         BumEmwGsNai1OXKF9hg7ZJZVSatW2Q7xgW81ygE6XbmwZZQzh2FnICguaHI8+akC/xDy
         blBy48a4w2840j1Ie/5i2XMEDceMnph6w5FkBXTjHuZ+llS+RijyedtwfkJ82e1VolML
         3yC5zKEpRkLHSOI8bsZ8PxbgIY98fbR2bQPQT6Ri4ciQF8+avosu7fYO6gm07Nn4dJ51
         HNTIKPkYv5CfBbM/RIG/EGDkSjPMAeHYWj7Nlkon9BPJgtHkoYJhGyMGcMQgLkkUf/hE
         QDiw==
X-Gm-Message-State: AOAM533zPlUtPgEoPIQYIL6WsrHMXO+Vlvk5TFUkpSmcLsrL+wjN5JKB
        kzctbnkWlOFmbxrsZP3FZBwqVfWYu6yPD84R
X-Google-Smtp-Source: ABdhPJy4t3eiheLv1qg1+HXpagATrVdTY4+Q+E56D+aPP4y+PUh5By+7/dYmy7r1tFn7zZdfo5Ik/g==
X-Received: by 2002:aca:aa41:: with SMTP id t62mr3208061oie.84.1616505352679;
        Tue, 23 Mar 2021 06:15:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:19be:10a5:ec17:ace3? ([2600:1700:e72:80a0:19be:10a5:ec17:ace3])
        by smtp.gmail.com with ESMTPSA id d1sm4092759oth.13.2021.03.23.06.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 06:15:52 -0700 (PDT)
Subject: Re: [PATCH 17/27] diff-lib: ensure full index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <45bbed6150a2a9f9e9446edc9a613f027da73957.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BHsSpQieOGFPwXJ63qy1JhWcwu-bSvv1w7-yTZ6T4fx9Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef818ccc-f502-b474-c126-7fd65d16db49@gmail.com>
Date:   Tue, 23 Mar 2021 09:15:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHsSpQieOGFPwXJ63qy1JhWcwu-bSvv1w7-yTZ6T4fx9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/18/2021 1:24 AM, Elijah Newren wrote:
> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Before iterating over all cache entries, ensure that a sparse index is
>> expanded to a full index to avoid unexpected behavior.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  diff-lib.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/diff-lib.c b/diff-lib.c
>> index b73cc1859a49..41d6fcec1a81 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -102,6 +102,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>>
>>         if (diff_unmerged_stage < 0)
>>                 diff_unmerged_stage = 2;
>> +
>>         entries = istate->cache_nr;
>>         for (i = 0; i < entries; i++) {
>>                 unsigned int oldmode, newmode;
> 
> I don't think adding a blank newline will ensure the index is expanded.  ;-)

Oops! This is one where I think we determined the loop doesn't
need the guard, but I didn't remove the newline and hence the
patch wasn't dropped.

Thanks,
-Stolee
