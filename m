From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not try installing SVNimport on RPM
Date: Sun, 30 Oct 2005 15:39:46 -0800
Message-ID: <7vd5lmlgl9.fsf@assigned-by-dhcp.cox.net>
References: <43652934.8000308@zytor.com>
	<7v1x22odka.fsf@assigned-by-dhcp.cox.net>
	<7vll0amy1z.fsf_-_@assigned-by-dhcp.cox.net>
	<43654F4B.30103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:41:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWMmG-0002rU-3F
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 00:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVJ3Xjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 18:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVJ3Xjt
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 18:39:49 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21971 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751244AbVJ3Xjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 18:39:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030233910.ZSHC29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Oct 2005 18:39:10 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43654F4B.30103@zytor.com> (H. Peter Anvin's message of "Sun, 30
	Oct 2005 14:55:07 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10843>

This is based on Ryan's suggestion.  Running 'rpm --requires'
on the resulting RPM  seems to want these -- which I cannot
judge if this would be something that satisfies you.  I'd push
it out if it is OK with you.

Also I do not see "use v5.8.0" you mentioned in a separate
message anywhere in the tree, so I am hoping that should be OK.

junio@hera:~/git(0)$ R=~/rpms/RPMS/i386/git-core-0.99.9a-1.i386.rpm
junio@hera:~/git(0)$ rpm -q -i -p $R --requires | grep 'perl '
/usr/bin/perl
perl >= 0:5.006
perl >= 0:5.008
junio@hera:~/git(0)$ exit

 ------------
[PATCH] Work around an RPM build problem.

The require statement at the top of git-svnimport seems to confuse
rpmbuild dependency generation.  It uses the newer notation "v5.8.0",
and rpm ends up requiring "perl(v5.8.0)", while we would want it to
say something like "perl >= 0:5.008".

Ryan suggests old-style "require 5.008" might fix this problem, so
here it is.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-svnimport.perl |    2 +-
 Makefile           |    2 +-
 debian/changelog   |    6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

applies-to: 5d3fb770835ba710480cbaf0c1b076a3a4affc54
c846e15ee31b7226a715646f633fc1fdd2e14cd9
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 20a8572..45b6a19 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -10,7 +10,7 @@
 # The head revision is on branch "origin" by default.
 # You can change that with the '-o' option.
 
-require v5.8.0; # for shell-safe open("-|",LIST)
+require 5.008; # for shell-safe open("-|",LIST)
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/Makefile b/Makefile
index 1163dda..5bb5108 100644
--- a/Makefile
+++ b/Makefile
@@ -52,7 +52,7 @@
 
 # DEFINES += -DUSE_STDEV
 
-GIT_VERSION = 0.99.9.GIT
+GIT_VERSION = 0.99.9a
 
 CFLAGS = -g -O2 -Wall
 ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINES) $(DEFINES)
diff --git a/debian/changelog b/debian/changelog
index 5fd31b7..7d18483 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,9 @@
+git-core (0.99.9a-0) unstable; urgency=low
+
+  * GIT 0.99.9a
+
+ -- Junio C Hamano <junkio@cox.net>  Sun, 30 Oct 2005 15:03:32 -0800
+
 git-core (0.99.9-0) unstable; urgency=low
 
   * GIT 0.99.9
---
0.99.9.GIT
