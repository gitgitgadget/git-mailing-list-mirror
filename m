Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B081C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 08:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A11A61051
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 08:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhIDI7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 04:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhIDI7e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 04:59:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF74C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 01:58:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k24so1411192pgh.8
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fXnLQBwy0yJXlrujPsPMvIiRzVZXn0ggQBhpuN/jnWg=;
        b=oya9BrHHJylPOB+bWhehuTp+/FsmkDeDOk1jcNoHAQhuLRQoE6pK5jvuOvAEHCJE+9
         /RiAf+Z/1EddQo8w7dDssfxUBh6kDcH4NWHiEzP9ClQyo9kioMMUEN/+GD4brdzmrAYo
         ehNWHCG9u3Pz5HaeKQyxMtFxO+S1BjJWEQHMruDtiRg5v5RAfeX6qts0i9MWB8FRIxvC
         XcrGFnfu979qg1lwGm11CB9o/FOq/Mof03XwVMguOGMtDiCTgVr/6DKR7kpdO88tx48T
         YsM7IKXF12WPtsBHUBye20/mZupawQSZ4fq82gci6Xjo9RGR8n/8Afje+BEkaY5+uRlc
         xeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fXnLQBwy0yJXlrujPsPMvIiRzVZXn0ggQBhpuN/jnWg=;
        b=p4CwMC0DpCAqt/sF46MPuUuW1x2Dq1ZUppRI4xZUhHrJtotemnyNq2xqpFtkod3xZy
         5MK8D9XtfoY4o9MAdSaLYPz7+UM68n13E3a+0i5v06BtRQ8ikvF0X+9niT7Lx+/s/Z5v
         OgsNNBYAITP2JFNz0BJA69bPxEd3k0PqnoTbI74Bc+IiLy5/RA+1X9Ubog+CYTAcCoof
         0/n0WTBFELUormoX4sbHG5nUl4vmicmS5PQESL2/pSAZMn0tz0knUM4BRJX+24KjDc5V
         E9XN363yAbQvMuqHvcuDMMg3bn+GXQma5q9Ah9uqmJF3wcpgxyqiokdrP180CXMPVDqC
         r7Xw==
X-Gm-Message-State: AOAM530ulAVHN76x653EchB8lTUOs95k2VuTVT3BtxA9TYcT6pPEbHqa
        9lykifZaE/Nqy7FlvK406EcHbdWWfleaKw==
X-Google-Smtp-Source: ABdhPJxJuHMa+bUqWzrk8yF/msWf7YsmJAcngTcPba3z5aeu9b4MJMUO0XEgTNuKBTbZY4WQp1IDOQ==
X-Received: by 2002:aa7:938c:0:b0:3b2:87fe:a598 with SMTP id t12-20020aa7938c000000b003b287fea598mr2875167pfe.74.1630745912610;
        Sat, 04 Sep 2021 01:58:32 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-73.three.co.id. [223.255.225.73])
        by smtp.gmail.com with ESMTPSA id b20sm1608966pfl.9.2021.09.04.01.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 01:58:32 -0700 (PDT)
Subject: Re: [PATCH v2 07/15] scalar: implement 'scalar list'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <fb7c931ddb3a248542bc6a03d09189e937315d0c.1630691688.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7d68dc36-81b3-1c8e-61d7-c656aee8c1fb@gmail.com>
Date:   Sat, 4 Sep 2021 15:58:27 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fb7c931ddb3a248542bc6a03d09189e937315d0c.1630691688.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/21 00.54, Derrick Stolee via GitGitGadget wrote:
> +List
> +~~~~
> +
> +list::
> +	To see which repositories are currently registered by the service, run
> +	`scalar list`. This subcommand does not need to be run inside a Scalar
> +	enlistment.
> +

I think the man-page-style wording should be:

> list::
> 	List enlistments that are currently registered by Scalar. This
> 	subcommand does not need to be run inside an enlistment.

-- 
An old man doll... just what I always wanted! - Clara
