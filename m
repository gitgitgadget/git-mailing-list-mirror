Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0434FC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F3E64E63
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhBQUL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhBQUL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 15:11:58 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A98C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:11:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l7so12558310pgj.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3eU5xlmIM7UiR5howJn5myjlp3i3u31asKeFaqTxHDs=;
        b=Bnp6l/hs+doWF1evL25P4xVVguVLzCwQkCUmpEotuKPyhj9s2R1gfuDuHIxBnWdhqg
         MJJX45EwZHQSTq5955gy+PZOUXbGOrFXs2VnmRH/GaDWrsBco0D+nP1gT7b3gbkeObX8
         vlzBhjbhWeFT4aQrSHgzu6GOPaY/qr/mBKvLDlgbnMyyH9059dv4kIWL+2FokzraHah9
         9sznDslavnqGIanmKXn6LwqkZ6eiy56/OJuz64uKtvJ13NDYfjulhOJGF6B1vj9UH9J9
         Us+we+YZnm/ChtftHyQrqzDycWgfOGnB7I3QrkBBHLXwLB1LOHMYyXooYDqYL5fH4rhY
         6BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3eU5xlmIM7UiR5howJn5myjlp3i3u31asKeFaqTxHDs=;
        b=OKLI6UPM+2izV+4ars2/ZC4s1ZYOQ8wo0W4E/z1pdVWpS2XI/bTxJNwZaY/AKH6PqU
         KFhZ+36IrTSFLd5ZJJOmLA4QkebS1lassGLwobqcIREJ7Wt1ye54a3ULEoKEgH2PRWZH
         SdMEewHUThg41AsU6bYFhdJgN7FRQHzRldtgVpOmW0uAfukaviSAOSjQI2To1ld+ycpS
         iMm0+Oh4jn+IwOxFz2ZMS8vidadsp2XO+OhgIYHY95tgV+ks5u+axOeWjC6JyvNCbYh4
         Iand8Erh7Upugg71a9M5KLctw8EWPcsdbyk9eQyHk9ZntD1YG4LOUHDZXqnSg3N/6S+Z
         hhiw==
X-Gm-Message-State: AOAM5314Xa3zr8HgToMNutMlIjAnPE83K4gbVK5dRM/w1e04YcwI298o
        SWzYz3XbVoRlSuiBtMvQEPCr27brsLuzXYMPjdKN
X-Google-Smtp-Source: ABdhPJzbSKnb3JBWkj8mLnOJcEdWxQE2ZX9994pBcUQuFug+KkQJogLLLEwp25feaY0vcH0A879Ab7V2s6CKtUS29Evz
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:4203:: with SMTP id
 o3mr447202pjg.1.1613592677436; Wed, 17 Feb 2021 12:11:17 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:11:15 -0800
In-Reply-To: <8735xua40w.fsf@evledraar.gmail.com>
Message-Id: <20210217201115.879491-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <8735xua40w.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What's the need for STRICT here & can't the former use the existing
> fsck_options in index-pack.c? With this on top we pass all tests:

[snip code]

Good point - I'll do that.
