Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5AEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EE960F94
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhIUFm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhIUFm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:42:28 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F21C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:41:00 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id n17so18395835vsr.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfl80nhwefFGPvi+66mVxaQe1cgRMBvxQKCQjXrEzp8=;
        b=g0YALYSZtmQrlFEjjfQlCRMVL3bKEbnPpGcUokC8Fp24aqO9xiJOxPNZ0vDji/9BHD
         E3HizMUs+B/JJiG64Qd+k+D5AGU0ONGwnMj6G0GIk6OiwBSssYFn5pX4YIrh+P1TsLC4
         0SQYi/snpLHwxLv0+Guyj8nVBhCOAtSW8ZAfhS/0l3TrPCdpq/rbM9NC/89Ip90yrlSz
         4iT+r56S9IU0wX611/JIxs0rVTCyVLLWYNE5UqxXoVMjpvF3GpNB1QN0rzdHQe2Up/mq
         y146XB9a8dnc36xlnAZfF4WvFr5J/kAFowqCpJ1Oxjtg4uQpk64KXkKqkTIvwmatFcxS
         fxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfl80nhwefFGPvi+66mVxaQe1cgRMBvxQKCQjXrEzp8=;
        b=GoW6ZZ6Bw2SvX1U9G6TgA84H+lxkOhSszEXFJPa2c06AjIJPGVd7DwddVFGZB+D261
         UYEHgBsZEAek/NVeQ7JQ/s+u3fP5cv3G6QVPBgoC7LBjugJQgQsP5P17hPzUR8z3HlhV
         19Q2ItetjtY0Ajg3RBUgQy5JKIaOoh8uY7SrBFmlUh/iq0ANwWs1rv2iBVAFrbWL5CzQ
         hVxt4yQwB6K0tMiCOm574iw5NO+HKIjz9UgVAD+H1wmcSPH7JZMDZkPFg66c2rhHk563
         FFA0ZC7ohgu+HU712nsW1MPOd/lsmyTcctxW6T2sCHUfdL5UM+tnpBrfnih9fD9canSz
         YhmA==
X-Gm-Message-State: AOAM531tw+B0J7PvFqUrQNdSO8SwdVxVCq1NqRB/0QoEdT1KMMUes0sJ
        QoSEOqCbIiIsPupLefNgyKQVXku0+OsUivkacV8=
X-Google-Smtp-Source: ABdhPJxZ9AoXMq2l6NdFWSof5dOQJzmERvsTZswHu3fTHhaVbM2h2qD/21sZM/VuProABAv+4kehqErBYWLEjuMLC1M=
X-Received: by 2002:a05:6102:285a:: with SMTP id az26mr7414413vsb.11.1632202859847;
 Mon, 20 Sep 2021 22:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net> <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
 <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com> <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
In-Reply-To: <CAPig+cQnC1LLPtuC0qVX7EQ_ki4pev6scRox3utA45XeLHfGig@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 20 Sep 2021 22:40:48 -0700
Message-ID: <CAPUEsphR5AYUz9eLjexfH0jZWiqgpU06x1ZD9rKb7PBU3z6pJQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 10:24 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Sep 21, 2021 at 1:18 AM Carlo Arenas <carenas@gmail.com> wrote:
> > On Mon, Sep 20, 2021 at 9:09 PM Jeff King <peff@peff.net> wrote:
> > > @@ -971,7 +966,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
> > >                 switch (p->field) {
> > >                 case GREP_HEADER_AUTHOR:
> > >                 case GREP_HEADER_COMMITTER:
> > > -                       saved_ch = strip_timestamp(bol, &eol);
> > > +                       strip_timestamp(bol, &eol);
> >
> > Why not something like (plus added error handling, even if it seems
> > the original didn't have them)?
> >
> >   eol = strrchr(bol, '>');
>
> strrchr() would search backward from the NUL, not from `eol`, thus
> would not be a faithful conversion (and might not be safe, though I
> didn't dig through all the callers).

of course; I meant memrchr, which I guess will need to have also a
compat version[1]
this is the only caller for strip_timestamp()

[1] https://www.gnu.org/software/gnulib/manual/html_node/memrchr.html
