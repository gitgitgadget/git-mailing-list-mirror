Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63770C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249BF2073B
	for <git@archiver.kernel.org>; Tue,  5 May 2020 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="X+6481Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgEEP7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgEEP7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 11:59:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9AAC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 08:59:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ms17so1306182pjb.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KtrfyjQGL+tSTUlR+p3iou+HOsMNlrkIVs13tEkHCXU=;
        b=X+6481GcTxB29biZ56bkGEei/d7q9kP58VeVpiLBFnduNkR+dQTRoqjYhAW+8yde8s
         b12y/4DcRKO3vWBiFCMa61Ok2Y2ulgpdX4aleaJ8454CrjjDpOD9KvZEVKyW+eZxQ2s/
         wDOJUUC9KnGqJfSoIu0e89kLE6xNJFmQLLO4qvPN/PzQ6dhQ/zXcuk7/145sQtb0tZU5
         +uLVo/73lqpu8BM4cbVMwoIP6C2ASK2/EgqCFGr+hrqe9NsMHzq2416EonAzF1mn0QdR
         U3Q349iWh1rRyb7TSxfKQgA6Q7i63RIs/LKfACuyVp+us3GhsUduP4GzBQAJzWtrvO+E
         2SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtrfyjQGL+tSTUlR+p3iou+HOsMNlrkIVs13tEkHCXU=;
        b=VNxQLJI/YKMcU1gyXVEV/k8W7G2ntfdkdbflTMFlKYlNdRMREJH96tHEV7ddfVDJOU
         gsl/RJc9JZ9rjmn0Vi4cnacs008uQsGtr7Ev1puk9dWS8Fnfn5Wr1WMUYicNwZv9BwEW
         Q2hrN0ebUD7vt4D32NyPRysOFlBCqJDgfEtcQTUw0YD0KMP3p+I+81wv9i6wlfMm+wUe
         H9eymuX4XPmmMLz383Q4nyol/26mkxmlH0gk6jPWbv/cdNq4nXMsXf3IQ4qTZnIJH/+E
         grqCHzRJk+ro3+GPfLpdZzWeLJkUAoDXqB/tK8KtNv2TW02o3PE5s0qLJmF3l/qNJL+Q
         MBVw==
X-Gm-Message-State: AGi0PuZVWDUqJkzeACbgISazAMlR7EplokoGj5uGr6T2hYbVEUBKzmUa
        37wuMppVjOAgU3nfQ9KtKjemSA==
X-Google-Smtp-Source: APiQypLAAQFLVgOF/d04kuHzLxmb8G3g4MYIZQzMvWnlWaPAxnfIS2E2VkUtz3oHE+t31aIOcEtBNw==
X-Received: by 2002:a17:90a:8994:: with SMTP id v20mr4122274pjn.76.1588694393987;
        Tue, 05 May 2020 08:59:53 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x185sm2411812pfx.155.2020.05.05.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:59:53 -0700 (PDT)
Date:   Tue, 5 May 2020 09:59:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 3/4] pack-bitmap.c: support 'tree:0' filtering
Message-ID: <20200505155951.GA69300@syl.local>
References: <cover.1588633810.git.me@ttaylorr.com>
 <87b21d72bb588f7366d928544aeaf4de68b027a7.1588633810.git.me@ttaylorr.com>
 <xmqq7dxrc5r9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dxrc5r9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 10:25:46PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 3693c9e62f..195ee8cad0 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -749,7 +749,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
> >  	eword_t mask;
> >  	uint32_t i;
> >
> > -	if (type != OBJ_BLOB)
> > +	if (type != OBJ_BLOB && type != OBJ_TREE)
> >  		BUG("filter_bitmap_exclude_type: unsupported type '%d'", type);
>
> OK.  This is the same as the previous step, but why would we even
> need this guard?  find_tip_objects() is equipped to find tips of any
> object type, iterating on the bitmap for "type", or flipping the
> bits in the to_filter bitmap, does not have any limitation to the
> blob type in the previous step, and there is no limitation to the
> blob or tree types after this step, either, no?

I think we need some sort of guard here, since we could receive any
value of object_type, but you're right that this isn't the right one. It
should probably be something like:

  if (type < OBJ_COMMIT || type > OBJ_TAG)

to pick out the sentinel values like OBJ_BAD and OBJ_NONE, as well as
the pack-specific types, like OBJ_OFS_DELTA and so on.

I fixed this locally, and will resend it along with the rest of v2 in a
day or so. Thanks for a review :).

> > @@ -867,6 +867,20 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
> >  	bitmap_free(tips);
> >  }
> >
> > +static void filter_bitmap_tree_depth(struct bitmap_index *bitmap_git,
> > +				     struct object_list *tip_objects,
> > +				     struct bitmap *to_filter,
> > +				     unsigned long limit)
> > +{
> > +	if (limit)
> > +		BUG("filter_bitmap_tree_depth given non-zero limit");
>
> This one does make sense, because the code to exclude all trees and
> all blobs we have below won't be able to cull only trees at a given
> depth or deeper.
>
> > +	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
> > +				   OBJ_TREE);
> > +	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
> > +				   OBJ_BLOB);
>
> And these two are quite straight-forward.
>
> > +}
> > +
> >  static int filter_bitmap(struct bitmap_index *bitmap_git,
> >  			 struct object_list *tip_objects,
> >  			 struct bitmap *to_filter,
> > @@ -890,6 +904,15 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
> >  		return 0;
> >  	}
> >
> > +	if (filter->choice == LOFC_TREE_DEPTH &&
> > +	    filter->tree_exclude_depth == 0) {
> > +		if (bitmap_git)
> > +			filter_bitmap_tree_depth(bitmap_git, tip_objects,
> > +						 to_filter,
> > +						 filter->tree_exclude_depth);
>
> I briefly wondered if it is cleaner to read if we hardcode 0 as the
> last argument.  But if the helper function ever learns how to filter
> by tree with non-zero depth, we can only tweak the if() condition
> without changing the call, so the way you wrote it is the right way.
>
> Thanks.

Thanks,
Taylor
