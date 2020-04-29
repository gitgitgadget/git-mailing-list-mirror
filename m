Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4736AC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2396720787
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Y9fmBbW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD2R0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2R0r (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 13:26:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C36C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:26:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n16so1326644pgb.7
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i+vFBLEnsd1+D7lVc0uXMFC6tG8K/3/teIYs4CR/+Pk=;
        b=Y9fmBbW0X8ScheKLLYB6nAIY9rq4mPy2m895cuVoOSUElPNfbngRyjeZ/rnVPCBG+w
         bw9xzDkbAJgdV3eQ4Q7gnh7RZD9KL/5Zc4LcXvKD83utvFfwI1sUf43/X/Qp0mip68Jz
         8zjolfrAvqhUMWGZCXlCzW7MoG7EPXmW1TdefQvYnEg9ZDiEa/ehfTBno2gXGpI6/ix7
         8/OGIaMHT2tZzlLfgRNgXQ7BrdVc4xZQvEXdgFuBzn5gYF7k459r3Wo1aFqYzFg2zV/o
         2d+tBDKUhajPZElXfVaWHXLHGkrXL6K+vxjRsTH9ptLhP+2Ih7xxCB8TPCGO6AF7S94I
         gQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i+vFBLEnsd1+D7lVc0uXMFC6tG8K/3/teIYs4CR/+Pk=;
        b=DK1I1LdJLsbduyIPxZUNwdUkrhLt7VmXxFfUTQu4wcgeNvEomhDP4SHK5LNoiXDcV5
         oAd2epwvRIrYI4pSd1JNR5thrgmMBnI6VOoP9RHdti5MwtJgFgsDFdH0g1dmFDXE1Q9V
         Q0I5vsh0ZOMKGeOT8dWtTrvOaHRhejTVN0D80fRNdsOPqKeZo1JyjXiAZzxwHPD4ikdy
         hUQQUlLdghFty6ZOsXGS1B80usCEsnalif2ES6t314llNBfwYGdpuna1PcXe3ibGJ5lf
         8Pg7o5R0zOFLoF1JzRBLqoGJ0u8KxHeZ1EnT5B2JU22ScxFIrffAvcHStSh8kUdv1gaa
         HCPA==
X-Gm-Message-State: AGi0Puau8L6PRxmU7ysfU9+TYRnoFOJf/JpGB21iXZ1ebC8NSl5SMuJQ
        rM9Idfsa52rBv1fMAAaBJ4UycA==
X-Google-Smtp-Source: APiQypLJF4CRJTKcuY2KxlMh+kSPnZO1GkiHkWLX9NwkaJoY++FPyuygmMLvplDuXm2LVqnrLhnR0A==
X-Received: by 2002:a63:67c5:: with SMTP id b188mr33828939pgc.111.1588181206959;
        Wed, 29 Apr 2020 10:26:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c12sm1452402pgk.11.2020.04.29.10.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:26:46 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:26:44 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2020, #03; Tue, 28)
Message-ID: <20200429172644.GD83442@syl.local>
References: <xmqqimhjyy9c.fsf@gitster.c.googlers.com>
 <20200429155701.GA83442@syl.local>
 <xmqqr1w6xmtf.fsf@gitster.c.googlers.com>
 <20200429165501.GC83442@syl.local>
 <xmqqy2qew6hw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2qew6hw.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 10:23:39AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Right... but I'm not sure that I agree that this other topic "builds" on
> > the whole series. There is nothing in the last commit that the other
> > series is dependent on. So, I was suggesting something like:
> >
> >   $ git checkout tb/commit-graph-split-strategy
> >   $ git revert HEAD
> >   $ git checkout tb/commit-graph-fd-exhaustion-fix
> >   $ git rebase tb/commit-graph-split-strategy # making sure to drop the final patch
>
> We cannot do this, as fd-exhaustion-fix is already in 'next'.

Ah, I didn't realize that it was already in next. Yep, makes sense that
we can't change the topic like this. Now I understand why you prefer the
below, thanks for an explanation.

> >> Why don't we do this:
> >>
> >>  $ git checkout tb/commit-graph-fd-exhaustion-fix
> >>  $ git revert tb/commit-graph-split-strategy
> >>  $ git checkout master
> >>  $ git merge tb/commit-graph-fd-exhaustion-fix
> >>  $ git branch -d tb/commit-graph-fd-exhaustion-fix tb/commit-graph-split-strategy
> >
> > That's fine with me, too.
> >
> >> That's the simplest solution and we'll have two fewer topics we need
> >> to worry about when we are done.
>
> OK.

Thanks,
Taylor
