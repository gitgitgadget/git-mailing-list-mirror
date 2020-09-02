Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649AFC43461
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4978820767
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 16:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgIBQ7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:59:39 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37543 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgIBQ7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 12:59:03 -0400
Received: by mail-ed1-f42.google.com with SMTP id n22so5642422edt.4
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 09:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiYTmHZxFBPrgE8nR4KZHDcpJzNRHPYpCoBXu1PRPZQ=;
        b=jvbuQKtKy46DzsDLk6+3WErWBAo3PfoI//XIrckUQF4FRI+81R8A/KHhnz/RWrfv5I
         koehhTQu8GbcLMi6uKOjsmB4NE0DVwTQXawQwa6vMRShgDLQWBEdgI/RRGKXG/r4oIcq
         2Kkmo+6oBzJfZ4kVYk9Ia71jsFphmYR9p73v4RErNPFpjGQAUbLebQpgmTnsjGG5+3FF
         y3/nELBclLDHv1oWoCk3juEtNVm+qrdenA2wfDFN2F1L/T5cT1eOgVj/bfF2Mx+9M5k1
         dPElFgNr5RT2SMUoFJeECDgp4ZzLZc1G2qzCqfmW59pNSWYkhBQm9Xl7fV6NmOrbPlSz
         UhYA==
X-Gm-Message-State: AOAM533omPuv8rn7dWIUGHb+/La58kVrwyR3YPFUyTbWdMY7Naq9Hx5X
        WEc0GJRxJ9tiFTAdE3ttQd1/nU4AIx94FBMvlzc=
X-Google-Smtp-Source: ABdhPJwHl5wkV3aj1BxnvA7aAfRI+6TknOrxMWLyIQ8QVIVWELZCuAWJLa3YnprN2EqKFxUa/F0tScZ/A1AJVn2zYgA=
X-Received: by 2002:a05:6402:17da:: with SMTP id s26mr971909edy.221.1599065941616;
 Wed, 02 Sep 2020 09:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqblipchk6.fsf@gitster.c.googlers.com> <CAPig+cTUhLoPvs+ygnc0Y4Ez3M3tfGncPzON0ejb=xEOMBixHQ@mail.gmail.com>
 <xmqq7dtcceka.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dtcceka.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Sep 2020 12:58:50 -0400
Message-ID: <CAPig+cTGspJAGxRu+vqdko1ntkBonVaoStYde3+P5UxPxrCs7g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #01; Tue, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 2, 2020 at 12:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I wonder if this could be reworded so it's clearer that "git worktree
> > repair" is a new command, and to mention fixes to "git init
> > --separate-git-dir". Perhaps like this?
> >
> >     "git worktree" gained a "repair" subcommand to help users recover
> >     from problems arising from factors outside of Git's control.
> >     Also, "git init --separate-git-dir" no longer corrupts
> >     administrative data related to linked worktrees.
>
> OK that reads much better.
>
> -from problems arising from factors outside of Git's control.
> +after moving the worktrees manually without telling Git.
>
> The latter is slightly shorter; does the "repair" help situations
> other than that, or is the above cover all the "factors outside" out
> control?

The current implementation also helps out when the main worktree (or
bare repository) is moved.

However, in the "git worktree repair" documentation, I intentionally
avoided nailing down precisely the problems it repairs, instead
leaving it open-ended since it may learn more repairs in the future.
(The documentation is careful to say that it repairs "administrative
files", and then talks about the currently-implemented repairs as
_examples_ of what it might repair, without locking it into only those
repairs.)

I think the same generality of description can apply to the blurb
here, as well. We don't necessarily need to give precise detail in
this blurb -- the reader can learn the details by consulting the
documentation.
