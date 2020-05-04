Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C6C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965A020707
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eJC3NJGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgEDWQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 18:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDWQu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 18:16:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538E3C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 15:16:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q124so51788pgq.13
        for <git@vger.kernel.org>; Mon, 04 May 2020 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZkLtJExGR+RpE3531aNmBywBmf/gYU7GuZsHdF7Kak=;
        b=eJC3NJGgCVBi4qrfFdXtnCt9/jvbett441m5oLBjE9thOXTxqDgSc19O2RxC4OeCx0
         pizomLm6mM0BPkflmzxjXcJsWlAh9mq0//4sjNVAjwIHxPp56SJJ6Hk4ZDf5agk8ZnVN
         rnGUMgNRxF5qoGtFaNfoeSHsxXXoXiQxCDmErGIBn2G0js7E38Pv2WV2MJ3xLlsN/XBU
         e2NoiZblRspOuetf0mxWLDx1zHmQf5nYMlprCPa5GfM8uoJ4Urb1x7AmpgCqODO3aA2P
         34l0V4UL/PiTvfSNp3FyBx2h50WCD2orhskaABAeI28ajygijyVBmmaUOZJGnefiHEOh
         sw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kZkLtJExGR+RpE3531aNmBywBmf/gYU7GuZsHdF7Kak=;
        b=Dd8XjarW+L2DbLhWiyyG/W+M4WriBUB7nreil4El1O8WrHJjEw+G7pBBtipVGctKC/
         hyF9vzKtGX4T9bZzqd4XJaKj9w00uJHZzIlIRi3Ip+fdtwPxMIInIfgJDIiFvFwIrW4Q
         7LnAO/hY6f2sZ9QidXuKzADNqC20L2NolbU8S1UcejMchI1Bh2mNnZ1JCBB7Hz7h87R6
         nl0OPNNgPcmFzFuDb4Nbk3RkQqd6gCUg052KXP94zzRSPz1XL7J47rHPaNUFejiMP4Ek
         d9MvdoxSbuvutB4/MM03czYwOLHs0uoh2sABNXVJ5tSsCezbnjrlw0sC/F1ZgXnc2s89
         CoPQ==
X-Gm-Message-State: AGi0PubuWpSgXex9Y8OZDDuiI96XOjQ6Nz0Y+MIJ7r5zSM2EmVl5AQ+l
        tiJf6PYyR8n8ZR3NCpINMBOk3w==
X-Google-Smtp-Source: APiQypKcH4ZTZFcwYtmcHiAkwZ/a+Sah7Qn+jgG4RZEwgS1oM6nJkDbKNyDnuJea1HSZGoD0ufhU4w==
X-Received: by 2002:a62:6246:: with SMTP id w67mr66076pfb.326.1588630609626;
        Mon, 04 May 2020 15:16:49 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q21sm50013pgc.76.2020.05.04.15.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:16:48 -0700 (PDT)
Date:   Mon, 4 May 2020 16:16:47 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, martin.agren@gmail.com
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <20200504221647.GH45250@syl.local>
References: <20200415042930.GA11703@syl.local>
 <20200415043137.GA12136@syl.local>
 <20200422105536.GB3063@szeder.dev>
 <20200422233930.GB19100@syl.local>
 <20200424105957.GB5925@szeder.dev>
 <20200501223848.GH41612@syl.local>
 <20200503094005.GD170902@coredump.intra.peff.net>
 <xmqq5zddj6us.fsf@gitster.c.googlers.com>
 <20200504145937.GA11373@coredump.intra.peff.net>
 <xmqqv9lbhdee.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9lbhdee.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 09:29:29AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > On Sun, May 03, 2020 at 09:55:39AM -0700, Junio C Hamano wrote:
> >
> >> >> Does that seem reasonable?
> >> >
> >> > FWIW, I think that is the best direction. If anybody is depending on the
> >> > "commit-graph write will complain about non-commits" behavior, they
> >> > could only be doing so for a few versions; prior to v2.24.0 we did not.
> >>
> >> If we had it for the past 180 days or so, that's not like " people
> >> have seen it for only a brief time", but working it around shouldn't
> >> be too difficult---they need to validate the input they feed to the
> >> command themselves (or do they need to do more?).
> >
> > Yeah, my point wasn't so much that it was brief as that we've had it
> > both ways, and nobody was complaining about it before v2.24.0 (the
> > type-restriction change came as a side effect of another tightening).
> >
> > But yeah, if somebody really wants that validation, they can do it
> > themselves with "cat-file --batch-check". Or even for-each-ref directly:
> >
> >   git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
> >   awk '/commit/ { print $1 }' |
> >   git commit-graph write --stdin-commits
> >
> > If you're using --stdin-commits, you're presumably processing the input
> > anyway (since otherwise you'd just be using --reachable).
> >
> > I suppose you could argue the other way, too (that the user could be
> > filtering out non-commits). But so far we have one data point in either
> > direction, and it wants the more forgiving behavior. :)
>
> Yup.  I agree that Taylor outlined the best direction going forward.

Thanks, both. I'll send a series to address this shortly. (I've been
sitting on it in ttaylorr/git for a couple of days over the weekend,
but a few other things today have gotten in the way of me sending it to
the list.)

> Thanks.

Thanks,
Taylor
