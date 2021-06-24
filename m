Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ED1C48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 05:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4CE613C1
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 05:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFXFPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 01:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFXFPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 01:15:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B006C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 22:12:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w13so681279edc.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 22:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GK4/MjshrzHq2cOOx0NFI9HtPMsLmeRyoD22+sJzmu8=;
        b=faf55MfNBS8VVOzjplN6O1GkhY+/bDt9TVMBhzl/o1AWoPvrQZgGfV5SzklxLpQDd/
         KhgGIacfNlo/0FMHjq9WqFjcGHIZIBUHle9QWdyjUHdDf9v69QEpDUbTvwDCNu/6VBv/
         pfR+CiFN0RoZX9RRMcQv+0b2pn0NhSwjYdoxwenwPJe1+dYC4pzOEaYZJ9r1L6U+hIA+
         67tL+faQ92hQAUFqK/U4yLZLRN+Vam+ZTVn9waQ7ZxL/DQDgZIHhVHgAr6pEYBg8t3GK
         wv/GYFLnzygH0kccMzrQ/nmaCp1s6SfOokZ/hEIsI7zVlBsrTehK/jl1u1kabiopUE7n
         twdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GK4/MjshrzHq2cOOx0NFI9HtPMsLmeRyoD22+sJzmu8=;
        b=f+R0fBlvbwZkdp2ug4Kug3qL5EACHCE8HaFsI7uJRZOnt0vwDL9uT1rVT0zkAvu6WX
         zTKjMwJJJa15+FpxNGp32iE6a6+PhmTcwomZK2nfYuXCCS4ZNsM0RWlRUFwiagulqhO0
         RMDIQzGv4peTtCJMZ3eGkj274lxnAGI9OHZS5AOxttcyh6iywnuAPQ08OCgVsYb4U9Qr
         X9GzbyG+gSWJ0rFAoOsmaEQoj+fAoLjTJAiONN4Jv54z2dSQC/xi7uZ7eyOKlZRKuK5P
         L4Sd2q8e48sf5Q96nlzHHZ3H9riDxFoA7iojT0rfcrARKEQEi0Vavj/eDWeba4a8uT2G
         QClQ==
X-Gm-Message-State: AOAM531tSKQ/lxWVBjb8EDqCUqB1Z4LXlvhMWg7SEHdZhkg2FsOosFmz
        51kf85vu82cMfG3u7UhQMm8=
X-Google-Smtp-Source: ABdhPJxfqFhtblIhvMvvYNfjkzzP0+u1qTDIpJQy7iRX7gyzZoJ9t6lrAHI/o7tN0NP8kqhXk+uzMA==
X-Received: by 2002:a05:6402:430d:: with SMTP id m13mr4569201edc.283.1624511575876;
        Wed, 23 Jun 2021 22:12:55 -0700 (PDT)
Received: from szeder.dev (94-21-146-91.pool.digikabel.hu. [94.21.146.91])
        by smtp.gmail.com with ESMTPSA id e3sm681061ejy.78.2021.06.23.22.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 22:12:55 -0700 (PDT)
Date:   Thu, 24 Jun 2021 07:12:53 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] progress.c tests: fix breakage with COLUMNS != 80
Message-ID: <20210624051253.GG6312@szeder.dev>
References: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
 <YNPISWEBxISC30DW@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNPISWEBxISC30DW@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 07:48:25PM -0400, Jeff King wrote:
> On Mon, Jun 21, 2021 at 09:01:23AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > The tests added in 2bb74b53a49 (Test the progress display, 2019-09-16)
> > broke under anything except COLUMNS=80, i.e. when running them under
> > the "-v" mode under a differently sized terminal.
> > 
> > Let's set the expected number of COLUMNS at the start of the test to
> > fix that bug. It's handy not do do this in test-progress.c itself, in
> > case we'd like to test for a different number of COLUMNS, either
> > manually or in a future test.
> 
> Hmm. So I can easily reproduce the problem here, and your patch fixes
> it. But my first thought was: shouldn't test-lib.sh be handling this to
> give all of the scripts a uniform environment?
> 
> And indeed, we _do_ unset COLUMNS there. So I think the problem isn't
> a bad setting of $COLUMNS, but rather that in "-v" mode, the
> sub-command's stderr is hooked to our tty, and term_columns() is smart
> enough to use TIOCGWINSZ to get the value (at least on some platforms).
> 
> Setting $COLUMNS again in the environment fixes it, because we prefer
> that value to trying the ioctl.
> 
> So I don't think what you have here is wrong (though the commit message
> is a little misleading).

It is misleading indeed and needs to be updated.  I did my own
analysis and arrived to the same conclusions wrt COLUMNS being unset
vs. the ioctl() and stderr being a tty.

> But it seems like the original intent of our
> "unset COLUMNS" in test-lib.sh would best be fulfilled by setting it to
> a known value there (like 80), rather than unsetting it.
> 
> I admit this a _bit_ of a nitpick (since as far as we know none of the
> other scripts care about the terminal width), so I'm OK with this as-is
> if you feel strongly the other way.

I remember one commit-graph test that does check the number of lines
in the progress output, assuming one progress line per commit-graph
layer, which breaks when we break the progress line in a too narrow
terminal.  Running './t5324-split-commit-graph.sh -v -i' in a 46
column wide terminal fails for me, but succeeds with 47 columns.

I do suggest setting COLUMNS=80 in 'test-lib.sh'.

