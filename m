Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855CFC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593B261287
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhFHRj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:39:29 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38648 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFHRj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:39:28 -0400
Received: by mail-pl1-f169.google.com with SMTP id 69so11039542plc.5
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BdQCejkkhCfrFwQonU8xoShqMAHB495u7fPtYIPpyYg=;
        b=BfZbvUMTbpH92XgMUb/9yyn2bHkbBDIg5M3tw+awOjjPFlA9O2HQJug5L1V46GNBXj
         3JX6QzwsRYPGmQZY7RTjj/W7g0e3bE7cZ7X2d+EXAf3JgoqmvxYki+6Dk/DGgOgPLBIz
         2MrPCLGotznMTlTTx3bjDl/y6tKmS4iZya3HQhR3/wNbwTOu+GPHwvj9LM0YZKDN1zMr
         xNV6sAcf3FufumZeKw6cs4o8D0dhc6ZlG0QR6sBlCvGkB3EBGlccmiwKKaRwCv0WtbYw
         IjcYmNAP9eZ6aPmoKzfa7hJh15d0g95d6GWqgizSwclXUnjqSA5IgXXZbvZ2phXAmcnp
         +EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BdQCejkkhCfrFwQonU8xoShqMAHB495u7fPtYIPpyYg=;
        b=dWT9Dk1v5g4Oo2NBUtyf1uyoa25ynQrNrvKAlYntN/sRNDyusvI8LXAPrDDAVKVrMu
         IvpPFK+mDssngTJrlsWW5qn2J2ePUnXEMyIpgtNYRd/rLunIaQdcn4oW4lg8/rZrBegL
         qABmAi76XvMBIoFmq1Jdd07OI4snBDFzkLIXmSRN9ZK2HAN6h7IDpH2+wWSZyj4P/irc
         HqL6REJCnZeIlVUHEB7jhINNxcSnjmFXJ8c/yNTgtyNCNhLT8AMcjxvCH90dCiMYJKBN
         dLnX2ORFsJUxZxbvVixlONNAmjAVM0EA+1F9Cka9gBdRN2isxBVvChJE96jlQnXo0WR6
         TQbQ==
X-Gm-Message-State: AOAM530XXVlKNVVXQVjfv+j6n+7uQnod//ldYQJKuh8pcCuuEXJp6I8I
        g7q/lTsXHfru7+4ldL2Yir58WEVNzjNBKQ==
X-Google-Smtp-Source: ABdhPJxVAbuqlZIAHJqFtGJXeA2IJvMqrrByYhz6GNBQsnQB48Wqd0koJvBeqv2U2lJLQFI4YhIkCg==
X-Received: by 2002:a17:90a:4e85:: with SMTP id o5mr6128404pjh.22.1623173784743;
        Tue, 08 Jun 2021 10:36:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id p11sm15935754pjo.19.2021.06.08.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:36:23 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:36:17 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] *: use singular they in comments
Message-ID: <YL+qkVXGMzg8S9gp@google.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 04:57:46PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> Several comments in our code refer to an anonymous user with "he/him" or
> "she/her" pronouns, and the choice between the two is arbitrary.
> 
> Replace these uses with "they/them" which universally includes all
> potential readers.

Thanks. I'm especially glad to see the codebase start to unify instead
of awkwardly choosing between "he", "she", "he or she", or even "(s)he".
This seems a lot neater.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
