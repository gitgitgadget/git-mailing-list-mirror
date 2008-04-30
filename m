From: Jeff King <peff@peff.net>
Subject: [PATCH] cvsimport: always pass user data to "system" as a list
Date: Wed, 30 Apr 2008 00:36:14 -0400
Message-ID: <20080430043614.GA31019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nigel Magnay <nigel.magnay@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 06:37:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr446-0006AZ-Bc
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 06:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbYD3EgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 00:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbYD3EgR
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 00:36:17 -0400
Received: from peff.net ([208.65.91.99]:4721 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbYD3EgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 00:36:17 -0400
Received: (qmail 11425 invoked by uid 111); 30 Apr 2008 04:36:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 00:36:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 00:36:14 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80787>

This avoids invoking the shell. Not only is it faster, but
it prevents the possibility of interpreting our arguments in
the shell.

Signed-off-by: Jeff King <peff@peff.net>
---
Nigel reported a problem with a CVS branch that had '(' in the name. No
report yet on whether this fixes it, but it should be done regardless.

I checked over git-cvsimport.perl, and this was the only instance I
found.

 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 95c5eec..bdac5d5 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -772,7 +772,7 @@ sub commit {
 	waitpid($pid,0);
 	die "Error running git-commit-tree: $?\n" if $?;
 
-	system("git-update-ref $remote/$branch $cid") == 0
+	system('git-update-ref', "$remote/$branch", $cid) == 0
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if ($tag) {
-- 
1.5.5.1.178.gc1eb9.dirty
