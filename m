From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [RFC PATCH 2/2] INSTALL: Describe a few knobs from the Makefile
Date: Tue,  8 Sep 2009 11:55:13 -0400
Message-ID: <1252425313-69793-2-git-send-email-brian@gernhardtsoftware.com>
References: <1252425313-69793-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 17:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml32Y-0007VI-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 17:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbZIHPzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 11:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbZIHPzX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 11:55:23 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51621 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZIHPzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 11:55:22 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id CD1541FFC087; Tue,  8 Sep 2009 15:55:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	by silverinsanity.com (Postfix) with ESMTPA id 1E6F11FFC080;
	Tue,  8 Sep 2009 15:55:13 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.2.420.g30ecf
In-Reply-To: <1252425313-69793-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128015>

We said that some of our dependencies were optional, but didn't say
how to turn them off.  Add information for that and mention where to
save the options close to the top of the file.

Also, reorder the list so the absolutely required ones are at the top.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 I don't know if anyone wants this level of detail in the INSTALL file, or
 if we'd prefer people actually RTFMakefile.  It didn't take long to write
 though, so I thought I'd throw it out and see if people liked it.

 INSTALL |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/INSTALL b/INSTALL
index 4a57e47..e08b990 100644
--- a/INSTALL
+++ b/INSTALL
@@ -13,6 +13,10 @@ that uses $prefix, the built results have some paths encoded,
 which are derived from $prefix, so "make all; make prefix=/usr
 install" would not work.
 
+There are many options that can be configured in the makefile using either
+command line defines or a config.mak file.  These options are documented at
+the beginning of the Makefile.
+
 Alternatively you can use autoconf generated ./configure script to
 set up install paths (via config.mak.autogen), so you can write instead
 
@@ -48,12 +52,19 @@ Issues of note:
 	export GIT_EXEC_PATH PATH GITPERLLIB
 
  - Git is reasonably self-sufficient, but does depend on a few external
-   programs and libraries:
+   programs and libraries.  Git can be used without most of them by adding
+   the approriate "NO_<LIBRARY>=YesPlease" to the make command line or
+   config.mak file.
 
 	- "zlib", the compression library. Git won't build without it.
 
-	- "openssl".  Unless you specify otherwise, you'll get the SHA1
-	  library from here.
+	- "ssh" is used to push and pull over the net
+
+	- A POSIX-compliant shell is needed to use most of the bare-bones
+	  Porcelainish scripts.
+
+	- "openssl".  Unless you specify otherwise (with NO_OPENSSL),
+	  you'll get the SHA1 library from here.
 
 	  If you don't have openssl, you can use one of the SHA1 libraries
 	  that come with git (git includes one based on Mozilla's as well
@@ -62,18 +73,20 @@ Issues of note:
 	- libcurl library; git-http-fetch and git-fetch use them.  You
 	  might also want the "curl" executable for debugging purposes.
 	  If you do not use http transfer, you are probably OK if you
-	  do not have them.
+	  do not have them (use NO_CURL).
 
 	- expat library; git-http-push uses it for remote lock
-	  management over DAV.  Similar to "curl" above, this is optional.
+	  management over DAV.  Similar to "curl" above, this is optional
+	  (with NO_EXPAT).
 
         - "wish", the Tcl/Tk windowing shell is used in gitk to show the
-          history graphically, and in git-gui.
-
-	- "ssh" is used to push and pull over the net
+          history graphically, and in git-gui.  If you don't want gitk or
+          git-gui, you can use NO_TCLTK.
 
-	- "perl" and POSIX-compliant shells are needed to use most of
-	  the bare-bones Porcelainish scripts.
+	- "perl" is used for several scripts that are useful, but not
+	  required for git (e.g. "git add -i" and "git difftool").  If you
+	  don't need the *.perl scripts or the library contained in perl/,
+	  then use NO_PERL.
 
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
-- 
1.6.4.2.420.g30ecf
