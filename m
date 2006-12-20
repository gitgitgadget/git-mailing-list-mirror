X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: [PATCH] revision: add --no-full-diff command line option
Date: Wed, 20 Dec 2006 03:41:08 -0500
Message-ID: <20061220084107.GA6895@coredump.intra.peff.net>
References: <20061220060102.GA540@coredump.intra.peff.net> <7v8xh3j86h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 08:41:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v8xh3j86h.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34910>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwx0k-0000cH-OV for gcvg-git@gmane.org; Wed, 20 Dec
 2006 09:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964933AbWLTIlM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWLTIlM
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 03:41:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:56476
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S964933AbWLTIlL (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 03:41:11 -0500
Received: (qmail 23009 invoked from network); 20 Dec 2006 03:41:09 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 20 Dec 2006 03:41:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec
 2006 03:41:08 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


Signed-off-by: Jeff King <peff@peff.net>
---
On Wed, Dec 20, 2006 at 12:14:14AM -0800, Junio C Hamano wrote:

> > I use --full-diff all the time, so this should save some typing. I can't
> > think of a time when I wouldn't want it on, but if there is, we probably
> > need a --no-full-diff.
> 
> Absolutely.

I took this to mean "absolutely we need --no-full-diff." :)

I note that --full-diff sets rev->diff = 1. The log.fulldiff config
option does not, and nor does --no-full-diff unset it. However, I'm not
sure it makes sense to set it. Doing "git-log --full-diff" outputs an
extra line (separating the diff from the commit log) but since we
haven't told it any type of diff to output, the diff is blank. And if we
had told it a type, then that would have turned on rev->diff. So I don't
see a point in setting it.

 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 56819f8..ac4dbf2 100644
--- a/revision.c
+++ b/revision.c
@@ -955,6 +955,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->full_diff = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--no-full-diff")) {
+				revs->full_diff = 0;
+				continue;
+			}
 			if (!strcmp(arg, "--full-history")) {
 				revs->simplify_history = 0;
 				continue;
-- 
1.4.4.2.gee7ba-dirty
