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
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BF81F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 07:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfJKHkM (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 03:40:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44962 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfJKHkM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 03:40:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id r16so7768028edq.11
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trQh1wdOJX1tpPfDr3FoQYeT47h9WQwJfcXlJ9Nshiw=;
        b=HIEyMmjErgvXxWvsv17PZzjBaWt9xmdeIjsHUPWz0hE5rz9DPKJSGFkmmD7m1mkFun
         oyFt3OpaAyFJPhLZ2AKdsTfv+mzP8mYsYSZDzRv3SCUnmCdSSbWqIE6T6+MN8Qrn6ufF
         pVYA/LCgbJSSgWGBDBCLZsLbjzuYhjBZCOF43c+shlmKsX7B8zgXMdAMNdFxTdexiMSZ
         CgAJKhpbboQgo/UPCz1DKozmNijetWeScGZFsAkzVbO1eFiSWwr8Raud+g/yDXOD6pJ7
         SSFKOGxDiaxgS5T2diP8YiYZqr/+cB/Vv+ZFH2HTI24wA1Je0GneNww+eimTZoXEica6
         aIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trQh1wdOJX1tpPfDr3FoQYeT47h9WQwJfcXlJ9Nshiw=;
        b=I8ECr2iSmGQ/WeUSNjKqjT+djy1TbxfRWqjpPvGVD/Nj3vU2BGW/Xmi1LvZiU/9h3f
         YKOzvDuzjyB/S4D12zQqpfpquYR7Ru2/RfiO3+fsorzJ0RZWLbn81acPYa1o+s8B7KN3
         +zSU1T7C1hiIPthUgX4h5WE9PF+wWeOH0yPjzRfJJdAUSee+vIoQyqcORTWbsZDXI9BJ
         OWvcVU+GD/MvHCc1n4+3I6eWrKyKybiXAk6PD6Jw2NovAczB9swHx6RK/nZEt9MUr4rj
         EPcfhrqs8X47WHFp+TE1BMB5nwMs5R9WQ+7W+1BRIxL5u60mPh608OAXpNrU3YaoHBL2
         Y8Ag==
X-Gm-Message-State: APjAAAVpbdxey1o9cdcN5Y7ZarGz+kwxWehPIuuwWvmd4e7MHy71/gbR
        /etG8gTHzdp2isc7ntbEgFfeTJj5BGEuJ4VO9Aln0cGbM7o=
X-Google-Smtp-Source: APXvYqwtxVvOw0d8WNwZ0r/QD3LRWQ6JEMgEduAiQYbx1si7BOoo7AB7xkn1IG5PcGC2G2semYDhjsegyoBg44rOE70=
X-Received: by 2002:aa7:c48c:: with SMTP id m12mr12145453edq.280.1570779610515;
 Fri, 11 Oct 2019 00:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190913130226.7449-11-chriscool@tuxfamily.org> <20191010235952.174426-1-jonathantanmy@google.com>
In-Reply-To: <20191010235952.174426-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 11 Oct 2019 09:39:58 +0200
Message-ID: <CAP8UFD0yefCapgLG78bqBY0ZNWNiifJZUxQ=MGDa8AVJJrWBFg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 1:59 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> I'm going to start with pack-bitmap.h, then builtin/pack-objects.c.
>
> >  int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
> >                                      struct packed_git **packfile,
> > -                                    uint32_t *entries, off_t *up_to);
> > +                                    uint32_t *entries,
> > +                                    struct bitmap **bitmap);
>
> Makes sense. The existing code determines if the given packfile is
> suitable, and if yes, the span of the packfile to use. With this patch,
> we resolve to use the given packfile, and want to compute which objects
> to use, storing the computation result in an uncompressed bitmap.
> (Resolving to use the given packfile is not that much different from
> existing behavior, as far as I know, since we currently only consider
> one packfile at most anyway.)
>
> So replacing the out param makes sense, although a more descriptive name
> than "bitmap" would be nice.

Yeah, in pack-bitmap.c this argument is called "reuse_out", so the
same name could be used in pack-bitmap.c too. I changed that on my
current version.

> > +/*
> > + * Record the offsets needed in our reused packfile chunks due to
> > + * "gaps" where we omitted some objects.
> > + */
> > +static struct reused_chunk {
> > +     off_t start;
> > +     off_t offset;
> > +} *reused_chunks;
> > +static int reused_chunks_nr;
> > +static int reused_chunks_alloc;
>
> This makes sense - offsets may be different when we omit objects from
> the packfile. I think this can be computed by calculating the number of
> zero bits between the current object's index and the nth object prior
> (where n is the offset) in the bitmap resulting from
> reuse_partial_packfile_from_bitmap() above, thus eliminating the need
> for this array, but I haven't tested it.

Thanks for the idea. I will let others comment on that though before
maybe trying to implement it. I think it could come as a further
optimization in a following patch if it makes things faster or reduce
memory usage.

> > +                     if (0) {
> > +                             off_t expected_size = cur - offset;
> > +
> > +                             if (len + ofs_len < expected_size) {
> > +                                     unsigned max_pad = (len >= 4) ? 9 : 5;
> > +                                     header[len - 1] |= 0x80;
> > +                                     while (len < max_pad && len + ofs_len < expected_size)
> > +                                             header[len++] = 0x80;
> > +                                     header[len - 1] &= 0x7F;
> > +                             }
> > +                     }
>
> This if(0) should be deleted.

Yeah, good eyes. I removed it on my current version.

> > @@ -1002,6 +1132,10 @@ static int have_duplicate_entry(const struct object_id *oid,
> >  {
> >       struct object_entry *entry;
> >
> > +     if (reuse_packfile_bitmap &&
> > +         bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid))
> > +             return 1;
>
> Hmm...why did we previously not need to check the reuse information, but
> we do now? I gave the code a cursory glance but couldn't find the
> answer.
>
> > @@ -2571,7 +2706,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
> >
> >  static int obj_is_packed(const struct object_id *oid)
> >  {
> > -     return !!packlist_find(&to_pack, oid, NULL);
> > +     return packlist_find(&to_pack, oid, NULL) ||
> > +             (reuse_packfile_bitmap &&
> > +              bitmap_walk_contains(bitmap_git, reuse_packfile_bitmap, oid));
>
> Same question here - why do we need to check the reuse information?

Maybe a reuse bitmap makes it cheap enough to check that information?

Thank you for the review,
Christian.
