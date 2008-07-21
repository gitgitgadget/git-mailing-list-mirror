From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/9] Makefile: Do not install a copy of 'git' in $(gitexecdir)
Date: Mon, 21 Jul 2008 21:19:50 +0200
Message-ID: <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:21:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0wT-0001rx-FH
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbYGUTUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbYGUTUE
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:20:04 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39815 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbYGUTUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:20:03 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 08C5F33C3E;
	Mon, 21 Jul 2008 21:20:00 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.18.g6aef2
In-Reply-To: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89391>

There is already a copy in $(bindir). A subsequent patch will enable git
to derive the exec-path from its invocation path. If git is invoked
recursively, the first invocation puts the exec-path into PATH, so that
the recursive invocation would find the instance in the exec-path. This
second instance would again try to derive an exec-path from its invocation
path, but would base its result on the wrong "bindir".

We do install the copy of git first, but remove it later, so that we can
use it as the source of the hardlinks for the builtins.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 551bde9..cbab4f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1335,6 +1335,7 @@ endif
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
 	fi
 	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+	$(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 endif
-- 
1.6.0.rc0.18.g6aef2
