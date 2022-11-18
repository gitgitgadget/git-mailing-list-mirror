Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DC8C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 19:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiKRTHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 14:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbiKRTG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 14:06:56 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8017C7C6BD
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:05:06 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s10so4522080ioa.5
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qX7MirF4VqrLHucTR8R67snslrdZptRCc905fBpMo9U=;
        b=VldBFSuDKhEpoZOEfCMUj920FB38uygcu2LnEl2YTp4M5w/8mBRsXatsJJ01CdbYk2
         xx5WJy52PJn+yKUp9bRkyJw9SBGaeyBUxED1pZBAKJ8U9gjDs16l4B1sFHSaBHss/Mhj
         wxgy5031D884e/98ZiK1hFJo1TvirDclhZY4FXvTa0qtej3KKZ8Gmuhj1Ae1Of7Ldj17
         Y2Wi8YZ/3IfqbCnunD04koPX5T4X4Q8QKfK2gFdTTQWAICuSbMX4Hn3PS5MkzCO4qfOt
         4QD4qIndPEd5t6FapKtG6gh0MY6s5PIb4f76OkSArI7fBn3/hMH7kYxSjt7ee+8kVyiQ
         xdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX7MirF4VqrLHucTR8R67snslrdZptRCc905fBpMo9U=;
        b=ZDoISdGupQqAv3skV+OWh0Ho+X9rUPaBPGIHSnaD7Fi0AGXWNbxgiPHBdprW29mFLL
         mPkN8YUUnZYD8dwSUoPsl5zoHdNbBv8lIWK1HONPd49ZSUqJI0CKMgkf9Yt68KgrOIQt
         K6UvB3E+FAcENLNRZaORPvHLcxPb9QO6gxC/J/qnjLh+ae8OT1vAxFGVnLjgG/fS4NSb
         Nzip9ACZK/xFqFu/+ZnNEuCmi/N1N+fI8IfRMLhUHck8CxvA8NnexpAt4nEGQBah/VA6
         tM9quqnoP+aF0X7fnDUdCjlIbtNjvBkMEMVdlawRlY8H3gypXGSbxBtwAPYm3HS/pjUs
         PD/A==
X-Gm-Message-State: ANoB5plpi9XgcmdGUzTdGm7qEO4om+ZmOuqKCeNKrX1fXH1Yoi0mbD2z
        OCYEN04VdOtOzXKIYbPAloCqBw==
X-Google-Smtp-Source: AA0mqf62dA2KTwon5O1Xu7gd4qgjN8mKoDgEcGlLGe6UxEKVkeYkk4MeHWzPzOH+q7KwHg0KjSptRw==
X-Received: by 2002:a05:6602:2495:b0:6ca:d145:93 with SMTP id g21-20020a056602249500b006cad1450093mr3996349ioe.71.1668798305850;
        Fri, 18 Nov 2022 11:05:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d2-20020a6b6802000000b006ddf70e3ce8sm1559514ioc.7.2022.11.18.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:05:05 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:05:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] fixing parse_object() check for type mismatch
Message-ID: <Y3fXYKj8PdS4EKLB@nand.local>
References: <Y3Up5Vi75Up8LaGQ@coredump.intra.peff.net>
 <20221116211419.439356-1-jonathantanmy@google.com>
 <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 05:37:29PM -0500, Jeff King wrote:
> I'm adding Taylor to the cc as the author of t6102, when we were
> tracking down all of these "oops, it's not really a blob" cases. This
> fixes one of the lingering cases from that test script.
>
>   [1/2]: parse_object(): drop extra "has" check before checking object type
>   [2/2]: parse_object(): check on-disk type of suspected blob
>
>  object.c                               | 5 ++---
>  t/t6102-rev-list-unexpected-objects.sh | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)

A blast from the past :-).

I took a careful look at both of these patches and they looked good to
me, so let's start merging them down.

Thanks,
Taylor
