Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1120DC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 23:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCXXJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXXI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 19:08:59 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602165BA0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 16:08:58 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536af432ee5so61345637b3.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679699337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhpbxjGWj80r/fAFHIdRCJCuIwk9A2OZv/f+n3Gn8NA=;
        b=p2povjS0j1fOJLdingXLb82/PLHVmXrGwarJA3g75IVqG7sS9KpXuJRSJQOA5NfFZA
         Pligwf++vUPY+yQbWNAavxysjk3soBfW/geXcHmTXUNze80pIRGuOzI8fIn5cvwtoPnn
         pJL9lrvxG3lYP60sdOY5j/V4T7H+hl9lnBFbp6A2PSXQiuK8CLcJ6x2mIFZlzz2y45rL
         tKrAviRGlloCUWOmVLt3GF/0VAod8I/TBUUufpCqVy763A0hGsQANd8RjyAcJnHH1v3S
         FswRvAONT+Ra14jUCK5qoIsDoEKe8sqhEAfFwsz+s2PtS8FSjB7V+8E9qtY7/s8bEsxj
         SwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679699337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhpbxjGWj80r/fAFHIdRCJCuIwk9A2OZv/f+n3Gn8NA=;
        b=fTzFJyDe4QJPkUW2qDG8LIzoXFTjEQOEDGWaa7Fy9e89Yo3Atjbj++vFkLcbHpOgh9
         KHDDf05rXJkR/oqnXeBI0Bf8u1F2Lq0pl/UmNUuYBkAxCT2+8zyBIbor+I5EVKVxYFQT
         ZQt92Pbjf+SOI+DN2GNkWKDxRjqXCf/IiD3r9a9Yk38hda7jzJA+FQBwS4jBLzp/2jf0
         xXlYDrVZPZBwpgmu9p+fRAtecxcHDoPzVWoGak+c6yPhG3a2+wMr3jZ7Q7rEx7Hee9DM
         CZ45mVKOzt3nG2oTqO9Qu+iL521hNM62uVLt+Q4Rlif3eFCILz8EJZEJuY6eibU0QPxK
         4ubw==
X-Gm-Message-State: AAQBX9c/WtXHDjjCM4aR2/Gj7506xpVp7uTKKTRSv9vm9GsirNMqbs9U
        WqBo7CZhZmK3QQjPlOUUUN/G2MhYc6Gy7BJh8GC1ug==
X-Google-Smtp-Source: AKy350ZqDhkJMAnOPpoWy6vrr+ajVNaS6yUKNLG7aT5sN/ClBr6N6kQ0O1JiFoDX9nDG6wzBpvc5ew==
X-Received: by 2002:a81:9109:0:b0:541:8ad0:296f with SMTP id i9-20020a819109000000b005418ad0296fmr3772900ywg.49.1679699337446;
        Fri, 24 Mar 2023 16:08:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 194-20020a8105cb000000b00545a08184b5sm668432ywf.69.2023.03.24.16.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:08:57 -0700 (PDT)
Date:   Fri, 24 Mar 2023 19:08:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos`
 manipulation
Message-ID: <ZB4tiLfNsD3LW/JS@nand.local>
References: <cover.1679342296.git.me@ttaylorr.com>
 <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
 <20230321175612.GF3119834@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230321175612.GF3119834@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 01:56:12PM -0400, Jeff King wrote:
> I like the idea of centralizing the bounds checks here.
>
> I do think copying lseek() is a little awkward, though. As you note, we
> only care about SEEK_SET and SEEK_CUR, and we have to BUG() on anything
> else. Which means we have a run-time check, rather than a compile time
> check. If we had two functions like:
>
>   void bitmap_index_seek_to(struct bitmap_index *bitmap_git, size_t pos)
>   {
> 	bitmap_git->map_pos = pos;
> 	if (bitmap_git->map_pos >= bitmap_git->map_size)
> 	   ...etc...
>   }
>
>   void bitmap_index_incr(struct bitmap_index *bitmap_git, size_t offset)
>   {
> 	bitmap_index_seek_to(bitmap_git, st_add(bitmap_git->map_pos, offset));
>   }
>
> then the compiler can see all cases directly. I dunno how much it
> matters.

Yeah, I think that trying to copy the interface of lseek() was a
mistake, since it ended up creating more awkwardness than anything else.
I like the combination of bitmap_index_seek_to() and _incr(), though
though I called the latter bitmap_index_seek_set() instead.

We've got to be a little reminiscent of lseek() after all ;-).

> The other thing that's interesting from a bounds-checking perspective is
> that you're checking the seek _after_ you've read an item. Which has two
> implications:
>
>   - I don't think we could ever overflow size_t here.

Yep, agreed. Let's drop the st_add() call there entirely, since it's not
doing anything useful and just serving to confuse the reader.

>   - The more interesting case is that we are not overflowing size_t, but
>     simply walking past bitmap_git->map_size. But again, we are reading
>     first and then seeking. So if our seek does go past, then by
>     definition we just read garbage bytes, which is undefined behavior.
>
>     For a bounds-check, wouldn't we want it the other way around? To
>     make sure we have 4 bytes available, and then if so read them and
>     increment the offset?

I thought on first blush that this would be a much larger change, but
actually it's quite small. The EWAH code already checks its reads ahead
of time, so we don't have to worry about those. It's really that
read_be32() and read_u8() do the read-then-seek.

So I think that the change here is limited to making sure that we can
read enough bytes in those functions before actually executing the read.

> > +	if (bitmap_git->map_pos >= bitmap_git->map_size)
> > +		BUG("bitmap position exceeds size (%"PRIuMAX" >= %"PRIuMAX")",
> > +		    (uintmax_t)bitmap_git->map_pos,
> > +		    (uintmax_t)bitmap_git->map_size);
>
> This uses ">=", which is good, because it is valid to walk the pointer
> to one past the end of the map, which is effectively EOF. But as above,
> in that condition the callers should be checking for this EOF state
> before reading the bytes.

I think that having both is useful. Checking before you read avoids
undefined behavior. Checking after you seek ensures that we never have a
bitmap_index struct with a bogus map_pos value.

Thanks,
Taylor
