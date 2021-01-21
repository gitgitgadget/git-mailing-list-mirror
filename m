Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D658C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 12:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C992123975
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 12:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbhAUMAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 07:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731017AbhAUMAB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 07:00:01 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC579C061575
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 03:59:20 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id n42so1311428ota.12
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 03:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AExALlAVf2LfpH6+c1I+fVx38O6bUPucZgMkXV5iqPE=;
        b=Qe4Tu9i6smCnnJA8z0lz2fkSSH/2iYVueoZySCWtVHtFWCmCp5/5quRoH8Ppow6XqX
         82QmhnbgJWHyLEdDqwF4vXwtNjv9JgFbcfSFUIl7uIOtokRQ7FsEGFimxQ8Zxf7hVD6x
         3S92ljQx+YgbXAu9K8EKULbH8EtFhxiOiVAF7SCvw+U8goNM0P2R8/Hl+zym/6Ix/Wqg
         yrzHiAebtKpBtzRALRZhYTCH/bKw5toZrHyTUa+0aHOPmtAaYTZUVvpPcaLhg99u+DG4
         tMooaf8cA3YGEptYcK7YBAdCRzOpQlwXiy91iPXvy1jlkHoTJU7QrMt6PGGuaZSk8dvU
         9q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AExALlAVf2LfpH6+c1I+fVx38O6bUPucZgMkXV5iqPE=;
        b=Y00teVV0Tz7gB4Fdwz1nFmw5qOvfo995QdjxdkgtjcMrMSUuebZhmH7xMOcdluaDzr
         u6sofRQnU5XZvn8QHtQvE0RlIUaUgG94bgdskVNOML4/j3y/R7nCtKUz1iI0Is0RxWg+
         /Pjcp+NIUqpqh+xqONydfK7uyWc3pwrx57zdAdZh753W8Ng9VQKGzwhHH+lPmbPClBXG
         qksqdYCCij9K4Bs2EmmvdqVbYo6x/WRH78JBtON5WPh0WNFnmDD4CgFvbFf2B7Lvg1BM
         +uvIovz2jB6CCDA51bgQrwU9wtb8NZFKX+sX2uZ6Ben9ubnGHIwZOb+ZCdv/dJewJLq8
         kVvw==
X-Gm-Message-State: AOAM533F3Ae7RPPUd4n8/2Kvu3bY01twHNPz9CiTLZ0+bvr3TaIe54aF
        eGQMzjUvHXW/q3rvcQbO4ls=
X-Google-Smtp-Source: ABdhPJz/z2XQ5rQjxBh6BETY2wBNJVQoi0t8sdDp3OVx7p5UFx08F8HJZYVLfD7Ruzgn1j4eKw89SA==
X-Received: by 2002:a9d:347:: with SMTP id 65mr10109421otv.4.1611230359982;
        Thu, 21 Jan 2021 03:59:19 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:34b6:33df:b7f8:7bad? ([2600:1700:e72:80a0:34b6:33df:b7f8:7bad])
        by smtp.gmail.com with UTF8SMTPSA id 126sm925262oop.30.2021.01.21.03.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:59:19 -0800 (PST)
Subject: Re: [PATCH 9/9] t1092: test interesting sparse-checkout scenarios
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <555e210dc03e3966d39b84d5fd5d409038422c40.1611161639.git.gitgitgadget@gmail.com>
 <CABPp-BH=E4bR2K21e-p+ABTG02feDF7YNvrOKhsMW5Dtet6y7Q@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd81bbda-152d-6230-bfc5-f4aa60d0fe9e@gmail.com>
Date:   Thu, 21 Jan 2021 06:59:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BH=E4bR2K21e-p+ABTG02feDF7YNvrOKhsMW5Dtet6y7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/20/2021 2:40 PM, Elijah Newren wrote:
> On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> These also document some behaviors that differ from a full checkout, and
>> possibly in a way that is not intended.
> 
> I'm in favor.  I should turn some of my noted weird behaviors from [1]
> into testcases as well.
> 
> [1] https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/

That would be helpful, and adding them here would be helpful.

For the cases where things don't work correctly, it is good
to add "test_expect_failure" cases as a TODO list for the
feature space.

>> +
>> +test_expect_success 'add, commit, checkout' '
>> +       init_repos &&
>> +
>> +       write_script edit-contents <<-\EOF &&
>> +       echo text >>$1
>> +       EOF
>> +       run_on_all "../edit-contents README.md" &&
>> +
>> +       test_all_match git add README.md &&
>> +       test_all_match git status --porcelain=v2 &&
>> +       test_all_match git commit -m "Add README.md" &&
>> +
>> +       test_all_match git checkout HEAD~1 &&
>> +       test_all_match git checkout - &&
>> +
>> +       run_on_all "../edit-contents README.md" &&
>> +
>> +       test_all_match git add -A &&
>> +       test_all_match git status --porcelain=v2 &&
>> +       test_all_match git commit -m "Extend README.md" &&
>> +
>> +       test_all_match git checkout HEAD~1 &&
>> +       test_all_match git checkout - &&
> 
> Up to here, this test is identical to the previous one.  Why repeat it?

Unintentional. I cleaned this up in a later commit of my
prototype, but forgot to delete that back in this patch.
Will fix.

>> +
>> +       run_on_all "../edit-contents deep/newfile" &&
>> +
>> +       test_all_match git status --porcelain=v2 -uno &&
>> +       test_all_match git status --porcelain=v2 &&
>> +       test_all_match git add . &&
>> +       test_all_match git status --porcelain=v2 &&
>> +       test_all_match git commit -m "add deep/newfile" &&
>> +
>> +       test_all_match git checkout HEAD~1 &&
>> +       test_all_match git checkout -
>> +'
> 
> Think out loud...so you are only adding files that were not previously
> tracked and that would have been part of the sparse cone.  You aren't
> trying to add files that would be outside the sparse cone, or manually
> creating files missing from the working tree due to sparseness and
> then attempting to add them.  (Which is fine, we have to start
> somewhere with our testing.  Also, I think my testcases didn't look at
> the case you did, and only covered one of these other two cases.)

Yes, these tests are currently focusing on the "happy" cases
of what is happening within the sparse cone. I plan to expand
to the more complicated cases later, as I start implementing
them correctly with the sparse-index. However, it would be fine
to have the tests here earlier. Extra documentation of the
expected behavior (or how the current implementation is not
desirable) would be good.

>> +
>> +test_expect_success 'checkout and reset --hard' '
>> +       init_repos &&
>> +
>> +       test_all_match git checkout update-folder1 &&
>> +       test_all_match git status --porcelain=v2 &&
>> +
>> +       test_all_match git checkout update-deep &&
>> +       test_all_match git status --porcelain=v2 &&
>> +
>> +       test_all_match git checkout -b reset-test &&
>> +       test_all_match git reset --hard deepest &&
>> +       test_all_match git reset --hard update-folder1 &&
>> +       test_all_match git reset --hard update-folder2
>> +'
>> +
>> +test_expect_success 'diff --staged' '
>> +       init_repos &&
>> +
>> +       write_script edit-contents <<-\EOF &&
>> +       echo text >>README.md
>> +       EOF
>> +       run_on_all "../edit-contents" &&
>> +
>> +       test_all_match git diff &&
>> +       test_all_match git diff --staged &&
>> +       test_all_match git add README.md &&
>> +       test_all_match git diff &&
>> +       test_all_match git diff --staged
>> +'
> 
> Also a case where you're operating on a file that matches the sparsity
> patterns (in cone mode, everything in the root directory is included).
> 
>> +test_expect_success 'diff with renames' '
>> +       init_repos &&
>> +
>> +       for branch in rename-out-to-out rename-out-to-in rename-in-to-out
>> +       do
>> +               test_all_match git checkout rename-base &&
>> +               test_all_match git checkout $branch -- .&&
>> +               test_all_match git diff --staged &&
>> +               test_all_match git diff --staged --find-renames || return 1
> 
> Aren't these last two lines the same? (diff.renames defaults to true
> ever since commit 5404c116aa, "diff: activate diff.renames by
> default", 2016-02-25)  Are they only different because you have a
> tweaked config that turns off renames by default?
> 
> Perhaps the first diff line should have a --no-renames flag.

Thanks! Will do.

>> +       done
>> +'
>> +
>> +test_expect_success 'log with pathspec outside sparse definition' '
>> +       init_repos &&
>> +
>> +       test_all_match git log -- a &&
>> +       test_all_match git log -- folder1/a &&
>> +       test_all_match git log -- folder2/a &&
>> +       test_all_match git log -- deep/a &&
>> +       test_all_match git log -- deep/deeper1/a &&
>> +       test_all_match git log -- deep/deeper1/deepest/a &&
>> +
>> +       test_all_match git checkout update-folder1 &&
>> +       test_all_match git log -- folder1/a
>> +'
>> +
>> +test_expect_success 'blame with pathspec inside sparse definition' '
>> +       init_repos &&
>> +
>> +       test_all_match git blame a &&
>> +       test_all_match git blame deep/a &&
>> +       test_all_match git blame deep/deeper1/a &&
>> +       test_all_match git blame deep/deeper1/deepest/a
>> +'
> 
> Good check.
> 
> On a side note going back to a piece of the other thread I didn't get
> a response to, I'm still curious whether
>     git blame -C -C $PATH_INSIDE_SPARSE_DEFINITION
> should (optionally?) behave differently in a sparse checkout.  In
> particular, should it limit its copy detection to other paths also in
> the sparse checkout, or should it always search all other files within
> the repository for copied lines?  Searching just within the sparse
> checkout seems like it could be a really nice performance
> optimization.

All of the "find movements or copies" logic could benefit from a
"universal" option to restrict to the sparse-checkout definition.

>> +
>> +# TODO: blame currently does not support blaming files outside of the
>> +# sparse definition. It complains that the file doesn't exist locally.
> 
> Nice catch.  Yeah, blame tries to check the local working copy for
> changes, and shows those lines with a changed in commit 0000000000.
> We should add a check that says that if the file is SKIP_WORKTREE,
> then we treat it the same as `git blame $PATH HEAD`.

Right. If it's not in the working directory, then we should
interpret that as HEAD.

>> +test_expect_failure 'blame with pathspec outside sparse definition' '
>> +       init_repos &&
>> +
>> +       test_all_match git blame folder1/a &&
>> +       test_all_match git blame folder2/a &&
>> +       test_all_match git blame deep/deeper2/a &&
>> +       test_all_match git blame deep/deeper2/deepest/a
>> +'
>> +
>> +# TODO: reset currently does not behave as expected when in a
>> +# sparse-checkout.
> 
> I'm going to go to test this out to see what it does.  It's the first
> testcase you listed that I didn't know how it worked and couldn't
> figure it out from your comments.  However it turns out, definitely a
> good test to have.
>
>> +test_expect_failure 'checkout and reset (mixed)' '
>> +       init_repos &&
>> +
>> +       test_all_match git checkout -b reset-test update-deep &&
>> +       test_all_match git reset deepest &&
>> +       test_all_match git reset update-folder1 &&
>> +       test_all_match git reset update-folder2
>> +'

Here are the failures:

after "git checkout -b reset-test update-deep"

--- full-checkout-out   2021-01-21 11:51:30.059713246 +0000
+++ sparse-checkout-out 2021-01-21 11:51:30.063713235 +0000
@@ -1,5 +1,5 @@
 Unstaged changes after reset:
 M      deep/a
 M      deep/deeper1/deepest/a
-M      folder1/a
-M      folder2/a
+D      folder1/a
+D      folder2/a

If we comment out that line, the failures for
"git reset update-folder1" is:

--- full-checkout-out   2021-01-21 11:52:36.203509990 +0000
+++ sparse-checkout-out 2021-01-21 11:52:36.207509976 +0000
@@ -1,2 +1,2 @@
 Unstaged changes after reset:
-M      folder1/a
+D      folder1/a

If we comment out that line, then the failure for
"git reset update-folder2" is:

--- full-checkout-out   2021-01-21 11:53:55.199197608 +0000
+++ sparse-checkout-out 2021-01-21 11:53:55.207197573 +0000
@@ -1,3 +1,3 @@
 Unstaged changes after reset:
-M      folder1/a
-M      folder2/a
+D      folder1/a
+D      folder2/a

Oddly, when I merge this into our branch in microsoft/git,
these failures disappear. There is something in those commits
that resolve this particular case. I hope to figure that out
sometime.

Thanks,
-Stolee
