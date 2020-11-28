Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FA3C83016
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D549221FD
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MgO4jXbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbgK1Vtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgK1SAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 13:00:38 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B5C025454
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 09:21:23 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so6832335pge.6
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 09:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=55u2F0HchmxC+QFbRcSPLvqqlU+E6P+hA+aVX9Zx6HA=;
        b=MgO4jXbZXYCvJ37l9JEQ/UT+bVYGhIAeFjx9jeFjxxRAthXy2Hp45FS6Q2p/dwCSqK
         3iDsoteTmxacKQ7+VpAJs1R3+UDwFGTI4OJPc5L2LWJ7TJL2hW6wH3HltlcpKG+ine8l
         6KRYudA/xBDVhHuPJZDpm9IuEKTsGLA38fEr+C0XXU5TyLhOmcjU8Ap8CRkLBVxtb1xm
         1GkVpvnTrw6dO6Z7yA67yewqkrOFlUxKjsQFiQqCfgftnjHwxQRGgEVTo5v/vmS00h19
         jS3652kU0mYvXeYy/COsYwaccPi7l/8RzsAin8zIInKE3875LUPhudeSiamxQpZn6XHb
         NkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55u2F0HchmxC+QFbRcSPLvqqlU+E6P+hA+aVX9Zx6HA=;
        b=Q7PfOJTlvIfil5c2PPQxZi+e/pRkEzxhuf2UYp1Bu82M4NSoA96ovXv00h+2cvrF0o
         2NVk0v1A8BnnI2Oy2QUY1uqUmuuOfioWofMRdUpKMMV357tFtT8+cX+rhMvcQzTV6mvC
         u1eSODIabCU/ZllmLU8RRU5CxDjdUtRMfC3HRd7diye/wxMn1Q0EmFPBBHjc3mHgRz6Q
         mQfqtmSKOEpHFeNobmL8olec7nBHFFFsTYwv8+MnDOIXiEVCjj9h52J1vNE0OxKdMYmR
         hqo5xslLPanNy1Z+B2isjjTpz0ow8A051c/YDpgUOw5xwOcyHFMj8spVdRjC/keZeWmz
         yu+Q==
X-Gm-Message-State: AOAM533Blik+Cfn3acFS7Fy9ABPUp+k1zSpkFvDXcYv8sltQ04WeGLeV
        eVMnPGqoZQMwXfWmiNsJsIBgwQ==
X-Google-Smtp-Source: ABdhPJz5JwUAhY9A5Fdd030OPFPXQlNFcHEtjZthAzNMigyuDB9lVRijDUPIrtzVlETNAIEpQMMVMg==
X-Received: by 2002:a62:8f03:0:b029:18c:968a:4cf9 with SMTP id n3-20020a628f030000b029018c968a4cf9mr11815687pfd.59.1606584082728;
        Sat, 28 Nov 2020 09:21:22 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id nk11sm10641497pjb.26.2020.11.28.09.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 09:21:21 -0800 (PST)
Date:   Sat, 28 Nov 2020 12:21:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, dstolee@microsoft.com,
        gitster@pobox.com, peff@peff.net, martin.agren@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 12/24] pack-bitmap-write: fill bitmap with commit
 history
Message-ID: <X8KHEMl87sU5cIGK@nand.local>
References: <8e5607929d66a3c808dbe3a06c312d0cda1ef568.1605649533.git.me@ttaylorr.com>
 <20201125011409.941639-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125011409.941639-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 05:14:09PM -0800, Jonathan Tan wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > The fill_bitmap_commit() method assumes that every parent of the given
> > commit is already part of the current bitmap. Instead of making that
> > assumption, let's walk parents until we reach commits already part of
> > the bitmap. Set the value for that parent immediately after querying to
> > save time doing double calls to find_object_pos() and to avoid inserting
> > the parent into the queue multiple times.
>
> I see from the later patches that this has no effect until the part
> where we can skip commits, but as Junio says [1], it's worth mentioning
> it here. Maybe something like:
>
>   The fill_bitmap_commit() method assumes that every parent of the given
>   commit is already part of the current bitmap. This is currently
>   correct, but a subsequent patch will change the nature of the edges of
>   the graph from parent-child to ancestor-descendant. In preparation for
>   that, let's walk parents...

Thanks. Stolee and I worked a little on revising this last week, and I
think that the current log message is more along these lines. Here's
what we wrote:

    pack-bitmap-write: fill bitmap with commit history

    The current implementation of bitmap_writer_build() creates a
    reachability bitmap for every walked commit. After computing a bitmap
    for a commit, those bits are pushed to an in-progress bitmap for its
    children.

    fill_bitmap_commit() assumes the bits corresponding to objects
    reachable from the parents of a commit are already set. This means that
    when visiting a new commit, we only have to walk the objects reachable
    between it and any of its parents.

    A future change to bitmap_writer_build() will relax this condition so
    not all parents have their reachable objects set in the in-progress
    bitmap. Prepare for that by having 'fill_bitmap_commit()' walk
    parents until reaching commits whose bits are already set. Then, walk
    the trees for these commits as well.

    This has no functional change with the current implementation of
    bitmap_writer_build().

> >  static void fill_bitmap_commit(struct bb_commit *ent,
> > -			       struct commit *commit)
> > +			       struct commit *commit,
> > +			       struct prio_queue *queue)
>
> As far as I can see, this function expects an empty queue and always
> ends with the queue empty, and the only reason why we don't instantiate
> a new queue every time is so that we can save on the internal array
> allocation/deallocation. Maybe add a comment to that effect.

Sure. Would you find a comment like that more helpful above
'fill_bitmap_commit()', or above the declaration of 'queue' (in
'bitmap_writer_build()') itself?

Thanks,
Taylor
