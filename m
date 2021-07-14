Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D45C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC62613B9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGNRUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhGNRUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:20:24 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D3C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:17:32 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso3216591oty.12
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFBDgg9qg1tiCJF4Cz4bZq6tcrbI44s+Jr3g5ygWptU=;
        b=bkdTfStOT6wnM7Wj1EbISWRfdU7gSfrd7Tpogjtq7eEZyKe8yQI/5Jl0CAxpw3HHVp
         iCYFS4eAJDQSTobjBD5hDQlbiubsIWkZxecdOCg55b1SwdosAx1X8zRW1LifZvTIkTvy
         KSKPcysYudyszyKwKsMRhWXjtleTdVejEAqMiKguVH4B2H3PW0e1qpMNBgf4g/iRpzQW
         yDmmJc9sU0weHcBm1LabssqMuN13Ll2LTPYJCAvQcCzTS4x5SH65bnMSrYD4YbBzrYWy
         6mhLR+vgsTidBoMSf3a81EU7J9zSfjfsCqtjjEKseOQ8A1s2pxSTwGuwhZxeerTPm/rW
         s7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFBDgg9qg1tiCJF4Cz4bZq6tcrbI44s+Jr3g5ygWptU=;
        b=gv8wV27AGLeONAV2eZQykf8araa6IuDVhDiipVjIvG492vm8idGQrvhDT/NlLpgKcT
         09xwfjJmCH2r4He6u4fKgKpkyKhPB4p5BCKrxkik2h/YXd8sI4GKQMCdOp2VL+Xu4res
         LRbWliUMM31AHVHIxA9Q7dywVhY+tVsg6/oGSpXVHEk3KJC0UqrPFyf47E6YaEx+gsmn
         bUd7bsTZJWuNcFHMqlmlGcMiXk2FgwXMr/rKnT/cNH9F1A4W/dO10fHHeO8F1qS7KzqF
         wSTNMl+cj8fbonLoI0yNiy9Y2oUL5di5MqIgJsQ7MODbJpvepD9StsmoCTj4gqvUgs3u
         bHCg==
X-Gm-Message-State: AOAM5301hyY7oWYQT0I0ioL/FQEq/T25eeQo8XRRWIHgQEtRfrMLCL1m
        TWjf4TucyLsnbC3N7XZ2V8NVuepx+zAp+hlg0h8=
X-Google-Smtp-Source: ABdhPJygshzqY0GCzfHjZodf0Y6NqVuiUSwekZ2/j29kF/2dkLKlGY2x1d4e4GZkFGX4mp53fPXe8gFRQfE6Grq2QlI=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr1814928oti.316.1626283051933;
 Wed, 14 Jul 2021 10:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com> <6f5767607cd2ed9d7d9f45e6dc60b07b29d70236.1626225154.git.gitgitgadget@gmail.com>
 <YO8Ut9b+6D/wR6uf@coredump.intra.peff.net>
In-Reply-To: <YO8Ut9b+6D/wR6uf@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 10:17:21 -0700
Message-ID: <CABPp-BFu4-SJrGbeSQTum_JOq4PHAGwGPPLQA+sHZMP4wvqA1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] doc: document the special handling of -l0
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 9:45 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 14, 2021 at 01:12:32AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > As noted in commit 89973554b52c (diffcore-rename: make diff-tree -l0
> > mean -l<large>, 2017-11-29), -l0 has had a magical special "large"
> > historical value associated with it.  Document this value, particularly
> > since it is not large enough for some uses -- see commit 9f7e4bfa3b6d
> > (diff: remove silent clamp of renameLimit, 2017-11-13).
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/diff-options.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> > index 11e08c3fd36..ba40ac66cc9 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -594,6 +594,9 @@ of a delete/create pair.
> >       exhaustive portion of rename/copy detection from running if
> >       the number of rename/copy targets exceeds the specified
> >       number.  Defaults to diff.renameLimit.
> > ++
> > +Note that for backward compatibility reasons, a value of 0 is treated
> > +the same as if a large value was passed (currently, 32767).
>
> Given the confusion around what "32767" even means to users, I wonder if
> we could just say: a value of 0 removes any artificial limits (but Git
> still has some internal limits which real-world cases are not likely to
> hit).

32767 is not an internal limit; and as such, it is absolutely an
artificial limit.  I had to use 48941 just a few years ago, and that
value (and others larger than 32767) are fully supported.

> Removing limits is after all the point of "0". I'm also not sure if it
> is simply for backwards compatibility. We commonly let "0" or "-1" mean
> "no limit" for convenience. It seems like something we'd want to
> support.

Making 0 mean unlimited could be done, and I think it'd be a one-line
change, but that's not what commit 89973554b52c (diffcore-rename: make
diff-tree -l0 mean -l<large>, 2017-11-29) tried to do.

I'm not opposed to such a change in the meaning of "0", but I am
opposed to documenting this value as unlimited unless we make it so.
