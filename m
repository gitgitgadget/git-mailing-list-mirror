Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45006C38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiJXVTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiJXVTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 17:19:33 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AAA2764C7
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 12:25:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-36ad4cf9132so65488377b3.6
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RYZuGPRAaqRqxE8LOwPHeXSrb6yNQaDEC5+z7J5ydV8=;
        b=RL83vv/gCtFBwXA1XAWVeNZNviE3dnRmD4yiOQuohbVesU4i2ywG+oonpl64+prJ/k
         CE06VksU8vJFfNr4YqTGC3sh4E1GsUPUkLncaLS/VAQJPBAQKKAEvMZFSS4M1v5Euuxw
         8nKdx36Ekn2VvgiTLpCeHNi1DXfvRBALTwyFIGjSq7anpGpjT3D/mxGkXAEP6IJbqZlh
         npDpJwTgL0KN9AotMOR5iHCKh0yUpqq2A1wKj39sn1LkecIh+xvqdHUrNi6iaXNTrLv2
         akd+Ha/D17raWNsEC/Xc+80iDlfuMIruynhTTlQUzmgzYQVIRIGiemSK1g+HWDkr6kIh
         pMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYZuGPRAaqRqxE8LOwPHeXSrb6yNQaDEC5+z7J5ydV8=;
        b=QG0BA60ji7d+geeuSpqMT0S0Xq9uGhw/XXY2qWrFGspRVKwdUCM1NFT8oHmZL19WUr
         eWUqHIWGuNt8GK9PgKOtHc7SkwxGpk48Fx/myhUxvaYA7jm7hdlWobN5LD0QCkDIJvWM
         dOFYY1f9BGGT5+u8JOeSzJ7i3methWQGRzUCu1thoeqc1MUMfQrFvwSLTK35mEPdt8Np
         v5qBYr6vMmkzfhFOUgNtZ5kH56lTZCNryTkIKPMDf6WRZOh1s2JteQSP0j9LBB9fVBKd
         1qGvNvbumd0Q/fj3kkaW4QFYPFbOfZdk+SYEYvxIB/ymznfEZUWRgNjTYS+HuRiqVJ6r
         MOBQ==
X-Gm-Message-State: ACrzQf1gt53vp5hFA4exA2qLbc7lTjOxi4kmemvcXnINBG8YG2tQ6kHJ
        mLLpepDYcfeNfrZlYmNixedSi8fNk9BPqQsvN+qkbQ==
X-Google-Smtp-Source: AMsMyM4RVA/k++DcwqYa2VSfEPe9Z4b6HhK0bqBXVVyXNXnXRqeHwjt7qr/6nbFqArNuWsDNgeei93rTd0zjn7rmJxM=
X-Received: by 2002:a81:793:0:b0:35d:78c5:e06f with SMTP id
 141-20020a810793000000b0035d78c5e06fmr30168975ywh.385.1666639473662; Mon, 24
 Oct 2022 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221020232532.1128326-3-calvinwan@google.com> <221021.86lep9g9ja.gmgdl@evledraar.gmail.com>
In-Reply-To: <221021.86lep9g9ja.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 24 Oct 2022 12:24:22 -0700
Message-ID: <CAFySSZCFrfhdKuOT=kxqPPBGBD0T2FtD4vJHfa9M3cMAPCSBtA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] run-command: add hide_output to run_processes_parallel_opts
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I may just be missing something, but doesn't "struct child_process"
> already have e.g. "no_stderr", "no_stdout" etc. that we can use?
> I.e. isn't this thing equivalent to running:
>
>         your-command >/dev/null 2>/dev/null
>
> Which is what the non-parallel API already supports.
>
> Now, IIRC if you just set that in the "get_next_task" callback it won't
> work in the parallel API, or you'll block waiting for I/O that'll never
> come or whatever.
>
> But that'll be because the parallel interface currently only suppors a
> subset of the full "child_process" combination of options, and maybe it
> doesn't grok this.
>
> But if that's the case we should just extend the API to support
> "no_stdout", "no_stderr" etc., no?
>
> I.e. hypothetically the parallel one could support 100% of the "struct
> child_process" combination of options, we just haven't bothered yet.
>
> But I don't see why the parallel API should grow options that we already
> have in "struct child_process", instead we should set them there, and it
> should gradually learn to deal with them.
>
> I think it's also fine to have some basic sanity checks there, e.g. I
> could see how for something like this we don't want to support piping
> only some children to /dev/null but not others, and that it should be
> all or nothing (maybe it makes state management when we loop over them
> easier).
>
> Or again, maybe I'm missing something...

Shouldn't the options that are set in "child_process" be abstracted away
from "parallel_processes"? Setting "no_stdout", "no_stderr", etc. in a
"child_process" shouldn't imply that we still pass the stdout and stderr to
 "parallel_processes" and then we send the output to "/dev/null".

That being said, I can understand the aversion to adding an option like
this that doesn't also add support for stdout and stderr. I can remove this
patch and instead reset the buffer inside of pipe_output and task_finished
in a later patch
