Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB99C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96516108D
	for <git@archiver.kernel.org>; Wed, 19 May 2021 13:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhESN5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbhESN5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 09:57:04 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA1C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 06:55:44 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q10so12757189qkc.5
        for <git@vger.kernel.org>; Wed, 19 May 2021 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ld/w/dv2oWazETo8kiZqi3jy1Tf7jfX9HRZJl7fWGWY=;
        b=i1YT7vZkUke1ZnHedbjIGQGR3cYVZttPGon38UWq5+PtwNPqXSKA7mNleLmmqcFmXR
         USyiFJc/ahXvXd2OY7L45ThpalguMDbuIA4X/GRcADciVbmZ/1k2nq9khWxIbaX1YK0R
         gjLdzcYATZgXxR5X3X1C+p9rP0s9S8zRkYmS0NS1KaQ4mFzJl+mWyLET9laD8+g97kw8
         G1REyeMWzak71k8jEPeiVu/Y5DYl6X5VEPXaHeeA4zrKzbfFNo3S4hg0M/O7rfXWYkqX
         oDVL0QaVYnFOEYhBFsdE8/h+wiYyCyh1AejGHZZWRD1SOS9LdlfVYL470jjZfGFloGCa
         CllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ld/w/dv2oWazETo8kiZqi3jy1Tf7jfX9HRZJl7fWGWY=;
        b=lCN/y4wEDJgl1oHRa8rEtm7I3C3EsJX9tJOSM7zlcUvseywTFnwYT/gUrkJNvnuotE
         3m2PSoqza93ZwSpnxAsTrIrdwqRfwXCkWUt8Yri+tCVayDsPZQ0XZcG/WnHM0O8LDr3X
         HvhAlRhZxRch1U2BImBDPgZupChyd2rrOAd1xzL4191unEz7yF8+LJsPZOCa8RYTfwH2
         jJv5S+HMF5NcQt0yrIs4Qgg8FfYxbKM7VI+qu0vv9iLHgHfEgnF8HazQEUoSSYVJE9Gd
         fAelT++/cOMKkFRAtWBdqsSO9TgtApRSSDviaiYdUqWompiq24GGPYlXD/Ibo6mK0vum
         FTqg==
X-Gm-Message-State: AOAM532KQln+HPq6FF0T/JSdIkcLW4iER1L4Ks16s6c7NUJoGBOuIQeA
        RdrD/vXEatQawoC3ZFS3vyU=
X-Google-Smtp-Source: ABdhPJytTBIUJrPeemwzHqjaZForqwffth1CUCHd9K8w5ohurRtvO/XJnEpliAZ48PLITrUjTepo0g==
X-Received: by 2002:a05:620a:751:: with SMTP id i17mr12188393qki.87.1621432543437;
        Wed, 19 May 2021 06:55:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:a1ee:38d:5766:9f4f? ([2600:1700:e72:80a0:a1ee:38d:5766:9f4f])
        by smtp.gmail.com with ESMTPSA id b23sm7296707qtq.0.2021.05.19.06.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:55:43 -0700 (PDT)
Subject: Re: [PATCH] fetch: improve grammar of "shallow roots" message
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, gitster@pobox.com
References: <20210518061855.57478-1-alexhenrie24@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2b1985b6-c426-7f7a-2d6b-34977ddecc1d@gmail.com>
Date:   Wed, 19 May 2021 09:55:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518061855.57478-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2021 2:18 AM, Alex Henrie wrote:
> - warning(_("reject %s because shallow roots are not allowed to be updated"),
> + warning(_("rejected %s because shallow roots are not allowed to be updated"),

This change to past-tense makes sense to me.

Thanks,
-Stolee
