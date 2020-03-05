Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549F9C3F2D7
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 07:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279A320870
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 07:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5kQHO87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgCEHDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:03:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41961 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEHDz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 02:03:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id m25so5448933edq.8
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 23:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O9//OUP72DwXEn3gKoX0gokT2JfgDDEmrcPKjTa331s=;
        b=A5kQHO870P4zWqUBRvO3K695ybug5AK9ZADED5oJ7MobRj5betfnMLyRPHLzmPqlHk
         zwmv63EsKzBz4h84dgKTgetk45hFQ6Nqcl0ciP8XR6p2QHeh8SqwKvTvTVBspESTDpcG
         Yd3yjtI1901T9SDdQU2mkrs7yc5AY8eBJSRG/QfzIBboISz5Hr4/KlP4KGYN+hpd5Y9A
         T9g2DjH0rf0sRuzXVMcTWcdXnUkuecEVK7RFrlfbzkJW6/VYpGgsr6kzGJE0WxJ6pszN
         AdSga4PbzO/r5wUvHpPgYbowlCv/854Stf/aDAWb7PjG9bJqW62/N+Kdeqrh6BY5g4on
         brCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O9//OUP72DwXEn3gKoX0gokT2JfgDDEmrcPKjTa331s=;
        b=koW4aK8IIyYnuCpyw1bvX1YOiBDnhXRySgxAuP/X3VydiPharE8VE5KJvaWHct8aRY
         xyS5m9gvhsKWFqW66PoArmYUZSgL0kJev2IAI7JZ5m5Qt13Yv1fjHJUVoazpjjQhi35J
         NQnwOXpO4PQTWldQcumS1YxqAsXqbkcZyiD3yR18U01TBoWq1BcHr+G0meUXjkW+3jfa
         W6TkN6zCQUcvDIxILSotTxoTtJXSp5qgclGk7tQuFVXabx3CDdvYW4ORwfe0GMUSJ4cE
         jfWLrbqN/KPYCUvrVqt7XJutn1l+c+RLDo/WfemaOYxor6nC6IkK7ULEGXdFlSFIGht6
         pMKA==
X-Gm-Message-State: ANhLgQ0yI4uRG55fCAGRl+I1ZmD1OWthPsRUHw4q+/FCDjqTFe/58J6E
        FGT36MPKhyFM6N3YWkZef/MAeWtXPuUm4Qsiwqsgby/IXGY=
X-Google-Smtp-Source: ADFU+vt5LOpxE9Va442tdw3zBJexTGUR8ccMwxtbOqcQRaPSBMImusnk9MATZ6emhCqVZ3dUi9IjWLcM2QJ0WYSAnNU=
X-Received: by 2002:a17:906:e251:: with SMTP id gq17mr6108953ejb.22.1583391833058;
 Wed, 04 Mar 2020 23:03:53 -0800 (PST)
MIME-Version: 1.0
References: <e387d31d-afab-fe09-4e37-535a2650afca@web.de>
In-Reply-To: <e387d31d-afab-fe09-4e37-535a2650afca@web.de>
From:   Manish Devgan <manish.nsit8@gmail.com>
Date:   Thu, 5 Mar 2020 12:33:44 +0530
Message-ID: <CABVXwf60wvnpqu8x4c4H+3iGUaz_FbJPTv7UgNOHhz1+KfsnTA@mail.gmail.com>
Subject: Re: [PATCH RESEND] remote-curl: show progress for fetches over dumb HTTP
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 4, 2020 at 2:25 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
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
> Original submission:
> https://lore.kernel.org/git/9ed26e7e-c19c-cdb2-0710-3b91bf31291b@web.de/
>
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


Thanks. This works for me.

Regards
Manish Devgan
