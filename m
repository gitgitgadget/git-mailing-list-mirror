Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDE7C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858EE60F57
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhG0Rrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhG0Rrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:47:42 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04490C061760
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:47:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r5so45509ilc.13
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Q3aiV2iBhbuY+OZenEpxTPrOkFnaZM9I+hbdLBbeIo=;
        b=m56x0c7+kvZbb90lU77CKtIMwmphd5jsCW094Dl5vU747qOJpCASNNAEbUfXILCPAG
         eGIp/QiOwdvVXserOexMUuAoM8s9pmLxdYvXMyubTuKcSjqvwje7BIO+8wEtVFoTj7sh
         n8DmcgA0YSYQFoT4VTfkDaBG69jH6IOc9lHMLxynj8MhoGsIKEOVj9U7Lm/K7tpmZlGr
         CKOfZVgL7/IPaHDGlG+oq/JGjcWpII9ULBxd9qsbPA4dnne1Pf6upFyho+SZtn1oDbKy
         9hTdkrkk5Dkm+UAy2nrbntcn3HrglPxqlznPsgSIAXxQyOd4espoUOiCQmHw/mtWiCuO
         TsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Q3aiV2iBhbuY+OZenEpxTPrOkFnaZM9I+hbdLBbeIo=;
        b=N1anvNIvzMBzmyIPsf2gCN6nFnuRaP4HzTt6pFgYswjCmCrJQdih6lK25BiXR6puay
         Nwxsc9YTpsQSFaBpK4CVR+2jLRat9cut0vfsUndCNIfUsw3UJX48tSir3k7WgQmP4074
         drg55+DmUJ8ySi91aYSiy+cpDEss+YYfMhH2Zq4+LSqIpGyg7wSDtsu/BqTtRBsjOJIE
         t//Z5kwaFV2ZW4yi9OZQ9zG6K+uMU3GshJ/ofqiAH7jf7shfLYVi2pPsa4UYMCzvWYyL
         bo8GrOCmzWBrnhwxg71mapSRexd/WkK1CzdVFHyO+4oiwLcfymlvyehwABwB9EOPvXp6
         7BqA==
X-Gm-Message-State: AOAM532PHayJgF8nIfGVTVpX5PTqkDvRJePCWTS2+Y0KzcvJ+9gy/PZS
        O1xLvYBQi1+kxg5P59GrwJw/Vw==
X-Google-Smtp-Source: ABdhPJywYQ3jGo5X5y7wmwF/0xZVbuASMCKKbKp5N9eDgJe0ct8nNy4IcT6tnnhrqNzfTFeCZdUQhw==
X-Received: by 2002:a05:6e02:1b03:: with SMTP id i3mr17495035ilv.160.1627408061394;
        Tue, 27 Jul 2021 10:47:41 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id x10sm2008978ill.26.2021.07.27.10.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:47:41 -0700 (PDT)
Date:   Tue, 27 Jul 2021 13:47:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQBGvEQoZpw49Z7L@nand.local>
References: <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
 <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
 <YQBEIrRfcq5dhpZn@nand.local>
 <YQBFi70c1wfXdKQf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQBFi70c1wfXdKQf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 01:42:35PM -0400, Jeff King wrote:
> On Tue, Jul 27, 2021 at 01:36:34PM -0400, Taylor Blau wrote:
>
> > > But now the internal midx writing code can never call close_midx() on
> > > that, because it does not own it to close. Can we simply drop the
> > > close_midx() call there?
> > >
> > > This would all make much more sense to me if write_midx_internal()
> > > simply took a conceptually read-only midx as a parameter, and the caller
> > > passed in the appropriate one (probably even using
> > > prepare_multi_pack_index_one() to get it).
> >
> > No, we can't drop the close_midx() call there because we must close the
> > MIDX file on Windows before moving a new one into place. My feeling is
> > we should always be working on the r->objects->multi_pack_index pointer,
> > and calling close_object_store() there instead of close_midx().
> >
> > Does that seem like a reasonable approach to you?
>
> Yes, though I'd have said that it is the responsibility of the caller
> (who knows we are operating with r->objects->multi_pack_index) to do
> that closing. But maybe it's not possible if the rename-into-place
> happens at too low a level.

Right; write_midx_internal() needs to access the MIDX right up until the
point that we write the new one into place, so the only place to close
it is in write_midx_internal().

> BTW, yet another weirdness: close_object_store() will call close_midx()
> on the outermost midx struct, ignoring o->multi_pack_index->next
> entirely. So that's a leak, but also means we may not be closing the
> midx we're interested in (since write_midx_internal() takes an
> object-dir parameter, and we could be pointing to some other
> object-dir's midx).

Yuck, this is a mess. I'm tempted to say that we should be closing the
MIDX that we're operating on inside of write_midx_internal() so we can
write, but then declaring the whole object store to be bunk and calling
close_object_store() before leaving the function. Of course, one of
those steps should be closing the inner-most MIDX before closing the
next one and so on.

> -Peff

Thanks,
Taylor
