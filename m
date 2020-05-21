Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00134C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B124C20709
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLg2oq7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgEUCf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgEUCf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 22:35:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A401C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 19:35:58 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n11so2388808pgl.9
        for <git@vger.kernel.org>; Wed, 20 May 2020 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jfXKFIINaK6ix50r4DL67MjUJW2mfeGnBeMfWnrJ4AE=;
        b=DLg2oq7MvCmjzF1rXPECnECBqia12mP7u37JYpwcKdJhK39Hg3yOGoL5atP2WM+3qm
         +fRY0HScAva44No7UlGHGC+VaZUJCoBSxPySB4Q/po8FSCtTDj0zreqPlxs13cEcFNgZ
         ygVhZrH+nJPSiVl3vzFY1BmE2BJTkYQleewGuExgqPgciOt6t+olwvmstiDKUn2udEIM
         dsYWNcojGKUFLk0De8QugywONqI5Rr6p3KSWp4g25sly9FoCkCkgTKVtPtQ/3QbaqvZG
         OJ/u/Hvja3nC/wr0YkMggpuf8GqLvHM8eDWDg9NtRiaOTt1vT21Lx4TFy3lAQxU4Xepp
         C6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfXKFIINaK6ix50r4DL67MjUJW2mfeGnBeMfWnrJ4AE=;
        b=VLRFFfn85WoIdjfdrFX7Xb3chbEAx06HwMzxiq9PPFyDa0aYkWvb8Wlzrbs1cPyMNh
         1th13Il5FjlQZW6gvKitdhiJPbsj3jf/PUssIpDosfJr3jj4cb93z4STkKUU/g256pJn
         tuF0zovetuG6iG0RaYycojiKTZnSx6JRRNroE/i4E/IYpjGl3N5XIgIbddZTbeDZZI1h
         uoCg8stQFXSlX7LbJI1gI+jjRDKATuNL3hzno7+AmCYwq1AvYfVdSnYqDNITmZPUeKhJ
         wZOfEkXaRvZXOALCV+gjiTS4lwR2r7OFCHeYuH53OAcSi74uLUruD2LY3Lvqw1m/2LzV
         0tJw==
X-Gm-Message-State: AOAM5318fHyNH21bg662ot7LAw8XuaZensPZcB+3AuWfCOC4KOdvawu9
        mS97rGcpc9+NsCxByIh6U5Me/5JA
X-Google-Smtp-Source: ABdhPJzP9wIPK14AIQkIZ6h819Na8S6a2Kl+L1v+hPnyKon333+3a2RHjbr6RXPpXMImUJk6kHl7bw==
X-Received: by 2002:a63:1451:: with SMTP id 17mr6682408pgu.242.1590028557546;
        Wed, 20 May 2020 19:35:57 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e26sm3110587pff.137.2020.05.20.19.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 19:35:57 -0700 (PDT)
Date:   Wed, 20 May 2020 19:35:54 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        bwilliams.eng@gmail.com
Subject: Re: Protocol v2 in v2.27 (Re: Re* [ANNOUNCE] Git v2.27.0-rc1)
Message-ID: <20200521023554.GE20332@Carlos-MBP>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
 <20200520193156.GA4700@coredump.intra.peff.net>
 <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
 <20200520220023.GB3648@google.com>
 <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
 <20200521021533.GC3648@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521021533.GC3648@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry to hijack the thread, but hopefully this is not completely offtopic
either, regarding v2 support.

Is 1aa8dded3a (connect: don't request v2 when pushing, 2018-03-15) still
relevant?

Carlo

CC +Brandon to help answer
