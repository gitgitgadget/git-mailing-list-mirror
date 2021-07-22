Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B8FC07E9D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 04:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D51E6108B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 04:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGVDmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhGVDmN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 23:42:13 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CE9C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 21:22:49 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t6so5337974oic.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 21:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3hRE/scOdwta3OXB6u4rcT/Ps4mlLuNFGdbfknH9ls=;
        b=psKUROhViAzUUAdeT5b3UBnatVZb12bsOZpbhK5hBp3JMbkiZOJ3DXSANzc4UGLZ/D
         LYOhxzmb3kR4WzaqxFYDpVd0zPxFfNWHlUGn0y7Fdhuwza/pHj2E/s2KkBLLUwNTuZhs
         Ec8L8SsegYzWaYkg0+Cp+aMJOk5BUAdztWmYXTfJVts1AoOp306nvvieKyuqeo+AVZge
         QgxRW42y3XfdRz2VhZtFnr8K4HrND2xECjnhNo81eHDE+VuCYG07CTlapNYE4Vv59g0l
         LeL+pT07g3QcPMcYs2/T3dVxjVbrGKNZuOY3SIYJd2OuLijXwuXtN3mVjbEmeM6z+Qle
         e8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3hRE/scOdwta3OXB6u4rcT/Ps4mlLuNFGdbfknH9ls=;
        b=B+2jbCXANLpmQJD1FR5GBGNAzH1k1PreBEIp+QSWedbKWZ1XG93FhaFJAAx6uNNTRy
         mnUSRTFGzf0fTScIuSW6KA9mrZgquTgeLgv05/NZCQVrNiEoT9CkE3WNdJNoim5JQyB5
         jaVLErwg1IzifeDTHnwFDIJsNN1boop3VJCDoj3qrFLB23SX8OojKfIM9Qwuiscybh0o
         28P7TSneodZd9+vofd9z80Yr9DusaVs0GS41FSlfpcnCdUrev4fWSBWek7xpidbnKrBV
         7eOUH0sXTNOEwwsDYOPGYkvT4SVB1N5Zv8WK2hf0Y8OOTYgn2CFFirqtVIqMJs+2XKdr
         H2gw==
X-Gm-Message-State: AOAM531BovjbPzGdzMJl8/w4Ne5EZ4+W5rgVONYhhLtcleUJT6PQ8NNI
        ZawharHvxQRw+W4r0lIoOgQuVr6D9Ew3lwS3unw=
X-Google-Smtp-Source: ABdhPJzN8NxGhncFUbH7ShTPC91/gsDbu7SxR9K4d0xHFfCrZ1fZlD50wFH+Mo/6/5myQdtCEvxD3NiTplvpfKL8kmw=
X-Received: by 2002:aca:38c3:: with SMTP id f186mr4542346oia.39.1626927768644;
 Wed, 21 Jul 2021 21:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.973.git.1624932786.gitgitgadget@gmail.com> <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Jul 2021 21:22:37 -0700
Message-ID: <CABPp-BGbM_+bznuCCLfctt-XqVdCuROa9+s_jpeQXmTHEyZmjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Sparse index: integrate with commit and checkout
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

On Tue, Jul 20, 2021 at 1:14 PM Derrick Stolee via GitGitGadget
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
>
> Update in V2
> ============
>
>  * There is no change to the code, but it is presented in a slightly
>    different order.
>  * We've been discussing some complicated directory/file conflict cases, in
>    particular with a staged change inside the directory. These tests are
>    added and described as documenting incorrect behavior that should be
>    changed.
>  * After those tests are in place, we can motivate the change to
>    twoway_merge() as necessary for a more-common situation (still rare) but
>    still incorrect in an already-broken situation. Hopefully that balance is
>    sufficient for now, until we can do the bigger work of fixing the bad
>    behavior.

I read the first five patches previously.  The tiny changes there in
the range-diff still look good to me.

I very much appreciate the new patch 6.

As noted in 7/7, I'm a little unhappy with the patch to
twoway_merge(), BUT you've clearly documented the shortcomings in very
good detail and pointed out how git has (likely for decades) messed up
in related ways for non-sparse checkouts with D/F conflicts.  You've
documented it well enough and argued well enough about the relative
merits, that I have to agree with you that this is a good step
forward.  I do hope we circle back and tie up the loose ends at some
point.

So, the whole series is:

Reviewed-by: Elijah Newren <newren@gmail.com>

>
> Thanks, -Stolee
>
> Derrick Stolee (7):
>   p2000: add 'git checkout -' test and decrease depth
>   p2000: compress repo names
>   commit: integrate with sparse-index
>   sparse-index: recompute cache-tree
>   checkout: stop expanding sparse indexes
>   t1092: document bad 'git checkout' behavior
>   unpack-trees: resolve sparse-directory/file conflicts
>
>  builtin/checkout.c                       |   8 +-
>  builtin/commit.c                         |   3 +
>  cache-tree.c                             |   2 -
>  sparse-index.c                           |   2 +
>  t/perf/p2000-sparse-operations.sh        |  47 ++++--
>  t/t1092-sparse-checkout-compatibility.sh | 197 ++++++++++++++++++++++-
>  unpack-trees.c                           |  11 ++
>  7 files changed, 240 insertions(+), 30 deletions(-)
>
>
> base-commit: e5ca291076a8a936283bb2c57433c4393d3f80c2
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-973%2Fderrickstolee%2Fsparse-index%2Fcommit-and-checkout-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-973/derrickstolee/sparse-index/commit-and-checkout-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/973
>
> Range-diff vs v1:
>
>  1:  bb3dd1fdd48 = 1:  6e74958f590 p2000: add 'git checkout -' test and decrease depth
>  2:  eb15bf37685 = 2:  3e1d03c41be p2000: compress repo names
>  3:  413babe6e77 ! 3:  cd94f820052 commit: integrate with sparse-index
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is e
>       + ensure_not_expanded commit --include deep/deeper1/a -m deeper
>        '
>
>      - test_expect_success 'reset mixed and checkout orphan' '
>      + # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  4:  ffe8473caab = 4:  65e79b8037c sparse-index: recompute cache-tree
>  5:  8710fee36b7 ! 5:  e9a9981477e checkout: stop expanding sparse indexes
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
>       + ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1
>        '
>
>      - test_expect_success 'reset mixed and checkout orphan' '
>      + # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  -:  ----------- > 6:  4b801c854fb t1092: document bad 'git checkout' behavior
>  -:  ----------- > 7:  71e301501c8 unpack-trees: resolve sparse-directory/file conflicts
>
> --
> gitgitgadget
