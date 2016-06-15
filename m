From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 10:05:47 -0400
Message-ID: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 17 16:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii9Wv-0000Di-6U
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 16:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003AbXJQOFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 10:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933012AbXJQOFf
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 10:05:35 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60391 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992AbXJQOFe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 10:05:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 6E1261FFC131;
	Wed, 17 Oct 2007 14:05:28 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61378>

This was causing test failures because die was exiting 255.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Shawn, I sent this in a couple weeks ago but it looks like it never
 made it into your repo.  It fixes test failures on my machine that have
 been plauging me for months.

 git-cvsserver.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13dbd27..0d55fec 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -145,8 +145,10 @@ if ($state->{method} eq 'pserver') {
     }
     my $request = $1;
     $line = <STDIN>; chomp $line;
-    req_Root('root', $line) # reuse Root
-       or die "E Invalid root $line \n";
+    unless (req_Root('root', $line)) { # reuse Root
+       print "E Invalid root $line \n";
+       exit 1;
+    }
     $line = <STDIN>; chomp $line;
     unless ($line eq 'anonymous') {
        print "E Only anonymous user allowed via pserver\n";
-- 
1.5.3.4.206.g0cef9
