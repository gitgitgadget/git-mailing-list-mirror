From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH] t1301-shared-repo.sh: fix 'stat' portability issue
Date: Thu, 16 Aug 2007 17:21:03 +0200
Message-ID: <1187277663740-git-send-email-arjen@yaph.org>
Cc: Arjen Laarhoven <arjen@yaph.org>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 17:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILhWl-0006Pe-Ig
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 17:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686AbXHPPos (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 11:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756554AbXHPPos
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 11:44:48 -0400
Received: from regex.yaph.org ([193.202.115.201]:56543 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130AbXHPPor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 11:44:47 -0400
X-Greylist: delayed 1422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2007 11:44:47 EDT
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 329505B7D2; Thu, 16 Aug 2007 17:21:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc5.12.geb1b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56021>

The t1301-shared-repo.sh testscript uses /usr/bin/stat to get the file
mode, which isn't portable.  There already is a dependency on Perl, so
use a Perl one-liner to do the file mode test, but portable.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 t/t1301-shared-repo.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index bb5f302..888c5fb 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -21,7 +21,7 @@ test_expect_success 'update-server-info honors core.sharedRepository' '
 	git commit -m a1 &&
 	umask 0277 &&
 	git update-server-info &&
-	test 444 = $(stat -c %a .git/info/refs)
+	$(perl -e '\''exit !(((stat ".git/info/refs")[2] & 0777) == 0444)'\'')
 '
 
 test_done
-- 
1.5.3.rc4.67.gf9286
