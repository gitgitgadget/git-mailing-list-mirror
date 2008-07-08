From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t9100-git-svn-basic.sh: Fix determination of utf-8 locale
Date: Tue, 08 Jul 2008 23:59:25 +0100
Message-ID: <4873F14D.1080903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGdgC-0004eO-TH
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 19:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYGIRlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYGIRlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 13:41:09 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:62593 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934AbYGIRlG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2008 13:41:06 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.68)
	id 1KGdf7-00026n-Nw; Wed, 09 Jul 2008 17:41:06 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87900>


When setting the GIT_SVN_LC_ALL variable, default to the $LANG
environment variable, when the $LC_ALL override is not set.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

It took some time before I noticed this because the message
"UTF-8 locale not set, ..." did not stand-out when flying past on
the console. After noticing it, however, it surprised me (then
irritated me) because I most definitely did have a UTF-8 locale
set ...

The two hunks which s/echo/say/ are not strictly part of the fix
and should perhaps be in a separate patch ... Dunno. (but it
certainly makes the message stand out more ;-)


 t/t9100-git-svn-basic.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 242cdf0..3bc6164 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -4,9 +4,9 @@
 #
 
 test_description='git-svn basic tests'
-GIT_SVN_LC_ALL=$LC_ALL
+GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
-case "$LC_ALL" in
+case "$GIT_SVN_LC_ALL" in
 *.UTF-8)
 	have_utf8=t
 	;;
@@ -17,7 +17,7 @@ esac
 
 . ./lib-git-svn.sh
 
-echo 'define NO_SVN_TESTS to skip git-svn tests'
+say 'define NO_SVN_TESTS to skip git-svn tests'
 
 test_expect_success \
     'initialize git-svn' '
@@ -183,7 +183,7 @@ then
 		git-svn set-tree HEAD"
 	unset LC_ALL
 else
-	echo "UTF-8 locale not set, test skipped ($GIT_SVN_LC_ALL)"
+	say "UTF-8 locale not set, test skipped ($GIT_SVN_LC_ALL)"
 fi
 
 name='test fetch functionality (svn => git) with alternate GIT_SVN_ID'
-- 
1.5.6
