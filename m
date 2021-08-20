Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71964C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD8610E6
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbhHTPjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbhHTPjw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:39:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3560AC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:39:13 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r38-20020a05683044a600b0051a2c6dd421so14602441otv.3
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=28AcPAQo5w9Fv0oUP/rUEIISL4omaa/S3/kTA2IOoPs=;
        b=k+JiZNAkzl0W3WS3g1vGbv5MiBZP2CE82G0jO2RLAlyoM3OqXf8kEaKLJ6IATkFwlC
         vIxbk3d14CPU0K28wTeKzW8p6/GbMYihoLmHSDshZRDFuzUn+sl0hREu/LnwihzK8EBQ
         6/Kz8PgBLBUhcvGsC/HZWOfiZrQXZD6pM3wq06tlTYqsvF4yFknvurOaD9z/Ob4n8Cv+
         kPp5y8iRS5OfFxp+Xz/VV7sLMOezlqlvrLdmdqLlUw4Rkf4gFsVYsGn5xA/vJAZn/V1h
         ayHOn2Tt3MoKjvrjrplMqY57kAH6hKvlcL+JTk/dyxiwbK7HzpYtFiHX6gttla5eHDQG
         kYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=28AcPAQo5w9Fv0oUP/rUEIISL4omaa/S3/kTA2IOoPs=;
        b=N0IDz9miajmgq8sDo5RQkM35uvGDAB2BS/oqxC/y1Y2va5snK37JoVGeAi/Bra/Tnl
         C1rhWXRqqgXwAQCWoXbN/rdTbHTbMvsWBhm/LLJzg9h7zZQ5FGVV+zA/i0cNyj0EZjWO
         3BO6mktmn8SjSKu323TLS6dHwrV6o06I7ti1BwFYjbULyuqeYayfqseLc1n6FrnsYvqA
         XvM4W0NEYDGrl/9iqvoHJAEGsb7uHNR4Bp/JWdzN6D/OEMM0jrbbesEqM+FuoTut6COt
         4XytNanJ1OrxCn3F3oMUHuOo02IzyCWsHB4C77OhgnY3japMJ33IKafOToC0Req93aT8
         b5GA==
X-Gm-Message-State: AOAM532kbD4j2JbYExSiH6Eoi/bKUi5kbTs0CdmKyoUeKd/tfoDZVfde
        xckUWB2UmRUKwmbxDAhp0+Q=
X-Google-Smtp-Source: ABdhPJxEH+HV+AD9/myRMW8ATVGkvIipyX2DleS+0s/bDx0NZS2qY5sOvUpJkX/4JHiMMXHnCb/HvQ==
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr16301382otp.63.1629473952526;
        Fri, 20 Aug 2021 08:39:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id j17sm1527193ots.10.2021.08.20.08.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:39:12 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] attr: be careful about sparse directories
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <c9e100e68f80196a35a37b5d0aad74e8e1174766.1629206603.git.gitgitgadget@gmail.com>
 <CABPp-BHqTSv7MkS8-nq3Qg3CA3pLxSD9TOVvL_8R1-eF3Rn7pQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07cc5a17-024a-910c-35c5-0dc468172f5e@gmail.com>
Date:   Fri, 20 Aug 2021 11:39:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHqTSv7MkS8-nq3Qg3CA3pLxSD9TOVvL_8R1-eF3Rn7pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:53 PM, Elijah Newren wrote:
> On Tue, Aug 17, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +       /*
>> +        * In the case of cone-mode sparse-checkout, getting the
>> +        * .gitattributes file from a directory is meaningless: all
>> +        * contained paths will be sparse if the .gitattributes is also
>> +        * sparse. In the case of a sparse index, it is critical that we
>> +        * don't go looking for one as it will expand the index.
>> +        */
> 
> "all contained paths will be sparse if the .gitattributes is also sparse"?
> 
> Do you mean something more like "the .gitattributes only applies for
> files under the given directory, and if the directory is sparse, then
> neither the .gitattributes file or any other file under that directory
> will be present" ?

Yes, you understand correctly and explain it better. Thanks.
 
> Also, out of curiosity, I was suggesting in the past we do something
> like this for .gitignore files, for the same reason.  Do we have such
> logic in place, or is that another area of the code that hasn't been
> handled yet?

I don't believe this has been handled. It definitely is less obvious
what to do there, because the point of .gitignore is to skip files that
exist in the working tree even if Git didn't put them there. Meanwhile,
.gitattributes is about how Git writes tracked files, but Git doesn't
write sparse tracked files.

> Though the code appears correct, I too am curious about the questions
> Dscho asked about the code in this patch.
 
Thanks,
-Stolee
