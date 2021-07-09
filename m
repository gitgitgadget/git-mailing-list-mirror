Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B98EC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 21:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAD3613B7
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 21:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhGIV24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 17:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIV2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 17:28:55 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0A9C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 14:26:11 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so10860524otq.11
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpViHiksy0LP3GJCQBTJMoVmWA4xAfwC9bimt2NAifQ=;
        b=BxRIfgHBgS2fSTXeaPteN/ET20rroCocI4KJFolGZVhXeZxi+KM5YLULKdEfUzKyHh
         Q55+qReHKo7XRJy3qrV9q4PGkVzCBS8+Zu34FvmVYGx+NDG+G725Zba6GHEh4MMPMo7g
         f5Oxe+nIqntXJGEyFco6f+Q3YAJv075wsevOeAuO2NJ+3eH3neAAGUgeFdnxaeLynrkS
         jj+IFT42Zx+uiSM3jkmFMbhAN52kScveZ20mYnZ9NtK9DldeSbKu2c2CYeODCmCa1GGj
         DLm7lO6OknTatOVUNuFGxptHa37erRqlB5YHdaAOd4m0KkXRFFJJBs0yEBs5dVDgfXM4
         pILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpViHiksy0LP3GJCQBTJMoVmWA4xAfwC9bimt2NAifQ=;
        b=JuztZRfDPNXYVb2uKDyA3qmEvbk1H1hxgQlLfg9xyP40or0wT3cl+J5d71EAf9XXE5
         1z4uoTp7Oa2GG/Cb3rOC4UnKBZeVUeGG7UkyUckYRQM2YB5Kzk+9jIhx7DBwa/Ng7LLU
         BP8DvuZcgSAKK6eIj8qvpKjzc4bE926KJ+a0C+CUPM6Iab9rqE065QgkH3LxdLg1QqMQ
         pmmj9goRmYh7+fkEfMjTkHy1pjKC0XTw/FMUNkpUfaZf273H7pFRzQ1v9FVe8bBMV4bT
         /4DQTkhxgW4bSyy2x4kktG0fSqO+eGIsBRBUBOlguvTmpalxZCbREMGujmc1P+sO3Km+
         CGJw==
X-Gm-Message-State: AOAM532seSZkQYawyUPIbatdRODcBblgfLxP+AjHMg6H4lzH6rOD5Lm4
        uRdozZN8l0sjgYlBjRrGUWyUoeReHeilMSZArvw=
X-Google-Smtp-Source: ABdhPJzVXyQwDkLlvGgTC55cvwBsekUDvpEhjnZqQCIQ/PcQHEWQ163UkYCWbUBprzWkSN9UzZhVKBb72/yKWgTRcks=
X-Received: by 2002:a9d:73c1:: with SMTP id m1mr27072992otk.162.1625865971103;
 Fri, 09 Jul 2021 14:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.1624932786.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 9 Jul 2021 14:26:00 -0700
Message-ID: <CABPp-BF_i1QRCXaeKzqoc6Q2=3un-wku7aKUEdBbXfeVfTG8xg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Sparse index: integrate with commit and checkout
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 7:13 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series extends our integration of sparse-index to 'git commit' and 'git
> checkout'.
>
> This is based on ds/status-with-sparse-index (v7) and v2.32.0. The hard work
> was already done in that topic, so these changes are simple.
>
> Recall that we have delayed our integration with 'git add' until we can work
> out the concerns about how to deal with pathspecs outside of the
> sparse-checkout definition. Those concerns might have some overlap with how
> 'git commit' takes a pathspec, but this seems like a rare enough case to
> handle here and we can be more careful with the behavior change in the next
> series which will integrate with git add.
>
> In addition to the tests that already exist in t1092, I have integrated
> these changes in microsoft/git and tested them against the Scalar functional
> tests, which go through quite a few complicated scenarios, verifying that
> things work the same across the full index and sparse-index cases.
>
> Thanks, -Stolee
>
> Derrick Stolee (5):
>   p2000: add 'git checkout -' test and decrease depth
>   p2000: compress repo names
>   commit: integrate with sparse-index
>   sparse-index: recompute cache-tree
>   checkout: stop expanding sparse indexes
>
>  builtin/checkout.c                       |  8 ++--
>  builtin/commit.c                         |  3 ++
>  cache-tree.c                             |  2 -
>  sparse-index.c                           |  2 +
>  t/perf/p2000-sparse-operations.sh        | 47 ++++++++++++--------
>  t/t1092-sparse-checkout-compatibility.sh | 55 ++++++++++++++++++++++--
>  6 files changed, 89 insertions(+), 28 deletions(-)
>
>
> base-commit: 1d744848ee6b58ccaf3a30f20abe9797ed5d2ce7
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-973%2Fderrickstolee%2Fsparse-index%2Fcommit-and-checkout-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-973/derrickstolee/sparse-index/commit-and-checkout-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/973

I've read over these patches and didn't find any problems in them in
my reading; however, since it builds upon ds/status-with-sparse-index
(v7)...

I decided to retry some of my ideas and testing on Patch 10/16 of v7,
over at https://lore.kernel.org/git/CABPp-BHwTAKwFiWQ0-2P=_g+7HLK5FfOAz-uujRjLou1fXT3zw@mail.gmail.com/

It turns out that the block you added there is now triggered by t1092
after this series, and the testcase won't pass without that block.  It
might be clearer to move that code fragment, or perhaps the whole
patch, into this series...though the code fragment as is has
introduced a bug.  If you take t1092 test 12 ("diff with
directory/file conflicts") and modify it so that before the

    git checkout df-conflict

invocation from sparse-index, you first run:

    $ git sparse-checkout disable
    $ echo more stuff >>folder1/edited-content
    $ git add -u
    $ git diff HEAD   # note the changes
    $ git sparse-checkout init --cone --sparse-index
    $ git diff HEAD   # note the changes are still there
    $ git checkout df-conflict  # no error??  What about the
conflicting changes?
    $ git diff HEAD

then the last command will show that the staged changes from before
the commit have simply been discarded.  In short, this makes the
series behave like --force was passed with sparse directory entries,
when --force wasn't passed.

So we've still got some directory/file conflict issues.
