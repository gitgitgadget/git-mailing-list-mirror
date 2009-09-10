From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v3 3/3] INSTALL: Describe dependency knobs from Makefile
Date: Thu, 10 Sep 2009 10:12:08 -0400
Message-ID: <1252591928-2278-1-git-send-email-brian@gernhardtsoftware.com>
References: <7vpra0hcd3.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 16:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlkNn-0004Rg-PY
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 16:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbZIJOMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 10:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755685AbZIJOMM
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 10:12:12 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37550 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbZIJOMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 10:12:09 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 29F9B1FFC087; Thu, 10 Sep 2009 14:12:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	by silverinsanity.com (Postfix) with ESMTPA id B7CBE1FFC06B;
	Thu, 10 Sep 2009 14:12:05 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.2.420.g30ecf
In-Reply-To: <7vpra0hcd3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128113>

We said that some of our dependencies were optional, but didn't say
how to turn them off.  Add information for that and mention where to
save the options close to the top of the file.

Also, standardize on both using quotes for the names of the dependencies
and tabs for indentation of the list.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

  Junio C Hamano <gitster@pobox.com> wrote:
  > I did not like calling "make variables" "options", and also it was unclear
  > what good these "options" are for.  How about...

 Sounds good.  Would have sent this out yesterday, but I ran out of tuits.

 INSTALL |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/INSTALL b/INSTALL
index 7ab2580..69c97b2 100644
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
 
@@ -48,7 +52,9 @@ Issues of note:
 	export GIT_EXEC_PATH PATH GITPERLLIB
 
  - Git is reasonably self-sufficient, but does depend on a few external
-   programs and libraries:
+   programs and libraries.  Git can be used without most of them by adding
+   the approriate "NO_<LIBRARY>=YesPlease" to the make command line or
+   config.mak file.
 
 	- "zlib", the compression library. Git won't build without it.
 
@@ -59,25 +65,29 @@ Issues of note:
 
 	- "Perl" is needed to use some of the features (e.g. preparing a
 	  partial commit using "git add -i/-p", interacting with svn
-	  repositories with "git svn").
+	  repositories with "git svn").  If you can live without these, use
+	  NO_PERL.
 
-	- "openssl".  Unless you specify otherwise, you'll get the SHA1
-	  library from here.
+	- "openssl" library is used by git-imap-send to use IMAP over SSL.
+	  If you don't need it, use NO_OPENSSL.
 
-	  If you don't have openssl, you can use one of the SHA1 libraries
-	  that come with git (git includes one inspired by Mozilla's and a
-	  PowerPC optimized one too - see the Makefile).
+	  By default, git uses OpenSSL for SHA1 but it will use it's own
+	  library (inspired by Mozilla's) with either NO_OPENSSL or
+	  BLK_SHA1.  Also included is a version optimized for PowerPC
+	  (PPC_SHA1).
 
-	- libcurl library; git-http-fetch and git-fetch use them.  You
+	- "libcurl" library is used by git-http-fetch and git-fetch.  You
 	  might also want the "curl" executable for debugging purposes.
-	  If you do not use http transfer, you are probably OK if you
-	  do not have them.
+	  If you do not use http:// or https:// repositories, you do not
+	  have to have them (use NO_CURL).
 
-	- expat library; git-http-push uses it for remote lock
-	  management over DAV.  Similar to "curl" above, this is optional.
+	- "expat" library; git-http-push uses it for remote lock
+	  management over DAV.  Similar to "curl" above, this is optional
+	  (with NO_EXPAT).
 
-        - "wish", the Tcl/Tk windowing shell is used in gitk to show the
-          history graphically, and in git-gui.
+	- "wish", the Tcl/Tk windowing shell is used in gitk to show the
+	  history graphically, and in git-gui.  If you don't want gitk or
+	  git-gui, you can use NO_TCLTK.
 
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
-- 
1.6.4.2.420.g30ecf
