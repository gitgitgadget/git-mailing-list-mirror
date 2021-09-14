Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40CAC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EC060F8F
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhINRnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhINRnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:43:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFDEC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:41:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e16so13035524pfc.6
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xm4+09i8cGiOUgS2ME2VWBXQ035KPSj+U9p+IiK5SmA=;
        b=Au4ItRy61SvTbSP7KCo1DUfS6QBMotSDgiDuN8AFYaVAOjLhr+nbIkTvO9rYOIyeOZ
         u+ikzA6vW+WHtJ/QXO+4w/u4CyHFjLGp3GwHmkAKyH7EiRJ2I7b9k2+WjlIl4Qz7mcN4
         hzgZ2kBLgGFbKWghErb9nihDSjyWxQvjmGD8FbakXkGHW4/FqVetx2kgLk2DcJVQn9Y2
         ubWto8eNbkMYFZtuPMcAF3TPjRh3el+7hhsqcuAFwF2pxa4mB4o95xQ4llwVrZISD0BI
         D1YYHo2e8MSsbPrGk0n7rOlzblmVUEtZqXA3X4ZIvEB3tpOLF236BAb8woeV4c79ofHS
         4AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xm4+09i8cGiOUgS2ME2VWBXQ035KPSj+U9p+IiK5SmA=;
        b=TXafwYZY6zNn0rdOiiZFKBZTme15gCDLALDFBmfwhCzHVNZnPu/2tUvhh8J73gOw1O
         EAyRtM1W0IW4K23e6VwXYeKz63JUeLvRR9s76hZH8KiVNnU0gfDUsXyrKupbGuYRVkys
         74Yq6ymq4kSQVrGBtJMLlTLBuqEbZuQTXseLyjkNnDIL0Hry1WimpbFUNAQ7q9c9e06u
         cSXuS9PZYm1I4HLQuR46YbwrbVhf3RxGDdmVB7iL1Ud0YJCDAB0jGfgm4TB7l7uVFOXE
         7R/a/k1nVYXtz0XdVKOsRsZ5UA+yge6JINxbkKarg9KCJeuQ4Q00U/VYhQxGyQY7llgq
         YnOA==
X-Gm-Message-State: AOAM5332vgrFRLiIIjUEov9JSRKWlhMWDC2XT0W69cDvJ7QwCFgADQt8
        DJ7b63HoiBr545GTKYztbalZsQ==
X-Google-Smtp-Source: ABdhPJzZUkBUvKKcQns1+1txxa89m6A71xF6/iep2MaJu6Qq0TRW7186MXcy1hFp8GMwmTgxE4H0Zg==
X-Received: by 2002:a63:9d44:: with SMTP id i65mr16478673pgd.69.1631641310971;
        Tue, 14 Sep 2021 10:41:50 -0700 (PDT)
Received: from chooglen-macbookpro.roam.corp.google.com ([2620:15c:2c1:200:694a:16e2:67eb:bcc9])
        by smtp.gmail.com with ESMTPSA id k127sm11363850pfd.1.2021.09.14.10.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:41:44 -0700 (PDT)
From:   Glen Choo <chooglen@google.com>
X-Google-Original-From: Glen Choo <chooglen@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 14 Sep 2021 10:41:41 -0700
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH 3/3] gc: perform incremental repack when implictly enabled
Message-ID: <YUDe1Spvh4r7VyA5@chooglen-macbookpro.roam.corp.google.com>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-4-chooglen@google.com>
 <YT+odsA17BqtD+WJ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT+odsA17BqtD+WJ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 03:37:26PM -0400, Taylor Blau wrote:
> > builtin/gc.c has two ways of checking of multi-pack-index is enabled:
> > - git_config_get_bool() in incremental_repack_auto_condition()
> > - the_repository->settings.core_multi_pack_index in
> >   maintenance_task_incremental_repack()
> 
> Is this hinting at why there are no new tests added here? If so, it may
> need to be explained more clearly, since I was a tad confused after
> reading it.

Looks like I'll need to be clearer; this wasn't my intention at all. I
was hoping to describe the current state of affairs and to show that
there are two different approaches. Thus, this patch is an attempt to
'standardize' the two approaches.

> But if not, this patch message deserves an extra sentence or
> two saying why tests aren't necessary.
>
> Or if none of that is the case, and tests *are* necessary, then they
> should be added ;).

I initially did not include tests because it *seemed* to me that there
were no tests for this. But on a second pass, it looks like that
assumption was completely wrong (the tests are in t7900-maintenance.sh).

So, tests are necessary, and so I will add them :)
