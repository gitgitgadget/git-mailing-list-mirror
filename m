Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF989C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A02C20884
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyGN6jPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFQXU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgFQXUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 19:20:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A909C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 16:20:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o140so4385067yba.16
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JXZSvtqQrNc6/2ByVNPz22ZUosbduajfzFCO2KNmDc4=;
        b=HyGN6jPYiOcH9+rqcxg6+7X1MBmwyYh4pj8ZufASXgTh6jIvf3xsrTx1WUO45lPKws
         V/ySZF65uKG6YddEJ8TzqvQncD1koa5wBPRK4n86SJGgs4rJKNbEYJ8FuB+9ABlIJFmq
         ZVP1xEMcFNzmAmOHboQtRS3UhYLhssKOyf+ileMQm2DRMHDoMy1Kqn4bt1vvkC4kpHC4
         RCsBHvh8WL79P9Vro62NutA+7vwYNNf7yUuFvYSoKqyO4uA4rt9rrRa5ypkLJ91VOUy2
         Bt1FmC5j50fjcZZm4/ZjbC9H6QTJdPJRLbMKjTK0f/0NCf6tVucl0j2sX25AztWjFXqZ
         Psqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JXZSvtqQrNc6/2ByVNPz22ZUosbduajfzFCO2KNmDc4=;
        b=VXuBgyTButXeqrJkwGYhqgHZPvyMhNY4gmeKHtarow+pq5OozVVkmgkB24lWIjaQjj
         ZMWiUOfM1GN9XGaZGhBOygmU1DkBm3V42mAFA1zCZMQ1Jt8WjUsOIJswg1uIG1n/+p6D
         QnrSjUcTz/NBLoL+ZRYGP2Rxn6VtQX9cafFY0pqVY360oTjufR2HpxX30RI/K3rxWe+L
         rtAAN8IdXBTuwAs2JGGVTKW3xlR7w9jGu+pC/8BqyKgKKRc0EX4L060c0kQ0nnac6xCM
         tJ5TicwOlk7zMdA1Zpjs4qwL5Dfk4S6gf52QHHNkXb85zNNf7RKziUppr2AfdJbxn4/v
         qTOA==
X-Gm-Message-State: AOAM532l+2Kk/UsOhhdy2TWmZyn6oEIuhJodekMtq0Yi3qXIue7wi7lz
        tuLZzGVB0MrG4kdSJmSdRHHdhotct9FGkMnDbHRA
X-Google-Smtp-Source: ABdhPJxfu7H6F6IYO63+NvProGqP0JVVH6HKhNb/5MfEMFXVQqMWPcrF6jDxQYzQtIAUcGnPL981OB1H2Q3BxoOhqKOq
X-Received: by 2002:a25:d088:: with SMTP id h130mr2183017ybg.451.1592436024400;
 Wed, 17 Jun 2020 16:20:24 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:20:18 -0700
In-Reply-To: <CAE5ih79vZDzKQ1TSNTrL_64XjZH-DJTPqdPH5NMwOrsbaH=n+g@mail.gmail.com>
Message-Id: <20200617232018.148877-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAE5ih79vZDzKQ1TSNTrL_64XjZH-DJTPqdPH5NMwOrsbaH=n+g@mail.gmail.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: Re: git clone --filter=blob:limit=X interaction with submodules?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     luke@diamand.org
Cc:     git@vger.kernel.org, andrew@adoakley.name,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I noticed that if I do git clone with submodules, using
> "--filter=blob:limit=whatever" that the filter is applied in the super
> project, but appears to be ignored in the sub modules.
> 
> Is that expected behaviour? Or am I just doing it wrong?
> 
> I'm using git 2.27.0.90.geebb51ba8c.
> 
> Thanks
> Luke

Yes, that's expected. The main technical reason is that a lot of the
subsequent submodule operations may read objects from the submodules,
and those could trigger on-demand fetches (if the submodules were
themselves partial clones) - but right now the fetch code is designed to
run only on one repository.

For those who would like to improve this state of affairs, one step in
the right direction would be to update the fetch and transport code to
support an arbitrary "struct repository" passed in, and not just operate
on the_repository.
