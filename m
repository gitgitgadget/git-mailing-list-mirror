Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB818C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 19:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiITTtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiITTtK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 15:49:10 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058596CF71
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:49:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id m16so1965561iln.9
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=I+lJnsF/ezjqSKG5X4FyiSk6lONhCoBbYCZv/xe1drI=;
        b=AVL9WLFjTzAE1XxDAqiJgdmAlM3qiYuz1UfBcZsKAfHivkElSSM0NKGIZWVFA0mxSh
         xkJeS4bGL5EG+VFvYcA8mR+5aMiHUMgaV9/iy2Wa98slg0pVG4Ux9X6rrC/K5GTsHb7l
         3mEaRlwZOgjVHACp4TQFnU2YP2bvYp0J0+NZI5xJ82IlQWvhyBiWgp1tkWg8TQAgYj7z
         cX2YVPb9g3lbA2luU60BSQAoix2Mw1/kIhf8kVM/Fi0Y1I1sdzA6RSjUnyUY6bqtCSKF
         029SqrZvDEL4+eWLNQG7p46zR75JOisYbtct9VxMYWJkQCxFMo2iiZvatdIU34GPwoF1
         LsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=I+lJnsF/ezjqSKG5X4FyiSk6lONhCoBbYCZv/xe1drI=;
        b=LleV20OKeMxdwYVDdsx7fghDSnbJUMHMARFMjpZPO2So5XKMlhHlAc1NQXl6v48D8z
         wCC2Akavg37crPqcCFFgKPNf3WplKPKSjGOkz1AU49acBzVR5x6/i+jAfZOXg3CbXVVe
         UmoGKsKwcl8iXYpB2Zoj6dVNPITqMsRZ/TloahR9Nqg+NF6EVeQ24NEj3P7KM6zX2bre
         JnmbFbcav5/qdFOSJ/SYG67qpweH9NkuIQz9sdjE3R6URdWl/yUdZKqxRk5f2GfM7boP
         ya0b2eAEpNjpFcCHOaW+wSOWMcOKXrVM0vsslbTj/Xt4KDP2HJLdy3b/BNmtZK1ENw2r
         Fgww==
X-Gm-Message-State: ACrzQf3EATCL/q40+okA6lWfbjm6GhzsijbO6geFKrE8DK0CQ9WJz6Ck
        h7a8C7dstwc5P748YjUDU+ORhg==
X-Google-Smtp-Source: AMsMyM4Wb6v2l71clrhZKZ4iJub4yxaOfKY8iw8D87Ye4e/tUpp8yKflguKVHU98FzQEc1UWIFcWUg==
X-Received: by 2002:a05:6e02:2191:b0:2f5:aade:9ea0 with SMTP id j17-20020a056e02219100b002f5aade9ea0mr5667725ila.79.1663703349262;
        Tue, 20 Sep 2022 12:49:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r19-20020a6b8f13000000b006a134d3b378sm285192iod.11.2022.09.20.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:49:08 -0700 (PDT)
Date:   Tue, 20 Sep 2022 15:49:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, derrickstolee@github.com
Subject: Re: [PATCH] midx.c: use `pack-objects --stdin-packs` when repacking
Message-ID: <YyoZM1V5S53dz6U6@nand.local>
References: <9195a9ecd11a19f2c7fb1c70136d2d13fa308010.1663639662.git.me@ttaylorr.com>
 <YyoUZb90HeJnOuAV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyoUZb90HeJnOuAV@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 03:28:37PM -0400, Jeff King wrote:
> On Mon, Sep 19, 2022 at 10:08:35PM -0400, Taylor Blau wrote:
>
> > This patch replaces the pre-`--stdin-packs` invocation (where each
> > object is given to `pack-objects` one by one) with the more modern
> > `--stdin-packs` option.
> >
> > This allows us to avoid some CPU cycles serializing and deserializing
> > every object ID in all of the packs we're aggregating. It also avoids us
> > having to send a potentially large amount of data down to
> > `pack-objects`.
>
> Makes sense. Just playing devil's advocate for a moment: is there any
> way that getting the list of packs could be worse? I'm thinking
> particularly of a race condition where a pack goes away while we're
> running, but if we had the actual object list, we could fall back to
> finding it elsewhere.
>
> I think that could only happen if we had two gc's running
> simultaneously, which is something we try to avoid already. And the
> worst case would be that one would say "oops, this pack went away" and
> bail, and not any kind of corruption.
>
> So I think it's fine, but just trying to talk through any unexpected
> implications.

Your assumption is right. We perform those pack validity checks pretty
early these days, see: 5045759de8 (builtin/pack-objects.c: ensure
included `--stdin-packs` exist, 2022-05-24).

We *could* handle the case where we know the object names, but the pack
file has gone away (either we could open the .idx but not the .pack, or
we opened both but then had to close the .pack because of hitting the
max open file-descriptor limit).

...But it gets tricky in practice, and 5045759de8 has some of those
details. At worst we'd complain that one of the packs listed is gone,
and then fail to repack (while maintaining the non-corruptedness of the
repository).

> > But more importantly, it generates slightly higher quality (read: more
> > tightly compressed) packs, because of the reachability traversal that
> > `--stdin-packs` does after the fact in order to gather namehash values
> > which seed the delta selection process.
>
> I think we _could_ do that same traversal even in objects mode. Or do
> --stdin-packs without it. If we were starting from scratch, it might be
> nice for the two features to be orthogonal so we could evaluate the
> changes independently. But I don't think it's worth going back and
> trying to split them out now. Although...

It's relatively easy to do `--stdin-packs` without the traversal. I
wouldn't be opposed to doing that here.

> > In practice, this seems to add a slight amount of overhead (on the order
> > of a few seconds for git.git broken up into ~100 packs), in exchange for
> > a modest reduction (on the order of ~3.5%) in the resulting pack size.
>
> Hmm. I thought we'd have some code to reuse the cached name-hashes in
> the .bitmap file, if one is present. But I don't see any such code in
> the stdin-packs feature. I think for "repack --geometric" it doesn't
> matter. There the "main" pack with the bitmap would also be excluded
> from the rollup (unless we are rolling all-into-one, in which case we do
> the full from-scratch repack with a traversal).

Right.

> Is that true also of "multi-pack-index repack"? I guess it would depend
> on how you invoke it. I admit I don't think I've ever used it myself,
> since the new "repack --geometric --write-midx" approach matches my
> mental model. I'm not sure when you'd actually run the "multi-pack-index
> repack" command. But if you did it with --batch-size=0 (the default), I
> think we'd end up traversing every object in history.

We could probably benefit from it, but only if there is a MIDX bitmap
around to begin with. For instance, you could first try and lookup each
object you're missing a namehash for and then read its value out of the
hashcache extension in the MIDX bitmap (assuming the MIDX bitmap exists,
and has a hashcache).

But if you don't have a MIDX bitmap, or it has a poor selection of
commits, then you're out of luck.

> > @@ -2026,17 +2027,17 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
> >
> >  	cmd_in = xfdopen(cmd.in, "w");
> >
> > -	for (i = 0; i < m->num_objects; i++) {
> > -		struct object_id oid;
> > -		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
> > +	for (i = 0; i < m->num_packs; i++) {
> > +		strbuf_reset(&scratch);
>
> The old code went in object order within the midx. Is this sorted by
> sha1, or the pack pseudo-order? If the former, then that will yield a
> different order of objects inside pack-objects (since it is seeing the
> packs in order of our m->pack_names array). I don't _think_ it matters,
> but I just wanted to double check.

Good point. This ends up ordering the packs based on their SHA-1
checksum, and probably should stick to the pack mtimes instead.

Unfortunately, we discard that information by the time we get to this
point in midx_repack(). We don't even have it written durably in the
MIDX, either, so we reconstruct it on-the-fly in
fill_included_packs_batch() (see the `QSORT()` call there with
`compare_by_mtime()`).

I agree that it probably doesn't matter in practice, but it's worth
trying to match the existing behavior, at least.

Thanks,
Taylor
