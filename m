Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0831BC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BCE212CC
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 14:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJCHMAUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbgJOOp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgJOOp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 10:45:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D535C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:45:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l15so2017723wmh.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I03FYbmsH9Ci48pF36URDnJKTUl7AVk0nU7qzKPgMV0=;
        b=tJCHMAUhwR2MqT1TxdFnwc8CO+XW7sXvtTPWLcVKJZk4vwDDMVN0S+G49y4S4hz/jv
         BfS+bB7xqvblMYyraNBmmVk/P3IFmu03TEIDXzBdT8gWT2uhmh/rKPkf1stFWqpmJEct
         7P4IPlQycmpIxkCAFqY6Ofjfp3TcifvYnKRpDpB9uFV1y6qOdRoJKYaLO3eMafIbLrxw
         s7RgILjU2/PxBqqmF1rKr1FlGi+iYDtb/qlqHYPiUx69ObbHFaGTYKtcarHVzssCDUpZ
         XNnJ3ibKT93JcbhTDzOi4QFJDQzkEzplHkLEdVVJtqQWkX9Q6J/gxBHGsDJivCxhrLup
         cybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I03FYbmsH9Ci48pF36URDnJKTUl7AVk0nU7qzKPgMV0=;
        b=fFlw9y5DefKmRxMtPODBucz9w/q/Pp3J9fvt90hr6dcrVYtXjvFQEK9SyXu3JFsVCv
         zC0QqGei7+ZIJxuD5vPvCfSiSQIOvBekghri88Ig32oOEBL6Ye8BrbGV/6h1SQrHXqVP
         FsyL7NpTnn+naLnYg/TyV3Sw6qqb7ZBDCSPngEoJDpwOnIx129V/GOncJ+nXXzYsMDXF
         MXKYtTKvT7munGXmKhVszLw5TO0EAmbF+JdyLh2ivwBK0xtX4pL4N3q8wBhpR7YsbdZ3
         OQSImzkewTp5AwM++EUzaEAkv31GTi7wc3xsIZBZGSLh6t5NOb+clo4EYoIz0CN1gDF+
         9+gw==
X-Gm-Message-State: AOAM532bIw+KOLTuoiZ8kDScWnlyHZccbDaSW/Tu5oYpL7Ll8SCsraiO
        YjCV/XWmfGhLR3duGGbjEvcbVZ3BW6c=
X-Google-Smtp-Source: ABdhPJzZCt2MTMsXGBFtEuv5bkG3/dMvfWOwVrle6PJR1K7N+kzlF46A1qg9hksy2SFcBrSVPl4oBA==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr4662939wmf.13.1602773156612;
        Thu, 15 Oct 2020 07:45:56 -0700 (PDT)
Received: from [192.168.1.240] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.gmail.com with ESMTPSA id d3sm3352716wrb.66.2020.10.15.07.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 07:45:55 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] Introduction
To:     Sangeeta NB <sangunb09@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, kaartic.sivaraam@gmail.com,
        git@vger.kernel.org
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
 <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
 <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com>
 <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
 <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com>
 <CAHjREB7xhBWHUCJ+T78i6dDGQr055sMAaYzG4gaQSr0T88cseg@mail.gmail.com>
 <95c90e7a-8f4c-32b9-2b0e-9efce2acfb8e@gmail.com>
 <CAHjREB6i7ZSSXk10OAOXcL-Av3WzesCkMKL2ES_aBRsrynT9DA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8c9b409b-4e44-ca8a-9075-36a7332f9765@gmail.com>
Date:   Thu, 15 Oct 2020 15:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHjREB6i7ZSSXk10OAOXcL-Av3WzesCkMKL2ES_aBRsrynT9DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 15/10/2020 14:57, Sangeeta NB wrote:
> On Thu, Oct 15, 2020 at 7:09 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hey Phillip,
> 
>> As we store the config options in default_diff_options and then copy
>> them across at the beginning of repo_setup_diff() we can use a flag in
>> struct diff_options which is set by handle_ignore_submodule_arg() to
>> tell if we need to initialize opts->flags.ignore_untracked_in_submodules
>> in repo_setup_diff()
> 
> Even if we don't set a global flag it is working fine because we are
> setting the default first, and would let the config override it. I
> have updated the code in the PR and you can have a look at it. I have
> also added --ignore-submodules=none in some tests to get the results
> mentioned earlier.

Thanks, I'll have a look later

>> Are you adding the printf and then running t3600? If so then the extra
>> line of output breaks a lot of tests which in turn breaks to setup for
>> the test that was failing so there are uncommitted changes.
>> Unfortunately it is hard to run a subset of tests in a lot the test
>> scripts as there are implicit dependencies between the individual tests
>> them.
>>
> Oh, okay it makes sense.
> 
>>
>> I'm afraid I'm still no closer to figuring out why that test in t3600 fails

diff --git a/submodule.c b/submodule.c
index 8f6227c993..c4182be633 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1679,6 +1679,8 @@ unsigned is_submodule_modified(const char *path, 
int ignore_untracked)
         strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
         if (ignore_untracked)
                 strvec_push(&cp.args, "-uno");
+       else
+               strvec_push (&cp.args, "--ignore-submodules=none");

         prepare_submodule_repo_env(&cp.env_array);
         cp.git_cmd = 1;

fixes it, I'm unsure at the moment if we should be adding the extra flag 
here or setting the appropriate option in status when -uno and 
--ignore-submodules=<option> are both omitted though

> What it is like debugging in Git? I have seen people writing debug
> statements(print statements in between the code) to figure out how
> things are working. But I guess we might not be able to do that. Do we
> have to create the exact environment that is been created by that test
> to check for the code?

Have you setup a config.mak file? Mine looks like

DEVELOPER = 1
SANITIZE = address,leak
CFLAGS += -ggdb3
CFLAGS += -fvar-tracking-assignments
CFLAGS += -fno-omit-frame-pointer

Which will build git with warnings enabled, debugging information and 
enables the address sanitizer. Then you can run the git you have built 
under gdb with

	GIT_DEBUGGER=1 bin-wrappers/git

If you want to debug a particular test then I find adding `test_pause` 
to the test and then running

	GIT_DEBUGGER=1 git

in the shell that the test opens (it sets up the path appropriately). 
You may want to add LSAN_OPTIONS=detect_leaks=0 to the commands above or 
set up a suppressions file

I also use printf quite a bit but it does tend to break other tests 
which can be awkward.

Best Wishes

Phillip
