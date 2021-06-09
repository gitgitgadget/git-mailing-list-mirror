Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27112C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087756054E
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFIUwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:52:39 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:43604 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFIUwi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 16:52:38 -0400
Received: by mail-qk1-f179.google.com with SMTP id j62so11349143qke.10
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q+HYSoShJUTiIhdUJC51tJycLUpwrBvHjyqEW2zNSJA=;
        b=XNQiK5H2nWORR2Esegh0rwXUj9wuWnCMXRvYR6yJpcyefrOyKjtHQVB2h/rxLrPrvm
         HRaymhYh7OxIjHUMucCYLi2n7rBJYa7CpWw847fNbE9if38XvrCus1fZrltE/5I3Zt0g
         9PjcMaGU84+A+yJwXn3u70xLIYGhJRW9Cq4/XJtW/45otBLoaUK/7xzZqXIcdFeredvh
         LhevBGmBXGnsRhUffHr0wQObP/KcwoB0d3d4YdstRuE5tAeOclour8dfwqy+eaOxLnvO
         ZXEPAEaQDphM1YJgXtfwkPVvpVOKlkd23ZWQ/1QErkFfxlrn3nqcGwOB+ZcToIduofFF
         qS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+HYSoShJUTiIhdUJC51tJycLUpwrBvHjyqEW2zNSJA=;
        b=iH4KAxGjb7NcLsg4JrOusFweuo2zCatG+CtZquEj6hKbZ5po/3qrxJXDe8xxlfv1pM
         dgQqCRQVRnQTwJnEDLe6Rip8uWihqMcqBFWFkuo1dkj4lXbrFE0lDPew9qc8K6ONuwuD
         x1TZYUJatbJIiV0vwxuC8JPbtn5kUvWwJS6ttG56F0/mHy9L06jvmjiN6KGjSoxLeF+S
         8kkxOOiLJXGUaY8L3/jz1qxCu2qJyYvpBciH4c1jzdKexq7c5cQ/WHMDUWLh4sO+Fifc
         gAlAMNNOyBrql5UwEh5x8GsZT8uuy2NefzVcnkjE+Y1wmaiMJB4XDnbHXsG7p95njIhj
         vHdA==
X-Gm-Message-State: AOAM531WHjLAWEzZP8wv5bc1Bt7oJhUGB5UwUpP9zY7vlDN0w1mzhzDc
        1doH2G4j6nZrNrAQOEGvwYI=
X-Google-Smtp-Source: ABdhPJyUWGuQUiGbCOMxK/72oupjfpjk9ho/K5fF2uhMKfIrOP0+qh5HP5vNkD46mMchCTadtvaJhw==
X-Received: by 2002:a05:620a:13c9:: with SMTP id g9mr1549095qkl.86.1623271767967;
        Wed, 09 Jun 2021 13:49:27 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:757b:21f8:d6f2:dd1b? ([2600:1700:e72:80a0:757b:21f8:d6f2:dd1b])
        by smtp.gmail.com with ESMTPSA id e20sm770455qtr.55.2021.06.09.13.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:49:27 -0700 (PDT)
Subject: Re: [PATCH v5 13/14] wt-status: expand added sparse directory entries
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
 <02f2c7b63982cfbafc300e1cd901473d5b9b7297.1623069253.git.gitgitgadget@gmail.com>
 <CABPp-BHOcDUJbA0ZRvxhOKryp3wdXj1yOrTovQBJi3PEoAMY_Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f90d241b-4b02-4f8a-a2f5-1b47fde69db4@gmail.com>
Date:   Wed, 9 Jun 2021 16:49:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHOcDUJbA0ZRvxhOKryp3wdXj1yOrTovQBJi3PEoAMY_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2021 1:27 AM, Elijah Newren wrote:
> On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>> +test_expect_success 'reset mixed and checkout orphan' '
>> +       init_repos &&
>> +
>> +       test_all_match git checkout rename-out-to-in &&
>> +
>> +       # Sparse checkouts do not agree with full checkouts about
>> +       # how to report a directory/file conflict during a reset.
>> +       # This command would fail with test_all_match because the
>> +       # full checkout reports "T folder1/0/1" while a sparse
>> +       # checkout reports "D folder1/0/1". This matches because
>> +       # the sparse checkouts skip "adding" the other side of
>> +       # the conflict.
>> +       test_sparse_match git reset --mixed HEAD~1 &&
> 
> Ooh!  I think you found a sparse-checkout bug here.  I agree that
> sparse-checkouts and full-checkouts should give different output in
> this case, but I don't think the current difference is the correct
> one.  Digging in a little closer, before running `git reset --mixed
> HEAD~1` I see:
> 
> $ git ls-files -t | grep folder
> S folder1/0/0/0
> S folder1/0/1
> S folder2/0/0/0
> S folder2/0/1/1
> S folder2/a
> S folder2/larger-content
> 
> and after running git reset --mixed HEAD~1, I see:
> S folder1/0/0/0
> S folder1/0/1
> H folder1/a
> H folder1/larger-content
> S folder2/0/0/0
> H folder2/0/1
> S folder2/a
> S folder2/larger-content
> 
> meaning that the reset of the index failed.  It thinks some entries
> are present in the working copy, though it didn't actually check any
> of them out, leaving them to be marked as deleted.  This leaves the
> sparse-checkout in a messed up state.  To correct it, I need to run
> either of the following:
> 
>     git diff --diff-filter=D --name-only | xargs git update-index
> --skip-worktree
> 
> or
> 
>     git sparse-checkout reapply
> 
> (Though one could ask whether sparse-checkout reapply should take a
> missing file that isn't SKIP_WORKTREE and determine it's okay to just
> mark it as SKIP_WORKTREE rather than treating it as dirty.  I'm not
> sure the answer to that...)
> 
> I really think that `git reset --mixed ...` should have been getting
> the sparsity right on its own without the manual fixup afterwards that
> I needed to add.
> 
>> +       test_sparse_match test-tool read-cache --table --expand &&
> 
> If both the full and the sparse checkouts do a reset --mixed, I would
> think that this step should be able to use a test_all_match...at least
> if reset --mixed weren't broken.

I will add this to my list when getting to 'git reset' integration
with sparse-checkout. Thanks.

>> +       test_sparse_match git status --porcelain=v2 &&
>> +       test_sparse_match git status --porcelain=v2 &&
> 
> Why is this test run twice?
> 
>> +
>> +       # At this point, sparse-checkouts behave differently
>> +       # from the full-checkout.
>> +       test_sparse_match git checkout --orphan new-branch &&
>> +       test_sparse_match test-tool read-cache --table --expand &&
>> +       test_sparse_match git status --porcelain=v2 &&
>> +       test_sparse_match git status --porcelain=v2
> 
> And again, you run the status twice...why?
> 
>> +'
>> +
>> +test_expect_success 'add everything with deep new file' '
>> +       init_repos &&
>> +
>> +       run_on_sparse git sparse-checkout set deep/deeper1/deepest &&
>> +
>> +       run_on_all touch deep/deeper1/x &&
>> +       test_all_match git add . &&
>> +       test_all_match git status --porcelain=v2 &&
>> +       test_all_match git status --porcelain=v2
> 
> same question.

These double 'git status' calls are actually a bit subtle: there
was a bug in an earlier version that only appeared when using
'git status' twice, because the first kept the sparse index
without expanding it, and the bug actually had an incorrect
result when writing that index. Only the second 'git status'
would notice the problem. I started adding two calls to my tests,
but it is not necessary any more.

The reason to leave it out of the Git tests is that I'm testing
all of my submissions against the Scalar functional tests which
run 'git status' multiple times throughout each test situation
and that catches the problem as well. In the future, we will have
'git add' keeping the sparse index in-memory; that will also
expose this behavior sufficiently.

Thanks,
-Stolee
