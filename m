Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C783C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 21:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74AA23AFE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 21:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgLKUkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 15:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731017AbgLKUjj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 15:39:39 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1EC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 12:38:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id n11so7559682lji.5
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcpTDZvDX1wPbXrYxcFXShrtPup88SVf2RVPdsc9Y34=;
        b=gg2Y1J2kVgobaDeS4x1CsXaMVGVOUwwIESTP9yYpgIiDkpPaNA61evZ3bSKqAR2ZB6
         Jvtvo9DKOx4G+yOHB2dnf8qhES2YgYoO3AB/P/6AdTHXoEAREuG/SGl2BxHY8sBxWm8A
         xBO21BDtWHxsZbNCkxcoUjCQ4aEqR8YwXslDl4TM0UvDHgO6Tht09tQTSgwCG4g0+jdj
         4L5JP1ehd00D8Y9Ck5m73OxAk5HRaZNKWc3V/8ujmDgz6B63CEFEUqC/IVKVX5bAkuXE
         u6BPFe53dLoT8GIa2F71aNYgAdh0k+GX1qNuJceJ59VATi2uUb7JseQioTc0WyM9dyrJ
         1/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcpTDZvDX1wPbXrYxcFXShrtPup88SVf2RVPdsc9Y34=;
        b=CIoUJYYz/oVl535tRLWuWRJAzC9J4s6r3FI3PkZzuoFFujQKOT7j0yNtVftu1eyu3W
         mUaFEPmR8lmfGvh7skoIovsFZ/aD59GW051yBmIZwWVKzo3ijiqHkfQkMJQw0qRc4/s2
         4nZQfDAdsvQpLNhCN1WnyzpetlxItqTWB4be22yNl7ofTJF9cg8tWIv4v/gaI6hVdulQ
         gZkkuXyaNl6Uw+X6A8J5xa645J8VzG5HdPOBJNiqMZ+u9jrSGkpz+51Cc5Fjm+9pHZlM
         /LMxZ1zNiOFkLPMrkwf2Jx0NkMdx8VLVj1JDvakspoeHzXzytBcony3QNt8Mx6HI9DnO
         tVgA==
X-Gm-Message-State: AOAM531OtRRWgVE+zQ7Q8rM/t+4j8q8QpUQ+XtrdVMq+aF3cUEGjn9n8
        4zsn78kByPcihRxE5c2SZ12RTspqi8YS+IthBX0=
X-Google-Smtp-Source: ABdhPJwMKARmc3yVw9snj2HYMdgf1kx2lcCzZOvb8UOr2fYKrag74jCPnsBT5qwX41tSMirjdlKDntIgnRms4YCLcIM=
X-Received: by 2002:a2e:9550:: with SMTP id t16mr987958ljh.370.1607719137264;
 Fri, 11 Dec 2020 12:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com> <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 11 Dec 2020 13:38:46 -0700
Message-ID: <CAMMLpeQA7VW_C4yw_8n6j_SCoGr8k4VUOUaEp98UxUAMR6-MVw@mail.gmail.com>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 2, 2020 at 7:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> So, the idea is that we currently return NULL when pull.ff is set,
> but now we also check "pull.rebase" etc. and give "--ff-only" when
> we did not choose --[no-]rebase and lack the configuration.  So the
> default (i.e. when pull.ff and pull.rebase are not set) would be as
> if the user said
>
>         git pull --ff-only --no-rebase
>
> I am not seeing what problem this tries to solve, exactly, though.
>
> I would have expected that for those who did not choose between
> merge and rebase (either with the pull.rebase configuration or from
> the command line --[no-]rebase option) the command would behave as
> if --ff-only is given, regardless of how pull.ff configuration is
> set.  That way, those who are unconfigured will just follow along
> what happens at the upstream, until they have their own development,
> at which point "--ff-only" can no longer be satisfied and their
> "pull" would fail until they choose how to consolidate their work
> with the upstream.

My goal was to make `git pull` without arguments and without any
configuration set (the most common case) reject non-fast-forwards, and
not add any new config variables or substantially change the semantics
of the existing ones. In my opinion it's fine that setting pull.ff
would change the behavior of `git pull` without arguments; I don't
think that that would be bad behavior.

I am glad to see so much discussion surrounding the behavior of and
documentation for `git pull`, but unfortunately at this point I'm
having trouble following the discussion as a whole. I'm hoping that it
settles down some so that it becomes more clear what I can do to help.

-Alex
