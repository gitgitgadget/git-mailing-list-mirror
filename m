Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64DCC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiK3SsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiK3SsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:48:02 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4B5140D8
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:48:01 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id z192so22789029yba.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pPb8SK/hCApbyd2I5FJ5/IA/oxXNBgvrLOU64BMD4vo=;
        b=epY8VDiBq4Ec+fOFpoiXIlLb9QH6H3tXOnKRCwYKQUAZ9JAggQXJ+wWa/dp0Am5z/F
         3BoDkBxgcjygJZQ71k5cKb1rmDiTTYdcxciEx45nAVN01FcDBitUJCQKfNnNuKbGBUec
         DNXg1ub/uOyrH/el+0bzHVEhn/sfVOEtiwLtRtP1hVPqTrXxhRzEt1UqU71FaOsiOQ9m
         3flnhSJwGZsQIXpenme585DllvX+ssAAzqQLtICem0CkXkSHxwB/2j0M+g/3XsYC0NfB
         t5QQPdpzkbtP46G77sDQ+KAq77th1wQvGonYPTKTUHI8qPhk0lOxE3YzbydziO5u5d6x
         YNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPb8SK/hCApbyd2I5FJ5/IA/oxXNBgvrLOU64BMD4vo=;
        b=xOZ/m+MEz6jbGfbdXGJIuLiKAw8nB1vd5fTI53ZheUorO1E8GMt+WoT8McqqdANLBZ
         lFA2tmN6EwlQCRFqsSWwr+4j+5wiYe/eejqzLO49S+qQkziDAXt+hhG3jujCKbRSDBmY
         fvU1+tINuh6ByYYjJFDNkuOHoGg8lNczfIdstEFLa3mT6NzZhrNAZaboWHNSYxAP7M3r
         6CldV5cmttac/5qlwd8bHe1cDhIF17DuD1Hb3qGut+8coZh+KxpAAUUaZlBimMCej9Wd
         TvIah0y+wssNUqwu6WlhDCpy/TrsacqhVAlAYifFc2SKDsk3p5nPUCNvI9xB/m3l/wSc
         hILg==
X-Gm-Message-State: ANoB5pmoUe+0149FMEzvKdnx9Poq7eSDzN3uM1lL0i7D7Dve0YNXfo+z
        Cz9H+F/l9eGd5+K+iUha+hirP9Za0nzfQYj2Mnku/Q==
X-Google-Smtp-Source: AA0mqf76B/nWFnet2KPswlcURQMedOWfFzuuoGg7vMG4SrGxSuxT+Dt730LLhm+QOTj1Jx9+H/4BhwzlqCvXsSAyRXI=
X-Received: by 2002:a25:2f8e:0:b0:6f2:d3be:5dc with SMTP id
 v136-20020a252f8e000000b006f2d3be05dcmr27112802ybv.286.1669834079087; Wed, 30
 Nov 2022 10:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20221108184200.2813458-2-calvinwan@google.com> <CABPp-BE7jNcNvF50rqJdSBr2ptwsicUwqtcjZcAV=YDKjNB-vA@mail.gmail.com>
In-Reply-To: <CABPp-BE7jNcNvF50rqJdSBr2ptwsicUwqtcjZcAV=YDKjNB-vA@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Nov 2022 10:47:48 -0800
Message-ID: <CAFySSZDhA0kfVACcni7Gb60wNeNXm8Eg0VpC+_14Qt_HX=KFzA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] run-command: add duplicate_output_fn to run_processes_parallel_opts
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 9:11 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Nov 8, 2022 at 11:11 AM Calvin Wan <calvinwan@google.com> wrote:
> >
> > Add duplicate_output_fn as an optionally set function in
> > run_process_parallel_opts. If set, output from each child process is
> > copied and passed to the callback function whenever output from the
> > child process is buffered to allow for separate parsing.
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> [...]
> > diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> > index 3ecb830f4a..40dd329e02 100644
> > --- a/t/helper/test-run-command.c
> > +++ b/t/helper/test-run-command.c
> > @@ -52,6 +52,21 @@ static int no_job(struct child_process *cp,
> >         return 0;
> >  }
> >
> > +static void duplicate_output(struct strbuf *process_out,
> > +                       struct strbuf *out,
> > +                       void *pp_cb,
> > +                       void *pp_task_cb)
>
> Should the last two parameters have an "UNUSED" annotation?

Yes, good catch!
