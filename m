Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDA8C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E47961261
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 17:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhHVRFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 13:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhHVRFk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 13:05:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2094C061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 10:04:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so203313pjt.0
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gf8wIO5493fzzODwj/p/NGZB4bq+VN7BJmqPFCsISwc=;
        b=KvY0L1jK7dNbe37hF5BgSBMsbkuwSYVM1fwXB7l13ssich7X3qrwZsJ48j69q23Pkr
         clw6KthhWX2EtvAiCMRB2PrRZhH0iwDBA49lAdLEXT+WcV/xk3oZZtnPdoALhSEmwUoB
         byXkiR0jBEUqB79sQsikFoMrdrSMfeXeUaY5kc41DOVA1O9nTyBoVbFXE3IF823Oo89f
         6hO6fdF9EBhIFPLo0qyQeDComkKxinXNj6VjPWK5epqBY66785BI0iNSPp6fij0kvN4t
         lCWQLklkWNUFfmQqkS3gImQgtocnZDLc1rAKY36pXU8/krljrYbwLc+RshE9jiIG0loW
         cp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gf8wIO5493fzzODwj/p/NGZB4bq+VN7BJmqPFCsISwc=;
        b=pPk1ZBS2JHhRdEw7TgweyE8Agzgi/RGcXVda0HJIVXG7mi+a6sqHiZzszJD3PRT/4P
         tNV20O4bW/mf/43EW5VnG6Dk9rp19q6ZW9ilUurC8OVaiL7kGWzzVCqiEAy2oYZAfsWT
         lDbDUG8fbjew74Gh7t9PapT1mZpNgAhZkpcBkTgjBKGf57LFKIol1AU+Ud4IaQdUJ126
         zXt4MF1Vg8BmJbgNMF3HLvP64wndQ4sD3BRnDS7aXupIX6kpYvuC5/g9tdfD/6Y6HOCW
         8QATnSDSX38LYyKaUaI3iidHMGDpnpvQn4I3L6kuM+mfEtoFfe/hr29L6kyqQNu4DUAX
         7XWw==
X-Gm-Message-State: AOAM532JKFy6rJoumK10NTmYEL4ZGt7KjgogYq0zOo7K8Ink10WnwqBW
        jTPHGmfVdHMr6HG0xFP+rgo=
X-Google-Smtp-Source: ABdhPJzYSnNVGmMGdP2uHOSNosDQydp57s0clehDD9iEuVb84Gmzv7p2daptwTnmhrh2/KswJuobzw==
X-Received: by 2002:a17:90b:3442:: with SMTP id lj2mr15298590pjb.81.1629651899212;
        Sun, 22 Aug 2021 10:04:59 -0700 (PDT)
Received: from [192.168.208.38] ([183.82.190.98])
        by smtp.gmail.com with ESMTPSA id ge6sm16861199pjb.52.2021.08.22.10.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 10:04:58 -0700 (PDT)
Subject: Re: [GSoC] The Final Git Dev Blog(s)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Shourya Shukla <periperidip@gmail.com>
References: <m2lf4wys5o.fsf@gmail.com>
 <b6ba6b44-c5f5-63f4-7fd1-19a1acd34770@gmail.com>
Message-ID: <f7f2f057-2671-ed2f-c307-55a468fdb3ab@gmail.com>
Date:   Sun, 22 Aug 2021 22:34:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b6ba6b44-c5f5-63f4-7fd1-19a1acd34770@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/21 5:45 pm, Kaartic Sivaraam wrote:
>> CoViD.
> 
> Good to know that all are well. I resonate with what Zheing Hu says. Let's
> hope we get through COVID-19 smoothly.
> 

Typo: I meant to refer ZheNing Hu :-)

BTW, I was planning to look at the patches you've sent to the list
recently. I couldn't manage to find the time for it yet. I hope
I'll be able to find some time soon.

-- 
Sivaraam
