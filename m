Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07582C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD6220675
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE40sBN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgFZJGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgFZJGU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 05:06:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B7C08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:06:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b5so4378259pfp.9
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ETVzTl2pfERIf2LL7DVMxOB1GAwp5tgg1RvoIt/cmoc=;
        b=fE40sBN1gX/RyYN8xkrKD5XtlCoup81PptYGohfh6UABsyuvQiBZWIou6UK9jP6arb
         Lqsqzx5H0lwJRj9siQtRHfg3/V6WEnvIM2zc681vrURVBYEXKbln6hBZ0Gc78QeYYQNA
         ieM0riC33IcyZ++GX/hNU5aA88fF/d0nnjqa5nycwGmCfUh2rdAFnjEJKTACT+/mGHSp
         3dh7J8J6qVy+8GSHntQbjnh5wPE1rcmZZ2atgAqBuUMy7RAPEuZe+WAdCjotWFaGkzOG
         cvSGgNH8HEpUpNhO+pZpOZvQPxDitTlkdZTvtg3JpFPwqD5hbg0xth+LMDVafzlFvDP8
         WsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ETVzTl2pfERIf2LL7DVMxOB1GAwp5tgg1RvoIt/cmoc=;
        b=ruOhuARYf3RNa7FYj48EcRdEQyHhTiXitMfeHm2DAZ3CPKzyDXElaf87e85zazU+5G
         0sRVfVVmPxcbJ+uhiKEp1ayY4VM3eiLmJsLTjJuPnbOMJf41xXJCQigBeJdvVn34qh+d
         uQeZXyraM7wkS9ScmyHxBz5gUTobkCNsF2HuBNRuJcpWJt4zMdNnfmJjaDsOsU7+px5G
         kyls/2jNItpyGCaf7XHG1ABHC8z06ct2YnD2cHT9/8q/BypzSEtH8HkOjx6GRZT39L11
         NcA+HsDKVbAsfn5r1pM0ECEFV8LtW+43wdqPCoLW7vn8zpKn24dvZZWGsXe5WtXGgn8C
         iQ8w==
X-Gm-Message-State: AOAM530+9HXWISWY3UQiDlKhyiL4TRqQELlLlkhOwR3lNvZ2UhaT3hTD
        mDi/rZmMXZxkCmVEtecV+FseB/KI
X-Google-Smtp-Source: ABdhPJwBfBdPuHZ7K7GecFcJwOHVjRFhTwh3zM6RRdWNpyoArO36Z9MiQPD2tMg89OhgPnH2L4gEPw==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr1807033pgm.253.1593162380329;
        Fri, 26 Jun 2020 02:06:20 -0700 (PDT)
Received: from [192.168.43.191] ([223.181.241.56])
        by smtp.gmail.com with ESMTPSA id n62sm11488110pjb.42.2020.06.26.02.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 02:06:19 -0700 (PDT)
Subject: Update ProGit for pu -> seen change? (was Re: [PATCH v3 0/3]
 Accommodate for pu having been renamed to seen)
To:     git@vger.kernel.org
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
 <pull.668.v3.git.1593087539.gitgitgadget@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <c08504e9-5067-221b-819c-adce262c7394@gmail.com>
Date:   Fri, 26 Jun 2020 14:36:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <pull.668.v3.git.1593087539.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25-06-2020 17:48, Johannes Schindelin via GitGitGadget wrote:
> This patch series adjusts Git's own source code to reflect that change.
> 
> Please note that even with these patches, there are still a couple places
> where pu is used:
> 

This reminds me. The ProGit book references the `pu` branch in several
places in the text and images IIRC. Is it fine to change them now?
Would it be premature?

>  * In the translations. These are legitimate words in languages that are not
>    English (as in "gpg n'a pas pu signer les données" where "pu" is French
>    for the English "could").
>  * In upload-pack.c, where a variable named pu is short form for
>    "pack-objects updates".

-- 
Sivaraam
