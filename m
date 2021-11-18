Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55D6C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B3D6126A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 05:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbhKRF7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 00:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbhKRF7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 00:59:37 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B9C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:56:37 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id jo22so3791576qvb.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 21:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFWfwYbTHzGoEyniE6CrACwReuzmFUpiLWNidmAU0tk=;
        b=jVihrEjI64JlfvuNwu+85UrT9IfVR1B3CFlw7cLg/MXAyGEP3lf3KItgAx1m2vKq+K
         Y5IVVWV27HyD35ynnI///FACrzpNmTVKm2oiAUfHyFhEy2iVnmKYk+gJl+LgMNEqslNJ
         9PG5GsJX/ojFsiVWneF0y6Erw5MAFO3GBAmDQZB+e300Pkf1jvU/wetk+ihToyZrRoug
         vlyHKQYM1RVKCwUhFmkaWYPPZ3aruXiylYCObbM3ChRC0VOkl2YBbiOShKZM6FTqpTCH
         NsRaXD3LPyIihQwjqqc/XbmV1ExkhZEwu6tVayT79uSc5MYTgA8HQEP/HOYnKO+Tma/3
         9MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFWfwYbTHzGoEyniE6CrACwReuzmFUpiLWNidmAU0tk=;
        b=z80BkR6AkmucmgrPCbzSYyQqVV/Lrh1wyPLtFLO72GQRZ8WNSWJ6OoNivVmsifClEX
         4nmabaXL6w3wp6+6ZrtJ5Y/XRr1iSKGP9AZLCDX7dzOd8JDcLtJDDyAWXL/gaYZCVjee
         UAFcDuEvisAV6Tiv4xE2fuNy2nW+c1LRgWRF7D19mROen1iSTnydI2xVJk+TnZJsvy0l
         Zu7zEWwgCrn/z/K+p1m4yJRAukkuolL/Xn0tIWzbRAVCW04/U50bWpdM/EpAehqyd672
         2HNRHIU44zXTIKKfkK18VbzXDreZYbJDV9VLFSE8blzQ2Zjca3150VAaS0IlZ7aJr/6T
         5Etw==
X-Gm-Message-State: AOAM5336xPy4rOe39LLM8f/KVjObLXT0dCawoq1zeNr3ES0FboTXPVWO
        oevLrwmOVlOzvrSfbS43sfNUn6mDbxpggOJD8w0=
X-Google-Smtp-Source: ABdhPJzvy+jwfp5qiZlr0wfoE5Nr9Nlfb99Qr6lN48Zq8Cz9VjN0J64RFDW2+I0b73GQnJFhfg0JZelmkmZsKqhcOR8=
X-Received: by 2002:a05:6214:2b0f:: with SMTP id jx15mr62764747qvb.62.1637214996203;
 Wed, 17 Nov 2021 21:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211112094010.73468-4-chiyutianyi@gmail.com>
In-Reply-To: <20211112094010.73468-4-chiyutianyi@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 18 Nov 2021 13:56:25 +0800
Message-ID: <CANYiYbF83iHZb=kr-yAwp8rBPx47e6O=80Avp23092f8J1m2RA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] object-file.c: read input stream repeatedly in write_loose_object()
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 12, 2021 at 5:43 PM Han Xin <chiyutianyi@gmail.com> wrote:
>
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> Read input stream repeatedly in write_loose_object() unless reach the
> end, so that we can divide the large blob write into many small blocks.

In order to prepare the stream version of "write_loose_object()", we need ...

>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 8393659f0d..e333448c54 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1891,7 +1891,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>         static struct strbuf tmp_file = STRBUF_INIT;
>         static struct strbuf filename = STRBUF_INIT;
>         const char *buf;
> -       unsigned long len;
> +       int flush = 0;
>
>         if (is_null_oid(oid)) {
>                 /* When oid is not determined, save tmp file to odb path. */
> @@ -1927,12 +1927,16 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>         the_hash_algo->update_fn(&c, hdr, hdrlen);
>
>         /* Then the data itself.. */
> -       buf = in_stream->read(in_stream->data, &len);
> -       stream.next_in = (void *)buf;
> -       stream.avail_in = len;
>         do {
>                 unsigned char *in0 = stream.next_in;
> -               ret = git_deflate(&stream, Z_FINISH);
> +               if (!stream.avail_in) {
> +                       if ((buf = in_stream->read(in_stream->data, &stream.avail_in))) {

if ((buf = in_stream->read(in_stream->data, &stream.avail_in)) != NULL) {

Or split this long line into:

    buf = in_stream->read(in_stream->data, &stream.avail_in);
    if (buf) {

> +                               stream.next_in = (void *)buf;
> +                               in0 = (unsigned char *)buf;
> +                       } else
> +                               flush = Z_FINISH;

Add {} around this single line, see:

  https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L279-L289

> +               }
> +               ret = git_deflate(&stream, flush);
>                 the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
>                 if (!dry_run && write_buffer(fd, compressed, stream.next_out - compressed) < 0)
>                         die(_("unable to write loose object file"));
> --
> 2.33.1.44.g9344627884.agit.6.5.4
>
