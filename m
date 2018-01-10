Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19261F404
	for <e@80x24.org>; Wed, 10 Jan 2018 21:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeAJVBd (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 16:01:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeAJVBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 16:01:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F1AB60BE7; Wed, 10 Jan 2018 21:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515618091;
        bh=GJOyZRDWJ56iUyRIfhQQmagu20X2OtGnt8+oXHc4AMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5ro/3pPAsGoae7mDQMYqBr/lSoHaZvZsiRtzTRWM2taNgH9nIBKGrQvbDVL9t2SS
         HVQVES97V/DGEk32w12awqpaZiZ1+DNbFVSwXn119GlAGg5hw/0HaF/nlPiAVjveJE
         KQKnqwtBFMJ9pBcp3f8LjdvsBF5PAH0fPP4ATz/U=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B252E6032D;
        Wed, 10 Jan 2018 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515618089;
        bh=GJOyZRDWJ56iUyRIfhQQmagu20X2OtGnt8+oXHc4AMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcTzKeX7bSYlCNQg2ifVw5MuDTLxnMyeKbAm6gds2KryLlsJsSN0eeewsbTuOC9W1
         Vj3GuK4bYAbUKFNHOQoPkw8/Kwz7xes5qXpV9AGECGV1r8RTkhrcDCy+Q2k6978jlO
         pY2fc1iPdaTejXtQPiFog0LuLsb7XnU5CU19OFfY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B252E6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
Date:   Wed, 10 Jan 2018 14:01:28 -0700
Message-ID: <7273121.kKAycuMGzH@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-125-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <7b3df316-8a35-0dcf-da17-64202f600821@gmail.com>
References: <20180107181459.222909-1-dstolee@microsoft.com> <2648064.NJaMxHkljU@mfick-lnx> <7b3df316-8a35-0dcf-da17-64202f600821@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, January 10, 2018 02:39:13 PM Derrick Stolee 
wrote:
> On 1/10/2018 1:25 PM, Martin Fick wrote:
> > On Sunday, January 07, 2018 01:14:41 PM Derrick Stolee
> > 
> > wrote:
> >> This RFC includes a new way to index the objects in
> >> multiple packs using one file, called the multi-pack
> >> index (MIDX).
> > 
> > ...
> > 
> >> The main goals of this RFC are:
> >> 
> >> * Determine interest in this feature.
> >> 
> >> * Find other use cases for the MIDX feature.
> > 
> > My interest in this feature would be to speed up fetches
> > when there is more than one large pack-file with many of
> > the same objects that are in other pack-files.   What
> > does your MIDX design do when it encounters multiple
> > copies of the same object in different pack files? 
> > Does it index them all, or does it keep a single copy?
> 
> The MIDX currently keeps only one reference to each
> object. Duplicates are dropped during writing. (See the
> care taken in commit 04/18 to avoid duplicates.) Since
> midx_sha1_compare() does not use anything other than the
> OID to order the objects, there is no decision being made
> about which pack is "better". The MIDX writes the first
> copy it finds and discards the others.

This would likely speed things up then, even if the chosen 
objects are suboptimal.

> It would not be difficult to include a check in
> midx_sha1_compare() to favor one packfile over another
> based on some measurement (size? mtime?). Since this
> would be a heuristic at best, I left it out of the
> current patch.

Yeah, I didn't know what heuristic to use either, I tended 
to think that the bigger pack-file would be valuable because 
it is more likely to share deltas with other objects in that 
pack, so more easy to send them.  However, that is likely 
only true during clones or other large fetches when we want 
most objects.  During small "update" fetches, the newer 
packs might be better?

I also thought that objects in alternates should be 
considered less valuable for my use case, however in the 
github fork use case, the alternates might be more valuable?

So yes heuristics, and I don't know what is best.  Perhaps 
some config options could be used to set heuristics like 
this.  Whatever the heuristics are, since they would be a 
part of the MIDX packing process it would be easy to change.  
This assumes that keeping only one copy in the index is the 
right thing.  The question would be, what if we need 
different heuristics for different operations?  Would it make 
sense to have multiple MIDX files covering the same packs 
then, one for fetch, one for merge...?

> > In our Gerrit instance (Gerrit uses jgit), we have
> > multiple copies of the linux kernel repos linked
> > together via the alternatives file mechanism.
> 
> GVFS also uses alternates for sharing packfiles across
> multiple copies of the repo. The MIDX is designed to
> cover all packfiles in the same directory, but is not
> designed to cover packfiles in multiple alternates;
> currently, each alternate would need its own MIDX file.
> Does that cause issues with your setup?

No, since the other large packfiles are all in other repos 
(alternates).  Is there a reason the MIDX would not want to 
cover the alternates?  If you don't then you would seemingly 
loose any benefits of the MIDX when you have alternates in 
use.

...
> > It would be nice if this use case could be improved with
> > MIDX.  To do so, it seems that it would either require
> > that MIDX either only put "the best" version of an
> > object (i.e. pre-select which one to use), or include
> > the extra information to help make the selection
> > process of which copy to use (perhaps based on the
> > operation being performed) fast.
> 
> I'm not sure if there is sufficient value in storing
> multiple references to the same object stored in multiple
> packfiles. There could be value in carefully deciding
> which copy is "best" during the MIDX write, but during
> read is not a good time to make such a decision. It also
> increases the size of the file to store multiple copies.

Yes, I am not sure either, it would be good to have input 
from experts here.

> > This also leads me to ask, what other additional
> > information (bitmaps?) for other operations, besides
> > object location, might suddenly be valuable in an index
> > that potentially points to multiple copies of objects? 
> > Would such information be appropriate in MIDX, or would
> > it be better in another index?
> 
> For applications to bitmaps, it is probably best that we
> only include one copy of each object. Otherwise, we need
> to include extra bits in the bitmaps for those copies
> (when asking "is this object in the bitmap?").

Agreed.  Would the MIDX potentially pave the way to create 
multi-pack bitmaps?

> Thanks for the context with Gerrit's duplicate object
> problem. I'll try to incorporate it in to the design
> document (commit 01/18) for the v1 patch.

FYI, this is not a typical Gerrit thing, it is something 
special we do in our installation.

Thanks for your thoughts,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

