Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E2C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 23:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3426520678
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 23:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERurCT+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHZXK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgHZXK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 19:10:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956BC061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 16:10:56 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s2so3963026ioo.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xUaWTHs9ZUBv+EfIZ0GIFzQk/yGS7997Nkj7khecaZk=;
        b=ERurCT+1Fq29qobMts13oItyePhjZX3MflhGAHFvdr28pj8KjNaIveEvTAWiA1gzLZ
         gTCCOmDb57UEWyMIujNGwtShJi4/efWHAzAiZHbyLVaFgtEOR6vJyFm47aIXkxDcvmaP
         uuknNg96gzQ+xTCb34a0LnxIm7oEP0YFigy5k5+Lv+AICFt6GlLdZKTK0XKfEwa9sPTK
         M2fgA3i/kNhfZ88qoFFgGCk7J478uQy743ist1vs8z5y6lv7GAxCMdumVuPuJT/DVAeo
         1CedKswjLtykg0Q+EhkrbvFZ8rKCB5crQ15tL4woinaL7Um8BJjKur2+wzlOiFRu/J6B
         yXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xUaWTHs9ZUBv+EfIZ0GIFzQk/yGS7997Nkj7khecaZk=;
        b=nSvF3t7lQ/28dt2ZTk8WkYrF1ddeZQ9Eu4b4QBc0e8YFSWzIUYxnOF9YojYVojmmlS
         Qy+lRCjibrU6Mqy8q4VvjnubaBB/+xC48aGI2tyUBDpjSBTiK/W8l2GmJI4Z2LDjZYRG
         rbfZfqToXhjX4c7XcJZjtGuCJ4R1oUZg8xJcghVy0BvuCth134tBWH089d01BFfK73tN
         C13KrOKhjNzzRuKjtmWxFL4/vtDN2zuWWtcIanLtMcIohOjo2S/Ygt8+LNtZAmiiJna4
         98/WmyeA+d1CE56uvDOGi/P0wO66u1XilDE2N8DlJHofoShl3zdcuufqA8kKIOf0WU0w
         OygA==
X-Gm-Message-State: AOAM530xeUbzQB4tVEBvZ7IR8ga5JKX0yWuTld9J0hUTceMMhtuSAsaj
        m082BZwyEcEbMDISFhG+N2jxOaWUnRLqoRexxxh/5u6N1p21jw==
X-Google-Smtp-Source: ABdhPJyRsG6/2ILRS1CZkzzZv5X83yThw6xN4aijIXxet08IKT9J2M/2JNpQVEJmpZDleJyyuDLDPSAa1bIHDccRDfM=
X-Received: by 2002:a05:6602:1589:: with SMTP id e9mr14742783iow.85.1598483453221;
 Wed, 26 Aug 2020 16:10:53 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Rutherford <tmrutherford@gmail.com>
Date:   Wed, 26 Aug 2020 16:10:42 -0700
Message-ID: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
Subject: post-checkout hook aborts rebase
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

My team encountered an issue today which I believe is a bug, and I'm
interested to know if those more familiar with the codebase and
documentation agree with me. Here's a bug report. Thanks for your
attention.

Tom

===

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Have a post-checkout hook that returns a nonzero exit status.
2. `git pull --rebase` where there is at least one local commit to be
rebased onto an incoming commit. (I assume any rebase would exhibit
similar behavior, but this is how I encountered the issue).

What did you expect to happen? (Expected behavior)

The rebase succeeds.

I expect this because the documentation for the post-checkout hook
states, "This hook cannot affect the outcome of git switch or git
checkout" https://www.git-scm.com/docs/githooks#_post_checkout

What happened instead? (Actual behavior)

`error: could not detach HEAD` is displayed, and I end up in a
detached head state.

What's different between what you expected and what actually happened?

I do not expect the post-checkout hook to prevent rebase from
succeeding. The documentation suggests this should succeed. It seems
either the documentation is wrong, or git's use of the hook is in this
case.

Anything else you want to add:

The issue is elegantly explained in this stack overflow answer:
https://stackoverflow.com/a/25562688/1286571

It's not clear to me if this is a bug, or an omission from the
documentation. I reproduced it on 2.28, but I haven't tried building
from source.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-42-generic #46~18.04.1-Ubuntu SMP Fri Jul 10
07:21:24 UTC 2020 x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.27
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]
pre-commit
post-checkout
