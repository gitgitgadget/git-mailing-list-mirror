From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 13:57:03 -0400
Message-ID: <20150320175703.GA15054@peff.net>
References: <20150320100429.GA17354@peff.net>
 <550C2E7B.3030203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:57:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1AV-00038T-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbbCTR5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:57:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:35957 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750950AbbCTR5G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:57:06 -0400
Received: (qmail 27018 invoked by uid 102); 20 Mar 2015 17:57:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 12:57:05 -0500
Received: (qmail 26073 invoked by uid 107); 20 Mar 2015 17:57:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:57:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 13:57:03 -0400
Content-Disposition: inline
In-Reply-To: <550C2E7B.3030203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265922>

On Fri, Mar 20, 2015 at 03:28:11PM +0100, Michael J Gruber wrote:

> With 1/25 only, I get 163 dubious or failed on current next.
> With 1/25 and only chain-lint without running the actual test loads, I
> get 213.
> 
> So, just as Jeff explained, we don't want a "chain-lint-only mode"
> because it does not give correct results.

Thanks for checking. I had assumed there would be some weirdness, but I
didn't actually try a lint-only mode.

I only ran the lint against master earlier. There are two trivial broken
chains in pu. Patch is below (against nd/multiple-work-trees).  Looks
like that is in 'next', so we can't just squash it in.

-- >8 --
Subject: t2026: fix broken &&-chains

These are totally trivial (test_when_finished should never
fail), but being complete with our &&-chaining makes the new
--chain-lint feature more useful.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t2026-prune-linked-checkouts.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index 2936d52..e885baf 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -65,7 +65,7 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
 '
 
 test_expect_success 'not prune locked checkout' '
-	test_when_finished rm -r .git/worktrees
+	test_when_finished rm -r .git/worktrees &&
 	mkdir -p .git/worktrees/ghi &&
 	: >.git/worktrees/ghi/locked &&
 	git prune --worktrees &&
@@ -73,7 +73,7 @@ test_expect_success 'not prune locked checkout' '
 '
 
 test_expect_success 'not prune recent checkouts' '
-	test_when_finished rm -r .git/worktrees
+	test_when_finished rm -r .git/worktrees &&
 	mkdir zz &&
 	mkdir -p .git/worktrees/jlm &&
 	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
-- 
2.3.3.520.g3cfbb5d
