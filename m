Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD462C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DDE2080D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392538AbhALQ2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbhALQ2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:28:42 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F947C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:28:02 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id c7so2358243qke.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/gy1fyzTLg8l5srVd7edWvyFVunEH9UJ70Nny14pgHM=;
        b=xpQWvWGdCJ6KWRApyDF9HqWzZAVmvIlJ4QuAu/5mwdyeCRPA8LbnczVK+o8eOsIun2
         g8ZHv6H6H5YAlvrSJZNw8Y8uJO3WA857phOgTl+pY2pkk7YIVUVd1sU7pBFXCXV6sAjj
         dH8v/lLM7jyeQj6Qlpt+ZUrlVYsRk1bmZzQ8pLpa2TFvo9tUIbW5F5s4fVOPa3czeJ8N
         9yehDJ24rqrGT+O6bPOTQ88FU7evs3lfoyNKcnZG7K5pD0BbyEiG7rTm8wu9wUJRzGEA
         HO+CBiRGb3MLuTd4EJXnTHVNvaP89hdZzLCr8FoNuVtn94klMVtpNeGlQFuGXu4pN3Sw
         h8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/gy1fyzTLg8l5srVd7edWvyFVunEH9UJ70Nny14pgHM=;
        b=ZPtewSNKRu+nBgdm12I8kZUl9rjFrluadwK/HZq9afhTQ8ZwBo9vgdoXQYX/VJPL6Y
         2lSW87FfEcqw/Fs//LCGsZEDb6ob3VpE+t3AtUC1RBpa0UAsB9T73VT+LTi6X5ny+fud
         A+ZG7+hST5OLZWzHshLSwb/Bq5AT52bbzBVq/10I20HLY7WVxPwdpvv+nHi713VaEqHH
         T+1yQxmdjbBE9w8c9UWIq/JDz0GF2bgdrRXUUZzcyojsVJ3KFSWyFMMXRpkW8JbZeWoS
         X1u9m+VJT2J2BN8Ia+PFRJHDa9Ud7I4UOlVdfRxIpothkT1W9sx5BK6mH1c7RepufwwC
         0A4Q==
X-Gm-Message-State: AOAM530kzlq9XCV9hAgawdLrywfWRX1h2FkHCVzJV2U+QXdRirwfS2vG
        0Crstwmm00spU4o2mxgr0Mu+E2xAiZiIHw==
X-Google-Smtp-Source: ABdhPJwHsdx0XuZ+4VzRAwmDPlTu32Aj8AJ1Nkn1sLfEC9GysTJD5pFolXNFCUItJ41HWMUhSoOwAg==
X-Received: by 2002:a05:620a:227:: with SMTP id u7mr113479qkm.256.1610468881692;
        Tue, 12 Jan 2021 08:28:01 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id p75sm1498742qka.72.2021.01.12.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:28:01 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:27:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 01/20] pack-revindex: introduce a new API
Message-ID: <X/3ODgaa9wr65M09@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
 <X/1guCOGWybOzIS7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1guCOGWybOzIS7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:41:28AM -0500, Jeff King wrote:
> > There are four ways to interact with the reverse index. Accordingly,
> > four functions will be exported from 'pack-revindex.h' by the time that
> > the existing API is removed. A caller may:
>
> This tells us what the new API functions do. That's useful, but should
> it be in the header file itself, documenting each function?

Mm, that's a good idea. I took your suggestion for a comment at the top
of pack-revindex.h directly, and then added some of my own commentary
above each function. I avoided documenting the functions we're about to
remove for obvious reasons.

I think that the commit message is OK as-is, since it provides more of a
rationale of what operations need to exist, rather than the specifics of
each implementation.

We'll have to update these again when the on-disk format exists (i.e.,
because all of the runtimes become constant with the exception of going
to the index), but that's a topic for another series.

> > +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
>
> The types here make sense. off_t is clearly needed for a pack offset,
> and uint32_t is correct for the position fields, because packs have a
> 4-byte object count.
>
> Separating the error return from the out-parameter makes the interface
> slightly more awkward, but is needed to use the properly-sized types.
> Makes sense.

Yep, exactly.

> > +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> > +{
> > +	int ret;
> > +
> > +	if (load_pack_revindex(p) < 0)
> > +		return -1;
>
> This one lazy-loads the revindex for us, which seems handy...
>
> > +uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
> > +{
> > +	if (!p->revindex)
> > +		BUG("pack_pos_to_index: reverse index not yet loaded");
> > +	if (pos >= p->num_objects)
> > +		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
> > +	return p->revindex[pos].nr;
> > +}
>
> But these ones don't. I'm glad we at least catch it with a BUG(), but it
> makes the API a little funny. Returning an error here would require a
> similarly awkward out-parameter, I guess.

It is awkward, but (as you note downthread) the callers of
pack_pos_to_index() make it difficult to do so, so I didn't pursue it
here.

> -Peff

Thanks,
Taylor
