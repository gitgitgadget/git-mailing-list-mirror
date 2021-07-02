Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D561EC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B891C6141C
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhGBKtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhGBKtF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:49:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8AC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:46:32 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t80so10828908oie.8
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=f7uFxhAEj5ZZFJPL6Ryjk8Nl1+FP7pVmiISmNIzcqCM=;
        b=X2BwIsQVGPLQRGyiwwRI6GX4R1U3d/wtqIaOYTvlgcQqz4Gc9TLNKqJzR0t6Ozxy2x
         CSnrOq93B8moAslvoUfj0yrRcYzfTuPZ3l8aYfo3CEYxKsZ7uPtHfA29rbT/huciwm52
         Gilf2Ql/fYWnd0a6TZ2KG49gXTk+G9WXKHUQQ1nZm+Rn5Zwgucr97zsvYrQ5QC56cHN0
         gI8DA09mlr+dTkxYfRKcyspTscfTe1Ovb7W7GBvx3jhp0VuawksPYMLnPS1P+W8K4Zb4
         T+qYXcPt3WwJXGJdyaL1fpq8awZT8cg+4EO+wnwUCALtR/I1XUHGYNfRrNAj4H2HnZF1
         5Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=f7uFxhAEj5ZZFJPL6Ryjk8Nl1+FP7pVmiISmNIzcqCM=;
        b=htsF75OelYY3hl7OTYQrahoLSK5q0iGLEcGahZ54KdTVP/L1HWsAMT8lYNN2xmYfdl
         HFO2oWcZGYA+vhfCkQy0I11yzx+A9DRVDoSo2Gg8v8lE96L64qNxDDVxsQmhssJEZT7O
         ttK1m4H9R50hw8HHHf2w7cxmq5MH2Q3DjW1U4/e38ZwqezTHu01Jw+no5ADpVYXG62Cn
         vpV5LLioR4tVzfAzh0YQxMh8QSDCns5VujEiImlbLS2N4nhnkVnC6TkJdZfBdF1CwuoP
         2UjgE/rTef1B0XwAnIyP8d2mLk4IP0RzYKAOzJG4iIzCxBZXu70f4GHPWRym1kTj256l
         oGmA==
X-Gm-Message-State: AOAM5327j0epgnMcspXGIAREnj+OQuWz65Lt4jQflK+HKFqZEaVxyqNq
        GyfRJm5Mi3S4eLaX/baQqIg=
X-Google-Smtp-Source: ABdhPJzI4YsOwSqiNN/5VzeUQ/6d5R18q21N6rmwESJM4iikFpnB4UE7ESDdN6CqYN1SF3O72m0FYw==
X-Received: by 2002:aca:e142:: with SMTP id y63mr3365034oig.57.1625222791670;
        Fri, 02 Jul 2021 03:46:31 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 5sm533793oot.29.2021.07.02.03.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:46:31 -0700 (PDT)
Date:   Fri, 02 Jul 2021 05:46:29 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60deee85f2786_744208cb@natae.notmuch>
In-Reply-To: <87wnq99fdd.fsf@igel.home>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <87wnq99fdd.fsf@igel.home>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab wrote:
> On Jul 02 2021, Felipe Contreras wrote:
> 
> > Andreas Schwab wrote:
> >> On Jul 02 2021, Felipe Contreras wrote:
> >> 
> >> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> >> > index 340c5fbb48..32b1fdba45 100644
> >> > --- a/Documentation/git-commit.txt
> >> > +++ b/Documentation/git-commit.txt
> >> > @@ -17,6 +17,10 @@ SYNOPSIS
> >> >  	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
> >> >  	   [--] [<pathspec>...]
> >> >  
> >> > +ALIAS
> >> > +~~~~~
> >> > +'git co'
> >> 
> >> That's `checkout' in hg, bzr, svn and cvs.
> >
> > I know, and commit is ci in many of them.
> 
> What's the point of making git different if the goal is to make it
> similar?

The goal is not to make git identical to every other SCM; it's to take
the best ideas (not all of them).

> Everyone will associate co with checkout.

I don't think so. Fortunately there's other people in the mailing list
that can opine.

-- 
Felipe Contreras
