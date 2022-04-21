Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602A9C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 04:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384102AbiDUElw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 00:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDUElu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 00:41:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD112602
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 21:39:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq30so6575957lfb.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 21:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5BMnfN5daDuYl7/TsbMnQ4kFU7DVZqegjC3S+TRpsQ=;
        b=kO+oZcgybdjFDguk4ZNKbjohs3zcy3l2RCnasD2Uiiceub7Cz+Bikh2dxwwQBo4Ffq
         3zPdWZOvp9rY6CyVXuwdx/r1m1j20xcPZn9cUzmiR0PI4gTdXcQiXJoN6moMBG5VfydD
         Foh+X+xKJuo/bia8TBt2aku4HevqdbhpHVC0NTRaGEaF+cVohP1gWwT3+hHXHq7kJhmS
         ywcp4euVAcND6R+gSeAigu3h2C3dRlEMXOX5jSbRYQuqZtZYW92LYrvjF+EsxuWXBPa1
         IWPkDKn6BhlM+7sV4CHSKelKwrL2rWftz1fxadP5J3Fe6DAFCtjnQQH1V/Pip1keuXuZ
         uxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5BMnfN5daDuYl7/TsbMnQ4kFU7DVZqegjC3S+TRpsQ=;
        b=tz9tW1y4nTS/dUF3lpkvZd10A3RYgRsZIkpqrSqjmteTEuQiSRykf7cuZqhb7en4pW
         Pt0U72OsSuwdBH1pK42NkEyNOIGCgtE0xZ7WwjzuyrTDJ5NFJcBTCdu3Y4+jgjA9EutJ
         JvCdhZpwYJzgTtqqbnI0CT6B0MD/Pu0YZH1nwTEuWzXr2bNJPoA898aC89jh133CkXtI
         rCeAlNt5tSp5r7PY28OWEAKSdxN1YnLuRF24yGfrMychPOpZOumtFNg2A/fK+9XCweoo
         T1EyxCyGVT/kMhcM68pfyJeT62Y6+zAP/Tkb/a3Ku5dg1flXzL/IICKcvj4BhoCqBkXJ
         ToBw==
X-Gm-Message-State: AOAM53277qqZdZbxb6BsCuexeCVzFFUgN998m2uMyPZfqbVELXOxYjG+
        J9eoPvHTNrF1UZW+S/v3nRtF966/ilIgDH9dooY=
X-Google-Smtp-Source: ABdhPJwDm1X5qQFLikHCHzLwR6zxJ5JobY8A2UToHEbJ4jzEDGdEnV/+kOMR/T9HeJTFMFn7UwVxSnITyhj0hmUoj3A=
X-Received: by 2002:a05:6512:31c4:b0:471:9f60:d7f3 with SMTP id
 j4-20020a05651231c400b004719f60d7f3mr10680681lfe.141.1650515940317; Wed, 20
 Apr 2022 21:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220418012716.2683624-1-alexhenrie24@gmail.com> <xmqqh76no53x.fsf@gitster.g>
In-Reply-To: <xmqqh76no53x.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 20 Apr 2022 22:38:49 -0600
Message-ID: <CAMMLpeTLkg7=WwhpkpA53bQ5ucSPH3zTXRdhR7uj9OKA=7s=kw@mail.gmail.com>
Subject: Re: [PATCH] rebase: use correct base for --keep-base when a branch is given
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> It is surprising that a basic and trivial bug was with us forever.

I was also surprised. Like you, I dug through the mailing list
archives and my impression was that the code review was mostly
concerned about the case where there are multiple merge bases. No one
seemed to have read the man page closely enough to notice that 'git
rebase --keep-base <upstream> <branch>' cannot be equivalent to 'git
rebase --onto <upstream>... <upstream>' because the latter doesn't
have <branch> at all. Seeing that discrepancy is what prompted me to
try out what actually happens when the branch is specified on the
command line, and then I realized that it was more than just a
documentation error.

> > +test_expect_success 'rebase --keep-base main topic from main' '
> > +     git reset --hard &&
>
> Clearing whatever cruft the last test left is good, but ...
>
> > +     git checkout topic &&
> > +     git reset --hard G &&
> > +     git checkout main &&
>
> it would be more efficient to just do
>
>         git checkout main &&
>         git branch -f topic G &&
>
> no?  Instead of rewriting the working tree three times, you only
> need to do so once here.

Sure. I'll make that change.

-Alex
