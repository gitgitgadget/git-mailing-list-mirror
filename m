From: Alp Toker <alp@atoker.com>
Subject: [PATCH] Install built-ins as symlinks
Date: Tue, 11 Jul 2006 11:19:38 +0100
Message-ID: <11526131792377-git-send-email-alp@atoker.com>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com> <11526131791902-git-send-email-alp@atoker.com> <11526131792773-git-send-email-alp@atoker.com>
X-From: git-owner@vger.kernel.org Tue Jul 11 12:20:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0FLY-0003jo-BU
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 12:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWGKKT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 06:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWGKKT5
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 06:19:57 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:12307 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1750949AbWGKKT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 06:19:56 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 35A6016460A; Tue, 11 Jul 2006 11:19:39 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g97c7-dirty
In-Reply-To: <11526131792773-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23706>

Doing this now will save headache in the long run, avoiding mismatched
versions of installed utilities and dangling copies of removed or
renamed git commands that still appear to work. It also makes screwups
when packaging git or making system backups less likely.

BusyBox has been doing it this way for years.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5b7bac8..cb5a5cc 100644
--- a/Makefile
+++ b/Makefile
@@ -538,7 +538,7 @@ git$X: git.c common-cmds.h $(BUILTIN_OBJ
 builtin-help.o: common-cmds.h
 
 $(BUILT_INS): git$X
-	rm -f $@ && ln git$X $@
+	ln -sf git$X $@
 
 common-cmds.h: Documentation/git-*.txt
 	./generate-cmdlist.sh > $@+
@@ -748,7 +748,7 @@ install: all
 		cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
 	fi
-	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+	$(foreach p,$(BUILT_INS), ln -sf 'git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 
 install-doc:
 	$(MAKE) -C Documentation install
-- 
1.4.1.g97c7-dirty
