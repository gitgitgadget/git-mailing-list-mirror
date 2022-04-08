Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8EBC433FE
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 12:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiDHMZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiDHMY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 08:24:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CAC3AA78
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 05:22:55 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t21so8598131oie.11
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1HpKlojwi/Rtb/IMuOT7lyXcWAwaZAcuT7BeS2CWLc=;
        b=JiNjP/GCcAU1UVs3n8VpnV4/Dig1lmadjEb92FLSNTpYL9vVqPaCWrIXGdpzXHj4i4
         U+KjZlCpLpCpCVtidX6E/bQClt/Zp+Ez2u5yv8X+HNzPMyst1Htke3pK77yy2yY9x2p2
         aZTeEDwzjWYHd7LmVrY83HaDe4waWNmwgC3o9BJh9pOEhGqVBvsbMNgljIOyxZv1UP33
         6rVXlpPgtAiY1WJh2nkcivdRU8MwH5jQ1CyTp910yKut8xczDRpBT201OQD75yDaqsAL
         PdXYiKANK1pArpAYKQwFjRu83SYRL13aa0VzcRZ3kEg9Doy0ojH7PCbD4QZ3IMyXWEnQ
         O5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1HpKlojwi/Rtb/IMuOT7lyXcWAwaZAcuT7BeS2CWLc=;
        b=W+aLVD7eeh256AMosOONWJdC6UxsGOHfnlCFOBzrbmWObwa0c8n62nk8opLkcskKe1
         nyGYw2NYR9lu/6BLvVxS5yYC9eMHRBdNFK4u/GIRU8XgbS5WK1puyUsvWyWJGhhEsLbN
         A7gQPjC6wyMKUbA2UHn+h28zErXpHUR2BYimzeZoNlANq/ZulawWxfUjE13cv1SNn0IC
         w/eV8zSmFMDNQx3/nWnKiAOPwmiSS0iZ88tm7yBINuq3tQAZ0G+BXM/EgwY/FVn53hnT
         P0KCid3Cb+GY0ukjbfqf6AYACciNyzUldTeNwMqlqrOCxoePFx2LR03jg8wHg+A3H2pd
         cLpg==
X-Gm-Message-State: AOAM531hlK3nX0bsNtDAtFk9YRqqdJsxabtfgthLyTXCdqc6UPTW0BrN
        UhUTtxave/LZ2zuZhMR+zHRNgb4M5SBYBb6OKt8o+CrcfpnflQ==
X-Google-Smtp-Source: ABdhPJwIZQPfEyddPoMa+TSNctWoAnKHNhcsTce1lG89NL+cz4Pv9yyYzGY88fYnk1QmbJKl8SHlfmz9GHRE235lC1c=
X-Received: by 2002:a54:410b:0:b0:2d9:ddf4:2ea with SMTP id
 l11-20020a54410b000000b002d9ddf402eamr7752223oic.280.1649420574868; Fri, 08
 Apr 2022 05:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 8 Apr 2022 20:22:42 +0800
Message-ID: <CAJyCBOQz-ns2hHUQ-Kg-UOMfutV7H=MbQMcdO_=oxYKrXfjzjA@mail.gmail.com>
Subject: Re: [WIP v1 0/4] mv: fix out-of-cone file/directory move logic
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 31, 2022 at 5:20 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> Before integrating 'mv' with sparse-index, I still find some possibly buggy
> UX when 'mv' is interacting with 'sparse-checkout'.
>
> So I kept sparse-index off in order to sort things out without a sparse index.
> We can proceed to integrate with sparse-index once these changes are solid.
>
> Note that this patch is tentative, and still have known glitches, but it
> illustrates a general approach that I intended to harmonize 'mv'
> with 'sparse-checkout'.
>
> Shaoxuan Yuan (4):
>   mv: check if out-of-cone file exists in index with SKIP_WORKTREE bit
>   mv: add check_dir_in_index() and solve general dir check issue
>   mv: add advise_to_reapply hint for moving file into cone
>   t7002: add tests for moving out-of-cone file/directory
>
>  builtin/mv.c                  | 76 ++++++++++++++++++++++++++++++++---
>  t/t7002-mv-sparse-checkout.sh | 72 +++++++++++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 6 deletions(-)
>
>
> base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
> --
> 2.35.1
>

Hi, to whom it may concern,

I'm writing to say that I'm making useful (possibly) progress on this topic.

I've been busy composing a GSoC proposal last week, so the progress
paused for a while. And I'm going to have a trip for around a week, starting
next week, so I may not have enough time next week to push forward on
this topic.

But I will always be available through email ;-)


--
Thanks & Regards,
Shaoxuan
