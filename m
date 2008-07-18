From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Windows: set gitexecdir = $(bindir)
Date: Fri, 18 Jul 2008 09:34:45 +0200
Message-ID: <1216366485-12201-5-git-send-email-johannes.sixt@telecom.at>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-2-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-3-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-4-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 09:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJkVT-0003a0-I7
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 09:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYGRHeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 03:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbYGRHet
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 03:34:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48425 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbYGRHes (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 03:34:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KJkUI-0004B2-IL; Fri, 18 Jul 2008 09:34:46 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3EBB7FF4E; Fri, 18 Jul 2008 09:34:46 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 2D998FA4A; Fri, 18 Jul 2008 09:34:46 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.275.g0a3e0f
In-Reply-To: <1216366485-12201-4-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88999>

The "dash-less" change aims to remove git commands from $PATH. It does so
by defining a GIT_EXEC_PATH that is different from $(bindir). On Windows
we want a relocatable installation of the git tool, so we cannot use an
absolute GIT_EXEC_PATH.  Therefore, the implementation of
builtin_exec_path() on Windows derives the exec-path from the command
invocation, and disregards GIT_EXEC_PATH. But this broke when
$(gitexecdir) became different from $(bindir), so we restore the earlier
behavior here.

This counteracts the aims of the "dash-less" change on Windows, but better
this way than having no working git at all.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 36339d3..7d466b3 100644
--- a/Makefile
+++ b/Makefile
@@ -742,6 +742,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
+	gitexecdir = $(bindir)
 	template_dir = ../share/git-core/templates/
 	ETC_GITCONFIG = ../etc/gitconfig
 endif
-- 
1.5.6.1.275.g0a3e0f
