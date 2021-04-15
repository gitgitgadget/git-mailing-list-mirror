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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A0C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647A760FDA
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhDOPZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhDOPZD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 11:25:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E7C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:24:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m3so28556317edv.5
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w4CMxt3W+Cm9CzeM7kYJ32vfuhhoWuqmmpsaJ751nCU=;
        b=h9KfAdUC6CV6o31D6IxQA9URdQFMna2g/bLFOokkOt530rxlCcUrvhEe4P888Hqu2k
         3b8k6jxu8EzigbrJs+uti4GpgFDsRmhj0/NXb63kPjNHxu51hlRms87MeAW/Aj5znA72
         y0TXgSMx48/OQLx8I+vBl7f1qafyxGRc3g+ky3LAvMYGU1vh/iPRDdDLaugpLGish0it
         D0ATIIUOzkE27tOuYeC5qKwqoW+MwMgMlc88GtbpU3lwhhiUGcWUCCi9MJIiAZVP2YNC
         Nz0mvIhogsi9aFtR9b0QcIBSoio0KqmW6Y0JpVMEu7/d1DvAbEK2SEvLRBvYsj5Rr8tL
         BYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w4CMxt3W+Cm9CzeM7kYJ32vfuhhoWuqmmpsaJ751nCU=;
        b=YPbgBJ2OMwPm1FdUgDSNIoo9yHi6Fjkz71eA6djHg7egD/g5lIlo4wGIfp8blTaZxE
         8nvLt3UWn4VSXLKMmjvCl1atnSB9weDOT5qYLHxQmOrhHBmpqQKfCvG0BeFbKMOTIlNm
         oLqyBRNhwdWl+LFb3d3rdKX2dfXwIGqhUP9ao1RiG8H7fZKx8PFPVEM0SY3oWejPVl+y
         Ev3xaNL8/tBMBbDgWgmDL6m3i1OwC0K8azJDP3iBv1TRevbq5izZBePAKceQC/EJytrG
         UeOBCMcpHWWngCzb7sIDiVeGnNyoFpZPI957eoH/dYsCmO51TYxtfdTH8Bvf5Vm1a9aE
         /QYA==
X-Gm-Message-State: AOAM532haTbhiXwWUL6cO/hVsMkJLLd9z/KiKQBaRuCFuSX8kyjABMsQ
        Tcq4WMtYcIHCj/5D/xl2AsA=
X-Google-Smtp-Source: ABdhPJyV6tgpTOrGAr5EU89rha5p7EDNdcIPqF5USNfdDbuIAGN7wZqxz2tgANxV3arubUXkT/LPOQ==
X-Received: by 2002:a05:6402:1764:: with SMTP id da4mr4851190edb.154.1618500277250;
        Thu, 15 Apr 2021 08:24:37 -0700 (PDT)
Received: from [192.168.1.240] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.gmail.com with ESMTPSA id m14sm2692111edd.63.2021.04.15.08.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:24:36 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] rebase: don't override --no-reschedule-failed-exec
 with config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1616411973.git.avarab@gmail.com>
 <cover-0.3-0000000000-20210409T075713Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <63774b95-7de2-b160-385b-6c7d99e867ed@gmail.com>
Date:   Thu, 15 Apr 2021 16:24:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <cover-0.3-0000000000-20210409T075713Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 09/04/2021 09:01, Ævar Arnfjörð Bjarmason wrote:
> This fixes a bug where we read config & options when "git rebase -i -x
> make" starts, and will understand the "--no-reschedule-failed-exec"
> option, but once a command fails we'll lose track of having had a
> "--no-reschedule-failed-exec" and will happily re-read the
> "rebase.rescheduleFailedExec=true" config the user might have.
> 
> Thus we'll have config winning over explicit command-line
> options. This series fixes that bug.
> 
> Changes since v1:
> 
>   * I forgot how test_config works, and was doing a test_when_finished
>     "test_unconfig", which isn't needed, duh! Thanks to Phillip Wood
>     for that & other reviews on this series.
> 
>   * There was a discussion about how to add yet another rebase
>     machinery state file. I think the consensus is "let's just do it
>     like this", i.e. we could write some tri-state content to the file,
>     but we'd get into back-compat issues with other git versions.

These patches look fine to me now

Thanks

Phillip

> There was a discussiob about how to manage this whole state (a DB,
> JSON?) in another thread, let's kick the can of how exactly we store
> state down the line, and just fix the bug using the existing state
> saving convention for now.
> 
> Ævar Arnfjörð Bjarmason (2):
>    rebase tests: camel-case rebase.rescheduleFailedExec consistently
>    rebase: don't override --no-reschedule-failed-exec with config
> 
>   Documentation/git-rebase.txt |  8 ++++++++
>   sequencer.c                  |  5 +++++
>   t/t3418-rebase-continue.sh   | 27 +++++++++++++++++++++++++--
>   3 files changed, 38 insertions(+), 2 deletions(-)
> 
> Range-diff against v1:
> 1:  002dc72ee7 = 1:  e0dd2cb82a rebase tests: camel-case rebase.rescheduleFailedExec consistently
> 2:  330b33e7a8 < -:  ---------- rebase tests: use test_unconfig after test_config
> 3:  e00300d58d ! 2:  7991160de3 rebase: don't override --no-reschedule-failed-exec with config
>      @@ Commit message
>           However the --reschedule-failed-exec option doesn't take effect when
>           the rebase starts (we'd just create a
>           ".git/rebase-merge/reschedule-failed-exec" file if it was true). It
>      -    only takes effect when the exec command fails, and the user wants to
>      -    run "rebase --continue".
>      +    only takes effect when the exec command fails, at which point we'll
>      +    reschedule the failed "exec" command.
>       
>      -    At that point we'll have forgotten that we asked for
>      -    --no-reschedule-failed-exec at the start, and will happily re-read the
>      -    config.
>      +    Since we only wrote out the positive
>      +    ".git/rebase-merge/reschedule-failed-exec" under
>      +    --reschedule-failed-exec, but nothing with --no-reschedule-failed-exec
>      +    we'll forget that we asked not to reschedule failed "exec", and would
>      +    happily re-read the config and see that
>      +    rebase.rescheduleFailedExec=true is set.
>       
>      -    We'll then see that rebase.rescheduleFailedExec=true is set. At that
>      -    point we have no record of having set --no-reschedule-failed-exec
>      -    earlier. So the config will effectively override the user having
>      -    explicitly disabled the option on the command-line.
>      +    So the config will effectively override the user having explicitly
>      +    disabled the option on the command-line.
>       
>           Even more confusingly: Since rebase accepts different options based on
>           its state there wasn't even a way to get around this with "rebase
>      @@ t/t3418-rebase-continue.sh: test_expect_success 'rebase.rescheduleFailedExec onl
>        
>       +test_expect_success 'rebase.rescheduleFailedExec=true & --no-reschedule-failed-exec' '
>       +	test_when_finished "git rebase --abort" &&
>      -+	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
>       +	test_config rebase.rescheduleFailedExec true &&
>       +	test_must_fail git rebase -x false --no-reschedule-failed-exec HEAD~2 &&
>       +	test_must_fail git rebase --continue 2>err &&
>      @@ t/t3418-rebase-continue.sh: test_expect_success 'rebase.rescheduleFailedExec onl
>       +test_expect_success 'new rebase.rescheduleFailedExec=true setting in an ongoing rebase is ignored' '
>       +	test_when_finished "git rebase --abort" &&
>       +	test_must_fail git rebase -x false HEAD~2 &&
>      -+	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
>       +	test_config rebase.rescheduleFailedExec true &&
>       +	test_must_fail git rebase --continue 2>err &&
>       +	! grep "has been rescheduled" err
> 
