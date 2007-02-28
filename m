From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-cvsexportcommit: don't cleanup .msg if not yet committed to cvs.
Date: Wed, 28 Feb 2007 12:35:39 +0000
Message-ID: <20070228123539.23809.qmail@d6daeb0e3466c1.315fe32.mid.smarden.org>
References: <20070227181721.GA4244@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 13:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMO1n-0006pA-Rq
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 13:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXB1MfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 07:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbXB1MfW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 07:35:22 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:38252 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1752146AbXB1MfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 07:35:22 -0500
Received: (qmail 23810 invoked by uid 1000); 28 Feb 2007 12:35:39 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070227181721.GA4244@bogon.ms20.nix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40917>

Unless the -c option is given, and the commit to cvs was successful,
.msg shouldn't be deleted to be able to run the command suggested by
git-cvsexportcommit.

See http://bugs.debian.org/412732

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-cvsexportcommit.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d08216c..67224b4 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -248,13 +248,14 @@ if ($opt_c) {
 	die "Exiting: The commit did not succeed";
     }
     print "Committed successfully to CVS\n";
+    # clean up
+    unlink(".msg");
 } else {
     print "Ready for you to commit, just run:\n\n   $cmd\n";
 }
 
 # clean up
 unlink(".cvsexportcommit.diff");
-unlink(".msg");
 
 sub usage {
 	print STDERR <<END;
-- 
1.5.0.1
