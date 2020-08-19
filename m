Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC45C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4920D20657
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rlvop1Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHSALg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHSALg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 20:11:36 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E4C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 17:11:35 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t19so7437950plr.19
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 17:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XlHvcGhP64BqBXaB96jKF+JL907PVVW2zPvv0LmibA8=;
        b=Rlvop1Awr0aLXzwjD0mHXzdukWjAoZbCIUORZAhSIl3MnXqPRSn5fmOCyVK96AL4FZ
         WmBqvRjUC0YrEzVJxSnioVjLg++Ag3qEz3A+Sb5vRVq1ctoIUMfWhoO0UPFby3oA0zW/
         2ibh/dz6la4PRFArYJsjKf+KYkQhmqUxAm2LCyJDQjcoHOpKLzoBcNmOtuuLgQcgYTci
         c9dWKryddrPT4CtFIkmu352vV5ethQIngFOoT8sMpetKoua9URdKdeXP7FVDrGbVW/Ym
         2dg/TY4LIO/SZ40fj79mjRYsuQSrfpFcAZOXxFMeU9r4mycfK5763CeoNgIXH2Za9EAm
         ATww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XlHvcGhP64BqBXaB96jKF+JL907PVVW2zPvv0LmibA8=;
        b=IKPBbwcDz8Y5cHinuOCuVhXFXh7Z0/tGQmm9UyDP78ZxZ+f6GQcOQE6CJBeCpRajVX
         rNfRdrO7OjJ3eEGxHj02NcfLsBFZpiMQruWH2zDsEjT08K7i8dmY0QaYYT/lHS6yLUP7
         0hdkr1bUXmhm6UrSeq0K4I/atvDA06U42bLWY+py8p63y0C6BPQdpdqqkdSGswiaWpNB
         rurbcipWzH61dCm7n8705UTXVNuJbtpYEZ6VQkJMkMgebQCAn8kSso7Fpdya2pPtz/50
         zpHvW9MgcX3/J0nzGtfkDYPQ9jTzVG3dxTMkdRIFTwOQ5uSucYkl5ujTbwwuleqQJy9f
         143Q==
X-Gm-Message-State: AOAM533A0AKE4iRZUvIFRHzfygDOVRufj/vKpgjA+go+uyR2EsFYoUAJ
        EQQYkr+SwszQHqJ+JW02xKwg6wWxW2UKU5oy/jIN
X-Google-Smtp-Source: ABdhPJyVMb6OGzOroI3MWLR31n8ufeLb+EB+UvucCF3Yh2s48b5M2mZ8aZa2yJRdNPzpYhG6PrUGG9RXjA0h9Mc6zAB9
X-Received: by 2002:a62:6d04:: with SMTP id i4mr7199971pfc.188.1597795895276;
 Tue, 18 Aug 2020 17:11:35 -0700 (PDT)
Date:   Tue, 18 Aug 2020 17:11:33 -0700
In-Reply-To: <46fbe161aa154de9406117ee916b1bd5f549905c.1597760589.git.gitgitgadget@gmail.com>
Message-Id: <20200819001133.2845536-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <46fbe161aa154de9406117ee916b1bd5f549905c.1597760589.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: Re: [PATCH v2 11/11] maintenance: add trace2 regions for task execution
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Thanks. Overall this looks like a good patch set. As you can see from my
other emails the only issues I have remaining are minor.
