Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42779C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15DCA61139
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhEKUNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:13:31 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F2C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:12:24 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id o202-20020a4a2cd30000b02901fcaada0306so4459467ooo.7
        for <git@vger.kernel.org>; Tue, 11 May 2021 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhTB5aR3KOvpTcXh5yqWwcuK4lSTYXa+y0tlhdUc5QE=;
        b=p1chDsk5ugELyXcQXjWpwEt2CUqKR2H68FIhN4NQs75wwmETfw6sXUK0wrdeI9fFYL
         EhqpsJqa83GMmbLBCrjN6xkYVCNiXwawSE+ZDv1p8Aqi6WlrR01sUSgsQ6ewzqwDhSn3
         dH7o5ws1ukKByC8XuEmkvJM6LflQdx3r1p6KuwRPO5r8fVQ/gtTRFTNXda/lG62rh8Gj
         0HkvFkBj8rYcj0GzmJ50lt+VesRzk8cMt3KN74ornO6zxyG/eqtBVUGIDBBqnm65kGxz
         XL0z0wig+PyTg6c/ZcoodKb6hS/5MUsKtfFYD6TjefXepdgX4CnovTjOBuB8iekKM7uF
         2GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhTB5aR3KOvpTcXh5yqWwcuK4lSTYXa+y0tlhdUc5QE=;
        b=r848QAR39WhiThWMwF7KleczqdPcdKYs6VelpEVIduCZ0V0cfxTHB5VoZ/wpVuQ9DA
         TDc0x3HiVQEu+FyMclrqUrWUtV4YGFBG592uigOK2DQdsblbz74YL6C8xaddoW/EVmBS
         mYqp/Hw9g6GESNzNotNkXMSvikyTbltnDXz4YcQkOQIwLHiQIjUpSYrDqDcFQXcxrHUv
         0ZRQSccQ7OZe+X6rnh6VPyGAlzXGaHnCQR5slGFeX5zgZP8p29PghktxTHMf+vrsBGsq
         rpicrNnN//ebMP4Xrf1hPUf01Q86RxA4JNLuTt9SSQtrOZkmgb31ZrQIx6xuIb1Uss8+
         FZow==
X-Gm-Message-State: AOAM530AKedrFj9/IeZwtY5bxxgGMNTnFYjn2Cs4R7cmbXsTNI01HEKt
        EgBubZ33dpvXzm73njC8TMbinkFrW3oJRzMkoq4=
X-Google-Smtp-Source: ABdhPJzjOGZ+44ORaZsgGdrbKRufk4q+UHCJDXkeCIihknnn9s1B7wzpmTBSmF58+qknEiQ8Aezb1kLg3o0nugKB8rM=
X-Received: by 2002:a4a:625c:: with SMTP id y28mr24634887oog.45.1620763944357;
 Tue, 11 May 2021 13:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
 <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com> <9204e36b7e9035c4cdda018d7ced8e8ca7acc8bc.1620758049.git.gitgitgadget@gmail.com>
 <df3695ad-5ba7-df22-2a2a-ca799c5d16d8@jeffhostetler.com>
In-Reply-To: <df3695ad-5ba7-df22-2a2a-ca799c5d16d8@jeffhostetler.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 13:12:12 -0700
Message-ID: <CABPp-BGeOUOvYRD+gX4jVR0kN8O5_icKtT18F9BdeR424DjUmg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dir: convert trace calls to trace2 equivalents
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 12:06 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 5/11/21 2:34 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >   dir.c                             |  43 +++++--
> >   t/t7063-status-untracked-cache.sh | 205 ++++++++++++++++++------------
> >   t/t7519-status-fsmonitor.sh       |   8 +-
> >   3 files changed, 155 insertions(+), 101 deletions(-)
> >
> > diff --git a/dir.c b/dir.c
> > index 3474e67e8f3c..122fcbffdf89 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -2760,15 +2760,34 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >       return root;
> >   }
> >
> > +static void trace2_read_directory_statistics(struct dir_struct *dir,
> > +                                          struct repository *repo,
> > +                                          const char *path)
> > +{
> > +     if (!dir->untracked)
> > +             return;
> > +     trace2_data_string("read_directory", repo, "path", path);
>
> I'm probably just nit-picking here, but should this look more like:

nit-picking and questions are totally fine.  :-)  Thanks for reviewing.

>
>         if (path && *path)
>                 trace2_data_string(...)

path is always non-NULL (it'd be an error to call read_directory()
with a NULL path).  So the first part of the check isn't meaningful
for this particular code.  The second half is interesting.  Do we want
to omit the path when it happens to be the toplevel directory (the
case where !*path)?  The original trace_performance_leave() calls
certainly didn't, and I was just trying to provide the same info they
do, as you suggested.  I guess people could determine the path by
knowing that the code doesn't print it when it's empty, but do we want
trace2 users to need to read the code to figure out statistics and
info?

>         if (!dir->untracked)
>                 return;
>
> Then when you add the visitied fields in the next commit,
> you'll have the path with them (when present).

There is always a path with them, it's just that the empty string
denotes the toplevel directory.

> (and it would let you optionally avoid the tmp strbuf in
> the caller.)

The path in read_directory() is not necessarily NUL-delimited, so
attempting to use it as-is, or even with your checks, would cause us
to possibly print garbage and do out-of-bounds reads.  We need the tmp
strbuf.
