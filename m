Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB35C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE08161406
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhFCM4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 08:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFCM4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 08:56:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B3C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 05:54:11 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 5so3133140qvk.0
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LkauhG7MA748SMkSDPo5ueurzt/23EVvJSr3pH1/spA=;
        b=U4GIL4YCexkPl5RcTAF0SPYDP1mBYAZepvkSAErQEfa0qxFG9m1PCXE6esu8On4Ffz
         ds7t+XyL9bglNlRJvmS4h71a5TDOz7Fk8IK6qc9a3e78I22KzVXAZTt37cs37UhC9p4l
         5riWh/QEmPdhMMPBsTLO94eMyf0b+sUfcv1xrlX3oCl3ogThAwun/37Y1y4bSQe62jQF
         Ei2+GNCpW5S/9xa/a1uwUMmwe5F9y2eWS9p6vcufaKO5jfZg1/pL7yT4CBhmmHhP4HPS
         daP/3h67QDkLno9KCOHxI4H8ucPTGXVMWrKUkZkT1/T5r02s7ceVJWGU86lcCv44uznB
         blkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkauhG7MA748SMkSDPo5ueurzt/23EVvJSr3pH1/spA=;
        b=W9fZSYkC2iZoQQPtwQcdBMw6rKadQaWfIUoU+ylPS68dTb5m2Cv3nuOFugLn+TUz7K
         3lYnhQiK1eZOyxypJyXdq7cbAYE1KBagOJ7FnilX8DgQvbkkstF4MamU+5WQpByYFTHm
         KON0013jKuWjTNQMRakt/OQOq9YFxfW0XR4Hz7eHHJ0UHEhpwqENW4IeTAZocOGLnaRs
         oZ7sWHvgCHO6gxFfx9YGkzlrlRgV9/rWL9KhBuIAYjlMZnXLXvP0BEe10n++eH4P8CZQ
         eCG7CVxT5iJYoxu8P8HbxvjBEGXqk5Py0d4cZqQTSZwLUQu1gFC9QrDwpP18An/OoNUB
         2jyQ==
X-Gm-Message-State: AOAM531ksoXkRyAEd1Wp7cKsKpVWlKUuvJ3GJ0uqZkiefbnwytUoSueE
        oTaBDQh6oKg5eM7MOyuYJoo=
X-Google-Smtp-Source: ABdhPJwqCHiEYLdsA/VAK36mcv6V1zNanHCW4Li5SGcX9tXXXZpGzumYu8YLjDQ5Cat3/5p6Ltgo2g==
X-Received: by 2002:a05:6214:11b4:: with SMTP id u20mr19707500qvv.4.1622724850236;
        Thu, 03 Jun 2021 05:54:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:c134:af19:92db:52e4? ([2600:1700:e72:80a0:c134:af19:92db:52e4])
        by smtp.gmail.com with ESMTPSA id y20sm1839319qkm.5.2021.06.03.05.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 05:54:09 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] diffcore-rename: enable limiting rename detection
 to relevant destinations
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <45e1de5fe7808f5297d5e33d14c239d74de33bdc.1622559516.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1016e500-8169-7bb3-8428-b5ea35d19630@gmail.com>
Date:   Thu, 3 Jun 2021 08:54:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <45e1de5fe7808f5297d5e33d14c239d74de33bdc.1622559516.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2021 10:58 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Our former optimizations focused on limiting rename detection to a
> pre-specified set of relevant sources.  This was because the merge logic
> only had a way of knowing which sources were relevant.  However, other
> callers of rename detection might benefit from being able to limit
> rename detection to a known set of relevant destinations.  In
> particular, a properly implemented `git log --follow` might benefit from
> such an ability.

I would be interested in seeing such an improvement. It could also
help the batch-download of missing blobs in a partial clone situation
because it would only need the "deletes" portion of the diff, since we
only care about one "add" (we'd need that blob, too, of course).
 
> Since the code to implement such limiting is very similar to what we've
> already done, just implement it now even though we do not yet have any
> callers making use of this ability.

However, I'm not sure that this change is warranted without such an
integration. Perhaps keep this patch here on the list as a reference
for anyone who wants to do the `git log --follow` speedup? This person
can include "you in the future".

I'm just worried that without a consumer, this code has no automated
validation and can either be buggy now or become buggy in the future
before someone starts trying to use the logic.

Thanks,
-Stolee

