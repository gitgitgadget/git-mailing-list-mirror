Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00FC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 15:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358762AbhLBPJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358427AbhLBPJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 10:09:34 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807DAC061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 07:06:09 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r26so55955838oiw.5
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CCo+LzTmxl5X2hIJ1k7+8c5RKiD9ksp0cx7wl2v+jpA=;
        b=XhBijeyBM7d/ZPF+CR6PWJeoxLPSEdGcMAuS4pLQnS2ENMBwLaH5fzY7Aksx1M6/S5
         pDkcx/YfKkQ9DItSjC0Oan6TL34OZ1PDeYh5B79XX5UmrGkSymOh81zy2fcMGaA7KwNd
         KQXifxHhtbHmx/6rWCbKtXjzzF+L1lOW1Lt0JvbEoV6R75M5km1O8rCgiK1DAIuUxHEx
         9+DChLcra/4rriflglqURv8wVHKWUI/06YgcFQX2eWLQhufB2j9Z8l/sM6Buht5OGuOX
         uCYcLEogPcCEBf2IqBmb6WIeaVh73oXpctLsQ/7sn6Z8IRpFHm6e8rf5xwlEUXC/aS9x
         oUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CCo+LzTmxl5X2hIJ1k7+8c5RKiD9ksp0cx7wl2v+jpA=;
        b=x2lppcgqDnIbBy9ZrBbnJsbZ3TSEEnPTpvxUz8Rc72jse7Xrq6wAFqZOKt9FI4+WSm
         GJYdJYRvWX4z0l6HwSEdhXBtsvZOdBtyGrfVj3r8TVgH1nm5beiJvnPnmh22krUhsaWF
         FvQfKrJC8DFJHyPKewRwGCb5VTAzBmg1HJHcz50xgD1TjRcy/ppH6Yxp/i6dc7ZFMQZ1
         KgXQEGhize24dR+U7wv5pdNLEo6dHaX1giamKGRaOguqyUymNRq3Ilvzv8BHhMroC3Hw
         LEE9xDpE88g7xLuiZ2/O/sgo9W/cOD+JNL8mSKnp8GCEUs0XagOIn+aX0kBiydcSNWn4
         qeGw==
X-Gm-Message-State: AOAM530rhJX95QFgG0gETyu3tb/ExgiuCf1mwJthwe5LWiJNxmxuysOA
        F0s98iJcGlevfLlzi7h6ca0=
X-Google-Smtp-Source: ABdhPJwQbk2uBaYpAsY3xikdfIZCVT6sjte7qHXivih/ZL/xBh+pq1XcPn8Rpu79XLkOy5upsn7ZXQ==
X-Received: by 2002:a05:6808:bc3:: with SMTP id o3mr4673923oik.151.1638457568693;
        Thu, 02 Dec 2021 07:06:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a483:be4f:55c1:3cc8? ([2600:1700:e72:80a0:a483:be4f:55c1:3cc8])
        by smtp.gmail.com with ESMTPSA id k14sm48677oil.38.2021.12.02.07.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 07:06:08 -0800 (PST)
Message-ID: <ef10c824-e2d9-f113-f010-6a1ac307427a@gmail.com>
Date:   Thu, 2 Dec 2021 10:06:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 02/17] pack-mtimes: support reading .mtimes files
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1638224692.git.me@ttaylorr.com>
 <7d4ae7bd3e28e2ec904abb37b6f26505e37531c5.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <7d4ae7bd3e28e2ec904abb37b6f26505e37531c5.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:

> +== pack-*.mtimes files have the format:
> +
> +  - A 4-byte magic number '0x4d544d45' ('MTME').
> +
> +  - A 4-byte version identifier (= 1).
> +
> +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).

I vaguely remember complaints about using a 1-byte identifier in
the commit-graph and multi-pack-index formats because the "standard"
way to refer to these hash functions was a magic number that had a
meaning in ASCII that helped human readers a bit. I cannot find an
example of such 4-byte identifiers, but perhaps brian (CC'd) could
remind us.

You are using a 4-byte identifier, but using the same values as
those 1-byte identifiers.

> +  - A table of mtimes (one per packed object, num_objects in total, each
> +    a 4-byte unsigned integer in network order), in the same order as
> +    objects appear in the index file (e.g., the first entry in the mtime
> +    table corresponds to the object with the lowest lexically-sorted
> +    oid). The mtimes count standard epoch seconds.

This paragraph seemed awkward. Here is a rephrasing that might be
less awkward:

 - A table of 4-byte unsigned integers in network order. The ith value
   is the modified time (mtime) of the ith object of the corresponding
   pack in lexicographic order. The mtime represents standard epoch
   seconds.

Storing these mtimes in 32-bits means we will hit the 2038 problem.
The commit-graph stores commit times with an extra two bits to extend
the lifetime by another hundred years or so.

Could we extend the lifetime of cruft packs by decreasing the granularity
here? Should 'mtime' store a number of _minutes_ instead of seconds? That
should be enough granularity for these purposes.

> +  - A trailer, containing a:
> +
> +    checksum of the corresponding packfile, and
> +
> +    a checksum of all of the above.

Could you specify the checksum as having length according to the
specified hash function?

> +All 4-byte numbers are in network order.
> +

Maybe this could be at the start of the format, since the file
version and hash function are both 4-byte numbers here and we
could remove the mention of network order from the mtime values.

> +static char *pack_mtimes_filename(struct packed_git *p)
> +{
> +	size_t len;
> +	if (!strip_suffix(p->pack_name, ".pack", &len))
> +		BUG("pack_name does not end in .pack");
> +	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
> +	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
> +}

I see your NEEDSWORK here and you are probably referring to this:

static char *pack_revindex_filename(struct packed_git *p)
{
	size_t len;
	if (!strip_suffix(p->pack_name, ".pack", &len))
		BUG("pack_name does not end in .pack");
	return xstrfmt("%.*s.rev", (int)len, p->pack_name);
}

and the implementation is identical except for the new trailer
(which exist in the exts[] array in builtin/repack.c, but could
also be pulled out into a header somewhere.

I'm happy to delay any cleanup of these code clones until later,
if at all, because doing it right might mean moving more code
than we like. Such refactorings aren't worth it most of the time.

> +static int load_pack_mtimes_file(char *mtimes_file,
> +				 uint32_t num_objects,
> +				 const uint32_t **data_p, size_t *len_p)
> +{

> +	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
> +		ret = error(_("mtimes file %s is corrupt"), mtimes_file);

This message could be more informative: "mtimes file %s has the wrong size"?

> +	data = hdr = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +
> +	if (ntohl(*hdr) != MTIMES_SIGNATURE) {
> +		ret = error(_("mtimes file %s has unknown signature"), mtimes_file);
> +		goto cleanup;
> +	}

Interesting that you defined 'struct mtimes_header' before this
method, but don't use it here (in favor of moving a uint32_t
pointer). Perhaps you are avoiding pointing the struct at the
memory map, but you could also do this:

	struct mtimes_header header;

	header.signature = ntohl(hdr[0]);
	header.version = ntohl(hdr[1]);
	header.hash_id = ntohl(hdr[2]);

And then operate on the struct for your validation.

At the very least, 'struct mtimes_header' is defined but not
used in this patch. If you decide to not use it this way, then
maybe delay its definition.

> +
> +	if (ntohl(*++hdr) != 1) {
> +		ret = error(_("mtimes file %s has unsupported version %"PRIu32),
> +			    mtimes_file, ntohl(*hdr));

Unlike the commit-graph, if we don't understand the version we
cannot simply ignore the data. error() is appropriate here.

> +int load_pack_mtimes(struct packed_git *p)
> +{
> +	char *mtimes_name = NULL;
> +	int ret = 0;
> +
> +	if (!p->is_cruft)
> +		return ret; /* not a cruft pack */

Interesting that this indicator is essentially "we have an mtimes
file for this pack", but it makes sense to include that check next
to the .keep and .promisor checks.

> +uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos)
> +{
> +	if (!p->mtimes_map)
> +		BUG("pack .mtimes file not loaded for %s", p->pack_name);
> +	if (p->num_objects <= pos)
> +		BUG("pack .mtimes out-of-bounds (%"PRIu32" vs %"PRIu32")",
> +		    pos, p->num_objects);
> +
> +	return get_be32(p->mtimes_map + pos + 3);
> +}

A nice safe access method. Good.

> -	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor"};
> +	static const char *exts[] = {".pack", ".idx", ".rev", ".keep", ".bitmap", ".promisor", ".mtimes"};

(Speaking of that refactoring earlier, here is a second definition of
exts[] that would be valuable to unify.)

The hunks I did not comment on look good. Nice standard file format
stuff.

Thanks,
-Stolee
