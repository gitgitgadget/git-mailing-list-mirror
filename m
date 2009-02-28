From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] git-svn - return original format_svn_date semantics
Date: Fri, 27 Feb 2009 22:11:45 -0500
Message-ID: <1235790705-12903-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sat Feb 28 04:13:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdFde-0007ti-Bu
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 04:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbZB1DLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 22:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbZB1DLt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 22:11:49 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:37015 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZB1DLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 22:11:48 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LdFcA-0004U5-7O; Fri, 27 Feb 2009 22:11:46 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LdFcA-0003MV-46; Fri, 27 Feb 2009 22:11:46 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n1S3BjRl012923;
	Fri, 27 Feb 2009 22:11:45 -0500
X-Mailer: git-send-email 1.5.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111742>

When %z was removed from the strftime call and subsituted with a
local gmt offset calculation, time() was no longer the default for
all time functions as it was with the previous localtime(shift).
This is now corrected so that format_svn_time behaves as it used to.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d967594..55702d0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4738,7 +4738,7 @@ sub run_pager {
 
 sub format_svn_date {
 	# some systmes don't handle or mishandle %z, so be creative.
-	my $t = shift;
+	my $t = shift || time;
 	my $gm = timelocal(gmtime($t));
 	my $sign = qw( + + - )[ $t <=> $gm ];
 	my $gmoff = sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
-- 
1.6.0.4
