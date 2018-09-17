Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08D91F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIQWyD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:54:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41007 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQWyD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:54:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id h138-v6so9420514qke.8
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NDTTItDVz4JmB8cilgdhDmIvK1uEDkeWxB//BR5fdAA=;
        b=cf7mFOZNWgpmBf20hFDiNcifDEcS5FXITY3tIoDy0MHsXqdgQxm6/HsoxSOC376csj
         imc7WtNrdmnp/SEWOaDvNJmh1w7fPoFd+eVixfTbIdAmOFk1thX98DnoKPWwCIaYh9R6
         VK7qg6BpHju3qEN1zox9TomMJpYKRyqvSetJvf2yNiYuiUyj1wEhRW5dUVeMeWfCtpP4
         noYS2zoKVM7yBCM10W/8v4EO4QENAEY5Z0EHhoItt4n6yeM4Vi+0uXvswdAawfVPVBcq
         7VENv1OVDtDhoF2Fs1JbYU/JV9QRF+bwVkMeVeVR+uHKOSmq2Hr6OmnLT+yyf+jkdCJa
         BCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NDTTItDVz4JmB8cilgdhDmIvK1uEDkeWxB//BR5fdAA=;
        b=YfUF2oZopnMmSVxTtzP3584qVqOQR9lt6dEylHo2sck8UAsI06aHyThshwMeZGYcm0
         4LeNtQFGIarftLebyo8Gs/4PR6sQtRewH+eOo4Lr7w2H3BdIQ0feFG8axyX0qPMycwQ0
         73EragWogSAepdzNIrr0oByrOKYaRe08mz1/OaZe5An8St/WLoeOWap2L9RnQciaeXzH
         1gf/kfLx6gfa2zDZN2QLRkH1SxE9OSLGjg9bUR/nlX6wpLU/bg2jg88a8Sr5oEPmPS/t
         7KpzXxCLN9VW5oHWX9FNm9iw7KkaWWON6FbJcy+wS8rIs4yUFMlBWTzecSppDrJQChfv
         3/Fw==
X-Gm-Message-State: APzg51CnY6B8PJb6fiN89FbksLcZet42EYOxXWmwpzS9ew29orm0qqWA
        GulrSw2RVI0ELyVcVxjnnQ8=
X-Google-Smtp-Source: ANB0Vdb2/Nhp1+sbdXVCjBL1CVPekl7ZlNy/KuEJVdMo+CeiP8uW32zpFv1XqJL3KsQs+MkDAJIHog==
X-Received: by 2002:a37:ac0d:: with SMTP id e13-v6mr18179768qkm.100.1537205143832;
        Mon, 17 Sep 2018 10:25:43 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x14-v6sm8424222qkf.59.2018.09.17.10.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 10:25:43 -0700 (PDT)
Subject: Re: [PATCH v5 3/5] read-cache: load cache entries on worker threads
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com>
 <20180912161832.55324-4-benpeart@microsoft.com>
 <CACsJy8CjWD_CHwv5NoURLt9is7-UUDpKDo-3EcM28imznZAOpA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <e021377f-fbde-e3e9-7b62-c2a2d33cf1eb@gmail.com>
Date:   Mon, 17 Sep 2018 13:25:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8CjWD_CHwv5NoURLt9is7-UUDpKDo-3EcM28imznZAOpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/15/2018 6:31 AM, Duy Nguyen wrote:
> On Wed, Sep 12, 2018 at 6:18 PM Ben Peart <benpeart@microsoft.com> wrote:
>>
>> This patch helps address the CPU cost of loading the index by creating
>> multiple threads to divide the work of loading and converting the cache
>> entries across all available CPU cores.
>>
>> It accomplishes this by having the primary thread loop across the index file
>> tracking the offset and (for V4 indexes) expanding the name. It creates a
>> thread to process each block of entries as it comes to them.
>>
>> I used p0002-read-cache.sh to generate some performance data:
>>
>> Test w/100,000 files                Baseline         Parallel entries
>> ---------------------------------------------------------------------------
>> read_cache/discard_cache 1000 times 14.08(0.01+0.10) 9.72(0.03+0.06) -31.0%
>>
>> Test w/1,000,000 files              Baseline         Parallel entries
>> ------------------------------------------------------------------------------
>> read_cache/discard_cache 1000 times 202.95(0.01+0.07) 154.14(0.03+0.06) -24.1%
> 
> The numbers here and the previous patch to load extensions in parallel
> are exactly the same. What do these numbers mean? With both changes?
> 

It means I messed up when creating my commit message for the extension 
patch and copy/pasted the wrong numbers.  Yes, these numbers are with 
both changes (the correct numbers for the extension only are not as good).
