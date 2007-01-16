From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Set _ALL_SOURCE for AIX, but avoid its struct list.
Date: Mon, 15 Jan 2007 17:34:49 -0800
Message-ID: <17466.1168911289@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 16 03:08:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6dju-0008Lt-AT
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 03:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXAPCE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 21:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbXAPCE5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 21:04:57 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45210 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbXAPCEk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 21:04:40 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l0G1YnSH017476
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 17:34:49 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l0G1Yn3O017473
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 17:34:49 -0800 (PST)
To: git@vger.kernel.org
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36910>

AIX 5.3 seems to need _ALL_SOURCE for struct addrinfo, but that
introduces a struct list in grp.h.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
---
  Also, the AIX iconv is insufficent.  All tests pass if I build
  GNU libiconv, but using AIX's fails in many conversion tests.
  If you build with NO_ICONV, all the conversion tests fail as
  well.  I'm not sure if that should be changed, or if NO_ICONV
  should be removed...

 git-compat-util.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8781e8e..cbad411 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -15,6 +15,7 @@
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
+#define _ALL_SOURCE
 #define _GNU_SOURCE
 #define _BSD_SOURCE
 
@@ -45,7 +46,9 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
+#undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
+#define _ALL_SOURCE
 
 #ifndef NO_ICONV
 #include <iconv.h>
-- 
1.5.0.rc1.gf4b6c
