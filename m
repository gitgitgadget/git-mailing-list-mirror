Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A9DC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiITU7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiITU7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:59:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415869F77
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:59:06 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id f26so2703189qto.11
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CCrP0zBmSe/ZEcW27Zmo2CIvwzyeWCNQhHHEvmII4IM=;
        b=v5mIVEjbjAivbmdL/i0FH74pFTZNN6MrdTetJZuUcB/RDWULOle0sjjPbFd6oSkJaW
         kPRY49Ege9iJ7qxHtT+XBosC5fLr98njertCgo1PhU96mE9expMW8maled8c7J6D17sX
         ToF/RRx9blL9OYs/DaydHP+zdCpT1h9ofrwGH/S/m0F9yDmTMPSNk6z0PxRBjIuDUgwX
         4ppdWNdmbLkwfd8oUXRSkrHUDlxLtEIOEhds60xXc0z77q10hpusMdqaqdXsHAq09BRQ
         JBNPYc2HDHkWnVoblfaB7KP8mZZV8fA+6VB0KDOV5WbvySToIqRvz82fsG5/+Vy69ooo
         PGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CCrP0zBmSe/ZEcW27Zmo2CIvwzyeWCNQhHHEvmII4IM=;
        b=zwyJGLvNXzMcdNl2S/8D0Qd7cOZxRFTtOnu2S/ZNuwbyC3VrFygNfEjkSSf5sW20bL
         0DO9wCfuZgxpHCzMH4DnUAx+jJ8HwksheDUv6TrPAzrCYESwiTJ23UigdWZYDe2jj7ly
         qbw+dvF3cSeby5EhXIwDEFrSPgf4Rt8Oy851sQ88VBv91GhkOVmTJPwPksFd7UNNEnzL
         U8zvJdgJbpC1YkkuQpGBSGgwdmiwazct2793a0KC1qMQe9OuWYDxymW0CqQj3/hspfP8
         brw+GpYxkzibSVNyDx55dGSBfpSczmbL8rXCtaTqaDuN9Of6ySMvMedVaFYsKavWr64H
         V77Q==
X-Gm-Message-State: ACrzQf2nMBqZ+L9aj2gJ5hWK8ctqsDYPM2+YJX3p2BR8zm0lXU9GlFTa
        4QjJfZD9Y0u1efXaiCrNZ9Xp/Q==
X-Google-Smtp-Source: AMsMyM7XL045XjV/JrcpbtCoADxSk+qJS1CvZNRmv6qWrNw+vNpRmBH5ADK5AozqkEPs+VwO323ggA==
X-Received: by 2002:ac8:7d10:0:b0:35c:d519:545 with SMTP id g16-20020ac87d10000000b0035cd5190545mr17742363qtb.537.1663707545599;
        Tue, 20 Sep 2022 13:59:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a240100b006ce16588056sm591105qkn.89.2022.09.20.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:59:05 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:59:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [BUG] seemingly-rare segfault in merge-tree
Message-ID: <YyopmKNZU4WL2wrV@nand.local>
References: <YyopQD+LvPucnz3w@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyopQD+LvPucnz3w@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 04:57:36PM -0400, Taylor Blau wrote:
>   #1  0x000056234188aba3 in real_merge (prefix=0x0, branch2=<optimized out>,
>       branch1=<optimized out>, o=0x7ffd3fc4cd60) at builtin/merge-tree.c:528
>   528	builtin/merge-tree.c: No such file or directory.

I should mention, of course, that this line is custom to GitHub's fork,
and so doesn't match with the latest on `master`. Here's a link to the
relevant call that matches up:

  https://github.com/git/git/blob/dda7228a83e2e9ff584bf6adbf55910565b41e14/builtin/merge-tree.c#L449

Thanks,
Taylor
