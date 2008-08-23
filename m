From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC/PATCH] Install templates directory using mkdir -p, not install -d
Date: Sat, 23 Aug 2008 21:29:06 +0200
Message-ID: <1219519746-7438-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 21:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWyoa-00080S-Ay
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYHWT2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbYHWT2g
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:28:36 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:37025 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYHWT2g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:28:36 -0400
Received: from vmobile.example.net (dsl5401CFDD.pool.t-online.hu [84.1.207.221])
	by yugo.frugalware.org (Postfix) with ESMTP id 0087D1DDC5B
	for <git@vger.kernel.org>; Sat, 23 Aug 2008 21:28:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 46FAB96FA; Sat, 23 Aug 2008 21:29:06 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93477>

The templates directory was previously installed using install -d, but
install has no '-d' option for example on HP-UX.

Using mkdir -p instead seem to solve the problem.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I checked Linux and Solaris so far, both have mkdir -p -m. I'm not sure
about other platforms, hence the RFC prefix.

 templates/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index cc3fc30..5d35e51 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -4,7 +4,7 @@ ifndef V
 	QUIET = @
 endif
 
-INSTALL ?= install
+MKDIR ?= mkdir
 TAR ?= tar
 RM ?= rm -f
 prefix ?= $(HOME)
@@ -29,7 +29,7 @@ boilerplates.made : $(bpsrc)
 		case "$$boilerplate" in *~) continue ;; esac && \
 		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
 		dir=`expr "$$dst" : '\(.*\)/'` && \
-		$(INSTALL) -d -m 755 blt/$$dir && \
+		$(MKDIR) -p -m 755 blt/$$dir && \
 		case "$$boilerplate" in \
 		*--) ;; \
 		*) cp -p $$boilerplate blt/$$dst ;; \
@@ -46,6 +46,6 @@ clean:
 	$(RM) -r blt boilerplates.made
 
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
+	$(MKDIR) -p -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
-- 
1.6.0.rc3.17.gc14c8.dirty
