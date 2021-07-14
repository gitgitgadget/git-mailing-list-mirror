Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF74C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652BC613C0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhGNR1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhGNR1M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:27:12 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE4C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:20 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p186so3067833iod.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BtG4+vCaoeZb9p/MB3OEQbNcDEGf7s6+4F9RtfqPPa0=;
        b=R5dGhsbyzDr4g8wMfziA2JVlrYkQm9kc40qIQX5t2ogtDVHExXpjbXZzQWrfGhYrQk
         AsJi5mqXvJIaJQZ4Zks7nEoHJENGG8QVANuM3psWDOPJs+5BJXbigYEhUV7Md5KGarrX
         6jh7guQfO+sbkqoDhQBLl37ut1uYMF2IQiRHiYkbClaV4YeQSp0ved2wXiUaAJs8Wbng
         4K+N5mDIUh8sirrAXR7SktxeepkTp8eVpBjOdUVsHV5KjWi4T4CPS/kIlilYb0bIDVpv
         cAMiGLpi8aVPH+jBix+FDg2lPJA0UirRqtB6D1yrFQ2fzF0einej2TqHsqmbTg9d+0Br
         zpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BtG4+vCaoeZb9p/MB3OEQbNcDEGf7s6+4F9RtfqPPa0=;
        b=szEx01mePII77UyitVxZIOQjxYj0O43pPMzft30Q5+X5S+DMEC0WQlGyel2qNe2nVq
         2G//WAVBsV/ZPlaq9xtPjBc8zMscyuCGCjtT9AjaRbTkmX3Jk5WtYPbZZ2LmMEBVObVK
         414ddC0glsdZ6wdHB9dqDToS28FpcPXvOJbiFl8BXWkT1dZFptkjiw8p+qya4kPObJUb
         Tgbsxco9vw/eVmCFaMTRJTdVrVhQ6IvoIk6/7rnn1iEz2w1oHccOZqZGkIc7glCJyrSH
         as8/MZ2afq7bl0yt9MiYLDsKoRQtHzWdC1otgVpGcZ6IgAcgUuyfeb1HYNd8kUJq5n5g
         M/vw==
X-Gm-Message-State: AOAM53086jI7Yd8e6rqZ2TnQKM4Sp/WsCTee6xVRIWMLE3a+Wh8ze/Ds
        r88BcJEtP+2FJsrMxoqbpcz9ww==
X-Google-Smtp-Source: ABdhPJxIMFjZNTOeIeqoLuGyg+cyIRSpmUS0QWaLLLJ3vUbA5+wFP+zb+cij86/SgLhP+b1Uyc0dCQ==
X-Received: by 2002:a5d:9396:: with SMTP id c22mr8213357iol.204.1626283459699;
        Wed, 14 Jul 2021 10:24:19 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id x10sm1452246ill.26.2021.07.14.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:24:19 -0700 (PDT)
Date:   Wed, 14 Jul 2021 13:24:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 01/24] pack-bitmap.c: harden 'test_bitmap_walk()' to
 check type bitmaps
Message-ID: <YO8dwitqG/pw2Mqn@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a18baeb0b42994ebcb216df5fe69459ba9a33795.1624314293.git.me@ttaylorr.com>
 <87k0mizws5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0mizws5.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 01:02:56AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Jun 21 2021, Taylor Blau wrote:
>
> > +	enum object_type bitmap_type = OBJ_NONE;
> > +	int bitmaps_nr = 0;
> > +
> > +	if (bitmap_get(tdata->commits, pos)) {
> > +		bitmap_type = OBJ_COMMIT;
> > +		bitmaps_nr++;
> > +	}
> > +	if (bitmap_get(tdata->trees, pos)) {
> > +		bitmap_type = OBJ_TREE;
> > +		bitmaps_nr++;
> > +	}
> > +	if (bitmap_get(tdata->blobs, pos)) {
> > +		bitmap_type = OBJ_BLOB;
> > +		bitmaps_nr++;
> > +	}
> > +	if (bitmap_get(tdata->tags, pos)) {
> > +		bitmap_type = OBJ_TAG;
> > +		bitmaps_nr++;
> > +	}
>
> This made me wonder if this could be better with something like the
> HAS_MULTI_BITS() macro, but that trick probably can't be applied here in
> any shape or form :)

Right; since we're looking at the same bit position in each of the
type-level bitmaps, we can't just OR them together, since all of the
bits are in the same place.

And really, the object_type enum doesn't have values that tell us the
type of an object by looking at just a single bit. So
HAS_MULTI_BITS(OBJ_BLOB) would return "true", since OBJ_BLOB is 3.

> > +
> > +	if (bitmap_type != obj->type)
> > +		die("object %s: real type %s, expected: %s",
> > +		    oid_to_hex(&obj->oid),
> > +		    type_name(obj->type),
> > +		    type_name(bitmap_type));
>
> To argue against myself (sort of) about that "== OBJ_NONE" above, if
> we're not assuming that then it's sort of weird not to also assume that
> type_name(type) won't return a NULL in the case of OBJ_NONE, which it
> does (but this code guards against).

I tend to agree. To restate what you're saying: by the time we get to
the type_name(bitmap_type) we know that bitmap_type is non-zero, so we
assume it's OK to call type_name() on it.

Of course, the object_type_strings does handle the zero argument, so
this is probably a little academic, but good to think through
nonetheless.

Thanks,
Taylor
