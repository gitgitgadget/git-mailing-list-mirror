Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD412C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 00:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A5061038
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 00:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhHMArB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 20:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhHMArA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 20:47:00 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCEC061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 17:46:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id be20so13397847oib.8
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 17:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2q7kWgP9Kfxy/edS59q5foMFZjiin4+v6WntvP1uyA=;
        b=nuvymqEA/CxZ/S0G2SGXCI9hDCw5ZZO35YiYfmaOOAtH+rq/ixXsfdQc/qRmRF9dp+
         faW3kNNLJmE4Fd0c/bUJINS6rsy/AEjScsgWom1Jepv8nYoyQjf5C0lb+sOFfCS/ewfw
         6C9CIoO2NYp8pRo3qiWckg2GjJB46TicMXed+MbbpL4hZuomtQcqMkaMdK6/RyHDuJVF
         xxbk7fCIyKGVtzTZh4RPyzTwEm+UPK6JSEieEE8wf/TnwBeUGiQ744Glu5BdNVE8EflT
         ACdqtdjhSW1X7xf5dQL69qscc5SXIRGQcJChCc6h+h7kyOD66B290MD4VIXpeGarGkKp
         ZA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2q7kWgP9Kfxy/edS59q5foMFZjiin4+v6WntvP1uyA=;
        b=k7F3EDuBVD7cc9bb4zelzpIEVivLTPWXh0p8FAAK5ENj+HTWoCnoyScQaU2OXkVQUP
         VmZtRbwH3bzms1DwB8xTBBywKwhpvrKcvimtPlkdeSNIZ8HkwF5TRdKiqNh+sAFaV2yl
         wamjiN2FXQPEbQ+5k339cs+R2SDdcb6IzFbIyCRw/hfX1ZAQg1aR8vXSUDUCU0z+vRcK
         IIrNprd6ymDBmkqq9j85atQw5n29OgQg26GRZnpG+uiW7eKx2r/bCI0Qqmfv6BC7lIdt
         TXBQxFbImS+FTKiaxZR0AXJgZU3MNtXs80y8M9mo5MSYDg6PhnfKGf66rj7I2NlH3sIT
         V69Q==
X-Gm-Message-State: AOAM531vMBfkcZ4USvV4sSYITEoHgR94Xw4PMP7mgrCBUTcCoD9N2YgN
        JxhXS4JCVKzH1iP1jYrURZhcjDGBnGOpDfI9nvs=
X-Google-Smtp-Source: ABdhPJzuldj1RN8Cye0UpIj0btWNM96NqY+dFS1w4KgVpLGyoKDjHCyYudyIbfSUNQ3uGtsxik4hbxS9ghowDbTdBUc=
X-Received: by 2002:aca:902:: with SMTP id 2mr36942oij.167.1628815594191; Thu,
 12 Aug 2021 17:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com> <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Aug 2021 17:46:22 -0700
Message-ID: <CABPp-BGHmCCeY7j9hVDGZPuLU8gR-ka3iEzUjK0wvkSUSYdNxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rebase --continue: remove .git/MERGE_MSG
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 6:46 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks for the comments on V1. I have expanded the commit message for the
> first patch to give a bit more context and reworded a couple of test
> descriptions in patch 2 as suggested by Elijah. Patch 3 is unchanged.
>
> V1 Cover Letter:
>
> If the user removes all the changes from the worktree without running git
> reset then rebase --continue leaves behind .git/MERGE_MSG which will then
> seed the message of the next commit. While working on this I noticed a
> couple of fixups for the test files I was adding to, I've cc'd Elijah in
> case my reasoning for patch 2 is off. Thanks to Victor for the bug report.
>
> cc: Victor Gambier vgambier@excilys.com cc: Elijah Newren newren@gmail.com
> cc: Johannes Schindelin Johannes.Schindelin@gmx.de
>
> Phillip Wood (3):
>   t3403: fix commit authorship
>   rebase --apply: restore some tests
>   rebase --continue: remove .git/MERGE_MSG
>
>  sequencer.c                |  3 +++
>  t/t3403-rebase-skip.sh     | 13 +++++++++++--
>  t/t3418-rebase-continue.sh | 18 ++++++++++++++----
>  3 files changed, 28 insertions(+), 6 deletions(-)
>
>
> base-commit: 2d755dfac9aadab25c3e025b849252b8c0a61465
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1013%2Fphillipwood%2Fwip%2Frebase-remove-merge-msg-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1013/phillipwood/wip/rebase-remove-merge-msg-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1013
>
> Range-diff vs v1:
>
>  1:  7559781ca92 ! 1:  8755dfa9d04 t3403: fix commit authorship
>      @@ Commit message
>           t3403: fix commit authorship
>
>           Setting GIT_AUTHOR_* when committing with --amend will only change the
>      -    author if we also pass --reset-author
>      +    author if we also pass --reset-author.  This commit is used in some
>      +    tests that ensure the author ident does not change when rebasing.
>      +    Creating this commit without changing the authorship meant that the
>      +    test would not catch regressions that caused rebase to discard the
>      +    original authorship information.
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>  2:  f7722dab21d ! 2:  84fe5823b4f rebase --apply: restore some tests
>      @@ Commit message
>           from "am" to "merge"", 2020-02-15). However some tests seem to have
>           been missed leading to us testing the "merge" backend twice. This
>           patch fixes some cases that I noticed while adding tests to these
>      -    files, I have not audited all the other rebase test files.
>      +    files, I have not audited all the other rebase test files. I've
>      +    reworded a couple of the test descriptions to make it clear which
>      +    backend they are testing.
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>      @@ t/t3403-rebase-skip.sh: test_expect_success setup '
>        test_expect_success 'rebase --skip can not be used with other options' '
>
>        ## t/t3418-rebase-continue.sh ##
>      -@@ t/t3418-rebase-continue.sh: test_expect_success 'non-interactive rebase --continue works with touched file'
>      +@@ t/t3418-rebase-continue.sh: test_expect_success 'setup' '
>      +  git checkout main
>      + '
>      +
>      +-test_expect_success 'interactive rebase --continue works with touched file' '
>      ++test_expect_success 'merge based rebase --continue with works with touched file' '
>      +  rm -fr .git/rebase-* &&
>      +  git reset --hard &&
>      +  git checkout main &&
>      +@@ t/t3418-rebase-continue.sh: test_expect_success 'interactive rebase --continue works with touched file' '
>      +  git rebase --continue
>      + '
>      +
>      +-test_expect_success 'non-interactive rebase --continue works with touched file' '
>      ++test_expect_success 'apply based rebase --continue works with touched file' '
>      +  rm -fr .git/rebase-* &&
>         git reset --hard &&
>         git checkout main &&
>
>  3:  6a63b657f13 ! 3:  028c9dfc460 rebase --continue: remove .git/MERGE_MSG
>      @@ t/t3403-rebase-skip.sh: test_expect_success 'moved back to branch correctly' '
>         test_must_fail git rebase -i --onto goodbye \
>
>        ## t/t3418-rebase-continue.sh ##
>      -@@ t/t3418-rebase-continue.sh: test_expect_success 'interactive rebase --continue works with touched file' '
>      +@@ t/t3418-rebase-continue.sh: test_expect_success 'merge based rebase --continue with works with touched file'
>         git rebase --continue
>        '
>
>      -+test_expect_success 'rebase --continue removes .git/MERGE_MSG' '
>      ++test_expect_success 'merge based rebase --continue removes .git/MERGE_MSG' '
>       + git checkout -f --detach topic &&
>       +
>       + test_must_fail git rebase --onto main HEAD^ &&
>      @@ t/t3418-rebase-continue.sh: test_expect_success 'interactive rebase --continue w
>       + test_path_is_missing .git/MERGE_MSG
>       +'
>       +
>      - test_expect_success 'non-interactive rebase --continue works with touched file' '
>      + test_expect_success 'apply based rebase --continue works with touched file' '
>         rm -fr .git/rebase-* &&
>         git reset --hard &&
>
> --
> gitgitgadget

Thanks, this version looks good to me.
