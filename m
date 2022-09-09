Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E8ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 12:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIIMtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIIMtw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 08:49:52 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9BE32D80
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 05:49:50 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b23so1162515iof.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=H3AR0c94vpi/q7TA8/+jX9VYOhecHkcr90dgOnIZ5BM=;
        b=K1ezI5ieao9bCjCK5NrhggQiQs5WGua6NuOkPo6iqMsT3knzil9g8HSGBSUbjEANrg
         fFqgHYBC4l9EjSQ0yTxpkqslGu+MSbK109ZhtEO6E1QQ/QjbpTvPdpX211ua+IHdYbS1
         lq152EOkiS04rPZy9pluTKgzUCHEqKhHyk8H8pmxDJGY2XLZHBHwJh/WHsGZgCmopWa8
         knOaWqNAt3vSwSkgnOagVpp1PvxCmkXvX90TTsiXPNK83G1X6r4ZKWI4qQBYFjAkE9HF
         CtaJw7SG5FyG5oXQkXVQ/tFRr2RKJRyofpn0FR2fyNiNvBTjY3JznUdrbPTS/VysLJeZ
         853Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=H3AR0c94vpi/q7TA8/+jX9VYOhecHkcr90dgOnIZ5BM=;
        b=QEQdVnwA9cPFpfsF/rxLFAXOjXI35ATFTsRzuC0InbUxf1KvZFrXnitGUcIpFDhMh9
         qW/RIYyAp1URdjDyhamqlV5YbXUvE3oQHNnVz+11sY1xNG77vqcU8uyI7L8I+yQQ4hcV
         qBJRVKOWpgjMFi/CKzE27Nfbitd9caIsjzgapop4fAO+IHQK1Nxxj+cNg4clw9n6bHen
         XDZlgaer4Vx1z6KVVtUTPfUpCpaC9vx12PmEkZf+dWYwSStJpNbdJUxccdgb6MwFnM8J
         TfFKf/Jpc50Kf0mUEnjxxrDT/J6Gxz5NUYt0IwA9v99afeL67h87o4fyfZnmetFgYL/j
         p3Jg==
X-Gm-Message-State: ACgBeo0OI7PhJbcPD3u7BPRpLsbzdXTga7rghcgvXkSVNQNsHXTO40G6
        AVjYdHOc9a6q5VGsRArpyhC6
X-Google-Smtp-Source: AA6agR4qU7spr+515w18WXNuaZOLcB9i/Dfi73cXu8zWotWvhu+UxwvX/OJc1HfKS1Cohg4Wee7q7g==
X-Received: by 2002:a05:6638:349e:b0:346:ec62:5851 with SMTP id t30-20020a056638349e00b00346ec625851mr6754956jal.157.1662727789760;
        Fri, 09 Sep 2022 05:49:49 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t8-20020a056602140800b0068a235db030sm209363iov.27.2022.09.09.05.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 05:49:49 -0700 (PDT)
Message-ID: <2badb772-2aa2-460c-818b-5aab8497000c@github.com>
Date:   Fri, 9 Sep 2022 08:49:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, vdye@github.com,
        git@vger.kernel.org
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-4-shaoxuan.yuan02@gmail.com>
 <xmqqczc5rblr.fsf@gitster.g>
 <093827ae-41ef-5f7c-7829-647536ce1305@github.com>
 <xmqqo7vpoaan.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqo7vpoaan.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2022 4:56 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> HOWEVER: it "doesn't matter" because the sparse index doesn't work
>> at all within a submodule. Specifically, if a super-repo does not
>> enable sparse-checkout, but the submodule _does_, then we don't
>> know how Git will behave currently. His reasonings go on to explain
>> why the situation is fraught:
>>
>> * command_requires_full_index is set in a builtin only for the
>>   top-level project, so when we traverse into a submodule, we don't
>>   re-check if the current builtin has integrated with sparse index
>>   and expand a sparse index to a full one.
> 
> Correct.  
> 
> Is it sufficient to propagate the bit from the_repository->settings
> to repo->settings of the submodule, or is there more things needed
> to fix it?

Likely that would suffice, but before we do that, we need to add a
lot of tests to be sure our previous sparse index integrations do
the right thing when within submodules.
 
>> * core_apply_sparse_checkout is a global not even associated with
>>   a repository struct. What happens when a super project is not
>>   sparse but a submodule is? Or vice-versa? I honestly don't know,
>>   and it will require testing to find out.
> 
> Naïvely, I would think that we should just treat a non-sparse case
> as a mere specialization where the sparse cone covers everything,
> but there may be pitfalls.

I worry about how this works if the super-project and the submodule
differ in the core.sparseCheckout config, but both have sparse-checkout
files. Will one or the other cause the sparse-checkout patterns to be
enabled despite the repo-local config? I honestly have no idea, and I
don't think we have tests that protect this scenario. That's the kind
of direction I would start in this investigation.

Thanks,
-Stolee
