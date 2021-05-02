Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F801C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 11:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFA061208
	for <git@archiver.kernel.org>; Sun,  2 May 2021 11:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhEBLNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 07:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhEBLNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 07:13:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490DC06174A
        for <git@vger.kernel.org>; Sun,  2 May 2021 04:12:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v13so1315167ple.9
        for <git@vger.kernel.org>; Sun, 02 May 2021 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J3fY5rEz0vJkbTx+Etctkg6PirB9FxCa5PAI/htuSyU=;
        b=Hr/l2RosMIYupAPx5AY02dW1zhPZbNPOUsmgytgHbbW5PMsGMKHV5FoW6Cg8oliDBP
         VUQVGVVuYXeQmLEGEElOtm92PF3O/5ifhzAVXFQ8A0VAmJs8cZtk5urC+Frxndn8OZ+O
         Waf+SKC9M7n18djWz3VWmySQSk7FXoeE6AbR5IKcbR0UEJzptUZz2/yzSEo63D13uDtZ
         gR8Cw6DvZYGjttOCHy5uTmWtfo7sTBJuVTys3q9c2DiiHR9anen3akK82iL/DE61OnG5
         8CicWIRrDjUr8D8PvCjmfqvOuDCdFJn31zyhkgNDxzj1SPnr3VgiiiMONlLxjM1MJ2Od
         YOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J3fY5rEz0vJkbTx+Etctkg6PirB9FxCa5PAI/htuSyU=;
        b=pO0vHVSqYJQ8kscpu1ksnj8ZKM7ifiQY31Rx/TKfftc5rC9cMbi/OUKEKtXX6HPg6f
         TFqRchG4F+mZcEC/Y8ezNWA0OdtOWSeHbM0QSEOwFpNEXin60QlHlfzNn0DaRGPmST2I
         tyCrcdVRd9ffEytS4Z+rj5IXtgc4OIhTcNLmQfgjv++ghf1mHzu9eNbyKi+PqCvTwjxm
         7XY/cyABjDuwqw+d7nmdroPRlEEc0R3/zSdiHLohldjsCp+/62k3cIwACK7Oy1RENDDb
         MeZjxdVrrCjcRIVv8j7ZOMir8lJ0kKfJutcgm0iZmuBkwVE9sWkD3/Q18FHq2oVNVRBN
         /zMA==
X-Gm-Message-State: AOAM53124H850LXJJajd6jpelGo04y1ygb66kgvhIixRFoaAxnnzseAd
        XiGezeF9cKht4zv137VY2hS+7evtpSO1YQ==
X-Google-Smtp-Source: ABdhPJytdfo+WpYo11QsxubniwxxAHXQDt2NjRDOp7rvs4a2Sw1RTSuoR0akujdyi7E155NMcxBBkA==
X-Received: by 2002:a17:902:74c3:b029:ed:5a91:472d with SMTP id f3-20020a17090274c3b02900ed5a91472dmr14930278plt.32.1619953930223;
        Sun, 02 May 2021 04:12:10 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-61.three.co.id. [116.206.28.61])
        by smtp.gmail.com with ESMTPSA id l127sm379950pfd.128.2021.05.02.04.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 04:12:09 -0700 (PDT)
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <d27d4832-0dc0-ae01-cb2b-264c938b1649@gmail.com>
Date:   Sun, 2 May 2021 18:12:06 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210501145220.2082670-1-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/05/21 21.52, Lénaïc Huard wrote:
> +BACKGROUND MAINTENANCE ON LINUX SYSTEMD SYSTEMD
> +-----------------------------------------------
> +

systemd was repeated twice above. It should be
`BACKGROUND MAINTENANCE WITH SYSTEMD TIMERS`

>   test_expect_success 'help text' '
>   	test_expect_code 129 git maintenance -h 2>err &&

Why exit code 129 there?

-- 
An old man doll... just what I always wanted! - Clara
