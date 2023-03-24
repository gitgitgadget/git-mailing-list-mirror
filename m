Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51AEC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCXTrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjCXTrC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:47:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8DB17146
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:46:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso6199956pjc.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679687218;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yotlMy3XuCcxr1B0kfSV4BVJ+FqGBtxpnMwAyK+boIM=;
        b=cRpsRYziIBvyc7t0JF52ON2H14fxCntSHJ//T+DMZnCVY7yukZdKKvs7PIg/p2aZHm
         LgV+J82YmOrB/n6STvHR8bGSTK40tbQUAFckaoB4BFEfWex4k7QktqwbEnSC2Q6XJwnU
         Zmjaftpm0s8sVFaPVQsHJXUmFGFnIHjd8kK3ub+09BOpW5DoDtXJD/jT6WaqWQWuvOZ9
         New+osDKW5zlrLCJ/lO9O6zK5wNF71CVTWNrcvR9BQt2lK88eXW4CJXOZIRjkgMUJ07t
         mxOkBqMWQU32cHHiUEAuQP+miJ3dF1bzCwa6DODy0UtJboTLAGP24/cWMlhxFnAd2qMC
         gKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687218;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yotlMy3XuCcxr1B0kfSV4BVJ+FqGBtxpnMwAyK+boIM=;
        b=XP+v9XLq1cC6LKjG070/7rXZGflY1pxmhZR2d7A1oxGEYLreg3SAumYiQEfVttIwYC
         xRI670YTLHSQzMS828qSvGmsLuyDINZXFUw5HpZpAIXIxBNJueti6dZcUD8+IjGIVAef
         Lllzo7JhmvnJEbV8YDJfi83HS3cX7j8TbXmcJhbrWy65TSsRuFv1yi/JWygZrtIexNql
         S1bzDYCdZQO1QQy3xINP/b0VEvjuqkJV91eEUdVw+cey+nhPZbM/mhL9pxJBMQ1f4fBj
         IJ21yqGbq+MBPxu8AZZOQyKduH3wfmChZxJMOLsqHTreeMvr1hHqlMEiX2SMOePvG7B8
         28Sg==
X-Gm-Message-State: AAQBX9deVXyaw64gS6r62qYNQhbJqMPLJEOpzpjchnmtvqeqxTtaCV4P
        4yen84BxJ+aZHBWCD1DdL2I=
X-Google-Smtp-Source: AKy350Yw4d7f6t+un2Gz2jxDEeMYAUaTVgY52rNuHq2dV2tq9P20hbNRWDmZwtvFqBe34yJw4tkA7Q==
X-Received: by 2002:a17:902:c411:b0:199:1996:71ec with SMTP id k17-20020a170902c41100b00199199671ecmr4586764plk.16.1679687217933;
        Fri, 24 Mar 2023 12:46:57 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id bg9-20020a1709028e8900b0019cbabf127dsm14573088plb.182.2023.03.24.12.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:46:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] minor cleanups to fast-export --anonymize
References: <20230322173636.GA5643@coredump.intra.peff.net>
        <4931e301-2fb6-0d4b-a7bd-f65dee87071a@github.com>
X-Gnus-Delayed: Fri, 24 Mar 2023 16:17:32 -0700
Date:   Fri, 24 Mar 2023 12:46:57 -0700
Message-ID: <xmqqjzz6dj9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I saw this was on its way to next(?) without any comment, but it
> really doesn't need any. Each patch was clear and created a self-
> sufficient reason, but the culmination of dropping parameters and
> clearing up memory is also good.

I also thought these were self evidently ready for 'next'.  Thanks
for a positive confirmation.

