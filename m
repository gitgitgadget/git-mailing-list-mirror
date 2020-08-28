Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F0C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143BB2075B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="FiZmAuNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgH1S4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgH1S4E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 14:56:04 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34EC06121B
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 11:56:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so281689qtn.7
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KaW9/U9Q8vPE+Xn4NrRGso7IhlTMU2xIcGylXG/vCF8=;
        b=FiZmAuNkR4lfSI7WBfgFdhwiIs9UQsLyAjJbYPJHayxVTG/eYyCMINIPwbguZHA++B
         LyQo2APaKPmVC+jzWoF6hE66icArA7sjA6uneTbCXYLd4LiydfEyQl0BEAt+++qLQVbs
         MWZW3PB4IwnpM1KYEYW1NZWlI8iVOy+RbxFwS2b8zxuSpQt9I3to60Y/WLw7V710N7yK
         iD67KjMVZhlyQiFlhtQhJRoufs26RYAP3AByEvNKuKDlMLkNRtTOpe7eh8v3eJKWvsEi
         oqff1WrKDPe2IxBMDXrG2g9b391AblFEHQffQeH0KGQ5dVJ7tBETKfiGD3nALjBjkWFu
         B0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KaW9/U9Q8vPE+Xn4NrRGso7IhlTMU2xIcGylXG/vCF8=;
        b=s+jIh4fPoXOPTqPean+qxmKo+7QCo0xRntmPuxRliibGhnFjHXG7FRrvu8TC7SFj7i
         DAXPe/vS8ZLIBUMpBpsX+WoQi768+7G07VZM9vdedqZZPfMKNKvhtK3MS4X9Mt2QziTP
         TCZzIWjOOzgBeT8DP+6T/06hgnysdfYwTbtgIYoXrsRxN70h3COS3cUHwuqXvm1GcQHS
         pkMk8izg9mtSWIVQTDv9WwBGy6Mh6lzSEJxhDzT3i+br+1QU3ZgMciziKUcFMPUBMKGF
         j6lyEpIl5wGngCqKF0MvwxnO9Q51khy128KTpG3dFAL/JOLheUiLZ+31xW7g87EBK6IJ
         MygQ==
X-Gm-Message-State: AOAM530j4o01z9OMtrBPkLJTa1Ha9jbnckKqKA6V+CNGDpV/mHpqzZnJ
        rt9mgEmggc5b64SX6RYkXi2tDQ==
X-Google-Smtp-Source: ABdhPJy/r0YhjivITVjyOyCIVSJJGffCja72a38MM94nkfXeMhfW0QUK+0PSHS4K+Vl7lLORKv/cLg==
X-Received: by 2002:ac8:5685:: with SMTP id h5mr2846063qta.119.1598640961689;
        Fri, 28 Aug 2020 11:56:01 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f08e:2c2d:3ae3:2fac])
        by smtp.gmail.com with ESMTPSA id d202sm2490qke.38.2020.08.28.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 11:56:01 -0700 (PDT)
Date:   Fri, 28 Aug 2020 14:55:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] midx: traverse the local MIDX first
Message-ID: <20200828185557.GC19328@nand.nand.local>
References: <20200828180621.GA9036@nand.nand.local>
 <20200828185039.GA2171353@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828185039.GA2171353@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 02:50:39PM -0400, Jeff King wrote:
> On Fri, Aug 28, 2020 at 02:06:21PM -0400, Taylor Blau wrote:
> [ snip ]
>
> > This patch bandaids that situation by trying to place the local MIDX
> > first in the chain when calling 'prepare_multi_pack_index_one()'.
> > Specifically, it always inserts all MIDXs loads subsequent to the local
> > one as the head of the tail of the MIDX chain. This makes it so that we
> > don't have a quadratic insertion while still keeping the local MIDX at
> > the front of the list. Likewise, it avoids an 'O(m*n)' lookup in
> > 'remove_redundant_pack()' where 'm' is the number of redundant packs and
> > 'n' is the number of alternates.
> >
> > Protect 'remove_redundant_pack()' against a case where alternates with
> > MIDXs exist, but no local MIDX exists by first checking that 'm->local'
> > before asking whether or not it contains the requested pack.
>
> It seems like the root of the problem is that get_multi_pack_index() is
> being used for two different things:
>
>   - most callers want to iterate over all of the possible midx files,
>     because they're trying to look up an object.
>
>   - this caller wants the single midx for the local repository (I
>     wondered if there might be more of these that we just never noticed
>     because the test suite doesn't use alternates, but having just
>     audited them all, the answer is no).
>
> So I'd be tempted to say that the latter callers should be using a
> separate function that gives them what they want. That lets them avoid
> being too intimate with the details of how we order things.
>
> The patch below illustrates that.  It also changes the existing function
> name to avoid confusion and to help audit the existing callers, but
> that's optional and maybe not worth it.
>
> It does do the linear lookup, so it has the O(m*n) you mentioned. But
> the number of alternates is generally small, and I'd be shocked if this
> was the first m*n loop over the number of alternates. However, we could
> still do the ordering thing and just keep the details inside the new
> function.

I'd be much happier with this patch.

If you wanted to go further, we could do both, and tighten up the
insertion code to make sure that the local MIDX is always first from the
perspective of 'r->objects->multi_pack_index' so that the linear lookup
drops to constant.

But, it might be overkill, since I also tend to think that the number of
alternates is small, and we're not even talking about a difference of
milliseconds here.

So, I'm happy to clean it up for you and forge your sign-off with
permission, or otherwise you're welcome to do so, too.

Thanks,
Taylor
