Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD60C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 05:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88CE61104
	for <git@archiver.kernel.org>; Mon, 24 May 2021 05:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhEXFYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 01:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhEXFYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 01:24:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CAEC061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 22:22:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g18so18225500pfr.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 22:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+iBFSyATAWv0OGVSqwMx0UdJ5zTnWStf74NLCQvmBTA=;
        b=hE/Awhi1dnh+4pNpYTcj2nHCJfXfzHGSniErSSq66K/ZihhNu0Ofmd3x1Lkf1apziT
         JtHAyxTaf8ns7RQ4O0VR1E3UK46pWEAQ7bNbPC9ailk56BlRHFBr6+fnJg6OtIODf/nI
         nOaXipLpFq3XcsQLZx/y9e7R1gMEDCL7DxVUHg7j/QZ7EhfyFH7QQJBF4EX2nnl6Zry5
         qj6keOHpd1OH/aLjDOQWmv+o4e3TT1A0EANeE2XmoDaeqQONxiuy6KKLGjUDhFhklBY0
         IIwKonyTYW4ffcK+ubGhL60pprmODEMpriXIPvkoTnHWuURX6H6ivnFyviGSEKIjK6gw
         zcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+iBFSyATAWv0OGVSqwMx0UdJ5zTnWStf74NLCQvmBTA=;
        b=itaPqdKRPafQGp/JG3yV5rVbfWlU5ZbzA58GrAlyqi262Wf34xtZcs11Z14jPnXvSq
         hbplum9STTqiS7SOBWRo3+w/xLTh5KqE1kS1GnG+LVBBGIubMCNz7wtkn/1uuIYnVKwJ
         bkB8M/QAwUZUIHWzj4UwHXvkMBd/FgeYGqofzV/LyVIJxPWBoSZZVnWBTWxYKIswW0SX
         TZ5+1mxAxZBtI6e6tAVDd8eWWd4nFeXouE6MR7QMwaXda82ovxwPAQS8WiaWRKuwvHcr
         yvi/DkGdrPOTtsRzAejtWBzYBv6Wx82PXMrHjSHc8VQyMQ6bnKRYvZyGVHIeCLEu5VQc
         JZjw==
X-Gm-Message-State: AOAM5311f8ethLOEnbVVe+gpBdqHfm8QvrxYS2QvLfTrtlAf+Bjb4M1r
        eqq3ja0sDtP+/7aazB0MsAU=
X-Google-Smtp-Source: ABdhPJwIvibYxEfemlxerQnrcj9wKB8Sl+aboeA1QPZlxSpLEc4DktcD/eTuUHEq74kRMwkXO5KCHQ==
X-Received: by 2002:a63:e058:: with SMTP id n24mr11580642pgj.91.1621833764210;
        Sun, 23 May 2021 22:22:44 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-53.three.co.id. [116.206.12.53])
        by smtp.gmail.com with ESMTPSA id 63sm9835801pfz.26.2021.05.23.22.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 22:22:43 -0700 (PDT)
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
 <xmqq1r9xndjf.fsf@gitster.g> <60ab1246d2d14_1691c2083b@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <72ce81a2-68eb-a750-8ca1-425af3cac370@gmail.com>
Date:   Mon, 24 May 2021 12:22:39 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60ab1246d2d14_1691c2083b@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/05/21 09.41, Felipe Contreras wrote:
> Junio C Hamano wrote:
> 
>> Is there another word to refer to the entire payload unadulterated?
> 
> Another word better than "raw"? I don't think so: basic, crude, green,
> rough.
> 

I think we should go with "raw", because the payloads we discussed here
are unmodified. It is akin to "raw data" that is processed further to
produce porcelain output, such as templating engine that process raw
HTML into HTML pages that would be served to end user.

-- 
An old man doll... just what I always wanted! - Clara
