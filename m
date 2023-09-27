Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D8CE80AB2
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjI0OeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 10:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjI0OeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 10:34:21 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA53F9
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 07:34:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59f4db9e11eso107065337b3.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695825259; x=1696430059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTx6uHtEclVrBpN/4J8q/q+U0WA/98HwPZWmGAk1OsQ=;
        b=ex5BZ5x2B+AJlVKv4ut5H5racnOq2ogyIDR5GgCK0NmYZuFloex7eEvDW4bqG05f71
         G7Xu1h6CKH5cXr0tRzVqU+jjCepahedlIH4MbF0sJxTKSD3iezSTUJ8ILDDPGx/7NRml
         bYKS2cbg1KH6HNgnFkKwbnONoIZDBNdaAZXa0Lbs0CIO+UV4tWOrnpdr2eAVi4O/17Di
         gfdrf+GcFp7VlBpgqfMyH0cjqlRyKhZKWFyR5vvAomtLUSKLXeIqhIDYw6ErBPx1Z9W2
         eQcOZ63oKP42XPRwJ51t+kqu9Mjs3gNtVldQFM0Zyy1fLdaOX4+0ABS+l2+VULm1j2v+
         10QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825259; x=1696430059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTx6uHtEclVrBpN/4J8q/q+U0WA/98HwPZWmGAk1OsQ=;
        b=EMt6hwSpzpWvX3nGEm+p+hduEA/NNrQ1wznE6H/wSYhusyTZU5GHSQT3XLUpkz0bxX
         NoMjbJlcGpVE1cI4hdmDnlXJ3ktIzWnNpJoQ9NdO2E/sdAILC+w3XQ8CfBQkwlF+J5XH
         YqaYfD7ePdJsVEB2MOOpgiFpvrZad5LCiV2JHyfhGKRZcEYFAjPb9GBZhbHvhjOYTavD
         WBYRNyPaHRhEDnKhbmegTioIucZ2gcVuC/pF8QZIzQxm4xIOfJUFrIi8Fwa1barJaVBm
         oGX3rrif0vKThCVHyyU7774aBb02tNC72xA3X1ZL0x9GKO+OhfoJd9aH30xaYfQlNGR4
         6nbA==
X-Gm-Message-State: AOJu0YxF/G7RZYQqTi56oACSINFFrlDZIiyArOjNoyfaMzVMgEbgBA9W
        MV06Lbx4L8UAFumm8awIgBzSGA==
X-Google-Smtp-Source: AGHT+IFngK9SCZ8le3HabnxZto7Ap5Nvl8l3YJ9HkofmZdmTrFMu7mglXEzrJRDJ0YyiqX8kPIsbGw==
X-Received: by 2002:a0d:df4d:0:b0:586:a68b:4c9a with SMTP id i74-20020a0ddf4d000000b00586a68b4c9amr2248779ywe.2.1695825258287;
        Wed, 27 Sep 2023 07:34:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z184-20020a8189c1000000b005707fb5110bsm3742461ywf.58.2023.09.27.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:34:17 -0700 (PDT)
Date:   Wed, 27 Sep 2023 10:34:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Eric W. Biederman" <ebiederm@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
Message-ID: <ZRQ9aSeu/wpJERuV@nand.local>
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
 <xmqqr0mtcosy.fsf@gitster.g>
 <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
 <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
 <xmqqmsx8mwr4.fsf@gitster.g>
 <ZROHrSmmZOIE6bl9@nand.local>
 <xmqqil7wmf50.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqil7wmf50.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 09:08:59PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Hmm. I wonder if retaining some flexibility in the bulk-checkin
> > mechanism may be worthwhile. We discussed at the Contributor's
> > Summit[^1] today that the bulk-checkin system may be a good fit for
> > packing any blobs/trees created by `merge-tree` or `replay` instead of
> > writing them out as loose objects.
>
> But see the last paragraph of my review comments for the earlier
> round upthread.  This particular function implements logic that is
> only applicable to blob objects, and streaming trees, commits, and
> tags will need their own separate helper functions.  And when they
> are written, the top-level stream_to_pack() function can be
> reintroduced, which will be a thin dispatcher to the four
> type-specific helpers.

I am not sure that I follow. If we have an address in memory from which
we want to stream raw bytes directly to the packfile, that should work
for all objects regardless of type, no?

Having stream_to_pack() take a non-OBJ_BLOB 'type' argument would be OK
provided that the file descriptor 'fd' contains the raw contents of an
object which matches type 'type'.

IIUC, for callers like in the ORT backend which assemble e.g. the raw
bytes of a tree in its merge-ort.c::write_tree() function like so:

    for (i = 0; i < nr; i++) {
        struct merged_info *mi = versions->items[offset+i].util;
        struct version_info *ri = &mi->result;

        strbuf_addf(&buf, "%o %s%c", ri->mode,
                    versions->items[offset+i].string, '\0');
        strbuf_add(&buf, ri->oid.hash, hash_size);
    }

we'd want some variant of stream_to_pack() that acts on a 'void *,
size_t' pair rather than an 'int (fd), size_t' pair. Likely its
signature would look something like:

    /* write raw bytes to a bulk-checkin pack */
    static int write_to_pack(struct bulk_checkin_packfile *state,
                             git_hash_ctx *ctx, off_t *already_hashed_to,
                             void *ptr, size_t size, enum object_type type,
                             unsigned flags);

    /* write an object from memory to a bulk-checkin pack */
    static int deflate_to_pack_mem(struct bulk_checkin_packfile *state,
                                   struct object_id *result_oid,
                                   void *ptr, size_t size,
                                   enum object_type type, unsigned flags);

, where the above are analogous to `stream_to_pack()` and
`deflate_to_pack()`, respectively. ORT would be taught to conditionally
replace calls like:

    write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);

with:

    deflate_to_pack_mem(&state, result_oid, buf.buf, buf.len,
                        OBJ_TREE, HASH_WRITE_OBJECT);

I guess after writing all of that out, you'd never have any callers of
the existing `deflate_to_pack()` function that pass a file descriptor
containing the contents of a non-blob object. So in that sense, I don't
think that my proposal would change anything about this patch.

But I worry that I am missing something here, so having a sanity check
would be appreciated ;-).

Thanks,
Taylor
