Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215D520A40
	for <e@80x24.org>; Sat,  2 Dec 2017 18:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbdLBS3e (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 13:29:34 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:41922 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbdLBS3d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 13:29:33 -0500
Received: by mail-it0-f51.google.com with SMTP id x28so5904458ita.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a4Uov+bmO6M4RBYPSAzHDqDKn3GpaADV0gwREMS+XZE=;
        b=uiqBhQw82PUxKb+xD+m8LW08ZPCzFSWIPK2uj56Uafpc/ACr9l3JDSQY1rR3Bxxqp4
         BB9gsYXLaHlLjvZwFAw41maHjHCJ6mjeJqUdZF99WJf85JDMdkLKHl5pNZin1aNim6cY
         u+3UNzhfstFuCEjeYh1NIJCfEDz+XhwWFTfGgVsOB2C99m4zHUG1lsf0zjeCCfwdvRma
         E6iyF+YULdBdgsExdy/+ShGbG/awm25h/ikbEaeW2lM4SaOC4l4tyQVLJ3ehcrDYDgZE
         7/pfQPfJTsa05VOg2m0/Cw7iiGgsZWlNtgqj81NlrzBT7r29SmCbifF31BnHCRTe5RCk
         MmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a4Uov+bmO6M4RBYPSAzHDqDKn3GpaADV0gwREMS+XZE=;
        b=sRjDZtxCFJH5Qp46GL+XZdf/aJNjZ8OylWHWQ3ZQHChkFqd4NFI7yRHwqw57dNWzxA
         zugbzT89mZ4WfBRC5wg/IwSTgsiBMNlxkatt0TndlHPqhhCRPeOLiEI88yK1BYkEt5DI
         w316tHTDo0qhd6+Xps/BiIZzaypDYe441taP9Jy9nYrOojTxD7FVviz+wPfhEe9Fad5Q
         BBw46TLfUwO84J75KcUi3HsM3zhbfbDoqnh3YE5Aa5iCPpBP0fP2VU8zXh2rHLhMJiOF
         3wJv6MHNiRpoyY/55zdmvicK1yluU2LT0DRQkFNuuqZS/P/gc6pLc4pp7Yx4QinHaVS9
         PE0Q==
X-Gm-Message-State: AKGB3mIQw2qeVKp/kKtL/dlEpbGjg/SE+tsOYFRPGHYEAMBQ0jYFQPGf
        16cH+VltC5LpskY6DzeE151XYyQwx3nx6fJh4Qg=
X-Google-Smtp-Source: AGs4zMY+dkvfIqVeLKcRlLDGq9kHZimHLbC6l+YHWh/vm46hsERfaC1Q6MTu2VQIWNtyjfQJhcM6h1bA6AEZsBczjb8=
X-Received: by 10.36.228.68 with SMTP id o65mr7280081ith.128.1512239372114;
 Sat, 02 Dec 2017 10:29:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sat, 2 Dec 2017 10:29:31 -0800 (PST)
In-Reply-To: <20171121210720.21376-9-git@jeffhostetler.com>
References: <20171121210720.21376-1-git@jeffhostetler.com> <20171121210720.21376-9-git@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 2 Dec 2017 19:29:31 +0100
Message-ID: <CAP8UFD2Q075aKG0yEbOy-W2+NSa6n8AEVu=yWn9q=xSnQwn5=g@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] sha1_file: support lazily fetching missing objects
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 10:07 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> From: Jonathan Tan <jonathantanmy@google.com>

> diff --git a/sha1_file.c b/sha1_file.c
> index 10c3a00..fc7718a 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -29,6 +29,7 @@
>  #include "mergesort.h"
>  #include "quote.h"
>  #include "packfile.h"
> +#include "fetch-object.h"
>
>  const unsigned char null_sha1[GIT_MAX_RAWSZ];
>  const struct object_id null_oid;
> @@ -1144,6 +1145,8 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>         return (status < 0) ? status : 0;
>  }
>
> +int fetch_if_missing = 1;
> +
>  int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
>  {
>         static struct object_info blank_oi = OBJECT_INFO_INIT;
> @@ -1152,6 +1155,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>         const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
>                                     lookup_replace_object(sha1) :
>                                     sha1;
> +       int already_retried = 0;
>
>         if (!oi)
>                 oi = &blank_oi;
> @@ -1176,28 +1180,36 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>                 }
>         }
>
> -       if (!find_pack_entry(real, &e)) {
> -               /* Most likely it's a loose object. */
> -               if (!sha1_loose_object_info(real, oi, flags))
> -                       return 0;
> +retry:
> +       if (find_pack_entry(real, &e))
> +               goto found_packed;
>
> -               /* Not a loose object; someone else may have just packed it. */
> -               if (flags & OBJECT_INFO_QUICK) {
> -                       return -1;
> -               } else {
> -                       reprepare_packed_git();
> -                       if (!find_pack_entry(real, &e))
> -                               return -1;
> -               }
> +       /* Most likely it's a loose object. */
> +       if (!sha1_loose_object_info(real, oi, flags))
> +               return 0;
> +
> +       /* Not a loose object; someone else may have just packed it. */
> +       reprepare_packed_git();
> +       if (find_pack_entry(real, &e))
> +               goto found_packed;
> +
> +       /* Check if it is a missing object */
> +       if (fetch_if_missing && repository_format_partial_clone &&
> +           !already_retried) {
> +               fetch_object(repository_format_partial_clone, real);
> +               already_retried = 1;
> +               goto retry;
>         }
>
> +       return -1;
> +
> +found_packed:
>         if (oi == &blank_oi)
>                 /*
>                  * We know that the caller doesn't actually need the
>                  * information below, so return early.
>                  */
>                 return 0;
> -
>         rtype = packed_object_info(e.p, e.offset, oi);
>         if (rtype < 0) {
>                 mark_bad_packed_object(e.p, real);

The above is adding 2 different gotos into this function while there
are quite simple ways to avoid them. See
https://public-inbox.org/git/CAP8UFD2THRj7+RXmismUtUOpXQv4wM7aZsejpd_FHEOycP+ZJA@mail.gmail.com/
and the follow up email in the thread.
