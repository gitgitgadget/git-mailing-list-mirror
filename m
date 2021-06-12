Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6EC48BE6
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 01:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E180F6101A
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 01:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFLBTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 21:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFLBTa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 21:19:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482CCC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 18:17:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d16so5802516pfn.12
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TlTLuslQ4y3N0bLXm0hh2fqsrAEh1i4MhYcvAgzy6s0=;
        b=RXx5j1Ust54KNXaOyReezxG8byJ340zUbyyrrGx7J66umuFeL4XPowuWmYyL47KyBT
         QJ5X1ZPiOvOXm4YQQ8yS6O1197x4wKyMHaTdKN6j4uJS6VwBe5PM1k/VegSytudJZCu2
         HZOSVPliqS9HE4vvyMqCJHIbv5wux/Pj7KW/k0QUPvhgW8sgEURKq6iFCKoA5SVfj7Cc
         xsj9QHiYyc69lzi3wEAH/TcHD2FbGaEvxrLcMlfR0YipR6pNeMgYcVMlCKj0XYMCMYLq
         RihD8NQ0in6o3VwSGXQw0Wq0QscQwuB8V05T/hzCbX2u78ofFKIij+7d0KS6hEI5Ysrg
         jd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TlTLuslQ4y3N0bLXm0hh2fqsrAEh1i4MhYcvAgzy6s0=;
        b=PNsxYp30+SfDfZdQck6kgcrC/rudl2Pue6Aktb3pN2TvrqfWh6qkucJsXB0T5zYnVu
         w2gXbYK8lUQT629QvVOiTbd/NlJkTEeklFtTKd/ZHrcNgZXBmoEWzMyTl54M/impzHj6
         /4nJgZqfbPETEi3+f4ukYYWCK2iqH/rklnfmguVNaMei6RLlkP+r35e/SxW6btd9I2h9
         SjFiwZETbDyRb9D+ipr+6R+IwS0u+A6TJ+R/lDOjXT9ajIqpzvWN6rSrei30ErYNhN7Y
         OOkXWa9act4SmmLjqDPvfb8C5GYvGG7zcfIllsHvBB2CCOiwRH0TAYcYhG+b6l/qZnqq
         PtBg==
X-Gm-Message-State: AOAM531cdXnxGWjhFVmlis8VHCegNrh/eNwIZ51RJuBvWOM77rpJtXvv
        y5FLTW/X+oAge51HkmrXjvucXxkrXdXmWQ==
X-Google-Smtp-Source: ABdhPJxtMyVATtFoTBoNspD+FOuTbPFx6P7U2THEtQzzdh0vplv56M2VGVNM1/v6qWJ7gzhbOltPYw==
X-Received: by 2002:a63:8f0b:: with SMTP id n11mr6194671pgd.342.1623460636782;
        Fri, 11 Jun 2021 18:17:16 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-226.three.co.id. [223.255.225.226])
        by smtp.gmail.com with ESMTPSA id p9sm87591pfo.106.2021.06.11.18.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 18:17:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] Avoid gender pronouns
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <57c48ef2-7fac-4d3f-e74b-a3ad44c49480@gmail.com>
Date:   Sat, 12 Jun 2021 08:17:12 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611202819.47077-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On 12/06/21 03.28, Felipe Contreras wrote:
> The latest solution looking for a problem [1] is to use the actively
> debated among linguists singular "they" [2].
> 
> Leaving aside the linguistic intricacies that not all singular "they" are
> equal [3], and the overwhelming sentiment that these kinds of political
> discussions don't provide value for this community [4], the "issue" can
> be easily solved by simply using different wording.
> 
>    - The reviewer herself
>    + The reviewers themselves
> 
> Problem solved.

So this patchset avoids any gender pronouns by changing single subject 
to many objects (plural), right?

-- 
An old man doll... just what I always wanted! - Clara
