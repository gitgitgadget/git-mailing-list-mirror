Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0410C76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 23:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCXXNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCXXNT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 19:13:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE381557F
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 16:13:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-544b959a971so60813777b3.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679699598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78+a601EfbAePk2OyTi6G0AFoaWdZMgj6Ok4XQ82K0Y=;
        b=LiIOc37vwr4DG+40rRzfL+on7CcUY8lFYlM0LS3IzWpIsdKnPxinbDv1wx1b+BpWWE
         q7IuLOF7UnXCR7lX6AIJREWzvcgjfmCGjMBA6r6QwoAFHj470DCKPoBvtmFRlbRyabGV
         UECkpKlJJfEp0RwnNud0CX/DpM9Hm+hJ7dor8BwLUdymrR+Ov/T87S2TQTooKNu+rex9
         PlMvtkhrN6kITYxiEqi19ZL1jn3oNymkqLNrkYysE/ILGJUx1w8zUvZZ4sXcTymebBg1
         xqsLtXggmOWCnuU/E8SkqdobcQ9MP02688hiAQcD/4JQfWdhZVxkCdFfbybZj/vUbdI3
         /Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679699598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78+a601EfbAePk2OyTi6G0AFoaWdZMgj6Ok4XQ82K0Y=;
        b=K/lRw/LqBvptkjh3/q9nZRs/Ny4NYQcPgeJ7h8UkxzyweE3eZb57jTPMTFnpYK/f/D
         me4a4KFvOfsfZq6Lw5yLPbI2HptqTLo9xbZ863mnUilfxZAVL67tsL0XrZ8WNU1OOrAd
         fkVqGATSwOJTvLfPh4X48JUvd/krqZZVAQvcoZPRX1BIfLMPNNhzSLWEV783ns0cCVAD
         8f1iJ6rN7DiIv/+l7MJjXJXbEFZG1WdHFhxMnpjL1PRY+MhyGASa+FFH0xQya1sSiqPY
         2neZPD/EaVhomLPnLD33rbZGCsOCiH+BWilSKUyi9dfzL/ubvhcRgicFAmQqqIQC7+jJ
         vehw==
X-Gm-Message-State: AAQBX9cFr+p6DTEkFbjONaQ+R/e8yRGE41pH6knoOf/MRZiZUeGF7FZm
        Qwr0Grjyj5Sea/Jvj0F5gFQSfP91nkbcs1A3W+na/Q==
X-Google-Smtp-Source: AKy350ZGGT6e2mlhNMsDS5ZiB0skwCVGJwStVsn96mSdEk2fosdwQmlfTFuqdRG8REuHnNLgqRw3eg==
X-Received: by 2002:a81:6dd7:0:b0:545:6368:45d4 with SMTP id i206-20020a816dd7000000b00545636845d4mr3936647ywc.0.1679699598181;
        Fri, 24 Mar 2023 16:13:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bw10-20020a05690c078a00b00545a08184c7sm682549ywb.87.2023.03.24.16.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:13:17 -0700 (PDT)
Date:   Fri, 24 Mar 2023 19:13:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos`
 manipulation
Message-ID: <ZB4ujCTiRgAmZaQo@nand.local>
References: <cover.1679342296.git.me@ttaylorr.com>
 <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
 <20230321175612.GF3119834@coredump.intra.peff.net>
 <61ae4ad5-4d4d-933c-a2cb-e7e2cd734401@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61ae4ad5-4d4d-933c-a2cb-e7e2cd734401@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 02:04:05PM -0400, Derrick Stolee wrote:
> The other alternative would be to use an enum instead of an arbitrary int.
> The compiler can warn to some extent, but it's not as helpful as a method
> name distinction.

Yeah, I think that another enum here just to distinguish between seeking
to an absolute position versus a relative one is probably overkill in
this instance.

> >> +	if (bitmap_git->map_pos >= bitmap_git->map_size)
> >> +		BUG("bitmap position exceeds size (%"PRIuMAX" >= %"PRIuMAX")",
> >> +		    (uintmax_t)bitmap_git->map_pos,
> >> +		    (uintmax_t)bitmap_git->map_size);
> >
> > This uses ">=", which is good, because it is valid to walk the pointer
> > to one past the end of the map, which is effectively EOF. But as above,
> > in that condition the callers should be checking for this EOF state
> > before reading the bytes.
>
> In other words, it would be too easy for a strange data shape to trigger
> this BUG() statement, which should be reserved for the most-extreme cases
> of developer mistake. Things like "this is an unacceptable 'whence' value"
> or "this should never be NULL" make sense, but this is too likely to be
> hit due to a runtime error.

> Would it make sense to return an 'int' instead of the size_t of map_pos?
> That way we could return in error if this is exceeded, and then all
> callers can respond "oh wait, that move would exceed the file size, so
> I should fail in my own way..."?

Works for me. I think bitmap_index_seek_to() would probably return the
error() itself, since I don't think it makes sense to require each
caller to come up with the same "bitmap position exceeds size" thing.

We want the message from that error() to appear regardless, but each
caller can decide what it wants to do in the presence of an error (e.g.,
continue on, propagate the error, abort the program, etc).

Something like this:

    static int bitmap_index_seek_to(struct bitmap_index *bitmap_git, size_t pos)
    {
      bitmap_git->map_pos = pos;

      if (bitmap_git->map_pos >= bitmap_git->map_size)
        return error(_("bitmap position exceeds size "
                       "(%"PRIuMAX" >= %"PRIuMAX")"),
                     (uintmax_t)bitmap_git->map_pos,
                     (uintmax_t)bitmap_git->map_size);
      return 0;
    }

Thanks,
Taylor
