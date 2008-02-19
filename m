From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] push: indicate partialness of error message
Date: Tue, 19 Feb 2008 11:25:01 -0500
Message-ID: <20080219162501.GA30451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jason Garber <jgarber@ionzoft.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVI3-00008w-MF
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbYBSQZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbYBSQZG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:25:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4248 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbYBSQZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:25:04 -0500
Received: (qmail 22541 invoked by uid 111); 19 Feb 2008 16:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Feb 2008 11:25:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 11:25:01 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74425>

The existing message indicates that an error occured during
push, but it is unclear whether _any_ refs were actually
pushed (even though the status table above shows which were
pushed successfully and which were not, the message "failed
to push" implies a total failure). By indicating that "some
refs" failed, we hopefully indicate to the user that the
table above contains the details.

We could also put in an explicit "see above for details"
message, but it seemed to clutter the output quite a bit
(both on a line of its own, or at the end of the error line,
which inevitably wraps).

This could also be made more fancy if the transport
mechanism passed back more details on how many refs
succeeded and failed:

  error: failed to push %d out of %d refs to '%s'

Signed-off-by: Jeff King <peff@peff.net>
---
This patch series is meant to address some user issues encountered in
the recent thread "git push [rejected] question". It's entirely
message and documentation updates.

 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index c8cb63e..9f727c0 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -90,7 +90,7 @@ static int do_push(const char *repo, int flags)
 		if (!err)
 			continue;
 
-		error("failed to push to '%s'", remote->url[i]);
+		error("failed to push some refs to '%s'", remote->url[i]);
 		errs++;
 	}
 	return !!errs;
-- 
1.5.4.1.143.ge7e51-dirty
