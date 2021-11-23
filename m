Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAE9C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 14:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhKWPBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhKWPBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 10:01:10 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB37C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 06:58:01 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i9so16478732ilu.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tbd0ISlYYdYBfypdDHnHElbsN8KCDPuvKnRJ2jjQQGo=;
        b=DvciHIFJmnbblJJaXyEibq+FvSEjGSSUVxpiqxPifYzhaHJgSV/rQqG3qujoEwyny7
         +CVkEGjYI/8bynSiSxJXN6XpPTbVfGiHFjj/d6m7tJWIQGKtfZqD6VfQR0WG21o7yzH6
         tL/gdyK3RhGIM9LNQ1ARoZdGDsC1AYJOw51BIGTEMi67jhVWt0NMvgeLHVtoTUnNW+km
         yTDE4Slww/ec+67O0Ggw3/UlZr3ye9zRC6Gjm8QrrVKn3e0UH+G2eHs2+2OpwOSDzBtN
         ly+ubFL8cDI3Vmkm4fscjVCyL1DxyLRjm2p65uUR9mzFLs65a2sdCUOgd/whU7114JKi
         Mncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tbd0ISlYYdYBfypdDHnHElbsN8KCDPuvKnRJ2jjQQGo=;
        b=SkSuKWki3FnQs5I/FKVyw65o9zW18v6fhTi+WlUk/RgdoAtKeVwNZcF6wmH0B4MMNd
         ri5u3VD9BkvKliNpc6wAE77lQM141q0e+YeGKzj9X/Nfp4rokyHIK0nOlruhcm8cFazu
         wvez9L0mHLmKPHIC2srmStRY6c1/yciO60aQE3YWqxU/IytEmBLmcI/Do7zEWLt+hrF4
         Ew6u8GyBWqZtdKatlUoQk3wA7zd7Tw8+nsmgQuHwbckQwrDKzjZyv2Bd87ppxeqcjgQP
         UTDEHCAAcnVRc46dRon1tdXLkIeXCQ/bSqaPu1s9OuhA0hd2K/WoKr0NJ5TThk83Wvnv
         FzHw==
X-Gm-Message-State: AOAM530XI7b34Eduv7LlyJeaKVRABWkSSeyaPzMJipa5bK8dzdlDGhJG
        SO+nbjDnGs5EJ4Hwv10jNTQ=
X-Google-Smtp-Source: ABdhPJxrY7ctCp0gi+sMAHMjgn9EH4RsFcOeIuShaCl6Bjo9PwFwPTRqYkOGjVgdFOEOB5fqVehvSw==
X-Received: by 2002:a92:d24e:: with SMTP id v14mr5871799ilg.55.1637679481215;
        Tue, 23 Nov 2021 06:58:01 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id g15sm5590565ile.88.2021.11.23.06.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 06:58:00 -0800 (PST)
Message-ID: <2ac61ff8-816d-99b4-333b-381d9a1dbdeb@gmail.com>
Date:   Tue, 23 Nov 2021 06:57:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] blame: enable and test the sparse index
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
 <ddcee003c9292d1b4cdd64a97f9e1731a72faee8.1634232353.git.gitgitgadget@gmail.com>
 <CABPp-BGM-57Xxxb-MRvkkgGFbVn4z6PEZFKryuBCwj7Ymr_oSA@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BGM-57Xxxb-MRvkkgGFbVn4z6PEZFKryuBCwj7Ymr_oSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/22/21 11:57 PM, Elijah Newren wrote:
> On Thu, Oct 14, 2021 at 10:25 AM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Enable the sparse index for the 'git blame' command. The index was already
>> not expanded with this command, so the most interesting thing to do is to
>> add tests that verify that 'git blame' behaves correctly when the sparse
>> index is enabled and that its performance improves. More specifically, these
>> cases are:
>>
>> 1. The index is not expanded for 'blame' when given paths in the sparse
>> checkout cone at multiple levels.
>>
>> 2. Performance measurably improves for 'blame' with sparse index when given
>> paths in the sparse checkout cone at multiple levels.
>>
>> The `p2000` tests demonstrate a ~60% execution time reduction when running
>> 'blame' for a file two levels deep and and a ~30% execution time reduction
>> for a file three levels deep.
>>
>> Test                                         before  after
>> ----------------------------------------------------------------
>> 2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
>> 2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
>> 2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
>> 2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
>> 2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
>> 2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
>> 2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
>> 2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%
> 
> Looks good.
> 
>> We do not include paths outside the sparse checkout cone because blame
>> currently does not support blaming files outside of the sparse definition.
>> Attempting to do so fails with the following error:
>>
>> fatal: no such path '<path outside sparse definition>' in HEAD
> 
> While technically accurate, this wording is misleading; it implies
> that there is something unique to sparse checkouts, and perhaps even
> to cone mode, affecting how blame handles files not in the working
> directory.  That's not true, though; git blame without a revision has
> always reported an error when given a file that does not exist in the
> working tree.  Try this in git.git:
> 
> $ rm t/README
> $ git blame t/README
> fatal: Cannot lstat 't/README': No such file or directory
> 
> The reason is that with no revisions, calling git blame with a
> filename means asking the question "Which commit did each line in that
> file come from?"  If there's no file, the question just doesn't make
> sense.  You could make sense of it by thinking in terms of some
> revision of the file, but then you're passing a revision along --
> which works just fine in a sparse checkout too.
> 
Thank you for clarifying that this is actually the expected behavior and 
isn't something we need to "fix" for sparse-checkout. I will update 
accordingly for v5.
>>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   builtin/blame.c                          |  3 +++
>>   t/perf/p2000-sparse-operations.sh        |  2 ++
>>   t/t1092-sparse-checkout-compatibility.sh | 24 +++++++++++++++++-------
>>   3 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 641523ff9af..af3d81e2bd4 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -902,6 +902,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>>          long anchor;
>>          const int hexsz = the_hash_algo->hexsz;
>>
>> +       prepare_repo_settings(the_repository);
>> +       the_repository->settings.command_requires_full_index = 0;
>> +
>>          setup_default_color_by_age();
>>          git_config(git_blame_config, &output_option);
>>          repo_init_revisions(the_repository, &revs, NULL);
>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>> index bff93f16e93..9ac76a049b8 100755
>> --- a/t/perf/p2000-sparse-operations.sh
>> +++ b/t/perf/p2000-sparse-operations.sh
>> @@ -115,5 +115,7 @@ test_perf_on_all git reset --hard
>>   test_perf_on_all git reset -- does-not-exist
>>   test_perf_on_all git diff
>>   test_perf_on_all git diff --staged
>> +test_perf_on_all git blame $SPARSE_CONE/a
>> +test_perf_on_all git blame $SPARSE_CONE/f3/a
>>
>>   test_done
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 1070bff1a83..54826e858a9 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -485,15 +485,16 @@ test_expect_success 'blame with pathspec inside sparse definition' '
>>          test_all_match git blame deep/deeper1/deepest/a
>>   '
>>
>> -# TODO: blame currently does not support blaming files outside of the
>> -# sparse definition. It complains that the file doesn't exist locally.
>> -test_expect_failure 'blame with pathspec outside sparse definition' '
>> +# Blame does not support blaming files outside of the sparse
>> +# definition, so we verify this scenario.
> 
> As above, this is misleading.  It'd be better to word it something like:
> 
> # Without a revision specified, blame will error if passed any file that
> # is not present in the working directory (even if the file is tracked).
> # Here we just verify that this is also true with sparse checkouts.
> 
Thank you. Will update for v5.
>> +test_expect_success 'blame with pathspec outside sparse definition' '
>>          init_repos &&
>>
>> -       test_all_match git blame folder1/a &&
>> -       test_all_match git blame folder2/a &&
>> -       test_all_match git blame deep/deeper2/a &&
>> -       test_all_match git blame deep/deeper2/deepest/a
>> +       test_sparse_match git sparse-checkout set &&
>> +       test_sparse_match test_must_fail git blame folder1/a &&
>> +       test_sparse_match test_must_fail git blame folder2/a &&
>> +       test_sparse_match test_must_fail git blame deep/deeper2/a &&
>> +       test_sparse_match test_must_fail git blame deep/deeper2/deepest/a
>>   '
>>
>>   test_expect_success 'checkout and reset (mixed)' '
>> @@ -871,6 +872,15 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
>>          )
>>   '
>>
>> +test_expect_success 'sparse index is not expanded: blame' '
>> +       init_repos &&
>> +
>> +       ensure_not_expanded blame a &&
>> +       ensure_not_expanded blame deep/a &&
>> +       ensure_not_expanded blame deep/deeper1/a &&
>> +       ensure_not_expanded blame deep/deeper1/deepest/a
>> +'
>> +
>>   # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>>   # in this scenario, but it shouldn't.
>>   test_expect_success 'reset mixed and checkout orphan' '
>> --
>> gitgitgadget
