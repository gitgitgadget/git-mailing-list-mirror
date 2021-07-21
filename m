Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89033C636C9
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B0061244
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhGUQkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhGUQkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:40:12 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA6C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:20:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z9so3178302iob.8
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WRqhU2InkBr2qGTuy2v4Yg33FZsFz7wY/gKiLlDY26U=;
        b=d6J+S+LQm2c2vKS/Ns+2JP6SusIBeoMNXp0fVBPq0v0UQa+jahTwxrewdIEDrrV3Iq
         63Pvg3+dWv9jT4haWXwKerKApcnvoplRnV2AtROFmsIuL3puOGE+v5xeCnUVUQIneu9M
         HkiYD4sObHtdqf875qEMOronbmDfiwsOeUSQnEiOuBJBQzUa92vKG9S7dz5hXgI8On3e
         3H97bTIkiBW2raiSGZFl6FKD8n6u7AR55SCxxjoeUqMUViqZcaGp/k6Pg0quR4GT+ipj
         At+xCawITj3UeMkmv3rwekNYAe5vo07rpQoh0sQEetsnBbjdJDgjlA+wRNKGFkQly0Fq
         J/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WRqhU2InkBr2qGTuy2v4Yg33FZsFz7wY/gKiLlDY26U=;
        b=glKDh/8pqLdqbejseu82+fBvUEWhAGLhagtN9IvB0tLLtpNp0NYPFQw3SNb+7iOoPd
         A6Nvh71k+Wx8Omjig80uMMDfVUKU7v4LKB8oLXihUz20ZGOOITJfu9V9meCQobzhaczk
         SwKZXDCw9nF9TytCG9Bjz/e10KrWAUtAikpUMoodDn7iEHViSPf32E+2ap0ywJFy8DEH
         UCKob+0xa7EpqPPtLP9sV1rPaz0y9nXRarLXnkOdRwGfUKItyaoZYmBo+ZSxCkbLtJDm
         k0LBdfwNnpq7iEjXbWDF9TMTQwv20p4A9mrFD7j1lIiUldot+COB115shJPBkukOCIzQ
         hTRw==
X-Gm-Message-State: AOAM5303KmAlQjUrNnoZ9yu1D+l4wigzloW3YZwfNat7N62DRcJx6wxJ
        SO2Q+oAd6SJCWH2glqg3G7RWiA==
X-Google-Smtp-Source: ABdhPJyx46oIm4K75koPs7SL2QFSCbZhNg+NFE2LtfaBQgk7gNGvFV1zeTznCywivYGBSQX2IVEcog==
X-Received: by 2002:a6b:b883:: with SMTP id i125mr28016965iof.104.1626888048265;
        Wed, 21 Jul 2021 10:20:48 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id z6sm13543703ilz.54.2021.07.21.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:20:47 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:20:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <YPhXb9Zns8S6aIod@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
 <YPft87yCjR9e+93E@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPft87yCjR9e+93E@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 05:50:43AM -0400, Jeff King wrote:
> The amount of error-plumbing you had to do is a little unpleasant, but I
> think is unavoidable. The only non-obvious part was this hunk:

Agreed, at least on the amount of plumbing required to get this to work
;).

> > @@ -463,8 +488,11 @@ void bitmap_writer_build(struct packing_data *to_pack)
> >  		struct commit *child;
> >  		int reused = 0;
> >
> > -		fill_bitmap_commit(ent, commit, &queue, &tree_queue,
> > -				   old_bitmap, mapping);
> > +		if (fill_bitmap_commit(ent, commit, &queue, &tree_queue,
> > +				       old_bitmap, mapping) < 0) {
> > +			closed = 0;
> > +			break;
> > +		}
> >
> >  		if (ent->selected) {
> >  			store_selected(ent, commit);
>
> This is the right thing to do because we still want to free memory, stop
> progress, etc. I gave a look over what will run after breaking out of
> the loop, and compute_xor_offsets(), which you already handled, is the
> only thing we'd want to avoid running. Good.

Right. The key is that we return "closed ? 0 : -1" (of course, being
careful to invert "closed" where "1" OK into a suitable return value for
bitmap_writer_build, where "0" means OK, and a negative number means
"error").

While I'm thinking about that inversion, we *could* call this variable
"open" and set it to "0" until proven otherwise. Then the conditional
becomes "if (!open)", but the return value is still "return open ? -1 :
0" (since I assume we'd want to use 0/1 values for "open" instead of -1,
meaning we'd have to do some translation).

Anyway, this is definitely an annoying detail that doesn't really
matter (and just rambling on my part) ;).

Thanks,
Taylor
