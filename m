Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6520CC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDNMRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNMRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:17:23 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BB8AD0C
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:17:21 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id by8so2331104ybb.9
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474641; x=1684066641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etNgWf2zmXpSWYyT+fvuqV9Erd8HxOPLP+tN9UjTVEA=;
        b=TEqnQF4BmG3Ihvrpf4dpoR3hvj0wLeRVtapnDzas+Tny5/swOGViZyHRtQ2CP+7EoJ
         1amTLpr3Gfx0dzb75ppvJ4eQNsFNv9H0UQwSVE43Mw5U0XOM/YNAhZO9yZJz3F8jl0vZ
         XwZ147hIDrP18mk3Ed4fGH4BPrQfKuJpxkyyZnUKKnSXaAfJf1bichuY5f+8puNc0wsh
         6TxwztYJ2kRolu+xX25cdz8uE4yVAxhMvYsI4it3tOETDeLEqhmLetg8uU9i4UIn6akx
         e1D69bi0WHgR2irW1CgNG8yc6PYLqNJAyE5y32MgsUjhVg9+v+T3qE96vO4jEjpXKlGq
         8RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474641; x=1684066641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etNgWf2zmXpSWYyT+fvuqV9Erd8HxOPLP+tN9UjTVEA=;
        b=ZKQHOq9Uvm092ieF9Ja0Hifj8CLLvI/BVF3JhzSmwb9EB1QBCMQiT09kNC5JUBl6Up
         GlFOhCVn9cDWlKxTSyxu3OpXKFnVoi3MpVd90E5oPsczRW4lq68XRdR+0HJhXaW8NvJL
         QhMFZjgcRXiMcZAXqgXzhuiyFykYlMlKD5HLX3sR9k0QSk/OSbT+vR+p7bja8QOKIg40
         ai/UMOPc9nS/TrvHEHdUvVLAR5MqrAD71/k/qNspLRmu+IMd+Brogrd/3SMRcy4BjRlC
         Qy2sNADnBO3M9nGuRgVRb4N7WNFx7bzj0K59PvAqeY/CvSE+CFgSf55Y40nBx0O5RNBu
         iztw==
X-Gm-Message-State: AAQBX9cJpW1KWuZEeyDQMN1a83EqI41g6he0bs30jye6UlCriTFwkYFZ
        h/qUPOzxMT3elH26r0f53N1+I5Sws+HXRukO3bs=
X-Google-Smtp-Source: AKy350Y/dlBdFkXHoQPQhlKKNQSEvmuyYFpJZm9vFRJw60/xnkkCjMIGb9DMryXi2zqIodPX+VdmMwYPyfWQ062EzRw=
X-Received: by 2002:a25:30c2:0:b0:b8f:553a:ddfd with SMTP id
 w185-20020a2530c2000000b00b8f553addfdmr2942168ybw.5.1681474640886; Fri, 14
 Apr 2023 05:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g> <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local> <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net> <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
 <20230412074309.GB1695531@coredump.intra.peff.net> <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
 <20230414073035.GB540206@coredump.intra.peff.net>
In-Reply-To: <20230414073035.GB540206@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 14 Apr 2023 20:17:34 +0800
Message-ID: <CAOLTT8SEeY1tfU39xHPJ21F7o3dmgEFwNCny=Z2F4Y2HFR3DzA@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2023=E5=B9=B44=E6=9C=8814=E6=97=A5=E5=91=
=A8=E4=BA=94 15:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 12, 2023 at 05:57:02PM +0800, ZheNing Hu wrote:
>
> > > It's not just metadata; it's actually part of what we hash to get the
> > > object id (though of course it doesn't _have_ to be stored in a linea=
r
> > > buffer, as the pack storage shows).
> >
> > I'm still puzzled why git calculated the object id based on {type, size=
, data}
> >  together instead of just {data}?
>
> You'd have to ask Linus for the original reasoning. ;)
>
> But one nice thing about including these, especially the type, in the
> hash, is that the object id gives the complete context for an object.
> So if another object claims to point to a tree, say, and points to a blob
> instead, we can detect that problem immediately.
>
> Or worse, think about something like "git show 1234abcd". If the
> metadata was not part of the object, then how would we know if you
> wanted to show a commit, or a blob (that happens to look like a commit),
> etc? That metadata could be carried outside the hash, but then it has to
> be stored somewhere, and is subject to ending up mismatched to the
> contents. Hashing all of it (including the size) makes consistency
> checking much easier.
>

Oh, you are right, this could be to prevent conflicts between Git objects
with identical content but different types. However, I always associate
Git with the file system, where metadata such as file type and size is
stored in the inode, while the file data is stored in separate chunks.

> > > For packed object, it effectively is metadata, just stuck at the fron=
t
> > > of the object contents, rather than in a separate table. That lets us
> > > use the same .idx file for finding that metadata as we do for the
> > > contents themselves (at the slight cost that if you're _just_ accessi=
ng
> > > metadata, the results are sparser within the file, which has worse
> > > behavior for cold-cache disks).
> >
> > Agree. But what if there is a metadata table in the .idx file?
> > We can even know the type and size of the object without accessing
> > the packfile.
>
> I'm not sure it would be any faster than accessing the packfile. If you
> stick the metadata in the .idx file's oid lookup table, then lookups
> perform a bit worse because you're wasting memory cache. If you make a
> separate table in the .idx file that's OK, but I'm not sure it's
> consistently better than finding the data in the packfile.
>

Yes, but it maybe be very convenient if we need to filter by object
type or size.

> The oid lookup table gives you a way to index the table in
> constant-time (if you store the table as fixed-size entries in sha1
> order), but we can also access the packfile in constant-time (the idx
> table gives us offsets). The idx metadata table would have better cache
> behavior if you're only looking at metadata, and not contents. But
> otherwise it's worse (since you have to hit the packfile, too). And I
> cheated a bit to say "fixed-size" above; the packfile metadata is in a
> variable-length encoding, so in some ways it's more efficient.
>

Yes, if we only use git cat-file --batch-check, we may be able to improve
performance by avoiding access to the pack file. Additionally, I think
this metadata table is very suitable for filtering and aggregating operatio=
ns.

> So I doubt it would make any operations appreciably faster, and even if
> it did, you'd possibly be trading off versus other operations. I think
> the more interesting metadata is not type/size, but properties such as
> those stored by the commit graph. And there we do have separate tables
> for fast access (and it's a _lot_ faster, because it's helping us avoid
> inflating the object contents).
>

Yeah, optimizing the retrieval of metadata such as type/size may not provid=
e
as much benefit as recording the commit properties in the metadata table,
like the commit graph optimization does.

> > > I'm not sure how much of a speedup it would yield in practice, though=
.
> > > If you're printing the object contents, then the extra lookup is
> > > probably not that expensive by comparison.
> > >
> >
> > I feel like this solution may not be feasible. After we get the type an=
d size
> > for the first time, we go through different output processes for differ=
ent types
> > of objects: use `stream_blob()` for blobs, and `read_object_file()` wit=
h
> > `batch_write()` for other objects. If we obtain the content of a blob i=
n one
> > single read operation, then the performance optimization provided by
> > `stream_blob()` would be invalidated.
>
> Good point. So yeah, even to use it in today's code you'd need something
> conditional. A few years ago I played with an option for object_info
> that would let the caller say "please give me the object contents if
> they are smaller than N bytes, otherwise don't".
>
> And that would let many call-sites get type, size, and content together
> most of the time (for small objects), and then stream only when
> necessary. I still have the patches, and running them now it looks like
> there's about a 10% speedup running:
>
>   git cat-file --unordered --batch-all-objects --batch >/dev/null
>
> Other code paths dealing with blobs would likewise get a small speedup,
> I'd think. I don't remember why I didn't send it. I think there was some
> ugly refactoring that I needed to double-check, and my attention just
> got pulled elsewhere. The messy patches are at:
>
>   https://github.com/peff/git jk/object-info-round-trip
>
> if you're interested.
>

Alright, this does feel a bit hackish, allowing most objects to fetch the
content when first read and allowing blobs larger than N to be
streamed via stream_blob().

I feel like this optimization for single-reads is a bit off-topic, I quote
your previous sentence:

> So a nice thing about being able to do the filtering in one process is
> that we could _eventually_ do it all with one object lookup. But I'd
> probably wait on adding something like --type-filter until we have an
> internal single-lookup API, and then we could time it to see how much
> speedup we can get.

This optimization for single-reads doesn't seem to provide much benefit
for implementing object filters, because we have already read the content
of the object in advance?

ZheNing Hu
