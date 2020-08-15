Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CACBC433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3759C204FD
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyknWPJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgHOVzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbgHOVwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C0C061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 17:29:57 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id p8so5528073vsm.12
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 17:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVgccJefpk9GHbxqI+D4Sy62Umoj3LkxCOVnmIUJHn0=;
        b=oyknWPJuAAvn+3+ha27t++idLig+cYwjqeq4odmS3h7PijUh8xfJvPulVVx6w01dDS
         ppeg+l/B/eyiC9qcmMCzCKfkY8tfA40qBEf8NXo762wMcdiLyU9rIDY32vTaCRx+OXdC
         HBUT39vvp+vipoD///Mi8Ne/ozZZi5k2nbhgYsgcgRk+DOUI37RVerj+e0ON6C/pidgv
         y6BvoOBT4tUE4hFM19rMYAUJu0xlNJsaWhoNnAqcYB8O2Nt+FRF+bOy22SLhawwB9jtr
         CTMfRUeWfVFG6xVQHQTR9pUZdaSO1YL80+PBp8NPeZfta2HSXICyAG+Xm3SuZiE2BomK
         pTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVgccJefpk9GHbxqI+D4Sy62Umoj3LkxCOVnmIUJHn0=;
        b=HmEvJ1AMjwIN1r7MKmrJ7BnORU8Wm/PwQsryYznvaq4N1OQOK82AQqzkoREpfH3mXz
         neYoS3B4+WN+ZtF9WjBswAUNgyTyqAA0NRfV7iA/c5t9dIS1olsPSuaeOsRfKgsNjRic
         0wOexV8rBuWsek6EXcqa8wQfzmsihGlgu3TcvPTTluASIji/hTU6jhQgKdU6GOMB9Efr
         hj0zyqtESZ46Ey9YCc6p+6GCOPghikgXF7qvgnrhK8qi7yyjeWXFZMXimEV3IcWquZxq
         clVtxdRi57OHotmH6TsKIa1pTuXAGzCNt+JxpDZsl9hbw/LLyfnyqZVW5W2aRn9sB0Ok
         XJrA==
X-Gm-Message-State: AOAM5322W43aMlVmDDlxzaRH/ZParSltZVa0C3M05qySJbzqp2lwjSNZ
        CRSZ01bBxAomo/sIjtlf+GKd3AWfEn87fgMmDLw=
X-Google-Smtp-Source: ABdhPJy/mil7A3TPz07iRiGNcBObGDseVbon0cPeCt6DuuT672uzIkF6F3feA7R7qPHi2wGLIsQLymtUDnSsKQZdtIs=
X-Received: by 2002:a67:7d8b:: with SMTP id y133mr3343583vsc.87.1597451396402;
 Fri, 14 Aug 2020 17:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002831.2468968-1-jacob.e.keller@intel.com>
In-Reply-To: <20200815002831.2468968-1-jacob.e.keller@intel.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 14 Aug 2020 17:29:45 -0700
Message-ID: <CA+P7+xoDckBukFF9MnkhmWDdJxEcCZK5jg6HJcBbPcXB70xOUQ@mail.gmail.com>
Subject: Re: [RFC 0/3] support negative refspecs
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 5:28 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> From: Jacob Keller <jacob.keller@gmail.com>
>
> This is more or less just a port of what Peff already had published a few
> years ago at https://lore.kernel.org/git/20140125013433.GA22336@sigill.intra.peff.net/
>
> I cleaned some things up and made sure the tests pass, but haven't yet added
> any new tests.
>
> I think the overal design makes sense: applying positive first and then
> negative. This appears to be how negative pathspecs work at least as far as
> I could tell with a few trials.
>
> The first two patches are cleanup/fixups that I think could go separately if
> everyone agrees. The third is the meat of the idea, and where most of the
> work needs to be done.
>
> Jacob Keller (3):
>   refspec: fix documentation referring to refspec_item
>   refspec: make sure stack refspec_item variables are zeroed
>   refspec: add support for negative refspecs
>
>  builtin/fetch.c  |  3 +++
>  builtin/remote.c |  1 +
>  refspec.c        | 30 +++++++++++++++++++++++++++++
>  refspec.h        | 29 +++++++++++++++-------------
>  remote.c         | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
>  remote.h         |  9 ++++++++-
>  transport.c      |  1 +
>  7 files changed, 107 insertions(+), 15 deletions(-)
>
>
> base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
> --
> 2.28.0.163.g6104cc2f0b60
>

This probably doesn't have the right reply headers, because I forgot
to send the cover letter along with the patches and realized it after
I hit send. Sorry!

Thanks,
Jake
