From: Eric Blake <ebb9@byu.net>
Subject: [PATCH 1/2] Makefile: installing git in cygwin 1.7.0
Date: Tue, 28 Apr 2009 06:28:31 -0600
Message-ID: <1240921712-3100-2-git-send-email-ebb9@byu.net>
References: <1240921712-3100-1-git-send-email-ebb9@byu.net>
Cc: Eric Blake <ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 14:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LymQi-0003Tk-DU
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 14:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbZD1M2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 08:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755214AbZD1M2j
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 08:28:39 -0400
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:35440 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755109AbZD1M2j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 08:28:39 -0400
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id l02U1b0040FhH24A30Uf88; Tue, 28 Apr 2009 12:28:39 +0000
Received: from localhost.localdomain ([24.10.247.15])
	by OMTA08.emeryville.ca.mail.comcast.net with comcast
	id l0UP1b0060Lg2Gw8U0Uek9; Tue, 28 Apr 2009 12:28:39 +0000
X-Mailer: git-send-email 1.6.3.rc3.2.g4b51
In-Reply-To: <1240921712-3100-1-git-send-email-ebb9@byu.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117767>

On platforms with $X, make removes any leftover scripts 'a' from
earlier builds if a new binary 'a.exe' is now built.  However, on
cygwin 1.7.0, 'git' and 'git.exe' now consistently name the same file.
Test for file equality before attempting a remove, in order to avoid
nuking just-built binaries.

This repeats commit 0d768f7 for the installation destdir.

Signed-off-by: Eric Blake <ebb9@byu.net>
---

This should be a trivial approval, seeing as how it finishes the
job of a previous patch (but this time for the installation dir,
as opposed to the build dir).  Without it, programs like git-var
get nuked during 'make install', giving a broken installation.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 5c8e83a..93ca0db 100644
--- a/Makefile
+++ b/Makefile
@@ -1545,7 +1545,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
 endif
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
-- 
1.6.3.rc3.2.g4b51
