Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5450C43217
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKOSHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiKOSGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:06:48 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D098413F7F
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:06:46 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id x16so7804345ilm.5
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7njmfg1SJPbgqPXJ/RdJYFMwMzn2D41/jrpZ680Wtk=;
        b=Pwbeu5dM3fTM+qug8RKLF9SK2SjTOG20lpqv+dSixHtrV4Mi/YXErSBOrfHeCl6GQE
         7Svr0JTuwSSjxb44P76OudbeGinDlTnRUCY5BKmQqGuI/ZKYJYtFpbChiRwWNRq2FaMO
         PAts3G2jMb2hEvUDy3NsIHX2zhQeXhdOUgFZmNz2hfX/YMKbUmL05F1C3MSCTqs+5nvK
         Wz2UDNi/1i3fV/pwLPqoI4ItGpl7BpwkSI8bim9jkDdEeoZmTV1rxclWSHnW80ZUkpOE
         tmgHh2liUXEwvpJZFvaC1JDrJ8601XSwvddY08ymsZiAewATW6x6pfw+kxAK8O+bF6h0
         vgRA==
X-Gm-Message-State: ANoB5plEysqQ6YZBKG07zLb2Nt19Tow0EYgjrT4ubPO73tVpRf44gUw9
        7rgvf2i0AHzdx9AptQAp6TTYTrHYzK43gusaZG8/vhR9Cq4=
X-Google-Smtp-Source: AA0mqf7sXTKe8dtYvpAshAvUaZ3M/E9y6+LDAHXwiWvoC3/K0bUb1DWcgv7ZTS86iVsJVUkSZmOGYfzSIO8sYvQx4fA=
X-Received: by 2002:a92:2612:0:b0:302:557a:dba7 with SMTP id
 n18-20020a922612000000b00302557adba7mr6145644ile.249.1668535606089; Tue, 15
 Nov 2022 10:06:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
 <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com> <CAPig+cTO3NPg_Kx3dZhFMEtbMe9hRvaumZYxMnSJRyXqUA=p0g@mail.gmail.com>
 <CANaDLW+Ec0kY4AW5dGvnCaHgcvFOZQZO5EAi595KbVKj7KDg3g@mail.gmail.com>
In-Reply-To: <CANaDLW+Ec0kY4AW5dGvnCaHgcvFOZQZO5EAi595KbVKj7KDg3g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Nov 2022 13:06:34 -0500
Message-ID: <CAPig+cT2+nitwD64FzG=6FvO7eUn3q-cq_CmmYeOXxOMyzvUnw@mail.gmail.com>
Subject: Re: [PATCH v5] status: long status advice adapted to recent capabilities
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 12:46 PM Rudy Rigot <rudy.rigot@gmail.com> wrote:
> Thanks for the feedback, and I'll integrate it into a new patch, most
> likely today.

Thanks. I think this is _almost_ there; much more polished than
earlier iterations. Hopefully, one final reroll will make it complete.

> > To what does "this" refer? Is it this repository? Or something else?
>
> Hah, good point. The accurate answer is "the status of currently
> existing files is being cached, and we'll watch what files changed
> after now so we only run things on those next time". Obviously that
> would be too verbose for the inexperienced user hitting this, really
> this line is here to convey "if you run it again, it's probably going
> to be faster".
>
> Here are some ideas:
> - "but this result is currently being cached."
> - "but git status results are currently being cached." (true but not
> perfectly accurate since index updates don't only happen on git
> status)
> - "but untracked files are currently being cached." (not completely
> accurate, I believe the index is updated for all files; the untracked
> files are only the interesting ones for this specific performance
> consideration)
> - "but the results were cached, and your next runs may be faster."
>
> I could use some guidance on what would make most sense here. I
> strongly feel like the user should know of it since that's been what's
> been confusing the users of our very large repo specifically when
> their git status is temporarily slow; but I don't have any opinions at
> all about the right phrasing. For now, I'm planning to use the latter
> bullet point in my next patch because it's the most explicit, but I'd
> be glad to apply someone else's take on this instead.

Reading the proposals while wearing the hat of someone who has never
had to deal with speeding up untracked-file bookkeeping and who may
not even know that remedies are available (as discussed in the
documentation), I find that the first three bullet points convey no
meaning at all; they leave the reader hanging. The final bullet point,
on the other hand, tells the user something conclusive. I _very_ much
prefer the final proposal.

(In "but the results were cached, and your next runs may be faster.",
I might suggest dropping "your" -- i.e. "... and subsequent runs may
be faster".)
