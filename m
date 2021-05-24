Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C16C2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9473F613F4
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhEXUju (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 16:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhEXUjt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 16:39:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32960C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:38:21 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so26531244oto.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7i3P2DKk/VVzgAGgwKWmfFwL9Y5CkUcCeDzX3n1AQSo=;
        b=Rpsz9qsJTLNzFvWyZUrElN2fyiBU2f10qTqB7zI0kG0vlE5wY/NDo/ryeO9tg/IGrJ
         4cC87OP3+KL0o3Uem9Lk8tCw99OB1UVmGnIVWGbxhDqCIy+9j0auyA2RO1Eqvk8O1fOH
         c10MSfekUFsY41hTtXvS3JcSqjE9GP8pj0C1fXQvzi0tFZJa6yMVYM8wp14j9zYn31+w
         z8oCfagZtEh6ObODeFoiS2AB8WZBMGMDF0tDrIikANbxq0LV8Rxgvk6+qFdIxJtGzWy5
         kMe9shNTr1ArRfcYvs6oWNuSKalnEOWiatXRTdA9ZPmOWHG788JloAWLhT82I6C/mhiQ
         kBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7i3P2DKk/VVzgAGgwKWmfFwL9Y5CkUcCeDzX3n1AQSo=;
        b=ZNEMziVXCsStL6631VGetLB2nwoeDiig7YWVz2S2ZiKFmRBxrSDYQfQr9Y3bm+LXgJ
         PJg5WK56oWbRiTOhcbFedY2dFTpx4LcCnLWrsowcNFEPJnXMM5mWQRy/CRsxl01oppOK
         6Uem78YWrX3wfdydfYOSUWcMQGVpJXY1bm8ucDEcV3LX/tM7Gd/5jg8gzYW9jrQs/sk6
         BSFgQ0e9Mhx2Ehi/DqGZ20rLOmWuuZ5LFMKwOusK8K+8j+R4NiJQG+bz6gbhKxzhFTHQ
         2KA37zpTCJWbbb7M71jFJ8st8vxcFJa5zJne4kiB+hKv6pzETv/xyWsxRun5RRqo2lVK
         GBHw==
X-Gm-Message-State: AOAM530tAzylCByiSHRmJgCb6RbB0uAdQfvvcVRWopYM49doiHyXesPz
        UUDNYmfl1B+UPz2qrBbPWYk=
X-Google-Smtp-Source: ABdhPJyDe/kpnEuUd6ZhXkYgrJLAS0PyRm0y6W9MbVxJM6ypDI380BcGxkjtDJzB9wiUEcWzm0DJ9Q==
X-Received: by 2002:a05:6830:200b:: with SMTP id e11mr20552335otp.349.1621888700378;
        Mon, 24 May 2021 13:38:20 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:5dc8:cb50:677d:c06d])
        by smtp.gmail.com with ESMTPSA id q1sm365850oos.32.2021.05.24.13.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:38:19 -0700 (PDT)
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
Date:   Mon, 24 May 2021 16:38:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKwMU13DOtTIgaeP@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/21 4:28 PM, Jonathan Nieder wrote:
> Hi,
> 
> Derrick Stolee wrote:
> 
>> The t1092-sparse-checkout-compatibility.sh tests compare the stdout and
>> stderr for several Git commands across both full checkouts, sparse
>> checkouts with a full index, and sparse checkouts with a sparse index.
>> Since these are direct comparisons, sometimes a progress indicator can
>> flush at unpredictable points, especially on slower machines. This
>> causes the tests to be flaky.
> 
> Hm, I think this test strategy is going to be fundamentally flaky
> regardless: Git doesn't intend to guarantee any kind of stability in
> the exact stderr output it writes.
> 
> Could the tests be made to check more semantically meaningful
> information such as "git ls-files -s" output instead?

The test is comparing the same exact Git command just with
different configurations. Any change to what Git writes to
stderr should be consistent across these, unless there is
an explicit reason why it would behave differently across
these options (for example, saying "You are in a sparse
checkout" in 'git status').

There are no expectations that stderr is stable across
versions of Git. These tests don't add friction to developers
making new features or changing the error messages that appear
over stderr. It's just that these tests should catch any
unintended inconsistency across these modes.

Thanks,
-Stolee 
