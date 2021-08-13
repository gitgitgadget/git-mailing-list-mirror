Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F60C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC8A60462
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhHMQY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHMQY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:24:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6697C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:24:01 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id h21-20020a17090adb95b029017797967ffbso8096190pjv.5
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/y38sfZMbYeYLk7jbCidRT7aFNOEM5F4mInrJGw2bxQ=;
        b=M3B9nhkzyMIP3eHQO1qgK6haxeqKPFg2tcgBXKiLdCWw4+Tj2C98wE54XXOlGjIKq2
         6VMv2rCxiMtU2HSzdupyM1T6UrbKm5lwHg6zPehgalgH/2SZ3scWhxAxD4jyH2T4h3vN
         B283eNFi8qrq1Sv88T01jAuoWBm21c4Go61dVDGDlvVEfF7W5eSRhYM8TV5rV0xWhjVe
         sDZUMdDP9dbdk/pJP+wF/fFJrz5hKS8+7cdvAQTEihtxLfvePxrfrDvFEJv7XXnZPcgL
         SLJQtoaS2/nsgz3bjrv86u8ljC7+59EK3rdtFxeEYHOEzhdwecSXml7hz4Jn0UQao7xY
         GOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/y38sfZMbYeYLk7jbCidRT7aFNOEM5F4mInrJGw2bxQ=;
        b=ArCeCbn8LsMj0Aw3wiHUXiWmLkYpIFTcDBaq/mCiGRAu8r/39QTKFMMwEkBqImHXrO
         MLut8D+kKzb8BAntzkFzimkGdUPRB6/cRzsqnuPWj30mOAu5z4/LVlNJG22Y1Eqhlww/
         r2GejxCZ6T5d5/7j2WhDTV+n39Voi9XtlNRVMHrXjUG+BfPMCfBkKhOTJSJMXrJ9f4v5
         6OSoq6K+nLRSxFjQL984Ns5m9EhIC3X5sWrAe25OcG1VGThtdSdbj4A/QyOdL2CL52wr
         dGrzxogPI/zI7dGWXUaC1rkGvGlMapL21oQpbhSs9Ubv/M34UL+zKXP46b+BwZKROaoc
         G2SQ==
X-Gm-Message-State: AOAM532/nY1wCnFkm+J9H8z3knEQgPq9CLkgzz71k3MMjLOpYwxBz4vf
        vMNonwtklIgbZUy8q5wUgtRhkov+9tabSw9Yx8Gk
X-Google-Smtp-Source: ABdhPJyZRjqUSic6W12zwR8YHG6yshkoytwfjEWevx6W2ZUVe64ZpZkqROG9qKj7GUB289dLBoSLSefjpvMCOK3YbIql
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:c006:: with SMTP id
 p6mr3374921pjt.144.1628871841432; Fri, 13 Aug 2021 09:24:01 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:23:58 -0700
In-Reply-To: <YRRCRHTgXU2x+s0l@google.com>
Message-Id: <20210813162358.3210807-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YRRCRHTgXU2x+s0l@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 1/7] submodule: lazily add submodule ODBs as alternates
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +int register_all_submodule_odb_as_alternates(void);
> 
> Does it need to be public? Could this be a static in submodule.c
> instead?

Thanks for taking a look at this patch series.

To answer this question: no - in this patch, I need to use it from
object-file.c to actually register the submodule ODBs as alternates when
we try to read an object that is not in the superproject.
