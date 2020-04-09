Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1FAC2BB55
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9181C2078E
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 13:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edwardthomson-com.20150623.gappssmtp.com header.i=@edwardthomson-com.20150623.gappssmtp.com header.b="duFuDbH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgDINxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:53:09 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55238 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDINxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 09:53:09 -0400
Received: by mail-wm1-f49.google.com with SMTP id h2so3968157wmb.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qjcoAq7V4fd7xRKYCzMBnimOhDoGtgflq04FKt7pM1A=;
        b=duFuDbH+E615epxxM6ICYDzW0iderQP/pDbL4otVvXuINgVlyj41nV0ZIUp2P6WCVC
         Tazi4MR2bUNLnCZ3ya4G4yivBefRg+Qtw0QFoCB4f2DfaChZKP1tsRaFHs8DSZkLBHWq
         FC/VdjQrOToAFO4KMzjKnsSD+AWv3XJyreGNxvOCQO5YNpeiWgxbt/yz8ATF63s9s0og
         8o1ViZ87aiYG3V0VnxHYRUPar37a1kvzzvL/1yHLTF5vMikzbKNkUaVN89ZC/kFREUWT
         ygp6JJG8F+LqNMgXGNs6o/398g4T9uIgVWdhU5SO1+9Kz36y1KpYuFEs/eE1gorl6AjT
         8qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qjcoAq7V4fd7xRKYCzMBnimOhDoGtgflq04FKt7pM1A=;
        b=arPudyAHYLiEkvYspHI2nveJWNvb4hzfVCgZ121pkdVktnI1Ij92Wm+1b/ITQ1720H
         2sA1BP07jLaJIAZkswUG2f0CkU2z2UnzYTGl0Jy2Y0sfU6q66I3uoL695tmOOCVIHBFh
         mInXH3hHo4jBOQZz2Ykw9mXr9IJUl2rpscVCb+kB98K0dmT32otQdOLPllWnbL6z1B+g
         JwKixPO6Vqi5ABtctknhTxI4RtWBVGKvXQKOd6FS6ctVhSwTC84XFaUVp2rjUTSqaQNY
         A3q6uJvaUTzCgPfVMbTqScwOUQyOuGS4qJmxNS2q/MHhYMRiaIaoeKza9HmlsEVGAlZF
         kCKg==
X-Gm-Message-State: AGi0PuYBhE+I8pu+destK0yLnzPoyZ0F05hfrpjA9vEq3lolwYMufPfv
        zKiTo6jMAoyI6IbRykYItziJNg==
X-Google-Smtp-Source: APiQypILdhQFxky90tZwdk2aFYRHnd1MH5TPh9BvHTSWyu79y3rEoBWR/nMNlh9zi0c7AOmkLhaZqg==
X-Received: by 2002:a1c:9842:: with SMTP id a63mr2074wme.23.1586440387745;
        Thu, 09 Apr 2020 06:53:07 -0700 (PDT)
Received: from c787dff23351 (global-5-182.nat-2.net.cam.ac.uk. [131.111.5.182])
        by smtp.gmail.com with ESMTPSA id f187sm3987829wme.9.2020.04.09.06.53.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 06:53:06 -0700 (PDT)
Date:   Thu, 9 Apr 2020 13:52:58 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Happy birthday to all of us ;-)
Message-ID: <20200409135258.GA6@c787dff23351>
References: <xmqqzhbmpyh6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhbmpyh6.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 06:17:41PM -0700, Junio C Hamano wrote:
> So, it was today 15 years ago that Linus announced the availability
> of the first tarball of Git.  
> 
> Let me thank all the contributors, both long timers and relatively
> newer ones, for working on the system to help our users better.
> 
> But I should not forget to thank others who help us by doing things
> other than writing code.  Writing code is not the only work on the
> software.

I'd like to extend my thanks, too, on behalf of libgit2.  libgit2 was
born from git, has taken some of its source code, and, of course,
thrives in the ecosystem that git has built.  Thanks to all the
contributors to the git project for everything you've done.  And a
special thanks to Junio for tirelessly maintaining the project.

Cheers-
-ed
