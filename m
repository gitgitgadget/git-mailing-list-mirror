Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137AFC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F2561864
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 17:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFYRpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 13:45:03 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F86C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 10:42:42 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id b17-20020a4aba110000b029024c219a3d83so1536810oop.10
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Q0kMDNY+74qAgyyKIiaJs1pAgUMunTvkw4ym753AVUY=;
        b=rRgnfa4ftgSzpoGGYpwxql1+tNde2o98mrFGnvRfv86130zMcql3+d5GG5JC8f5zGB
         QXOSqbY8eA3qcg+ebbam6772WNmj0GUhz6Z0hWjQcGF51O2bC9Gk6ATjOS4jyeQtPbvm
         yWT2fvqpKJBq2oOhwfziOsaehPS0FEgGH7P2LZU0MA/Moit3VI+uuQxMVfCD1V21qc2z
         NJk16rsdjbF/suhoq46TgvADs7aD2dtTIK4+6+LxTSSDX6QaGh8rhZhks+gwMmRfP8DW
         9svwlyWhsdfwYUaEzO6x6P32lDItBJtLZJ3xwgMgKKFkt8EMrAi50h6/BkaPKba3znPf
         AACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Q0kMDNY+74qAgyyKIiaJs1pAgUMunTvkw4ym753AVUY=;
        b=bAZqosj9gL18HhSZfUhJBbbxHY46YgzRvOsY7REQHQS+Vf3HCKnb/+pNqysEpr6r0X
         meCNBGfIUkr+obsY0pT1pQBLE1c80e/eRNhJ9lVsXIbz6mCay7Xg3C0fLQ2xUrzEvx0g
         fotNHSk11fgHmbSzgDvA0Xsb7noo3Yj8eKwd9TDL8/Tyj+dxns8rLWD/JDqkWaINdChx
         LTvP8Tbz3ErdInoeKovSDdu+5s5Rw7jj0pjXCiDHtKHqDoVDkSIe0xl3nPc2nOVx6Dr0
         Q8ptHMp35dxwdFs0+oRGDnnOOE6EwQ9wIobrIQcn/XHFSLB+kh3FXM+xiC5a74dUvNNA
         4o6w==
X-Gm-Message-State: AOAM530wjCsYuWD3Ze8dknZyPybha7jbDj4V5OgXWiW87vT3Vkih7LQH
        vliQuQRIaEUl0VtvFnqVL4Y=
X-Google-Smtp-Source: ABdhPJwcZgvqu4WjH2bQmeW+dsJ1lEBwiwPWLEM/Yn3xyKoOWJ4rpj7LIMNiTxbBzQ5WC1nI5AoSVw==
X-Received: by 2002:a4a:1401:: with SMTP id 1mr10069942ood.50.1624642961804;
        Fri, 25 Jun 2021 10:42:41 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id t25sm1136359oij.47.2021.06.25.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 10:42:41 -0700 (PDT)
Date:   Fri, 25 Jun 2021 12:42:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Avishay Matayev <me@avishay.dev>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <60d6158fcef74_cc8d20834@natae.notmuch>
In-Reply-To: <CAJ-0Oswry0Rry_0ZqZzzVGuzfU-apZnv95LcxQEhm7GVA=uOxA@mail.gmail.com>
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
 <60d294eb984ba_3122081@natae.notmuch>
 <CAJ-0Oswry0Rry_0ZqZzzVGuzfU-apZnv95LcxQEhm7GVA=uOxA@mail.gmail.com>
Subject: Re: Forcing git to use a pager without a tty
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avishay Matayev wrote:
> On Wed, 23 Jun 2021 at 04:57, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> > Seems like a completely sensible request to me, except I would do it a
> > slightly different place:
> >
> > --- a/pager.c
> > +++ b/pager.c
> > @@ -101,7 +101,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
> >
> >  void setup_pager(void)
> >  {
> > -       const char *pager = git_pager(isatty(1));
> > +       const char *pager = git_pager(git_env_bool("GIT_PAGER_FORCE", isatty(1)));
> >
> >         if (!pager)
> >                 return;
> >
> > I'm Cc'ing Jonathan Nieder who seems to have toched these lines.

> 
> Well I'm glad to hear you find it sensible, though your patch suggests
> that `GIT_PAGER_FORCE` will be a boolean, while I expect it to be an
> actual pager, which would make more sense IMO.

I just copied the idea from the GitHub issue, I find it simple and easy
to implement in the code this way. A GIT_PAGER_FORCE as you suggest
would be a bit more complicated.

Either way feel free to provide a patch with whatever approach you think
is best.

However, for a proper patch you need to add documentation too (see
Documentation/git-var.txt), and preferably some tests.

Cheers.

-- 
Felipe Contreras
