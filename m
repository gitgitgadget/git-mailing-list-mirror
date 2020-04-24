Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6235C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1122075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Wa9dfz7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDXQyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQyi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 12:54:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26108C09B046
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 09:54:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g2so3947582plo.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RmYWV7OjoT/bNWrPKkhTvPJSLNj/cBQBTOEuvDco+XU=;
        b=Wa9dfz7QIqZFJfNOIkR+6v7lxbe/sgaa/7gdijbCcyZEOpl1o2avd706AM7gpSFYp7
         5JSfCkMBCrDi8becYDPvJQq6XBOfQ/9EwZGMa+TVN6dtaRdqv0Q4TOZSroC8TT/lXOzx
         x7hnTgp9eH1vrdV4EW8LDXS5QSwm429eFiiLFxqJDooY4rECeXSsQrRhftvoOx5ReDTM
         8Ep4BDrtl2lZe59jmpvoyOsJWrBB44JEdes3bQ1sdmWE5iJ+dgREehnGHD3qi9pzr+/2
         fa8ION+JVbdWvpbC7tEg0PQadC++x0PaxpzwuY9bgSk4ZtS9uUcjN+TieMWdHjpZOdxW
         ISyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RmYWV7OjoT/bNWrPKkhTvPJSLNj/cBQBTOEuvDco+XU=;
        b=gPdGhYMgKHjDN0kzJxIEMdc2yl+Z4L279p4bpmM+ro+TbKRcH9w9ZyBuyfVNl9ClJ+
         azlb9vZ7iiX4SnRbzgo438WQAyjmyt8FyfVrdO7KpjjAtq8RNhbFFDKONl+l2+rc+Dc6
         aAuvHQSctQ2GfxdbbounyRbcqBdBa3ewVacKFeO/PLLz2a2xDw9iFAvAcX08ZbMlnuVz
         gZ4yM+rR8CP/rgXUFpflBYe6GXD3Jyp67CqvQqgWFKh+fqckZTwNGVLYmFzFsXOqwFpG
         WY9F+r+myl+UeI3xHuFN5sBKc61wNNSsi7jq4fRLvL0mgjXCSgo1/syEPNfQSpjLIboa
         n21A==
X-Gm-Message-State: AGi0PuaJe5b8aypBkvOSYAVKPoik4p8FAAuhr/HUrPFUW4QA5YB3GVm3
        xUAqrr8SR8Lh+zHThOl+CxMjYg==
X-Google-Smtp-Source: APiQypL4g1WwHQiWCo14yGvvE2clSQm1tDeDr4Vvki/HZ+EwzqWKkR5WaC3cAMdg/VjMxPDwpu0WwA==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr8435212ply.262.1587747277563;
        Fri, 24 Apr 2020 09:54:37 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r17sm4238366pgn.35.2020.04.24.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:54:36 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:54:35 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 4/4] pack-bitmap: pass object filter to fill-in traversal
Message-ID: <20200424165435.GB58621@syl.local>
References: <cover.1587597151.git.me@ttaylorr.com>
 <65467a058e7dca6cf1e2db9cdab81513989b5db0.1587597151.git.me@ttaylorr.com>
 <20200424054227.GE1648190@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424054227.GE1648190@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 01:42:27AM -0400, Jeff King wrote:
> On Wed, Apr 22, 2020 at 05:13:35PM -0600, Taylor Blau wrote:
>
> > From: Jeff King <peff@peff.net>
> >
> > Sometimes a bitmap traversal still has to walk some commits manually,
> > because those commits aren't included in the bitmap packfile (e.g., due
> > to a push or commit since the last full repack). If we're given an
> > object filter, we don't pass it down to this traversal. It's not
> > necessary for correctness because the bitmap code has its own filters to
> > post-process the bitmap result (which it must, to filter out the objects
> > that _are_ mentioned in the bitmapped packfile).
> >
> > And with blob filters, there was no performance reason to pass along
> > those filters, either. The fill-in traversal could omit them from the
> > result, but it wouldn't save us any time to do so, since we'd still have
> > to walk each tree entry to see if it's a blob or not.
> >
> > But now that we support tree filters, there's opportunity for savings. A
> > tree:depth=0 filter means we can avoid accessing trees entirely, since
> > we know we won't them (or any of the subtrees or blobs they point to).
>
> s/won't them/won't include them/ perhaps

Oops. Even though you wrote this patch, I clearly also should have
proofread it more carefully before sending it to the list ;).

Junio -- assuming that you are comfortable taking this series as-is (and
please let me know if you are not), would you mind fixing up this typo
as you apply it?

> > diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
> > index b629a211f9..95379b1d4e 100755
> > --- a/t/perf/p5310-pack-bitmaps.sh
> > +++ b/t/perf/p5310-pack-bitmaps.sh
> > @@ -95,4 +95,9 @@ test_perf 'pack to file (partial bitmap)' '
> >  	git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
> >  '
> >
> > +test_perf 'rev-list with tree filter (partial bitmap)' '
> > +	git rev-list --use-bitmap-index --count --objects --all \
> > +		--filter=tree:0 >/dev/null
> > +'
>
> This covers perf testing of this partial-bitmap state, but we shoudl
> make sure that we are covering correctness, too. I think so, because
> t6113 creates a similar state for all of its tests.

Yeah, we are covered there. The last three tests in t6613 cover
'--filter=tree:0', bot with and without specified objects (to make sure
that named objects don't get culled out by the filter), as well as the
'--filter=tree:1', to make sure that we didn't break that.

> -Peff

Thanks,
Taylor
