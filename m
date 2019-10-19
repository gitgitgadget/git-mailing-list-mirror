Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7611F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 19:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfJSTUZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 15:20:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33415 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfJSTUY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 15:20:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id c4so7065219edl.0
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPDmFeUsDJTYdUyuu239ACjGsaLGkkA4ZNd9ZNue9zE=;
        b=Ix9WS8Jli3pC6kiLlKcTddoQsFvc1QrnrzkwvlPJ6jBLjq7hsoX7lJ1QroDKv3YHIH
         UlFRuETQrvsaWwoZcYiZm+86g0Fdi7kVvTVO90wniON3cdy9W5jgEXuPtzPhlvzZcuDl
         yMEv/Z/KIAgOOgzUmTm3ZfW2nNHfcQzQw/WViHnqvCdEyayT45VphB43ZkzUr1ItGvx8
         Rp5lxix1eJqtKyxbk8/hxTPE25PAK3l05Z27iF8Q19oUYvDDjmxr8kiIiMFT4dpkfSQq
         G+qdDwuu+A0+bpvWyQqhqqo4pDFotbSGPuy9Ixe1ln+shRG/W6PIpcJH36p3UhduJW4H
         VViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPDmFeUsDJTYdUyuu239ACjGsaLGkkA4ZNd9ZNue9zE=;
        b=AFuB5VfWHYr4K2pfDlpRVTht3t6/hKv61s2Jv86AdT8vQecmPU5qtdPenv5Weo+CNx
         rv562c5NuJjbYr56B5pQssh4ORIP6/xxVcjVS7lHVcyXyLwnaYFzD6lWEGGNvzXSjBmy
         09xirPcjkSZ16tkMMEuUdRO3iE86aVrD1J1Xi7a6lRWRbgFHIAW3cDHBBo/89K/BOKSr
         rC0j1/0RDxP8x/SC+paJicwHD6Dws1roU3R8GHo6xx2snHvo5eafFoSk3CsbHOXc5TD2
         Tg4JTSnZQz1JwhzDL5tRzHDH5KOpVzR0A4cbXH8a2WuPBKV3gUGTniryKoktpFr1SyC6
         HiAw==
X-Gm-Message-State: APjAAAXjtY2xVImMolppdhcjgl5YvPVAW+o1UbS2Pc4Z4f243/eEbXN6
        YC1aBtF3niX1OcP54a3WVkiJvhqV4+zNz8jesd0=
X-Google-Smtp-Source: APXvYqzt7Uvj2uqEYy0cESn6kJmiJ2SX1sC7eGuakXzHLxJMHJzAT9xNyg/E80JH1vHtO0pnDwjRKW2SggpH3sEnqMY=
X-Received: by 2002:a17:907:2172:: with SMTP id rl18mr14683833ejb.125.1571512822944;
 Sat, 19 Oct 2019 12:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
 <20191019103531.23274-10-chriscool@tuxfamily.org> <6e4ad9bb-20d7-4ae5-8768-326f5c455c3c@iee.email>
In-Reply-To: <6e4ad9bb-20d7-4ae5-8768-326f5c455c3c@iee.email>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 19 Oct 2019 21:20:11 +0200
Message-ID: <CAP8UFD2rsZj3=KoPCEWw2sTXFhNkynrJLeAGWK2vEbD5GU8chA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] pack-objects: improve partial packfile reuse
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sat, Oct 19, 2019 at 5:30 PM Philip Oakley <philipoakley@iee.email> wrote:

> On 19/10/2019 11:35, Christian Couder wrote:

> > +static void write_reused_pack_one(size_t pos, struct hashfile *out,
> > +                               struct pack_window **w_curs)
> > +{
> > +     off_t offset, next, cur;
> > +     enum object_type type;
> > +     unsigned long size;
>
> Is this a mem_sized size or a counter for less that 4GiB items?

What I can see is that `&size` is passed as the last argument to
unpack_object_header() below. And unpack_object_header() is defined in
packfile.h like this:

int unpack_object_header(struct packed_git *, struct pack_window **,
off_t *, unsigned long *);

since at least 336226c259 (packfile.h: drop extern from function
declarations, 2019-04-05)

So fixing this, if it needs to be fixed, should probably be part of a
separate topic fixing unpack_object_header().

> > +
> > +     offset = reuse_packfile->revindex[pos].offset;
> > +     next = reuse_packfile->revindex[pos + 1].offset;
> >
> > -     if (reuse_packfile_offset < 0)
> > -             reuse_packfile_offset = reuse_packfile->pack_size - the_hash_algo->rawsz;
> > +     record_reused_object(offset, offset - hashfile_total(out));
> >
> > -     total = to_write = reuse_packfile_offset - sizeof(struct pack_header);
> > +     cur = offset;
> > +     type = unpack_object_header(reuse_packfile, w_curs, &cur, &size);
> > +     assert(type >= 0);

> > +static void try_partial_reuse(struct bitmap_index *bitmap_git,
> > +                           size_t pos,
> > +                           struct bitmap *reuse,
> > +                           struct pack_window **w_curs)
> >   {
> > +     struct revindex_entry *revidx;
> > +     off_t offset;
> > +     enum object_type type;
> > +     unsigned long size;
>
> Is this mem_sized or a <4GiB size?

Again this `size` variable is passed as the last argument to
unpack_object_header() below.

...

> Apologies if these are dumb queries..

I think it's a valid concern, so it's certainly ok for you to ask
these questions.
