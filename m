Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36014C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 10:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiD1KhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 06:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiD1KhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 06:37:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4888D69CFC
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:33:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kq17so8670910ejb.4
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/Wz/4RDhwZZT5UtksUaTLkFMtUsz4lleJj3K6/W23A=;
        b=qZUB2urf8zC7ZrRJVldEb9Iz5ERlha62f+gO6j5xZ7HQTvDmV+sRlFLl4IpWpYzFsv
         96ktY5lvN59LY0muojabKDVsv1Y/wssWRWyW7upmn3q0J43hz/qZeSqSiuMcKrSCzf7g
         uBqwJET3ZPZdYVPTvpQWaYYCLKv1tqBEd2KGrN09TOdiY2nyHipBfjGyutnTc04rIt1P
         h54xDKeiDjVh6ped7Les8KHWD/PAcCeLq300BWVs05ldvifgwHr4aDvcWaCjyl4iNH+n
         DKBxxX9tMvIdeJnkFgndlwB8sBvFjZ2Ra22WNZCuQG1UsWLomzcskc6nL5L5etLoxd+7
         rOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/Wz/4RDhwZZT5UtksUaTLkFMtUsz4lleJj3K6/W23A=;
        b=OXDbTpl+BYA+kkqIQiPDkpzceIZDBYpXhkIut06Pw8v5lbKliEXh4jq7JJMxrNOQaf
         uZWpcP7tKGzL+haGZMpALtB+er4EBfQ3mR1WKel4P7eSmPx75oL/J+8sydmT5nLfuR2g
         wdMNev0ca1ptlNWbgCwJ2bFHW9iP7r83kEMSxqRXyV8MY3sEccGVfIpMHUaNzaJ184Vz
         xtMOF599tDze4Wz7IXMZbYnxSj5r6Ytm0TR1AqFJzS8MijKoIyv9Tgo8u3y1h53wQtNq
         cc6vD5Y6B2IKMD9taGWajKATZMXUecNkHI3tKIBD/Wep/X5uSU79BebpWyKL7bYAtntO
         BL8A==
X-Gm-Message-State: AOAM533rNhUH2SXiyqMo0Hu6KB67VGNNjFTYZAsTEoMNL7BMiUhqAJOH
        jzVP4OqIN6R2lf6MQztYk//Vc8UtUVFWMnxMtDc=
X-Google-Smtp-Source: ABdhPJwE0R73mEo4WhFBd8Xiz3K9EC4EzUgzY0RMR6caTnB+lQwrsjhYuAa7T2n+Ht1nFM+JSjHTCrVIuy7IvucI+i4=
X-Received: by 2002:a17:907:2cc3:b0:6da:e6cb:2efa with SMTP id
 hg3-20020a1709072cc300b006dae6cb2efamr31028958ejc.169.1651142025840; Thu, 28
 Apr 2022 03:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqfsmg97ac.fsf@gitster.g> <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
 <xmqqczh4vp6e.fsf@gitster.g> <fdd9f13d14e942f3a1572866761b9580@SAMBXP02.univ-lyon1.fr>
 <243b40ef-a720-46aa-6657-87ac8d3c3bdc@univ-lyon1.fr> <xmqq35hzsu0d.fsf@gitster.g>
In-Reply-To: <xmqq35hzsu0d.fsf@gitster.g>
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
Date:   Thu, 28 Apr 2022 12:33:34 +0200
Message-ID: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Be nicer to the user on tracked/untracked merge conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Guillaume Cogoni <cogoni.guillaume@gmail.com>,
        BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Probably a command line option ("git merge" would probably want the
> same one) plus a configuration varaible to give it the default (the
> latter is optional).

First, we think that add an option to pull and merge is more suited to
our situation, and next, it could be good to add the configuration
variable

In unpack-trees.c there is a list of files that cause problem with merge.
We want to split this list to list files that have the same content, then if
all the files have the same content, we can suggest to use the option
to overwrite those files.
Then we can modify the error message to show the files that have the
same content apart.

> I wonder if this whole thing is an attempt to work around whatever
> "stash --untracked" fails to do well (or perhaps there are no such
> shortcomings, but just the users are not made aware of the command
> enough).  If you have these two untracked files (file1.txt and
> file2.txt) are "in the way" for a merge to succeed, I have to wonder
> if "Please move or remove" message that was introduced by 23cbf11b
> (merge-recursive: porcelain messages for checkout, 2010-08-11) is
> still giving a good piece of advice to users today.

We got a similar idea, but we finally decide that it was not a very good
approach because it's not efficient if we have a lot of files or some big files.
And because if there are files that doesn't block the merge, we treat them
anyway and they will move from the work tree, it's a bit overkill.

> Note that I never use "git stash" with "untracked" option, so I do
>  not know if it works well in this context already, or we need more
> work before it becomes usable in this scenario.  But it smells like
> it is exactly what we might want to use in such a situation to stash
> away these untracked file1.txt and file2.txt while running the
> merge, while allowing us to recover them after running the merge or
> discarding it.  I dunno.

Indeed, git stash works well with this kind of problem, however an option
would be easier in that specific case.

Thanks for you're helpfull review, you always give us a lot of good
information and ideas.

Cogoni Guillaume and
Bressat Jonathan
