Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA7C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07096613D4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCCQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:16:00 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB506C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 19:14:02 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id e8-20020a05620a2088b02903a5edeec4d6so3168775qka.11
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iyQtMUwb6cxo+0JK/yAKTR4/g3+PJFm3Tp0TSQVAySQ=;
        b=HiuE5vzDV9Roey1/tvNt+94ywrqsAlNF0QQw+5UnRFSNegREj/buV+YH4df4WErpRz
         4Wu8Fq6Yv7eQtqstYYUhG4OK1TlvGZGNmNNGG1qgV4Zavzb4KoNr0RNFy0KR39PHcFZV
         ITVX8OtitkuAH3iwzPMSB2UKXfEzCi/Wlo0t//lqfbMKFd8z0G74Ys6rHlMuAddJxSlO
         WT66n19iBtIvEiwoGrgknmOodfC+HN6SzaQNr8r7JA8xSn6MhvhXNvVoi64PbZaEEAD/
         FmMwUrlgbuAbWfPNkHYRMDqsakPplk31e+oWhfhcV7jFSqnWQpotFJw98yVZqAWp+SpW
         rptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iyQtMUwb6cxo+0JK/yAKTR4/g3+PJFm3Tp0TSQVAySQ=;
        b=KtMQDI9ONnh+En9IpYcB9BqKoMz08vVjEUIuA2TxY+H1NmaJkK+w0tU2Ak1mTGiL0U
         rCcC3Ib7lTQOyoBNJVxqST6RpzoJ2QHhMi8d+ZL2iShTrGchhN9cp+8JfUotslK2Ony7
         9QbYmQ5otQfNnKGo94x9txgcSc2xaCtgF4pOHPfLFS291lMYWfajdBCkZjY7pyYymStW
         ytKvABB3t6Iz7p12zPlYof6Psfu0TJ5kV6mRGc1N7Fun9D49kB+mb32ZZ84llqIjtkYp
         zGq+uOiYPdMJzTbjBopZB1Tvu9VcRVjY34b627K4so4n3JOliCzw6NEEGt/DH/vKloRF
         X7nA==
X-Gm-Message-State: AOAM533NY/chUmEuWUa3XcRQrLD5A5Sk7j7KJ4XI/spw7lIbOFZWVUjw
        +AvaW73BLHsJ+j7wkWb6K/Q+Zxs8eE3dXDnUNLmp
X-Google-Smtp-Source: ABdhPJzWFD8fDaKNY2ZxyRl108nnM91RTViNiV/i7rDbgPpXZCUpWYAN5YTYAPzZJ6/FWLm4d4CkmKc+LHTRNAdGUEP9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:57a2:: with SMTP id
 g2mr4271407qvx.55.1622686441352; Wed, 02 Jun 2021 19:14:01 -0700 (PDT)
Date:   Wed,  2 Jun 2021 19:13:56 -0700
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
Message-Id: <20210603021356.342665-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH 0/8] refs: cleanup errno sideband ref related functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwenn@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> v3
> 
>  * remove errno as an implicit communication mechanism from refs support
>    completely.

Looking at all the patches, it seems that this patch set is about
functions in Git code that set errno themselves to indicate the category
of failure encountered, and instead of setting errno, we want them to
transmit that information through an out param instead. I notice that
the cover letter talks about "cleanup" and "remove errno", but that
could have been explained in greater detail, I think.

As for whether it is a good idea overall, it could be said that errno is
idiomatic in C and writing "if (myfunc()) { store_errno = errno; ..." is
not much more difficult than "int store_errno; if (myfunc(&store_errno))
{ ...". But presumably Han-Wen thinks the opposite, since he wrote this
patch set, and I'll defer to his opinion on this since he's working on
the ref code and I'm not. Besides that, having the out param is more
explicit (which might be better) and permits chaining of such functions
(e.g. "if (myfunc(&store_errno) || myotherfunc(&store_errno))"). I'll
review this patch set as if this is the approach we want to take.
