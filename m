Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9305C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C027520722
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgCTWiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:38:04 -0400
Received: from mx.sdf.org ([205.166.94.20]:53199 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgCTWiD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 18:38:03 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 18:38:02 EDT
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02KMUFjD029457
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Fri, 20 Mar 2020 22:30:15 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02KMUFaY008062;
        Fri, 20 Mar 2020 22:30:15 GMT
Date:   Fri, 20 Mar 2020 22:30:15 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     git@vger.kernel.org
Cc:     lkml@sdf.org
Subject: Feature request: rebase -i inside of rebase -i
Message-ID: <20200320223015.GA19579@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm cleaning up a patch series for submission, and came across a fixup in
patch #4/20 that belongs in #2/20.

Unfortunately, I can't go back two patches to apply the fix until I get to 
the end of the current rebase, then go back down to clean it up. :-(

Thinking about it, I realized that a rebase in a rebase is a perfectly 
well defined operation.  *If* you don't bother setting a new abort point 
(it's not a fully nested transaction), *and* require that the tree be 
clean (no stashing allowed; create a WIP commit instead), it's just a 
matter of putting some commits back on the front of the todo-list and 
checking out the old version.

This would make rebase work more like quilt.

I'm not sure how difficult this would be, but it might be worth looking
into.  (Possibly gated by an extra option like --nested.)


(A second thing that would be nice would be a documented way to break out 
of a reword and change the commit.  A few times I've been improving
the documentation of a patch and realized that I should change the 
function name.)

