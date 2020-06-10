Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DD1C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCF22072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjVK/8Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgFJRmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFJRmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:42:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C363CC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 10:42:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v13so2375605otp.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LkFqK5Su2o/4KDN15TPjGZ537xMi651dEzdEJ35Svjc=;
        b=FjVK/8TnwbtPb4Rxd0NPNRrgOrBozwwqqM34qPKM4dHiPWM8T1NszJMOOqZketvk6g
         TfWN6mSuWVTDye5m4yaQoY2lFyDQFGoQwr4zo86+zNdwbzaHRVHOrWFel+GJWlmYUj4G
         RjvwJ0Df3w/f2dAgbdliepJioZwtkCPH+E5jB0b6+vqymRW3Jt7gH++NzpNa/pAJ9EOu
         ovIOtPm5Q25zg846ZvKIg/fhBEeuycL2OeBhcUv25yUly67a1CU45KvxUoSw9jpfvM/s
         f6M4BGMa+tgLr+tXropDZwDC2Ce7bhg9K1oBtlpkNRqqhtiV2H+/4naOReAmzUGHwbxr
         nTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkFqK5Su2o/4KDN15TPjGZ537xMi651dEzdEJ35Svjc=;
        b=lnYNjWOJMoR1mR1O9QLYvp8qVxneSwF1TFrtx+V5ZBvqDYtbcrfxAF4tI4aJC0R+k4
         CyuDRHSvQvua0GTzHUt5KUZauOVA6Ij+xBn2/ahXazmcbTL2sK8QdFPqlWLqCINPhxM5
         ff1n9rEjLDmWt7BvPd2ObEliM6ilAslGcan/8jgh0US8ZIZ0IsCdVFopyQhSe4uu9z2p
         igvYFHdzboOrVrDEeaQZrdz8Kw8ZXnHPP6WdadyTbKv7TOytIdVZEFYqx6pwVQ2CBn0w
         nKyOrd4feO//SLyOof3hUwkr2F2Tv/KrPERHmL+GwyITQHdO1/HKkcQJOC1+Vt3RRNdz
         3V9w==
X-Gm-Message-State: AOAM533Ktz2BfFja5Y1/52gPLpUHMQRwqD6t4wRZNeBHuy66BxAzuukH
        ng8Z1w5nPAR5nz0dKsMhaFQ=
X-Google-Smtp-Source: ABdhPJys9vC4x1VpougqNMHRmuJZrFTwvKbpmv+8WTBrJzfWvuLtpknL3gV0f8jpTsz1QWTH8YSYGQ==
X-Received: by 2002:a9d:1a7:: with SMTP id e36mr3530177ote.215.1591810926969;
        Wed, 10 Jun 2020 10:42:06 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i2sm132270otr.49.2020.06.10.10.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 10:42:06 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com>
 <562542d2-2a90-8683-a7fa-cbffb2e26bff@gmail.com>
 <CAHd-oW7BXWzaWsvsh0dQt7NgeBcz0HSbcwKVYA7sPjUinarsng@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <909e19aa-9d96-a68a-eed0-d721948b9dbc@gmail.com>
Date:   Wed, 10 Jun 2020 13:42:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW7BXWzaWsvsh0dQt7NgeBcz0HSbcwKVYA7sPjUinarsng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2020 12:22 PM, Matheus Tavares Bernardino wrote:
> On Wed, Jun 10, 2020 at 8:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 5/22/2020 10:26 AM, Elijah Newren wrote:
>>> +This may mean that even if your sparsity patterns include or exclude
>>> +submodules, until you manually initialize or deinitialize them, commands
>>> +like grep that work on tracked files in the working copy will ignore "not
>>> +yet initialized" submodules and pay attention to "left behind" ones.
>>
>> I don't think that "left behind" is a good phrase here. It feels like
>> they've been _dropped_ instead of _persisted despite sparse-checkout
>> changes_.
>>
>> Perhaps:
>>
>>   commands like `git grep` that work on tracked files in the working copy
>>   will pay attention only to initialized submodules, regardless of the
>>   sparse-checkout definition.
> 
> Hmm, I'm a little confused by the "regardless of the sparse-checkout
> definition". The plan we discussed for grep was to not recurse into
> submodules if they have the SKIP_WORKTREE bit set [1], wasn't it?
> 
> [1]: https://lore.kernel.org/git/CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com/

Thanks for correcting my misunderstanding. By introducing
`git grep` into this documentation, I have also made it
co-dependent on your series. Instead, Elijah was probably
purposeful in his use of "grep" over "git grep".

If we revert that part of my change to use `grep` instead
of `git grep`, then is my statement correct?

Thanks,
-Stolee
