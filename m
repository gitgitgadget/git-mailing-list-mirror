Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA9EC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7749861374
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhGBK5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhGBK52 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:57:28 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB6C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:54:56 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id x62-20020a4a41410000b029024fb8f731dfso1786752ooa.12
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OgwEXM0q2UMu2D9iicJtpLA4styTXU1+2zUjdGt0bZk=;
        b=dppXuz9feCjlZ+DkA6bB+JdJHby2HiZS0R9o427v8XO2jp3XucvP9YkWLylz5Rw+yY
         TPPECyArQz5TxgFgAZNxz4aOiodFnKRaAcmI9A57od8jCfqcdCnh2IAePGOl0bp3r3jD
         9hCao8zMxX7IWi3ZyTwV9NJpTByCinWRhMoytnuzPuJ+2Yxpz6cGpJjyG0INaT6l3MPu
         E4JpUZyFX8BUniLc6LcnGG/DsG9fWYnkDXIFKY/vi7svk+th1YDbARd8Zq1ckKJAaxFL
         f6GNKzOkC9xSFTXXRRdWlbALXmQWOHW7jcrQ1iND94bqaVE3cwicP9m8K65PhoI1COKZ
         dswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OgwEXM0q2UMu2D9iicJtpLA4styTXU1+2zUjdGt0bZk=;
        b=sReqXXbYfbL0jjpkoz59ERk6fAZu4w9p3lDl/696aoYQTdSq0u2SeqkUqFbGv/sd3w
         U816ArTRuIvhztSw/U2yDZs2/fyFlR3aK5Kg+TbDGZdlQY1JHPiK9KijlvMJqNfnXYD1
         SWXOSY+ryf6ZqgiSWsWUHjp7hRxjoC2p/cOE6L9o6bfrngbYkaz9fxF2xNYPX0C4haK9
         7Kymv5hgDkhrlMdYNaRTgM7ERh7inN/yz6tIKOvPMl6VH/u6Tw2GAxRVhI0SUGkaq0ub
         hU4EVgtt4kYYYQ4JKlLXZVmtX44PCWZPLmQ5VWHaDcHrFRiuy9I8OME4dCQ3xn/ae+xK
         xYQA==
X-Gm-Message-State: AOAM533eKdn5cwUbDnGl2zd5JBQ1/ZNBaNyHW/+nbAFkX6VGWcs96qcq
        Ijed/iDU6NEOUfp0x/NmI1M=
X-Google-Smtp-Source: ABdhPJyzoNfdnM2LOvSWsZlF9NNi/mOQVW7iSkaLz+5QOm1WaraGRlhp/onCDCLO8FgAP/YyTNju9g==
X-Received: by 2002:a4a:e1c5:: with SMTP id n5mr3842147oot.5.1625223296044;
        Fri, 02 Jul 2021 03:54:56 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l10sm538682oti.9.2021.07.02.03.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:54:55 -0700 (PDT)
Date:   Fri, 02 Jul 2021 05:54:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     martin <test2@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60def07e686c7_7442083a@natae.notmuch>
In-Reply-To: <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

martin wrote:
> On 02/07/2021 12:17, Felipe Contreras wrote:
> > Andreas Schwab wrote:
> >> On Jul 02 2021, Felipe Contreras wrote:
> >>> +ALIAS
> >>> +~~~~~
> >>> +'git co'
> >> That's `checkout' in hg, bzr, svn and cvs.
> > I know, and commit is ci in many of them.
> >
> > The reason why I decided to make checkout co, is that we have already an
> > alternative for checkout: switch. So unlike all those other VCS, in git
> > we can have:
> >
> >    co = commit
> >    sw = switch
> >
> 
> If I may jump into the discussion.
> 
> IMHO it would be good to (partly) follow other vcs, and have
> commit = ci

I'm fine with leaving co out of the default aliases if it's deemed "too
controversial".

But ci doesn't make sense. ci comes from "check in" which has no
similitude in git.

I don't think it's a good idea to leave "git checkout" without an alias
(it's perhaps the second or third most used command), but at least some
aliases are better than no aliases.

> 3) if co is not a default, then people can set it according to their own 
> taste, with less confusion, than if they override a default.

People already have aliases. Whatever is the default doesn't matter.
If you don't like the default you can set a co alias to whatever you want.

-- 
Felipe Contreras
