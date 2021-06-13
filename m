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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2336EC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C58610C9
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhFMDOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 23:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMDOo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 23:14:44 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE887C061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 20:12:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso7327518otu.10
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 20:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=PcO2kRR3cT2EUrMjRQTejyIhhyrCDf69Cuem7diTic0=;
        b=sLUfBFyh6hZ9jshmc2nrCh/ibjAcYDH/THc7yTqxe6u95wiIO+HNEmSwaSbAx52HOF
         DsZ8G/CCBm4CN0Sk9bXju7pv17FH3qqmwneyhUfjLBNAyuElNrNM89WOfeFeQOTuH4by
         dAKARNfg5zJnAvvEQi+uXmeKbyLV/wBdDAMfGrUaFiD0N4/5fJip4XlO1Y7dlhuN1/zg
         jF2egDfOnvQz3CfURmfmNL19J7voxuOUqZNqofzKywDZ39LxL+cv3tefMgf4HJgtPxi8
         zWBowziedr57xBssIXgM2zeopkMJcfNCpstNg9UbZXzFdlu2smzawgv0yk69w3RVC6xF
         6ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=PcO2kRR3cT2EUrMjRQTejyIhhyrCDf69Cuem7diTic0=;
        b=Rm5MbVyWQVjKe+B3xv7SC4ZsZhPxpMHDq+0rRuRzCBfHRoGerFO3Yuh/B4cJ2FpQek
         l+gbJa+oTZpq4Z62DCoIj/uJ2uRCtp98vPcgIPEVcoqq2XWtF+L9CayGSNpNFnEnTHts
         9aJ4d0f8zevWZjczvmVNuAaM3QfV04AjevcXqX3coF91hwSnESHCps3XNqpGhJLIgLw0
         iE0bpUp2dPJRhWchthFbqrz1zDzQHmNi206VY5+CwYuXqqavC/WNBDmY26sQL3YQXBJ2
         YXhw0bj4W/clf2u7dmzvz+Vc2pu8oypWQczoWaH7oAVAWakX3XYDI43cgt8VbvSoGKlz
         1dFQ==
X-Gm-Message-State: AOAM5333l9XKYyMbAD4lZj7iPxE3X7dLeQLt08HD0W/i25UR0z878fRk
        XyRjuR3WxkWD/9Go60SC3qc=
X-Google-Smtp-Source: ABdhPJz2quoD8/SnvZNmKBZOAwcv9H3uJK9pDkUCYpNeBs0ggGlH//zl21sCIwD/hGeG8MEAFqZMYg==
X-Received: by 2002:a9d:82e:: with SMTP id 43mr8945415oty.364.1623553963238;
        Sat, 12 Jun 2021 20:12:43 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l2sm2398889otn.32.2021.06.12.20.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 20:12:42 -0700 (PDT)
Date:   Sat, 12 Jun 2021 22:12:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60c577a9a1a71_3c23a208ed@natae.notmuch>
In-Reply-To: <4067f10f-067f-6475-8305-2e10631388c6@gmail.com>
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
 <4067f10f-067f-6475-8305-2e10631388c6@gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 13/06/21 07.44, Felipe Contreras wrote:
> > The original explanation didn't seem clear enough to some people.
> > 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >   Documentation/revisions.txt | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > index f5f17b65a1..d8cf512686 100644
> > --- a/Documentation/revisions.txt
> > +++ b/Documentation/revisions.txt
> > @@ -299,22 +299,22 @@ empty range that is both reachable and unreachable from HEAD.
> >   
> >   Commands that are specifically designed to take two distinct ranges
> >   (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
> > -they are exceptions.  Unless otherwise noted, all "git" commands
> > +they are exceptions.  Unless otherwise noted, all git commands
> >   that operate on a set of commits work on a single revision range.
> > -In other words, writing two "two-dot range notation" next to each
> > -other, e.g.
> >   
> > -    $ git log A..B C..D
> > +For example, if you have a linear history like this:
> >   
> > -does *not* specify two revision ranges for most commands.  Instead
> > -it will name a single connected set of commits, i.e. those that are
> > -reachable from either B or D but are reachable from neither A or C.
> > -In a linear history like this:
> > +    ---A---B---C---D---E---F
> >   
> > -    ---A---B---o---o---C---D
> > +Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
> > +commits, but doing A..F B..E will not retrieve two revision ranges
> > +totalling 8 commits. Instead the starting point A gets overriden by B,
> > +and the ending point of E by F, effectively becoming B..F, a single
> > +revision range.
> 
> AFAIK, A..F means all commits from A to F. But in case of branched 
> history like
> 
>      ---A---B---C---G---H---I <- main
>                 \
>                  ---D---E---F <- mybranch
> 
> the notation main..mybranch means all commits that are reachable from 
> mybranch but not from main, but the opposite (mybranch..main) means the 
> opposite!
> 
> So basically the right-hand side of two dot notation specifies from what 
> commit I want to select the range, and the left-hand side specifies the 
> commit which I don't want to reach.

Yes, `A..F` is the same as `^A F`.

-- 
Felipe Contreras
