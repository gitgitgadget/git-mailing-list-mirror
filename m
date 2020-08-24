Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA9C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CBD205CB
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBQg5W/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHXPsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHXPsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 11:48:06 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B263C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:48:06 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a13so4686532vso.12
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YI97j0wwLGb+zfiINiC0jr2x4uXRWkTbg46K5fo/WQI=;
        b=vBQg5W/DhQUA8ihzeOzQFq6TTo+OzXhM7bh9GXnZB3qK3lgKBv+rp8yY4i46Dx1QyK
         0McvofTtC3TzeJlrpB5SukS70ldn8bnvxyYrTDjEDyvu3mWSJA3wi03qEyYdw7p5Tbmz
         xdgDoQjPY+FTgjUoLqlZaflo12YuYOaPgaoz7ZTSwp/n7+WnvyfnMf0BxzPj4QuCW2cC
         n3UQqGm7Z7VzXO8aTHdbdzhPalrpKo+AymVD9EsSSjSTtrmJMvHsLaLXFJUF+CUF/J/7
         uXOWgf/batkMxSaee9HS3neteSqkyPiwQNgrEkp5wWEoDRA1l7zDLjEkoj08u/QJ+DUy
         3TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YI97j0wwLGb+zfiINiC0jr2x4uXRWkTbg46K5fo/WQI=;
        b=FGRdTrYuPvEY/Ut7fFiR95A4Gjgzo6QwH1caWUSqQOSZ3mtCe8I2fb/YWnnpfvQt9N
         4kqRyxeBgEpyofRrBZO6ZsiGe42kgrAju5sPispzXl9BGVfCyhsXQ8USc3IoEAB1WHyH
         U2fJ5eqcAK2mvrveFGx1WSn533yPBqhifqfmyKgwKElk55unRYg6Fn0ury0DdYpUXjZb
         52Sky7vc4ECbvwyqKg83mNZly/tcukRpPjkfI2M26j5NTtv5ys7EYG6Xv40FcQNzBISE
         QE3LzGZooIoCLhI7nCUb9bsjJC8aYdldn5qrCPMxgKAU8Qp/1F5f3JjdCR6MZL8Ak7Yy
         yB+w==
X-Gm-Message-State: AOAM533g7Hrym4iEe/mY6ww6HMAkmKF+WsSmnSCJ07CDeTGCBvPmQwID
        8yDJWKbYpW+RIAdi5Z1Y+qzaoa/ceKGq/H7nMxo=
X-Google-Smtp-Source: ABdhPJwFil9fhwXNJxKySclL4pKzZ3ctBl7pnfjj1FTe3yAp9LoYv/avLoildor3hDWNT5UAC1fIBiNDaFcC3TrrkUY=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr3044038vsn.54.1598284085370;
 Mon, 24 Aug 2020 08:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200821215247.758978-1-jacob.e.keller@intel.com>
 <20200821215247.758978-2-jacob.e.keller@intel.com> <nycvar.QRO.7.76.6.2008221528170.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2008221528170.56@tvgsbejvaqbjf.bet>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 24 Aug 2020 08:47:54 -0700
Message-ID: <CA+P7+xp9CEO_wLbqvg26cTWV45mniMwJyJkY8xEmMTqLOWjoSw@mail.gmail.com>
Subject: Re: [RFC v2 1/1] refspec: add support for negative refspecs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 23, 2020 at 1:29 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Jake,
>
> On Fri, 21 Aug 2020, Jacob Keller wrote:
>
> >  static void query_refspecs_multiple(struct refspec *rs,
> >                                   struct refspec_item *query,
> >                                   struct string_list *results)
> >  {
> > -     int i;
> > +     int i, matched_negative = 0;
> >       int find_src = !query->src;
> > +     struct string_list reversed = STRING_LIST_INIT_NODUP;
> > +     const char *needle = find_src ? query->dst : query->src;
> > +     char **result = find_src ? &query->src : &query->dst;
> >
> >       if (find_src && !query->dst)
> >               BUG("query_refspecs_multiple: need either src or dst");
> >
> > +     /*
> > +      * If a ref matches any of the negative refspecs, then we should treat
> > +      * it as not matching this query. Note that negative refspecs apply to
> > +      * the source but we're checking only the destination. Reverse and
> > +      * capture any pattern refspecs in order to see if the source would
> > +      * have matched a negative refspec.
> > +      */
> > +     for (i = 0; i < rs->nr; i++) {
> > +             struct refspec_item *refspec = &rs->items[i];
> > +             char *expn_name;
> > +
> > +             if (refspec->negative)
> > +                     continue;
> > +
> > +             /* Note the reversal of src and dst */
> > +             if (refspec->pattern) {
> > +                     const char *key = refspec->dst ?: refspec->src;
>
> This breaks at least with Visual C. I need this to unbreak the build:
>


The provided fixup! looks good to me. I'll pull it in when making the
next revision.

Thanks,
Jake

> -- snipsnap --
> Subject: [PATCH] fixup! refspec: add support for negative refspecs
>
> The `?:` operator is not supported e.g. by Visual C. Let's not use it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  remote.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 940622e0ba88..8e081863c06d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -731,7 +731,7 @@ static void query_refspecs_multiple(struct refspec *rs,
>
>                 /* Note the reversal of src and dst */
>                 if (refspec->pattern) {
> -                       const char *key = refspec->dst ?: refspec->src;
> +                       const char *key = refspec->dst ? refspec->dst : refspec->src;
>                         const char *value = refspec->src;
>
>                         if (match_name_with_pattern(key, needle, value, &expn_name))
> @@ -795,7 +795,7 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
>
>                 /* Note the reversal of src and dst */
>                 if (refspec->pattern) {
> -                       const char *key = refspec->dst ?: refspec->src;
> +                       const char *key = refspec->dst ? refspec->dst : refspec->src;
>                         const char *value = refspec->src;
>
>                         if (match_name_with_pattern(key, needle, value, &expn_name))
> --
> 2.28.0.windows.1
>
