Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4068C433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD3C2074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Sz7ogdvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbgG1QzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbgG1QzV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:55:21 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9CC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:55:21 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s15so4993995qvv.7
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jHPgVs+D+ytSA058DNtOf9gTgjXYeujLMShJ+PKdKsY=;
        b=Sz7ogdvV2CVLjL08gUjgmdsDS2wxTczXPpXvpJpsYTAPD2jj4I/SuDnQrSweYZFjHa
         b5kGoE7toxw6cvwdC/yH/JBkLklODCQ6/j64VrOFAU78hPJ0GxhD9wN1fwkmqc39T+zi
         8UNetqAG8bVyUiALW1YNq8MU3Y1I3ES2tUrnlNpiTAZqU09YQNDTM7dCZkKkwrnEJBLP
         48uTZ9V4ulyWE38LKoVjPjPZg9dOnKJlIaHAplaNRUVK7oktDLKVa1moseEukDOzj6NS
         2yu0N1ngpMdwxahbO19MN94l3h4oGtK1tNHMh1kBhl4iF9WP14Oio31T3vnKItq2EAKg
         MSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jHPgVs+D+ytSA058DNtOf9gTgjXYeujLMShJ+PKdKsY=;
        b=YjIbB2ARfKWC0ZYioghE+6wGKQEKUGpM3MWMwNYoRMxI3hLLOZkDwTBcSEpNzDfLA2
         mQGe3/6YEOT8ax0pZDBe0uw7ZyC0WhLMvh+1XCizrnIPUoVE5ii10kcvCAejk/6VU1pO
         WaS4W8g/JrgbTbEW40K4joPujrIkYEqUW6GuzZY45th6OkyLkbPGwNAm7hJ1UP6T4xzy
         kOBpOGu3tnDor41lZdFt6F1Rkrap8WBhseIy3n1zKpNC5ta0NXGzV9NghzvTa1iabT8a
         nE91ktIAlFw+zgNgDRHy17KF9VdEw9prcTlF0YR7whOmuDzPK/ZG4mbAk3U2y/WlwNgF
         yaAw==
X-Gm-Message-State: AOAM532lwiAXNOGmqkxNDGJ3MGTOV7hvyqb1m2p1LbqWLM5cb6rDlMWo
        WGpdv5x+nrgWe2wgC4W1WOw5clpryTJ9GA==
X-Google-Smtp-Source: ABdhPJzIjrS12+5sFI8+36Tv2ju1lFHZ1TTQ9vJqHlIaqqyDsD9rr5edf45OQASJKsHGIQdobHwvGw==
X-Received: by 2002:a0c:83e6:: with SMTP id k93mr27531811qva.112.1595955320720;
        Tue, 28 Jul 2020 09:55:20 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id k56sm20584339qtk.61.2020.07.28.09.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 09:55:19 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:55:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] making --first-parent imply -m
Message-ID: <20200728165518.GI87373@syl.lan>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728163617.GA2649887@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 12:36:17PM -0400, Jeff King wrote:
> For some projects, it's useful to walk the first parent history, looking
> at each merge commit as a normal commit introducing all of the changes
> no its side branch. E.g.:
>
>   git log --first-parent -m -Sfoo -p
>
> might show you the topic or pull request that introduced code "foo". But
> I quite often forget to add "-m", and get confused that it doesn't
> return any results.
>
> This series just makes --first-parent imply -m. That doesn't change any
> output by itself, but does mean that diff options like "-p", "-S", etc,
> behave sensibly.
>
>   [1/3]: log: drop "--cc implies -m" logic
>   [2/3]: revision: add "--ignore-merges" option to counteract "-m"
>   [3/3]: log: enable "-m" automatically with "--first-parent"
>
>  Documentation/rev-list-options.txt            |  1 +
>  builtin/log.c                                 |  7 +-
>  revision.c                                    | 10 ++-
>  revision.h                                    |  2 +-
>  t/t4013-diff-various.sh                       |  1 +
>  ...g_--ignore-merges_-p_--first-parent_master | 78 +++++++++++++++++++
>  t/t4013/diff.log_-p_--first-parent_master     | 22 ++++++
>  7 files changed, 113 insertions(+), 8 deletions(-)
>  create mode 100644 t/t4013/diff.log_--ignore-merges_-p_--first-parent_master
>
> -Peff

Very handy to have. The first patch looks good and could be taken
independently. The other two patches look fine to me, too, and it's
behavior that at least I would want.

So, the whole series can have my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
