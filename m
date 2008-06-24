From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH/RFC] git-svn: sanitize_remote_name should accept underscores.
Date: Tue, 24 Jun 2008 11:54:58 -0400
Message-ID: <1214322898-9272-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 24 18:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBB7Y-0002Tn-2g
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbYFXQKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbYFXQKy
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:10:54 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:40081
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752432AbYFXQKx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 12:10:53 -0400
X-Greylist: delayed 933 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2008 12:10:37 EDT
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 11:55:03 -0400
Received: (qmail 29610 invoked from network); 24 Jun 2008 15:55:02 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 24 Jun 2008 15:55:02 -0000
Received: (qmail 29603 invoked from network); 24 Jun 2008 15:55:02 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 24 Jun 2008 15:55:02 -0000
Received: (qmail 29580 invoked from network); 24 Jun 2008 15:55:00 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 24 Jun 2008 15:55:00 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 195008C880; Tue, 24 Jun 2008 11:54:59 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.56.g29b0d
X-OriginalArrivalTime: 24 Jun 2008 15:55:03.0606 (UTC) FILETIME=[AA5D5D60:01C8D612]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86078>

Without this patch, git-svn failed with the error:
 config --get svn-remote.D2007.Win32.url: command returned error: 1

...upon trying to automatically follow a link from a child branch back to
its parent branch D2007_Win32 (note the underscore, not dot, separating the
two words).

Note that I have each of my branches defined (by hand) as separate
svn-remote entries in .git/config since my svn repository layout is
nonstandard.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>

---
I'm not sure why sanitize_remote_name is so picky about allowed characters,
but underscore should certainly be allowed.  I'm worried that this has
revealed a more serious problem, since presumably sanitizing the name
shouldn't break anything in any case.

---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4c9c59b..263d66c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1465,7 +1465,7 @@ sub verify_remotes_sanity {
 # we allow more chars than remotes2config.sh...
 sub sanitize_remote_name {
 	my ($name) = @_;
-	$name =~ tr{A-Za-z0-9:,/+-}{.}c;
+	$name =~ tr{A-Za-z0-9:,_/+-}{.}c;
 	$name;
 }
 
-- 
1.5.6.56.g29b0d
