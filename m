From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Install git-send-email by default
Date: Sun, 14 May 2006 19:26:56 -0700
Message-ID: <11476600163338-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 15 04:27:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSnl-0001jI-WE
	for gcvg-git@gmane.org; Mon, 15 May 2006 04:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWEOC1A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 22:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWEOC1A
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 22:27:00 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39072 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750808AbWEOC1A (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 22:27:00 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D84917DC005;
	Sun, 14 May 2006 19:26:56 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 14 May 2006 19:26:56 -0700
To: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-Mailer: git-send-email 1.3.2.g97f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20008>

After 567ffeb7722eefab3991cb894c96548b92b57cc2 and
4bc87a28be020a6bf7387161c65ea3d8e4a0228b, git-send-email no
longer requires any non-standard Perl modules, so there's no
reason to special-case it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 Makefile    |    7 ++-----
 git.spec.in |    4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

df2d76fcee34efcf265b3a8a45940138e11a97c4
diff --git a/Makefile b/Makefile
index 8fd3e13..95d25f0 100644
--- a/Makefile
+++ b/Makefile
@@ -131,7 +131,8 @@ SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-shortlog.perl git-fmt-merge-msg.perl git-rerere.perl \
 	git-annotate.perl git-cvsserver.perl \
-	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl
+	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl \
+	git-send-email.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
@@ -320,10 +321,6 @@ else
 	endif
 endif
 
-ifdef WITH_SEND_EMAIL
-	SCRIPT_PERL += git-send-email.perl
-endif
-
 ifndef NO_CURL
 	ifdef CURLDIR
 		# This is still problematic -- gcc does not always want -R.
diff --git a/git.spec.in b/git.spec.in
index 96dfc1d..8ccd256 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -74,12 +74,12 @@ Git revision tree visualiser ('gitk')
 %setup -q
 
 %build
-make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease WITH_SEND_EMAIL=1 \
+make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
      prefix=%{_prefix} all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease WITH_SEND_EMAIL=1 \
+make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease \
      prefix=%{_prefix} mandir=%{_mandir} \
      install %{!?_without_docs: install-doc}
 
-- 
1.3.2.g1c9b
