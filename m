Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90882C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C736128A
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhFIEb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhFIEb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:31:27 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC795C061789
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 21:29:21 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d12-20020ac85acc0000b0290248a842f529so3414084qtd.15
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iO3QH2y2+cy8CbFOIsfkVmmXYTX7eVUMCCDUNxmAjhM=;
        b=aWLkKxaUoL7clHWJvKsAk9DxSdcNfdTspox2NXG//8LQjE1YNzBOtCKKA5YpUToyuG
         HDOTHHoq9oea30GfpIOK5mPlkThG3mBKdspZ5IJPH7pU8oTi3x54f0v2VhaBg4Mt7X4i
         TFN28yCHspmVM9KCizMuMRAmqIqC5Ajn+AjmfbSI4+shgA2Jckqrhn6l5g8+vk6//gFk
         A5pPlMLwsRtTK3q1/dzskIYz3y1E1iX6mTvUyk7z8SNiLIbYWQOSjkp5k/PhGMoDkxSu
         wBGf8v189HpEhTIRmrrTOdWIVKCQkywWqqHz1gDh+VY5qmlQjW8mPL/hzi5GWAgcK1nx
         d6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iO3QH2y2+cy8CbFOIsfkVmmXYTX7eVUMCCDUNxmAjhM=;
        b=rqvK4CDaCBxVzwXp/6404kQ0IGtaZlgmCYjGhfRJ/W+Z++L+D65GgITGRO0iLaJF0x
         03xJKe3oUHHKi+CWjHnltwkvnra8hwVws2qiduwZ7e6ZIox/ByyCRO2ctEvj7jvX0r8e
         hikwD3guoWunjxZzOvxhq3IVQJri6BSXc9ejGpEHnkBN4MOMuDccD/QVDjgZhoXPmgRh
         tdcKY/GLxpd8ht+qxyYWlWQeGfZnz9kKpQKSuGN3FP4AVf8100LUJw3tlrVptXNyql54
         pyeNCKeu9Im/VAlcM0MJDzci2eGo+CGJUeG7LPRcwtkhyy9/RLfv8/Rqv2nNidP7I/zJ
         smhA==
X-Gm-Message-State: AOAM5321qt+EQfjlFnSoPTnHGvvnXVlrnlsUOdyF60mqUWdke9OmOiWz
        5Z73uiAMnlETqOr4Y9tXP7mfdwImr1Qd2SUee/4C
X-Google-Smtp-Source: ABdhPJxM5shGglZ64CqDNhp/slfwXK2pP//5mWwLwsimpsUDfw88z3AkA6+PJxj+jgNprzUm2nACOXTgzjnbWGq0+hH+
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:d41:: with SMTP id
 1mr3957709qvr.6.1623212959335; Tue, 08 Jun 2021 21:29:19 -0700 (PDT)
Date:   Tue,  8 Jun 2021 21:29:17 -0700
In-Reply-To: <xmqqy2blqbhh.fsf@gitster.g>
Message-Id: <20210609042917.2323660-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy2blqbhh.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 2/4] promisor-remote: support per-repository config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Instead of using global variables to store promisor remote information,
> > store this config in struct repository instead, and add
> > repository-agnostic non-static functions corresponding to the existing
> > non-static functions that only work on the_repository.
> 
> This does make sense.  In general, repository extensions are per
> repository, so anything read from "extensions.*" should be stored
> per in-core repository structure.
> 
> But doesn't that mean the thing that should be fixed is on the
> setup.c side, where not just extensions.partialClone but other data
> is read into "struct repository_format *format"?  Shouldn't we have
> a pointer to that struct in the in-core repository object?
> 
> Special casing the "partialClone" field alone feels somewhat strange
> to me.
> 
> Thanks.

My reply is the same as what I replied to the query in patch 1 [1].

[1] https://lore.kernel.org/git/20210609042649.2322758-1-jonathantanmy@google.com/
