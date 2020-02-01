Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F9C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FE520723
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 15:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHtU5+NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgBAPcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 10:32:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38614 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgBAPcO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 10:32:14 -0500
Received: by mail-ot1-f65.google.com with SMTP id z9so9515640oth.5
        for <git@vger.kernel.org>; Sat, 01 Feb 2020 07:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zo9Io2yOf1Sev4ZClwiiA4+I0iTuAXPpxed4/scxNqc=;
        b=NHtU5+NGEGSfc7CVhuvUlayz0ZsKOyB61Zlvlowj8ghTjdG6cJJjmWGnlblDWfHRPE
         iRDIHJOnBvQoBTAbOhosyavbaE8uKjiPiFM9p2IxOMvL2jtsS9bRbpYlPtScCA9/eUts
         e5eR8JadzhDoJh1+K1b8VJe3RWkmjnFtHQtsxNM+C7JRAjhghEzGKovZQCUN7fb1KDud
         w9/Sgp3swp/GdcYDz+MXUgzh85fMPuTz9DYf5TFFF35IwGkLkLPkbnczJI/+EFATIcih
         Nl+kdwPxFc6/+5xYA3C51JpXKG8xbMGidK7Ho+xu6+axXF/YH5jWSG+ISyl7NG5mDUsW
         SSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zo9Io2yOf1Sev4ZClwiiA4+I0iTuAXPpxed4/scxNqc=;
        b=ccjdO9pnG22MlNQ9gYE6fN9/B1EQvbIPf/TS9SlS3gyzB/pQmG6YRevHIQCgYcs1ti
         ss69zXPAYp4c3nED9o67+fPYUzQ3xTbnitQdg7dJd+voX6qzDFUcrwTmV2/mgPeJ1e35
         CGaP5xt5mma216PP8L5wBI7CY+k6pG2OsNbcivlASa7//AdQ3VuTfom5A6Ib+kkBC+Gc
         Gcu+LSZA4AP/CYQE68j/LQms+wiCeybpWOAi28yVuH/7TWJplsvHuEDEr+c4jcuQmaak
         gFE+jveYrBdkmbxk9IJ4UvE0GJn9KO20WAB+reJdzoOR1KaCfYrK5nHkPNs2CrVd7EOJ
         UjZw==
X-Gm-Message-State: APjAAAX4PzdhXJaRCoUqt4aqIeE8DFt25oC6n+cVOD7RC7mpUvwUNoi7
        LTnl0/o5dkPr4RbiyN6Syw1PsIzysi0iTkyrwKU=
X-Google-Smtp-Source: APXvYqzJltu7g9r14PZdw+wN+7OP7wC6nQEMRUITnsZa96VlvS+/dIgSEOHaf2YGdeROxTVw1UqBCIc+KKtzP4LRht4=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr12022525otp.316.1580571133205;
 Sat, 01 Feb 2020 07:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20200130095155.GA839988@coredump.intra.peff.net>
 <20200130095338.GC840531@coredump.intra.peff.net> <CABPp-BE7E--8Yz3PAcjPQX2RCsbq0Q0gURi3RJuE64KM0eo6mA@mail.gmail.com>
 <20200131092936.GA2916051@coredump.intra.peff.net> <CABPp-BFXwin5mR7z7Ocx9bq5LadFF4CxZR03HzZxh5f=1+F6NQ@mail.gmail.com>
 <20200201113922.GE1864948@coredump.intra.peff.net>
In-Reply-To: <20200201113922.GE1864948@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Feb 2020 07:32:02 -0800
Message-ID: <CABPp-BFPt7dcsc0a4jq1fisEszm=cmtk549rWgzyh2MpN1xMBw@mail.gmail.com>
Subject: Re: [PATCH] tree-walk.c: break circular dependency with unpack-trees
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 1, 2020 at 3:39 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 31, 2020 at 10:52:30AM -0800, Elijah Newren wrote:
>
> > As far as I can tell, before your change, we can remove the
> >    #include "unpack-trees.h"
> > from tree-walk.c; nothing uses it.  I do like snipping includes and
> > dependencies where they aren't necessary, and this one seems like one
> > that could be removed.
>
> Yeah, I think that is the case.
>
> > But, it's not a big deal; if you want to leave that for future work
> > for someone else (perhaps even asking me to turn my paragraph above
> > into a commit message that rips it out and defines one #define in
> > terms of the other), that's fine.
>
> Let's do it now while we're thinking about it. How about the patch below
> on top of my series?
>
> -- >8 --
> Subject: [PATCH] tree-walk.c: break circular dependency with unpack-trees
>
> The unpack-trees API depends on the tree-walk API. But we've recently
> introduced a dependency in tree-walk.c on MAX_UNPACK_TREES, which
> doesn't otherwise care about unpack-trees at all.
>
> Let's break that dependency by reversing the constants: we'll introduce
> a new MAX_TRAVERSE_TREES which belongs to the tree-walk API. And then we
> can define MAX_UNPACK_TREES in terms of that (since unpack-trees cannot
> possibly work with more trees than it can traverse at once via
> tree-walk).
>
> The value for both will remain at 8. This is somewhat arbitrary and
> probably more than is necessary, per ca885a4fe6 (read-tree() and
> unpack_trees(): use consistent limit, 2008-03-13), but there's not
> really any pressing need to reduce it.
>
> Suggested-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  tree-walk.c    | 3 +--
>  tree-walk.h    | 2 ++
>  unpack-trees.h | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index 3093cf7098..bb0ad34c54 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -1,6 +1,5 @@
>  #include "cache.h"
>  #include "tree-walk.h"
> -#include "unpack-trees.h"
>  #include "dir.h"
>  #include "object-store.h"
>  #include "tree.h"
> @@ -410,7 +409,7 @@ int traverse_trees(struct index_state *istate,
>                    struct traverse_info *info)
>  {
>         int error = 0;
> -       struct name_entry entry[MAX_UNPACK_TREES];
> +       struct name_entry entry[MAX_TRAVERSE_TREES];
>         int i;
>         struct tree_desc_x tx[ARRAY_SIZE(entry)];
>         struct strbuf base = STRBUF_INIT;
> diff --git a/tree-walk.h b/tree-walk.h
> index 826396c8ed..a5058469e9 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -3,6 +3,8 @@
>
>  #include "cache.h"
>
> +#define MAX_TRAVERSE_TREES 8
> +
>  /**
>   * The tree walking API is used to traverse and inspect trees.
>   */
> diff --git a/unpack-trees.h b/unpack-trees.h
> index ca94a421a5..ae1557fb80 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -6,7 +6,7 @@
>  #include "string-list.h"
>  #include "tree-walk.h"
>
> -#define MAX_UNPACK_TREES 8
> +#define MAX_UNPACK_TREES MAX_TRAVERSE_TREES
>
>  struct cache_entry;
>  struct unpack_trees_options;
> --
> 2.25.0.538.g1d5d7023b0

Looks great, thanks!
