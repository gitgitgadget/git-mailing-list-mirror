Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2191BC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAC12224D
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKMVk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:40:58 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:40251 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKMVkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 16:40:55 -0500
Received: by mail-ej1-f67.google.com with SMTP id oq3so15773023ejb.7
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6+mB+MMKA+HxSIUmrDk/nHzTYg6K/JXzpjR6dPio6I=;
        b=egMAkLDsYGTGUz6kykOAzambuCuBoTnsHUIXE5hC/EVqSxPo/9G+nVRDeUpsIhZc0p
         JBr9P/ylzFyWU0kHbDsRHZEY2BGCltc1Lhaekk+lw/wb13W6G+FJEJobBjfb3buuYA30
         m2t5ylKQdQsq2WiFDfLepuga9ZDfA9oA0VaHs11uY+wmmJm17x/Q2F5IR63FBAnzURCd
         9fTLDNsU8v41SY/IxatftxEmI+k5a8YrayHhszPUXqEfUaYNVRY/EhRjf2sBTeKQTH5h
         vpR1774n0doSKpYiWM2OxkyDNOGLmCYcKqmZmPbVVbPa5rNRi4dumxRtDw2blRm80Oux
         qaxw==
X-Gm-Message-State: AOAM531ZaA9WpSpfWxfuDyQNGxZ3k6x+U0ytvErf02HutD4E3yKKViVC
        /1vCwiMfiNwxIwbt7THaNkio+HH8Q9zFOieehXA=
X-Google-Smtp-Source: ABdhPJwVfWa5xVU2gV95UuisDxW0B7ybdkZjARsuRxyZG0dD5FlBkG/bSeAs/zbaljg2XnZUyQD4rc1R/Vr09CIWLHs=
X-Received: by 2002:a17:906:c357:: with SMTP id ci23mr3821512ejb.311.1605303650967;
 Fri, 13 Nov 2020 13:40:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com> <ed7a61978fe9dce26ca459b5a86490c15e470698.1605276024.git.gitgitgadget@gmail.com>
 <CAPig+cS3YXH=SmTsRTOa5Cdppt9L=MbFRT+LWn9QE7aEqRiDqQ@mail.gmail.com> <73c902db-40f5-2693-c350-9c04ba2751cf@gmail.com>
In-Reply-To: <73c902db-40f5-2693-c350-9c04ba2751cf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Nov 2020 16:40:40 -0500
Message-ID: <CAPig+cRv_Swd4WcZDnyDxg4E1HdwdkfybjWiZsYwPFSxkhUz0w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] maintenance: use Windows scheduled tasks
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 4:32 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/13/2020 3:44 PM, Eric Sunshine wrote:
> > On Fri, Nov 13, 2020 at 9:00 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +test_expect_success MINGW 'start and stop Windows maintenance' '
> >> +       write_script print-args <<-\EOF &&
> >> +       echo $* >>args
> >> +       EOF
> >
> > Using `>>` here makes it harder to reason about the test than using
> > `>` would, especially since `>>` seems to be unnecessary in this case.
>
> Since we execute the GIT_TEST_CRONTAB executable multiple times, we
> need to use >> to log all three instances (and their order). Using ">args"
> would only capture the final call for the weekly schedule.
>
> On macOS, there are as many as six calls (three bootouts, three bootstraps).

Makes sense. Thanks.

> >> +       GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
> >
> > Is it a requirement on Windows to mention /bin/sh here? Specifically,
> > I'm wondering why a simple ./print-args doesn't work. (It's especially
> > unclear since write_script() is used heavily in the test suite and it
> > seems to work well enough on Windows without specifying /bin/sh.)
>
> I landed on this after trying several attempts to get this to work,
> including "$(pwd)/print-args" and I'm not sure why it doesn't work
> in the Windows case. It is something to do with how I am executing
> the subcommand from within Git. I'm pretty sure this idea of "mocking"
> an executable through Git is relatively new, or at least rare

Just for clarification... You mentioned in response to my [3/4] review
that your accidentally-working write_script() only worked as expected
on Mac but not on Windows. When you arrived at this solution of
GIT_TEST_CRONTAB="/bin/sh ..." here, was that before or after you
fixed write_script() to take the script body from stdin?
