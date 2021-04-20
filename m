Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5809EC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A8E613E5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhDTUbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDTUbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 16:31:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA9EC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 13:31:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s4so1869746qtw.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0wbfeNsVq1BXAnWY+xMtRhalNnSeYbTxhT2uCxF0vU=;
        b=gCeiLmxtPAcqrImI+18W0C06WDHqxIJmyxmU2P5d3pU0tgDBkQqKyPOIf6fB0/dBCG
         A3de9+cdtncE8ILjnd525in9rduh5dfcWlCQoegeinwMRAKnIPr8EeYbBglfZEWtpuV9
         RhyUKui1NN3qkc/vniuMSTvwCc9plIzlKcGqA2DzMBi4WSwti3odXKUDhU+WASop3as2
         d2Ak5z3cR21qL/unj/NEggwhO7/Ba5qkNqg7Sy+nRWdpr5UjUA9h6NdrK+vdUCSKYv21
         tcFEiLyV8NyVLUE9aNIhOQfwaUjXS3C0f4gGV0JSHjkph/X20kPtgwUZYIfSFRMUkTLi
         O0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0wbfeNsVq1BXAnWY+xMtRhalNnSeYbTxhT2uCxF0vU=;
        b=bZUvS0aFzenqyCfiinQyj4qgnoQaeZpECfxKQsIFh5fax5Smcp3rvIlXdOfL1e4k/v
         lfxh6U7V7tVI5I+AVCIarSPOIvB6BvJIEPZa+e6Vr5rPUwxPUqajeRyu+pv+yIXAIR7N
         sBwbCerXLcf8sZrnwzNUHNF0wsBsM/8ocePEPMGa7Lu+opjVbTnfVJP3t7z1Xpg4RhBS
         pMqwODE0wdKbV+t/pK1IVBFtkzjtHtpmdFtLi5DDrPN0XEYQHNOQXE4a03aaG5NpglKq
         2/jdm5uLuv/kJgTFXUYRsWtdQNtLTveksj96SrOyYRbSjR3XsejfYbcwCddk2ac2wSMp
         ru3w==
X-Gm-Message-State: AOAM532Ag8cK7OrEAx8gkuW1mPWSEoyLL30pbGdjECDWo/QuIifJcJDB
        uF7glEiNJumkAd35NGGKHLYo5A==
X-Google-Smtp-Source: ABdhPJxjB4QZTZ81bZ6jQw/abmBOy+CCBoxTaCVvnsrIQBJTKiVUBpR+YJGtGDwM8+32N3t2GImrug==
X-Received: by 2002:ac8:5545:: with SMTP id o5mr13234013qtr.330.1618950674400;
        Tue, 20 Apr 2021 13:31:14 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:b323:36c3:bfb7:a769])
        by smtp.gmail.com with ESMTPSA id g64sm163170qkf.41.2021.04.20.13.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 13:31:13 -0700 (PDT)
Date:   Tue, 20 Apr 2021 16:31:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: set a default factor for '--geometric'
Message-ID: <YH86ENkPrTeWnnBb@nand.local>
References: <1ecab817396fae6a1cbafde1ca8b3ebfd9ae4c11.1618883241.git.me@ttaylorr.com>
 <xmqqv98g4sbl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv98g4sbl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 01:25:02PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > --g=<factor>::
> > ---geometric=<factor>::
> > +-g=[<factor>]::
> > +--geometric[=<factor>]::
>
> Do you mean "git repack -g= -d" is (1) accepted and/or (2)
> recommended?
>
> If not, we'd want "-g[=<factor>]" similar to the longer form, no?

Thanks for spotting. The '[' should come before the '=' character, not
after. I'll send a reroll with this (and a suggestion from Stolee).

Thanks,
Taylor
