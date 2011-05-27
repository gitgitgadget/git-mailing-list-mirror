From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] rebase: create HEAD reflog entry when aborting
Date: Fri, 27 May 2011 16:13:02 -0400
Message-ID: <20110527201302.GA29836@sigill.intra.peff.net>
References: <BANLkTinyKQJQUHa8tn43=cCJMsVbgaZXjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Csaba Henk <csaba@lowlife.hu>
X-From: git-owner@vger.kernel.org Fri May 27 22:13:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ3PF-0007ju-BD
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab1E0UNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 16:13:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45461
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab1E0UNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 16:13:06 -0400
Received: (qmail 27241 invoked by uid 107); 27 May 2011 20:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 May 2011 16:13:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2011 16:13:02 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinyKQJQUHa8tn43=cCJMsVbgaZXjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174644>

From: Csaba Henk <csaba@lowlife.hu>

When we abort a rebase, we return to the original value of
HEAD. Failing to write a reflog entry means we create a
gap in the reflog (which can cause "git show
HEAD@{5.minutes.ago}" to issue a warning). Plus having the
extra entry makes the reflog easier to follow for a human.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the one that actually gave you trouble. It's different than
other cases (dealt with in 2/2) in that it actually creates a gap in the
reflog. So I think fixing it is the right thing to do, and your original
patch is fine.

 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 7a54bfc..57cbe49 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -332,7 +332,7 @@ abort)
 	read_basic_state
 	case "$head_name" in
 	refs/*)
-		git symbolic-ref HEAD $head_name ||
+		git symbolic-ref -m "rebase: aborting" HEAD $head_name ||
 		die "Could not move back to $head_name"
 		;;
 	esac
-- 
1.7.5.3.12.g99e25
