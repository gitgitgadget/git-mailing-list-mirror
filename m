Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4BC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 19:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F30D610A1
	for <git@archiver.kernel.org>; Mon,  3 May 2021 19:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhECToI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 15:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhECToH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 15:44:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E6AC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 12:43:11 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d21so4427633oic.11
        for <git@vger.kernel.org>; Mon, 03 May 2021 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GBlT7bioncFs2Ml9p3G17bqw9+JbQjVTAGFypDnp80o=;
        b=cgeo5e3sWyNeD0Pnz2DIq1AVd0FBOBWz8j47ge/ypISncffYNIK7aFbU1tEmj2Yb4r
         z6OcBZVKXYsd8VfN0HrUNahGdBxDaTiQoYcna5AQ6Y36iwCWmeureMwr9JqN6nwEqMPZ
         x7bWpRomCR6ee9J9DXcv7xHRFZNir2JqS73+B9+niI1w8A7rHPD1r4Zqr/57K3ExYRNj
         aiatv7/gnD8Du8RTkgJFNqbIjd0pJ3PltNfZBckpIgOiIxAWvQJ/7qrvVIoxVbd5zmjn
         UVzJpqGd1AVNKY155d60DDI2h5IQ0KA6VqCxm9MbRdmI9THtf1Kv8vSaYDMCSm8jwuQE
         hrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GBlT7bioncFs2Ml9p3G17bqw9+JbQjVTAGFypDnp80o=;
        b=jjiU+Ld/As5h8xIbwWN90IRvsraGY+3cpOUcOxTccL/ygox8XmMHOLG6au5Sqn8AdK
         wS+KDmvuUf8+yqNeSoKdmeu3U9w98VErPe7ryyDsGzLwEdrmw6KilMuuP5SFBm/vWKuH
         53mTGuq6ks2kabNlvFNYGewWT044/JxvBuHDkWecvcq+2726GN+alCcbxDRXL7xQGUAi
         d/pEITmmSB3T4epykYNpHw9O9xYMBAhzVrCWpholl1THe2qhR4xhsDhPIgOAjBWAewFP
         Ce3+XOY1cRWq+SWqoX/4pPrwm/GsU5FiY2sojUCpP3ceaiF2T5gqHLi4lDHujvAokttr
         6/vA==
X-Gm-Message-State: AOAM531lnvXC50xMMskUCUN0x2KUIk9fnRvNWoS8EH3OeUtTHKIwTkoF
        /y5rfzFJyVUBg46fc+g/a2tFeeGg8BkkWw==
X-Google-Smtp-Source: ABdhPJz0k1dtHzKg3fkAXb2nCc86vwWikW4jNMqCcjqXpMX6frr1uxiX9a5SmKecTSYAeQAIkwpDfw==
X-Received: by 2002:aca:b6d7:: with SMTP id g206mr14866886oif.53.1620070991240;
        Mon, 03 May 2021 12:43:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1d10:1602:8cac:e291? ([2600:1700:e72:80a0:1d10:1602:8cac:e291])
        by smtp.gmail.com with ESMTPSA id i9sm178941otr.19.2021.05.03.12.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 12:43:10 -0700 (PDT)
Subject: Re: [PATCH v4 3/8] for-each-repo: run subcommands on configured repos
To:     Andrzej Hunt <andrzej@ahunt.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <dd9237927395ef69663ab376a2da74da4654c495.1602782524.git.gitgitgadget@gmail.com>
 <cda4f200-2400-e915-e995-36eea2a27c11@ahunt.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <68bbeca5-314b-08ee-ef36-040e3f3814e9@gmail.com>
Date:   Mon, 3 May 2021 15:43:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <cda4f200-2400-e915-e995-36eea2a27c11@ahunt.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/2021 12:10 PM, Andrzej Hunt wrote:
> 
> On 15/10/2020 19:21, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> +static int run_command_on_repo(const char *path,
>> +                   void *cbdata)
>> +{
>> +    int i;
>> +    struct child_process child = CHILD_PROCESS_INIT;
>> +    struct strvec *args = (struct strvec *)cbdata;
> 
> I was curious there's a strong reason for declaring args as void * followed by this cast? The most obvious answer seems to be that this probably evolved from a callback - and we could simplify it now?

You are absolutely right that this evolved from a
callback. I look forward to reviewing your patch that
updates this. ;)

Thanks,
-Stolee
