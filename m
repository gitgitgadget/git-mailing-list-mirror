Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D52C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1839611AB
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhETDTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 23:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhETDTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 23:19:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3EC061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 20:18:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so4558774pjo.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 20:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=u2JJA6CPNmu5XgCVS5foHWOf7MTadJqaF1kObGhHJrk=;
        b=JEmVdNDPWTVWHARwZEqEqRdHtBbIcep6SaGpfJgwutP3JM7uQ7l3V0AmNYFf7iSg/6
         Ne+IIMUo8NmuY0CAYpMYwl2jEP5G+KKmK0Ndz1C0lzupnN6uGS0JmjMJiNFigO20mDWL
         ySKHAPT7tI088pN/vggfkWfxWYf0g+35x6mMjDXGYC0h3Wzv8mg1vlCmo2+n+vQhrHty
         W1kPOOERpF1Noj8i1/kBF+5jfpbajd5bGCBe/Y+VONncOm98FnyMHkkYpQQvjjYxRYnO
         MzknyVJim5FT0h0UbW9U7v3Cd57bVaqUY4XEbDTuixfRQdwoA2KWQ5ahkhlQ8GlhhXdw
         yhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u2JJA6CPNmu5XgCVS5foHWOf7MTadJqaF1kObGhHJrk=;
        b=LCorAlS8cUDnDI+xe5zo/6K2Rp3EswR8HjnDgt9Slknfjfj9nBnoAmdejGSgKT6BRq
         DVVyHJugnhVT8HgDH7L5sUqAdRzpFZpJwx3gh/zERZzKvWXjZUMOhaQHpmetutsqE5D/
         N0nifaZs8lKcgOWm/4r+fAl0txssU/jXPZiKPHKygO5Lhw6q2JbXAqrziTutRoRUcxOv
         9gySPMdp+9ARkqg3tAbIWS3+Ghf8EcUgOErTYMRvkSifIPBOmlj48molwBLvkJnPfP5/
         V8xDRBkn8SpFyx2elmmIOvR+zDTYBHatDPRPPWDwM0lyFaCyIamrXDS/qSRA6YpzffyZ
         fy2w==
X-Gm-Message-State: AOAM532E3B5YbA/rzCpGZvLMZoN9+NLqUcon3QBsEYthn5r6zv0EimLU
        xBlL6WbSaVQxOD9CRA+abUR0KApb2UbaKw==
X-Google-Smtp-Source: ABdhPJyrNimaCQrD/ZuhXjMcF0ECB6qTNsH3UmhDcBRPH3loDFhaWBiq9Xfb8kxme75tP0KTYtb3Aw==
X-Received: by 2002:a17:90a:8005:: with SMTP id b5mr2436320pjn.208.1621480701437;
        Wed, 19 May 2021 20:18:21 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id b65sm606415pga.83.2021.05.19.20.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 20:18:21 -0700 (PDT)
Subject: Re: [Bug Report] git log -L:<funcname>:<file>
To:     Weishi Zeng <amwish.zeng@gmail.com>, git@vger.kernel.org
References: <CAH6yD_bkY+_7XrzHdOqnnE=qvnnvxAWEQPtOyVh=BwvbcheTCA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <83740d18-e0ba-e6b5-0356-144373708d4e@gmail.com>
Date:   Thu, 20 May 2021 10:18:18 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAH6yD_bkY+_7XrzHdOqnnE=qvnnvxAWEQPtOyVh=BwvbcheTCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Weishi,

On 20/05/21 07.11, Weishi Zeng wrote:
> Summary:
> git log -L:<funcname>:<file>
> would fail if there's any java-style comment that appears before the
> <funcname> string in the file.
> 
> 
> Details:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> git log -L:'myFunction':~/a.java
> The file is a java file that contains comment before the function name.
> E.g.
> /**
> * comments will interrupt the regex match
> */
> private static void myFunction() {}
> 
> What did you expect to happen? (Expected behavior)
> As described, it should return me the commit history that touched this function
> 
> What happened instead? (Actual behavior)
> It returns error:
> fatal: -L parameter 'myFunction' starting at line 1: no match
> 
> Anything else you want to add:
> If the function name string to search for appears before any
> java-style comment, it returns a valid response.
> 

I can't reproduce this issue on my system (Ubuntu 20.04) using latest Git
(2.32.0-rc0), compiled with gcc 9.3.0.

Please compile latest Git on your system, repeat and report.

-- 
An old man doll... just what I always wanted! - Clara
