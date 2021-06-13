Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50443C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 04:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1530E611CC
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 04:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhFME2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 00:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhFME2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 00:28:06 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19DDC061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:25:58 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id d19so6547450oic.7
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jKNveA6MSN8bPHCpvlz3Zi0YYqOwVHbUVr7Ieu3IJeg=;
        b=T/cSJNALM9p4oDeGPb+meLKrioXF0GSgDfEoVmEt9yFnFugtLmangMcExCiLQTeSKM
         y3tzfKTl4qK/utaW24Am66G7UEZQxCG7eBd0xDnscwhn4icVThzXmDiOyhWzTHhXs0ct
         p0LjXtcX8XgCIMX4jRAmFmFIc+d8liQMj3L8bTMFBLgFVL1fx9vjb3oO87f0QYxaz2h4
         /BKSnbbCzAs30kNF6Z7VaTonTaBXmpP5q/xAZFwzASaaqEKTOrLhe19ljxTRwCdA0rqX
         l7/eSu6xiLCYXMdSIcHwZ52E0867ckJQnBuVgOQxRhFEZtcrizDLHb4oLNX1xPtJcrDE
         1DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jKNveA6MSN8bPHCpvlz3Zi0YYqOwVHbUVr7Ieu3IJeg=;
        b=jxQBCLp48I0dI7PqEDkX3Ki6sCACPNPpnYtp7I6pLjBedFWgyklbPeyu5O7t+eAlHH
         mPftWTXJOB4z8x5OoNsxPR5rykLmly2d23536TKFTts4HmI4y+PJFkSREbAKVuIhj2sQ
         w39yt2v4qc8IqXzt9ib9rpTNRE5pjqteebvM6yKeJMOD9jgOYip0EkqgcUIuVElndsfh
         3myVzqKEpKgXjOmjuj6OgEHVqm/DYm751oXGCwbnTcE6EJDu9qWb8NOTJZ2k2bw4KDQZ
         QpP/h0ADx4L43VI70apVVU4WJItu9Qc4E0SUmVvmlKI70xYyxuW5982L/vzke2H6XjwE
         xZiw==
X-Gm-Message-State: AOAM531irK/mHaQm7QnAfd8PGOMqSbbwWL55JPPJDCh6DL2xL1d8vDo8
        i5zubmDYZwYuByj7IsGPzUg=
X-Google-Smtp-Source: ABdhPJzFEu/lF94Q/Bwh0CmaZx6OD7yq3zt1xaj5LPb+3T2CwEAVTg7YkCWvgsBE3ECuEuiXmdL6tw==
X-Received: by 2002:a05:6808:1522:: with SMTP id u34mr6420952oiw.100.1623558358195;
        Sat, 12 Jun 2021 21:25:58 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x8sm2221089oiv.51.2021.06.12.21.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 21:25:57 -0700 (PDT)
Date:   Sat, 12 Jun 2021 23:25:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60c588d452750_3d86c2085c@natae.notmuch>
In-Reply-To: <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com>
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
 <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Sat, Jun 12, 2021 at 8:44 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > The original explanation didn't seem clear enough to some people.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > @@ -299,22 +299,22 @@ empty range that is both reachable and unreachable from HEAD.
> > +For example, if you have a linear history like this:
> >
> > +    ---A---B---C---D---E---F
> >
> > +Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
> > +commits, but doing A..F B..E will not retrieve two revision ranges
> > +totalling 8 commits. Instead the starting point A gets overriden by B,
> > +and the ending point of E by F, effectively becoming B..F, a single
> > +revision range.
> 
> s/overriden/overridden/
> 
> For what it's worth, as a person who is far from expert at revision
> ranges, I had to read this revised text five or six times and think
> about it quite a bit to understand what it is saying,

Can you explain why?

This is the context: commands don't generally take two ranges:

 1. Unless otherwise noted, all git commands that operate on a set of
    commits work on a single revision range.

 2. Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
    commits, but doing A..F B..E will not retrieve two revision ranges
    totalling 8 commits.

At this point what isn't clear? Isn't it clear that `A..F B..E` aren't
two revision ranges?

 3. Instead the starting point A gets overridden by B, and the ending
    point of E by F, effectively becoming B..F, a single revision range.

What isn't clear about that? A gets superseded by B because it's higher
in the graph. And if you do `git log D E F` it's clear that doing
`git log F` will get you the same thing, isn't it?

> Also, if this explanation is aimed at newcomers, then saying only
> "doing A..F will retrieve 5 commits" without actually saying _which_
> commits those are is perhaps not so helpful.

It doesn't matter which specific commits are retrieved, the only thing
that matters is that `X op Y` is not additive.

-- 
Felipe Contreras
