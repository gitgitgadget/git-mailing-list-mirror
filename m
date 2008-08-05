From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: use backticks rather than $() notation to support
 ancient shells
Date: Tue, 05 Aug 2008 18:22:09 -0500
Message-ID: <K5bb057jTokXyOIU_aDE4vMr3jT4DOgSPRcIktfus6QMVq6dszrgGw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 01:23:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQVs6-0006QH-Uq
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 01:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbYHEXWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 19:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755187AbYHEXWR
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 19:22:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35849 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbYHEXWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 19:22:16 -0400
Received: by mail.nrlssc.navy.mil id m75NM9xW028161; Tue, 5 Aug 2008 18:22:09 -0500
X-OriginalArrivalTime: 05 Aug 2008 23:22:09.0800 (UTC) FILETIME=[155F3880:01C8F752]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91469>

Since make is using /bin/sh to execute shell code, avoid the newish
shell construct $() so older (ancient) shells can execute the shell
code in the Makefile.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I know that $() is preferred in the main scripts, but the Makefile
is using /bin/sh to execute shell code and there are already a few
places in the Makefile using back-ticks, so it doesn't seem like
going against the flow too much.

Otherwise, should we set the SHELL variable to the configured SHELL_PATH
at some point in the Makefile?

-brandon


 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 608a185..421af24 100644
--- a/Makefile
+++ b/Makefile
@@ -1366,8 +1366,8 @@ endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
-	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
-	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
+	bindir=`cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd` && \
+	execdir=`cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd` && \
 	if test "z$$bindir" != "z$$execdir"; \
 	then \
 		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
-- 
1.6.0.rc1.87.g56c9f.dirty
