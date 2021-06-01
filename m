Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9393C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B66613BC
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhFAXfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAXfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 19:35:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B931C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 16:33:43 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so887993otk.5
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wZ8iC2+6lXHX6EObOwnKlUoy6og8rE6Hg+5A5KyidCY=;
        b=DQGK0zLfe8kQg+JbNn4egvdJ5IKWsv4FXk6J5UZzvnY7zoW7BbBRHdt6hIr6QTjWda
         Jz3hYJ0nY+3YFJlPHEfmBUJD5thJpVLM6nnc5Vd1BbD2z8+Y0UpsgzI3V/49bLbNK7bt
         dXULAIidE9Y70NC9YndimFhaoQPqG0fPN7pUZdxRFQXEV2Fpay7ubhmm+xFDOMH/L1pg
         /sgug0V/AKHEOshqDnKScTNE8yEcLn9jI6tdpnHCfD60cMYBGSGlWIXPuQD9+cow/lob
         253r0muoGO6efrV0ugWykwoID/Yk+M85ev17+wWkhY8Lc9KTNEQWWi2gR6ladBPgL/rh
         WOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wZ8iC2+6lXHX6EObOwnKlUoy6og8rE6Hg+5A5KyidCY=;
        b=UqJzKBacUCnc+j1Ru2pFlHHs1lb2uiwwoFiPkeFEH4syOkB1ZnsgYVLYIbhV7QPHl9
         UQxT6A7E4fJkjlhi6e39EWgf2s30xSWZE9E0ipH41kOhoz2fJ67cHNGESebmnlE01q+z
         z63iCWrfO0eggl+Nnj31lGpdpwhEKahEygxo6I5JiQwmDoy1XY+dCkW4HRYzOxEh6Zje
         lCuaurSgyb4J8ii28fyR3bpImrATkgRQA6/74uTXjEDv37sHuumU1s3kXOy3hBYTKuiN
         I10GsFpZfNzCw1R0xZmFaDu8JhAxXaYF/x9nEuvPJI5o9CMgDueewsXrOPce1xpBIqrC
         kfEQ==
X-Gm-Message-State: AOAM533AtfUFzjcBIMllKt9x9jVyEH7CZtxPJRpFpAOD+HLkCGReiV2l
        qfT93BnLeHmPiSl7ttY4IIU=
X-Google-Smtp-Source: ABdhPJxGhyeuOtKo90HCjHlyxw59fAJ3AvDIjSmy6qgWG6D9Jrkn4HKPoZyf6ziZN88uA7w9UZcqsA==
X-Received: by 2002:a05:6830:2243:: with SMTP id t3mr22954652otd.142.1622590422630;
        Tue, 01 Jun 2021 16:33:42 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r10sm3734000oic.4.2021.06.01.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:33:42 -0700 (PDT)
Date:   Tue, 01 Jun 2021 18:33:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
Message-ID: <60b6c3d4d432b_4044208a6@natae.notmuch>
In-Reply-To: <CAJDDKr630n7=8FqsSRXpN7fNy9ZB8FOzO=LxvfHFVrMR1=L3_A@mail.gmail.com>
References: <20210601165254.18136-1-davvid@gmail.com>
 <60b6873624c6f_1a702085e@natae.notmuch>
 <CAJDDKr630n7=8FqsSRXpN7fNy9ZB8FOzO=LxvfHFVrMR1=L3_A@mail.gmail.com>
Subject: Re: [PATCH v3] contrib/completion: fix zsh completion regression from
 59d85a2a05
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> On Tue, Jun 1, 2021 at 12:15 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > > @@ -261,7 +261,7 @@ __git_zsh_main ()
> > >
> > >               (( $+opt_args[--help] )) && command='help'
> > >
> > > -             words=( ${orig_words[@]} )
> > > +             words=( git ${orig_words[@]} )
> >
> > This is wrong. The current code is fine.

> Thanks for the detailed explanation.
> 
> Just so I'm understanding this correctly.. if this was instead..
> 
>     words=( git ${words[@]} )
> 
> (instead of orig_words like I mistakenly included in v3) would that be
> an improvement, no-op or would it be worse?

It would be an improvement, but it's orthogonal to the regression you
are trying to fix.

I would just fix the regression for v2.32, and then afterwards try to do
the improvement.

I have a testing framework for the zsh completion in my git-completion
project, so I would be much more confident about this change if all the
tests pass. Alas I have not yet merged any v2.32.0-rc* so it's not
straightforward to run the tests now.

> It sounds like additional changes are needed to make it properly
> support options between "git" and the sub-command name, hence the
> patch is fine as-is in v4, correct?

I mean there's git options, and git command options. I don't know how
many changes are needed to make all the interactions work correctly, but
I wouldn't have confidence in any of them so close to a release,
especially considering git.git doesn't have any zsh tests.

So yes, v4 is fine.

> Hopefully in the future it can be extended to cover eg. "git -c
> foo.bar -C some-dir <sub-command>" as well. Thanks for your patience.

That will work correctly on git-completion once I merge your v4 patch
(and v2.32).

-- 
Felipe Contreras
