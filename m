Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99233C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 22:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625B261208
	for <git@archiver.kernel.org>; Mon,  3 May 2021 22:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhECWDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECWDl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 18:03:41 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A3C061573
        for <git@vger.kernel.org>; Mon,  3 May 2021 15:02:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z12-20020a170903408cb02900ed5b2fa5edso2487709plc.21
        for <git@vger.kernel.org>; Mon, 03 May 2021 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G2V1AFHQmkkwfbbxS4iaBNBCvU+wry4m7D5/fkxEx7M=;
        b=FN68WXD6KxaGolZsyXN0U9OtsC3UTLf+dD7bjhzdrlClUsTKZfO9AT+aZDaWs6hTBc
         ocvvsIwyZBF6hhe2OYMwQEgpZTgJ4Mu1XvrIKHItypGzMdHJgQpoh3Z6b8DE5meD8D+g
         kjiFiQx/o1PeVj5DSj8gOopX2VQbuybGWWr7Sq6uLnzVDDtGxvjC5YNik2+1RkAjrCnz
         mklaXLMFZsYjH8zqOKfK1y5k/py6wruEHw6sy1ZdmZ+upTBlwVUUUpkb/TgG+YP378SX
         4rt/lop6G/220JPCudDU4adtCgJL0O0fQ1qreSPTDMED0FvfYO242YRc8cZPYsqR5Wm7
         4+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G2V1AFHQmkkwfbbxS4iaBNBCvU+wry4m7D5/fkxEx7M=;
        b=USVyjbY8VeBXsyR3x1tIER0Qw+VvDrP4roqLiTmYEaXYIPqp+3pWvXqrJU7Ym3hwR/
         qktSfvHRb24a08Fj3uYAP4Z1ExL1CNlYr+xjvz/Dx2JwLKODxyIZNzHEcW6emxtfeD0k
         U8sq6icYc7qBk9ZB3D63xsM1qhU0/nKsjnSbagdqm2RD2UgJADFfKvvgm0vkB9yc0QvT
         6lQ49gRpjnAayHDfMCBu5Vn6a0EZ+8vjZ4NA+iiBEF0JsaO51w/gMf9lan1n9aNzyYUV
         M6DcTveC2YkvzGggDILUHcge2JvxnX+LsdjAaOyng5XnK/1k2d8oJIwUNyTZiRheXnX7
         RSbg==
X-Gm-Message-State: AOAM530bob3VEt3dfRN567/jwk8i5kgv1sEbpMBBAyFEFl93ccRgc1WA
        H98IXOTnmnRhBKcp7fawZSfx/ryl4A1P1AXzutQP
X-Google-Smtp-Source: ABdhPJzSrPy1iKyG4Lxz4THLi99S1PsEN/dNaU6g2Wso+fUiwkdcqOu2iOngss2MW+bCH0AU+OR+O1c5iwNskUdShZ0O
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d4d0:b029:ee:d5c3:745b with
 SMTP id o16-20020a170902d4d0b02900eed5c3745bmr7966798plg.14.1620079366479;
 Mon, 03 May 2021 15:02:46 -0700 (PDT)
Date:   Mon,  3 May 2021 15:02:44 -0700
In-Reply-To: <c2780570-81ec-bede-2f4e-75748b788bbb@gmail.com>
Message-Id: <20210503220244.2878522-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <c2780570-81ec-bede-2f4e-75748b788bbb@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: Re: [PATCH 6/6] send-pack: support push negotiation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[snip asking about whether extra_have (a.k.a. advertised) and commons (a.k.a.
negotiated) can be merged]

> Here, it would be nice if extra_have and commons were merged before calling
> pack_objects(). I mentioned a way to perhaps make that easier above, but
> the context might not make that be super-simple. Running a loop here to
> scan 'commons' and append them to 'extra_have' might be a sufficient
> approach.
> 
> Generally, this approach seems like it would work. I have not done any
> local testing, yet.
> 
> Thanks,
> -Stolee

I was reluctant to merge them because that would involve either (1)
adding commons to "extra_have" (as you suggest) or (2) iterating through
"extra_have" in order to add it to the "commons" set. For (1), this
would modify "extra_have", which is passed in from the outside. Looking
at its callers, the main one in git_transport_push() in transport.c
calls send_pack() with a set that has traversed the transport API, so I
think it would be confusing if such a set suddenly changed. For (2), the
extra loop seems more troublesome than having two parameters with
clearer names indicating where they come from. I don't mind changing to
(2), though, if people want it.
