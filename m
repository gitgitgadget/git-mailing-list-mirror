Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B49C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 02:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbhLNCjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 21:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNCjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 21:39:22 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E41C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 18:39:22 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so57894540edd.13
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 18:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpEnsosslw6+457CuakGMchlMGVOWCQxrm0zSl0DFCg=;
        b=SdweIAJZjckCNOAdo4RKU8r672P+uyoc+l7Nt9j/yr55EI2+RNKVn23fnlxzoS7azB
         FkzoVPGEsHXeWgQjLcmBIMA9rTnV14FVz5AWxOwhdDHU1xKwz6xOij20jrDwZvq2JYR4
         Tw02gEzF25RqS9ONvkLerE9SJjdbzsH/+UNfkJCM1shjtxGr3aimn3bccyBKcYI/1jpw
         XCmb2CyQFoqrobIR6n7gfEnChpbVZ+Vxby+7ORY3Tad5OiVlQIBGmoKkYCB8rEKelfNH
         Ga4K1Bcq86I73xuD3+WFzeafKaxbshsECMzzEf2Ufi9n9gPf3cEZsf5yk2RNbRJtOc+6
         pPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpEnsosslw6+457CuakGMchlMGVOWCQxrm0zSl0DFCg=;
        b=jC12Hr4pWnVBhVSZ5S0hCOvfGUbjNpFQKfV/gdbWwcScTQXPJCcItgMjVqCbuT7Eln
         VY78PO7zZnTiFDFKGPB21uytk8v518lzLTNqe2FF8GJm6EkNs4XATBNbWlzC8k3006vM
         8VKfrP/nqW9mdRjwT4i4eTMEAdj71bXhytDnQsVxg+yPrb7RdwgqWmqcmbyZqPs6IJk3
         A/4BvLEDE98XIo4x2aFrFKM3OaB66tE0dOYUE8TXxtZKXgsjTt28hXVQu3eAdKiJRXte
         0QX3ibO1yJycgsUxCdN1zXK8d8ODbvt1TXBCFiXPLGI/z1u6i8l4CbMB3PJydJaOgh+t
         T3hg==
X-Gm-Message-State: AOAM531zo30EOp5g3D3+MzjtzG5Fz0Ytltk+YxVM8wLXVYoxL37ioYA2
        hM11whCkvyU82hALY9FqMJhV11H1SXziOYXZTIahPZ6E
X-Google-Smtp-Source: ABdhPJxiAcjg3yY4Nx+6LdpDWgisV1njWzG7pwbtBHnsa+GPEGy8IElgJmOsUVYefMozmPURetLURF9l3kF4wVWuiH4=
X-Received: by 2002:a17:907:2d11:: with SMTP id gs17mr2751428ejc.100.1639449560964;
 Mon, 13 Dec 2021 18:39:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
 <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com> <3687637915f4fdf62d15791f5cf41f9ea7838f4e.1639108573.git.gitgitgadget@gmail.com>
 <xmqq1r2ge53u.fsf@gitster.g>
In-Reply-To: <xmqq1r2ge53u.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Dec 2021 18:39:09 -0800
Message-ID: <CABPp-BGq5-_84=hXqpxg5A7syauXYK_MBzgSY989d3KmR4rn-g@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 10:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Folks may want to switch to or from cone mode, or to or from a
> > sparse-index without changing their sparsity paths.  Allow them to do so
> > using the reapply command.
>
> Interesting.
>
> Are there certain pattern that would make sense only in one of the
> modes but not the other?  If there isn't any such pattern, this
> feature perfectly makes sense, I would think.

Good question.

Valid cone mode patterns are a strict subset of the possible sparsity
patterns.  So, switching from cone to non-cone mode trivially makes
sense.  Understanding why switching in the other direction is okay
takes a bit more understanding...

Stolee designed cone mode such that when it's active, and someone
edits .git/info/sparse-checkout and adds patterns of their own (which
users might do because that had been suggested for several years in
the read-tree docs -- and still is), then the code will print a
warning ("disabling cone pattern matching") and operate in non-cone
mode.  As such, the sparsity does not "break" when they switch modes
if they have non-cone patterns; they'll just get warnings.

Further, we're making `reapply` consistent with `init` here.  Stolee
made `init` usable for switching modes in an active sparse-checkout
(though it wasn't well documented, and it's slightly confusing to
users who might worry that they'll lose their sparsity patterns by
using `init`).  We're just copying that ability from `init` over in
`reapply`, and recommending using the latter rather than the former.

> If an existing pattern changes its meaning between the old mode and
> the new mode, that is very much fine---that is what the user wanted
> to achieve by switching between the modes with "reapply".
>
> Thanks.
