Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653EC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 10:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB6020708
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 10:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyeyOFFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGKUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGGKUE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 06:20:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2250C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 03:20:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so45660024ljp.6
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZCqhZDlflTIkbJMg0b9qmKB0lVV+tkXdNeRVwfDgp84=;
        b=PyeyOFFrayTcPxyYd/4u7BtexMdrRtQ3J1GZLkxs/K40P+ib+v0SL+xCFeV0rJUZTm
         NYJcKR6bw053xlxfh2WYgGgdWzDsLgkzniuGNyGfEcY/yV2HINyEI3oiSuzxkAF8gp5q
         5asSqy2AIDrWVhIbFiv92UVJ5EDkOB2VqhdfeIM1I6TaJ7J4QI+ulburatvziRAH3yvr
         kbikrPYcqWMvU0zvEoJylLgWpPH9OsRrKe/JAaeCcVrJFt9aPxm6vgwIO6gbaw8uCjgN
         K2K81poJ1vleokFdRzmkhsWkuxlyT87/XYyTfm/PvvecHaeGgWL++niT1pBfxgV2DTlX
         tnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZCqhZDlflTIkbJMg0b9qmKB0lVV+tkXdNeRVwfDgp84=;
        b=kWpJoVh6zw7BI6lB0igczITLkAgD0MioIteO7Gi1e0YPkmuPuDGqLq+ljjLXJPth9T
         Q7XGxqzHKD88JnwxrlyDFy3nuhqO8L1bgW85pzOIfEV9Clxjx56KS2Z9e8zjKKSLe2TL
         9ihlzQpJT7+uiHlZKjwctLeQSlvcT7+Fi4KugFeXRklMpio6V4EyR/JITHTkDAC/gg1P
         +3t8p6S2R9kuYxIwWdPj7x3FmvRJfNXIhytZriWg5cpIlyoF23nGM0CluGGxmuEIg9Z2
         w+xMjNJ0cuTkQh5/Lx6PRTZfJm6IK2qI5fSGK89KOJ98MxWQKSKB/R2iW37EFxwNNSsh
         ruSA==
X-Gm-Message-State: AOAM530EaZRN0VhlgPEe/+E2mjaTr4/nAqcyMWxnJbfZGIbjCP0N4O0n
        dxlGaRxur1P+U2rbgElqxJ4=
X-Google-Smtp-Source: ABdhPJwLxbm1ZX/RHZ3blRhA6y3706U/HCp2pcubYqQ3yjfkLOvI8Gpjf1J6OZ6x5qc0H8PV7Te8TQ==
X-Received: by 2002:a2e:978c:: with SMTP id y12mr18021030lji.270.1594117201236;
        Tue, 07 Jul 2020 03:20:01 -0700 (PDT)
Received: from aaberge.net (kramer.samfundet.no. [2001:67c:29f4::72])
        by smtp.gmail.com with ESMTPSA id k7sm9457676lfd.67.2020.07.07.03.20.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 03:20:00 -0700 (PDT)
Date:   Tue, 7 Jul 2020 12:19:59 +0200
From:   Trygve Aaberge <trygveaa@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/2] Wait for child on signal death for aliases to
 externals
Message-ID: <20200707101959.qsuumtuelepnxore@aaberge.net>
References: <20200704221839.421997-1-trygveaa@gmail.com>
 <20200704221839.421997-2-trygveaa@gmail.com>
 <20200706211403.GB85133@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706211403.GB85133@coredump.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 06, 2020 at 17:14:03 -0400, Jeff King wrote:
>     I guess to recreate that you'd need to trigger the pager inside the
>     alias itself, like:
> 
>       $ git -c alias.foo='!{ echo foo; sleep 10; echo bar; } | less' foo
>       ^C
> 
>     which does exhibit the annoying behavior (we exit, and pgrp loses
>     the tty session leader bit, and the pager gets EIO).

Yes, that's correct. So it's a rather niche use case. The main thing for me
was the first commit, but I figured I should fix this too while I was at it. I
don't think I have any current use cases where I would need this fix, but I
could imagine some existing. For instance, before stash list got the -p
option, I had this alias:

  stash-p = !git show $(git stash list | cut -d: -f1)

And this is one use case where the pager is invoked inside the alias, so the
first patch doesn't help, but the second one fixes it. While this alias isn't
necessary anymore, there could be similar use cases.

>   - the child for some reason decides not to respect the signal.
>     Obviously running a pager is one reason it would decide to do so,
>     and we'd be improving the behavior there. I have trouble imagining a
>     case where waiting for it would do the _wrong_ thing. I.e., if I do:
> 
>       $ git -c alias.foo='!trap "echo got signal" INT; sleep 5' foo
> 
>     it probably does make sense for us to continue to wait on that alias
>     to complete (I'm not sure what anyone would try to accomplish with
>     that, but waiting seems like the least-astonishing thing to me).

Yeah, I agree. Since it's an alias to an external command, I think it should
behave just as when running that external command by itself where there would
be no parent killing it on ^C.

> However, there is one weirdness worth thinking about. Because the
> wait_after_clean feature relies on actually trying to clean the child,
> Git will actually send a signal to the alias shell. For a signal, we'll
> try to pass along the same signal, so it just means the shell will get
> SIGINT twice in this case (or more likely, they'll race and we'll ignore
> the duplicate signal while the child is in its own handler).

Hm, okay, not sure if anything should be done about this.

> But a more interesting case is if somebody sends the parent git process
> a signal but _not_ the child (e.g., kill -TERM). Then we'd pass SIGTERM
> along to the child. I'd venture to say that's _probably_ the right thing
> to do, if only because it's exactly what we do for a dashed external as
> well.

Hm, not sure. If you run a process in bash and send TERM to bash it seems to
just ignore the signal. The child keeps running, and bash even keeps running
after the child exits. If you don't run a process in bash it respects TERM and
exits. I'm wondering if an alias executing an external command should behave
the same way as when a shell does it.

Though, I also see that this only happens when bash runs interactively. If you
run `bash -c 'echo; sleep 1000'` it exits, but sleep keeps running.

> Sorry that ended up so long-winded, but my conclusion is: this is doing
> the right thing. We should probably embed some of that discussion in the
> commit message, but I think the simplest argument is just: this is what
> we do for external commands we run, so treating shell aliases the same
> in terms of passing along signals makes things simple and consistent.

Thanks, yeah I'll send an updated patch with a better description.

-- 
Trygve Aaberge
