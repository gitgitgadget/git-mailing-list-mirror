Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A5C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693626121E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhGURNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhGURNG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 13:13:06 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC41AC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:53:42 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id m20so3021880ili.9
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJjuWfiZbtY+CyDt0Kvq8FU6IVyokA8ttsu7Djs6kJI=;
        b=ToA1h93GNo8ZZVPybQrTNvGhFI453U3rKVIwnZTjAojuTnXUWG05W2aFdoUoRhgZLF
         xwhrF9/aNxtjfGz2YBbk/PgW17VGuk7E0Hm7czQ2/9ujPeB5PDN6PeJeN9UJmQqVV1DT
         PX1y/eS3wmlOV5HO11tD89eHuc107SiVRLWHii68Z8dx96KJqG31x2hLxvEZz54IOH5t
         8/de6inHJtnJ8WmjFkK6myCJm6Jg2aMibGZqmUKeZ1mFN87gJb1QffpnC4GgSO3I3ETS
         izU9Zl4PJsxfBZr8ZxI5Q4dRlHBHTzDEKkgX+aec787xhNxYey6DLIQliqjLMpi+1U08
         I9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJjuWfiZbtY+CyDt0Kvq8FU6IVyokA8ttsu7Djs6kJI=;
        b=aEWWvPNlgJPjFpIpB43ibG1v9gi0MQzrnF7KGHgvrfpOSsBio/6lsPcORZKvyDZIvn
         dYR06PmL/Pz3Mqfaxn+vp9rNucwWwXetevbnbSKM41Vy+Dcb33UXY7E4s8zLfhcLJcSk
         0Iw4p7fJF1DU1w4FDSWw/vN+pIQBuFgKNi/JBpOvTPBtdL5H14PhPde4AcMaMDyHsNwl
         7uG8SbSzoOXqLPbaM+1n1o8ALkjySVRdY9cl98MlHMFZtlvQ91jh9CYKjKDTxgmlIAUf
         LxOCasYAUf8odjvS1iFKIMA4saTkT5ujNig+dzbHw8h8vNJKV6QNs8yE7dWY30MFSqBD
         Dl8w==
X-Gm-Message-State: AOAM532aHcZyN1Yg+DYaigLa4yDLCFsFhrQZdiau0Ak6B3K/z1cYb41C
        2v5I7rVCjfHknIwwF4X/XIqjqA==
X-Google-Smtp-Source: ABdhPJyEheyxjzIQ/5iebCj48qqo8UWVfg9GIRpxWbZkdi+HFytsL1XOCbZRa9Wrjq6mg3VdE2PxNA==
X-Received: by 2002:a92:c504:: with SMTP id r4mr24408471ilg.131.1626890021303;
        Wed, 21 Jul 2021 10:53:41 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id a1sm5810431ilp.1.2021.07.21.10.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:53:40 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:53:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 05/24] Documentation: describe MIDX-based bitmaps
Message-ID: <YPhfJNubkJpOn4Sm@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <64a260e0c6a116b7c6fa6fea2b9fd96bf416cb18.1624314293.git.me@ttaylorr.com>
 <YPf0hivipY6o5Y3B@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPf0hivipY6o5Y3B@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 06:18:46AM -0400, Jeff King wrote:
> On Mon, Jun 21, 2021 at 06:25:10PM -0400, Taylor Blau wrote:
>
> > +An object is uniquely described by its bit position within a bitmap:
> > +
> > +	- If the bitmap belongs to a packfile, the __n__th bit corresponds to
> > +	the __n__th object in pack order. For a function `offset` which maps
> > +	objects to their byte offset within a pack, pack order is defined as
> > +	follows:
> > +
> > +		o1 <= o2 <==> offset(o1) <= offset(o2)
> > +
> > +	- If the bitmap belongs to a MIDX, the __n__th bit corresponds to the
> > +	__n__th object in MIDX order. With an additional function `pack` which
> > +	maps objects to the pack they were selected from by the MIDX, MIDX order
> > +	is defined as follows:
> > +
> > +		o1 <= o2 <==> pack(o1) <= pack(o2) /\ offset(o1) <= offset(o2)
> > +
> > +	The ordering between packs is done lexicographically by the pack name,
> > +	with the exception of the preferred pack, which sorts ahead of all other
> > +	packs.
>
> This doesn't render well as asciidoc (the final paragraph is taken as
> more of the code block). But that is a problem through the whole file. I
> think we should ignore it for now, and worry about asciidoc-ifying the
> whole thing later, if we choose to.

Agreed; let's ignore it for now.

> > +	The ordering between packs is done lexicographically by the pack name,
> > +	with the exception of the preferred pack, which sorts ahead of all other
> > +	packs.
>
> Hmm, I'm not sure if this "lexicographically" part is true. Really we're
> building on the midx .rev format here. And that says "defined by the
> MIDX's pack list" (though I can't offhand remember if that is
> lexicographic, or if it is in the reverse-mtime order).
>
> At any rate, should we just be referencing the rev documentation?

The packs are listed in lex order in the MIDX, but that is so we can
binary search that list to determine whether a pack is included in the
MIDX or not.

I had to check, but we do use the lex order to resolve duplicate
objects, too. See (at the tip of this branch):

    QSORT(ctx.info, ctx.nr, pack_info_compare);

from within midx.c:write_midx_internal(). Here, ctx.info contains the
list of packs, and pack_info_compare is a thin wrapper around
strcmp()-ing the pack_name values of two packed_git structures.

Arguably, you'd get better EWAH compression of the bits between packs
if we sorted packs in reverse order according to their mtime. But I
suspect that it doesn't matter much in practice, since the number of
objects vastly outpaces the number of packs (but I haven't measured to
be certain, so take that with a grain of salt).

In any case, I think that you're right that adding too much detail hurts
us here, so we should really be mentioning the MIDX's .rev-file
documentation (unfortunately, we can't linkgit it, so mentioning it by
name will have to suffice). I plan to reroll with something like this on
top:

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 25221c7ec8..04b3ec2178 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -26,9 +26,8 @@ An object is uniquely described by its bit position within a bitmap:

 		o1 <= o2 <==> pack(o1) <= pack(o2) /\ offset(o1) <= offset(o2)

-	The ordering between packs is done lexicographically by the pack name,
-	with the exception of the preferred pack, which sorts ahead of all other
-	packs.
+	The ordering between packs is done according to the MIDX's .rev file.
+	Notably, the preferred pack sorts ahead of all other packs.

 The on-disk representation (described below) of a bitmap is the same regardless
 of whether or not that bitmap belongs to a packfile or a MIDX. The only

Thanks,
Taylor
