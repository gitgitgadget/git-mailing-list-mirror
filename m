Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21DA1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 09:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfJZJ3c (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 05:29:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34516 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfJZJ3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 05:29:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id b72so3844497edf.1
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5N0PUDt32rZqRzJM2QSije4fjqFav9SBtB2gXXJBB0=;
        b=twKOmwD4dYjh/VcuZlv3JC1ADb8S4RzGk9Ylr9be9zudKZzFqbtm9DNDbz0jprJWub
         XN4xEAp46qU4VdGR0JbLdLZRJrazYGcFW9q00E9XBWIvZLgPdtnagyD3FaaqcRxObKzT
         WtRZ/nIOJaBw4cR0G1R5wJeUBLtbAp5xtVcPKhV6S25ziRquEFNtDcOW/Ti+/x2aayEz
         NoKdl1qsZj+l9OJ7XYZpymR6vgJLkHPK/NjF3PXb6k1P/aulO3Ti54vmQnHfHGj1XBMe
         XY16LhWc12v/lJQxSaxq5ylz5EmKG2dteQsNTspdSp1QfIpof2ux1Td3q4XPQD4oIDZd
         gnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5N0PUDt32rZqRzJM2QSije4fjqFav9SBtB2gXXJBB0=;
        b=fxRU6+pWrMeGmgGuX8G6Vz2jaNWDcZXqjuXmj7fw1eymSX7XL7YnCXqkXSQSBEu/0L
         t/DwrGlKx/R4nr+/lm8OrxPDbuFxwukWCBFR/BFy6vGEmaXM4P3g5NlwF008y6qW6gtw
         TBApEoNNQKviRKKVK6bH6Sp6sn2+PDN3/ca9ElH76akpKMJY6IciAPXKb1LisGPcCRos
         FWreItvafpiM3fOePx5z6INudOp+1eF8rvx21ahU4LsVae96jA3hsXQjdd9Ps5N0LFMW
         sfdQj6faRfwMpkhUAvxXuv/e8NxQYcH8jYR0nwyGDmw50Qo3mhcf5P5M/WUupPqQK4wW
         5d9w==
X-Gm-Message-State: APjAAAVFaPKrPFobRQjuyssWE49bhq5aYZ9pzpxPym4BJDScf6eW8dlm
        vM9g9Ile4W4UHd/W1VmoTi66WVjileT/xqvfGJo=
X-Google-Smtp-Source: APXvYqy7qA0tRRx7CIsB5VSmq2x4wnW4LoGGqbCbvn/0uMG1Yiku/vWGf3fJ0Q2NXcvRAovJVEslf/Adnux/gLuITmg=
X-Received: by 2002:a17:906:5399:: with SMTP id g25mr7500744ejo.125.1572082169399;
 Sat, 26 Oct 2019 02:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191019103531.23274-10-chriscool@tuxfamily.org> <20191022194805.139215-1-jonathantanmy@google.com>
In-Reply-To: <20191022194805.139215-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 26 Oct 2019 11:29:17 +0200
Message-ID: <CAP8UFD0PfCb+NfPDZ36c9MLcOa2xN9C9viOEEaLrbeA8Y9Rd7A@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] pack-objects: improve partial packfile reuse
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 9:48 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> First, the commit message could probably be reordered to start with the
> main point (reusing of packfiles at object granularity instead of
> allowing reuse of only one contiguous region). To specific points:

Done in my current version.

> > The dynamic array of `struct reused_chunk` is useful
> > because we need to know not just the number of zero bits,
> > but the accumulated offset due to missing objects.
>
> The number of zero bits is irrelevant, I think. (I know I introduced
> this idea, but at that time I was somehow confused that the offset was a
> number of objects and not a number of bytes.)

Ok, I removed "not just the number of zero bits,".

> > If a client both asks for a tag by sha1 and specifies
> > "include-tag", we may end up including the tag in the reuse
> > bitmap (due to the first thing), and then later adding it to
> > the packlist (due to the second). This results in duplicate
> > objects in the pack, which git chokes on. We should notice
> > that we are already including it when doing the include-tag
> > portion, and avoid adding it to the packlist.
>
> I still don't understand this part. Going off what's written in the
> commit message here, it seems to me that the issue is that (1) an object
> can be added to the reuse bitmap without going through to_pack, and (2)
> this is done when the client asks for a tag by SHA-1. But all objects
> when specified by SHA-1 go through to_pack, don't they?

That's how Peff explained it in response to one of your previous
messages. Peff, would you mind answering Jonathan's questions?

At the end of the commit message I added the following which might help though:

>> No tests, because git does not actually exhibit this "ask
>> for it and also include-tag" behavior. We do one or the
>> other on clone, depending on whether --single-branch is set.
>> However, libgit2 does both.

So my wild guess sould be that maybe the reason is that some of this
code was shared (or intended to be shared) with libgit2?

> On to the review of the code. The ordering of - and + lines are
> confusing, so I have just removed all - lines.
>
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
> A chunk is a set of objects from the original packfile that we are
> reusing; all objects in a chunk have the same relative position in the
> original packfile and the generated packfile. (This does not mean that
> the bytes are exactly the same or, even, that the last object in the
> chunk has the same size in the original packfile and the generated
> packfile.)
>
> "start" is the offset of the first object of the chunk in the original
> packfile.
>
> "offset" is "start" minus the offset of the first object of the chunk in
> the generated packfile. (I think it is easier to understand if this was
> "new minus old" instead of "old minus new", that is, the negation of its
> current value.)
>
> So I would prefer:
>
>   /*
>    * A reused set of objects. All objects in a chunk have the same
>    * relative position in the original packfile and the generated
>    * packfile.
>    */
>   struct reused_chunk {
>     /* The offset of the first object of this chunk in the original
>      * packfile. */
>     off_t original;
>     /* The offset of the first object of this chunk in the generated
>      * packfile minus "original". */
>     off_t difference;
>   }

Ok, I have used that though it introduces some discrepancies, as
record_reused_object() for example still has an "offset" argument.

> > +static size_t write_reused_pack_verbatim(struct hashfile *out,
> > +                                      struct pack_window **w_curs)
> > +{
> > +     size_t pos = 0;
> > +
> > +     while (pos < reuse_packfile_bitmap->word_alloc &&
> > +                     reuse_packfile_bitmap->words[pos] == (eword_t)~0)
> > +             pos++;
> > +
> > +     if (pos) {
> > +             off_t to_write;
> > +
> > +             written = (pos * BITS_IN_EWORD);
> > +             to_write = reuse_packfile->revindex[written].offset
> > +                     - sizeof(struct pack_header);
> > +
> > +             record_reused_object(sizeof(struct pack_header), 0);
>
> Probably worth a comment, since we're recording one chunk, not one
> object.

Ok, added a comment.

> The code is correct, though - one big chunk with original offset
> as written, and no difference between original and generated offsets.


> > @@ -2661,6 +2785,7 @@ static void prepare_pack(int window, int depth)
> >
> >       if (nr_deltas && n > 1) {
> >               unsigned nr_done = 0;
> > +
> >               if (progress)
> >                       progress_state = start_progress(_("Compressing objects"),
> >                                                       nr_deltas);
>
> Unnecessary added line - please remove.

We often separate variable declaration from the rest of function code
with a blank line, so I don't think the added line is completely
unnecessary. It helps make the code more standard and therefore more
readable, so I left it.

You might say that it should be in a preparatory patch, but a
preparatory patch for just such a small change is a bit wasteful. I
think it's ok to add this blank line "while at it" in this patch.

> On to pack-bitmap.c.
>
> > +static void try_partial_reuse(struct bitmap_index *bitmap_git,
> > +                           size_t pos,
> > +                           struct bitmap *reuse,
> > +                           struct pack_window **w_curs)
> >  {
> > +     struct revindex_entry *revidx;
> > +     off_t offset;
> > +     enum object_type type;
> > +     unsigned long size;
> > +
> > +     if (pos >= bitmap_git->pack->num_objects)
> > +             return; /* not actually in the pack */
>
> Is this case possible? try_partial_reuse() is only called when there is
> a 1 at the bit location.

I'd like Peff to answer here too, as I don't think I fully understand
what's going on here.

> > +     /* Don't mark objects not in the packfile */
> > +     if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
> > +             i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
>
> Why is this necessary? Let's say we have 42 fully-1 words, and therefore
> i is 42. Shouldn't we allocate 42 words in our reuse bitmap?

I'd also prefer Peff to answer here.

[...]

> And thanks for this patch - other than the difficult-to-understand parts
> I described above, I found the overall flow easy to discern.
>
> I presume tests would also need to be written. One way is to introduce
> yet another test variable, but maybe that is overkill.

This part of the commit message might again help understand why there
is no test:

>> No tests, because git does not actually exhibit this "ask
>> for it and also include-tag" behavior. We do one or the
>> other on clone, depending on whether --single-branch is set.
>> However, libgit2 does both.

But I'd be again happy if Peff could confirm.

Thanks for another review,
Christian.
