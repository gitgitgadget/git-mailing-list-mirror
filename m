Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9348C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 22:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbhLJWfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 17:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbhLJWfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 17:35:05 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051AC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 14:31:29 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p23so12027048iod.7
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9DMpbkycrJODvb0whnnDK3a5Gm6o3hzWLyPxdMDKvSA=;
        b=SPKJ70wlyFgviL2wZhrmdk+E3kqqj/vznod9QO1i7hk/c4bcFVqowGqOGuyj8DQVRB
         uYZ1KPYgJKC3agZr4BFa4IIY6+8t9XI4PzCPTojXKiQ5UF/y/lIFDyksa9wv65nMsGkH
         mttDOuXmyZqX8pi3dIIpSvJwE7N4iVvCNYbsS3Cfv+W7seO71m1J0MkOtgrfLoEqfXEV
         X1jvU761jxx9TlgiZxDRa4WVSgOxtU/EO2kEolASNFuWM5lPkyMz8Cn3fT0TC25LBZ3Y
         7owE/rVT62OxD/OQOXeOHB/lZzTXjFAQiD3yMoXM96CUDtvkuP/GQmeGNjwslg3sv5Kz
         nUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9DMpbkycrJODvb0whnnDK3a5Gm6o3hzWLyPxdMDKvSA=;
        b=kloGWR866qxx21oAIdgUR1frMVjNS5Yskyvbj5/CFevUiTTh4lmScBKeNAoC+CHTke
         Rl7oJrifirWzRWJRKfi2DNIzVAo+Mk264Qe5YVT6xcCvaV7Deyqi0qlKFI2dWAcGXuy1
         hWclfAD0FSrEPeE+/oQoJJTkhs6Z+Qsl+/pXLeg/hYFxy2M45e7K+1T2k+s2+ySMcupb
         IRJC1rNaShky4eU9N/zjd+SwDnhCCQCh5Kmu9VI+DfJ7uRWxwoGGfQw9yigbHrvFmFnv
         fd7VspNtnE3b9xCvma4I7VUbi2KjdfAALa88xGHyfzJtvZA4utHQ5zgQsUa/eOMsoWyA
         C/yQ==
X-Gm-Message-State: AOAM533Ill6rHVtnATfIMq270DxIue5F2/1HxAVgQrjzTkda4zy8frAi
        g5T3t8AIqSP0Atc/X2Yzt05PXA==
X-Google-Smtp-Source: ABdhPJxBy4Ki4koNDM6AG4ilfpo8lEokZYHyiryAuxLoucRQ+H6Qo9TK9EV6XKbSZ/vCVtW9T/SWBA==
X-Received: by 2002:a05:6602:490:: with SMTP id y16mr23699406iov.162.1639175488942;
        Fri, 10 Dec 2021 14:31:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w2sm3474349ilv.31.2021.12.10.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:31:28 -0800 (PST)
Date:   Fri, 10 Dec 2021 17:31:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/2] midx: prevent bitmap corruption when permuting pack
 order
Message-ID: <YbPVP0BvYcVsfOrf@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <bf100d0c-66c7-d402-4790-9c5797e8baf3@gmail.com>
 <YbENofRtY0BPMEUd@coredump.intra.peff.net>
 <YbOeEjNic5ETGcdy@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbOeEjNic5ETGcdy@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 01:36:02PM -0500, Taylor Blau wrote:
> On Wed, Dec 08, 2021 at 02:55:13PM -0500, Jeff King wrote:
> > On Wed, Dec 08, 2021 at 02:30:17PM -0500, Derrick Stolee wrote:
> >
> > > > Taylor Blau (2):
> > > >   t5326: demonstrate bitmap corruption after permutation
> > > >   midx.c: make changing the preferred pack safe
> > >
> > > Just chiming in to say that I reviewed an earlier version of this series
> > > and the version in this submission looks good to me.
> >
> > Ditto. ;)
>
> All three of us missed that this PORD chunk actually contains the
> psuedo-pack position for every object in the MIDX. That is OK, but it's
> definitely adding more than 4 bytes per pack to the MIDX (in practice,
> it's adding 4 bytes per object).
>
> I'm semi-OK with this direction, since it's tantamount to storing the
> .rev file's contents in the MIDX itself. And even though we're not
> reading from it, it is doing the thing we need it to which is causing
> the MIDX to change its checksum when the object order changes.
>
> But I'm curious what both of your thoughts are before moving forward.

To just add a little bit more detail before I mostly close my computer
for the weekend:

The key part of this bug is that the MIDX checksum could remain
unchanged even when the object order used to write the MIDX bitmap does,
and that's what the first patch here is demonstrating.

Having PORD contain the same data as the .rev file still accomplishes
our original goal of preventing this bug, because it forces the checksum
to change when the object order does. But it's definitely more invasive
than I had imagined.

I had originally imagined that storing the preferred pack's identity
alone would be enough to solve this bug. But that isn't quite so,
because we break ties among duplicate objects first by prefered-ness,
then by their pack's mtime. So that could change too, and it would cause
us to break in the same way.

At the bare minimum you need an ordering of all of the packs in the
MIDX (like I had originally imagined here). At most, we could do
something like what is unintentionally written here, which would allow
us to get rid of MIDX .rev files entirely. I think doing the former is
simpler, and I am not sure if there are practical advantages to the
latter.

But I'm definitely curious as to what others think would be a good
direction to pursue.

Thanks,
Taylor
