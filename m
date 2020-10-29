Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196AAC56201
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 19:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B360220782
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 19:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=powertools-tech.com header.i=@powertools-tech.com header.b="RZvIzhJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgJ2TUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgJ2TUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 15:20:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC08C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 12:20:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k21so1872821wmi.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=powertools-tech.com; s=gsuite;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Y2MMMnSKnAGvH5EkQJTzg0QYC2EcxXQNT9Rwst1Q7FQ=;
        b=RZvIzhJuDErh539U/7yhnEj9M33NixGf5Kd86iYNeRRmfleoUXK9rHOl8nzrk8pheo
         ezx91sQsz4ZozlqPh7ljYOv6CdNpVYkE2IP28KAABdTwUESlSEMvmFb0S+hoGmfmzP+M
         uBggpTFGDCd5DGjjPgLyv5zqDZRe514Sqq1iJIWIK5C+4xp/i7O6LEtBTyUz9mRho6W+
         8vyLqGIFIOe6RjA3+t01D6ai1KFuygu2GLBRk2RFy2MST92FrXR/xY0MKCU3zSfkQJ2l
         cem2CXmVH3AmQrcBmfriHVJAOI1oUp2ScIOdeAGiL8IGfRdyoEXfrE6x2E7cBvmzJdpZ
         d0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Y2MMMnSKnAGvH5EkQJTzg0QYC2EcxXQNT9Rwst1Q7FQ=;
        b=rsHQUkEDxdG6eOBV+UbRJ5pnVYtv7FcQ6FeAJl2Zzz4yONxgyFYYlMxu/A9FCViGJq
         4cNuEEvFOxpTlIEoKUf3y90PhAi/3SuuGlxZojDZPp6YaqvR74hKYrR1Z28clOg9XU2B
         Yi7LaeNOU0VrYpRwYqPTEguz1CqLfWCMGW0+072MGYbL7z9crbFubw7Jubc/X2/Gt26Y
         hL18FukWU654xNTU15NP/TFvIqs/OMXmrbvjIxheZ3qdyASRnXCKj0zoqRnFiUw+lLd6
         Jqj5SE0tobo5nT9ZSzwFFxTCNL6rHFEqyUnW0ldxSC79Y9VH1gO4cFYsALtlgjij8Q/O
         GeAQ==
X-Gm-Message-State: AOAM530h4/KStkUR0x7u3pnI1EgNh19fYB0Q/LGvS/CcLq/faJcLNzjL
        KX5ZuiyZ5KCP/3+tadoYU0jC+2dj6/Pp/uFI
X-Google-Smtp-Source: ABdhPJwdk/n1ZkVtPLVSS5NeAMWzkmPnuYLWfbekz8XK7dLQrFp/3EjjLMpZC0Nd6Vx5dhCMgsvaAA==
X-Received: by 2002:a1c:2ed3:: with SMTP id u202mr728741wmu.85.1603999222826;
        Thu, 29 Oct 2020 12:20:22 -0700 (PDT)
Received: from localhost ([2001:470:1f21:ea::ffff:dda4])
        by smtp.gmail.com with ESMTPSA id l11sm6117591wro.89.2020.10.29.12.20.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 12:20:22 -0700 (PDT)
Date:   Thu, 29 Oct 2020 19:20:20 +0000
From:   =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
To:     git@vger.kernel.org
Subject: Credential Store: Don't acquire lock when only reading the file
Message-ID: <20201029192020.mcri76ylbdure2o7@safonso-t430>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git is configured for parallel fetches `fetch.parallel = 0` and
uses the `store` credential helper, fetching all remotes might lead to a
spurious lock fail. It's a race condition when several remotes require
the credentials at the same time.

This shouldn't happen, using the `get` operation should not lock the
file.
