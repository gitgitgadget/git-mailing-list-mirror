Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B99C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 20:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbjEOUtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjEOUtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 16:49:04 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144288694
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:49:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba76528fe31so451686276.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684183742; x=1686775742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIYYEA8s30USZLKCDmV3aUD3ycztOAYpBBlNTHEAoQY=;
        b=4AkoPsNB34soFJDGJdoDKg/C12tTZStq8nri8J9u3Fa0OUeDJdQ5Yw88kJUf0LLyAj
         XxTOjAXVFRDKJb8abkkbmlENF/xtNoagXPuVPC1adQWP8K4aMvWs9PCTxeBDLoxwBf4H
         w1EhPRkC4lZqJSFA8ZNKHGfWv/KpbjLXo57R7rZavPrKzGZ8faA5KA6l3JUxH2KMk8qL
         T5G1RlVKDcdlJpdj2+YqAji1N8Pbh/aKgqN3zgjCpL2WL5YjmICWB77oMPYWS93818NN
         HXNm0ZyJZ9uirECaU8jL9yrVEPCzujV8O2A0QBRnm8xTkl+MuD6GxUaiFpDYFXISY6A7
         A88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684183742; x=1686775742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIYYEA8s30USZLKCDmV3aUD3ycztOAYpBBlNTHEAoQY=;
        b=TfmIvadqZHecWguLRD9f2ru1mWiY3f8YC0HojQfNeYaa6o496BO3uLcJIPssAVyfMl
         4NWTAGLPI8sO7OO9Z2ROCrHDoi7OKtE5zIBnroAbIE5jrK9iw2YpaiTcSOBBhLFG5VfX
         LynnUl5j+vlNpt8Lq/ITN399V3VW7Su14mTeeB7mkyiV+jFvyL5HglLelk/iXYo7TN+i
         9zJsoGoVWyI3V1tr+P6RyvnFcgSSrkV+vW2D/XiG4KXaRlY6X0dF13pD7UxEqF6r6Iyb
         fAqax9lZK/2WeoYQb9LfYjROyDC3KW/2Hk2Mh99+yDaB4xEZpRIGQA8CLM6p8hmTsHf6
         YEJw==
X-Gm-Message-State: AC+VfDwWE2vz+tVKQ7IJHCCnAodzl/wkyR0ryzYTp0oy84+81XxUKIc7
        0up6aiWBjd8gCYIcDQwK842rozkaGwULGmm0kuUqvA==
X-Google-Smtp-Source: ACHHUZ79cePYNrdErRaB6xd79W1ZX8R/iKum2Fzfa+sG1KyEBue43vwVeFChGg+6i8c26cNRMGtIug==
X-Received: by 2002:a81:8347:0:b0:55a:8293:e387 with SMTP id t68-20020a818347000000b0055a8293e387mr32657708ywf.19.1684183742224;
        Mon, 15 May 2023 13:49:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r66-20020a0de845000000b0055d6ae09dedsm55812ywe.127.2023.05.15.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:49:01 -0700 (PDT)
Date:   Mon, 15 May 2023 16:49:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <ZGKavGdYrFvjVex7@nand.local>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512212456.GA2495860@coredump.intra.peff.net>
 <20230512214542.GB2495860@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512214542.GB2495860@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 05:45:42PM -0400, Jeff King wrote:
> On Fri, May 12, 2023 at 05:24:56PM -0400, Jeff King wrote:
>
> > > This patch introduces a new configuration, `pack.recentObjectsHook`
> > > which allows the caller to specify a program (or set of programs) whose
> > > output is treated as a set of objects to treat as recent, regardless of
> > > their true age.
> >
> > I was going to complain about putting this in the "pack" section,
> > because I thought by touching reachable.c, we'd also affect git-prune.
> > But I don't think we do, because it does its own direct mtime check on
> > the loose objects.
> >
> > But I'm not sure that's the right behavior.
> >
> > It feels like even before your patch, this is a huge gap in our
> > object-retention strategy.  During repacking, we try to avoid dropping
> > objects which are reachable from recent-but-unreachable things we're
> > keeping (since otherwise it effectively corrupts those recent objects,
> > making them less valuable to keep). But git-prune will happily drop them
> > anyway!
> >
> > And I think the same thing would apply to your hook. If the hook says
> > "object XYZ is precious even if unreachable, keep it", then git-prune
> > ignoring that seems like it would be a source of errors.
> >
> > I suspect both could be fixed by having git-prune trigger the same
> > add_unseen_recent_objects_to_traversal() call either as part of
> > the perform_reachability_traversal() walk, or maybe in its own walk (I
> > think maybe it has to be its own because the second walk should avoid
> > complaining about missing objects).
>
> <phew> I am happy to say that I was wrong here, and git-prune behaves as
> it should, courtesy of d3038d22f9 (prune: keep objects reachable from
> recent objects, 2014-10-15). The magic happens in mark_reachable_objects(),
> which handles walking the recent objects by calling...you guessed it,
> add_unseen_recent_objects_to_traversal().

Phew. Thanks for digging into it before I was able to respond. I'm glad
that this works (though I agree that we should add a test).

> So it does the right thing now, and your patch should kick in
> automatically for git-prune, too. But I think we'd want two things:
>
>   1. Should the config variable name be made more generic to match?
>      Maybe "core" is too broad (though certainly I'd expect it to apply
>      anywhere in Git where we check recent-ness of objects), but perhaps
>      "gc" would make sense (even though it is not strictly part of the
>      gc command, it is within that realm of concepts).

"core" does feel pretty broad. There's some precedence for adding
hook-like configuration there, at least with
`core.alternateRefsCommand`. But I think that was an appropriate choice
given the scope of that feature.

I think that calling it "gc.recentObjectsHook" makes the most sense.

>   2. We probably want a test covering git-prune in this situation.

Yup.

Thanks,
Taylor
