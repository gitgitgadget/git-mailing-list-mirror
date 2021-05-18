Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A06C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D16B611CC
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbhERORn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbhERORm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:17:42 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E6BC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:16:24 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so2263751ool.1
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vn8pZv0dCLH0o5yfSWI0mFkNfOSzixvPvSF5bVv6wpw=;
        b=aMYiXzcpvnXRUuiFaWuDcl4OAiz9WZ3H5NfB5yi213IwqO/76T8Of2xDpCL24HpSoG
         CJ3Udaoy9v8PRK8jqbdEvCbUQuApeAhiJE97kNGUlVeeOAJz/s6rMqW2F4sJ1k7yun8n
         rI3nb2WY+JSKXi1b+2utp6TiiSR0puvDt5ms+oDp/BHZMHp/7d6fVIwMFZB5JJgFYZ5H
         KY2LlM8BiFr1H4I2M2F3orrVxqhIzs3YqTBgIng8IHf8sjxT65ga+HjlottYbVBNMVp5
         qk4nFBkA3PavjhQW/4mB4v3J7XRl/Z6v4Eccj2/GXQHKVvUnt658h9BPgckFRLHK2vWg
         iR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vn8pZv0dCLH0o5yfSWI0mFkNfOSzixvPvSF5bVv6wpw=;
        b=pq1Yp6f2fSvIHrzC67p399/nNNfFBNfXE87Y7pN84+DhAY/d9qwfrnGZyjMw6Ugigg
         pquqYItHlkxxS23Wd0DTh2iOgS8fW3E1WxDbffEl/boGn+0TobW1/7HfuJkDWCyY4s6P
         41IBeppE8krNELFLagYKEKcrKBskGWARbkl5reV6KCPSmMthDr48wxY7+fdwO05zxEEZ
         qsZCFx1Az1EbxyI0JpUzwhpA6FxiLGh8fXDBunrN8x25JQ3ha8sKWnHpAQZeeGRnSjfh
         HoPQ/4iHwlZVN0bMkEgd0Qh54s+1SgNic/f3DteQqcOkBUds/Kt7YA+TMDy1eFBFbSti
         GHjg==
X-Gm-Message-State: AOAM533IEPH/c+WE2lyvX9IWjnzOKAgc/iTg2potOD78F0L1/v0Ha7jR
        ZxXDWT3oUQRKkeleePmOn0KHjV6nCNvPfJDm
X-Google-Smtp-Source: ABdhPJx0AcT+QA0kBfP58QE+4uKvAeBomHd9/aVFkLVSiGHREOzpnBJkNuy40WWGRL+nbqLpq8EMcw==
X-Received: by 2002:a4a:97ed:: with SMTP id x42mr4588130ooi.40.1621347384239;
        Tue, 18 May 2021 07:16:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id f9sm3854799otq.27.2021.05.18.07.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 07:16:23 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] read-cache: use hashfile instead of git_hash_ctx
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
 <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
 <b94172ccf5e91fe59a1d32774dbec23e624f1135.1621254292.git.gitgitgadget@gmail.com>
 <xmqqfsyl57q2.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1641be46-c8d7-08ae-ebe0-7f3eb3589b27@gmail.com>
Date:   Tue, 18 May 2021 10:16:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqqfsyl57q2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2021 6:13 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> ...
>> mult-pack-indexes, and commit-graphs. Therefore, it seems prudent to
> 
> multi-pack, I would say.
> 
>> There are still some remaining: the extension headers are hashed for use
> 
> some remaining what?  I first read an unwritten word as "issues",
> but I think the answer is "uses of git_hash_ctx".

Thanks for pointing these out. I will fix them.

>> in the End of Index Entries (EOIE) extension. This use of the
>> git_hash_ctx is left as-is. There are multiple reasons to not use a
>> hashfile here, including ...
> 
>> In addition to the test suite passing, I computed indexes using the
>> previous binaries and the binaries compiled after this change, and found
>> the index data to be exactly equal. Finally, I did extensive performance
>> testing of "git update-index --force-write" on repos of various sizes,
>> including one with over 2 million paths at HEAD. These tests
>> demonstrated less than 1% difference in behavior, so the performance
>> should be considered identical.
> 
> Hmph, does that mean 128k buffer is overkill and if we wanted to
> unify the buffer sizes we should have used 8k instead?

The buffer was previously increased to 128k because it makes a
difference in performance when writing the index.

The thing I'm measuring here is the difference between the old
writing code and the new hashfile code. Using the hashfile API
(with an identical buffer size) does not have a meaningful
performance impact, as it should.

I can make this clearer.

> Wait, the removal of fsync has made things faster in general, hasn't
> it?  Did something else degrade performance to cancel that gain?

Are you thinking about [1], which originally was talking about a
change to fsync() calls, but really ended up just making the same
behavior more readable?

[1] https://lore.kernel.org/git/pull.914.v2.git.1616762291574.gitgitgadget@gmail.com/

I was focused on that because I had initially seen a performance
degradation when I did this refactor. It turns out that my measurements
were not robust enough to the noise, which has been remedied.

> The patch looks an obvious improvement.  What was open-coded in
> longhand is now a well structured series of API calls and the result
> is much easier to follow and maintain.

That is the goal. I'm glad you agree.

Thanks,
-Stolee
