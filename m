Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C04C47082
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF9D6140A
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 02:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFDCll (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDClk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 22:41:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E45C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 19:39:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r1so6663371pgk.8
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hwd/mAv+dxdsyuvg5sjjGU9KYLOKkADy6+ehPIwCi2Q=;
        b=lyEQsSh4Hf60bhAnUl3+gJWVD8ZGrBxVivf17VkuMKraYRAM9mThQebQryUYOm+2OL
         UtKH6/FJ0JF/4m69aD2T6DInFU/uj3zJ9HF31JfNsNuH5EfxbH9Hnsgpj69qmYAIQiQT
         gWd+6fWyGnaTMZaSrYhoVelo5ysoCltjE/t5I1AHYUWYsb9wYqXxd0mm9M7qx6IJ1Fhb
         AzXVNjLRBQtmqGBf9WBTgVTRdbBJ3EQX0iPZqbUE/qgZTxJZlrQevSS+TI72MjTNjWHW
         tViVNKf8RQOUZhbZuR3TE0KJb5BdNtOPbbM08b4PSNjETkjE9iQ19WPYm1x9dyNT4jDz
         mICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hwd/mAv+dxdsyuvg5sjjGU9KYLOKkADy6+ehPIwCi2Q=;
        b=sLbqXTifo/HP5Z+WpGdO+PXsmr0ZFR8Cqrv4cC4cZokkwngl1cqLmU0Toy510V3NuL
         /KkmbGvP0+9a8SnEuCqXCYbZRyIOZetDLlARHTsAMvAZrilQ/FF/NThfnEwihdbvgQPG
         lb6FKVauMe7kQQ/ajmTZhhShlKH4NQ3X2YbV6KTiQWnqS41iDJ0l1tbShYMpf1bkqHvR
         4tCm88AJc54JVGTlO56MilFxCPiNFllP4YnrsOBAXyz3fwfL/Ou0K0JXrJl7qDynqOld
         q4CeLAjYypIg7QGHby5TVi+DtD4P0pe1A16yPBL10RSM/FTPfjwjoHtikzrCPrWxRGUW
         ZlhA==
X-Gm-Message-State: AOAM533V/UUXd6i0OiiXYScKlGMrVRHRNK8bdfDkv3Kup1lnI1kecmIr
        CRzB2pjVY/S9UO12WbjGHcg=
X-Google-Smtp-Source: ABdhPJyT+UHnhkhuGsWJr7ocpWtRto7bkf181UzSuoR+1aG/lrNmEn+s8PY927NwMncgs5ApfCmRTw==
X-Received: by 2002:a63:e316:: with SMTP id f22mr2550630pgh.100.1622774394760;
        Thu, 03 Jun 2021 19:39:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:b66c:839a:e48e:131c])
        by smtp.gmail.com with ESMTPSA id m13sm3371330pjj.18.2021.06.03.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 19:39:54 -0700 (PDT)
Date:   Thu, 3 Jun 2021 19:39:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <YLmSd7ADvhdh33/O@google.com>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <YLhx7nIptHUwXfBD@google.com>
 <878s3r73g3.fsf@evledraar.gmail.com>
 <YLmGo8PZDAT90hj+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLmGo8PZDAT90hj+@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> I agree that it wouldn't be worth "git send-email" registering for its
> own API key, mostly because registering for API keys with every email
> provider would be a distraction from what git send-email tries to do.
>
> On the other hand, I would mind a perl library or a commandline tool
> that git send-email calls having _its_ own API key.

Ahem --- I *wouldn't* mind a perl library or commandline tool showing
up that does this.  Sorry for the confusion.

>                                                      That would be
> helpful to other programs that want to send email as well, and it
> would help users who are not as patient as we are in trudging through
> the multi-step process required.  For example, it's nice that KMail,
> Apple's Mail.app, and so on have their own API keys instead of every
> user of those programs having to generate their own.

There's a sendgmail tool in
https://github.com/google/gmail-oauth2-tools.  It requires generating
your own API key but I suppose someone could package it up with an API
key for their package if they wish to.

Jonathan
