Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C240C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245195AbiBPA5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:57:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiBPA5W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:57:22 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936D9D073
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:57:10 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso960295pjj.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUe5JNFmeTZ72N4b+tS8yAn1Wbka7V6XnszNlhr9gd4=;
        b=ZHpqZXdQyXT3f9koZsN4slJlDjhmLq5czChKZek+if1dL/BFdI8NkI8gWXiXgo8YGV
         e+zGYBMI6UT2I03P3REm0yHtZ2SBpMH1Z5NvKtzGDJVM4qoHGt7Y5LPf3irwio7eJkwI
         6Z8wz8+5Fwfn5AO6gfPXf0wouXYNpHDCxtGn1r66/MU7o74BzkKWfhFrDjJmG0rYVAV2
         PkHxEjuXRAb7BV8aJbIpsKPtDRGw+lGsGKtOitMBaMJEnYtoqjvFRLcpN2ykyky1CJYR
         LJqju3lMldgJMAxhay1pfub70zyj48zQ9aZqND7lE8AzvQeoL1d+N2sYdYGobMExVTcf
         NZWA==
X-Gm-Message-State: AOAM532lIQUE1zhFC3sVtcVQpn09zd8YBK/GRCJcpK3vDeXbAZ2Z0KOO
        gjB3pXTgZfEFaBhH71ny1vMAUAtft2iQ2wHFby4=
X-Google-Smtp-Source: ABdhPJy5OU/YCcHj2lVqBUdQlaCB0G7i20GiCI1oN+q0EjuTie4iWjOKLWlDefiCis412LIe4ElhVqeFBmjX5lgVEoI=
X-Received: by 2002:a17:902:ccc2:: with SMTP id z2mr1636241ple.145.1644973029924;
 Tue, 15 Feb 2022 16:57:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <CABPp-BG4m6i+yobjnD6UC5S5n3k-HbB7Y5uUNEvrD79ErOoYHg@mail.gmail.com>
 <CAPig+cT7GwyhPOBdqDDh8jGm+mWK1x9Gt4Zebcw34dgFyaufkw@mail.gmail.com>
 <CABPp-BGZoGwpMaqo2px1SqOBk1xLHtwkkBBAaqU5sNfTvKD1og@mail.gmail.com> <CAPig+cQWnuG+-eWyih7-Q75PeFjQRHN58SWWhFQWHU2=R6GfyA@mail.gmail.com>
In-Reply-To: <CAPig+cQWnuG+-eWyih7-Q75PeFjQRHN58SWWhFQWHU2=R6GfyA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 19:56:58 -0500
Message-ID: <CAPig+cQTRGuuspz2g5LZr4Oh8bQCr4FUDV0tirs+ZPwhtAaJVw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 8, 2022 at 12:42 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Feb 8, 2022 at 12:18 AM Elijah Newren <newren@gmail.com> wrote:
> > So, you clearly also read the patches in this round.  Do they also
> > look good to you?   :-)
>
> I have not yet looked at either the patches or the range-diff, and I
> only scanned my eye quickly over the cover letter, but the empty
> bullet point made me stop and look a bit more carefully at that part
> (and only that part) of the cover letter. Not sure yet when I'll have
> time to carefully read this round.

I've now read through the series and, I think, left only one or two
minor not-actionable comments.
