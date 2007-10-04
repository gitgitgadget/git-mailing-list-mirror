From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 3 Oct 2007 21:43:47 -0400
Message-ID: <20071004014253.GA22390@Hermes.local>
References: <20071004011954.GK18024@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 03:43:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdFkc-0006Ie-05
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 03:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbXJDBnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 21:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbXJDBnc
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 21:43:32 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39856 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbXJDBnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 21:43:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 287861FFC013
	for <git@vger.kernel.org>; Thu,  4 Oct 2007 01:43:31 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <20071004011954.GK18024@planck.djpig.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59916>

This was causing test failures because die was exiting 255.
---

 This finally takes care of my test failures.
 
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
1.5.3.4.203.gcc61a
