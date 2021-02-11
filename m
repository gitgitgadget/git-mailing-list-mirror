Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E84C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 03:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E6664E31
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 03:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBKDDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKDDy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 22:03:54 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9EC061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 19:03:14 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id m144so3956667qke.10
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 19:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m08OJstak4Nsk9s6OIZQSSLjd/hypd/u5P4aMWwu/8g=;
        b=g2/a9N8EFyANcG8tbKsYZHH8O1GMsySwjSpra/E8UHyZrEPocGbb4x88FWpeRVz13C
         LOKFcfW+MxiNvgfYQwLyvYQWcuHNvSUSPqqrzQmrXfEkJ99bQfqQ7W1vPXQ/hY/V9rcc
         k+l47bRo8Hom5Nycjst7xz+ljIfYcf3+no7NdSi4faNrFog3vll08mOUwh8cN9w3tVe3
         PtunwbvpEw+YsGmNwkvQUZS6wof+RARJbXSEvXKSJ09mYaLwSq3mwf2do+K6gsaCN+ZV
         OMnpOFw+CSPlGsdkbAiqhpA0lFplk3sDeR7W5c2v7td7enEMgxnjUYXtRZiE99323T1E
         gyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m08OJstak4Nsk9s6OIZQSSLjd/hypd/u5P4aMWwu/8g=;
        b=cR+peKwAYOowe9voTE4B9GDhlwCfxoPY+bD8YgRb+6ZV+bYDVLVgrW2FE+PZVt0Er0
         LcHrxTeCHYasv9PJiUXdXDr5JV5rS7RLiTPC1LBXOzzO5xKRciGfGreoJb/M6v/V4yQ+
         gUS763DYegwbqvNDKbShuWoG1THDSXTT7vtoh7ETEcg0swLeWfoADA8StIT1aKZXTUOR
         S5vFLUS8XXUDKoQVxkNmMhc7RXZ9WOoyLCXboRjCwTwa1K8xKGLPL5ZizAnb1ykZ1MoZ
         slgi/ZHdMfHzQ2R3EZrrmh8JlnfcFj765SatK2lCAJL9kcoXk5rT/ebFoatKPhiqYHpN
         1HXQ==
X-Gm-Message-State: AOAM530I0JzfAakoQdJAQNZfPc2iC6vfsHDjzeDXKOb9FdImk8DQKRVo
        13eM4b9cF3E7elWwbuZ2UGAc+Q==
X-Google-Smtp-Source: ABdhPJxItSCoax2tUp4MVrGJ19sIBOgb/o9yzswZt0Aa9YTJy6a3KbudkKXqHPhC7UlTP4ddhT8Ttg==
X-Received: by 2002:a37:54b:: with SMTP id 72mr6248295qkf.338.1613012593582;
        Wed, 10 Feb 2021 19:03:13 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:666f:3d4:2894:5ee9])
        by smtp.gmail.com with ESMTPSA id o12sm2888127qkm.81.2021.02.10.19.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 19:03:13 -0800 (PST)
Date:   Wed, 10 Feb 2021 22:03:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 6/9] Documentation/technical: describe multi-pack reverse
 indexes
Message-ID: <YCSeami0pkLy20tK@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <e64504bad6e181522946a8f234e12f569bede89e.1612998106.git.me@ttaylorr.com>
 <320ef364-05ac-7d51-a6f9-770d32590766@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <320ef364-05ac-7d51-a6f9-770d32590766@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 09:48:20PM -0500, Derrick Stolee wrote:
> nit: use multi-pack-index or MIDX, not lower-case 'midx'.

Thanks.

> > +Crucially, the objects' positions within this pseudo-pack are the same
> > +as their bit positions in a multi-pack reachability bitmap.
> > +
> > +As a motivating example, consider the multi-pack reachability bitmap
> > +(which does not yet exist, but is what we are building towards here). We
> > +need each bit to correspond to an object covered by the midx, and we
> > +need to be able to convert bit positions back to index positions (from
> > +which we can get the oid, etc).
>
> These paragraphs are awkward. Instead of operating in the hypothetical
> world of reachability bitmaps, focus on the fact that bitmaps need
> a bidirectional mapping between "bit position" and an object ID.

Hmm. I could buy that these paragraphs are awkward, but I'm not sure
that what you proposed makes it less so.

I may be a bad person to judge what you wrote, since I am familiar with
the details of what it's describing. But my thoughts on that second and
third paragraph are basically:

  - define the valid orderings we might consider objects in a MIDX by,
    indicating which of those orderings we're going to use for
    multi-pack bitmaps

  - motivate the need for a mapping between lexicographic order and
    pseudo-pack order

> Here is an attempt to reword some of the context you are using here.
> Feel free to take as much or as little as you want.
>
>   The multi-pack-index stores the object IDs in lexicographical order
>   (lex-order) to allow binary search. To allow compressible reachability
>   bitmaps to pair with a multi-pack-index, a different ordering is
>   required. When paired with a single packfile, the order used is the
>   object order within the packfile (called the pack-order). Construct
>   a "pseudo-pack" by concatenating all tracked packfiles in the
>   multi-pack-index. We now need a mapping between the lex-order and the
>   pseudo-pack-order.

I struggled with what you wrote because I couldn't seem to neatly
place/replace that paragraph in with the existing text without referring
to yet-undefined concepts.

Maybe the confusion lies in the fact that we stray too far from the
point in the second and third paragraphs. What if we reordered the
second, third, and fourth paragraph like this:

		Instead of mapping between offset, pack-, and index position, this
		reverse index maps between an object's position within the MIDX, and
		that object's position within a pseudo-pack that the MIDX describes.

		To clarify these three orderings, consider a multi-pack reachability
		bitmap (which does not yet exist, but is what we are building towards
		here). Each bit needs to correspond to an object in the MIDX, and so we
		need an efficient mapping from bit position to MIDX position.

		One solution is to let bits occupy the same position in the oid-sorted
		index stored by the MIDX. But because oids are effectively random, there
		resulting reachability bitmaps would have no locality, and thus compress
		poorly. (This is the reason that single-pack bitmaps use the pack
		ordering, and not the .idx ordering, for the same purpose.)

		So we'd like to define an ordering for the whole MIDX based around
		pack ordering, which has far better locality (and thus compresses more
		efficiently). We can think of a pseudo-pack created by the concatenation
		of all of the packs in the MIDX. E.g., if we had a MIDX with three packs
		(a, b, c), with 10, 15, and 20 objects respectively, we can imagine an
		ordering of the objects like:

> [snip]
>
> The rest of these details make sense and sufficiently motivate the
> ordering, once the concept is clear.
>
> Thanks,
> -Stolee

Thanks,
Taylor
