Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F0C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABAD207DE
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tYdjY/mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIOVsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgIOVsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:48:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277C8C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 14:48:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so5984582qke.8
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GYarg4nSezFLyxPIMHUPQqMdkdIwlr5vwWjLJiNR9ks=;
        b=tYdjY/miwsd9tiPQPXsX5A/gYmXRCoiUbaL+xPsUNJ83cfgWJWO8PoVyKyCiWr/adM
         ktZ/E9RkUO6lqldnvhKjC+iZXg4FU02htw79SliXlfGLW2gvAScT0frjOOB9r2GPj9fE
         FCzgtFuNY41BnAeJM3QA+SDN5HZzzK/NYI4f2z3pBh1LPWUboMsPEnJ/qzt3VDOcnlRb
         LH9dwZire8Dtsjw2tz+fTK/Mur/hvcxc4HYV0kwZE7pKVawH2axpnaG9p4xEvRADRMw6
         a7oKdHlyn8q83VmQlYke2GyQNrmuxZ1LUB+QuAYFAR2GpXQ2KEmEjZqmbogkhWa2oiLq
         yvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GYarg4nSezFLyxPIMHUPQqMdkdIwlr5vwWjLJiNR9ks=;
        b=hmY75Od8e0GXeII1HWpfWNkrR5x5cZVDGDxZIHDa8D9xAasmgwuDjB09ozEfDcsQsM
         OA4yut4nsKyszMv50LBpx4m0VsFPwhF3N/cmyNuMagWiCFdi5Gu9bwjl5/ipBqVh+LUl
         G4w344c63M7xhZldQl/F5227C/dZeWd10fg+I699FoMGmyHDlqObttWBmjE+GeaPNiyQ
         DkHLcTBoDj0GNkpuWsQ0ukylxEbB7yXGJkHQRsdrUsg368W8o4ioWs3Zheo7e0EdFWJ0
         wQzmuYLj4ud7J6Frp3R9/CkDpxhNRXyKmKtny4WVT5LC7hOp58iznPKHy9Hq8eaYryLy
         WkJg==
X-Gm-Message-State: AOAM530ZPmDXhamN5uVPAPOj4akk+sGC9styzi4407ZC+tMdv3CTyzET
        5sJLp/PZOEzFckh6q4J+1hfReA==
X-Google-Smtp-Source: ABdhPJzrtYPB5DLNuIed9bKHFb1TSkOwra6z4/F6irKxpsReex1Nz7yswwMv+eaWaXhB2twMnL/pMA==
X-Received: by 2002:a37:5dc6:: with SMTP id r189mr19574986qkb.364.1600206487261;
        Tue, 15 Sep 2020 14:48:07 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:209c:e081:d56c:21a0])
        by smtp.gmail.com with ESMTPSA id z37sm19100875qtz.67.2020.09.15.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 14:48:06 -0700 (PDT)
Date:   Tue, 15 Sep 2020 17:48:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git <git@vger.kernel.org>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
Message-ID: <20200915214802.GB1741@nand.local>
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
 <85ft7ivp1t.fsf@LAPTOP-ACER-ASPIRE-F5.i-did-not-set--mail-host-address--so-tickle-me>
 <xmqqimcezqs5.fsf@gitster.c.googlers.com>
 <CANQwDwc3-n4X16F1Xuf-y-yLeXoGRTeT5c=kVVFXH1E6P=ZEqA@mail.gmail.com>
 <xmqqzh5qyar4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzh5qyar4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 02:45:51PM -0700, Junio C Hamano wrote:
> Jakub Narębski <jnareb@gmail.com> writes:
>
>
> >> My gut feeling is that overflow handling needs to be there whether the
> >> field is 32-bit or 64-bit.
> >
> > Not if the size on-disk is the same as the size in memory:
> > timestamp_t is usually 64 bit (and even unsigned 64 bit epoch
> > would be enough - its range is over twenty times the present
> > age of the universe per direction).
>
> Yes, and "corrected commit dates" is about accommodating commits
> with absurd out-of-sync timestamp mixed in a history with commits
> with correct timestamp, right?  What happens if the absurd timestamp
> is near the limit of the range?  You do not have to live through the
> end of the universe---you only have to create a commit object that
> records such a timestamp, no?

I completely agree with Junio's sentiment here. The overflow handling
needs to exist no matter what, but let's remember what's common and what
isn't.

Since it's not common to be towards the end of even just the 32-bit
range, let's "optimize" for that and store the fields as 32 bits wide.


Thanks,
Taylor
