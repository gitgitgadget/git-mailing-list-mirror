Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB703C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE62A61412
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFDNOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:14:21 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45872 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNOR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 09:14:17 -0400
Received: by mail-ot1-f45.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so8963329otc.12
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z6mkHZXJOwoJvLjBfJNuWyyRu29v1jGEH1soRTdDZhY=;
        b=kvP1JVexgyjet4lMbZ4gYuKeIlsF9jChGPQFT7Q69HIywA/r9768YTKMNG+Zx3Gq8E
         UFXHSYT4OTMem+P+UquH6YLBgwohlhhlmmLgN6GyXaTKg5wgl6RBwPcSZPNcs9Evrjfk
         MfdU6oMFyqw3IIgiY1duf1MVNObHASk2Id34FeWWzOLNVpoyDnJG8pnBW02NNqteN5JJ
         T5oD4cIWc/CWQE/mm6VIXOFfPMBjOzmNJm7e/xGZhK5i3+X9Q+YJO34mWDRe5L040uJa
         Oy5PSSaPUPfPmcCDrA8/qpz8d8QFcVMuncfIHYt74ElLOARep5nmMVdRvrCv0BIGFUEE
         UabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z6mkHZXJOwoJvLjBfJNuWyyRu29v1jGEH1soRTdDZhY=;
        b=YwjmX/rIK9ez23KEht2uItz9nHO0yI0Rnnzz0sgAwRtP9kJpDbX/1XbyTmMnMZ51zx
         F4eZHvkP5+bv6Z9jmOPXb+mpV0S1yCH9BRMFEMz1tLVFAJ6FSv2mWm1Dj54/+IrNBz9C
         Ixs1t+WBPtYAc7UUYrdiRgqhKV7ItNJhTMsBwV+pjdLXgzJAnDAOSZY/fC5CV38b/Jns
         0J0lksMiwZN+rdOUfmS+lrNnjVdKO7lRP+12rLslJAs8Yp4E7bj0DjR1AvSEVtuBF9d3
         XuL5WS6h6MaXfRycwYmW7UNbBOTrJPN5fmGYNalCArm4QnK+w9ijOOqsWz6p1nkKugOO
         RWHA==
X-Gm-Message-State: AOAM533hJt1SwRInjlFlmctDYVpnj3U5BiioytvPlTZu1bV8I4kHifa8
        rsxBgBUFTRKPSfYWNnHMOkA=
X-Google-Smtp-Source: ABdhPJwvYSZFYyLzG7Tna8wGR9arDlOjoTuKsI/IUjzodQA9Nv0yXyzeGa4O+ewHo0mHg9etJ5XOZA==
X-Received: by 2002:a05:6830:1505:: with SMTP id k5mr3744984otp.45.1622812278496;
        Fri, 04 Jun 2021 06:11:18 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:a8e5:75e1:b132:878d? ([2600:1700:e72:80a0:a8e5:75e1:b132:878d])
        by smtp.gmail.com with ESMTPSA id f16sm405373oop.6.2021.06.04.06.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 06:11:17 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Optimization batch 12: miscellaneous unthemed
 stuff
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a5755340-c0c8-8028-7c03-3c8e7f0268d1@gmail.com>
Date:   Fri, 4 Jun 2021 09:11:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2021 12:39 AM, Elijah Newren via GitGitGadget wrote:
> This series depends on en/ort-perf-batch-11 textually, but is semantically
> independent of it.
> 
> Changes since v2:
> 
>  * Made suggested minor tweaks from Stolee on Patch 1
>  * Dropped patch 3, for now

With these changes, I think the code is good to go.

>  * Added Stolee's Acked-by
...
>  1:  c4a0f6a9510c ! 1:  f63ffc2a7c22 merge-ort: replace string_list_df_name_compare with faster alternative
>      @@ Commit message
>               just-one-mega:   500.3  ms ±  3.8  ms   480.1  ms ±  3.9  ms
>       
>           Signed-off-by: Elijah Newren <newren@gmail.com>
>      +    Acked-by: Derrick Stolee <dstolee@microsoft.com>

I believe the sign-off should always be the last thing in
the message. Perhaps Junio is willing to fix this without a
re-roll?

Feel free to replace Acked-by with Reviewed-by.

Thanks,
-Stolee
