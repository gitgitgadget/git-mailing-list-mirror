Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8167FC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6965F61625
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFOQlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFOQlO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:41:14 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF72C061767
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:39:09 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id o5-20020a4a2c050000b0290245d6c7b555so3653659ooo.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=O3uuJfjrqqIEBgh1nfXPCfn07ei+j7Frqxee1DCtqcM=;
        b=HvU65ASy1lAF+TgQsamVTQq+X8+etpezXvT1LFuvlNBM28W5xp7jlYdt+UjpLaMWGo
         jPAuNGNhU/+OBLnOOPevwQZXczSd0iGJIZKvZIqlAGkNEDvj0f0cqC6RnDFoctfEcPGa
         Ox1gp2br5xR73taRBK3driVpxyLk0Vx1pvm7xC5q301bHudlmAJ4U/1TYhJEKZhhXGS2
         CQwMC0b+WwfoL8JFKL/2QVdnn14D9IHklA1qulSIglQ/KzVhAzCMs7CfNCe873SQ73g2
         so2Aexq5V4HBbmrUkp7PoDU9Sgun9JdIanTSLGDDd6AYTD9d1JGbSOPYOuQlh0B5NZ9k
         65/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=O3uuJfjrqqIEBgh1nfXPCfn07ei+j7Frqxee1DCtqcM=;
        b=ZwnUrGGgrOwmKVJXxAK5Yy8nHgNeOI+wcMbBy5blY55OT0HPNry9OW4tSpuyAC/AWJ
         0pVq/lXXxinU9H9pTufxrYMds3JNUbsYv8+/tCM/ih5EahR9QSbuxYq0bxCb7tL6u6Qd
         gRWCBLUrYKn+ISs7qgrPRMivPXYtO3jP5wbw5f1bif1nXaUPL+oIneAd5itxePNyTz59
         KvF/dQ19fHhM2+v/TwEioaxEYg8h3iCZRN73BuqYYQGrBm3ED7AiJtmcHHKFveb2lkzw
         fiyuoipxPjc6ERRJaDX/9GmZQ2pemyqTO0v5P/Je3CGzp3+mqliPnGkbBpE4xJRiS+jp
         NwFA==
X-Gm-Message-State: AOAM531H9iAWdk6/6bizbgBcQXei1HcvK/nPT31lxqjptz4n+2arv5gb
        DAaRNJtImf+AbhwH93UAuL+qjAEe+G3a7g==
X-Google-Smtp-Source: ABdhPJw7J+QsB+gckx5SBrWmJOAwJDtwGgt3cYJOkNtBh2kXRL9TcUuj0Yni8o85ZYbiGmRFZfzW3Q==
X-Received: by 2002:a4a:ba03:: with SMTP id b3mr98772oop.70.1623775148684;
        Tue, 15 Jun 2021 09:39:08 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c64sm1740718oif.30.2021.06.15.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:39:08 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:39:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org
Message-ID: <60c8d7ab2e5ce_1296f2089@natae.notmuch>
In-Reply-To: <88d70774f702f32b6618c626f44b1f216e03c297.camel@mad-scientist.net>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
 <20210611202819.47077-3-felipe.contreras@gmail.com>
 <94ce6d7d-f923-edb3-12f5-4b11149c9f6f@gmail.com>
 <88d70774f702f32b6618c626f44b1f216e03c297.camel@mad-scientist.net>
Subject: Re: [PATCH 2/2] comments: avoid using the gender of our users
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith wrote:
> On Tue, 2021-06-15 at 09:31 -0400, Derrick Stolee wrote:
> >   but sometimes a few slip by due to habit.
> 
> Or perhaps just, "but sometimes a few slip by" ?
> 
> No need to suggest a reason IMO.

There's no need, but I would prefer to imply no ill intent, nor neglect,
iow: they tried.

But I'm fine with not specifying a reason too.

-- 
Felipe Contreras
