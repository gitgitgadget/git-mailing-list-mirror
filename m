Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E9C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9432D60E97
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGWTVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWTVh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 15:21:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D5C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 13:02:09 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so3269526oti.0
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FgDjiq5qOwJS6BALz6OlB0nHMesc+hI8SmZ/QDitCsA=;
        b=lSRBOKZH0VANzAwUKoRZI+sLISYKzuH8rbMkl/UUPzqYVU0symbFK4WnuipZTNm0Xm
         eEg/O/v2EPH75urpltXEMBiCrE5vkaoW2/3BX3x4c2w6jAsYdt1ENMepEJpt9fmRU9FL
         cVT0fzEQFHX3FGOhAbaTkCMqH8PkfCDs+uqF0LKhq2LQdM0UNBZq6J8UIekSZzm/Rl1k
         QcJii5p7QvEr46wPxyeBS/phGrO4oSoO9ijVjI/p9FA6F9FdDvCGSx7eJC9nYDxXTuNe
         Jp/jrfCIX3prPJD3KXMtX113MKzY6rk+FLufNf9kTRWMSQ/ElqtsqqVrMxUsONacf4+9
         0IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FgDjiq5qOwJS6BALz6OlB0nHMesc+hI8SmZ/QDitCsA=;
        b=s0U4VQaOjoEFsQcO8bWT5rIPpMDnKq+R1cnBI8JAqFO7U6RAIZKgyTA85QyBpHKtuk
         UR7hjJcG3r+zKYKQWc8U6kYJGJCrcXA10+rQPab627yYV1bUnpg47L06DZbAbEFPw12N
         MW7ohIIZmnnJRrufNTBj4U4iBPWX0DF7kxwPMbsqS/SbjvJin2hMgHYCYrV9XoeAFXmy
         e+zqlDBYz+2g85Sc0/Hx8OwXwEMksdP44Nnz4c6NwV1NBizSoVNRYCGPAxGO1xw8yvjL
         sJk6UUt1u4YIJZYkZBLGMJILWZAkK8kZo6vExZTQ8UR9HbAGwzjizS8fX0XOJQI9EZuk
         rG+A==
X-Gm-Message-State: AOAM530Fh01d8rN7dhflMpe3ZwQh/GuN8iAWOuatJYT2YJkEYQBQHves
        n79j9r7NcDrN86FQKaT5/Pw=
X-Google-Smtp-Source: ABdhPJxE6NoUuB+L/NlB69rdNj6Heg4L6nKylUoh0ZOMH3H0ZKVB//PAohiFhMumbSc54AcEJiIrMQ==
X-Received: by 2002:a05:6830:2a08:: with SMTP id y8mr4369197otu.61.1627070529032;
        Fri, 23 Jul 2021 13:02:09 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e31sm5503067ote.22.2021.07.23.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 13:02:08 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:02:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Message-ID: <60fb203f641a9_1073e208e9@natae.notmuch>
In-Reply-To: <CAPig+cS6EmxZeO5Ad3oUMn2tkSwE1CdLTaA7-Pp2CbmO--EW3g@mail.gmail.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-5-emilyshaffer@google.com>
 <87lf66y6pd.fsf@evledraar.gmail.com>
 <YPnwBu4oMA9K445J@google.com>
 <60fafd8295996_defb208dc@natae.notmuch>
 <CAPig+cS6EmxZeO5Ad3oUMn2tkSwE1CdLTaA7-Pp2CbmO--EW3g@mail.gmail.com>
Subject: Re: [PATCH 4/9] hook: treat hookdir hook specially
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Fri, Jul 23, 2021 at 1:34 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Emily Shaffer wrote:
> > > On Fri, Jul 16, 2021 at 10:58:34AM +0200, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:
> > > > At this point I tihnk it would be way better to squash this and o=
ther
> > > > such changes that basically add a field to a struct that isn't us=
ed yet
> > > > into whatever commit use/need them.
> > >
> > > I think at this point we run into you and me having different
> > > patch-storytelling styles - which probably is what led to the big t=
opic
> > > restart in the first place ;)
> >
> > Yes, but as a reader of the story I prefer not to have to read the
> > entire thing in order to understand it. I prefer each page to tell a
> > small story.
> >
> > Putting my armchair reviewer hat I cannot do that for this particular=

> > patch, I would need to do more work to make sense of it, and while I'=
m
> > writing this message to explains that, others will simply skip it, an=
d
> > that's a lost opportunity.
> =

> Implicit in what Felipe and =C3=86var are saying is that a well-structu=
red
> patch series asks the reviewer to keep only one or two details in mind
> after reading a patch in order to understand the next patch in the
> series, and that the reviewer shouldn't be expected to keep a large
> set of details in mind over several patches. Unlike the author of the
> patches who can keep all the details in mind at once and understands
> the series in its entirety, reviewers (usually) don't have such
> luxury[1]. So, it's important to hand-hold reviewers as much as
> possible by not asking them to remember a lot of details between
> patches and by ensuring that the details which they must remember only
> need to be remembered for a very short time. This is why it is
> helpful, for instance, to bundle documentation and test updates in the
> patch with changes to code, so the reviewer can see at a glance that
> the changes to documentation and tests match the changes to the code,
> rather than delaying documentation and test updates until later in the
> series.

Another important point is that while as a patch author it's natural to
push back against possibly unnecessary changes because it would require
considerably more work, there's a reason why writers sometimes chose to
rewrite entire chapters, and it's because every effort to improve the
text as an author would be translated into less effort for the
potentially millions of readers.

It's a multiplicative effect.

Sure, programmers don't have millions of readers, but I think it makes
sense to do 2x the effort as a patch author to receive 4x the review
(at least).

Cheers.

-- =

Felipe Contreras=
