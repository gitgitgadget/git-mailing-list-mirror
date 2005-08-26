From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Enable git-send-email-script on Debian.
Date: Thu, 25 Aug 2005 18:29:43 -0700
Message-ID: <7vfysxmqns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 07:16:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8T2m-0005ah-Vy
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 03:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVHZB3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 21:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVHZB3q
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 21:29:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7307 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965036AbVHZB3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 21:29:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826012943.WDKF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 Aug 2005 21:29:43 -0400
To: Ryan Anderson <ryan@michonline.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7788>

You can define WITH_SEND_EMAIL to include the send-email command as
part of the installation.  Since Debian, unlike RPM/Fedora, has the
two necessary Perl modules available as part of the mainline
distribution, there is no reason for us to shy away from shipping
send-email.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 *** How do you like this one, Ryan?  Yes I know that we should
 *** not be using the same "0.99.5-" with different package
 *** version to ship changes in the upsteram file (Makefile)
 *** like this, but that aside...

 Makefile         |    5 ++++-
 debian/changelog |    7 +++++++
 debian/rules     |    3 +++
 3 files changed, 14 insertions(+), 1 deletions(-)

32fa6df832a1dc9ed0a1388dbe11a16b236683d5
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,6 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-request-pull-script git-bisect-script
 
 SCRIPTS += git-count-objects-script
-# SCRIPTS += git-send-email-script
 SCRIPTS += git-revert-script
 SCRIPTS += git-octopus-script
 
@@ -87,6 +86,10 @@ PROG=   git-update-cache git-diff-files 
 	git-show-index git-daemon git-var git-peek-remote git-show-branch \
 	git-update-server-info git-show-rev-cache git-build-rev-cache
 
+ifdef WITH_SEND_EMAIL
+SCRIPTS += git-send-email-script
+endif
+
 ifndef NO_CURL
 	PROG+= git-http-pull
 endif
diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,10 @@
+git-core (0.99.5-1) unstable; urgency=low
+
+  * Enable git-send-email-script on Debian.  There is no reason to shy
+    away from it, since we have the necessary Perl modules available.
+
+ -- Junio C Hamano <junkio@cox.net>  Thu, 25 Aug 2005 14:16:59 -0700
+
 git-core (0.99.5-0) unstable; urgency=low
 
   * GIT 0.99.5
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -25,6 +25,9 @@ else
 	export MOZILLA_SHA1=YesPlease
 endif
 
+# We do have the requisite perl modules in the mainline, and
+# have no reason to shy away from this script.
+export WITH_SEND_EMAIL=YesPlease
 
 PREFIX := /usr
 MANDIR := /usr/share/man/
