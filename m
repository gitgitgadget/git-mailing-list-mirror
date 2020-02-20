Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D5DC11D04
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 10:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DBB24672
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 10:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPZ1733p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgBTKUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:20:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39423 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgBTKUV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 05:20:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id m13so33062463edb.6
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 02:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=20SB+3uVdwqt0LPsKDTrb798j6vDSWQdo7va30MBrfw=;
        b=iPZ1733pf64DZoq9FZn7HdKkZP2LmOtQCHdbDCyuw49RPPB0nQ8NRb92iotLB52HLm
         dvjLv+fUETvEoDjaYRIVhGn2P36Sd6oxf4gtM7dH11RResGdlMKDWGikzDFQt8bjWNPY
         qGCDCriTI0B9umJVVlNYBn65sIhJ/DjAuWgkY4t4ovOUsqXEZ8fwBJ8OU/EH1O4OeVKz
         hNRKEUyeF7JVkvXuLuW4TxbXEk7TNuS20Z+8yMXfKtPx7GyWfwF35s+BHUBotwkexv2N
         qHalEdpF6XJ4mNK7MYS0crpQJ2LodvYz/Vjz4UJY8JGvpPjrscFFddXH/4ZKSjccKOZ3
         wihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=20SB+3uVdwqt0LPsKDTrb798j6vDSWQdo7va30MBrfw=;
        b=UBeH6R+e7+qoZ4k/30RqueuJ/qTi70Ugo3vGvrpQDFbeMI11HcB7SsqUq37ia0NBWD
         7QMOEn3KBn2rvjGUHugBv1CGlknM9Gga5TsqBNW0bahr9rdx5zT2ckldANh2jZt9hyJS
         61b9HYU3vgC2mnYdkoj6JwNoYYgDys3T4ipDkmPkGE1evZCoNTrhdGJGGYUTIogMEpkh
         JQfjJbmRdiVMl1W6AjTghim6U8m39W+697+ozlSuyLmLTbYKoQakYMZsbNZv0lh9IDjk
         TM3BOGGeKeoi2GNPUAPjEtKkcghs1HB5nDmXKjyHgttf49Fhx7lZgMwR6HK3ckNAWz7D
         cTnA==
X-Gm-Message-State: APjAAAW2FuzmTLXjFMlGBwfebbYlM7wfncIMIEC8V56yqgdRmIoXHkfi
        RVPDzm9F+PqNmluBs3sOWzQWOdirkW5MNqOTgnc=
X-Google-Smtp-Source: APXvYqxxUiRevxUhCzmqISLXijz+D2F8aJQYsq7wRQTFtElml3C6MefBcsH+7dlq3oBfjEHC7Wuzq81b7tDqEm1knR4=
X-Received: by 2002:aa7:d3cd:: with SMTP id o13mr27029454edr.276.1582194019322;
 Thu, 20 Feb 2020 02:20:19 -0800 (PST)
MIME-Version: 1.0
References: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
 <4d17a541-3c5c-0cf3-6ea6-11c214aa4674@web.de> <CABVXwf404m9FdsoLxYxZriYT6uif_fsMs8B4dY4RmeQojqK9Wg@mail.gmail.com>
 <9ed26e7e-c19c-cdb2-0710-3b91bf31291b@web.de>
In-Reply-To: <9ed26e7e-c19c-cdb2-0710-3b91bf31291b@web.de>
From:   Manish Devgan <manish.nsit8@gmail.com>
Date:   Thu, 20 Feb 2020 15:50:07 +0530
Message-ID: <CABVXwf6mPXWof3RHshDo=FSX8dvqUYDFH6-ecaCXDi4KhY8QJQ@mail.gmail.com>
Subject: Re: Bug: Git: Clone: University Network: No Output on Terminal
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 12:54 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

> How about something like this?
>
> -- >8 --
> Subject: [PATCH] remote-curl: show progress for fetches over dumb HTTP
>
> Fetching over dumb HTTP transport doesn't show any progress, even with
> the option --progress.  If the connection is slow or there is a lot of
> data to get then this can take a long time while the user is left to
> wonder if git got stuck.
>
> We don't know the number of objects to fetch at the outset, but we can
> count the ones we got.  Show an open-ended progress indicator based on
> that number if the user asked for it.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  remote-curl.c |  1 +
>  walker.c      | 13 ++++++++++++-
>  walker.h      |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 8eb96152f5..e4cd321844 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1026,6 +1026,7 @@ static int fetch_dumb(int nr_heads, struct ref **to=
_fetch)
>
>         walker =3D get_http_walker(url.buf);
>         walker->get_verbosely =3D options.verbosity >=3D 3;
> +       walker->get_progress =3D options.progress;
>         walker->get_recover =3D 0;
>         ret =3D walker_fetch(walker, nr_heads, targets, NULL, NULL);
>         walker_free(walker);
> diff --git a/walker.c b/walker.c
> index bb010f7a2b..4984bf8b3d 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -8,6 +8,7 @@
>  #include "tag.h"
>  #include "blob.h"
>  #include "refs.h"
> +#include "progress.h"
>
>  static struct object_id current_commit_oid;
>
> @@ -162,6 +163,11 @@ static int process(struct walker *walker, struct obj=
ect *obj)
>  static int loop(struct walker *walker)
>  {
>         struct object_list *elem;
> +       struct progress *progress =3D NULL;
> +       uint64_t nr =3D 0;
> +
> +       if (walker->get_progress)
> +               progress =3D start_delayed_progress(_("Fetching objects")=
, 0);
>
>         while (process_queue) {
>                 struct object *obj =3D process_queue->item;
> @@ -176,15 +182,20 @@ static int loop(struct walker *walker)
>                  */
>                 if (! (obj->flags & TO_SCAN)) {
>                         if (walker->fetch(walker, obj->oid.hash)) {
> +                               stop_progress(&progress);
>                                 report_missing(obj);
>                                 return -1;
>                         }
>                 }
>                 if (!obj->type)
>                         parse_object(the_repository, &obj->oid);
> -               if (process_object(walker, obj))
> +               if (process_object(walker, obj)) {
> +                       stop_progress(&progress);
>                         return -1;
> +               }
> +               display_progress(progress, ++nr);
>         }
> +       stop_progress(&progress);
>         return 0;
>  }
>
> diff --git a/walker.h b/walker.h
> index 6d8ae00e5b..d40b016bab 100644
> --- a/walker.h
> +++ b/walker.h
> @@ -10,6 +10,7 @@ struct walker {
>         int (*fetch)(struct walker *, unsigned char *sha1);
>         void (*cleanup)(struct walker *);
>         int get_verbosely;
> +       int get_progress;
>         int get_recover;
>
>         int corrupt_object_found;
> --
> 2.25.1

This is great. But perhaps I would want the output to come
irrespective of --progress argument in case of dumb_http.

Thanks & Regards
Manish Devgan
