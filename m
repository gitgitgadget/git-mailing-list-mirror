From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Install builtins with the user and group of the installing personality
Date: Mon, 23 Feb 2009 15:50:42 +0000
Message-ID: <20090223155042.14806.qmail@518da7eef5d9e4.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 16:52:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbd6N-0004ev-JN
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 16:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbZBWPur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 10:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbZBWPur
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:50:47 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:3894 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754800AbZBWPur (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:50:47 -0500
Received: (qmail 14807 invoked by uid 1000); 23 Feb 2009 15:50:42 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111144>

If 'make install' was run with sufficient privileges, then the installed
builtins in gitexecdir, which are either hardlinked, symlinked, or copied,
would receive the user and group of whoever built git.  With this commit the
git-add program is installed using $(INSTALL), and subsequently linked or
copied to the other builtins.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index b040a96..7401603 100644
--- a/Makefile
+++ b/Makefile
@@ -1467,9 +1467,7 @@ ifneq (,$X)
 endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
-	{ $(RM) "$$execdir/git-add$X" && \
-		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
-		cp git-add$X "$$execdir/git-add$X"; } && \
+	$(INSTALL) git-add$X "$$execdir" && \
 	{ for p in $(filter-out git-add$X,$(BUILT_INS)); do \
 		$(RM) "$$execdir/$$p" && \
 		ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \
-- 
1.6.1.3
