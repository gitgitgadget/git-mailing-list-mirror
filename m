Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62E6C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B859D60ED5
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 11:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhHQLPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQLPx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 07:15:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B8C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 04:15:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h9so37900675ejs.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7EZ1tjtAONKVHy7Z3bhwVT7uc70RlCXvDOfEn/Rvs9A=;
        b=SFJ7JQ5Z0qY5MkusDe54hIAI7qwvoq2ulwDWumBlX8+BZLXB7v6EDcbJYFL+JaTzwx
         RqV25b2Z3LScuLWB42uJXM1+5Hf2cmnB8gcD1uT3f2KPqZfOtuXHmOh0Ijy7tozIKN/d
         GwtuT/aLl8MiWfYaMQPqVLOIsX3kgczZWxo4/7QdODRU+7hZlzMib3MhTiXslvYAstwJ
         kgjV8/JuiRWhjVANxjV5Jkdl7kzGZh1wla1ys4XRmeg1RhTiOR2SowVt4n1LytzP5R+c
         bm2YZsCoAhTmAEokMlUTfoSl//z5VXi6IWyTfy1hAYi42ZX34kOeBrOlADVQ2heLnSKF
         0WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7EZ1tjtAONKVHy7Z3bhwVT7uc70RlCXvDOfEn/Rvs9A=;
        b=OuuS5hsMvO6nJFtxCjde+MheV5h1Gz1exahoAgfkCqaFpjpYofmPT+3bEN9MAdDQZg
         OpunJADnjiMoZYbiD80AiJKZpvI8gLCpvlji/Dg/0nx//gRxF0zOf3rekEJ7bDC0yaH5
         qIN8tVpVJPHj+JgUGgVh8ON9rqtNY1gTHjc3qps5TSNbrvIOsGF5tdHOrb+CqGmjidrc
         +bFO1oGRE8huIwq141qbBDOJYdG2wMP663+3xcwgBaezLv7Qci1esY6XuVng73GgNbLk
         BUE+HT5sgiPu+KVTr0GGcCnFW/0Sw7r1KnnMHPYD3ErD/f4Vx/2irG+3eq+MTPPOg3NM
         VWvw==
X-Gm-Message-State: AOAM532pM/+7HAIh+DkSmHdp4Dk/qFSxeGJ4sehtoX0Ecf4Hd6dYAdKe
        Wb7UIrb/4ENcJizWCY2IDuA=
X-Google-Smtp-Source: ABdhPJw9DvbZCx3MIQTh7mXMIw23+8+ITIUhnS8bNMkF8DZEg3vcrz9pci6aDuTdry+DWNED59AjGQ==
X-Received: by 2002:a17:906:ced1:: with SMTP id si17mr3292476ejb.506.1629198918864;
        Tue, 17 Aug 2021 04:15:18 -0700 (PDT)
Received: from szeder.dev (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id j27sm636430ejk.18.2021.08.17.04.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 04:15:18 -0700 (PDT)
Date:   Tue, 17 Aug 2021 13:15:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: add job for gcc-4.8 to GitHub Actions
Message-ID: <20210817111512.GA2257957@szeder.dev>
References: <20210816045750.36499-1-carenas@gmail.com>
 <444e7410-c9c9-1b90-da5f-d6862a35c1fc@gmail.com>
 <YRqP7J7Gu0VmB6q2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRqP7J7Gu0VmB6q2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 12:18:52PM -0400, Jeff King wrote:
> On Mon, Aug 16, 2021 at 12:06:46PM -0400, Derrick Stolee wrote:
> 
> > Forgive me, I probably missed a discussion about this
> > somewhere else on the list, but...
> > 
> > Could you describe why we want GCC 4.8 in our CI? Is that a
> > compiler version that we officially support? What kind of
> > syntax triggers a problem on 4.8 versus latest?
> 
> Try fb9d7431cf (travis-ci: build with GCC 4.8 as well, 2019-07-18).
> (found with "git log -Sgcc-4.8 ci"). The gist of it is to find variable
> declarations in for-loops.
> 
> IMHO it may be more trouble than it's worth. If we can't find a compiler
> that complains on this construct, then maybe it is not a construct worth
> worrying too much about.

I for one like for loop initial declarations, because they allow us to
limit the scope of the loop variable to the loop, and would love to
see it used in more places (well, wherever possible, actually, but
that'd be a lot of churn).  So I would prefer to just drop this job
sooner rather than later, update CodingGuidelines, and, if deemed
necessary, launch a weather balloon.

