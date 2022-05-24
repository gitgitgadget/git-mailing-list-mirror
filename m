Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144E8C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiEXWVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbiEXWVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:21:33 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0318386
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:21:31 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id s4-20020a4ac804000000b0040e93a35508so1048111ooq.8
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eEZKAEY9RSlB+FrueL9XBcpCSM+PnRBl8aKLlOBdq+A=;
        b=a6fOkgFdiq/cuoIAIBAD4GbHwNyVV+P+93DstN4kJNCpRPevg9h7cMly2+hQfkmPVM
         WI2vCFADE0wpSgTzAuYFpM2vfcYfpqxXNlEXD6cRDF5ZDTQawRiWzsDpGw4mwjeBwhe6
         j1gtkSFMB0HNzcfF2KNnpQe7d+TPrRTsHnd64z8iatrI9o7ScctfZphgJD1y7V82/K8U
         p+9DNlvgQvSILx83Ac200FShdg4pCwTrTnZsCVqHxPTKJj4pzmEaOpkkl0CIVL+xZXFv
         pYSoVN87J/SQwoqnBqNQ6V7mAlFWnuA1iC6+/frJvej9Y0dBikR3TtIPZ18Y+CufV7EV
         Z3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eEZKAEY9RSlB+FrueL9XBcpCSM+PnRBl8aKLlOBdq+A=;
        b=uEL2Rti3ZQ/V+qsIuIbUBnEwUWpQslrQQY/DLENB1hSsE5npJ6SB9Ng/HInQIcAduR
         Cu3qSPFIpdEG/5VjOL+qe+qO9c6ljIsaIobjfhGhJSZG9AMeBWeNAwRYpLv0o1X7Dfxc
         gltIpjNPl3G+ypB8vfQ0oR2Z1et1S3biqTxsKVaPcq4xahI4PkEGgzbNxyzZhi6QcfSG
         Pxq9IeLZ4Cvag4+hLXOb1b3aH4J9dVmp4gOqVIqgUeTUHaoK9qO+6V3TDJnq5Zx/YtYF
         08wuoz87S5+V2ca9d8REEtii8uC9YnlMD6L+e2U3SqRi9gptNsTnXSTAnq9Bj8C8m2oI
         MXpA==
X-Gm-Message-State: AOAM532Rpb/wMRsUpVUqp0OQkqYJtKmvqWTFmhzwJYeLmgUvVjOqV+0w
        v0xKhshaCGD/DjYcgeo8K05Xhg==
X-Google-Smtp-Source: ABdhPJxTKN3ARFmOR+U/IRcfhQ18vxu1P3Qyp4X60B4JUS9IP1g1Y0FdtyfiqsvRaJz50DFmhetavA==
X-Received: by 2002:a05:6820:1794:b0:40e:5e86:1dd4 with SMTP id bs20-20020a056820179400b0040e5e861dd4mr9286383oob.19.1653430891058;
        Tue, 24 May 2022 15:21:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 106-20020a9d0bf3000000b0060603221276sm5484346oth.70.2022.05.24.15.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 15:21:30 -0700 (PDT)
Date:   Tue, 24 May 2022 18:21:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yo1aaLDmPKJ5/rh5@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo0ysWZKFJoiCSqv@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 12:32:01PM -0700, Jonathan Nieder wrote:
> Hi,
>
> Taylor Blau wrote:
>
> > This patch prepares for cruft packs by defining the `.mtimes` format,
> > and introducing a basic API that callers can use to read out individual
> > mtimes.
>
> Makes sense.  Does this intend to produce any functional change?  I'm
> guessing not (and the lack of tests agrees), but the commit message
> doesn't say so.
>
> By the way, is this something we could cover in tests, e.g. using a
> test helper that exercises the new code?

This does not produce a functional change, no. This commit in isolation
adds a bunch of dead code that will be used (and tested) in the
following patches.

There is a test helper that is added (and then used extensively further
on in the series) four patches later, c.f., "t/helper: add 'pack-mtimes'
test-tool".

> [...]
> > --- a/Documentation/technical/pack-format.txt
> > +++ b/Documentation/technical/pack-format.txt
> > @@ -294,6 +294,25 @@ Pack file entry: <+
> >
> >  All 4-byte numbers are in network order.
> >
> > +== pack-*.mtimes files have the format:
> > +
> > +All 4-byte numbers are in network byte order.
> > +
> > +  - A 4-byte magic number '0x4d544d45' ('MTME').
> > +
> > +  - A 4-byte version identifier (= 1).
> > +
> > +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
> > +
> > +  - A table of 4-byte unsigned integers. The ith value is the
> > +    modification time (mtime) of the ith object in the corresponding
> > +    pack by lexicographic (index) order. The mtimes count standard
> > +    epoch seconds.
> > +
> > +  - A trailer, containing a checksum of the corresponding packfile,
> > +    and a checksum of all of the above (each having length according
> > +    to the specified hash function).
> > +
>
> This describes the "syntax" but not the "semantics" of the file.
> Should I look to a separate piece of documentation for the semantics?
> If so, can this one include a mention of that piece of documentation
> to make it easier to find?
>
> [...]
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -115,12 +115,15 @@ struct packed_git {
> >  		 freshened:1,
> >  		 do_not_close:1,
> >  		 pack_promisor:1,
> > -		 multi_pack_index:1;
> > +		 multi_pack_index:1,
> > +		 is_cruft:1;
> >  	unsigned char hash[GIT_MAX_RAWSZ];
> >  	struct revindex_entry *revindex;
> >  	const uint32_t *revindex_data;
> >  	const uint32_t *revindex_map;
> >  	size_t revindex_size;
> > +	const uint32_t *mtimes_map;
> > +	size_t mtimes_size;
>
> What does mtimes_map contain?  A comment would help.

It contains a pointer at the beginning of the mmapped region of the
.mtimes file, similar to revindex_map above it.

>
> > --- /dev/null
> > +++ b/pack-mtimes.c
> > @@ -0,0 +1,126 @@
> > +#include "pack-mtimes.h"
> > +#include "object-store.h"
> > +#include "packfile.h"
>
> Missing #include of git-compat-util.h.

Ah, good eyes: thanks.

Junio: would you like a replacement patch / a whole new copy of the
series / or can you amend this locally when queuing? Whatever is lowest
effort for you works for me.

> > +
> > +static char *pack_mtimes_filename(struct packed_git *p)
> > +{
> > +	size_t len;
> > +	if (!strip_suffix(p->pack_name, ".pack", &len))
> > +		BUG("pack_name does not end in .pack");
> > +	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
> > +	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
> > +}
>
> This seems simple enough that it's not obvious we need more code
> sharing.  Do you agree?  If so, I'd suggest just removing the
> NEEDSWORK comment.

Yeah, it is conceptually simple, though it feels like the sort of thing
that could benefit from not having to be written once for each
extension (hence the comment).

> > +
> > +#define MTIMES_HEADER_SIZE (12)
> > +#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))
>
> Hm, the all-caps name makes this feel like a compile-time constant but
> it contains a reference to the_hash_algo.  Could it be an inline
> function instead?

Yes, it could be an inline function, but I don't think there is
necessarily anything wrong with it being a #define'd macro. There are
some other examples, e.g., RIDX_MIN_SIZE, MIDX_MIN_SIZE,
GRAPH_DATA_WIDTH, and PACK_SIZE_THRESHOLD (to name a few) which also use
the_hash_algo on the right-hand side of a `#define`.

> > +
> > +struct mtimes_header {
> > +	uint32_t signature;
> > +	uint32_t version;
> > +	uint32_t hash_id;
> > +};
> > +
> > +static int load_pack_mtimes_file(char *mtimes_file,
> > +				 uint32_t num_objects,
> > +				 const uint32_t **data_p, size_t *len_p)
>
> What does this function do?  A comment would help.

I know that I'm biased as the author of this code, but I think the
signature is clear here. At least, I'm not sure what information a
comment would add that the function name and its arguments don't already
convey.

> > +	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
>
> This presupposes that the hash_id matches the_hash_algo.  Maybe worth
> a NEEDSWORK comment.

Good catch.

> [...]
> > +cleanup:
> > +	if (ret) {
> > +		if (data)
> > +			munmap(data, mtimes_size);
> > +	} else {
> > +		*len_p = mtimes_size;
> > +		*data_p = (const uint32_t *)data;
>
> Do we know that 'data' is uint32_t aligned?  Casting earlier in the
> function could make that more obvious.

`data` is definitely uint32_t aligned, but this is a tradeoff, since if
we wrote:

    uint32_t *data = xmmap(...);

then I think we would have to change the case where ret is non-zero to be:

    if (data)
        munmap((void*)data, ...);

and likewise, data_p is const.

> > +int load_pack_mtimes(struct packed_git *p)
>
> This could use a doc comment in the header file.  For example, what
> requirements do we have on what the caller passes as 'p'?
>
> [...]
> > +uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos)
>
> Likewise.

Sure. I wonder when we should do that, though. I'm not trying to be
impatient to get this merged, but iterating on the documentation feels
like it could be done on top without having to re-send the substantive
parts of this series over and over.

> [...]
> > --- a/packfile.c
> > +++ b/packfile.c
> [...]
> > @@ -363,7 +373,7 @@ void close_object_store(struct raw_object_store *o)
> >
> >  void unlink_pack_path(const char *pack_name, int force_delete)
> >  {
> > -	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor"};
> > +	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};
>
> Are these in any particular order?  Should they be?
>
> [...]

These aren't technically in any particular order (nor should they be),
though .idx should be first. I'm leaving it alone here
(semi-intentionally, since the race it opens up isn't related to this
series, and it's on my list to deal with after this code has settled).

> > @@ -718,6 +728,10 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
> >  	if (!access(p->pack_name, F_OK))
> >  		p->pack_promisor = 1;
> >
> > +	xsnprintf(p->pack_name + path_len, alloc - path_len, ".mtimes");
> > +	if (!access(p->pack_name, F_OK))
> > +		p->is_cruft = 1;
> > +
> >  	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
> >  	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
> >  		free(p);
> > @@ -869,7 +883,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
> >  	    ends_with(file_name, ".pack") ||
> >  	    ends_with(file_name, ".bitmap") ||
> >  	    ends_with(file_name, ".keep") ||
> > -	    ends_with(file_name, ".promisor"))
> > +	    ends_with(file_name, ".promisor") ||
> > +	    ends_with(file_name, ".mtimes"))
>
> likewise

No specific order here (since these are all OR'd together).

Thanks,
Taylor
