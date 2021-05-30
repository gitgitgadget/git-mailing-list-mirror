Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F3C47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 07:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8843961059
	for <git@archiver.kernel.org>; Sun, 30 May 2021 07:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhE3HIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 03:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3HIy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 03:08:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA6BC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 00:07:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so4895058pjg.1
        for <git@vger.kernel.org>; Sun, 30 May 2021 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3v3aB6CAS+Ql2haGL0nm5yKs5OSvFgh82CkktJtmgKQ=;
        b=LdKZm4p6MrmJ/kWbedTi9N4Ck7nB+pgBNutW84tZODCgSY29sg4RDoIVEWicMgK99Y
         kMT9+sGGuAzksz90oQKAKcA1JgnD1nclPVjMlLxtNBgpuB14DSQVixGmjZKIL0zBL45c
         sWjrtB743Od04R0YCLIpqiwJxZ8ZjsrIM+pSQsOTCjD0Prq3ZBmGgn1AonWGRvuGKhgp
         5i1aABtWlObdw5tW/3kJJpteNJXp3HuwMu8bLaCVVGC6N+2x1vLRCCVaXYOUdGWI2oVk
         r6Ntbddr10joc2OVKm287RsxFIX3ccZrPZF7E8Gjrob4Nnb6EBGwOHAzHwACFCIzVMqg
         96NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3v3aB6CAS+Ql2haGL0nm5yKs5OSvFgh82CkktJtmgKQ=;
        b=Rbadb/Ctr1sFZsbUZOP9sZeQfo1bSmVAvgTGhSLnAPxe+VhkWwhbSr1WF3X9alLLSQ
         yEVaBTqHtctTrImbcPIrcQ1+tAK+rjZ54y7pV67fhULW9kzAFdQfmjwDm8vxYfPSCPpx
         sf2BTzJnHFUZEt9OKFuz5XWlhVBTzarrdVFEavJ90IsT7yPRynmcj1mZkntTtZzzuyZz
         ROYdTdAJUEeRodEKDS378/lTvVPUwHXvTqXA1D7s1L0xMSIRSnpq/03+sDBsgb1m53PH
         vF7+OGAc+ozlINpFFNUeCKdw+KUBYDXXioS2kSvoCFMm5fPnR9gYtegrAqoQn02314nz
         jiWA==
X-Gm-Message-State: AOAM531YhqUIG/CHmEHtPdLIAG/2tZ44//c/DCqOAXR/yI9jjS29d1fn
        TpBycjf8NUguD7itYWy5SZOJmzCaNmmySvnY
X-Google-Smtp-Source: ABdhPJysRXLXhao1ZGmlx0rzPzyZ/RdSPxWhjkq7jSQsvFitM2RKojFLt2w7WwcClstdt+yV7YyLVQ==
X-Received: by 2002:a17:902:6a86:b029:104:3ea2:1ac4 with SMTP id n6-20020a1709026a86b02901043ea21ac4mr1355188plk.21.1622358427562;
        Sun, 30 May 2021 00:07:07 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id a21sm8006106pfk.152.2021.05.30.00.07.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 May 2021 00:07:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] My Git Dev Blog
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
Date:   Sun, 30 May 2021 12:37:04 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B932C097-1B91-4D59-9CC7-1B91C86FA1A1@gmail.com>
References: <35493133-2504-4CAE-B700-79EAB990DD17@gmail.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 22-May-2021, at 22:12, Atharva Raykar <raykar.ath@gmail.com> wrote:
> 
> [...]
> I will update this thread every week when I make a new post.

A new blog post is out at: http://atharvaraykar.me/gitnotes/week2

Summary of what's in it:

* Deliberate and not-so-deliberate things left behind by developers
  -- and why they are valuable (especially for my first patch)

* My work as putting cherries on top of other people's cakes

* A debugging blooper -- showing my mistakes in the hopes that
  there is something to learn from it

The usual things apply: feedback and discussion is welcome.
