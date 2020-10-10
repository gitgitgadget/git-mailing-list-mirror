Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8FC4363A
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E466A20795
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQPMIG5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbgJJW4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgJJTwD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:52:03 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18AC05BD13
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 06:43:39 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id f8so6559802vsl.3
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ocN1o18El+81X/uj75Mdq4GzYHHbDiAczM1cXz2mQuk=;
        b=YQPMIG5ixBq8rN6S8BVSuUqO+XPthpAsEAtIlQDr+2///2/WovvTGgr8QuJhrfmYhG
         565/112tF8zmZRVRiXOFAeT0IpDQsyo9B7cutqB1bW52u96Hp72mQvRegovboiM/kBhM
         y/L9dbNrs+5ai+EwsGrlipoVxBJzc0Kl1s5v7q0z2sIJWLt1yR4n1lbkBFQ7ljPiw/1m
         wv6laHFdb5eZ/RnQICU5kCeaM7Qeg7spEZ4uRLOd27IB5th72TX5lKNcFwv2pP8+aC6R
         j2OmSeFajLj0Td8t8kpeVJBaiL/d9nGawjZI9UAhLF4uuVy2LozNN2Htn4X6Znq73+bW
         DiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ocN1o18El+81X/uj75Mdq4GzYHHbDiAczM1cXz2mQuk=;
        b=VQYgQTDN2XlUUI1nq9owqB2QdOILlvgptF2xfbFdEp3gpFTUmHsdfWACD/hSGZ54zN
         +NSIO5QBLL6/WM6bsEba5yV3jgIOcV3FUhDFJ/6EDO4IPvKlbMEq6PcQdTnT3NKhy5uw
         9JpLGdlIfdT8YUvsyYQxaOwuEbyyxUgsOZvXDCauW8FVeFubacvHuBCi0lAwBBbFtMgs
         2IKNgfjtMQhGBU5rVFd1tUQTfDY8OSUL9Vdph3vARlMlsaMy+ImeazobF2WkO1czxI1l
         hD2Qj4Fp2v4NJBbrVpr5rp2ZhCfOYRt/p+B+l66ticOiq24/1hBBE/c+O7KeDt0r5Y3I
         kC+A==
X-Gm-Message-State: AOAM5330s/PrhhFapmw/s0hZKJlRiiP59Gm6Zl27NXpxozCboeqBdobu
        e+ppgtJNLJm55raMhCQYH+8rsMDoZMU8DsATAj0y7A==
X-Google-Smtp-Source: ABdhPJzmtK/FxvdAGAGWBz+TzN225zuTdvSIKi/4s9Gnf5rMKemCGgq98DWVKUeGYIG89pLIxzqJL/QyvxS/tu9f1hw=
X-Received: by 2002:a67:782:: with SMTP id 124mr10421909vsh.12.1602337417647;
 Sat, 10 Oct 2020 06:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
 <20201002035851.GB3252492@google.com>
In-Reply-To: <20201002035851.GB3252492@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Sat, 10 Oct 2020 15:43:25 +0200
Message-ID: <CAFQ2z_NU_hBF2Gz4yFK+Q-KreBQONeMF+pJYESp7hVnKCWvmDg@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] reftable: define the public API
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 2, 2020 at 5:58 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Adding a header in a separate patch from the implementation doesn't
> match the usual practice.  Can we add declarations in the same patch
> as the functions being declared instead?

We could, but it would considerably complicate work on this patch
series, as the commit boundary then doesn't fall on file boundaries
anymore. Would you be open to having multiple headers for the public
interface? eg. reftable-record.h, reftable-reader.h etc. ?

> > +     /* Misuse of the API:
> > +        - on writing a record with NULL refname.
> > +        - on writing a reftable_ref_record outside the table limits
> > +        - on writing a ref or log record before the stack's next_updat=
e_index
> > +        - on writing a log record with multiline message with
> > +        exact_log_message unset
> > +        - on reading a reftable_ref_record from log iterator, or vice =
versa.
> > +     */
> > +     REFTABLE_API_ERROR =3D -6,
>
> Should these call BUG()?  Or is it useful for some callers to be able
> to recover from these errors?

Since this was written as a standalone library, it's up to the caller
to decide what should be done. It also simplifies testing: you can
verify that incorrect API usage returns a certain error code, but a
BUG() that prints an error or crashes the program is much harder to
verify.

> > +     /* Dir/file conflict. */
>
> This is when adding a ref?

yes.

> > +
> > +/*
> > + * Convert the numeric error code to an equivalent errno code.
> > + */
> > +int reftable_error_to_errno(int err);
>
> What is the intended use of this function?

The read_raw_ref method in the ref backend API uses errno values as
out-of-band communication mechanism.

> > +/* Set the range of update indices for the records we will add.  When
> > +   writing a table into a stack, the min should be at least
> > +   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is return=
ed.
> > +
> > +   For transactional updates, typically min=3D=3Dmax. When converting =
an existing
> > +   ref database into a single reftable, this would be a range of updat=
e-index
> > +   timestamps.
> > + */
> > +void reftable_writer_set_limits(struct reftable_writer *w, uint64_t mi=
n,
> > +                             uint64_t max);
>
> What happens if I write to a reftable_writer without setting limits
> first?

you get an REFTABLE_API_ERROR.

> > +/* block_source_vtable are the operations that make up block_source */
> > +struct reftable_block_source_vtable {
> > +     /* returns the size of a block source */
> > +     uint64_t (*size)(void *source);
> > +
> > +     /* reads a segment from the block source. It is an error to read
> > +        beyond the end of the block */
> > +     int (*read_block)(void *source, struct reftable_block *dest,
> > +                       uint64_t off, uint32_t size);
> > +     /* mark the block as read; may return the data back to malloc */
> > +     void (*return_block)(void *source, struct reftable_block *blockp)=
;
> > +
> > +     /* release all resources associated with the block source */
> > +     void (*close)(void *source);
> > +};
>
> This is abstracting file input?  I wonder if some name emphasizing the
> 'read' operation like block_reader might be clearer.
>
> Do I pass in the 'struct block_source *' as the source arg?  If so, why
> are these declared as void *?

you pass in block_source->arg. Should struct implementations of
polymorphic types carry a pointer to their own vtable instead?

> Is the reason this manages the buffer instead of requiring a
> caller-supplied buffer to support zero-copy?

Log blocks are compressed, so the caller doesn't know the correct size
to supply. By letting the block source handle the management, we can
swap out the block read from the file for a block managed by malloc on
decompressing a log block.

> > +/* returns the hash ID used in this table. */
> > +uint32_t reftable_reader_hash_id(struct reftable_reader *r);
>
> What is a hash id?

The hash identifier, eg. "sha1" for SHA1 and "s256" for SHA-256.

> [...]
> > + Generic tables
> > +
> > + A unified API for reading tables, either merged tables, or single rea=
ders.
>
> Are there callers/helpers that don't know whether they want one or the
> other?

The setup with per-worktree refs means that there are two reftable
stacks in a .git repo. In order to iterate over the entire ref space,
you have to merge two merged tables, but the stack itslef merges a set
of simple reftables.

> [...]
> > +/* holds a transaction to add tables at the top of a stack. */
> > +struct reftable_addition;
>
> When would I add multiple tables at once to the top?  Is this used
> during compacting, for example?

No. You'd usually add only one table, but at the same time, it seemed
kind of arbitrary to allow adding only one table. FWIW, I added this
because libgit2 wants to be able to lock a ref database: creating the
reftable_addition institutes the lock.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
