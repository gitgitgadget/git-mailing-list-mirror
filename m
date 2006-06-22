From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Implement Git::version()
Date: Fri, 23 Jun 2006 01:59:55 +0200
Message-ID: <20060622235955.560.46623.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 02:00:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtZ5d-0004sj-Se
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 02:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWFVX76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 19:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWFVX76
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 19:59:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35780 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750901AbWFVX76 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 19:59:58 -0400
Received: (qmail 570 invoked from network); 23 Jun 2006 01:59:55 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 23 Jun 2006 01:59:55 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22386>

Git::version() returns the Git version string.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile    |    5 ++++-
 perl/Git.pm |   12 ++++++++++++
 perl/Git.xs |    8 ++++++++
 3 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4d20b22..7842195 100644
--- a/Makefile
+++ b/Makefile
@@ -596,7 +596,10 @@ XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare
 
 
 perl/Makefile:	perl/Git.pm perl/Makefile.PL
-	(cd perl && $(PERL_PATH) Makefile.PL PREFIX="$(prefix)" DEFINE="$(ALL_CFLAGS)" LIBS="$(LIBS)")
+	(cd perl && $(PERL_PATH) Makefile.PL \
+		PREFIX="$(prefix)" \
+		DEFINE="$(ALL_CFLAGS) -DGIT_VERSION=\\\"$(GIT_VERSION)\\\"" \
+		LIBS="$(LIBS)")
 
 doc:
 	$(MAKE) -C Documentation all
diff --git a/perl/Git.pm b/perl/Git.pm
index 5b233ed..3f85000 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -285,6 +285,18 @@ sub command_noisy {
 }
 
 
+=item version ()
+
+Return the Git version in use.
+
+Implementation of this function is very fast; no external command calls
+are involved.
+
+=cut
+
+# Implemented in Git.xs.
+
+
 =item exec_path ()
 
 Return path to the git sub-command executables (the same as
diff --git a/perl/Git.xs b/perl/Git.xs
index 792dc6d..4d57685 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -22,6 +22,14 @@ # /* TODO: xs_call_gate(). See Git.pm. *
 
 
 const char *
+xs_version()
+CODE:
+	RETVAL = GIT_VERSION;
+OUTPUT:
+	RETVAL
+
+
+const char *
 xs_exec_path()
 CODE:
 	RETVAL = git_exec_path();
