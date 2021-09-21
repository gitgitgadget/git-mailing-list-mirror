Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D14C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 690C7606A5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 04:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhIUEYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 00:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhIUEYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 00:24:17 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC06C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 21:22:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y197so11496983iof.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 21:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bjg5V/zRf8RqyGuYuVZndVOiAa+PcHVAt8vakuZL0bY=;
        b=uvAMOkneCs0UD5sZiusIyEaHaG0qQq8470Qj92b35ZiItSLwWuLsqaaTqmuaEDGm4/
         ALSKpBpR10iRRPm1d1Kx0Ev7a4FJgWJlzHpxOxFOcPQBWpbZzaLSqxjZkomaBMqzpqtb
         KVOeDilCgcaKpcR80miUQbQPreS2Ti/0RUb+cHVDITZo7wI4FAeQ7xOeNNU+vcUVr4Tg
         UcaoKu9Ctn1UAQWwm4bBMbU4zymMfNlKxH16BAo/lw9xnWQVEWLllNHp2gHVc2HhNfjJ
         RTb/cnAjUWYl1Q3T6maOSHBbTmnEOzTvWQOn1AhI0klTCOgGtw+3Fo8+NqrioQujtFVD
         lH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bjg5V/zRf8RqyGuYuVZndVOiAa+PcHVAt8vakuZL0bY=;
        b=nbcPk7oX/TErcmEplpaxskZl2uIejYYaMXcCIMTJgW4JeSEwW30Bf/X/lpxWQTYwF7
         HQWpARNi1Vq2ByZ67Xm7MFmMl6Ft7aXq99amGZntMJE1e9wvRlwMyQtHsOEqoWqVCVeI
         ie3gQNdObxyjDu4vGyzeZO4TgKzifwbXrFGxMXj6rKpubNWNqBWNWhJDaxNgSI9xNVCO
         xVFMsZ3txCptQarTtm7/faO7pXxlsxawbzkHc2GoPNtoh1kD2zUC+t9lE79jPal6bSjS
         8TbIOsia+lPKj98u3ZhOIN9NydFXTINK0/M9yBKX/RXOtUtiCIcf4/0hnE1eq8uy8sEW
         QC7A==
X-Gm-Message-State: AOAM532sDv4b0qCMyLSHx0v+ahqWwXycSp8uj5youfbCAF4pjizcn+4T
        0/vOq7PzGHAz/e55gYYwmJj/bESZg/vcSw==
X-Google-Smtp-Source: ABdhPJwJCrx5ld8+vxEGWlKOy4amaE443ib0DkdXyyGkOeP1vATopWL7wt34CGohIAntDPIoyJ/qfQ==
X-Received: by 2002:a05:6638:2588:: with SMTP id s8mr22106280jat.43.1632198166741;
        Mon, 20 Sep 2021 21:22:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d12sm9002556iow.16.2021.09.20.21.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 21:22:46 -0700 (PDT)
Date:   Tue, 21 Sep 2021 00:22:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH 2/5] grep: stop modifying buffer in show_line()
Message-ID: <YUleFU4QrKb28bDz@nand.local>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
 <YUlV+RPMHGGfk25d@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUlV+RPMHGGfk25d@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 11:48:09PM -0400, Jeff King wrote:
> When showing lines via grep (or looking for funcnames), we call
> show_line() on a multi-line buffer. It finds the end of line and marks
> it with a NUL. However, we don't need to do so, as the resulting line is
> only used along with its "eol" marker:
>
>  - we pass both to next_match(), which takes care to look at only the
>    bytes we specified

Thinking aloud, next_match() calls match_next_pattern() which takes eol
as non-const and passes it to match_one_pattern(). And that calls
strip_timestamp(), which would be non-const, were it not the previous
patch. So I think this conversion is safe.

>  - we pass the line to output_color() without its matching eol marker.
>    However, we do use the "match" struct we got from next_match() to
>    tell it how many bytes to look at (which can never exceed the string
>    we passed it

Yep, makes sense. The patch looks good and matches your description
here.

Thanks,
Taylor
