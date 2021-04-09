Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9785C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1761106
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhDITAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhDITAh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 15:00:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C44C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 12:00:24 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id x27so3203397qvd.2
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JNyEsMp5xpThatkaKHUnUDYKqDD7Bc+m+2Dkfeou7YU=;
        b=DCpbXVpun4x7oda7gYHPJwpU+SUCSOcODPxAa66WxqMa1BJBUhWTz471Zak9iZqdlo
         aFDn1J3KUdBV4QIfCA38d1iXoVmVHkCCAtsWAY2WyS34aBWMaoSBffVWhCEGcz1hLwxf
         cma9l2siC1NZUEmkYUOHalM5CqUhnacvQ86lakkwaqfkmc3FyEntOl3tEND2xi8NK7Or
         tLT5W4GizGGyz1AAtpyURnlCr18XP1a++tSMv3nf48La6m8npjq26NS6eBplXlcjQz0l
         ZtcG2DH+u6bY+I4MeHljolW6cN/23AgLUOGzK9067B6dD+O/zdN8PXfx5ZOhdbMkbRxV
         Tguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JNyEsMp5xpThatkaKHUnUDYKqDD7Bc+m+2Dkfeou7YU=;
        b=Eq96bahmU3sTlDbhDY/+/RXppzMrqXYz50iUPv+Z2oNo57t1i5nfQoXSOXGCnovYAR
         kp++cfjXikyoq8ApV9sZWWQ60nhp/9LVFPw10pQWR/GZcpmo2fB02mohbwVu0VPh1o5f
         PRp3Brk8ueul6QemUrugxrO7r1ar217lDvVRo2mk/st+bs5Saah+Fyqy4SdyDYThJrUG
         0cyYEPYb/h5pM3cfshmcM8bthjYYXJs+A/6eEm6hKJgBTiOtZyaCrVwSA9qWl9dgkD3Q
         oyKh0D1gSk/h3P4YtwjjiYNGPjNiGev5MThyxJ8bca0drZB67Q2VexsBDdBcHmIxKqCk
         nfbw==
X-Gm-Message-State: AOAM533VtrWXOlnibq9iaPIa1h8Dw1mStQpMpN5OUCr681KntqIbkrlK
        BzQlEZleKCa/Q9qsrtKDSz4=
X-Google-Smtp-Source: ABdhPJweOFfs170ca5ybDQF6YFg8R/XxxZIwI45eoPXSfvBiTrxik0mBK0SLbun+JbX60sY8iYNUyg==
X-Received: by 2002:ad4:5b88:: with SMTP id 8mr7821792qvp.34.1617994823190;
        Fri, 09 Apr 2021 12:00:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e556:d73b:6b67:5b9f? ([2600:1700:e72:80a0:e556:d73b:6b67:5b9f])
        by smtp.gmail.com with ESMTPSA id s17sm2304081qta.44.2021.04.09.12.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 12:00:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] maintenance: simplify prefetch logic
To:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <5aa0cb06c3f2e31a51bb6747fa84de69c0c1212f.1617734870.git.gitgitgadget@gmail.com>
 <YG4+67oe39IRnUzb@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91f3d4f5-429c-8a9e-eea3-a02ced426b7b@gmail.com>
Date:   Fri, 9 Apr 2021 15:00:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YG4+67oe39IRnUzb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2021 7:23 PM, Emily Shaffer wrote:
> Overall, the series looks pretty solid to me - which is why I've got a
> handful of small nits to relay. :)
> 
> On Tue, Apr 06, 2021 at 06:47:46PM +0000, Derrick Stolee via GitGitGadget wrote:
>> -static int fetch_remote(const char *remote, struct maintenance_run_opts *opts)
>> +static int fetch_remote(struct remote *remote, void *cbdata)
>>  {
>> +	struct maintenance_run_opts *opts = cbdata;
> [snip]
>>  	if (opts->quiet)
> I worry about the lack of null-checking here.

If this was a general-purpose method, I'd agree with you.
But since this is a static method being called exactly once
(and always passing a non-NULL value) then I don't believe
that NULL check is valuable here.

Thanks,
-Stolee
