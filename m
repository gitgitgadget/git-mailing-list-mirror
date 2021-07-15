Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9518FC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708A7610A7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhGOO60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhGOO6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 10:58:23 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0C5C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:55:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id l18so6776156iow.4
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jlAYqARsDQgtvHzXfmxFTqELefMwwWch5lz63TnMf04=;
        b=Rty6tn0fMAgxBz0XQaZPqah4DXVv3vqjKZxpJ5D3zWpToukyjqKt9UZmvvkmsItoxU
         7P7aIXIa6mBFK0VE+SkPpi8CSAPIcLQinFek5a5gbDNWcXFuzCGbayemaAgJPx4OcSu0
         RdC2shFw3ZLT7EjohDvIQO6cGU4sVsn2bM7mOVrO1zoYD55bdeejEJ6skmDOWSuWUrmd
         OX1y6OAnYvZAogpHA8ep7XTiUsySphRDSdI/KAtH72Meyuy2omOzY5ChdtVQqVNqD++Z
         KbB1p8fq3X5/uGCxf6YP2gxFRwdUW7q8IJEQgufO/hLqQByTXJDYIPp+6PHcpdEl6U+Y
         +R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jlAYqARsDQgtvHzXfmxFTqELefMwwWch5lz63TnMf04=;
        b=M3WNPq6FDCkNKSAK0qJcbFYH2mslAzEiXD4bGlFiRyR/pf0vFuY1KKDwsQwGs2cBTx
         uSlN68Ur992TfIBjs2bS+xb//HDnA7krPNp6V3NK+rixgm5qAsfCUHXw0/jtztPmiCZX
         +9/rinYsqFln/UA0KEo+XgocOu0tltDxAn4jqFfLhE3wudGCJVebH5+qATS2S3PWyPrX
         PHPKuLuXkNv8EjvIA+ArCrJKbhUCFBEyCLJIW5GtrwwVqOpEVqAvmFQqmAylfxYpnV3H
         8IlW9QMxDWU59cldAm0W8UL7WpeZm0FqLc3yFEsrLFsFSNlZxdSBWO3bbQVdJOgje/IO
         UkFQ==
X-Gm-Message-State: AOAM532ugmuuyREQS2zzqHILZ26g0Bss11+/ktl/kO4pywJ0WwU+lOT3
        1GvPKZVPbpmvnHBUHXn/RV4=
X-Google-Smtp-Source: ABdhPJxwaFB4El2tXkcx1xMC/B9nA3qPivuKWrMnkYWBbuFDa2VJkic8bEpg0rFnyKWQF8pCNAS/Ug==
X-Received: by 2002:a05:6602:2219:: with SMTP id n25mr3376766ion.205.1626360928936;
        Thu, 15 Jul 2021 07:55:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id 204sm3261441ioc.50.2021.07.15.07.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 07:55:28 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] merge-ort: avoid recursing into directories when
 we don't need to
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <3409a6cd631deb361d3ecb94491c0c297c52fb53.1626204784.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <24c5ef26-f5d3-fb0e-b2da-24cdac90450d@gmail.com>
Date:   Thu, 15 Jul 2021 10:55:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3409a6cd631deb361d3ecb94491c0c297c52fb53.1626204784.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
...
> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> performance work; instrument with trace2_region_* calls", 2020-10-28),
> this change improves the performance as follows:
> 
>                             Before                  After
>     no-renames:        5.235 s ±  0.042 s   205.1  ms ±  3.8  ms

Wow! This is quite the savings, and reinforces that when no renames
exist we are likely to hit this optimization.

>     mega-renames:      9.419 s ±  0.107 s     1.564 s ±  0.010 s

I'm surprised that this one works so well, too. Clearly, there must
be a lot of directories that can be skipped despite many renames
existing.

>     just-one-mega:   480.1  ms ±  3.9  ms   479.5  ms ±  3.9  ms

And no overhead added to this case. Good.

> +		/* Loop over the set of paths we need to know rename info for */
> +		strset_for_each_entry(&renames->relevant_sources[side],
> +				      &iter, entry) {
> +			char *rename_target, *dir, *dir_marker;
> +			struct strmap_entry *e;
> +
> +			/*
> +			 * if we don't know delete/rename info for this path,
> +			 * then we need to recurse into all trees to get all
> +			 * adds to make sure we have it.
> +			 */

super-nit: s/if/If/

Otherwise, I can't speak to the code being 100% correct because
this area is so dense. I find the code to be well organized,
which will help finding and fixing any potential bugs that might
show up in strange corner cases later.

Thanks,
-Stolee
