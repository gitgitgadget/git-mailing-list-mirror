Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06BBC433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 03:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C287061954
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 03:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhCaDkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 23:40:23 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:37582 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhCaDju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 23:39:50 -0400
Received: by mail-qv1-f41.google.com with SMTP id iu14so3734817qvb.4
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 20:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w2KROlF+ZM9c8pglKYG8CbrwOtS23mVBgaJrogWBqLQ=;
        b=Ucte/iS636H8eS9/SNNFrmos3R4dBt6kAGPUYlirCao4AIYPlkcT2qTY+pKauPkNHb
         GURtMYLVnAGJzuWYgJiABVy+BDRNzh7HdXuukFp4NdIaKK5csskgeAlKw6dLNsCHafa2
         Fk3yHQm9HuW7USlsjKiI6e0WKeXgaYBMybngK7xa6B1QGA4yTCqcjXqgd+tsbuBaQSTO
         cEaaItby2RfYSWeB4Gox9MSqlGHEwJi83Nc67I2QH+tGCyIf9eZ8ZEglEMZvQIOOxMTw
         Sg+GdJV06zE4KJmT1b/SoF2OhuTCwqd+3A7VCF4f82j1VEuawiTvSa/FKTLZyjAtbNb/
         Azqw==
X-Gm-Message-State: AOAM530hZ5tIJj7Y5BERcvookMIlisDmYBxJ+zuGRZG6RqsUY7vyp4JT
        +FAhOjf4VEBVX/m2L9wG/P0XwTngNpYLgYcs7RSw0ytEM1Q=
X-Google-Smtp-Source: ABdhPJxki+Yp6pyHVxN/wP40lchsEJXC50Q89kWNQdjw7wihXUJPk59zeVWRv0XcTX26+jW4fpOnuhgBhLLNbbrq8v8=
X-Received: by 2002:ad4:4692:: with SMTP id bq18mr1341089qvb.0.1617161988272;
 Tue, 30 Mar 2021 20:39:48 -0700 (PDT)
MIME-Version: 1.0
From:   Drew Noakes <drew@drewnoakes.com>
Date:   Wed, 31 Mar 2021 14:39:37 +1100
Message-ID: <CAJd66x6XT7m5Njg2kRyGJ80rU6WNcLifijS98=onJeBz+74rrA@mail.gmail.com>
Subject: Detecting when bulk file-system operations complete
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I develop IDE tooling that watches a repo's workspace and reacts to changes.

Bulk file-system changes (i.e. branch switch, rebase, merge,
cherry-pick) trigger lots of file system events, and my tooling should
ignore intermediary updates. Currently I debounce events with a fixed
time span, but would like a more reliable and performant approach to
scheduling this reactive work.

Can this be done by monitoring the GITDIR in some way? For example, is
there a file that's present when these operations are in flight, and
which is removed when they complete?

If an operation is interrupted (i.e. merge or rebase that hits a
conflict) my tooling should consider the bulk operation as complete.
This means that detecting a git-rebase-todo file or
rebase-merge/rebase-apply folder is not adequate.

Any help appreciated. Thanks!

Drew.
