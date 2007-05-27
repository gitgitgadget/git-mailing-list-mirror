From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] t9400: Work around CVS' deficiencies
Date: Sun, 27 May 2007 14:33:09 +0200
Message-ID: <11802692201027-git-send-email-frank@lichtenheld.de>
References: <1180269190126-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 27 14:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsICE-000432-H5
	for gcvg-git@gmane.org; Sun, 27 May 2007 14:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbXE0Mtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 08:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXE0Mts
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 08:49:48 -0400
Received: from v32413.1blu.de ([88.84.155.73]:41066 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbXE0Mto (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 08:49:44 -0400
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 May 2007 08:49:42 EDT
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HsHwy-0004fD-Q7; Sun, 27 May 2007 14:34:20 +0200
Received: from p3ee3d801.dip.t-dialin.net ([62.227.216.1] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HsHwy-0007aW-13; Sun, 27 May 2007 14:34:20 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HsHwU-0006M6-Is; Sun, 27 May 2007 14:33:50 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
In-Reply-To: <1180269190126-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48533>

If we are too fast with our changes, the file in
the working copy might still have the same mtime
as noted in the CVS/Entries. This will cause CVS
to happily report to the server that the file is
unmodified which can lead to data loss (and in
our case test failure).

CVS sucks!

Work around that by sleeping for a second.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t9400-git-cvsserver-server.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 7f9c6e2..76a9b1a 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -250,6 +250,7 @@ test_expect_success 'cvs update (merge)' \
    git commit -q -m "Merge test (merge)" &&
    git push gitcvs.git >/dev/null &&
    cd cvswork &&
+   sleep 1 && touch merge &&
    GIT_CONFIG="$git_config" cvs -Q update &&
    diff -q merge ../expected'
 
@@ -292,6 +293,7 @@ test_expect_success 'cvs update (merge no-op)' \
     git commit -q -m "Merge test (no-op)" &&
     git push gitcvs.git >/dev/null &&
     cd cvswork &&
+    sleep 1 && touch merge &&
     GIT_CONFIG="$git_config" cvs -Q update &&
     diff -q merge ../merge'
 
-- 
1.5.2-rc3.GIT
