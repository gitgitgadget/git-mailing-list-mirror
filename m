Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D71C433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 21:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593792087C
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 21:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXCQjxT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgILVDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 17:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgILVDO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 17:03:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B5DC061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 14:03:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so8674456pgm.11
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 14:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uUI95V2Myh81NTXEix3QX+POn+tkd10ivPTFSbGO4JM=;
        b=rXCQjxT+Xcr7QsHL93/BMXRiWy1NMtVJVK2zhRDXrFWJcdpjvgsSGYRxETnETM6qau
         jOMirmUUw3luXRkmPmHPjL27shrB5FlXdFqy1zPjylYdbFYwpFg5IMXfJDsLF7RhQmuE
         W92pgpKKc9OwYXZ9lQFcPQwXcTGkHxextQEhBnJUpLnJr4nn1qzu1Fm4cHFadjeXE6Ue
         5JBnT4gQ5ExUWpMOLxzeOaXOdiRJeqPUquFzQuEXe64l5NRJQQqmuGbhEm1I2l72CMBW
         IUaAykFZJVR711gjQ8pYocGDTa7aeMvxkw9rB3vhCcGG1SF4OnzIkk4mOak+6g7INq7y
         GVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uUI95V2Myh81NTXEix3QX+POn+tkd10ivPTFSbGO4JM=;
        b=PGCRGDBQ0oziVmdt1Wc0JuIrccj3xkugbZuv74MNBue8u/JmoAlvFjUYRRDYcD+62o
         Eyxh+hEkSNGCGV0F0NZZvLWArza6xi+3XHpEOLpn7g39Z13GcyAVss/RNosdRZiQJUgg
         aNtjg2eZI0RY2khIMz3uhPim0BYnFGFUq0Pv2uFUsFQdRBHmKb4/Cc3p7qZZll26oKcU
         adWW46DF3RMAF6Jm1Bo7V3F4h6Zt3cyoW1C0nA5nebfrMvW7jxqQOIO5JFSs79C0r8Dq
         jrZyWTjIXcptSGnJSzuT3rTqSf13k5qsxTC3yG2mmLgJgVjIeVl2UMJ0c271VZz8kzs7
         xZRA==
X-Gm-Message-State: AOAM533FZ57724SAUwUj+BiWsbYp5YmmMvXJlXj9ayuePYlgg9t9NyBZ
        c4apU9SFV0oI1OY1/+bOPVBXOgRXyaJ+e6sx
X-Google-Smtp-Source: ABdhPJzi+CimJQhqZzufrye0cCDzGNl1oM8cvxJq+vwpHqLiMX19N7dRRxlviITko+sD7NkJH0oNdg==
X-Received: by 2002:a62:1b56:: with SMTP id b83mr7465248pfb.15.1599944593298;
        Sat, 12 Sep 2020 14:03:13 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.38])
        by smtp.gmail.com with ESMTPSA id x3sm5134802pjf.42.2020.09.12.14.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 14:03:12 -0700 (PDT)
Date:   Sun, 13 Sep 2020 02:33:07 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/2] push: make "--force-with-lease" safer
Message-ID: <20200912210307.GA55022@mail.clickyotomy.dev>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <xmqqa6xuoo8h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6xuoo8h.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/12/2020 11:15, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > The `--force-with-lease[=<refname>[:<expect]]` option in `git-push`
> > makes sure that refs on remote aren't clobbered by unexpected changes
> > when the "<refname>" and "<expect>" ref values are explicitly specified.
> 
> If you did a feature with different semantics to satisfy Dscho's
> need, then this is no longer "make force-with-lease safer", I would
> think.  Hopefully it is just the cover letter.

Yes, this patch is about the new option, but I thought of keeping the
original reason for introducing it  in the cover letter for context.
I will add this as a note and change subjject cover letter in v3.
 
> > The new option `--force-if-includes` will allow forcing an update only
> > if the tip of the remote-tracking ref has been integrated locally.
> > Using this along with `--force-with-lease`, during the time of push
> > can help preventing unintended remote overwrites.
> 
> "if-includes" sounds quite sensible.  I think you want to lose the
> word "lease" from the configuration variable name.  I do not think
> it should be on by default, though.

Thanks; that makes sense. I am thinking of  just adding the option
as a command line argument without a configuration option. Will change
this in the next patch-set.

> [...]

Thanks again, for reviewing this.
-- 
Srinidhi Kaushik
