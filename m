Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DD01F453
	for <e@80x24.org>; Sun, 30 Sep 2018 05:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeI3LpK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 30 Sep 2018 07:45:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34032 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbeI3LpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 07:45:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id x23-v6so10856670qtr.1
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 22:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GX5qzLTqXskO8vPRegn3sA/u+WnQBhSXcgmZ1xINusM=;
        b=WRlo0TB93Lt8uDcBaI7HIjA7aXaUOaycLmQxcEQKsBtL5Q28wOd2yopu/84ETBzpft
         BrfPCVrcWQHH6JF8BYJ5erYHdtK/1zwJvDx9HEPp1JQtUNRr6pN6L1foIDE1C6zaLvxn
         u8KtsPXSkrvfZy2AUhK6UiNbJsabnDlIhWaGiuF6nyw+hLLZgYKhwWZUWrpeeIzgi5hG
         xSJbhm37WZbDxObBMNC5JBlXIYrdQowmwrQRRcXKmr5tmdRkyT9vLStVwmbQQ0f+r+go
         NHpOWxsSm7qMuxR8FgpPzN7xEI+QKrsN0S1VJA2Wn3Ftfpb6zfAvUE5N8sHJUx77QfNV
         w3UA==
X-Gm-Message-State: ABuFfohGD+3KlCB2UYz6iyw0wSII6wz9VVpmJtzmwRLNRyUojemNtAVU
        ii2xUbhXYkSs0ReIOkXn6K4mMVzD9vGKdznrH8Q=
X-Google-Smtp-Source: ACcGV63rI7Uc7qFIaJBqc/jh1UdS2cBKa+t9U4dVYJiOFD29nATRp9N6WOyEwnp8H6KtapWki1Xsg/BOxkr+Pxtlcec=
X-Received: by 2002:a0c:964a:: with SMTP id 10-v6mr4291320qvy.62.1538284419203;
 Sat, 29 Sep 2018 22:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180929191029.13994-1-pclouds@gmail.com>
 <20180929191029.13994-4-pclouds@gmail.com>
In-Reply-To: <20180929191029.13994-4-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 Sep 2018 01:13:28 -0400
Message-ID: <CAPig+cTRNzhKhcmt7hnLHP=8Oc86EnokSDzDD4z2CGYFGmuz4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] refs: new ref types to make per-worktree refs
 visible to all worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 3:10 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> The main worktree has to be treated specially because well.. it's

Nit: s/well../well.../

> special from the beginning. So HEAD from the main worktree is
> acccessible via the name "main-worktree/HEAD" instead of
> "worktrees/main/HEAD" because "main" could be just another secondary
> worktree.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -216,6 +217,18 @@ directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
> +Refs that are per working tree can still be accessed from another
> +working tree via two special paths main-worktree and worktrees. The

s/paths/paths,/

> +former gives access to per-worktree refs of the main working tree,
> +while the former to all linked working trees.

s/former/latter/

> diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
> @@ -30,4 +30,50 @@ test_expect_success 'refs/worktree are per-worktree' '
> +test_expect_success 'ambiguous main-worktree/HEAD' '
> +       mkdir -p .git/refs/heads/main-worktree &&
> +       test_when_finished rm .git/refs/heads/main-worktree/HEAD &&
> +       cp .git/HEAD .git/refs/heads/main-worktree/HEAD &&

Better to use "rm -f" for cleanup in case this 'cp' fails for some reason.

> +       git rev-parse main-worktree/HEAD 2>warn >/dev/null &&

You could probably omit the /dev/null redirect.

> +       grep "main-worktree/HEAD.*ambiguous" warn
> +'
> +
> +test_expect_success 'ambiguous worktrees/xx/HEAD' '
> +       mkdir -p .git/refs/heads/worktrees/wt1 &&
> +       test_when_finished rm .git/refs/heads/worktrees/wt1/HEAD &&

Ditto "rm -f".

> +       cp .git/HEAD .git/refs/heads/worktrees/wt1/HEAD &&
> +       git rev-parse worktrees/wt1/HEAD 2>warn >/dev/null &&

Ditto /dev/null.

> +       grep "worktrees/wt1/HEAD.*ambiguous" warn
> +'
