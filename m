Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF5C433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 21:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D607C20674
	for <git@archiver.kernel.org>; Tue, 26 May 2020 21:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=newcontext.com header.i=@newcontext.com header.b="SN31M/hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbgEZVBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 17:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389124AbgEZVBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 17:01:24 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8184FC061A0F
        for <git@vger.kernel.org>; Tue, 26 May 2020 14:01:24 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l17so10540575ybk.1
        for <git@vger.kernel.org>; Tue, 26 May 2020 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newcontext.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=zhJKSuoi+tO2GUzZYBUW0myYvlStv5bNQibZqRDu7/k=;
        b=SN31M/hjG2hQfKS3R6gXBfk4IGgos4+mAiUE6Ei/p1cxGOag9my5aO6t/SkHUO5E5N
         tTQz8VdT8Eun+egz0gfZ6GUJzOjDTwtkGUh8zr1AGtCfJ/M8M9G4OYWEGDHX5PunrDwW
         IuwqzuGSTySxJPKDD5IYiM9Ib6sUWTrLTfJTJ/gkqlc6bpHbeqsAvrGH5acscBnwy/w1
         QLuI96vgzTz1xOFGmNDAfp5mi4hOxqNdTPHc8CChbR1mR8yGAafN1+uqiIPn51ez1fm6
         /decQ0pe6sTZzII4DMoIxaYACcs6pJ/naFyzibeBWE61IWvaeP4r2CiW05H/gDaWW9am
         Oz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zhJKSuoi+tO2GUzZYBUW0myYvlStv5bNQibZqRDu7/k=;
        b=hKNBo34Y43qvR5L2io9/FoPxLvCTlETu/jSoixfJfwPBaqd3KOlX9hm1AXDENO34N0
         qhDbt9PH1tst1Zt2iu6ZBqN2d2JTPvp1D1dNwQLXDe+BK2DnBlLUVuOTjc6RpHRzm0FH
         Zu4tMR2VFx3Exac8Y+GpPsky3lljv4i+ylBmDYiGGIZVGeMv2wPbpAAGLPtHeEtWoSXo
         Oe5FQCV9KCCc/uLus6Y+KtM+G0wTQBUudvpksG9zRCAnQlTqdjNI6b+/ZI166L28gQGp
         l5aSDbYpT+I6u4z4z+KaaR/j7yhxKiJXuarXiXyALMvcbBlW/QnF9j2gGb4TSqrRSdWZ
         TZ/g==
X-Gm-Message-State: AOAM530W0YtHF9tx5aqoEhzwemAmjlNQf8d92cD22BUcjS1DxQxhCrur
        eGL5tbWVg0Lc1WTj8842EnFwQhDigix9vkSFGU6gKzE4
X-Google-Smtp-Source: ABdhPJwVoIMtzW4jcxs+yrELst2xVrG36jSDg638WP+7zZKvuCi0i7ixXGAmOp5e907tRfYqJ8Th0oys1lHAWs9cn1Y=
X-Received: by 2002:a25:8006:: with SMTP id m6mr4460149ybk.437.1590526883267;
 Tue, 26 May 2020 14:01:23 -0700 (PDT)
MIME-Version: 1.0
From:   Kevin Buchs <kevin.buchs@newcontext.com>
Date:   Tue, 26 May 2020 16:01:11 -0500
Message-ID: <CAKTRx=09tjsH0j+Nf4_1uzn-GwasWFB_Q96KEO=qtr5nVBkAew@mail.gmail.com>
Subject: rationale behind git not tracking history of branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For many years of using Git, I always struggled to make sense of
commit history graphs (git log --graph; gitk). Just recently I
discovered that git does not track the history of branches to which
commits belonged and the lightbulb turned on. This is proving to be
painful in a project I inherited with permanent multiple branches.
Now, I am a bit curious as to the rationale behind this intentional
decision not to track branch history. Is it entirely a matter of
keeping branches lightweight?

I am assuming one can backfill for the missing capability by using a
commit hook to manually track when a branch head is changed. Perhaps
by storing the branch in the commit notes.

Kevin Buchs, Senior Engineer, New Context Services
kevin.buchs@newcontext.com  507-251-7463  St. Cloud, MN
