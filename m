Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C23C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 03:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiEJDyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 23:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiEJDyP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 23:54:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F2D5A5B8
        for <git@vger.kernel.org>; Mon,  9 May 2022 20:50:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i19so30379832eja.11
        for <git@vger.kernel.org>; Mon, 09 May 2022 20:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQrVJkRSi3E2Tu+IpqGcpLLec5SuycgKdHhMENXlZNM=;
        b=XTGC7ddlm+qMl3/9Q6eU7T7jDctWiTggQxNqk7CC0YAKNTX+/Z9SUNQhW8eBjU1nUl
         kphMY2KmWEczqr/12+Ua9VCffqWKksYcJMz4C2gtrBcU8yA0snOJkTDWBGAd9MufJH0I
         goFXYyRI/8QicTwp2avDPPrp2ng+vpdL+Cq04IyrBOV4xd66Z6zA4kYyafkgBO2Cpuik
         2DI/Omm83DXfdjOL3Qx1RPHRu3nUazvz1JL5Gv6/kVlqq7knOMnqGXwQnOccI+iT/wAQ
         1cIehIB8YJpeP2gh2N717wGD1/Af7C+11+NTDVyQIjKF1I9yU/+4OoIyavoMoohqpR0s
         3nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQrVJkRSi3E2Tu+IpqGcpLLec5SuycgKdHhMENXlZNM=;
        b=YxJsF7lGILRjsqdpwiyVyG0H1urW/BMlBfJdhQ3qICT+W5F6ACtpKq3vx2bFpVRsGS
         sKbKQhtRK+4w65lhMYrUn7hMHjPxso/91jhdLBaAyyoRv+m6R4Wv2yqdUhs/QDF2G5V4
         O1+PsgHo4zvW3D4KWJMvwcc9xSdKnbjaOmhRPcRbMLY6PpWaPrn/O50ZNKlknO2FgLRC
         6P6VJPxOKNlEWbZiMAhOlugVCRKfjXVRpRpxvvI9KWNVnXTF9u1p7NCzLy9f5LC4X1gS
         FQZNe31wS/ramZMJ6U9pova67MdaDd7cEUw0mMSWC0F7O2syEsDGNZ6MrTd5hCNQt1kf
         Jl6g==
X-Gm-Message-State: AOAM531urVenJstNPP3LyxfSdHQhs+tN04dRWyGtIdXe128oL1bXxOIA
        JCxoGs8R7ynNccfHdAycoYuKuzPltBTuVYzxvTemYtey
X-Google-Smtp-Source: ABdhPJx1OaHfma/tGyB8ZLYogoCifQSi1qGW9DstnmGiG4Ew1NICB+JfpcYCVjZBg8HxKr/9kJ9/ZMcTgrx4AgkjrvM=
X-Received: by 2002:a17:907:7e88:b0:6fa:55f:881a with SMTP id
 qb8-20020a1709077e8800b006fa055f881amr8754885ejc.476.1652154618043; Mon, 09
 May 2022 20:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <YnOQmVFVRuqnanMi@pflmari> <YnSWgDdxgm+XWiLt@nand.local>
 <YnT19KB2XkBrJOLQ@pflmari> <xmqqv8uioc7p.fsf@gitster.g> <CABPp-BEb8saqS0awK77y+-3oB1LAOPwOw-2dZU=67wJOKLBS1Q@mail.gmail.com>
 <Ynkx/nI67uOUDhL9@nand.local>
In-Reply-To: <Ynkx/nI67uOUDhL9@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 May 2022 20:50:06 -0700
Message-ID: <CABPp-BHyNw0dj=mh65pb9HirGFFTxF1+Kky_T4NUxFKANPE2yQ@mail.gmail.com>
Subject: Re: Crashes in t/t4058-diff-duplicates.sh
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2022 at 8:23 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, May 06, 2022 at 09:14:07PM -0700, Elijah Newren wrote:
> > > That commit talks about "trees with duplicate entries".  Does it
> > > mean a bad history where a tree object has two or more entries under
> > > the same name?
> >
> > Yes.
> >
> > > We should of course be catching these things at fsck
> > > time and rejecting at network transfer time, but I agree it is not a
> > > good excuse for us to segfault.  We should diagnose it as a broken
> > > tree object and actively refuse to proceed by calling die().
>
> Elijah would be able to comment more authoritatively than I could about
> whether or not these are easily detect-able. If they are, then I think
> it'd be worth doing so and calling die(). But they may be tricker, I
> don't know.

It's been a couple years, so I don't remember much.  I think the way I
discovered these issues was that in order to make sure some other code
changes of mine didn't regress on some issues, I was attempting to
recreate problematic cases that had been covered by the code I was
restructuring.  The existing tests related to that code had some
problems, so I was modifying/creating my own testcases, and I
misunderstood the setup of those tests and the checks behind them and
ended up creating trees broken in a *different* way and which was not
covered by the existing code anywhere.  I was already a few tangents
from the focus of my work at the time (the new merge backend), so I
don't think I investigated whether these were easily detectable.  I do
remember being concerned that the necessary checks might be expensive,
and feeling that it'd be unfortunate to add expensive checks for
issues that no one had ever triggered in 15.5 years, and which I only
discovered due to intentionally trying to create a broken tree but
accidentally creating the wrong type of broken tree.

As it was, the new merge backend took a few years of work, and I
probably followed too many tangents along the way.  This particular
issue was a case where it clearly didn't touch code I was modifying
(the merge or diff machinery) and instead triggered in unpack-trees.c
and cache-tree.c.  So, I decided to simply document it in case others
wanted to investigate.

Long story short, I can't comment about the difficulty of detecting
and working around these.  If you've read this email and the commit
message I wrote at the time, then you know everything I remember about
the issue.
