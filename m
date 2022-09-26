Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FB6C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIZRz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIZRyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:54:53 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00B1FCDC
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:31:17 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p69so9376395yba.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5RMRnOMYmt9bm5IDNRQOT1f1mfq0rwx29PdALvLDYDo=;
        b=eMEmtNWlbZ02HYZZOkIemoNCulO/5UPOGLqVvdnXFTbj0MzjXoBTonZKE7PEWrZexS
         YHPW9KPwHyeuszj+WeCgelyiDDsw9OZtrUKxWXZ6pE1FIPWPQaAI3ULPQyvdF7heQukK
         WCQPSU41m4f0K+FTONuGsVwkL62dOZddGAr/CfFADE8m3S794xuu0+WYWhB+mlSDAkc7
         kDfQikPMmHj5aJhPLB/cDBhz9Fay8eSDzqDWItl2CoExYBFpPZMUeW886SiHHFNW0h9d
         R/b2bDY0/ztD9Z4UEGcr205FNGtG9nntdpKnyOlgNxc8jUSF/Fuwq6z4hVpID+P85Zz+
         YafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5RMRnOMYmt9bm5IDNRQOT1f1mfq0rwx29PdALvLDYDo=;
        b=RPR8S7nUdvh1lk4T7lOKIP0JSD4QsL6pnUFkk5Yo5Dfrt4xlAOVjlW3fzaOapf4QMp
         irmB31TYU/LaKS0MFuDf6zgYONmbfgHxLWSuri9OCVTjQgSRS6uTAyL2vOmKz29S3VkV
         rkS+JpRPLlY8YPoTaPIEm09dzvly0TTHhUP/591NlNHVcxKs8SBO9Qp5rd4M/mlC6RGk
         d1mlwWKeQ1ezly9lQwcQBdrmxC2ZK+xMm9VKps3slWaZWb92O0iNg09c5X8svpCMPttG
         F1NZmBC5mt5HtnE1/91rytdvZj5KjT5m/ISpx9tlyHamYURnE0ZB516pCPDsV/GINYDd
         9jTw==
X-Gm-Message-State: ACrzQf2FPT3Nr56kbwkodbsc0uQDynOz0bkp/ifctjEZZQ1uvMVoC54A
        AtvobhvQRMTw25FimuM4mH/vg0cpUTQKkGSOCebS3s2SJ7Y=
X-Google-Smtp-Source: AMsMyM726Ktwk9tJDc3H1gcw6816ziCkQOQD15Em/senCXLyTHdJSin6yt7T88CJDKw1gxa3F36qyrSNQ2n8SVFNXTk=
X-Received: by 2002:a25:37cb:0:b0:6b1:db19:83cf with SMTP id
 e194-20020a2537cb000000b006b1db1983cfmr23121407yba.391.1664213476435; Mon, 26
 Sep 2022 10:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-2-calvinwan@google.com>
 <xmqqy1u9uddc.fsf@gitster.g>
In-Reply-To: <xmqqy1u9uddc.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 26 Sep 2022 10:31:05 -0700
Message-ID: <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  * Why are we configuring an API behaviour via a global variable in
>    21st century?

I was mimicking how "ungroup" worked, but now that Avar mentions
that pattern was for a quick regression fix, I can fix it to pass it in as a
parameter.

>  * The name "task_finished" is mentioned, but it is unclear what it
>    is.  Is it one of the parameters to run_process_parallel()?

It is one of the callback functions passed in as a parameter to
run_process_paraller(). I'll go ahead and clarify that.

>  * Is the effect of the new feature that task_finished callback is
>    called with the output, in addition to the normal output?  I am
>    not sure why it is called "pipe".  The task_finished callback may
>    be free to fork a child and send the received output from the
>    task to that child over the pipe, but that is what a client code
>    could do and is inappropriate to base the name of the mechanism,
>    isn't it?

The output in task_finished callback, before pipe_output, either
contains part of the output or the entire output of the child process,
since the output is periodically collected into stderr and then reset.
The intention of output I believe is for the caller to be able to add
anything they would like to the end (this can be seen with functions
like fetch_finished() in builtin/fetch.c). My intention with pipe_output
is to guarantee that output contains the entire output of the child
process so task_finished can utilize it.

>
> > @@ -1770,10 +1771,12 @@ int run_processes_parallel(int n,
> >       int output_timeout = 100;
> >       int spawn_cap = 4;
> >       int ungroup = run_processes_parallel_ungroup;
> > +     int pipe_output = run_processes_parallel_pipe_output;
> >       struct parallel_processes pp;
> >
> >       /* unset for the next API user */
> >       run_processes_parallel_ungroup = 0;
> > +     run_processes_parallel_pipe_output = 0;
> >
> >       pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
> >               ungroup);
> > @@ -1800,7 +1803,8 @@ int run_processes_parallel(int n,
> >                               pp.children[i].state = GIT_CP_WAIT_CLEANUP;
> >               } else {
> >                       pp_buffer_stderr(&pp, output_timeout);
> > -                     pp_output(&pp);
> > +                     if (!pipe_output)
> > +                             pp_output(&pp);
>
> So, we do not send the output from the child to the regular output
> channel when pipe_output is in effect.  OK.
>
> >               }
> >               code = pp_collect_finished(&pp);
> >               if (code) {
>
> And no other code changes?  This is quite different from what I
> expected from reading the proposed log message.
>
> Am I correct to say that under this new mode, we no longer flush any
> output while the child task is running (due to the change in the
> above hunk to omit calls to pp_output() during the run) and instead
> keep accumulating in the strbuf, until the child task finishes, at
> which time pp_collect_finished() will call task_finished callback.
>
> Even though the callback usually consumes the last piece of the
> output since the last pp_output() call made during the normal
> execution of the run_processes_parallel() loop, because we omitted
> these calls, we have full output from the child task accumulated in
> the children[].err strbuf.  We may still not output .err for real,
> as we may not be the output_owner, in which case we may only append
> to .buffered_output member.
>
> I am puzzled simply because, if the above summary is correct, I do
> not see how a word "pipe" have a chance to come into the picture.

Ah I see what you mean here -- your summary is correct. Something
like "buffer_output" would make much more sense.

> I can sort of see that in this mode, we would end up buffering the
> entire output from each child task into one strbuf each, and can
> avoid stalling the child tasks waiting for their turn to see their
> output pipes drained.  But is this a reasonable thing to do?  How do
> we control the memory consumption to avoid having to spool unbounded
> amount of output from child tasks in core, or do we have a good
> reason to believe that we do not have to bother?

You are correct that storing unbounded output doesn't seem like a good
idea. One idea I have is to parse output during the periodic collection rather
than waiting till the end. The other idea I had was to add another
"git status --porcelain" option that would only output the necessary
pieces of information so we wouldn't have to bother with worrying about
unbounded output.

Any other thoughts as to how I can workaround this?

Thanks!
