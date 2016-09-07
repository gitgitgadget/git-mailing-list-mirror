Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BCA1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 22:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbcIGWvP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:51:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33901 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbcIGWvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 18:51:14 -0400
Received: from mfilter18-d.gandi.net (mfilter18-d.gandi.net [217.70.178.146])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 64104FB882;
        Thu,  8 Sep 2016 00:51:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter18-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter18-d.gandi.net (mfilter18-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id 8RrQ-Wt8LLk2; Thu,  8 Sep 2016 00:51:09 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E3356FB877;
        Thu,  8 Sep 2016 00:51:06 +0200 (CEST)
Date:   Wed, 7 Sep 2016 15:51:04 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v2 0/3] patch-id for merges
Message-ID: <20160907225104.f5wi2yo4d2f26tti@x>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
 <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 06:01:01PM -0400, Jeff King wrote:
> Here's a re-roll of the series I posted at:
> 
>   http://public-inbox.org/git/20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net/
> 
> Basically, it drops the time for "format-patch --cherry-pick" on a
> particular case from 3 minutes down to 3 seconds, by avoiding diffs
> on merge commits. Compared to v1, it fixes the totally-broken handling
> of commit_patch_id() pointed out by Johannes.
> 
> We can drop the diffs on the merge commits because they're quite broken,
> as discussed in the commit message of patch 3 (they don't take into
> account any parent except the first). So what do we do when somebody
> asks for the patch-id of a merge commit?
> 
> This is still marked RFC, because there are really two approaches here,
> and I'm not sure which one is better for "format-patch --base". I'd like
> to get input from Xiaolong Ye (who worked on --base), and Josh Triplett
> (who has proposed some patches in that area, and is presumably using
> them).

Thanks.

I'd love to see a more resilient patch-id mechanism, to make it easier
to match up patches between branches.  I don't think it makes sense to
talk about the patch-id of a merge commit (though it might make sense
for a merge which makes additional changes not present in any of the
parents).  Even if someone wants to match up merge commits with merge
commits, I don't think that should happen via patch-id; I think that
should happen in terms of "what patches does this merge introduce",
without constructing a merge-patch-id via a Merkle tree of commit
patch-ids.

So, I think this patch series makes sense (modulo the comments about the
commit message in patch 3).  We already don't respect merge commits when
doing format-patch; this seems consistent with that.  If we ever make it
possible for format-patch to handle merge commits, then we should also
allow it to have merge commits as prerequisites.

- Josh Triplett
