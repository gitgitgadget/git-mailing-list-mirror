Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B24C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2787720707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p94KWuMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgA3O5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:57:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41878 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgA3O5i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 09:57:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so3736052oie.8
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 06:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFodYFGrlzoyzPHOP/Ff7qtDCaD5J6tdc9Avx8TyXLw=;
        b=p94KWuMNGnod3VNCtmhbVy8y4816w0DHYKeL/bH2bf+AGHHiKGRqJdBI9SCiQm2tbL
         8MH0hwNf0hIy1QC+1OrLSzA8IpzeGBbDjvBnqnkyoWU56dj0xj3akHFi1jE8sZUxKK2O
         ATADPVPe8rqBwML5ZGDYUdUHDPvzClScCU++8MDuwZTC7MzbLe9GkP4F530ygmZrpBeH
         MJyFFwKLjxjpeOOPShNVfqEJ3xjhUyvlPkwGqrU8nuNeMqaUPsmFFdEyEir0+duALTRt
         8MZp3q8MOWq7dUjhxY+vRqyiUTwYljfD+RpxqG+qzeI9HlxGiVgg0UkTZuTfdpOo8v7b
         /V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFodYFGrlzoyzPHOP/Ff7qtDCaD5J6tdc9Avx8TyXLw=;
        b=QW9Y2+VVuCrvD0Bf7ZgmVGgFJagMUrg5lgTnH2A62BgUZC6yEnS5rcM2b2UsEoquQU
         z+lTFCf5UVa72StDJRmIMbbsgWd+LjqRr1HZjWw2BMR9ShPyRBSTbe4smeFL8XYi1aUm
         k5XfJgesSZGBx1G9tv2/erEH1d1e+sDsOclb++6Y3PIjn3/dFzBSc4X8d1KwysI/NPCv
         IGPGba+n6KGuf8FbNGZcQwHNuwGYe3djQ8UlNG+UpUMdjb6sjzT5P1nmtX1uEhAdsHDU
         b3ONvUpxniKLHTZUHKl1MMZUhGNp2lUcKZvR5NLxavqefAIjc46yi6yGiAtnNEdgc/v6
         Rfhg==
X-Gm-Message-State: APjAAAVBC0RnLmoBT5lSQtm6y2avOhp1XaZ8up9hKDpa8y8Rq/x3SFBt
        /+gbCliagcTOPo9YJt7Xcif2CF1dBP8sWZuTGxmFsg==
X-Google-Smtp-Source: APXvYqyJAhqpYrnI3NvbbWYtDt8PPdsF8Ykbh0d/pJIEPlsSToKT8rDduVFtVnhnA1JRcXS67870Vy/b1OwU0UdAotI=
X-Received: by 2002:a05:6808:b18:: with SMTP id s24mr3022002oij.31.1580396257076;
 Thu, 30 Jan 2020 06:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20200130095155.GA839988@coredump.intra.peff.net> <20200130095338.GC840531@coredump.intra.peff.net>
In-Reply-To: <20200130095338.GC840531@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jan 2020 06:57:26 -0800
Message-ID: <CABPp-BE7E--8Yz3PAcjPQX2RCsbq0Q0gURi3RJuE64KM0eo6mA@mail.gmail.com>
Subject: Re: [PATCH 3/3] traverse_trees(): use stack array for name entries
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 1:54 AM Jeff King <peff@peff.net> wrote:
>
> We heap-allocate our arrays of name_entry structs, etc, with one entry
> per tree we're asked to traverse. The code does a raw multiplication in
> the xmalloc() call, which I find when auditing for integer overflows
> during allocation.
>
> We could "fix" this by using ALLOC_ARRAY() instead. But as it turns out,
> the maximum size of these arrays is limited at compile time:
>
>   - merge_trees() always passes in 3 trees
>
>   - unpack_trees() and its brethren never pass in more than
>     MAX_UNPACK_TREES
>
> So we can simplify even further by just using a stack array and bounding
> it with MAX_UNPACK_TREES. There should be no concern with overflowing
> the stack, since MAX_UNPACK_TREES is only 8 and the structs themselves
> are small.
>
> Note that since we're replacing xcalloc(), we have to move one of the
> NULL initializations into a loop.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>
> This does increase the coupling between tree-walk and unpack-trees a
> bit. I'd be OK just switching to ALLOC_ARRAY(), too. I doubt the
> performance improvement is measurable, and the cleanup free() calls are
> already there.

Could we undo this cyclic dependency between tree-walk and
unpack-trees by defining MAX_TRAVERSE_TREES in tree-walk.h, making
MAX_UNPACK_TREES in unpack-trees.h be defined to MAX_TRAVERSE_TREES,
and remove the include of unpack-trees.h in tree-walk.c?

>  tree-walk.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index d5a8e096a6..3093cf7098 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -410,15 +410,20 @@ int traverse_trees(struct index_state *istate,
>                    struct traverse_info *info)
>  {
>         int error = 0;
> -       struct name_entry *entry = xmalloc(n*sizeof(*entry));
> +       struct name_entry entry[MAX_UNPACK_TREES];
>         int i;
> -       struct tree_desc_x *tx = xcalloc(n, sizeof(*tx));
> +       struct tree_desc_x tx[ARRAY_SIZE(entry)];
>         struct strbuf base = STRBUF_INIT;
>         int interesting = 1;
>         char *traverse_path;
>
> -       for (i = 0; i < n; i++)
> +       if (n >= ARRAY_SIZE(entry))
> +               BUG("traverse_trees() called with too many trees (%d)", n);
> +
> +       for (i = 0; i < n; i++) {
>                 tx[i].d = t[i];
> +               tx[i].skip = NULL;
> +       }
>
>         if (info->prev) {
>                 strbuf_make_traverse_path(&base, info->prev,
> @@ -506,10 +511,8 @@ int traverse_trees(struct index_state *istate,
>                         if (mask & (1ul << i))
>                                 update_extended_entry(tx + i, entry + i);
>         }
> -       free(entry);
>         for (i = 0; i < n; i++)
>                 free_extended_entry(tx + i);
> -       free(tx);
>         free(traverse_path);
>         info->traverse_path = NULL;
>         strbuf_release(&base);
> --
> 2.25.0.515.gaba5347bc6

Looks good to me otherwise.
