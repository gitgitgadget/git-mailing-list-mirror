Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B188C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489D3206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="bi8XmEak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgEDWFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgEDWFU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 18:05:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BCBC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 15:05:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u22so329075plq.12
        for <git@vger.kernel.org>; Mon, 04 May 2020 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p1GljsQjS0MbXkTjBiSYiFp1YDBe1sS7b9FuCKEl+64=;
        b=bi8XmEakmFLGhCvRoxaTschpyVN8NDkBBgUWM/glqtip5Ctai95+z1eGIA9A+07Day
         uXpaq0bOycG2RaHiLqI7qmzysco8bLE8ZJbJ9WO7JPFun8WLGkXTuxVCtdKD0jgYkCkI
         lGW1brVAvPrV/MWOOEsbUBzJS2EQqyLQotvsffDrLbxPNfkXazOfM99rJ7k9UB/faO/5
         UjYTQFhByO4Kmx6dbKcDmyR9RTxxpm09MG4y1W/bMCoToDgZTxHUNpEOGJYgdqaqnSYq
         jnrkM31gjhrJVj28x66TZ8ACT7XDUu1m9qWogltQtW2VmNcVB10BuF5LqFzTNFrEzTuD
         1DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1GljsQjS0MbXkTjBiSYiFp1YDBe1sS7b9FuCKEl+64=;
        b=lGBvHf2xotNw/vTNkJlExYl6wMNrv4zrWK5XkQBCYeNxXkGICWY9W6+W1Y9sz9Ngvc
         JHql2WoO3mBDRHgcrsQ/WJhEHfpF55q1Og0/F1YeZQ4bV8b32ZuaygP01epFceKG1DNr
         759MQoG3y9B0DOZhuduhmUV+hNZn+Xgch1ZprM9gFko9IH7OByQo3vtDPlMopOkw1L+q
         sf511Kwu6pmtqXWYWkQpXSvd7KcZUhXB9PPGM2rNLabEnDuMZ7Q1tWL7lGfvMfIt4JSj
         ZfSWhJWbLnhIQUQ5kAMEK+gltnGOoXJdMR+kfPl/mABDJUILLOxwQeBNgleYiNhA86DJ
         toEg==
X-Gm-Message-State: AGi0PubTRJwFhwfH9gqJRoDsyoKrCAraoo3P7Q+7SmHn0KRk30hd1LCZ
        4Octg04McHIuNheuiW0TMuK+nQ==
X-Google-Smtp-Source: APiQypJJD7o6BqVKqbcLEde4d8+gTDos98QSRhO7FqINKgVlPXjLD8pzeuCOqbkHdW7IG8VX/IWkmA==
X-Received: by 2002:a17:90a:cc9:: with SMTP id 9mr69681pjt.16.1588629919443;
        Mon, 04 May 2020 15:05:19 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y21sm57688pfn.148.2020.05.04.15.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:05:18 -0700 (PDT)
Date:   Mon, 4 May 2020 16:05:17 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Kevin Daudt <me@ikke.info>, Wolfram Sang <wsa@kernel.org>,
        git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: tig: bug when binding to 'generic'?
Message-ID: <20200504220517.GE45250@syl.local>
References: <20200502190433.GB25220@ninjato>
 <20200502190729.GC1838755@alpha>
 <20200502193102.GA1160@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200502193102.GA1160@kunai>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 09:31:02PM +0200, Wolfram Sang wrote:
> Hi Kevin,
>
> > Tig is a third-party interface, not maintained by git. You can report
> > issues for tig on [github][0]
>
> I know it is third-party. Seems the README in tig needs fixing, too:
>
> ===
> Bugs and feature requests can be reported using the issue tracker or by
> mail to either the Git mailing list or directly to the maintainer.
> ==
>
> I prefer the mail option, so I wrote here and CCed the maintainers.

Thanks for clarifying. I was a little confused when I read your patch
series, since on first blush I thought that you were submitting it to be
applied in Git's integration branches, and not Tig's.

In either case, the heads-up is appreciated, but I do not think
necessary in general. I am not sure about the feelings of others, but I
do not think Tig-specific bugs need to be reported on Git's mailing
list.

Of course, if there are Git bugs that affect Tig (or any other project),
we would be interested in hearing about them.

That's all to say that I think the README there should be updated.

> Kind regards,
>
>    Wolfram
>

Thanks,
Taylor
