Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67D6C433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 12:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5B64E60
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 12:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBIMn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 07:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhBIMnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 07:43:16 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520BFC061788
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 04:42:36 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id h6so19272116oie.5
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XomVUom4/ZukQBZVjOzX6Jm7lgb1tmVhtk1lEIkdZqk=;
        b=GDE2HNqBsvZhSS9IYgDOPlxUg07lSHBNv8JSQynVgr39PtnYK+MxAoQyxsR/9uMMSJ
         8oLAY1x0M279klo88l3DeoxIqPzGvfprJAXt0so4M2RytlBasE8TwpSVkQ88H72Uoi17
         0mryvdwy5OR0uc+vEpyn32n2CthStnNNsrq+hd4huQSwvl4a+bWhgXzQtrSgpE8RByhF
         aLaKKiU2o/nxAcfZrXJ/sGvnWoBqo+FWBhikZ1QV1shtnAYRCMrcunkqk5yVshpU89sR
         QAr2QYSUy6Hyqkah6dCx/L2lTxJ6UpcQpOs8gef6EVEiwBUghbRUbSMfsdZ9mO1VuV3l
         gnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XomVUom4/ZukQBZVjOzX6Jm7lgb1tmVhtk1lEIkdZqk=;
        b=F3qzuDxYrZqs5vPujyTADAmZKF0QmKQp0219GmWeD24JhKITfSa04KjhkyaptTNLS0
         0gOcwCt5H9ImJJ5f7yx5yh9xv3QfloxIrRBmKQL5ehWsCz5EELrTF5liANdqeJbB4NUZ
         U/BGSFwmD/hp1ggXHRuXifqN9hrJxwlPy9KuVVJnMA2JrN9ubXZAQrw2jluz1f1A8pZ9
         4yfSZIcCi1Qmb8o69E9IxsO3EHh0/6jjOJo6cGub9we07FYFAumMDK2VPXQwMgztxOsT
         svGrk6qEH5XG3d07IgrVr2CUbJR31RmEO78F4Y2ZfNP60592/Ub21EP8+BWI4KwOyP3y
         K7Zw==
X-Gm-Message-State: AOAM532mqSaCCRsRjUDFihtdFG4quAckFMQmsOYw74kiL87r7r5tiGQZ
        2PFKAaVZ2dJ48K9MsNCLyY8=
X-Google-Smtp-Source: ABdhPJxSflz8um2NNIuY9HsEkXCQEsknDBAxqjTuVB4YF3peOHg24WMlw6lmnEgFJ0ML8Yd1nc9MpA==
X-Received: by 2002:aca:f06:: with SMTP id 6mr2256230oip.107.1612874555768;
        Tue, 09 Feb 2021 04:42:35 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id y10sm1984720otq.71.2021.02.09.04.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 04:42:35 -0800 (PST)
Message-ID: <a4bf6692-9e45-fc2e-66e6-5a3671a1daa9@gmail.com>
Date:   Tue, 9 Feb 2021 07:42:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 1/2] maintenance: add pack-refs task
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
 <33b7a74af4eb45756c3648eb7b002d06e4ec3563.1612795943.git.gitgitgadget@gmail.com>
 <CAPig+cTOv_Hq-FM2s8-XaGHz6FSUt5Dr41sOB9wP12tQJ_kcmA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cTOv_Hq-FM2s8-XaGHz6FSUt5Dr41sOB9wP12tQJ_kcmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2021 6:06 PM, Eric Sunshine wrote:
> On Mon, Feb 8, 2021 at 9:52 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +pack-refs::
>> +       The `pack-refs` task collects the loose reference files and
>> +       collects them into a single file. This speeds up operations that
>> +       need to iterate across many refereences. See linkgit:git-pack-refs[1]
>> +       for more information.
> 
> s/refereences/references/
 
Thanks!
-Stolee
