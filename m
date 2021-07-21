Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A619C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 20:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBC061222
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 20:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhGUTiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGUTiK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 15:38:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C09C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 13:18:45 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r18so3797309iot.4
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 13:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=axtDeKDDx1phayBy7JQKAqu/WNcecfdx0m5T9NudOiQ=;
        b=UzukVx109hIz4HHzT2OIbhTMg14/cl1ELLZQIDPG8lm2nsufwI0ROw46AXxiVHUm7P
         bmRj2IWNjnvPvMBfbDVRXrBmbPBGKIJ9exm/410CsmC4uhYrGWGoAeO3e957ogGIwPwZ
         a49Ek4JXTjTfAbt+K+lJVtXo+QYrrnEJ6rYV42e4UljTAYoeFZapjsgtHCR7HgfGrtvA
         ivF99nPqkNLb5ExriB0BHZpmlhvkbCYrqCqbjsGUCu8MYIHCmEgan1ALw0ji+BACoMf7
         EOWOL4qivEAd8AHNCiXu2V1HgLC0EH40w0HS/vgUbgnWadfgJ/egTmGI4U+qgcQPvD+5
         b2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axtDeKDDx1phayBy7JQKAqu/WNcecfdx0m5T9NudOiQ=;
        b=XTTc2PsCnTzJqDowWBaAGYHL5rKGJ2hcEPY3eE71uknxiaSXZi2jKW+4mBrzueF5XY
         JJ6Fycn4Tkg8z5pcb/pkvr6jliQto30KuQy4h3iajTG/YCtTMWeoUnCw9akd9GkESDtU
         UxJN7JVXP0VH0dXMnq+o/kPFiR0sEGZMuP3j0ehL8mcaKFbDN0LtaGeilAjp6AESbqQe
         cto2az55C8tnR9wdQ6stw5aOz6yL4JA8zuICd1Ix7BiE1FIA/DizbzdwMcT524tHYrD0
         wbuacIL4/T4qvKFKpdOLJk53fFpn/0s4obT6DBgInOQgB3HCqLlwObVTg1ICO5KnXBs4
         +/cQ==
X-Gm-Message-State: AOAM531CGcU+We08fNQ5TUBKaShQDEY3bIOoY9/wIsYL3mzDaxMOkzmM
        lvQjRuqf8tA5JoJeHaqK853xgA==
X-Google-Smtp-Source: ABdhPJxGjC3wVOSyapz9URwdmlt4CkT54+Ctwa4Igy4Cx7ssngCAMk/RnG8nRSue7P2x6qVfzBnAUg==
X-Received: by 2002:a6b:e706:: with SMTP id b6mr16090690ioh.202.1626898725164;
        Wed, 21 Jul 2021 13:18:45 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id n10sm3989508ile.82.2021.07.21.13.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 13:18:44 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:18:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 12/24] pack-bitmap.c: introduce
 'bitmap_is_preferred_refname()'
Message-ID: <YPiBJKWUV+BQJyif@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <c474d2eda5b0b4393616109915626134429085d5.1624314293.git.me@ttaylorr.com>
 <YPf5a4LzBwNweI3W@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPf5a4LzBwNweI3W@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 06:39:39AM -0400, Jeff King wrote:
> On Mon, Jun 21, 2021 at 06:25:29PM -0400, Taylor Blau wrote:
> > [...]
> >
> > Implement a function 'bitmap_is_preferred_refname()' which does just
> > that. The caller will be added in a subsequent patch.
>
> I suspect there was some patch reordering here. We don't have any
> multi-pack bitmap code yet. :)
>
> Probably this needs to say something like "in preparation for adding
> multi-pack bitmap code..." or similar?

Oops. Good catch!

Thanks,
Taylor
