Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB172C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EEE60C51
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhGWRDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:03:55 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:34486 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGWRDz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:03:55 -0400
Received: by mail-ej1-f51.google.com with SMTP id v21so4923885ejg.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjf5fhBMhJIg0F8x3DOOnDUPDIWYF4RivIwucBQZfAI=;
        b=R+d8+ibJ5wcA+ksC3radsDz9HbZ2BWmJKFEjtIHqFXIK/6LcKHvkE5XmZtlP1yhCwF
         24oSjaVieiEfgmutPg7BNyHkc8tu32LgNGIwk1ERex4ERs3Yj2moFEq5LDpJO1+sk6g4
         MYj+jKeV1c1uD2P/EJHpj6OcdCbCCcJflQhjczes8S3ly8ZJQ7ZVAElgQTgN+bAPEAqW
         SBZ232bcTOKCQ9kkeXA8q3bchFb6KB0P4rTlaPmV3R2ETS+7hi+DYhSc8f5QnBtg5R08
         8a8M7aUaX+IItMF+jCfJbhm4iXvxEtJRWNvysXpiGKUzaHGg4BKL4BzVP/lgmVjS1McK
         Dqcg==
X-Gm-Message-State: AOAM5315WE0JvxAzR2HdfBoJtD0yOVgl1TDDbXrUYNL3rK4ae+BbpbzX
        ng+0Fh3VsIyUsx+S4LsS/I5W3MJlTvyzSHUKU5o=
X-Google-Smtp-Source: ABdhPJxsqkE9jWOWOC/tJ2Hi/Xh6HcFgqG9qYLwvHReUB1czigHlcMxeOYCN1bAEmyVC4V23Wp7USzyAO3GYq3M2ZgM=
X-Received: by 2002:a17:906:4a0a:: with SMTP id w10mr5681697eju.371.1627062266496;
 Fri, 23 Jul 2021 10:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <a763a7d15b8e92dec61c1fa328ecb647b6f61682.1626901619.git.gitgitgadget@gmail.com>
 <CABPp-BF-UVZKWmsohjCzRLpbHZii+1g=SShEYg_cwScsOHi=5g@mail.gmail.com>
In-Reply-To: <CABPp-BF-UVZKWmsohjCzRLpbHZii+1g=SShEYg_cwScsOHi=5g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Jul 2021 13:44:15 -0400
Message-ID: <CAPig+cQwxXGmN=exrr9YN174LXDuHU2yH847uOCzQQKsTEVWtg@mail.gmail.com>
Subject: Re: [PATCH 1/5] t1092: test merge conflicts outside cone
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 1:34 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > +               for side in left right
> > +               do
> > +                       git checkout -b merge-$side base &&
> > +                       echo $side >>deep/deeper2/a &&
> > +                       echo $side >>folder1/a &&
> > +                       echo $side >>folder2/a &&
> > +                       git add . &&
> > +                       git commit -m "$side" || return 1
>
> Why is this "|| return 1" here?
>
> It looks like there are a number of other cases of this in the file
> too, which I must have overlooked previously, because I don't
> understand any of them.

A shell for-loop won't automatically terminate just because some
command in its body fails. Instead it will run to completion and
return the status of the last command of the last iteration, which may
not be the iteration which failed, thus a failure can be hidden.
Therefore, we need to proactively stop the loop iteration _and_ ensure
that the return status of the loop itself reflects the failure, which
we do by `|| return 1`. (If this loop was inside a subshell, we'd use
`|| exit 1` instead.)
