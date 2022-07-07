Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF1C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiGGXyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiGGXyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:54:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A376D551
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:54:22 -0700 (PDT)
Received: (qmail 6914 invoked by uid 109); 7 Jul 2022 23:54:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 23:54:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5866 invoked by uid 111); 7 Jul 2022 23:54:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 19:54:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 19:54:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 0/3] cloning unborn HEAD when other branches are present
Message-ID: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
 <YsVB2eOMp5guQfVr@coredump.intra.peff.net>
 <xmqqr12ygl3p.fsf@gitster.g>
 <xmqq5yk9hpd9.fsf@gitster.g>
 <Yscaoz8qmPYiiLO5@coredump.intra.peff.net>
 <xmqqk08ozrid.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk08ozrid.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 07, 2022 at 11:50:34AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If so, do you prefer to go straight there in patch 3 (and drop patch 2,
> > keeping the unborn setup inline), or do you prefer to see it on top?
> > Normally I'd suggest the former, but I worry that doing it all in one
> > patch means it's reorganizing the code _and_ changing the behavior all
> > at once, which is harder to reason about. And I don't see an easy way to
> > reorganize the code without changing the behavior.
> 
> Either way is fine, but the "go straight there" approach may work
> better, I suspect.

Yeah, the diff turned out less noisy than I'd feared. So here's a v2. It
does the refactoring we've been discussing, which is now in patch 2
(since the extra function is no longer needed). And then it was actually
pretty easy to fix the other weird "your unborn master does not match
the remote's master" problem on top. I _think_ that's the right thing to
be doing, but see the discussion in patch 3.

I'll skip the range diff, which is mostly unreadable (the only readable
part is that I did s/empty/unborn/ in the tests, as discussed).

  [1/3]: clone: drop extra newline from warning message
  [2/3]: clone: propagate empty remote HEAD even with other branches
  [3/3]: clone: use remote branch if it matches default HEAD

 builtin/clone.c        | 58 ++++++++++++++++++++++-------------------
 t/t5605-clone-local.sh | 16 +++++++++---
 t/t5702-protocol-v2.sh | 59 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 29 deletions(-)

-Peff
