Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F63C77B7E
	for <git@archiver.kernel.org>; Thu, 25 May 2023 19:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbjEYT47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 15:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjEYT46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 15:56:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9682DF
        for <git@vger.kernel.org>; Thu, 25 May 2023 12:56:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5653213f5c0so2001167b3.1
        for <git@vger.kernel.org>; Thu, 25 May 2023 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685044613; x=1687636613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcshBM4r0TioU2FQFexEwJ08o0ko6l22sRiY3+09s/Y=;
        b=h5+UsqQFHmBKsSA9+lE7yUwM/tHtkj/yKDambJq10xs17ez3makIBODUhm2pHhNS9n
         S5/5nv7u3aS+d4l3k5Zh8OdUrCBTT38liHQ0i2++dn45eYfnPZAD/b3xYjenzbnHzbRy
         DKTZ3xMcOgC0v0pJHuL+5S1FIVI18PfpIVhoMihcSZi1VAWQkIl5NRelr4zP4INf4FNa
         1180toZcSdZUb9iBNmUx10KaUSU9ANQNXtvEySn+IXEsiDIWCzMh1svD1Gc2A543lBWC
         4AXFQEUeaQMackWTOC7qHlBRijFQAWl/yGeltU9OszfMMVnjdL18XRs5ci/6rYd3KXrV
         mt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685044613; x=1687636613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcshBM4r0TioU2FQFexEwJ08o0ko6l22sRiY3+09s/Y=;
        b=dGZzPWqouwxpV3sknTlwu2i6ruW7y6qXHK8kGr4GsRaD12hhA+MbnTCGsIAvI7ivWI
         zVynNzv1ogzOGrFeyT2kueUYdCF3/d4z9mK876ZE8dlz5ZfpngNv1Ls+MjOpSlQXERBm
         N+xeJDWgxgLMW2k0XSnHW4QSvHw9QwexWfDBtcfnsKw1ctxAmoPnDp4FYnp2Ac7fKq0o
         OlZBgyWcbWhKqC1fskpoVQZ0hhNaI13yM3J+QFyx3pl34QtgfHa7nIZeIA/gXOnUSuIc
         D2se6s0xsJz5d0fU0fyqqUtcYSpTrAAf9atQanQVW/HDtNUaXnlMuQJ+pS7bjhEkN21c
         YuTg==
X-Gm-Message-State: AC+VfDwbMSJ+U8Cj1Jt/qlznY3RqNLBqc+476kcSxmm1TyPBFdgOyNOX
        HKTc+pUQy+BaCs0lOM34iqUIZbmJMSHT1g==
X-Google-Smtp-Source: ACHHUZ688YaMaxHWT23tO553bPi1yLLR0TBHey5h1VJ4ipMKYLaafENWy1NaAidOjEnXoA6jN6FRa12BeLmL6Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:b707:0:b0:561:81b:7369 with SMTP id
 v7-20020a81b707000000b00561081b7369mr400038ywh.8.1685044612948; Thu, 25 May
 2023 12:56:52 -0700 (PDT)
Date:   Thu, 25 May 2023 12:56:38 -0700
In-Reply-To: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
Message-ID: <kl6lpm6oxk09.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/2] Fix behavior of worktree config in submodules
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The outcome of this series is that 'extensions.worktreeConfig' and the
> contents of the repository's worktree config are read and applied to (and
> only to) the relevant repo when working in a super project/submodule setup.

Thanks sending these patches! This is an obvious bug, and squashing
another global is always helpful.

> I'm
> also hoping this will help (or at least not hurt) the work to avoid use of
> global state in config parsing [2].

Both pieces of work touch different bits I think - yours plumbs and
reads a "struct repository" before the config iterating begins, mine
plumbs config source information after the config interating - so
they don't help each other, but at least the conflicts are only textual.

Junio: There are quite a few conflicts. AFAICT each only has to be
resolved once (IOW the number of conflicts to be fixed is the same with
"git merge" vs "git rebase"). I have a v2 that I'm about to send, and if
you'd prefer (especially since you're on half-vacation), I can base it
off Victoria's topic, which looks pretty straightforward and will
probably get merged pretty quickly.
