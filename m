From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Install builtins with the user and group of the installing personality
Date: Tue, 24 Feb 2009 08:58:16 +0000
Message-ID: <20090224085817.16736.qmail@86bc3118539950.315fe32.mid.smarden.org>
References: <20090223155042.14806.qmail@518da7eef5d9e4.315fe32.mid.smarden.org> <49A2D644.6040106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:59:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbt8n-0002Rv-SD
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 09:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZBXI6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 03:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbZBXI6W
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 03:58:22 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:2247 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751663AbZBXI6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 03:58:22 -0500
Received: (qmail 16737 invoked by uid 1000); 24 Feb 2009 08:58:17 -0000
Content-Disposition: inline
In-Reply-To: <49A2D644.6040106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111240>

If 'make install' was run with sufficient privileges, then the installed
builtins in gitexecdir, which are either hardlinked, symlinked, or copied,
would receive the user and group of whoever built git.  With this commit
the initial hardlink or copy is done from the installation tree and not
the build tree to fix this.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

Thanks, Johannes.


 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b040a96..0675c43 100644
--- a/Makefile
+++ b/Makefile
@@ -1468,8 +1468,8 @@ endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	{ $(RM) "$$execdir/git-add$X" && \
-		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
-		cp git-add$X "$$execdir/git-add$X"; } && \
+		ln "$$bindir/git$X" "$$execdir/git-add$X" 2>/dev/null || \
+		cp "$$bindir/git$X" "$$execdir/git-add$X"; } && \
 	{ for p in $(filter-out git-add$X,$(BUILT_INS)); do \
 		$(RM) "$$execdir/$$p" && \
 		ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \
-- 
1.6.1.3
