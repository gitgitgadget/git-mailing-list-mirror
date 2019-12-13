Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC28C3437B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A3024747
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmuZAQT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLMN1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:27:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36440 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfLMN1U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:27:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so2046601edp.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAzf32pQJXWfc83vvVHPN/Tw21bdkR1UKCq3g1WS3rs=;
        b=OmuZAQT4Is1UmdWy9PZfxjUArtYci1miJ8FygGRXud5leJcLMXEay9JAnRPUiSYnHh
         pprP0XQjjifNqC7rV7RlWpLuCLXKUyYo0rgz30iZ9nUMsQFqa78nu83sUbcVOalU6k9p
         4UifK8dpsrq18cl9kG8T666GWShFNT34aMTyD1UwMGCSjfZBTISKpGC+eVtcrJj0HIGb
         /p2AUacZ2AYlTC29s/dcyqCAoxVbXprU0Gmy8kSSm294DfL5FbUVjgQhr1oOUfBbTB1G
         nkDugiZ5l+0QfoVNefP7vBHK2f2cQkCzV27o5Xboy1CD8nonCJF36TSkSr6AyG6jJ/Ec
         XMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAzf32pQJXWfc83vvVHPN/Tw21bdkR1UKCq3g1WS3rs=;
        b=lW/a91K3vQx+tZxScGoNIUJsbvVZ5pEBbYPl9R5zNJi0DEYhbrrTVcXT2eR2YpZjIo
         RsNGbUgLiqAut/zQ05ok2Oqzr9VE1n5q+j4eyqgSOrALMWSNjprYhrISfgmZsGfz3Dhb
         etjoNHXHrpJ2QXhic9luTGl2VO8KjISanyKX7pTheL7qX8TuxyvjmmmIBs7PxNrWjfah
         4+oO7vQ9JCsYKITUUZFplDkrr+YhVBpotzlU9oj6CO1qYdcn9X5vp/3zLaC3sMvJdnKT
         yhoNl/iOQyONR1JEatiNag+epKlky4HketaACpF+eqEp73atHC9qvZ08ZVjHleKVQRyk
         korQ==
X-Gm-Message-State: APjAAAW3GjPxrN5dHe/YN6BK7UyYK8Jf0h8xz583TNMnBgkqnxjvkUtE
        gmwr/ySyYar5OEwYlL30CM3K/xtMP6vF7BjGadk=
X-Google-Smtp-Source: APXvYqyz3iMwBuYxSrokgTel9LY3OnCB92+0Da5WiIA1CnzCjhXWPPqMWnhaJV2Swz34JR5r+Ma1pn7sv4+6rueeCMc=
X-Received: by 2002:aa7:d44a:: with SMTP id q10mr16006661edr.45.1576243638126;
 Fri, 13 Dec 2019 05:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-6-chriscool@tuxfamily.org> <20191209070642.GE40570@coredump.intra.peff.net>
In-Reply-To: <20191209070642.GE40570@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 13 Dec 2019 14:27:06 +0100
Message-ID: <CAP8UFD2dE6gtmuWNbQj7o7X=kQTgJzk=eWMa0kYJW85WTRcXQA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] pack-bitmap: introduce bitmap_walk_contains()
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 8:06 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 15, 2019 at 03:15:37PM +0100, Christian Couder wrote:

> > +int bitmap_walk_contains(struct bitmap_index *bitmap_git,
> > +                      struct bitmap *bitmap, const struct object_id *oid)
> > +{
> > +     int idx;
> > +
> > +     if (!bitmap)
> > +             return 0;
> > +
> > +     idx = bitmap_position(bitmap_git, oid);
> > +     return idx >= 0 && bitmap_get(bitmap, idx);
> > +}
>
> This is really a factoring out of code in
> bitmap_has_oid_in_uninteresting(). So I think you could simplify that
> like:
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index cbfc544411..f5749d0ab3 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1194,16 +1194,6 @@ void free_bitmap_index(struct bitmap_index *b)
>  int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
>                                     const struct object_id *oid)
>  {
> -       int pos;
> -
> -       if (!bitmap_git)
> -               return 0; /* no bitmap loaded */
> -       if (!bitmap_git->haves)
> -               return 0; /* walk had no "haves" */
> -
> -       pos = bitmap_position_packfile(bitmap_git, oid);
> -       if (pos < 0)
> -               return 0;
> -
> -       return bitmap_get(bitmap_git->haves, pos);
> +       return bitmap_git &&
> +              bitmap_walk_contains(bitmap_git, bitmap_git->haves, oid);
>  }

Yeah, nice simplification. I added a patch doing that.

> One curiosity is that bitmap_has_oid_in_uninteresting() only uses
> bitmap_position_packfile(), not bitmap_position(). So it wouldn't find
> objects which weren't in the bitmapped packfile (i.e., ones where we
> extended the bitmap to handle loose objects, or objects in other packs).
>
> That seems like a bug in the current code to me. I suspect nobody
> noticed because the only effect would be that sometimes we fail to
> notice that we could reuse a delta against such an object (which isn't
> incorrect, just suboptimal). I don't think p5311 would show this,
> though, because it simulates a server that is fully packed.
>
> I think it's probably still worth doing this as a preparatory patch,
> though:
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index e07c798879..6df22e7291 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1125,7 +1125,7 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
>         if (!bitmap_git->haves)
>                 return 0; /* walk had no "haves" */
>
> -       pos = bitmap_position_packfile(bitmap_git, oid);
> +       pos = bitmap_position(bitmap_git, oid);
>         if (pos < 0)
>                 return 0;

Yeah, I agree that it's a good idea to do it in a preparatory patch,
so I added a patch doing that before the one doing the simplification
you suggest above.
