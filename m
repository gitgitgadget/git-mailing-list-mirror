Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E6C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 18:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245136AbiAXSWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 13:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiAXSWe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:22:34 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085DC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:22:34 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s19-20020a170902b19300b00149a463ad43so3782409plr.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HtAYBwZ9c+yKt5elaj3PmlU5kjDTRAANVjS8KwprxAo=;
        b=d+9EEmRXXPpYHTvw3DSV5cz8CabvXynvleG3O+/uhf4/3AXf85zA0UYzAHSX7GUGUL
         dM2WhoNytfxi4G+qpgDerniaHj+5bmmN739lyMIy1P0+cdVnfJ05LexDADqSCAm6TP4v
         wH6aA3qK6Ilf5rjTm1Nd3P/x9cciltIEa9N5ptSXkJxX90xGUsXKEOJpG1aO8GAUvDa0
         IgoA6Yr2Io3KOrOB2CbN87Fzg3d2FZuMhiU7Su4TZgCu3Fjn4755tQj+OSEwD4KDvYOE
         VELrbV115PlhOcVljJCVnlqNvmryeKgODFaa4p4VJ/KT0F3D/qnImvszOLXujgpGyDx1
         vUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HtAYBwZ9c+yKt5elaj3PmlU5kjDTRAANVjS8KwprxAo=;
        b=vTgmFmV85K7dU3f271Vphh9xFusPtJ+d30l6ZTXZ5nNWcn3DZTPI5ymEML60r1FIpa
         pY+GcxuY7o3zxqo8FSX1iYDvravYlRa3lp+VZHxGFAd5NKrFbnhPw2+DIfZxQxenY+/5
         fNCKuOCfYQ1r0Hl2YVfUGqR+JInzZz7KAM4YWplzwi9uFEEmK7tWutkIzhSRQ8kSfK2f
         tdmfHhpl9wmLQZ+zCJNsCf+8cN1t8LcA/yRwM70zuaaajS62q+ikp1tQvthgq4t2E4Fj
         AcHA+ReQCI/1ibxmKHsVVljPbFAiAWE2FR/8j5GW0ecD5tp6UHww4vw6Q580pRYJSoY5
         fImg==
X-Gm-Message-State: AOAM531KWpR2NCA3l+Yyd8D9OLexnnpXsxelM9KlHM9tzIX1tCbwmZJX
        LhZXP27OOS47De/3/IaULrXR9MSYlTH9P3LCTF4V
X-Google-Smtp-Source: ABdhPJy5Wzq2ZK8TAVIjAv20Y34NWYUvzFIwPUSm92u3YgtrV9isGtNC8WHYls/qnR7nVVv6rOfMg0b+1LXqbOK/7eaJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:b55:b0:4c9:25c7:b522 with
 SMTP id p21-20020a056a000b5500b004c925c7b522mr5397308pfo.55.1643048553773;
 Mon, 24 Jan 2022 10:22:33 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:22:31 -0800
In-Reply-To: <CABPp-BG9rxJsA9XwgUxpny5TDW4W7Z85PAkBdzKJXrSJxAim1g@mail.gmail.com>
Message-Id: <20220124182231.2439029-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BG9rxJsA9XwgUxpny5TDW4W7Z85PAkBdzKJXrSJxAim1g@mail.gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com,
        avarab@gmail.com, jabolopes@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> On Fri, Jan 21, 2022 at 6:05 PM Jonathan Tan <jonathantanmy@google.com> wro=
> te:
> >
> > When creating the sparse-checkout file, Git does not create the leading
> > directory, "$GIT_DIR/info", if it does not exist. This causes problems
> > if the repository does not have that directory. Therefore, ensure that
> > the leading directory is created.
> >
> > This is the only "open" in builtin/sparse-checkout.c that does not have
> > a leading directory check. (The other one in write_patterns_and_update()
> > does.)
> >
> > Note that the test needs to explicitly specify a template when running
> > "git init" because the default template used in the tests has the
> > "info/" directory included.
> 
> If wanted, you could avoid that by using `git worktree add ...`;
> git-worktree will create a $GIT_DIR that does not contain an info
> subdirectory.
> 
> (No need to resubmit or anything, mostly I'm just mentioning another
> way folks might have triggered this issue.)

Ah, thanks for the information.

> Patch looks good to me:
> 
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks for taking a look!
