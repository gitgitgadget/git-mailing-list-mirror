Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D223C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBC161073
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhFIFBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 01:01:20 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52767 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFIFBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 01:01:16 -0400
Received: by mail-pl1-f201.google.com with SMTP id d18-20020a170902b712b029010f71d164c6so7395083pls.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 21:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0ADbltRRIawtvDGi1L5iVaM2XboXGrMy69mUM77VXYo=;
        b=S/Crh67rQWMmB0mXuyP17uowBpGWIlFL9zSnVQZ+XmXFXYaPiaR4VcamAU66jMcEDd
         nY2s9t6rz7DmbWXmHfjM6KvF0RVduAW8shQJMxXC3z2/dumUG2JXoMTrwRGQTXUmdyIV
         glucdEkhRLFrP0mVF2wd/uk8sRkt7uslWCkInFDAjEFMDp8Z49CZbNIHN/V5ZKZ95eMl
         XRt1NJhluPQi/t1ujpDqXzNRpCEvcfQzvwt7jDmH3WVcJtXMn4neeYSH75qOjDm4rd8S
         tzEKWUdlAn6wHx/WPgezebG0M8cRM8bVsquy2pL2nbSt/04+6CUfaQ5DbAV5q/UoN5fZ
         5CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ADbltRRIawtvDGi1L5iVaM2XboXGrMy69mUM77VXYo=;
        b=kDnT0VVGbdwowwH+m1lq+C/gUwjOQuwIjUgmrJhyonJ4vdYICpCJB52zpSFqOhe+Gr
         bYff9fCcsqPztDLMLV07DrpJVOQPf2gqfompIMxDIDjlkOod5c8+CJrLpGgCBOZXTx3Z
         bvao/utwqMA1hZtDaAQ1JDfujixGasYal35OgqNepc+8Pbd51Cj0YxhZT7Aw2Ea4iacy
         zgPBG2Occ/mT0B9Jwp/QxZMcvGw7iM+SGOlPGayffN2Y8qOWvsmBSWPwP05P7bHDWWSX
         GPwxGULBDi5TzvIjKXwqXPBSE8yNjp6FmApqduNklM+79kPGgPU0e9jIQdsbhAiy7FJ0
         9+rQ==
X-Gm-Message-State: AOAM533P4XUFiR3bIyoBNHZ+2V521trw4RwXG2Dk8Agkh7mZSXwFKUsH
        0L9h4d9c3lA4Dhg1iU/nyIKfdhMrGWza3+bDxAva
X-Google-Smtp-Source: ABdhPJw/pbkF/MCksdaRj89ZlJO4c+cLXiTMHRHnq5wud554cgefeEtc7HxscGT4z36O2aECqW1xh928VznMMlGeh0hN
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:cb07:: with SMTP id
 z7mr298045pjt.0.1623214686036; Tue, 08 Jun 2021 21:58:06 -0700 (PDT)
Date:   Tue,  8 Jun 2021 21:58:04 -0700
In-Reply-To: <CABPp-BGL3L5uReVHtSUsNJ7fYgBV_Us5ZYv7e9FPHT2DuY-dyg@mail.gmail.com>
Message-Id: <20210609045804.2329079-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGL3L5uReVHtSUsNJ7fYgBV_Us5ZYv7e9FPHT2DuY-dyg@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 0/4] First steps towards partial clone submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        emilyshaffer@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Looks like Junio did spot some bigger items...which raises a question
> for me.  I have a series
> (https://lore.kernel.org/git/pull.969.git.1622856485.gitgitgadget@gmail.com/)
> that also touches partial clones.  Our series are semantically
> independent, but we both add a repository parameter to
> fetch_objects().  So we both make the same change, but you also make
> additional nearby changes, resulting in two trivial conflicts.  So,
> should I rebase my series on yours, should you rebase on mine, or
> should we just let both proceed independently and double-check Junio
> resolves the trivial conflicts in favor of your side?
> 
> Thoughts?

From [1], looks like this is already resolved, but in any case I think
we can just let both proceed independently since the conflicts are
relatively trivial. If it turns out to be not so trivial, I think Junio
can just let one of us know on-list and whoever it is can rebase on the
other's.

[1] https://lore.kernel.org/git/xmqqlf7jnb5u.fsf@gitster.g/
