Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D3CC433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BA8236F9
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbhAIWaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIWaB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:30:01 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B141C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 14:29:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o19so31887541lfo.1
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 14:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5O0CA2RdyBBAhIYqa3twIY2u4ljSQXwgf4AsmsgVB1A=;
        b=hueZ4VsDE+YSxdgQWi97gLKOz5qZJun6dKT89c7fdjdL1drNCWzz4EcNeIWqA9iYOE
         eKoo3CXQbcFcPiQcZ1HuV6NSfOrE4lIVok4/nt/5QyYdcSTpBmPQl8Mv3BLKrIbWRAvb
         ip52LdMgUB8iHFaU1CKglnw8T/LU+XKLG0IbWQBVyHfTRq8h0yhun5UQbSGZCGStCUTa
         ZZmNuK3SGXspx0RXmID+xCG7nWZ8p57UlPYZw/GZxkzST0pv7sZJ/5H//gOu5++UJiKf
         qnr79xgKHwn372jPZBJFQh6qwlwh4pQG9Rteh4xXF92deykijN5ZeyPl//jNY7wwgWw0
         BJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5O0CA2RdyBBAhIYqa3twIY2u4ljSQXwgf4AsmsgVB1A=;
        b=R5O6QNf2lTONJNAphTHRjIUmpfKztVERyrsETjiRDFSWQPdzkr5eWeR/GX2ScBMlAN
         wPXcUh74vpDRdGB8F2zBvkNvIyvtsOW709SaBXQlgoJaiFX+68SlbgrP2/ewd5rdSiqC
         /rXtEg5bEyzrI+mDFT7v6q0e+ERbfS3ERq2Mhzf2s6eTtLUiiA3EouWR1RSTjse0dEhz
         eJD69D7gmUkwQu8aFkWEAChothCiTzC56uQppNxxTTP5sHz3b+6PJ1CeKfm2Bq+DikdQ
         4/aSFz84KjpEU0X+GU0umccv8ABiFbqOhiKAqia9IR/p1yNQbkFcoZcMM1g7e3GCITET
         i18g==
X-Gm-Message-State: AOAM530aUWEwzLQzoUP4eyj0htwrGf6YCyToQ9Rzd6iaEXUgPe5dnEtL
        yPNw4T5pF8bbE1R+apqZFG8e0Erg6q81FGjhI5RNKQ==
X-Google-Smtp-Source: ABdhPJx9RDtkUsoNrJPud4s6yLrizJexrkeIqzoUmH2UglI4FqNWRThla1icuxZqOzh3k/fsFt81P6TaW5La/iLRrpk=
X-Received: by 2002:a2e:9757:: with SMTP id f23mr4244189ljj.55.1610231359871;
 Sat, 09 Jan 2021 14:29:19 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6tkn9xw.fsf@gitster.c.googlers.com> <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>
In-Reply-To: <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 9 Jan 2021 19:29:08 -0300
Message-ID: <CAHd-oW4_dFixMjVSgpCEc-fX17Wye=KzFL5mvLizMYm5aFczUA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #01; Wed, 6)
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Elijah

On Thu, Jan 7, 2021 at 3:21 PM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Junio (& Matheus),
>
> On Thu, Jan 7, 2021 at 5:41 AM Junio C Hamano <gitster@pobox.com> wrote:
> > * mt/grep-sparse-checkout (2020-12-06) 10 commits
> >  - t7817: do not depend on any specific default branch name
> >  - config: add setting to ignore sparsity patterns in some cmds
> >  - grep: honor sparse checkout patterns
> >  - config: correctly read worktree configs in submodules
> >  - config: make do_git_config_sequence receive a 'struct repository'
> >  - t/helper/test-config: unify exit labels
> >  - t/helper/test-config: diagnose missing arguments
> >  - t/helper/test-config: be consistent with exit codes
> >  - t1308-config-set: avoid false positives when using test-config
> >  - doc: grep: unify info on configuration variables
> >  (this branch is used by mt/rm-sparse-checkout.)
> >
> >  "git grep" has been tweaked to be limited to the sparse checkout
> >  paths.
> >
> >
> > * mt/rm-sparse-checkout (2020-12-08) 1 commit
> >  - rm: honor sparse checkout patterns
> >  (this branch uses mt/grep-sparse-checkout.)
> >
> >  "git rm" follows suit to "git grep" to ignore paths outside the
> >  sparsity pattern when the sparse checkout feature is in use.
> >
> >  Need to wait for how these fit in larger picture.
> >  cf. <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>
>
> Larger picture provided last week[1].  I would now say that:
>   * mt/rm-sparse-checkout needs some small changes (Matheus: I'm happy
> to tweak the patch and add a Helped-by: Elijah to it if you want me to
> push those changes)
>   * the bug fix part of mt/grep-sparse-checkout could possibly be
> broken out and merged now (Matheus: similar question here...do you
> want help with this?)

Thank you. I would really appreciate the help :)

>   * the other parts of mt/grep-sparse-checkout should probably wait
> off based on Stollee's sparse-index work mentioned later in that
> thread

Do we want to also pull out the fix to correctly read worktree configs
from submodules and the improvements to test-config? I.e. these
patches:

- config: correctly read worktree configs in submodules
- config: make do_git_config_sequence receive a 'struct repository'
- t/helper/test-config: unify exit labels
- t/helper/test-config: diagnose missing arguments
- t/helper/test-config: be consistent with exit codes
- t1308-config-set: avoid false positives when using test-config
- doc: grep: unify info on configuration variables

These are unrelated to sparse-checkout, and I think they might be
worthy on their own. (Although IIRC, the last version of "config:
correctly read worktree configs in submodules" didn't get any reviews
yet.)

> (Matheus: I'm so sorry we've delayed your series for so long.
> I feel bad.  But Stollee is proposing some rather big changes that
> could significantly affect this and several other things.)

Don't worry :) I understand that waiting off is the best approach, and
it should lead us to a more solid/consistent design later.
