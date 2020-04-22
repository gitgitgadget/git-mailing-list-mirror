Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A023C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4969E2071E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QcS1PJt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDVUlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVUlT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 16:41:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568FC03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:41:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h69so1687111pgc.8
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJykU29O1lCCF9pmeqC0wH8PzuSswNxY5KEaMz8L+r4=;
        b=QcS1PJt5j+YgobyGuR8rtX+dquthf7GwDG57zAJFRdx62wSJg7+A9oK0JMDg2LabI9
         I5mOzZpU9Q/F3aYNRb3NCK7BHoOw8R8q1qZX8lPkAMQ5X1QHBRz/rG9YbwQKsRwNwUKB
         41GkqFanhpWXQD7FO/jrF36nbv/WjJ7gnfOfhcWylBkEZgBdg08bwNxuUePSpDF5SdQ3
         trFq0anhp8wuziiUGGjFqCvJaVFei6gDViILDE3/GUmEbQcFnePNg11wKoGkjSVGDVG4
         9huPKUzS7ENkm9YZVehU/vZXUmClWeHx+8FH+FzBZ5muSkNmjoyLFtOLES7olZEEJMj+
         1q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJykU29O1lCCF9pmeqC0wH8PzuSswNxY5KEaMz8L+r4=;
        b=lK9Q7b1GAfoclNIbjW28KRYvl9MVteKb7UUGNGGPJ6EXMKz8MWdA6gHbd7RBzy3s6t
         j33LgkalFfCNtTWqulYupc6aSxJyEPTgjlItSmsqzQ0rSZXzsFBovXlH41OGikRvx8TA
         tis3yXPXBv/wnbL+P/dH58RvpaFp9j933KK9OaYxF+/fZkldLHwwaZ006ZlLx28sVd2K
         95lgWRLzseUVJA8ZJULCgyGVZlfM8BxJS9mwA2NapKnGe+gcvo/J7PLKUiZikoUWm5Do
         mrt9wpjzsYerHB5t593QMW2C+smVLW5amaiVrX6svhPtE0uFtkdxMWQc5ipyQYRipYOp
         vrPg==
X-Gm-Message-State: AGi0PuZBn57PZsPDImYrjEbpacn6+N4Df+1ScVacB8HJYKUpDSOz/D84
        gozYOTxss2sXgl+/rqb4DDDe5w==
X-Google-Smtp-Source: APiQypLZfsodaDYaNYSJOEiq0H8BXlfWBXHtxtYKGAQh8l7tCTqvcoz7ffgTLxqzxDpkgDzUZ0tGsw==
X-Received: by 2002:a63:545:: with SMTP id 66mr879182pgf.66.1587588077650;
        Wed, 22 Apr 2020 13:41:17 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x4sm381005pfj.76.2020.04.22.13.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:41:16 -0700 (PDT)
Date:   Wed, 22 Apr 2020 14:41:14 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git <git@vger.kernel.org>, James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200422204114.GA4850@syl.local>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <20200318101825.GB1227946@coredump.intra.peff.net>
 <CAP8UFD3v_J3zGqHKa94d71QB82hTsX0MZasERB-jOnY3Ya-uJw@mail.gmail.com>
 <20200417174030.GB2103@syl.local>
 <20200417180645.GJ1739940@coredump.intra.peff.net>
 <CAP8UFD0kqSQAnpfUxqDn_qwigQZhq7zyxY_CZhd1nJzqHT1cqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0kqSQAnpfUxqDn_qwigQZhq7zyxY_CZhd1nJzqHT1cqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 02:34:18PM +0200, Christian Couder wrote:
> On Fri, Apr 17, 2020 at 8:06 PM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Apr 17, 2020 at 11:40:30AM -0600, Taylor Blau wrote:
> >
> > > > What do you think about something like:
> > > >
> > > > [promisorFilter "noBlobs"]
> > > >         type = blob:none
> > > >         uploadpack = true # maybe "allow" could also mean "true" here
> > > >         ...
> > > > ?
> > >
> > > I'm not sure about introducing a layer of indirection here with
> > > "noBlobs". It's nice that it could perhaps be enabled/disabled for
> > > different builtins (e.g., by adding 'revList = false', say), but I'm not
> > > convinced that this is improving all of those cases, either.
> >
> > Yeah, I don't like forcing the user to invent a subsection name. My
> > first thought was to suggest:
> >
> >   [promisorFilter "blob:none"]
> >   uploadpack = true
> >
> > but your tree example shows why that gets awkward: there are more keys
> > than just "allow this".
>
> I like your first thought better than something that starts with
> "uploadPack". And I think if we let people find a subsection name (as
> what I suggest) they might indeed end up with something like:
>
> [promisorFilter "blob:none"]
>      type = blob:none
>      uploadpack = true
>
> as they might lack inspiration. As filters are becoming more and more
> complex though, people might find it much simpler to use the
> subsection name in commands if we let them do that. For example we
> already allow:
>
> git rev-list --filter=combine:<filter1>+<filter2>+...<filterN> ...
>
> which could be simplified to:
>
> git rev-list --filter=combinedFilter ...
>
> (where "combinedFilter" is defined in the config with
> "type=combine:<filter1>+<filter2>+...<filterN>".)
>
> [...]

I really think that we're getting ahead of ourselves here. For now, I
don't think that we have powerful enough filters that it makes sense to
put them together with combine and give them meaningful names. At least,
no one has asked about such a thing on the list, which I take to mean
that people don't have a use for it.

I'm also skeptical about relying on named filters when working with a
server. If the server defines the filter names (as we at GitHub would
do under this proposal), then what use are they to the client? For the
server, I'm not at all convinced that this is beneficial: the extra
layer of indirection through the configuration makes this brittle and
hard-to-follow.

Not to mention that the server could just as easily spell out the whole
filter.

I'm not trying to give you a too-simple proposal, but I think yours
introduces additional complexity that is trying to enable use-cases that
we don't have in practice.

> > > We're not using them, but without them we suffer from a problem that if
> > > we can get a SIGPIPE when writing the "sorry, I don't support that
> > > filter" message back to the client, then they won't receive it.
> > >
> > > Szeder's patches help address that issue by catching the SIGPIPE and
> > > popping off enough from the client buffer so that we can write the
> > > message out before dying.
> >
> > I definitely think we should pursue that patch, but it really can be
> > done orthogonally. It's an existing bug that affects other instances
> > where upload-pack returns an error. The tests can work around it with
> > "test_must_fail ok=sigpipe" in the meantime.
>
> Ok, maybe I will take a look a this one then.

Thanks.

> Thanks,
> Christian.

Thanks,
Taylor
