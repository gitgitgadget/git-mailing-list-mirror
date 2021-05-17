Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893B8C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 10:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CE161184
	for <git@archiver.kernel.org>; Mon, 17 May 2021 10:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbhEQKbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbhEQKbU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 06:31:20 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2CBC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 03:30:03 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so5104670otq.7
        for <git@vger.kernel.org>; Mon, 17 May 2021 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sNcClOcLK5HuusTyMh0pK16s5p+o+vfVYuG1u+Ai/n8=;
        b=bS6iDRpvwNWgOOYW3s0WyZdYr8/36w5I68QqLYS6s9jnO8pb0KqIooO43JPEo0oUjk
         z+gY/m2pLmWnFyPx3ybCkM9D55tVFVm6+cFB4gv5aEhHWt3+olEmUBd/TL0HpRu58oy4
         CLhCPoYa/JSX3GyjfbCtEXf4Ve1x5ARnw9AXq60lw2W16re3PZZPfs16ixZ3dQckWsar
         oplx99gacjpMwe3msaR50xGZulXv0D0vcF1es9TEnoEn60X7HaHyXtWy25H5ZHrhRjq2
         VCgL2r9zkCePyO7aHn6DpatK8GRQ/+8iWNEwtFYhnvPKArkm2uqA6Qu0bgKBz/ZVWRJ8
         /l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sNcClOcLK5HuusTyMh0pK16s5p+o+vfVYuG1u+Ai/n8=;
        b=jYP0F3RLi0k9ljNpGkIY5XMgru4Le9Cjml0iczDBaHHxtQgkEALEVjDqstR5Cr2nIZ
         JES8vI5YWjhNHxNL3PWJyv8mbFz6CenS9HZbZB17kHqyxNMb54QtiO+2ABWF/cxb0+j3
         yetZwDBquIjPW0UE+uhzECS6uNN1BLg/UED9lEyznYEBaF5pJII/cNTYfIL9qxWNZUdC
         p6P7i5wGyQm9e1rk2uuY/yYp7v87JRyuHdz3nT59CCOnOwOc+HU6V3bgmBui/8fnjHLs
         4wQwORTame+RvfqTDxSqdKQB4//UGoC7X9aAFEe5GLidPEg16/D0/FbHIVi/uUlYzQGJ
         NNCA==
X-Gm-Message-State: AOAM5337J34BV9EPDxRnfFukZiAbBfp9xceL+ZiUCDb1X/W0scK4F/m9
        dZWMorqMw9P9g0LXkafFliA=
X-Google-Smtp-Source: ABdhPJwxEZFOq7Sx2OL00r50PCt/a2hsvcgeyaB9Wwh0yQOPt9mCoMhS8mCtchblPZTMQEYU59h2FA==
X-Received: by 2002:a9d:71da:: with SMTP id z26mr50874828otj.41.1621247403367;
        Mon, 17 May 2021 03:30:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 34sm3011276otf.38.2021.05.17.03.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:30:02 -0700 (PDT)
Date:   Mon, 17 May 2021 05:30:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a245a927c62_126333208ea@natae.notmuch>
In-Reply-To: <xmqqbl993irp.fsf@gitster.g>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
Subject: RE: Re* [PATCH] doc: glossary: add entry for revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Revision ranges are one of the most pervasive concepts in Git. It belongs
> > in the glossary.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/glossary-content.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> > index 67c7a50b96..31151277ba 100644
> > --- a/Documentation/glossary-content.txt
> > +++ b/Documentation/glossary-content.txt
> > @@ -554,6 +554,10 @@ The most notable example is `HEAD`.
> >  [[def_revision]]revision::
> >  	Synonym for <<def_commit,commit>> (the noun).
> >  
> > +[[def_revision_range]]revision range::
> > +        A syntax to specify a list of commits, usually indicating the starting
> > +        and ending points. For example: `master..@`.
> 
> As there is no need to spell out HEAD, `master..` would be a better
> example.

I don't think so. The description said _starting_ and _ending_ points...
`master..` has no ending point.

If we must not use @, then I would rather use `master..mybranch`, or
something like that. HEAD seems like a technical accident. But of course
I would prefer HEAD to nothing, because at least it qualifies as an
ending point.

> Especially since most people are downstream consumers, I'd
> suggest using `origin..` or `@{u}..` here.

Nobody uses "origin" (what does that even mean?), and @{u} is way too
technical, and something not a lot of people know about (@{upstream}
would be a little less cryptic, but still suffer from the same
disadvantage).

> Either is in line with the spirit of the example in the patch that
> asks "what did I do on my own on this branch since I forked?".

No it wouldn't. I don't have an "origin" head in any of my repositories.

If you really don't want to give a real example (like `master..@`--which
I guarantee does work on 99% of your repositories), then we can go with
'start..end' (it would not work on any real scenario, but neither does
many of your suggestions).

> Incidentally, it also avoids fruitless arguments about what the name
> of the primary integration branch ought to be.

Anybody who wants to get into that first needs to address the issue
that:

  git -C Documentation grep '\bmaster\b' -- \
    SubmittingPatches '*.txt' ':!RelNotes/*'

Returns 799 matching lines (many with more than one instance).

So, if this patch makes it 800, I don't think it would be a significant
factor in transitioning the documentation away from "master" (when and
if that happens).

Today people use "master". When they don't, the glossary can be updated.
It takes a second (which is much less than the time we've spent talking
about it already).

> Also "see the 'Specifying Ranges' and 'Revision Range Summary'
> sections of linkgit:gitrevisions[7] for details" would be a helpful
> addition to readers.

> Since there are examples there, we may even be able to drop "For
> example..." from here and have just refer the readers to these
> sections.

I think we need both. Detailed explanations are good, but so is a
succinct example.

> By the way, this reminds of me one thing that seems to occasionally
> confuse new people.  Most Git commands take a single range, even
> though you can give multiple bottoms and tops.  This is because a
> revision range is *not* just a random "list" of commits, but a single
> connected set of commits, and to new people, the distinction between
> them seems to be a bit unclear.

Yeah, but at this point that's overcomplicating the issue.

For example, if you do master..feature-a, and master..feature-b that
technically can be considered a revision range", since it's something
accepted by `git log`, and `git log` accepts "revision ranges".

But anyone that understands English would say that's not a single
range, but two ranges.

So English and git are at odds in this instance.

I think a..b should be a revision range, and multiple of those could be
called a revision spec (or revspec for short). We have pathspecs, why
not revspecs?

Mercurial for example calls them revsets.

Either way. I'm trying to start from the lowest common denominator.

  1. Revision ranges do exist throughout the documentation
  2. `git log` accepts a revision range

So let's describe what a revision range is, in the simplest form.

The rest can be done later.

Cheers.

-- 
Felipe Contreras
