Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D70C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04EA20721
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D34L5B5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgEUJo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgEUJo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 05:44:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D47AC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 02:44:58 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 190so6644989qki.1
        for <git@vger.kernel.org>; Thu, 21 May 2020 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8ueVWqBVWc8z8AvqoHX77YGzSwngMhxR13v0bXlw3E=;
        b=D34L5B5xxtMHQEbbhyf1gh9pOfg11qEAYjha236c34jDgNvMZbClImTkx24HVVYuAs
         /Nj6zaNcybLJWF1Rn3cFiTyLcV4fiWS/RrN7s6H5XwV3kYNzQbK1XwsBrsNw1Z+qgciD
         IhYBhpWuJnmaVal8G4r/34FPV10tiGzFxHXEXxrbtyJm8Vyc+Km2so4GdyrJvi78yMdu
         RGi/vsBhGR8D1WkW2BeXRc0OJunVwOvqgE3kzR075AyuwXuAxx4C22mYdbAdfzJ4EVmK
         I2AutkZBqIZ1fD0GIsqALdqVE9er+OHrEDNOd1FlCZdolmn2EJywicfxdzolotzsv86Y
         C+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8ueVWqBVWc8z8AvqoHX77YGzSwngMhxR13v0bXlw3E=;
        b=oYZS3vM/CLGT2/3zVqdFDlruuflXAk3ikrrpBeeOeNLpoTHBif7k3AEbQ+j08/qDeq
         2p6Um+xFXPwr8cejVAyJjb/2YwX0HUnFKXQhb2P7sRKHlhJSyVKkugRYz2LwWOypKWjF
         vrB3HK9n6fTnrUmplPSMP23JwqYziTlk0Hw3Y5pxPObXgK+PzB7rdqvcu+uTcUwhFNDu
         67wTVycaA5DWW5AyHfqD2AODygOPbcJagGk1IhbbrMWSUSc/AoJMB7JIz68sN8GOLXXC
         JM8fyelcGMSr3h4G+qsoYz+LzqVJVDZCbckmNB0PcESaRS1P012GsLiP1LNzXTWmc0er
         QiRQ==
X-Gm-Message-State: AOAM530T4ZxE/BApb6A+TcPYFNpQACqg997K4ZB6wKF/xuK5AyOHz+Zc
        N1z4/yGhAEiWFYNnUZdy0/c=
X-Google-Smtp-Source: ABdhPJw1p/D1up9wHEyrXGwLtF5xyBoQuvxr2f3ssO8WZwn2wYYQZ75RIHMOVxrziQ6ECs6D56lhEQ==
X-Received: by 2002:a37:a292:: with SMTP id l140mr1644723qke.171.1590054297590;
        Thu, 21 May 2020 02:44:57 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o3sm4601524qtt.56.2020.05.21.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 02:44:56 -0700 (PDT)
Date:   Thu, 21 May 2020 05:44:54 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jiuyang Xie <jiuyangxie@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>
Subject: Re: [PATCH] doc: fix wrong 4-byte length of pkt-line message
Message-ID: <20200521094454.GA577071@generichostname>
References: <20200521075643.35286-1-jiuyang.xjy@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521075643.35286-1-jiuyang.xjy@alibaba-inc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jiuyang,

On Thu, May 21, 2020 at 03:56:43PM +0800, Jiuyang Xie wrote:
> The first four bytes of the line, the pkt-len, indicates the total
> length of the pkt-line in hexadecimal.  Fixed wrong pkt-len headers of

s/Fixed/Fix/ perhaps?

> some pkt-line messages in `http-protocol.txt` and `pack-protocol.txt`.
> 
> Signed-off-by: Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>

Aside from the above, I manually checked all of the changes and they
look good to me.

-Denton
