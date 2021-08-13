Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CFC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DD76103A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbhHMQdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhHMQdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:33:11 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB5C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:32:44 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bo13-20020a05621414adb029035561c68664so7542604qvb.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4dlJpxRd5+UGpWihw/EuCcQ+/rzF0VwiOogLhRaTpTk=;
        b=q0ORAP5Ks3Ierp8pctunuG/GZIhOBbc4qkp+uYDxVkkF0JEPzy+2Wx+ThiA6kzHBuO
         pVijnOcogjaw4IWdaPqWtbdN0HXjQXFLLfhCTkFBR7XIapt6rXjjf7eYgafbpxDv4S8+
         4vPE2DSXil91UtT88FH8l6wwGlP4cIOQSW9/1Z+IVXnyHu2DF0iAUjGChvjZgaTDBRjt
         V3nrkWDez86k/OwtEhiiR05HRVR6r8RxguAToqORRb1vg2+idXoUu54ZeKAmKoDgvhW9
         TuektTG+04xEP+DyKObnX3rGVdkI2D6lX0kQFwJ/JfZFQc2/j9GdKyj4QvwkFxENLIY2
         7yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4dlJpxRd5+UGpWihw/EuCcQ+/rzF0VwiOogLhRaTpTk=;
        b=rCWXSq3/TorU3TwlaOT+GyZwiiNIqAeaL5US8wcB98jf3XkMfVYoBMKiEhWC68WcDB
         7gq+NNTc4N1Psv8fRAbD1S8wATxoPeyA0y9akTeClPWmr6hs0/f4SNlIh8OnJ4wdqjZG
         vpG2UM9IlUb5r3UjHr1P2o/L1i5YE7W3X9UJEueUim9AFHz/eEa7mt4g/aPecTFMzaPt
         Rs7rD8w1WQQj82uJ3Qec82sT3Wc2r0xW9rkCDv1/oWQZnXmMnVPVaR2xtT7UM+DxNo3k
         JPMsO77dFJbTifxG7x4pMI+o9GsANy7/3s5ZR97rkP8HvrNYhIa+Aeb43bd2e/6HpTP9
         W8bw==
X-Gm-Message-State: AOAM533EAFGkf9311wD3FJcQmBqqgJ9ys/2+nGW0hGRgrJq3qY+xONcY
        0DUkyENR/rhXqw/oDxYHwdlmvqo9XfZbyFiOPk9q
X-Google-Smtp-Source: ABdhPJw8prnZ1u0i7NKx8Yd3jnkK4yJIPjVrbLlBe69h5rTeJDMRIdJlTn3ponfk7Jc5KpRwgCRiQnpjxohObefU4A/u
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:728:: with SMTP id
 c8mr3502816qvz.53.1628872363711; Fri, 13 Aug 2021 09:32:43 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:32:41 -0700
In-Reply-To: <YRRYOmwW9yKhvldn@satellite>
Message-Id: <20210813163241.3213428-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YRRYOmwW9yKhvldn@satellite>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 3/7] grep: typesafe versions of grep_source_init
From:   Jonathan Tan <jonathantanmy@google.com>
To:     ramsay@ramsayjones.plus.com
Cc:     emilyshaffer@google.com, jonathantanmy@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Just a quick note: grep_source_init_buf() is only called from
> grep.c:1833, before its definition at grep.c:1869, so it could be marked
> as static (as things stand). Do you anticipate any future callers from
> outside of grep.c? (after removing the declaration from grep.h, you
> would need to add a forward declaration or, better, move the definition
> to before the call (or the call (and grep_buffer()) after the definition)).

No, I do not - thanks for the note, and I'll make it static in the next
reroll.
