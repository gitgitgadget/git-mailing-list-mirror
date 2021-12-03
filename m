Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42A6C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 22:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383411AbhLCW1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353945AbhLCW1a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 17:27:30 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103CC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 14:24:06 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z26so5598018iod.10
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pI19J+x2QBPBU52gDEq4boHi83BWB2kgddiM4flUzpE=;
        b=cXonCvdnrgPDYPKYHija0sLEOiSw+W6LOEZhJxpYpOsQ/Walm7TJGrFdUB8pGwu3ce
         L6vtZls8kXqP68HKSnQo0HPV0HwFRL5ouy59Qt7ci4X6KKpNaZM9MS7sK+uy3supz7Ub
         ftkXrTqo1SBNOXWDFWl1rsTHFyO5X1iHPmH2BARISI8++QxNbGzPz183FDLd29oCpbJv
         ODTIZY1CwT3BOy3mqaUrqr5+gEGw9u0aJpJOCVP8qV/SYBzUcw/O6WXXDyDrXY0+qNHf
         jIdagANwbJs8RuRc6a2eKn0mBXyDMzrEA6XM3ykt+QClDlqdLbq07hBu+1CCPBZnZSYY
         eA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pI19J+x2QBPBU52gDEq4boHi83BWB2kgddiM4flUzpE=;
        b=Ob5v4yvzOgcAFlwzEiD580R3z//Szz+pCwyz5ONzNjDnJt8fh2Zu9d9cCgIcAfxgCN
         zVZ6MiygX/cL3Uf9w0DMbVV3prGw4sj05EkMlFysgmHBo/DIAh8ExaX7IVwzffGZppo2
         ratBkEFDl9KxwscJnC37jGfRlmy01lkAHrxXtrNiBeGx5VqUxjpeznGTEKkTKIC+a/yB
         ZxmjQJaO2ScM/OhAy0fGVyKPLSQjFMSYAYyfuN01GwrV18RhQV4xVmnzwMiSE4cVJCZW
         IrhFmRtBfPDM3VFedY6pxqqqgtq0L1yfJE0m5Kf4FX4lbWFRvC1MZzWVPdqwpwK/o4O0
         4mng==
X-Gm-Message-State: AOAM530xaKJigcS+ny7mq57O83PXh0Mmx25sIaNrkTUCbHAywxPM+yCn
        l8ZW52plDg50S6TIK6+J2oFmNYrl3Cg3dw==
X-Google-Smtp-Source: ABdhPJxUw8MlClG0BG1URnnQGH2Bqn/XAHzjw8wHlGl8VDqhtmxKnuCMkBSbHY2xhjfo9Y8qQh1BGQ==
X-Received: by 2002:a05:6638:13d5:: with SMTP id i21mr28013955jaj.79.1638570245249;
        Fri, 03 Dec 2021 14:24:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t14sm2161368ilh.62.2021.12.03.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:24:04 -0800 (PST)
Date:   Fri, 3 Dec 2021 17:24:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <YaqZA02FsCFA9qBi@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <7d4ae7bd3e28e2ec904abb37b6f26505e37531c5.1638224692.git.me@ttaylorr.com>
 <ef10c824-e2d9-f113-f010-6a1ac307427a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef10c824-e2d9-f113-f010-6a1ac307427a@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 02, 2021 at 10:06:07AM -0500, Derrick Stolee wrote:
> On 11/29/2021 5:25 PM, Taylor Blau wrote:
>
> > +== pack-*.mtimes files have the format:
> > +
> > +  - A 4-byte magic number '0x4d544d45' ('MTME').
> > +
> > +  - A 4-byte version identifier (= 1).
> > +
> > +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
>
> I vaguely remember complaints about using a 1-byte identifier in
> the commit-graph and multi-pack-index formats because the "standard"
> way to refer to these hash functions was a magic number that had a
> meaning in ASCII that helped human readers a bit. I cannot find an
> example of such 4-byte identifiers, but perhaps brian (CC'd) could
> remind us.
>
> You are using a 4-byte identifier, but using the same values as
> those 1-byte identifiers.

Yeah, I'm definitely borrowing from the commit-graph and multi-pack
index formats here. Though I believe we did the same thing for .rev
files, too (and checking with Documentation/technical/pack-format.txt
confirms as much).

I don't have a strong feeling about using the 4-byte identifier or not.
But making this field four bytes wide is very much intentional, since it
makes sure that all of our reads are aligned, which should yield much
better cache performance (assuming the page size is also a multiple of
four).

I don't, but if others feel strongly we could write the magic
identifiers brian points out downthread here instead. (It would be
mildly inconvenient for GitHub, which has many hundreds of thousands of
these files laying around everywhere with '1' as the identifier. But
since the magic identifiers don't collide with the values proposed here,
GitHub's fork could easily be taught to accept both on the reading side,
but only write out the special identifier).

> > +  - A table of mtimes (one per packed object, num_objects in total, each
> > +    a 4-byte unsigned integer in network order), in the same order as
> > +    objects appear in the index file (e.g., the first entry in the mtime
> > +    table corresponds to the object with the lowest lexically-sorted
> > +    oid). The mtimes count standard epoch seconds.
>
> This paragraph seemed awkward. Here is a rephrasing that might be
> less awkward:
>
>  - A table of 4-byte unsigned integers in network order. The ith value
>    is the modified time (mtime) of the ith object of the corresponding
>    pack in lexicographic order. The mtime represents standard epoch
>    seconds.

Thanks, this is clearer. I went with a blend of the two:

    - A table of 4-byte unsigned integers in network order. The ith
      value is the modification time (mtime) of the ith object in the
      corresponding pack by lexicographic (index) order. The mtimes
      count standard epoch seconds.

> Storing these mtimes in 32-bits means we will hit the 2038 problem.
> The commit-graph stores commit times with an extra two bits to extend
> the lifetime by another hundred years or so.
>
> Could we extend the lifetime of cruft packs by decreasing the granularity
> here? Should 'mtime' store a number of _minutes_ instead of seconds? That
> should be enough granularity for these purposes.

Perhaps, though it does add some complexity to the code that deals with
this format at the expense of some future-proofing. I'm open to it,
though.

>
> > +  - A trailer, containing a:
> > +
> > +    checksum of the corresponding packfile, and
> > +
> > +    a checksum of all of the above.
>
> Could you specify the checksum as having length according to the
> specified hash function?

Great suggestion, thanks.

> > +All 4-byte numbers are in network order.
> > +
>
> Maybe this could be at the start of the format, since the file
> version and hash function are both 4-byte numbers here and we
> could remove the mention of network order from the mtime values.

This is copy-and-pasted from the .rev section above, where I think I
added the "All 4-byte numbers are in network order" bit at the end in
response to a suggestion opposite yours ;).

Here I would probably rather stay consistent with the surrounding
sections.

> > +static char *pack_mtimes_filename(struct packed_git *p)
> > +{
> > +	size_t len;
> > +	if (!strip_suffix(p->pack_name, ".pack", &len))
> > +		BUG("pack_name does not end in .pack");
> > +	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
> > +	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
> > +}
>
> I see your NEEDSWORK here and you are probably referring to this:
>
> static char *pack_revindex_filename(struct packed_git *p)
> {
> 	size_t len;
> 	if (!strip_suffix(p->pack_name, ".pack", &len))
> 		BUG("pack_name does not end in .pack");
> 	return xstrfmt("%.*s.rev", (int)len, p->pack_name);
> }
>
> and the implementation is identical except for the new trailer
> (which exist in the exts[] array in builtin/repack.c, but could
> also be pulled out into a header somewhere.
>
> I'm happy to delay any cleanup of these code clones until later,
> if at all, because doing it right might mean moving more code
> than we like. Such refactorings aren't worth it most of the time.

Yeah, I think your thoughts matched my own when writing this. Which is
to say, I felt it prudent to call out that there is an opportunity to
DRY these two up, but I'm not convinced that such a clean up would be
worthwhile.

> > +static int load_pack_mtimes_file(char *mtimes_file,
> > +				 uint32_t num_objects,
> > +				 const uint32_t **data_p, size_t *len_p)
> > +{
>
> > +	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
> > +		ret = error(_("mtimes file %s is corrupt"), mtimes_file);
>
> This message could be more informative: "mtimes file %s has the wrong size"?

Copy-and-pasting here again from the corresponding code for the .rev
file, which is why I didn't opt to change the message here. Probably
many of these checks could be extracted out and shared between the two
paths, but I don't think we should attempt it here.

> > +	data = hdr = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);
> > +
> > +	if (ntohl(*hdr) != MTIMES_SIGNATURE) {
> > +		ret = error(_("mtimes file %s has unknown signature"), mtimes_file);
> > +		goto cleanup;
> > +	}
>
> Interesting that you defined 'struct mtimes_header' before this
> method, but don't use it here (in favor of moving a uint32_t
> pointer). Perhaps you are avoiding pointing the struct at the
> memory map, but you could also do this:
>
> 	struct mtimes_header header;
>
> 	header.signature = ntohl(hdr[0]);
> 	header.version = ntohl(hdr[1]);
> 	header.hash_id = ntohl(hdr[2]);
>
> And then operate on the struct for your validation.
>
> At the very least, 'struct mtimes_header' is defined but not
> used in this patch. If you decide to not use it this way, then
> maybe delay its definition.

Yeah, not reading directly out of the struct is intentional, since the
compiler is free to insert padding between these members, which would
break any subsequent reads out of the struct.

But I like your idea to assign the fields manually, thanks!

> > +int load_pack_mtimes(struct packed_git *p)
> > +{
> > +	char *mtimes_name = NULL;
> > +	int ret = 0;
> > +
> > +	if (!p->is_cruft)
> > +		return ret; /* not a cruft pack */
>
> Interesting that this indicator is essentially "we have an mtimes
> file for this pack", but it makes sense to include that check next
> to the .keep and .promisor checks.

I think I had originally called it "mtimes" but changed it to "cruft",
since it makes sense as a prefix similar to the others (that is, "keep
pack", "promisor pack", and "cruft pack", not "mtimes pack").

> The hunks I did not comment on look good. Nice standard file format
> stuff.

Thanks for your review!

Thanks,
Taylor
