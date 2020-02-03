Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19895C33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 12:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A182086A
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 12:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="PfwgJzQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgBCMy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:54:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52860 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBCMy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 07:54:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so15788948wmc.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 04:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGmr4L4frIsr6gT89X5OO2ntg5dFN6ux2y87g/c1Tgg=;
        b=PfwgJzQqzvaklGIjzeR/1royLeEtfxaOM0CMLaLKKVEkMfaOphc/sA9KUdBaNjpFVp
         EJb1EC47OCsxfChe9u+2xxJ/Pmp7ZwgnskU/9EB3qpb8OjJmxFh67J8muDi02cJkFSR9
         RzQB1F4S6YaqGqoGk78TOkHxM0DUqP5kD3Vgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGmr4L4frIsr6gT89X5OO2ntg5dFN6ux2y87g/c1Tgg=;
        b=Yst0uBmSffsDyTpmPH7fGIr0J0rm69ZCJ+SjmcGV2xbBAfaqIUKU4gxBxXSGJk29YP
         Gbp8UMxG6gRC/q2uDeGzBBetYq2Cr3fO4E0zUIiwtn/0qk3lDztZ+ktmqKOIWKhml0za
         A5sY8IPZ+L/Yy8W9nb1DFvWZ6V6eE3MHjUg7wvu9R9ucLtThncMV6+rWpdWBInj467Kj
         JQs8CunHunMhQFyRGStMcOD5JGkoxuLydfahVhswwbBM39OXsurJB9XsNAhzt6XcdZmK
         reQxuNdFzaYAdyherIfnCmXeyU4ZaT11svnjQhlw+4cE+wsvzTQmZ7PUOOQz1AnpUPEr
         8jYQ==
X-Gm-Message-State: APjAAAVKK/Dp42EBbs1tKLjmdhFJ0bgp+q6qQDGy6EZcCM0y2DANybtt
        t1ebn7ixodFKe1xliDcFzb+xmlCobLrzWPM/8HBixWa0CRs=
X-Google-Smtp-Source: APXvYqxoYqu3g7Blgxo8eGg2ga1qdJ3qgDq+MLxrlZY1aVtbQOplZUAygZIiaWn2mQ5gr4ki7ST81KyOH07E5GRpTVY=
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr28975133wmd.92.1580734496964;
 Mon, 03 Feb 2020 04:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
 <20191213235247.23660-2-yang.zhao@skyboxlabs.com> <CABvFv3LH2tYbobn8xBykyC43FB+z16FFOSAX1XjTLFZ2BUqZ1Q@mail.gmail.com>
 <CAE5ih7-LrK1XZgjhpx3qQqRMQ5MUf-e0q=45VY4cNhHV--nSuQ@mail.gmail.com> <CAE5ih7-ngXsn1+RYSJ9qk_Ajr9x9zLRWNCyUiBGjg=sx_cOuzA@mail.gmail.com>
In-Reply-To: <CAE5ih7-ngXsn1+RYSJ9qk_Ajr9x9zLRWNCyUiBGjg=sx_cOuzA@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 3 Feb 2020 12:54:46 +0000
Message-ID: <CAE5ih78dpmPhdsR73cwGJuDYQECDaCvdOuosOAhLyLun9DyL_A@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] git-p4: python3 compatibility
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jan 2020 at 13:35, Luke Diamand <luke@diamand.org> wrote:
>
> On Fri, 24 Jan 2020 at 20:14, Luke Diamand <luke@diamand.org> wrote:
> >
> > On Fri, 17 Jan 2020 at 22:00, Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
> > >
> > > On Fri, Dec 13, 2019 at 3:53 PM Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
> > > > This patchset adds python3 compatibility to git-p4.
> > >
> > > Ping?

One very small bug report:

When doing "git p4 sync" it prints out the percent complete. It looks
like it's no longer rounding it sensibly, so where before it would say
77%, now it says 77.7777777%.

It's this line:

   sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt *
100 / len(changes)))

I think / just needs replacing with //.


> >
> > Hi!
> >
> > Sorry, I've been a bit busy.
> >
> > I quickly tried this and it was failing for me with:
> >
> > > failure accessing depot: could not connect
> >
> > It works fine with the interpreter set to /usr/bin/python, but
> > changing it to python3 caused this problem.
> >
> > I'm at 050387ce43179f1b0da364dd6eec10ce578d6583.
>
> I'm using it for day-to-day work, so far it's working well, thanks!
