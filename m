Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6326C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiEYVgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiEYVgx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:36:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321DBAB0C8
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:36:52 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g3so18326290qtb.7
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PoDe0BPKw1RSgddXq9sIR4x/kzAJDQI3Xa4H9biCwWw=;
        b=cExv3l8483YFbl2923A02ffgE5qhgcbL6ea5Tvr4wW79z8TytToOlln+3QLSPaFaxl
         b7QecgoUhOu1I6FfsVi86kyaiz+COZQu89Lr10kJjDvLxd8r/ihWaKE/8Gf7Zoiv+8y9
         JT2uA0hxKpveZaZEopbDKHsXNikVMWxptc4BANPpq35dDX9s5zDDADiLE92dlrdq5aTZ
         OWWgQ4rzkWq8RuMGF7sMR1033QxBqtz8kjMGYwZYZ5gDlfJ5NQeJ9spGJWGhG1r626Ai
         +ECCzg8HwSofZqLNrilZbtGfBu//c8jBIl63L79WOTe5lVHJ/bel7DObQ6sXwAdVmn5I
         x0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PoDe0BPKw1RSgddXq9sIR4x/kzAJDQI3Xa4H9biCwWw=;
        b=jcv/tOGVtDAQOx/jV8CJG3rrcUOJn4f7Xv+qeReAffjZS7PfV0Tz44nTUMpTR/SYVU
         iJwpC96NWuMd61+YJLEs1QzS/zv/yY1hdqCEGrXgyJyFowgazBha/jqLo9YzTnVMfILr
         M/zd1kxjJfRcoOXignp3kMU376NwDrfkTcIM1M6cYeebtk/bXHAm+ToSh0ZaR6ARtqW6
         2wowtx2Gy/vB/Cf0rORJdMKPambaW5WcVhBZWuFxohYjbV8veJoMmvZjYDmglM7X6Do/
         8Gg99gV1TBiZgZT1t7NgTfv1tEnBjeAOB1l7KtyMbF3okUwOz+tRWBUPoV3mWHRGEJzO
         OCJg==
X-Gm-Message-State: AOAM533caOOmRYz4f5JE/2sIbmHt/7WUmNoej0pHc6TlocTsJjst25Pi
        Fn+ohE3iJNbQs4xHzMsft8EzOQ==
X-Google-Smtp-Source: ABdhPJwavHZQrPvhnqBK4VkMWzOeo75Ab8c4vP7PrCpawzSF9KK/1tDx/O3fbkpDOJsZOVu/xeUF+A==
X-Received: by 2002:a05:622a:492:b0:2f9:307d:d102 with SMTP id p18-20020a05622a049200b002f9307dd102mr16202663qtx.351.1653514611292;
        Wed, 25 May 2022 14:36:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o22-20020ac84296000000b002f93554c009sm2177891qtl.59.2022.05.25.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:36:50 -0700 (PDT)
Date:   Wed, 25 May 2022 17:36:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yo6hcOjIlYglqdxs@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com>
 <Yo1aaLDmPKJ5/rh5@nand.local>
 <Yo3fZkpkCLPbAC8B@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo3fZkpkCLPbAC8B@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2022 at 12:48:54AM -0700, Jonathan Nieder wrote:
> >> What does mtimes_map contain?  A comment would help.
> >
> > It contains a pointer at the beginning of the mmapped region of the
> > .mtimes file, similar to revindex_map above it.
>
> To be clear, in cases like this by "comment" I mean "in-code comment".
> I.e., my interest is not that _I_ find out the answer but that the
> code becomes more maintainable via the answer becoming easier to find.

OK. I'll add a comment in the fixup! patch which I'm about to send.

> [...]
> >> This seems simple enough that it's not obvious we need more code
> >> sharing.  Do you agree?  If so, I'd suggest just removing the
> >> NEEDSWORK comment.
> >
> > Yeah, it is conceptually simple, though it feels like the sort of thing
> > that could benefit from not having to be written once for each
> > extension (hence the comment).
>
> The reason I asked is that the NEEDSWORK here actually got in the way
> of comprehension for me --- it made me wonder "is there some
> complexity here I'm missing?"
>
> That's why I'd suggest one of
> - removing the NEEDSWORK comment
> - going ahead and implementing the code sharing you mean, or
> - fleshing out the NEEDSWORK comment so the reader can wonder less

I am a little sad to remove it, since I thought it was useful as-is. But
I can just as easily remember to come back to this myself in the future,
so if it is distracting to you in the meantime, then I don't mind
holding onto it in my own head.

> >>> +
> >>> +#define MTIMES_HEADER_SIZE (12)
> >>> +#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))
> >>
> >> Hm, the all-caps name makes this feel like a compile-time constant but
> >> it contains a reference to the_hash_algo.  Could it be an inline
> >> function instead?
> >
> > Yes, it could be an inline function, but I don't think there is
> > necessarily anything wrong with it being a #define'd macro. There are
> > some other examples, e.g., RIDX_MIN_SIZE, MIDX_MIN_SIZE,
> > GRAPH_DATA_WIDTH, and PACK_SIZE_THRESHOLD (to name a few) which also use
> > the_hash_algo on the right-hand side of a `#define`.
>
> Those are due to an incomplete migration from use of the true constant
> GIT_SHA1_RAWSZ to use of the dynamic value the_hash_algo->rawsz, no?
> In other words, "other examples do it wrong" doesn't feel like a great
> justification for making it worse in new code.

Fair point. I can imagine reasons for the existing pattern, but updating
it to handle the variable rawsz is easy to do (and it probably should
have been that way since the beginning).

> [...]
> >>> +static int load_pack_mtimes_file(char *mtimes_file,
> >>> +				 uint32_t num_objects,
> >>> +				 const uint32_t **data_p, size_t *len_p)
> >>
> >> What does this function do?  A comment would help.
> >
> > I know that I'm biased as the author of this code, but I think the
> > signature is clear here. At least, I'm not sure what information a
> > comment would add that the function name and its arguments don't already
> > convey.
>
> Ah, thanks for this point of clarification.  What isn't clear from the
> signature is
> - when should I call this function?
> - what does its return value represent?
> - how does it handle errors?
>
> I agree that the parameters are self-explanatory.

I'm hesitant to over-document a static function with a single caller,
but when looking at this, I think there is an opportunity to document
_its_ caller (`load_pack_mtimes()`) which isn't static, but was also
missing documentation.

> >>> +cleanup:
> >>> +	if (ret) {
> >>> +		if (data)
> >>> +			munmap(data, mtimes_size);
> >>> +	} else {
> >>> +		*len_p = mtimes_size;
> >>> +		*data_p = (const uint32_t *)data;
> >>
> >> Do we know that 'data' is uint32_t aligned?  Casting earlier in the
> >> function could make that more obvious.
> >
> > `data` is definitely uint32_t aligned, but this is a tradeoff, since if
> > we wrote:
> >
> >     uint32_t *data = xmmap(...);
> >
> > then I think we would have to change the case where ret is non-zero to be:
> >
> >     if (data)
> >         munmap((void*)data, ...);
> >
> > and likewise, data_p is const.
>
> Doing it that way sounds great to me.  That way, the type contains the
> information we need up-front and the safety of the cast is obvious in
> the place where the cast is needed.
>
> (Although my understanding is also that in C it's fine to pass a
> uint32_t* to a function expecting a void*, so the second cast would
> also not be needed.)
>
> [...]

Done, thanks for the suggestion.

Thanks,
Taylor
