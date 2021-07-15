Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B86C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C8361002
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhGOOgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOOgn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 10:36:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E02DC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:33:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j5so5173485ilk.3
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=041UcLZaN/+V4AhdjCuMC7F8e5yDtWr/neV/wIGTZEQ=;
        b=ascvetwAN4kYf0m3sDktY+HGsvIII9Vdjq3mUQzOXBr798Lt95AMrwR1J7ptMeJ2Zh
         V+TOwNC9Dgjjd5494n55r36zU/HazV4N9a245RE7fHIzyI2BcWIGohP2x37nwaOY4mRA
         2FK6vBMn+G4VjSLngCF6+nKOeq+xH4CrP9yJ1pWMNgesIZj90R5WsXK5nbRsyHVC9cIH
         LN64fm5HFWAkgTE/Cm6jNI0DsqPFK9aVHJtJyGQsGyNkMMc94+OUTlT3PKEmvpWpq3AE
         SYBHwLbW/p0IOgjmi/Y1/98i1wWcbwuhQdGaTxTMVTjgF/cOUxY83A+fz1aCQJp3dH/v
         0enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=041UcLZaN/+V4AhdjCuMC7F8e5yDtWr/neV/wIGTZEQ=;
        b=ajs2jwJ1rv4J1nVB2DPtVondZhbkpizT1yuflkHh/WM1No957vsQwUWy1pi2jiJyfX
         pGhmZEGSYzxXGs7NfePTJVhqg00t1oFWtKyEy1m+CGrcGVeLRE+je4eUQrwqQ39weLnI
         iCKjN6wo3MhZXaLHmS8xVUAsGqNQdrwboCuFyjfXoV3JvW/GjzTBfTAzCUUhFeH0ubkJ
         qftgpVQWCjd1zk3L2pzs+kqMUaaw926xvb/txniA/ZMpZbLbv42RgUxxGGgwzAB43e/t
         5kBpumHIOupCgv3C0Dy1+b9nTa2XX5oYxzFVY0Ptd9nP/OCkj4HLyUP3cr4gfST8GyQg
         BF4A==
X-Gm-Message-State: AOAM532WC1IVfaYE7SMf5yPpFyKBI1ut7xDjltdfVE/4vlYfctc8zsyN
        dkkzWw7bCsYjEr0loJe1n1xW7A==
X-Google-Smtp-Source: ABdhPJyyOwKv+y6wi15S2IHkgLIt+BkKa9btsx9q3Ex+npcMSlock45vyELPa3dKjBoyQv7EyYSftQ==
X-Received: by 2002:a05:6e02:1a67:: with SMTP id w7mr2837673ilv.175.1626359629879;
        Thu, 15 Jul 2021 07:33:49 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:d40c:332:312b:8a8c])
        by smtp.gmail.com with ESMTPSA id v11sm2969791ilh.52.2021.07.15.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 07:33:49 -0700 (PDT)
Date:   Thu, 15 Jul 2021 10:33:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <YPBHSWaACJcQRy2K@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
 <8735t6zucn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735t6zucn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 01:45:46AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Jun 21 2021, Taylor Blau wrote:
> > +* Write a MIDX file for the packfiles in the current .git folder with a
> > +corresponding bitmap.
> > ++
> > +-------------------------------------------------------------
> > +$ git multi-pack-index write --preferred-pack <pack> --bitmap
> > +-------------------------------------------------------------
> > +
>
> I wondered if this was a <pack> positional argument, but it's just the
> argument for --preferred-pack, even though the synopsis uses the "="
> style for it. Even if parse-options.c is loose about it, let's use one
> or the other in examples consistently.

The example below (for writing a MIDX in an alternate object store)
doesn't include the '=', but probably would be clearer if it did. I
think it's a good suggestion, though, so I'll fix up my addition here.

> > +	memset(pdata, 0, sizeof(struct packing_data));
>
> We initialize this on the stack in write_midx_bitmap(), shouldn't we
> just there do:
>
>     struct packing_data pdata = {0}
>
> Instead of:
>
>     struct packing_data pdata;
>
> And then doing this memset() here?

I could go either way. Part of me prefers the memset() since it lets
callers of prepare_midx_packing_data() pass in anything they want,
including a pointer to uninitialized memory. Of course, there is only
one such caller, so it probably doesn't really matter.

And the other caller of prepare_packing_data() which is in
builtin/pack-objects.c operates on a pointer to a statically allocated
variable, so its bytes are already zero'd.

I don't feel strongly about it, though, so I'd just as soon err on the
side of flexibility than changing the declaration.

> > +{
> > +	struct rev_info revs;
> > +	struct bitmap_commit_cb cb;
> > +
> > +	memset(&cb, 0, sizeof(struct bitmap_commit_cb));
>
> Another case of s/memset/"= {0}"/g ?

Ah, in this case I'd prefer the aggregate-style initialization, since
we're zero-ing it out in the same function.

> >  static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
> >  			       struct string_list *packs_to_drop,
> >  			       const char *preferred_pack_name,
> > @@ -930,9 +1100,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >  		for (i = 0; i < ctx.m->num_packs; i++) {
> >  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> >
> > +			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> > +				error(_("could not load pack %s"),
> > +				      ctx.m->pack_names[i]);
>
> Isn't the prepare_midx_pack() tasked with populating that pack_names[i]
> that you can't load (the strbuf_addf() it does), but it can also exit
> before that, do we get an empty string here then? Maybe I'm misreading
> it (I haven't run this, just skimmed the code).

Nice catch, we can't rely on ctx->m.pack_names[i] being safe to read
(and at the same time know that we're going to get a non-empty string).

Since prepare_midx_pack() can fail because the pack itself couldn't be
loaded, I think the easiest thing to do here is to just opaquely say
"could not load pack" without adding any pack name that we may or may
not have.

> > @@ -1132,6 +1342,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >  	free(ctx.pack_perm);
> >  	free(ctx.pack_order);
> >  	free(midx_name);
> > +	if (ctx.m)
> > +		close_midx(ctx.m);
> > +
>
> I see Stolee made close_midx() just return silently if !ctx.m in
> 1dcd9f2043a (midx: close multi-pack-index on repack, 2018-10-12), but
> grepping the uses of it it seems calls to it are similarly guarded by
> "if"'s.
>
> Just a nit, weird to have a free-like function not invoked like
> free. Perhaps (and maybe better for an unrelated cleanup) to either drop
> the conditionals, or make it BUG() if it's called with NULL, but at
> least we should pick one :)

I agree with the direction of 1dcd9f2043a, so I'm happy to just drop the
conditional and call close_midx() with an argument that may or may not
be NULL.

Thanks,
Taylor
