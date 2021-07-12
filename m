Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143AFC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 04:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6ABA60D07
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 04:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGLEp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 00:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLEp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 00:45:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9C6C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 21:42:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m83so7562412pfd.0
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 21:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IkuPuQqL7VYseGffegfIiIYyrXNYAbLLunu4a8qSXyE=;
        b=O0+m7FId7RB7dmhVtAUIl0PT6kVxu1/qV3sgrYXcYqo+ipeE5/y7p+s7lKeH9Jl+RC
         UYHmgfp3LEBDqkJb4ASPUTdo5770M708lQgGRMvGgr5vqGnvoGl8058AvnSehQR5I6QO
         oMXcPwUg05nbgts3Ah0fmlxp1QqZywJxuUrI4h6m5+LiG+3XCKtf+pkBWhhvHhT75Ikz
         7eOJLEQQmzMJ1IQTjuDGV9HUbfrpjR5kZuq3SDTyshexGqTyoRqXPMJiCNQxfoxUMO1q
         UuB2HMeydbi1NmxVRy4ap2O+uHA1wEw37dxP+3X5im8bYvJfzQZ6PDPi8YriQOKBvI3i
         XadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IkuPuQqL7VYseGffegfIiIYyrXNYAbLLunu4a8qSXyE=;
        b=qQuTe786x6mqNh1qhcIv4ec0IHYZqNT0Vk4loWQjcQ918Dm2HqXAWD4kvpS8Vpr4vb
         cqx8KdUokJUiPZUc/6T2h5LdRcNgWnieJfYWwE/RtlLpqb4JDQ2L5uCmGnb91rjDD8Jd
         bZLRFk349biuZZgRzRaSQPpFD4PkFb6eDcybNl0yFl2slZFU/0ro0/gQhqXmjJz8Nl2P
         oZHJpEN4IlFzHt9YcNoJ3lCgkhERUW04IL2tEvJZc2EpKcg5xmAlaJtAI3qFpz478N/m
         3FyJe8gyCsG6OanQ1wymaXa3+TDltZKQ2CU3CZktCxZQMm3X31d/yqf7j/J3cB6agELN
         SjQA==
X-Gm-Message-State: AOAM5331GMnaMe73CO/P1v+VNfA2FIDD2cDYjivtL19iCV8a4RgvQVan
        0S8gtm83b2aNsfyh2Jtw1mU=
X-Google-Smtp-Source: ABdhPJysjN3/nv8hFATMOZ/kRL0XW0yIu6pwUnPr3/bN13fJBGws97F+hnyBBlzlAtzXBK7LwlqyLQ==
X-Received: by 2002:a05:6a00:99b:b029:312:d3c7:3637 with SMTP id u27-20020a056a00099bb0290312d3c73637mr51406359pfg.22.1626064958345;
        Sun, 11 Jul 2021 21:42:38 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id a16sm2646885pfo.66.2021.07.11.21.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 21:42:37 -0700 (PDT)
Subject: Re: [PATCH] test: pull: add test for disabling pull.ff=only
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210711170703.651081-1-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ef5ca2bf-3a7a-aa9e-40a2-6b1fe04e323e@gmail.com>
Date:   Mon, 12 Jul 2021 11:42:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711170703.651081-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/21 00.07, Felipe Contreras wrote:
> The advice clearly says it should be possible to override pull.ff=only
> with --rebase:
> 
>    You can also pass --rebase, --no-rebase, or --ff-only on the command
>    line to override the configured default per invocation.
> 
> Since the intended behavior of `git pull` is very easily forgotten let's
> add a test to make sure it isn't.
> 

Is pull.ff=only only do fast-forward merge when pulling?

> +test_expect_success 'pull allows non-fast-forward with "only" in pull.ff if --rebase' '
> +	git reset --hard c1 &&
> +	test_config pull.ff only &&
> +	git pull --rebase . c3
> +'
> +

Better say 'pull allows non-fast-forward (using --rebase) regardless of 
pull.ff=only config'

-- 
An old man doll... just what I always wanted! - Clara
