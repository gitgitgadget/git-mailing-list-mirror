Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83FFC433E0
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 01:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB6D6197D
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 01:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCTBpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 21:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTBpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 21:45:09 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E170C061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 18:45:09 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n140so6751573oig.9
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 18:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oq/7EzJttlCleiQL7YZtEc13WtiyJsSFxteeJ68ZEwM=;
        b=EWIBW70hYuhaVTguj46mnZWPp+oTKLa7u6nL3d2w1bUd1NtpE5C4cnrURvsjFPEofR
         rRw+Q2YrqFCqVFDQzlTHDsFP4u6NXp9IcIja+9w0lpoIrj2ZUAqlUtk2XYljX6Z353Pi
         qvayfaX5BJeXnfLI2SmvCLgpG40f89O4FX6IqE79qsH1fAxrD8ZotzBna0LzTc0s4II2
         QwRArsDttDZtrXiYxDkZnUG53eDXQ6yYvLu60MqpQaYxt0uskvktLa6FXtyrLE2FUFfD
         UT7dBPfNTbd8NZ5C4OD9yFhtUzqch50v70+Df5NJrIvcsHlgmOyXtFx3fH5Utbv79sbh
         maZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oq/7EzJttlCleiQL7YZtEc13WtiyJsSFxteeJ68ZEwM=;
        b=qoAfzSVk0/xxsi2pARTCbT/2PTicMlV0ZCZ/N78dMBLBY5EVjV+Ytq9rXrxflZxdgF
         TfaHUw7J649K8LVFg0fVAYmGUAtMcMRI8cDKxtyWGPb90Jn5YcgO0EpR1/TDU6KJuFwF
         YUuu9FxUdsXW5bVKthbmvaWSc7qoY8+l2+bKM/74SARGGle3qrJkFl2NFYEBXmX2lWed
         K46h6oEWr8k1+ydvIuW3FC04P67qPRxBvMrw60gV/EYUByiCk9tF/j54EPiovQ01m5Gv
         7+5v6cnTTSAwzAlTdJZfPEhJdHLVcBtHsAvCUsvtuKPZ6gs/tqRFF6HkvjyRUvt5cWBk
         gjVg==
X-Gm-Message-State: AOAM5322A24QCZbuL2vKcbmIaDW0ITSxoGlLtaq3mL1eBYLEUG0IkKah
        2anbJEKV761U8IsIVLydOO/GBsJ7ItDKUw==
X-Google-Smtp-Source: ABdhPJy+pOu7jYRKt5qn8Q887HT68Fqqstdkv042BovtBSWZYAPx/6N6J7ZiGaA8sxbnZ35g0vx85A==
X-Received: by 2002:a54:4507:: with SMTP id l7mr2850193oil.165.1616204708750;
        Fri, 19 Mar 2021 18:45:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5c2:d98f:a8c3:5198? ([2600:1700:e72:80a0:5c2:d98f:a8c3:5198])
        by smtp.gmail.com with ESMTPSA id d24sm1531184otf.12.2021.03.19.18.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:45:07 -0700 (PDT)
Subject: Re: [PATCH 01/27] *: remove 'const' qualifier for struct index_state
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <628e16dd3fc7be96d40a7b3201573a71ae7fbbd6.1615929436.git.gitgitgadget@gmail.com>
 <xmqqwnu2lux2.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b98a1080-2481-508e-bf3e-50ea665d8e21@gmail.com>
Date:   Fri, 19 Mar 2021 21:45:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqwnu2lux2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/19/2021 5:01 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Several methods specify that they take a 'struct index_state' pointer
>> with the 'const' qualifier because they intend to only query the data,
>> not change it. However, we will be introducing a step very low in the
>> method stack that might modify a sparse-index to become a full index in
>> the case that our queries venture inside a sparse-directory entry.
>>
>> This change only removes the 'const' qualifiers that are necessary for
>> the following change which will actually modify the implementation of
>> index_name_stage_pos().
> 
> This step has a bit of interaction with Matheus's "git add/rm" work
> in sparse checkout (mt/add-rm-in-sparse-checkout), which I believe
> is still in a bit of flux.  I didn't check potential conflicts the
> remainder of the series may have with other in-flight topics.
> 
> So, I may throw review comments at the patches in this topic as if
> they are standalone, but please do not be upset if it didn't appear
> in the 'seen' topic.

Thanks for the point. I need to reset my expectations about how
much I am stomping on other topics in flight. I rarely work so
widely across the source tree.

I could split this patch out on its own so it can fit into a
narrow window between other topics that might collide with it,
then rebase the rest of the series on top after things settle.

Thanks,
-Stolee
