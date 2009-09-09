From: Jeff King <peff@peff.net>
Subject: [PATCH] rebase: use plumbing to show dirty state
Date: Wed, 9 Sep 2009 10:59:37 -0400
Message-ID: <20090909145937.GA5723@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 16:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlOeA-0001Ue-9v
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 16:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbZIIO7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 10:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZIIO7h
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 10:59:37 -0400
Received: from peff.net ([208.65.91.99]:50179 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbZIIO7g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 10:59:36 -0400
Received: (qmail 28818 invoked by uid 107); 9 Sep 2009 14:59:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 09 Sep 2009 10:59:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 10:59:37 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128070>

Commit 4cfbe06 introduced the use of "git diff" to show
dirty state in a format more familiar to users. However, it
should have used the plumbing "git diff-files" instead.

Not only is it good practice in general to use plumbing in
scripts, but in this case we really don't want the automatic
pager to kick in for an error message.

Signed-off-by: Jeff King <peff@peff.net>
---
I got quite a surprise when I ran "git rebase" and was presented with a
pager with nothing but:

  M foo.c

in it. I suspect this issue wasn't noticed while testing because most
people use "-FX" with "less", so their short list of dirty files causes
the pager to exit immediately.

 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2315d95..6ec155c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -387,7 +387,7 @@ fi
 # The tree must be really really clean.
 if ! git update-index --ignore-submodules --refresh > /dev/null; then
 	echo >&2 "cannot rebase: you have unstaged changes"
-	git diff --name-status -r --ignore-submodules -- >&2
+	git diff-files --name-status -r --ignore-submodules -- >&2
 	exit 1
 fi
 diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
-- 
1.6.5.rc0.166.ge65f.dirty
