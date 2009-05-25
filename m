From: Jeff King <peff@peff.net>
Subject: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 06:43:09 -0400
Message-ID: <20090525104308.GA26775@coredump.intra.peff.net>
References: <20090508091218.GC29737@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 12:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8XeV-0005UG-Qj
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 12:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbZEYKnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 06:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbZEYKnK
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 06:43:10 -0400
Received: from peff.net ([208.65.91.99]:43996 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbZEYKnK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 06:43:10 -0400
Received: (qmail 3804 invoked by uid 107); 25 May 2009 10:43:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 06:43:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 06:43:09 -0400
Content-Disposition: inline
In-Reply-To: <20090508091218.GC29737@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119918>

We really have no idea what state the tree is in at this
point, and whether the user might have done useful work on
top of it. So let's err on the side of keeping the user's
data intact.

The downside is that if they do have cruft to get rid of, or
want to pretend as if earlier parts of the series that were
applied did not exist, they must manually "git reset --hard"
now.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a followup to:

  http://thread.gmane.org/gmane.comp.version-control.git/118373

 git-am.sh |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 578780b..a7e24cf 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -240,10 +240,6 @@ then
 			exec git rebase --abort
 		fi
 		git rerere clear
-		test -f "$dotest/dirtyindex" || {
-			git read-tree --reset -u HEAD ORIG_HEAD
-			git reset ORIG_HEAD
-		}
 		rm -fr "$dotest"
 		exit ;;
 	esac
-- 
1.6.3.1.250.g01b8b.dirty
