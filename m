Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B9FC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8CF22B48
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5BPaauD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgBRPFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:05:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34568 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgBRPFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 10:05:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so22411213wrm.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 07:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w5YUVZQP3EM0FdO3RUTcsPBiqbZBpz+mnRvUJ37YFBc=;
        b=X5BPaauDo6hcJK8rBXNcPn6Pg+A3pojDuuf3en6vjgWESSosL8HKgrjHDV2I/UD/1l
         OrYhjtEin0iZfSGvPGgfl6CYImU7zSta1VadTxOlJG3F361VqeC4FdU9JTo4u54xo+zK
         MGRTVlfCzM/70G6YNnqWRVX+IMG8mtzZZo5upbFO+auaMCYpdkMJr3lKwSmIR3klhtqv
         O9HMoSeIGEI2adOH30TQJb4ruZHuC6wx4WDEjSBtAISgWmOdGFURcNLqE5S3Abt2gK0I
         aSr+3sjAqK83Mhzm+mWBGU0AOkx0oJJ6eEHAFEbss7tcq7gXcjKl3csz+wNPqaGRZw+J
         nZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w5YUVZQP3EM0FdO3RUTcsPBiqbZBpz+mnRvUJ37YFBc=;
        b=oESPxczziKeaRi6gKIOvebVleF8sYU7Ut+NcZyr6JvwJjQPmPSPWQLwMSSpBWHVCVM
         QU91+rcLjedKx2EE5qhctayWQxLRHTX13R5q6waK+0m5WxvGcDeUy6iUBX8z820pJ2s8
         2xf/u8hb7ywlZwZOStsTsToMgTp+qQIs2OsTrq5okgWnsNopSjBeyTMNLvT3trWIeHqR
         pY6/TlAuse8bcckIiOFVmiYJjKF1B3GnzMHrKnMsC9z6N89+JUCS6QpsOarq2VTiTak7
         BxDaohInR9EKg5Wmm7ZcgpETm1fwiLMwuvAtvNjH9lKhDCTEK+0oiDWHtIK0w3k+ISpn
         jhHw==
X-Gm-Message-State: APjAAAVkAtn9PNNkM/zTd7zKlMX3IJ8hyL8nMlQUkaHclBm5SA+w2KAa
        +hO/If8GW7alvGSx5DJNTZxeaPmP
X-Google-Smtp-Source: APXvYqy9RKa+D75zS7Ijp6laSPSJKLFEEIdFRke2vv2thGMOd37dlLWI4Qhlhc2lfxbkgy71Yu5h5A==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr27898308wro.195.1582038341001;
        Tue, 18 Feb 2020 07:05:41 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id x6sm3833575wmi.44.2020.02.18.07.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 07:05:40 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like
 failure
To:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
 <CABPp-BEtnmzDp0E4=0y9eEMKQ89FcrsK9h-1Mqcd2FDV_EBohw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ed8dc52c-db50-f6fa-9583-8ad4af23d327@gmail.com>
Date:   Tue, 18 Feb 2020 15:05:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BEtnmzDp0E4=0y9eEMKQ89FcrsK9h-1Mqcd2FDV_EBohw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 17/02/2020 19:12, Elijah Newren wrote:
> I forgot to add some cc's in GitGitGadget before submitting; adding now...
> 
> On Mon, Feb 17, 2020 at 9:15 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Elijah Newren <newren@gmail.com>
>>
>> A user discovered a case where they had a stack of 20 simple commits to
>> rebase, and the rebase would succeed in picking the first commit and
>> then error out with a pair of "Could not execute the todo command" and
>> "Your local changes to the following files would be overwritten by
>> merge" messages.
>>
>> Their steps actually made use of the -i flag, but I switched it over to
>> -m to make it simpler to trigger the bug.  With that flag, it bisects
>> back to commit 68aa495b590d (rebase: implement --merge via the
>> interactive machinery, 2018-12-11), but that's misleading.  If you
>> change the -m flag to --keep-empty, then the problem persists and will
>> bisect back to 356ee4659bb5 (sequencer: try to commit without forking
>> 'git commit', 2017-11-24)
>>
>> After playing with the testcase for a bit, I discovered that added
>> --exec "sleep 1" to the command line makes the rebase succeed, making me
>> suspect there is some kind of discard and reloading of caches that lead
>> us to believe that something is stat dirty, but I didn't succeed in
>> digging any further than that.

Intriguing - it's strange that it errors out picking commit2, not 
commit1 I'll try and have a look at it. There seem to be some leftover 
bits at the start of the test that want removing see below

>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>      t3424: new rebase testcase documenting a stat-dirty-like failure
>>
>>      A user discovered a case where they had a stack of 20 simple commits to
>>      rebase, and the rebase would succeed in picking the first commit and
>>      then error out with a pair of "Could not execute the todo command" and
>>      "Your local changes to the following files would be overwritten by
>>      merge" messages.
>>
>>      Their steps actually made use of the -i flag, but I switched it over to
>>      -m to make it simpler to trigger the bug. With that flag, it bisects
>>      back to commit 68aa495b590d (rebase: implement --merge via the
>>      interactive machinery, 2018-12-11), but that's misleading. If you change
>>      the -m flag to --keep-empty, then the problem persists and will bisect
>>      back to 356ee4659bb5 (sequencer: try to commit without forking 'git
>>      commit', 2017-11-24)
>>
>>      After playing with the testcase for a bit, I discovered that added
>>      --exec "sleep 1" to the command line makes the rebase succeed, making me
>>      suspect there is some kind of discard and reloading of caches that lead
>>      us to believe that something is stat dirty, but I didn't succeed in
>>      digging any further than that.
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-712%2Fnewren%2Fdocument-rebase-failure-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-712/newren/document-rebase-failure-v1
>> Pull-Request: https://github.com/git/git/pull/712
>>
>>   t/t3424-rebase-across-mode-change.sh | 52 ++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100755 t/t3424-rebase-across-mode-change.sh
>>
>> diff --git a/t/t3424-rebase-across-mode-change.sh b/t/t3424-rebase-across-mode-change.sh
>> new file mode 100755
>> index 00000000000..4d2eb1dd7c6
>> --- /dev/null
>> +++ b/t/t3424-rebase-across-mode-change.sh
>> @@ -0,0 +1,52 @@
>> +#!/bin/sh
>> +
>> +test_description='git rebase across mode change'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +       rm -rf ../stupid &&
>> +       git init ../stupid &&
>> +       cd ../stupid &&

I think these 3 lines must be left over from you trying this out before 
making it a test

Best Wishes

Phillip

>> +       mkdir DS &&
>> +       >DS/whatever &&
>> +       git add DS &&
>> +       git commit -m base &&
>> +
>> +       git branch side1 &&
>> +       git branch side2 &&
>> +
>> +       git checkout side1 &&
>> +       git rm -rf DS &&
>> +       ln -s unrelated DS &&
>> +       git add DS &&
>> +       git commit -m side1 &&
>> +
>> +       git checkout side2 &&
>> +       >unrelated &&
>> +       git add unrelated &&
>> +       git commit -m commit1 &&
>> +
>> +       echo >>unrelated &&
>> +       git commit -am commit2
>> +'
>> +
>> +test_expect_success 'rebase changes with the apply backend' '
>> +       test_when_finished "git rebase --abort || true" &&
>> +       git checkout -b apply-backend side2 &&
>> +       git rebase side1
>> +'
>> +
>> +test_expect_failure 'rebase changes with the merge backend' '
>> +       test_when_finished "git rebase --abort || true" &&
>> +       git checkout -b merge-backend side2 &&
>> +       git rebase -m side1
>> +'
>> +
>> +test_expect_success 'rebase changes with the merge backend with a delay' '
>> +       test_when_finished "git rebase --abort || true" &&
>> +       git checkout -b merge-delay-backend side2 &&
>> +       git rebase -m --exec "sleep 1" side1
>> +'
>> +
>> +test_done
>>
>> base-commit: e68e29171cc2d6968902e0654b5687fbe1ccb903
>> --
>> gitgitgadget
