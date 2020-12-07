Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4468BC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F67723888
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgLGSTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLGSTy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:19:54 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D4C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 10:19:14 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id u3so10253877pfm.22
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 10:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EvooqO6NGLwT7mPvAcGcsRhGiMiEyYcVnqeoIS/SyFg=;
        b=iMjvuxM+QaLKHkYSXHxe4F5cY/cVKP2WL4qvl1AB+va0+52jvaNfzFbfxaMRBywGw0
         TCzMl4D8gmseHDlJhwUCyEvZSM3g1g5FTAbFGewr58yzVwHuz22YyztdhBugUZis1wkj
         FEY5G2SS+0+TYbHuKYeCDB0KWT710Is17cWpVH5jiO7xrZZ/K/PjQf9o9uksk/835Z3C
         0GjoWIFq0ZAmMEszgUnHqyc/V/A/rdT/K4Nr3NpeisNYJ2d0g8jZ3Y4UNHdYJQTB4dRS
         gGRJevaKZMOXlz+Ja0u4GFGwq5oKQD036MmkLxU1Lwf5InFC5EHIC4gqgBWbO0kYhRXd
         qdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EvooqO6NGLwT7mPvAcGcsRhGiMiEyYcVnqeoIS/SyFg=;
        b=X4mfMrSpDfB50h5Kv0lVyb3NVc0hZpCiX87IL3tIsp1zzeUwNwdjxTy65Nl3dFPZ+c
         6xhsdzV4BwxEhHpmE9O10IbzioFtAALFNOVyzbHc+CZpkjeOfUv5MarGTs43bnKBL7FF
         pUXh0kHAH/75oCX3ua8gSgKyr/sCJzp0K2eV4Ht2kr6/dZrFjVb+u9CXEzNUVVc3fa+G
         /wXpozb3tPml9PRSKtUI2WJ/iQu/ei4VB7oztuZBul+5tc9uHuWEdLAsnGeyrEx8bHkX
         s8xvM9UFAjibLnxFbflCE2dufZd6BaTuATm6GmF81eXXhqQOP5YrG9n501XFCiiZ1e3q
         hytA==
X-Gm-Message-State: AOAM5300jcXbt5x9HGqFk5yePmSx/vUoA4I8zIWNf8LBdXBsmj8Z5pG+
        MXT34tlh/YXi5O6iju557kNAsL+bMHE4RU7wTibV
X-Google-Smtp-Source: ABdhPJxejWDpahzL6k5xcIwWDBvywPJpuCyHVX2v6Cvb/7ahCtGEdGjPzHiPViGwMc8S7CuKG2i/t8aKuom8nZd2KJj+
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:460a:: with SMTP id
 w10mr81117pjg.1.1607365153329; Mon, 07 Dec 2020 10:19:13 -0800 (PST)
Date:   Mon,  7 Dec 2020 10:19:09 -0800
In-Reply-To: <X8fBHz2A82hxUzV8@nand.local>
Message-Id: <20201207181909.3032039-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X8fBHz2A82hxUzV8@nand.local>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: Re: [PATCH v2 23/24] pack-bitmap-write: relax unique rewalk condition
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > In an effort to discover a happy medium, this change reduces the walk
> > > for intermediate commits to only the first-parent history. This focuses
> > > the walk on how the histories converge, which still has significant
> > > reduction in repeat object walks. It is still possible to create
> > > quadratic behavior in this version, but it is probably less likely in
> > > realistic data shapes.
> >
> > Would this work? I agree that the width of the commit bitmasks would go
> > down (and there would also be fewer commit bitmasks generated, further
> > increasing the memory savings). But intuitively, if there is a commit
> > that is selected and only accessible through non-1st-parent links, then
> > any bitmaps generated for it cannot be contributed to its descendants
> > (since there was no descendant-to-ancestor walk that could reach it in
> > order to form the reverse edge).
> 
> s/bitmaps/bitmasks. 

I do mean bitmaps there - bitmasks are contributed to parents, but
bitmaps are contributed to descendants, if I remember correctly.

> We'll select commits independent of their first
> parent histories, and so in the situation that you're describing, if C
> reaches A only through non-1st-parent history, then A's bitmask will not
> contain the bits from C.

C is the descendant and A is the ancestor. Yes, A's bitmask will not
contain the bits from C.

> But when generating the reachability bitmap for C, we'll still find that
> we've generated a bitmap for A, and we can copy its bits directly. 

Here is my contention - this can happen only if there is a reverse edge
from A to C, as far as I can tell, but such a reverse edge has not been
formed.

> If
> this differs from an ancestor P that _is_ in the first-parent history,
> then P pushed its bits to C before calling fill_bitmap_commit() through
> the reverse edges.
> 
> > > Here is some data taken on a fresh clone of the kernel:
> > >
> > >              |   runtime (sec)    |   peak heap (GB)   |
> > >              |                    |                    |
> > >              |   from  |   with   |   from  |   with   |
> > >              | scratch | existing | scratch | existing |
> > >   -----------+---------+----------+---------+-----------
> > >     original |  64.044 |   83.241 |   2.088 |    2.194 |
> > >   last patch |  44.811 |   27.828 |   2.289 |    2.358 |
> > >   this patch | 100.641 |   35.560 |   2.152 |    2.224 |
> >
> > Hmm...the jump from 44 to 100 seems rather large.
> 
> Indeed. It's ameliorated a little bit in the later patches. We are
> over-walking some objects (as in we are walking them multiple times),
> but the return we get is reducing the peak heap usage from what it was
> in the last patch.
> 
> In the "unfathomably large" category, this makes things tractable.

Quoting from the next patch [1]:

>              |   runtime (sec)    |   peak heap (GB)   |
>              |                    |                    |
>              |   from  |   with   |   from  |   with   |
>              | scratch | existing | scratch | existing |
>   -----------+---------+----------+---------+-----------
>   last patch | 100.641 |   35.560 |   2.152 |    2.224 |
>   this patch |  99.720 |   11.696 |   2.152 |    2.217 |

That is true, but it is not ameliorated much :-(

If you have steps to generate these timings, I would like to try
comparing the performance between all patches and all-except-23.

[1] https://lore.kernel.org/git/42399a1c2e52e1d055a2d0ad96af2ca4dce6b1a0.1605649533.git.me@ttaylorr.com/
