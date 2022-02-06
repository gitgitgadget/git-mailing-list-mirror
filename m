Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B8C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 19:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiBFTgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 14:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiBFTgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 14:36:51 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64F1C043186
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 11:36:50 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id w1so48040plb.6
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 11:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kytHUzA4PcWSeBHk6qfQ90p62NbC521bZHrzsO1EBXc=;
        b=tYhBNTzJexiOTgCEPHvbsocwASPYwgyO4yZfy+QQHJpaUNjzy1VSVu4Y6i4C6XwSJO
         TY7vgZ6KtQYMTpxPP4wJWirI7rvmmozYa3otvTo5Obxl0caeKtNe3fPfNyEQCgtNaXxn
         ogbNY7wUIHcCrizzBL4oQDS38z+1JaXn0R+gX7LSBrk/HIQdX3W4xijJ/VOPan7/tHvq
         5NwQFMv7t2O1rIMvnemeQqzTzca2t/4laAmCnnd9NiHN6cwNyhVaycxkEXcZ5/jWBZtz
         rdTsoW8QEkmzbttF47OvLgBCPj7F/tSaYPBaa0trCWhb42hBQmaXymQWFntWRbe2qunS
         +BFQ==
X-Gm-Message-State: AOAM5332XEzAXYRAMR62tBtKQRXjpSaSN42MxNPSOqGx0mTHP6bDhu79
        7LaP9ywKYhx567KZU4JEEZgCS2XPDGjy3Tu+wOk=
X-Google-Smtp-Source: ABdhPJzd7XB/0xQy2vAmtE0biPbuigeS+vNyyBeiYJ9DpEslLsIUv+iFOGYCwWFfWZoWcn7oNrNUVkWII+O0Sw7/CDk=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr10236022pjv.150.1644176209933;
 Sun, 06 Feb 2022 11:36:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com> <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
 <CAPig+cQOieO3cmZv42G_8XRiMwkh4v3cO1AYg5VR9SiPNMwxhw@mail.gmail.com>
In-Reply-To: <CAPig+cQOieO3cmZv42G_8XRiMwkh4v3cO1AYg5VR9SiPNMwxhw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Feb 2022 14:36:39 -0500
Message-ID: <CAPig+cQf-qxkGfz_inJvxhi-YMKYDBkROyE5T5+86K7Lwh7brA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config
 on add
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 6, 2022 at 6:30 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jan 31, 2022 at 10:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > +       new=repo/.git/worktrees/worktree/info/sparse-checkout &&
>
> For robustness, this should be using:
>
>     new=$(git rev-parse --git-path info/sparse-checkout)
>
> to retrieve ".git/worktrees/<id>/info/sparse-checkout" rather than
> hard-coding "worktree" for "<id>".

Of course, I mean to type:

    new=$(git -C worktree rev-parse --git-path info/sparse-checkout)
