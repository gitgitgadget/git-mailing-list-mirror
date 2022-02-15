Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E048DC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 06:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiBOGng (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 01:43:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiBOGng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 01:43:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA775C24A3
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 22:43:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h18so8194572edb.7
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 22:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJ3iyu7BedDuxl1EejJvuJvWdxiFWUpxke6eI0e6YYQ=;
        b=VkbfiABDF6Wq1Qbk86rwDaEKr1sqMdLf1yF9+LuGXRzDHjx0b8YJNdvjc1KghVKy+D
         oegpDjFGFM2ytjpvGx0qlkUHmiFZWQiIe6edzPzOubIol57kRDtQ//eQZOZlMp9xSL0h
         CmEon7iTf1j+oOcT5ZGURcB4reGlPOMgwMQngWZeGcTA1M/Lbbo7JQRz0nDYjjypAdZL
         imGutfgt5DdLDOb7RVFoFfOmwPZxbf1rK5ekOcfBENnZRvmftSutamZQACw7cHDyaY5L
         xhVWUwFWhKkzbwEAB84S9M3oje1xqr0tQU5M0gRylSmYv6lhT++KecfBVYqs26FKhrnN
         RX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJ3iyu7BedDuxl1EejJvuJvWdxiFWUpxke6eI0e6YYQ=;
        b=OxefoTnsJ8KvtT96kHgPEgtNU1zJc0f3ymu6wK/y4LkwczuvKRs3QPc/ixbnUXgwtx
         sslg5zsMsiZTdvE+FTQil+XCDdsC9OU0bm6izvAaqb9Dzrzs0ICxjSPs5fuNJvHSFjQK
         j6ifam1MVc0AcAtO4YWeVLR7GQubwWH9TSaSy+ZRaMGRBkth6uEwCkrmW6ygJT6ITPIX
         f8kfo36FbYCqBx/TAy1rzn+9ktm0SsZNnrKGWcYYlH8Af7HBNsTnxyRBT/19gzUuPVaU
         aW0th2lmX77Eri+bZpsWNDLQkZrswP/9j1Bx2omiMqxiQ1Rb8CXcvSYc8NPPFAB9Y1uy
         +heg==
X-Gm-Message-State: AOAM532QMAOu3KzYfWWMDu+/XC59JDTDaCPWI0PqrCf/cykXwsKoKxUX
        XVdFSF0qfkTUU8nalXHGcDdyxG7yJ2kpIrpl/fY=
X-Google-Smtp-Source: ABdhPJxrFtQu68g2+7YBmEyoDyn6Z7pYrseT5zzwsi2+X0bCLeiOpY4aDx53BSKzQC0EzU247rYoqOm28eiXcO4DWfI=
X-Received: by 2002:a05:6402:2989:: with SMTP id eq9mr2410688edb.51.1644907405362;
 Mon, 14 Feb 2022 22:43:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <64c94e7a28d83fbaa1b6308b034d07c7be10e767.1644565025.git.ps@pks.im>
In-Reply-To: <64c94e7a28d83fbaa1b6308b034d07c7be10e767.1644565025.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Feb 2022 07:43:14 +0100
Message-ID: <CAP8UFD3RpeMcfTDV89gRjhaOsjjbPv3x_pFPqF-gO4Kpv51VtQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] fetch: backfill tags before setting upstream
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 5:12 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> The fetch code flow is a bit hard to understand right now:
>
>     1. We optionally prune all references which have vanished on the
>        remote side.
>     2. We fetch and update all other references locally.
>     3. We update the upstream branch in the gitconfig.
>     4. We backfill tags pointing into the history we have just fetched.
>
> It is quite confusing that we fetch objects and update references in
> both (2) and (4), which is further stressed by the point that we require

s/require/use/

> a `skip` label which jumps from (3) to (4) in case we fail to update the

s/`skip` label/`skip` goto label/
s/which jumps/to jump/

> gitconfig as expected.
>
> Reorder the code to first update all local references, and only after we
> have done so update the upstream branch information. This improves the
> code flow and furthermore makes it easier to refactor the way we update
> references together.

> @@ -1536,7 +1536,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map,
>  static int do_fetch(struct transport *transport,
>                     struct refspec *rs)
>  {
> -       struct ref *ref_map;
> +       struct ref *ref_map = NULL;
>         int autotags = (transport->remote->fetch_tags == 1);
>         int retcode = 0;
>         const struct ref *remote_refs;
> @@ -1618,11 +1618,22 @@ static int do_fetch(struct transport *transport,
>                 }
>         }
>         if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
> -               free_refs(ref_map);
>                 retcode = 1;
>                 goto cleanup;
>         }
>
> +       /* if neither --no-tags nor --tags was specified, do automated tag
> +        * following ... */

Maybe while at it this could be changed to use our usual style for
multi-line comments:

       /*
        * If neither --no-tags nor --tags was specified, do automated tag
        * following...
        */

> +       if (tags == TAGS_DEFAULT && autotags) {
> +               struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
> +
> +               find_non_local_tags(remote_refs, &tags_ref_map, &tail);
> +               if (tags_ref_map)
> +                       backfill_tags(transport, tags_ref_map, worktrees);
> +
> +               free_refs(tags_ref_map);
> +       }

> @@ -1676,21 +1687,9 @@ static int do_fetch(struct transport *transport,
>                                   "you need to specify exactly one branch with the --set-upstream option"));
>                 }
>         }
> -skip:

I like that it's removing one goto label and making the code simpler.
